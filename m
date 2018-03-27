Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeC0Pwy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:52:54 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33358 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbeC0Pwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:52:51 -0400
X-Google-Smtp-Source: AG47ELsmnnQBKoEJZa7KTc0uH1x+y1WcaBe1hpi4xPQkf4adPPjTjrGa3RrIkoiRGFbnlOdv8eEdfw==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] regulator: qcom: smd: Add pm8998 and pmi8998 regulators
Date: Tue, 27 Mar 2018 08:53:01 -0700
Message-Id: <20180327155301.31862-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pm8998 and pmi8998 regulators as used in the MSM8998 platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/regulator/qcom,smd-rpm-regulator.txt  |  48 ++++++++
 drivers/regulator/qcom_smd-regulator.c             | 121 +++++++++++++++++++++
 include/linux/soc/qcom/smd-rpm.h                   |   1 +
 3 files changed, 170 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
index 4e3dfb5b5f16..58a1d97972f5 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
@@ -23,7 +23,9 @@ Regulator nodes are identified by their compatible:
 		    "qcom,rpm-pm8916-regulators"
 		    "qcom,rpm-pm8941-regulators"
 		    "qcom,rpm-pm8994-regulators"
+		    "qcom,rpm-pm8998-regulators"
 		    "qcom,rpm-pma8084-regulators"
+		    "qcom,rpm-pmi8998-regulators"
 
 - vdd_s1-supply:
 - vdd_s2-supply:
@@ -119,6 +121,38 @@ Regulator nodes are identified by their compatible:
 	Definition: reference to regulator supplying the input pin, as
 		    described in the data sheet
 
+- vdd_s1-supply:
+- vdd_s2-supply:
+- vdd_s3-supply:
+- vdd_s4-supply:
+- vdd_s5-supply:
+- vdd_s6-supply:
+- vdd_s7-supply:
+- vdd_s8-supply:
+- vdd_s9-supply:
+- vdd_s10-supply:
+- vdd_s11-supply:
+- vdd_s12-supply:
+- vdd_s13-supply:
+- vdd_l1_l27-supply:
+- vdd_l20_l24-supply:
+- vdd_l26-supply:
+- vdd_l2_l8_l17-supply:
+- vdd_l3_l11-supply:
+- vdd_l4_l5-supply:
+- vdd_l6-supply:
+- vdd_l7_l12_l14_l15-supply:
+- vdd_l9-supply:
+- vdd_l10_l23_l25-supply:
+- vdd_l13_l19_l21-supply:
+- vdd_l16_l28-supply:
+- vdd_l18_l22-supply:
+- vdd_lvs1_lvs2-supply:
+	Usage: optional (pmi8998 only)
+	Value type: <phandle>
+	Definition: reference to regulator supplying the input pin, as
+		    described in the data sheet
+
 - vdd_s1-supply:
 - vdd_s2-supply:
 - vdd_s3-supply:
@@ -148,6 +182,12 @@ Regulator nodes are identified by their compatible:
 	Definition: reference to regulator supplying the input pin, as
 		    described in the data sheet
 
+- vdd_bob-supply:
+	Usage: optional (pmi8998 only)
+	Value type: <phandle>
+	Definition: reference to regulator supplying the input pin, as
+		    described in the data sheet
+
 The regulator node houses sub-nodes for each regulator within the device. Each
 sub-node is identified using the node's name, with valid values listed for each
 of the pmics below.
@@ -169,11 +209,19 @@ pm8994:
 	l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20,
 	l21, l22, l23, l24, l25, l26, l27, l28, l29, l30, l31, l32, lvs1, lvs2
 
+pm8998:
+	s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, l1, l2, l3, l4,
+	l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19,
+	l20, l21, l22, l23, l24, l25, l26, l27, l28, lvs1, lvs2
+
 pma8084:
 	s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, l1, l2, l3, l4, l5,
 	l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20,
 	l21, l22, l23, l24, l25, l26, l27, lvs1, lvs2, lvs3, lvs4, 5vs1
 
+pmi8998:
+	bob
+
 The content of each sub-node is defined by the standard binding for regulators -
 see regulator.txt.
 
diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 940fe1b78411..ef51db5f0d9b 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -165,6 +165,15 @@ static const struct regulator_ops rpm_switch_ops = {
 	.is_enabled = rpm_reg_is_enabled,
 };
 
