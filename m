Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeEVOY3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:24:29 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:33535 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeEVOY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:24:27 -0400
From: Dan Murphy <dmurphy@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jacek.anaszewski@gmail.com>, <andy.shevchenko@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v8 1/2] dt: bindings: lm3601x: Introduce the lm3601x driver
Date: Tue, 22 May 2018 09:24:16 -0500
Message-ID: <20180522142417.19639-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the device tree bindings for the lm3601x
family of LED torch, flash and IR drivers.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v8 - No changes - https://patchwork.kernel.org/patch/10416161/

v7 - Removed led-sources in favor of reg, fixed malformatted ranges - https://patchwork.kernel.org/patch/10401435/
v6 - Removed multiple led child nodes, fixed example to display micro ranges
for corresponding child nodes and added led-sources to define the current driver -
https://patchwork.kernel.org/patch/10392121/
v5 - No changes - https://patchwork.kernel.org/patch/10391743/
v4 - Added " " around "=", changed strobe to flash on label, removed "support and
register" comment and change ir lable to ir:torch - See v2 patchworks for comments
v3 - Removed wildcard compatible - https://patchwork.kernel.org/patch/10386241/
v2 - No changes - https://patchwork.kernel.org/patch/10384587/

 .../devicetree/bindings/leds/leds-lm3601x.txt | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3601x.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
new file mode 100644
index 000000000000..a88b2c41e75b
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
@@ -0,0 +1,45 @@
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
+	- reg : 0 - Indicates a IR mode
+		1 - Indicates a Torch (white LED) mode
+
+Required properties for flash LED child nodes:
+	See Documentation/devicetree/bindings/leds/common.txt
+	- flash-max-microamp : Range from 11mA - 1.5A
+	- flash-max-timeout-us : Range from 40ms - 1600ms
+	- led-max-microamp : Range from 2.4mA - 376mA
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
+		reg = <1>;
+		label = "white:torch";
+		led-max-microamp = <376000>;
+		flash-max-microamp = <1500000>;
+		flash-max-timeout-us = <1600000>;
+	};
+}
+
+For more product information please see the links below:
+http://www.ti.com/product/LM36010
+http://www.ti.com/product/LM36011
-- 
2.17.0.582.gccdcbd54c
