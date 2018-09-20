Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F50EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2592147C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="d+U6NcIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2592147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbeITXVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:21:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51878 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbeITXVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6z8meJC2J4+DyCe4EqzupIi53QVclOpnTRvHbkyCYWk=; b=d+U6NcIKuNxm
        Jh527SUOAcGQ1Y0IwRyvoV3d2i6z75FJfzYGnv2NFOPTBv5GZ5EdSoMzbtC97ChJw40YtVxB62dCR
        zRG/n9Yrc1pTnHbPG0kJB8/52TmC2rzwF1bsWbUeL4/4XCKckw5M4poXcQcif4AValbPhOg5GNpdC
        UM3x8=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g32sM-0007Ee-7n; Thu, 20 Sep 2018 17:36:26 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2F617440078; Thu, 20 Sep 2018 18:36:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: qcom: Add PMS405 regulators" to the regulator tree
In-Reply-To: 
Message-Id: <20180920173624.2F617440078@finisterre.ee.mobilebroadband>
Date:   Thu, 20 Sep 2018 18:36:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: qcom: Add PMS405 regulators

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

From f589d95b9751d1ae4cbe2cdd2e505c11a5438c9e Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Wed, 19 Sep 2018 18:40:20 -0700
Subject: [PATCH] regulator: qcom: Add PMS405 regulators

The PMS405 provdies 5 SMPS regulators and 13 LDOs, add these to the RPM
regulator driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../regulator/qcom,smd-rpm-regulator.txt      | 23 ++++++
 drivers/regulator/qcom_smd-regulator.c        | 77 +++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
index 58a1d97972f5..45025b5b67f6 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
@@ -26,6 +26,7 @@ Regulator nodes are identified by their compatible:
 		    "qcom,rpm-pm8998-regulators"
 		    "qcom,rpm-pma8084-regulators"
 		    "qcom,rpm-pmi8998-regulators"
+		    "qcom,rpm-pms405-regulators"
 
 - vdd_s1-supply:
 - vdd_s2-supply:
@@ -188,6 +189,24 @@ Regulator nodes are identified by their compatible:
 	Definition: reference to regulator supplying the input pin, as
 		    described in the data sheet
 
+- vdd_s1-supply:
+- vdd_s2-supply:
+- vdd_s3-supply:
+- vdd_s4-supply:
+- vdd_s5-supply:
+- vdd_l1_l2-supply:
+- vdd_l3_l8-supply:
+- vdd_l4-supply:
+- vdd_l5_l6-supply:
+- vdd_l7-supply:
+- vdd_l3_l8-supply:
+- vdd_l9-supply:
+- vdd_l10_l11_l12_l13-supply:
+	Usage: optional (pms405 only)
+	Value type: <phandle>
+	Definition: reference to regulator supplying the input pin, as
+		    described in the data sheet
+
 The regulator node houses sub-nodes for each regulator within the device. Each
 sub-node is identified using the node's name, with valid values listed for each
 of the pmics below.
@@ -222,6 +241,10 @@ pma8084:
 pmi8998:
 	bob
 
+pms405:
+	s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12,
+	l13
+
 The content of each sub-node is defined by the standard binding for regulators -
 see regulator.txt.
 
diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index fe2fb36803e0..f5bca77d67c1 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -420,6 +420,60 @@ static const struct regulator_desc pmi8998_bob = {
 	.ops = &rpm_bob_ops,
 };
 
+static const struct regulator_desc pms405_hfsmps3 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 216,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pms405_nldo300 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 128,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pms405_nldo1200 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 128,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pms405_pldo50 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1664000, 0, 128, 16000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 129,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pms405_pldo150 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1664000, 0, 128, 16000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 129,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pms405_pldo600 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1256000, 0, 98, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 99,
+	.ops = &rpm_smps_ldo_ops,
+};
+
 struct rpm_regulator_data {
 	const char *name;
 	u32 type;
@@ -661,6 +715,28 @@ static const struct rpm_regulator_data rpm_pmi8998_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pms405_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pms405_hfsmps3, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pms405_hfsmps3, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pms405_hfsmps3, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pms405_hfsmps3, "vdd_s4" },
+	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pms405_hfsmps3, "vdd_s5" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pms405_nldo1200, "vdd_l1_l2" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pms405_nldo1200, "vdd_l1_l2" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pms405_nldo1200, "vdd_l3_l8" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pms405_nldo300, "vdd_l4" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pms405_pldo600, "vdd_l5_l6" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pms405_pldo600, "vdd_l5_l6" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pms405_pldo150, "vdd_l7" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pms405_nldo1200, "vdd_l3_l8" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pms405_nldo1200, "vdd_l9" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pms405_pldo50, "vdd_l10_l11_l12_l13" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pms405_pldo150, "vdd_l10_l11_l12_l13" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pms405_pldo150, "vdd_l10_l11_l12_l13" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pms405_pldo150, "vdd_l10_l11_l12_l13" },
+	{}
+};
+
 static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-pm8841-regulators", .data = &rpm_pm8841_regulators },
 	{ .compatible = "qcom,rpm-pm8916-regulators", .data = &rpm_pm8916_regulators },
@@ -669,6 +745,7 @@ static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-pm8998-regulators", .data = &rpm_pm8998_regulators },
 	{ .compatible = "qcom,rpm-pma8084-regulators", .data = &rpm_pma8084_regulators },
 	{ .compatible = "qcom,rpm-pmi8998-regulators", .data = &rpm_pmi8998_regulators },
+	{ .compatible = "qcom,rpm-pms405-regulators", .data = &rpm_pms405_regulators },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rpm_of_match);
-- 
2.19.0

