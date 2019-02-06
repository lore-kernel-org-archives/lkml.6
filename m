Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03B7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A603F20823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549472321;
	bh=j3BI9SMvcnIkB82VYvFfmIyhqJuvyU0wrzuoDCv+CH4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=M3sOSmMkPuDh1trV5zuGOwP6IxFgK4Y5w4Afz3v0lVwcWIH9AtPX1PBEYpgN+0cXJ
	 /UZc6ndXuZKDxl1Y/FQbaERxT9h+WiT0Rui1tlS0yRpA78KzCJCmr/c2sJGt9FOmtY
	 AOWRNC6NJPRBXdGeZnvl5/7K4dFcMTGN3db3f958=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfBFQ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:58:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46338 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfBFQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=AKUNPySlVJNCi/CfbhpshMhASxtChS/aFLuHwNzFOxs=; b=B1jvBr22qqB2
        U70a8cUFW36RA66NMgroGpqeh4sliQRiyYO4DXoWYW/g5dnwTGqR6Fvfd7FrcvGqmFDCMIK7+AX5U
        iZx53cW5TP7KGnsiI3E1us3Vxi5lGsFCZTqtDlbny+ifN9cR6Hy3lTAkEcUG55whOllreOEqVw75O
        fExfs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grQWx-00073r-Lq; Wed, 06 Feb 2019 16:58:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3CFA11127EA3; Wed,  6 Feb 2019 16:58:35 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: rk808: Convert rk805 buck1/2 to use linear range" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190206165835.3CFA11127EA3@debutante.sirena.org.uk>
Date:   Wed,  6 Feb 2019 16:58:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rk808: Convert rk805 buck1/2 to use linear range

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

From 4f297062b288e9434280dd3a2f0ba7424d7a7224 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 4 Feb 2019 15:10:51 +0800
Subject: [PATCH] regulator: rk808: Convert rk805 buck1/2 to use linear range

It looks like linear range is suitable to describe the voltage table
for rk805 buck1/2:

selector 0 ~ 59: 0.7125V with uV_step = 12500
selector 60 ~ 62: 1.8V with uV_step = 200000
selector 63: 2.3V

With this change, then rk805 buck1/2 can reuse rk808_reg_ops_ranges.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Tested-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 55 +++++++----------------------
 1 file changed, 12 insertions(+), 43 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 79e79cdd503b..23713e16c286 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -289,21 +289,6 @@ static int rk808_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 				  RK808_RAMP_RATE_MASK, ramp_value);
 }
 
-static int rk805_set_suspend_voltage(struct regulator_dev *rdev, int uv)
-{
-	unsigned int reg;
-	int sel = regulator_map_voltage_ascend(rdev, uv, uv);
-
-	if (sel < 0)
-		return -EINVAL;
-
-	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
-
-	return regmap_update_bits(rdev->regmap, reg,
-				  rdev->desc->vsel_mask,
-				  sel);
-}
-
 static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
 {
 	unsigned int reg;
@@ -399,19 +384,6 @@ static const struct regulator_ops rk805_switch_ops = {
 	.set_suspend_disable    = rk805_set_suspend_disable,
 };
 
-static struct regulator_ops rk805_buck1_2_ops = {
-		.list_voltage		= regulator_list_voltage_table,
-		.map_voltage		= regulator_map_voltage_ascend,
-		.get_voltage_sel        = regulator_get_voltage_sel_regmap,
-		.set_voltage_sel        = regulator_set_voltage_sel_regmap,
-		.enable                 = regulator_enable_regmap,
-		.disable                = regulator_disable_regmap,
-		.is_enabled             = regulator_is_enabled_regmap,
-		.set_suspend_voltage    = rk805_set_suspend_voltage,
-		.set_suspend_enable     = rk805_set_suspend_enable,
-		.set_suspend_disable    = rk805_set_suspend_disable,
-};
-
 static const struct regulator_ops rk808_buck1_2_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -461,15 +433,10 @@ static const struct regulator_ops rk808_switch_ops = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
-static const int rk805_buck_1_2_voltages[] = {
-	712500, 725000, 737500, 750000, 762500, 775000, 787500, 800000,
-	812500, 825000, 837500, 850000, 862500, 875000, 887500, 900000,
-	912500, 925000, 937500, 950000, 962500, 975000, 987500, 1000000,
-	1012500, 1025000, 1037500, 1050000, 1062500, 1075000, 1087500, 1100000,
-	1112500, 1125000, 1137500, 1150000, 1162500, 1175000, 1187500, 1200000,
-	1212500, 1225000, 1237500, 1250000, 1262500, 1275000, 1287500, 1300000,
-	1312500, 1325000, 1337500, 1350000, 1362500, 1375000, 1387500, 1400000,
-	1412500, 1425000, 1437500, 1450000, 1800000, 2000000, 2200000, 2300000,
+static const struct regulator_linear_range rk805_buck_1_2_voltage_ranges[] = {
+	REGULATOR_LINEAR_RANGE(712500, 0, 59, 12500),
+	REGULATOR_LINEAR_RANGE(1800000, 60, 62, 200000),
+	REGULATOR_LINEAR_RANGE(2300000, 63, 63, 0),
 };
 
 static const struct regulator_desc rk805_reg[] = {
@@ -479,10 +446,11 @@ static const struct regulator_desc rk805_reg[] = {
 		.of_match = of_match_ptr("DCDC_REG1"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = RK805_ID_DCDC1,
-		.ops = &rk805_buck1_2_ops,
+		.ops = &rk808_reg_ops_ranges,
 		.type = REGULATOR_VOLTAGE,
-		.n_voltages = ARRAY_SIZE(rk805_buck_1_2_voltages),
-		.volt_table = rk805_buck_1_2_voltages,
+		.n_voltages = 64,
+		.linear_ranges = rk805_buck_1_2_voltage_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rk805_buck_1_2_voltage_ranges),
 		.vsel_reg = RK805_BUCK1_ON_VSEL_REG,
 		.vsel_mask = RK818_BUCK_VSEL_MASK,
 		.enable_reg = RK805_DCDC_EN_REG,
@@ -494,10 +462,11 @@ static const struct regulator_desc rk805_reg[] = {
 		.of_match = of_match_ptr("DCDC_REG2"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = RK805_ID_DCDC2,
-		.ops = &rk805_buck1_2_ops,
+		.ops = &rk808_reg_ops_ranges,
 		.type = REGULATOR_VOLTAGE,
-		.n_voltages = ARRAY_SIZE(rk805_buck_1_2_voltages),
-		.volt_table = rk805_buck_1_2_voltages,
+		.n_voltages = 64,
+		.linear_ranges = rk805_buck_1_2_voltage_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rk805_buck_1_2_voltage_ranges),
 		.vsel_reg = RK805_BUCK2_ON_VSEL_REG,
 		.vsel_mask = RK818_BUCK_VSEL_MASK,
 		.enable_reg = RK805_DCDC_EN_REG,
-- 
2.20.1

