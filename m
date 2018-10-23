Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB415C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C29220671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C29220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeJXBbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:31:08 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48048 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbeJXBa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:30:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NH6YJ3100396;
        Tue, 23 Oct 2018 12:06:34 -0500
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9NH6Yvi047566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 12:06:34 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 12:06:34 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 12:06:34 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NH6Yxj011935;
        Tue, 23 Oct 2018 12:06:34 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.171.190])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w9NH6Xx15364;
        Tue, 23 Oct 2018 12:06:34 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <lee.jones@linaro.org>,
        <tony@atomide.com>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 5/7] dt-bindings: ti-lmu: Modify dt bindings for the LM3633
Date:   Tue, 23 Oct 2018 12:06:21 -0500
Message-ID: <20181023170623.31820-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20181023170623.31820-1-dmurphy@ti.com>
References: <20181023170623.31820-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LM3633 is a single function LED driver. The single function LED
driver needs to reside in the LED directory as a dedicated LED driver
and not as a MFD device.  The device does have common brightness and ramp
features and those can be accomodated by a TI LMU framework.

The LM3633 dt binding needs to be moved from the ti-lmu.txt and a dedicated
LED dt binding needs to be added.  The new LM3633 LED dt binding will then
reside in the Documentation/devicetree/bindings/leds directory and follow the
current LED and general bindings guidelines.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v4 - Squashed removal and addition of the dt bindings into a single patch - https://lore.kernel.org/patchwork/patch/998703/

 .../devicetree/bindings/leds/leds-lm3633.txt  | 102 ++++++++++++++++++
 .../devicetree/bindings/mfd/ti-lmu.txt        |  48 ---------
 2 files changed, 102 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3633.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3633.txt b/Documentation/devicetree/bindings/leds/leds-lm3633.txt
new file mode 100644
index 000000000000..d791b891ea6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3633.txt
@@ -0,0 +1,102 @@
+* Texas Instruments - LM3633 Lighting Power Solution for Smartphone Handsets
+
+The LM3633 is a complete power source for
+backlight, keypad, and indicator LEDs in smartphone
+handsets.
+
+This device is suitable for display and keypad Lighting
+
+Required properties:
+	- compatible:
+		"ti,lm3633"
+	- reg :  I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+
+Optional properties:
+	- enable-gpios : GPIO pin to enable/disable the device
+	- vled-supply : LED supply
+
+Required child properties:
+	- reg : 0 - HVLED is Controlled by bank A
+		1 - HVLED is Controlled by bank B
+		2,3,4 - LVLED1, 2 and 3 are Controlled by bank C, D and E
+		5,6,7 - LVLED4, 5 and 6 are Controlled by bank F, G and H
+	- led-sources : Indicates which LED string is associated to which
+			control bank.
+			0 - LED is not active in this control bank
+			1 - LED string is controlled by this control bank
+
+Optional child properties:
+	- runtime-ramp-up-msec: Current ramping from one brightness level to
+				the a higher brightness level.
+				Range from 2048 us - 117.44 s
+	- runtime-ramp-down-msec: Current ramping from one brightness level to
+				  the a lower brightness level.
+				  Range from 2048 us - 117.44 s
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+Control bank C output to 3 LVLEDs and Control F, G and H have independent
+controls of the LVLEDs.
+
+led-controller@36 {
+	compatible = "ti,lm3633";
+	reg = <0x36>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	led@0 {
+		reg = <0>;
+		led-sources = < 1 0 1 >;
+		label = "white:backlight";
+		ramp-up-ms = <100000>;
+		ramp-down-ms = <1000>;
+		linux,default-trigger = "backlight";
+	};
+
+	led@1 {
+		reg = <1>;
+		led-sources = < 0 1 0 >;
+		label = "white:light";
+		ramp-up-ms = <100000>;
+		ramp-down-ms = <1000>;
+	};
+
+	led@2 {
+		reg = <2>;
+		led-sources = <1>;
+		ramp-up-ms = <100000>;
+		ramp-down-ms = <1000>;
+		label = "white:indicator1";
+	};
+
+	led@5 {
+		reg = <5>;
+		led-sources = <1>;
+		ramp-up-ms = <100000>;
+		ramp-down-ms = <1000>;
+		label = "red:light";
+	};
+
+	led@6 {
+		reg = <6>;
+		led-sources = <1>;
+		ramp-up-ms = <41940>;
+		ramp-down-ms = <1000>;
+		label = "green:light";
+	};
+
+	led@7 {
+		reg = <7>;
+		led-sources = <1>;
+		ramp-up-ms = <100000>;
+		ramp-down-ms = <1000>;
+		label = "blue:light";
+	};
+};
+For more product information please see the link below:
+http://www.ti.com/lit/ds/symlink/lm3633.pdf
diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
index 920f910be4e9..573e88578d3d 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -7,7 +7,6 @@ TI LMU driver supports lighting devices below.
   LM3532       Backlight
   LM3631       Backlight and regulator
   LM3632       Backlight and regulator
-  LM3633       Backlight, LED and fault monitor
   LM3695       Backlight
 
 Required properties:
@@ -15,12 +14,10 @@ Required properties:
                 "ti,lm3532"
                 "ti,lm3631"
                 "ti,lm3632"
-                "ti,lm3633"
                 "ti,lm3695"
   - reg: I2C slave address.
          0x11 for LM3632
          0x29 for LM3631
-         0x36 for LM3633
          0x38 for LM3532
          0x63 for LM3695
 
@@ -157,51 +154,6 @@ lm3632@11 {
 	};
 };
 
-lm3633@36 {
-	compatible = "ti,lm3633";
-	reg = <0x36>;
-
-	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
-
-	backlight {
-		compatible = "ti,lm3633-backlight";
-
-		main {
-			label = "main_lcd";
-			led-sources = <1 2>;
-			ramp-up-msec = <500>;
-			ramp-down-msec = <500>;
-		};
-
-		front {
-			label = "front_lcd";
-			led-sources = <0>;
-			ramp-up-msec = <1000>;
-			ramp-down-msec = <0>;
-		};
-	};
-
-	leds {
-		compatible = "ti,lm3633-leds";
-
-		chan1 {
-			label = "status";
-			led-sources = <1>;
-			led-max-microamp = <6000>;
-		};
-
-		chan345 {
-			label = "rgb";
-			led-sources = <3 4 5>;
-			led-max-microamp = <10000>;
-		};
-	};
-
-	fault-monitor {
-		compatible = "ti,lm3633-fault-monitor";
-	};
-};
-
 lm3695@63 {
 	compatible = "ti,lm3695";
 	reg = <0x63>;
-- 
2.19.0