+static const struct regulator_ops rpm_bob_ops = {
+	.enable = rpm_reg_enable,
+	.disable = rpm_reg_disable,
+	.is_enabled = rpm_reg_is_enabled,
+
+	.get_voltage = rpm_reg_get_voltage,
+	.set_voltage = rpm_reg_set_voltage,
+};
+
 static const struct regulator_desc pma8084_hfsmps = {
 	.linear_ranges = (struct regulator_linear_range[]) {
 		REGULATOR_LINEAR_RANGE(375000,  0,  95, 12500),
@@ -355,6 +364,64 @@ static const struct regulator_desc pm8994_lnldo = {
 	.ops = &rpm_smps_ldo_ops_fixed,
 };
 
+static const struct regulator_desc pm8998_ftsmps = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 259,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pm8998_hfsmps = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 216,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pm8998_nldo = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 128,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pm8998_pldo = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 256,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pm8998_pldo_lv = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 128,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pm8998_switch = {
+	.ops = &rpm_switch_ops,
+};
+
+static const struct regulator_desc pmi8998_bob = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 84,
+	.ops = &rpm_bob_ops,
+};
+
 struct rpm_regulator_data {
 	const char *name;
 	u32 type;
@@ -544,12 +611,66 @@ static const struct rpm_regulator_data rpm_pm8994_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pm8998_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8998_ftsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8998_ftsmps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm8998_hfsmps, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm8998_hfsmps, "vdd_s4" },
+	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pm8998_hfsmps, "vdd_s5" },
+	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pm8998_ftsmps, "vdd_s6" },
+	{ "s7", QCOM_SMD_RPM_SMPA, 7, &pm8998_ftsmps, "vdd_s7" },
+	{ "s8", QCOM_SMD_RPM_SMPA, 8, &pm8998_ftsmps, "vdd_s8" },
+	{ "s9", QCOM_SMD_RPM_SMPA, 9, &pm8998_ftsmps, "vdd_s9" },
+	{ "s10", QCOM_SMD_RPM_SMPA, 10, &pm8998_ftsmps, "vdd_s10" },
+	{ "s11", QCOM_SMD_RPM_SMPA, 11, &pm8998_ftsmps, "vdd_s11" },
+	{ "s12", QCOM_SMD_RPM_SMPA, 12, &pm8998_ftsmps, "vdd_s12" },
+	{ "s13", QCOM_SMD_RPM_SMPA, 13, &pm8998_ftsmps, "vdd_s13" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm8998_nldo, "vdd_l1_l27" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm8998_nldo, "vdd_l2_l8_l17" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm8998_nldo, "vdd_l3_l11" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm8998_nldo, "vdd_l4_l5" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm8998_nldo, "vdd_l4_l5" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm8998_pldo, "vdd_l6" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm8998_nldo, "vdd_l2_l8_l17" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm8998_pldo, "vdd_l9" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm8998_pldo, "vdd_l10_l23_l25" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm8998_nldo, "vdd_l3_l11" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm8998_pldo, "vdd_l13_l19_l21" },
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm8998_pldo_lv, "vdd_l7_l12_l14_l15" },
+	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm8998_pldo, "vdd_l16_l28" },
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm8998_nldo, "vdd_l2_l8_l17" },
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm8998_pldo, "vdd_l18_l22" },
+	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm8998_pldo, "vdd_l13_l19_l21" },
+	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pm8998_pldo, "vdd_l20_l24" },
+	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pm8998_pldo, "vdd_l13_l19_l21" },
+	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pm8998_pldo, "vdd_l18_l22" },
+	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pm8998_pldo, "vdd_l10_l23_l25" },
+	{ "l24", QCOM_SMD_RPM_LDOA, 24, &pm8998_pldo, "vdd_l20_l24" },
+	{ "l25", QCOM_SMD_RPM_LDOA, 25, &pm8998_pldo, "vdd_l10_l23_l25" },
+	{ "l26", QCOM_SMD_RPM_LDOA, 26, &pm8998_nldo, "vdd_l26" },
+	{ "l27", QCOM_SMD_RPM_LDOA, 27, &pm8998_nldo, "vdd_l1_l27" },
+	{ "l28", QCOM_SMD_RPM_LDOA, 28, &pm8998_pldo, "vdd_l16_l28" },
+	{ "lvs1", QCOM_SMD_RPM_VSA, 1, &pm8998_switch, "vdd_lvs1_lvs2" },
+	{ "lvs2", QCOM_SMD_RPM_VSA, 2, &pm8998_switch, "vdd_lvs1_lvs2" },
+	{}
+};
+
+static const struct rpm_regulator_data rpm_pmi8998_regulators[] = {
+	{ "bob", QCOM_SMD_RPM_BOBB, 1, &pmi8998_bob, "vdd_bob" },
+	{}
+};
+
 static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-pm8841-regulators", .data = &rpm_pm8841_regulators },
 	{ .compatible = "qcom,rpm-pm8916-regulators", .data = &rpm_pm8916_regulators },
 	{ .compatible = "qcom,rpm-pm8941-regulators", .data = &rpm_pm8941_regulators },
 	{ .compatible = "qcom,rpm-pm8994-regulators", .data = &rpm_pm8994_regulators },
+	{ .compatible = "qcom,rpm-pm8998-regulators", .data = &rpm_pm8998_regulators },
 	{ .compatible = "qcom,rpm-pma8084-regulators", .data = &rpm_pma8084_regulators },
+	{ .compatible = "qcom,rpm-pmi8998-regulators", .data = &rpm_pmi8998_regulators },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rpm_of_match);
diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 9f5c6e53f3a5..9e4fdd861a51 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -10,6 +10,7 @@ struct qcom_smd_rpm;
 /*
  * Constants used for addressing resources in the RPM.
  */
+#define QCOM_SMD_RPM_BOBB	0x62626f62
 #define QCOM_SMD_RPM_BOOST	0x61747362
 #define QCOM_SMD_RPM_BUS_CLK	0x316b6c63
 #define QCOM_SMD_RPM_BUS_MASTER	0x73616d62
-- 
2.16.2
