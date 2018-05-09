Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934383AbeEIJsk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:48:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42748 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934272AbeEIJs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:48:28 -0400
From: Mark Brown <broonie@kernel.org>
To: Ondrej Jirman <megous@megous.com>
Cc: Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: add binding for the SY8106A voltage regulator" to the regulator tree
In-Reply-To: <20180423144657.63264-2-icenowy@aosc.io>
Message-Id: <20180509094818.5593844007A@finisterre.ee.mobilebroadband>
Date: Wed,  9 May 2018 10:48:18 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: add binding for the SY8106A voltage regulator

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 32aba834f2a9fe126ff5e624371113ac1defa06e Mon Sep 17 00:00:00 2001
From: Ondrej Jirman <megous@megous.com>
Date: Mon, 7 May 2018 20:29:40 +0800
Subject: [PATCH] regulator: add binding for the SY8106A voltage regulator

SY8106A is an I2C-controlled adjustable voltage regulator made by
Silergy Corp.

Add its device tree binding.

Signed-off-by: Ondrej Jirman <megous@megous.com>
[Icenowy: Change commit message and slight fixes]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
