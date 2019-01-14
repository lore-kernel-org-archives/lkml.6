Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6ECC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20332064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ekbE0mYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfANVRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:17:46 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52260 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfANVRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:17:46 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0ELHe41041900;
        Mon, 14 Jan 2019 15:17:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547500660;
        bh=lbuDqpW4Kmj6H2xYlb6NNkVPhAN97yT6G0r3Fyg4mJQ=;
        h=From:To:CC:Subject:Date;
        b=ekbE0mYXSilExGFT3Fn0I0F/2Zdy2bleXo1xK0/vJxwXyOwLmi6fJI+fEnhdh5F8D
         C1uovygIBYqvmfQVsMKDAaAhpNaNXTsK6bUTPie3oCruO0Agj3puyNn3yBkKZCDFuz
         r/vCFDaWu1MslRgKbUPOcICm0cbOfa0POWHyCHZA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0ELHeQ2115484
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 15:17:40 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 15:17:40 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 15:17:40 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0ELHebD029556;
        Mon, 14 Jan 2019 15:17:40 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.100.22])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0ELHdU00270;
        Mon, 14 Jan 2019 15:17:39 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-leds@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jacek.anaszewski@gmail.com>,
        <pavel@ucw.cz>, <devicetree@vger.kernel.org>, <dachaac@gmail.com>,
        <robh+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 1/2] dt: bindings: lp50xx: Introduce the lp50xx family of RGB drivers
Date:   Mon, 14 Jan 2019 15:17:22 -0600
Message-ID: <20190114211723.11186-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the bindings for the Texas Instruments LP5036, LP5030, LP5024 and the LP5018
RGB LED device driver.  The LP5036/3024/18 can control RGB LEDs individually
or as part of a control bank group.  These devices have the ability
to adjust the mixing control for the RGB LEDs to obtain different colors
independent of the overall brightness of the LED grouping.

Datasheet:
http://www.ti.com/lit/ds/symlink/lp5024.pdf
http://www.ti.com/lit/ds/symlink/lp5036.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Added the LP5030/36 devices, defined the modules vs banked properties
renamed the file from lp5024 to lp50xx. - https://lore.kernel.org/patchwork/patch/1026514/

 .../devicetree/bindings/leds/leds-lp50xx.txt  | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lp50xx.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.txt b/Documentation/devicetree/bindings/leds/leds-lp50xx.txt
new file mode 100644
index 000000000000..7bc6843ddba4
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.txt
@@ -0,0 +1,143 @@
+* Texas Instruments - LP5018/24/30/36 RGB LED driver
+
+The LP50XX is multi-channel, I2C RGB LED Drivers that can group RGB LEDs into
+a LED group or control them individually.
+
+The difference in these RGB LED drivers is the number of supported RGB strings.
+
+Required properties:
+	- compatible:
+		"ti,lp5018"
+		"ti,lp5024"
+		"ti,lp5030"
+		"ti,lp5036"
+	- reg :  I2C slave address
+		lp5018/24 - 0x28
+		lp5030/36 - 0x30
+	- #address-cells : 1
+	- #size-cells : 0
+
+Optional properties:
+	- enable-gpios : gpio pin to enable/disable the device.
+	- vled-supply : LED supply
+
+Required child properties:
+	- reg : Is the child node iteration.
+
+Required Child properties but only one should be defined per child:
+Either one of these two properties are required for each node.  The 
+property ti,led-bank takes precedence over the ti,led-module within the same
+node.
+
+	- ti,led-module : This property denotes the single LED module number
+			  that will be controlled in the LED class instance.
+	- ti,led-bank : This property denotes the LED module numbers that will
+			be controlled as a single RGB cluster.  Each LED module
+			number will be controlled by a single LED class instance.
+			There can only be one instance of the ti,led-bank
+			property for each device node.
+
+The LED outpus associated with the LED modules are defined in Table 1 of the
+corresponding data sheets.
+
+LP5018 - 6 Total RGB cluster LED outputs 0-5
+LP5024 - 8 Total RGB cluster LED outputs 0-7
+LP5030 - 10 Total RGB cluster LED outputs 0-9
+LP5036 - 12 Total RGB cluster LED outputs 0-11
+
+Optional child properties:
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+
+Examples:
+LP5018 and LP5024 example:
+led-controller@29 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "ti,lp5024";
+	reg = <0x29>;
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	vled-supply = <&vmmcsd_fixed>;
+
+	led@0 {
+	        reg = <0>;
+	        label = "led1_mod";
+		ti,led-module = <1>;
+	};
+
+	led@1 {
+	        reg = <1>;
+	        label = "banked_leds";
+		ti,led-bank = <0 2 5 3 >;
+	};
+
+	led@2 {
+	        reg = <2>;
+	        label = "led4_mod";
+		ti,led-module = <4>;
+	};
+
+	led@3 {
+	        reg = <3>;
+	        label = "led7_mod";
+		ti,led-module = <7>;
+	};
+
+	led@4 {
+	        reg = <4>;
+	        label = "led6_mod";
+		ti,led-module = <6>;
+	};
+};
+
+LP5030 and LP5036 example:
+led-controller@30 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "ti,lp5036";
+	reg = <0x30>;
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	vled-supply = <&vmmcsd_fixed>;
+
+	led@0 {
+	        reg = <0>;
+	        label = "led1_mod";
+		ti,led-module = <1>;
+	};
+
+	led@1 {
+	        reg = <1>;
+	        label = "led_banked";
+		ti,led-bank = <0 2 5 3 9 10 >;
+	};
+
+	led@2 {
+	        reg = <2>;
+	        label = "led4_mod";
+		ti,led-module = <4>;
+	};
+
+	led@3 {
+	        reg = <3>;
+	        label = "led7_mod";
+		ti,led-module = <7>;
+	};
+
+	led@4 {
+	        reg = <4>;
+	        label = "led6_mod";
+		ti,led-module = <6>;
+	};
+
+	led@5 {
+	        reg = <5>;
+	        label = "led8_mod";
+		ti,led-module = <8>;
+	};
+};
+
+
+For more product information please see the link below:
+http://www.ti.com/lit/ds/symlink/lp5024.pdf
+http://www.ti.com/lit/ds/symlink/lp5036.pdf
-- 
2.20.1.98.gecbdaf0899

