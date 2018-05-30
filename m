Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeE3LDN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:03:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56552 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeE3LDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:03:03 -0400
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd71837: Devicetree bindings for BD71837 regulators" to the regulator tree
In-Reply-To: <20180528090101.GD8778@localhost.localdomain>
Message-Id: <E1fNysd-0006kn-NO@debutante>
Date: Wed, 30 May 2018 12:02:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd71837: Devicetree bindings for BD71837 regulators

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

>From 196c813570afd0d52d453ef3b77c4c15ca760327 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Wed, 30 May 2018 11:42:32 +0300
Subject: [PATCH] regulator: bd71837: Devicetree bindings for BD71837
 regulators

Document devicetree bindings for ROHM BD71837 PMIC regulators.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../regulator/rohm,bd71837-regulator.txt      | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
new file mode 100644
index 000000000000..4edf3137d9f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
@@ -0,0 +1,126 @@
+ROHM BD71837 Power Management Integrated Circuit (PMIC) regulator bindings
+
+BD71837MWV is a programmable Power Management
+IC (PMIC) for powering single-core, dual-core, and
+quad-core SoC’s such as NXP-i.MX 8M. It is optimized
+for low BOM cost and compact solution footprint. It
+integrates 8 Buck regulators and 7 LDO’s to provide all
+the power rails required by the SoC and the commonly
+used peripherals.
+
+Required properties:
+ - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7"
+
+List of regulators provided by this controller. BD71837 regulators node
+should be sub node of the BD71837 MFD node. See BD71837 MFD bindings at
+Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+Regulator nodes should be named to BUCK_<number> and LDO_<number>. The
+definition for each of these nodes is defined using the standard
+binding for regulators at
+Documentation/devicetree/bindings/regulator/regulator.txt.
+Note that if BD71837 starts at RUN state you probably want to use
+regulator-boot-on at least for BUCK6 and BUCK7 so that those are not
+disabled by driver at startup. LDO5 and LDO6 are supplied by those and
+if they are disabled at startup the voltage monitoring for LDO5/LDO6 will
+cause PMIC to reset.
+
+The valid names for regulator nodes are:
+BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6, BUCK7, BUCK8
+LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+regulators {
+	buck1: BUCK1 {
+		regulator-name = "buck1";
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-boot-on;
+		regulator-ramp-delay = <1250>;
+	};
+	buck2: BUCK2 {
+		regulator-name = "buck2";
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-ramp-delay = <1250>;
+	};
+	buck3: BUCK3 {
+		regulator-name = "buck3";
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-boot-on;
+	};
+	buck4: BUCK4 {
+		regulator-name = "buck4";
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-boot-on;
+	};
+	buck5: BUCK5 {
+		regulator-name = "buck5";
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-boot-on;
+	};
+	buck6: BUCK6 {
+		regulator-name = "buck6";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+	buck7: BUCK7 {
+		regulator-name = "buck7";
+		regulator-min-microvolt = <1605000>;
+		regulator-max-microvolt = <1995000>;
+		regulator-boot-on;
+	};
+	buck8: BUCK8 {
+		regulator-name = "buck8";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1400000>;
+	};
+
+	ldo1: LDO1 {
+		regulator-name = "ldo1";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+	ldo2: LDO2 {
+		regulator-name = "ldo2";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		regulator-boot-on;
+	};
+	ldo3: LDO3 {
+		regulator-name = "ldo3";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+	ldo4: LDO4 {
+		regulator-name = "ldo4";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <1800000>;
+	};
+	ldo5: LDO5 {
+		regulator-name = "ldo5";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+	ldo6: LDO6 {
+		regulator-name = "ldo6";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <1800000>;
+	};
+	ldo7_reg: LDO7 {
+		regulator-name = "ldo7";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+
-- 
2.17.0
