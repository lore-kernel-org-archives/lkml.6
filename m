Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757332AbeEJM1d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:27:33 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:41571 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757317AbeEJM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:27:31 -0400
From: Dan Murphy <dmurphy@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <afd@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 1/2] dt: bindings: lm3601x: Introduce the lm3601x driver
Date: Thu, 10 May 2018 07:27:17 -0500
Message-ID: <20180510122718.8413-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the device tree bindings for the lm3601x
family of LED torch, flash and IR drivers.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v4 - Added " " around "=", changed strobe to flash on label, removed "support and
register" comment and change ir lable to ir:torch - See v2 patchworks for comments

v3 - Removed wildcard compatible - https://patchwork.kernel.org/patch/10386241/
v2 - No changes - https://patchwork.kernel.org/patch/10384587/

 .../devicetree/bindings/leds/leds-lm3601x.txt | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3601x.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
new file mode 100644
index 000000000000..697e5e3a1d4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
@@ -0,0 +1,50 @@
+* Texas Instruments - lm3601x Single-LED Flash Driver
+
+The LM3601X are ultra-small LED flash drivers that
+provide a high level of adjustability.
+
+Required properties:
+	- compatible : Can be one of the following
+		"ti,lm36010"
+		"ti,lm36011"
+	- reg : I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+
+Required child properties:
+	- reg : 0 - Indicates a torch interface
+		1 - Indicates a flash interface
+		2 - Indicates an infrared interface
+
+Optional child properties:
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+led-controller@64 {
+	compatible = "ti,lm36010";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x64>;
+
+	led@0 {
+		reg = <0>;
+		label = "white:torch";
+		led-max-microamp = <10000>;
+	};
+
+	led@1 {
+		reg = <1>;
+		label = "white:flash";
+		flash-max-microamp = <10000>;
+		flash-max-timeout-us = <800>;
+	};
+
+	led@2 {
+		reg = <2>;
+		label = "ir:torch";
+	};
+}
+
+For more product information please see the links below:
+http://www.ti.com/product/LM36010
+http://www.ti.com/product/LM36011
-- 
2.17.0.582.gccdcbd54c
