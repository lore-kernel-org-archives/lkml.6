Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AE9C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339ED2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GqAJzLt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339ED2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbeJLAUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:20:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48458 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbeJLATl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:19:41 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9BGpVHI031427;
        Thu, 11 Oct 2018 11:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539276691;
        bh=Di5TTVK8nMsFF6vs8+PC410nXwy/9n2E3w86bq7ehcw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GqAJzLt5enXvn9zWp1quQwTGd5Cjn5kWwrMtiMA8gg9NAabaBmwFL4iwCd1mTn+/3
         oZikwoxYj9LUrzLgTtMMlYo1I2JROaBU6OH4HiU1cOMc3NnOA0gCdKgZ++F+rDlqj3
         7iO83RvwLXDzQ2qj74H1lTRQHGA6o/8fvU2VzlUU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BGpV7o026853;
        Thu, 11 Oct 2018 11:51:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 11
 Oct 2018 11:51:31 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 11 Oct 2018 11:51:31 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BGpUAr027742;
        Thu, 11 Oct 2018 11:51:30 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.172.124])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w9BGpUx20823;
        Thu, 11 Oct 2018 11:51:30 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <lee.jones@linaro.org>, <tony@atomide.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 8/9] dt-bindings: leds: Add support for the LM3633
Date:   Thu, 11 Oct 2018 11:51:22 -0500
Message-ID: <20181011165123.32198-9-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20181011165123.32198-1-dmurphy@ti.com>
References: <20181011165123.32198-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the TI LM3633 LED driver.
This device has 9 control banks 3 high voltage
LED channels and 6 low voltage LED channels.

Data sheet:
http://www.ti.com/lit/ds/symlink/lm3633.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/leds/leds-lm3633.txt  | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
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
-- 
2.19.0

