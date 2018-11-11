Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D28C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FFD214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FFD214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeKLFUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:20:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51065 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbeKLFUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:20:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CCBEB224CD; Sun, 11 Nov 2018 20:31:15 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9EEFE206A7;
        Sun, 11 Nov 2018 20:31:15 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] dt-bindings: rtc: Move trivial RTCs to rtc.txt
Date:   Sun, 11 Nov 2018 20:31:14 +0100
Message-Id: <20181111193114.24307-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111193114.24307-1-alexandre.belloni@bootlin.com>
References: <20181111193114.24307-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move trivial RTCs to the rtc generic binding documentation as they all also
support at least 'start-year'.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/rtc/rtc.txt | 34 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.txt   | 24 -------------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
index 221b7da50aca..7c8da6926095 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -28,3 +28,37 @@ below.
                           disabled
 - wakeup-source :         Enables wake up of host system on alarm
 
+Trivial RTCs
+------------
+
+This is a list of trivial RTC devices that have simple device tree
+bindings, consisting only of a compatible field, an address and
+possibly an interrupt line.
+
+
+Compatible		Vendor / Chip
+==========		=============
+abracon,abb5zes3	AB-RTCMC-32.768kHz-B5ZE-S3: Real Time Clock/Calendar Module with I2C Interface
+dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
+dallas,ds1672		Dallas DS1672 Real-time Clock
+dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
+epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
+epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
+emmicro,em3027		EM Microelectronic EM3027 Real-time Clock
+isil,isl1208		Intersil ISL1208 Low Power RTC with Battery Backed SRAM
+isil,isl1218		Intersil ISL1218 Low Power RTC with Battery Backed SRAM
+isil,isl12022		Intersil ISL12022 Real-time Clock
+microcrystal,rv3029	Real Time Clock Module with I2C-Bus
+nxp,pcf2127		Real-time clock
+nxp,pcf2129		Real-time clock
+nxp,pcf8523		Real-time Clock
+nxp,pcf8563		Real-time clock/calendar
+nxp,pcf85063		Tiny Real-Time Clock
+pericom,pt7c4338	Real-time Clock Module
+ricoh,r2025sd		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+ricoh,r2221tl		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+ricoh,rs5c372a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+ricoh,rs5c372b		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+ricoh,rv5c386		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+ricoh,rv5c387a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
+sii,s35390a		2-wire CMOS real-time clock
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 6ab001fa1ed4..fda7a0f50c1e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -9,7 +9,6 @@ document for it just like any other devices.
 
 Compatible		Vendor / Chip
 ==========		=============
-abracon,abb5zes3		AB-RTCMC-32.768kHz-B5ZE-S3: Real Time Clock/Calendar Module with I2C Interface
 ad,ad7414		SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
 ad,adm9240		ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
 adi,adt7461		+/-1C TDM Extended Temp Range I.C
@@ -25,12 +24,9 @@ at,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
 capella,cm3232		CM3232: Ambient Light Sensor
-dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
 dallas,ds1631		High-Precision Digital Thermometer
-dallas,ds1672		Dallas DS1672 Real-time Clock
 dallas,ds1682		Total-Elapsed-Time Recorder with Alarm
 dallas,ds1775		Tiny Digital Thermometer and Thermostat
-dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
 dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
 dallas,ds75		Digital Thermometer and Thermostat
 devantech,srf02		Devantech SRF02 ultrasonic ranger in I2C mode
@@ -40,9 +36,6 @@ dlg,da9053		DA9053: flexible system level PMIC with multicore support
 dlg,da9063		DA9063: system PMIC for quad-core application processors
 domintech,dmard09	DMARD09: 3-axis Accelerometer
 domintech,dmard10	DMARD10: 3-axis Accelerometer
-epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
-epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
-emmicro,em3027		EM Microelectronic EM3027 Real-time Clock
 fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
 fsl,mma7660		MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
 fsl,mma8450		MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
@@ -53,9 +46,6 @@ gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire In
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
 infineon,tlv493d-a1b6	Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
-isil,isl1208		Intersil ISL1208 Low Power RTC with Battery Backed SRAM
-isil,isl1218		Intersil ISL1218 Low Power RTC with Battery Backed SRAM
-isil,isl12022		Intersil ISL12022 Real-time Clock
 isil,isl29028		Intersil ISL29028 Ambient Light and Proximity Sensor
 isil,isl29030		Intersil ISL29030 Ambient Light and Proximity Sensor
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
@@ -142,7 +132,6 @@ microchip,mcp4662-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Mem
 microchip,mcp4662-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
 microchip,tc654		PWM Fan Speed Controller With Fan Fault Detection
 microchip,tc655		PWM Fan Speed Controller With Fan Fault Detection
-microcrystal,rv3029	Real Time Clock Module with I2C-Bus
 miramems,da226		MiraMEMS DA226 2-axis 14-bit digital accelerometer
 miramems,da280		MiraMEMS DA280 3-axis 14-bit digital accelerometer
 miramems,da311		MiraMEMS DA311 3-axis 12-bit digital accelerometer
@@ -156,25 +145,12 @@ nuvoton,npct601		i2c trusted platform module (TPM2)
 nuvoton,w83773g		Nuvoton Temperature Sensor
 nxp,pca9556		Octal SMBus and I2C registered interface
 nxp,pca9557		8-bit I2C-bus and SMBus I/O port with reset
-nxp,pcf2127		Real-time clock
-nxp,pcf2129		Real-time clock
-nxp,pcf8523		Real-time Clock
-nxp,pcf8563		Real-time clock/calendar
-nxp,pcf85063		Tiny Real-Time Clock
 oki,ml86v7667		OKI ML86V7667 video decoder
 ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
-pericom,pt7c4338	Real-time Clock Module
 plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
 pulsedlight,lidar-lite-v2	Pulsedlight LIDAR range-finding sensor
-ricoh,r2025sd		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-ricoh,r2221tl		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-ricoh,rs5c372a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-ricoh,rs5c372b		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-ricoh,rv5c386		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-ricoh,rv5c387a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 samsung,24ad0xd1	S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
 sgx,vz89x		SGX Sensortech VZ89X Sensors
-sii,s35390a		2-wire CMOS real-time clock
 silabs,si7020		Relative Humidity and Temperature Sensors
 skyworks,sky81452	Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
 st,24c256		i2c serial eeprom  (24cxx)
-- 
2.19.1

