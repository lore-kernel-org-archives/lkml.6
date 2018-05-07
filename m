Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeEGMb0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:31:26 -0400
Received: from hermes.aosc.io ([199.195.250.187]:43657 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752367AbeEGMbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:31:22 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Ondrej Jirman <megous@megous.com>, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 1/3] dt-bindings: add binding for the SY8106A voltage regulator
Date: Mon,  7 May 2018 20:29:40 +0800
Message-Id: <20180507122942.25758-2-icenowy@aosc.io>
In-Reply-To: <20180507122942.25758-1-icenowy@aosc.io>
References: <20180507122942.25758-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

SY8106A is an I2C-controlled adjustable voltage regulator made by
Silergy Corp.

Add its device tree binding.

Signed-off-by: Ondrej Jirman <megous@megous.com>
[Icenowy: Change commit message and slight fixes]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
---
No changes in v4.

Changes in v3:
- Added silergy,fixed-microvolt property.

Changes in v2:
- Added Chen-Yu's Reviewed tag and Rob's ACK tag.
- Specify regulator.txt's directory.

 .../bindings/regulator/sy8106a-regulator.txt  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt b/Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
new file mode 100644
index 000000000000..39a8ca73f572
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
@@ -0,0 +1,23 @@
+SY8106A Voltage regulator
+
+Required properties:
+- compatible: Must be "silergy,sy8106a"
+- reg: I2C slave address - must be <0x65>
+- silergy,fixed-microvolt - the voltage when I2C regulating is disabled (set
+  by external resistor like a fixed voltage)
+
+Any property defined as part of the core regulator binding, defined in
+./regulator.txt, can also be used.
+
+Example:
+
+	sy8106a {
+		compatible = "silergy,sy8106a";
+		reg = <0x65>;
+		regulator-name = "sy8106a-vdd";
+		silergy,fixed-microvolt = <1200000>;
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
-- 
2.17.0
