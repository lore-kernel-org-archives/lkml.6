Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4F6C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AC320685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SFUuihIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AC320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeI2AzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:55:07 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39308 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeI2AzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:55:07 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8SIU2f1105751;
        Fri, 28 Sep 2018 13:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538159402;
        bh=pSmD2M/O+yZuviPXrMoZZB16/Jfgp2hSP7dtvrq1WXQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SFUuihIZy3+TXii2DRD7hJbyo5zIjezgZW4d3E78azALhF58ubeLz90JUPqA61kqr
         SY5RIDndnl/u01mpxLjTjgEMlTqVT+eJYRRvSTWAXmUZcF/zyuScd3AUnB2zM4DLNU
         F+/PL7Fw7THOADK8+iMxQYcwS+PMmSEqh+KWR3g4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SIU10J017185;
        Fri, 28 Sep 2018 13:30:02 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 13:30:00 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 13:30:00 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SIU04x015017;
        Fri, 28 Sep 2018 13:30:00 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.149.181])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8SIU0x27710;
        Fri, 28 Sep 2018 13:30:00 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH v2 4/9] dt-bindings: leds: Add bindings for lm3697 driver
Date:   Fri, 28 Sep 2018 13:29:49 -0500
Message-ID: <20180928182954.25446-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180928182954.25446-1-dmurphy@ti.com>
References: <20180928182954.25446-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree bindings for the lm3697
LED driver for backlighting and display.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/leds/leds-lm3697.txt  | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
new file mode 100644
index 000000000000..4bb2ed51025b
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
@@ -0,0 +1,98 @@
+* Texas Instruments - LM3697 Highly Efficient White LED Driver
+
+The LM3697 11-bit LED driver provides high-
+performance backlight dimming for 1, 2, or 3 series
+LED strings while delivering up to 90% efficiency.
+
+This device is suitable for display and keypad Lighting
+
+Required properties:
+	- compatible:
+		"ti,lm3697"
+	- reg :  I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+
+Optional properties:
+	- enable-gpios : GPIO pin to enable/disable the device
+	- vled-supply : LED supply
+
+Required child properties:
+	- reg : 0 - LED is Controlled by bank A
+		1 - LED is Controlled by bank B
+	- led-sources : Indicates which HVLED string is associated to which
+			control bank.  Each element in the array is associated
+			with a specific HVLED string.  Element 0 is HVLED1,
+			element 1 is HVLED2 and element 2 HVLED3.
+			Additional information is contained
+			in Documentation/devicetree/bindings/leds/common.txt
+			0 - HVLED is not active in this control bank
+			1 - HVLED string is controlled by this control bank
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
+
+HVLED string 1 and 3 are controlled by control bank A and HVLED 2 string is
+controlled by control bank B.
+
+led-controller@36 {
+	compatible = "ti,lm3697";
+	reg = <0x36>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	vled-supply = <&vbatt>;
+
+	led@0 {
+		reg = <0>;
+		led-sources = <1 0 1>;
+		runtime-ramp-up-msec = <5000>;
+		runtime-ramp-down-msec = <1000>;
+		label = "white:first_backlight_cluster";
+		linux,default-trigger = "backlight";
+	};
+
+	led@1 {
+		reg = <1>;
+		led-sources = <0 1 0>;
+		runtime-ramp-up-msec = <500>;
+		runtime-ramp-down-msec = <1000>;
+		label = "white:second_backlight_cluster";
+		linux,default-trigger = "backlight";
+	};
+}
+
+All HVLED strings controlled by control bank A
+
+led-controller@36 {
+	compatible = "ti,lm3697";
+	reg = <0x36>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	vled-supply = <&vbatt>;
+
+	led@0 {
+		reg = <0>;
+		led-sources = <1 1 1>;
+		runtime-ramp-up-msec = <500>;
+		runtime-ramp-down-msec = <1000>;
+		label = "white:backlight_cluster";
+		linux,default-trigger = "backlight";
+	};
+}
+
+For more product information please see the link below:
+http://www.ti.com/lit/ds/symlink/lm3697.pdf
-- 
2.19.0

