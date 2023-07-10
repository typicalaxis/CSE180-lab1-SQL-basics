DROP SCHEMA Lab1 CASCADE;
CREATE SCHEMA Lab1;

CREATE TABLE Highways ( 
    highwayNum INT PRIMARY KEY, 
    length Numeric(4,1), 
    speedLimit INT
);
CREATE TABLE Exits(
    highwayNum int References Highways(highwayNum), 
    exitNum int, 
    description VARCHAR(60), 
    mileMarker Numeric(4,1), 
    exitCity VARCHAR(20), 
    exitState CHAR(2), 
    isExitOpen boolean,
    CONSTRAINT PK_Exits PRIMARY KEY (highwayNum,exitNum)
);
CREATE TABLE Interchanges(
    highwayNum1 int, 
    exitNum1 int, 
    highwayNum2 int, 
    exitNum2 int,
    CONSTRAINT PK_Interchanges PRIMARY KEY (highwayNum1,exitNum1,highwayNum2,exitNum2),
    CONSTRAINT FK_Exit1 foreign key (highwayNum1,exitNum1) references Exits(highwayNum,exitNum),
    CONSTRAINT FK_Exit2 foreign key (highwayNum2,exitNum2) references Exits(highwayNum,exitNum)
);
CREATE TABLE Cameras(
    cameraID int PRIMARY KEY, 
    highwayNum int References Highways(highwayNum), 
    mileMarker Numeric(4,1), 
    isCameraWorking boolean
);
CREATE TABLE Owners(
    ownerState CHAR(2), 
    ownerLicenseID CHAR(8), 
    name VARCHAR(60), 
    address VARCHAR(60), 
    startDate date, 
    expirationDate date,
    CONSTRAINT PK_Owners PRIMARY KEY (ownerState,ownerLicenseID)
);
CREATE TABLE Vehicles(
    vehicleState CHAR(2), 
    vehicleLicensePlate CHAR(7), 
    ownerState CHAR(2), 
    ownerLicenseID CHAR(8), 
    year int, 
    color CHAR(2),
    CONSTRAINT PK_Vehicles PRIMARY KEY (vehicleState,vehicleLicensePlate),
    CONSTRAINT FK_OwnerVehicles foreign key (ownerState,ownerLicenseID) references Owners(ownerState,ownerLicenseID)
);
CREATE TABLE Photos(
    cameraID int References Cameras(cameraID), 
    vehicleState CHAR(2), 
    vehicleLicensePlate CHAR(7), 
    photoTimestamp timestamp,
    CONSTRAINT PK_Photos PRIMARY KEY (cameraID,photoTimestamp),
    CONSTRAINT FK_VehiclesPhotos foreign key (vehicleState,vehicleLicensePlate) references Vehicles(vehicleState,vehicleLicensePlate)
);
