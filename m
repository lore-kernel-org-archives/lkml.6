Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755292AbeEXF56 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:57:58 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46570 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755033AbeEXF54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:57:56 -0400
X-Google-Smtp-Source: ADUXVKIr4gQ/U5f2flcoGx1z8/u//6RLSsCX8VkGbkwXjTAItGQ4/uUvhSmU7ju7LyBjdVuYe4m0wA==
Date: Thu, 24 May 2018 08:57:52 +0300
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH 4/9] regulator: bd71837: Devicetree bindings for BD71837
 regulators
Message-ID: <20180524055752.GE4249@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for ROHM BD71837 PMIC regulators.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../bindings/regulator/rohm,bd71837-regulator.txt  | 124 +++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
new file mode 100644
index 000000000000..a43230143b66
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
@@ -0,0 +1,124 @@
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
+ - compatible: should be "rohm,bd71837-pmic".
+ - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7"
+
+List of regulators provided by this controller. BD71837 regulators node
+should be sub node of the BD71837 MFD node. See BD71837 MFD bindings at
+Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+Regulator nodes should be named to BUCK_<number> and LDO_<number>. The
+definition for each of these nodes is defined using the standard
+binding for regulators at
+Documentation/devicetree/bindings/regulator/regulator.txt.
+
+The valid names for regulators are:
+BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6, BUCK7, BUCK8
+LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+regulators {
+	compatible = "rohm,bd71837-pmic";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	buck1: BUCK1 {
+		pmic-supply = <&vmmcsd_fixed>;
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
+	};
+	buck7: BUCK7 {
+		regulator-name = "buck7";
+		regulator-min-microvolt = <1605000>;
+		regulator-max-microvolt = <1995000>;
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
2.14.3
