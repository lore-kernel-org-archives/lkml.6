Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E767C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C87205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549124317;
	bh=3BFF8DS+ez4FJEgA+DLAU5Ii7kNsXeYG2QSLp1Uv1LE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=tyN8nMQmTnXYQ8rTerVHlGIZ2eudYHEcrLL8U7SpOQawGqd0+tr5AcwNyEfGIrdL1
	 LhQ+gDDvDkRdwfTJ4WBaOaOez3ovIoM0FxXD9Uq40+uVYh9SmdyxmiM52RhXDpgwZ1
	 8m4rH1wcUJEXZBtCxdLUe7zgWrd2nsv3w1UgGor8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfBBQSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:18:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50532 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfBBQSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NN2wws9X6S4B6+m84i++t1NW8MfUmkY5iAsZfbk7wyg=; b=VnwvfM3ZSr21
        wpgyo8p9cIYv+dGJnE5r1mU4PmZjACG0hQCNg7Cs2gKGlQlwFVLf+ofvkkECN3rszXiKlooO2S/Xq
        YJi3wdK04zSSxig81JM6EuNvvwPcsgh239kgSu3ZSEELySJXI0SGxUx+ys/PpnRBbU+S6a3ugUagB
        hgVlM=;
Received: from [2001:67c:1810:f055:877d:5801:eba7:24a1] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gpxzz-0007dU-RC; Sat, 02 Feb 2019 16:18:31 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8A6CA440082; Sat,  2 Feb 2019 16:18:31 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: rk808: Fix BUCK1/2 voltages on rk805" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190202161831.8A6CA440082@finisterre.ee.mobilebroadband>
Date:   Sat,  2 Feb 2019 16:18:31 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rk808: Fix BUCK1/2 voltages on rk805

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

From 2b679ca1136129b0601f3d439965f83bd33d9eda Mon Sep 17 00:00:00 2001
From: Otavio Salvador <otavio@ossystems.com.br>
Date: Thu, 31 Jan 2019 10:46:01 -0200
Subject: [PATCH] regulator: rk808: Fix BUCK1/2 voltages on rk805
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

RK805 has the following voltage range for the BUCK1 and BUCK2 regulators:

From 0.7125V to 1.45V in 12.5mV steps, 1.8V, 2V, 2.2V and 2.3V

, which corresponds to the following values as per the RK805
datasheet:

000 000: 0.7125V
000 001: 0.725V
……
111 011: 1.45V
111 100: 1.8V
111 101: 2.0V
111 110: 2.2V
111 111: 2.3V

This means that the voltage range is not linear and so RK805 can not
reuse the same regulator_ops structure from RK808.

Fix it by creating a list with the correct supported voltage values
for RK805 BUCK1 and BUCK2 regulators.

Tested on a rv1108-elgin-r1 board that now correctly reports a BUCK2
voltage of 2.2V instead of the unsupported value of 1.4875V.

Fixes: c4e0d344c1f0 ("regulator: rk808: Add regulator driver for RK805")
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 53 ++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 08578f6d737d..79e79cdd503b 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -289,6 +289,21 @@ static int rk808_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 				  RK808_RAMP_RATE_MASK, ramp_value);
 }
 
+static int rk805_set_suspend_voltage(struct regulator_dev *rdev, int uv)
+{
+	unsigned int reg;
+	int sel = regulator_map_voltage_ascend(rdev, uv, uv);
+
+	if (sel < 0)
+		return -EINVAL;
+
+	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
+
+	return regmap_update_bits(rdev->regmap, reg,
+				  rdev->desc->vsel_mask,
+				  sel);
+}
+
 static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
 {
 	unsigned int reg;
@@ -384,6 +399,19 @@ static const struct regulator_ops rk805_switch_ops = {
 	.set_suspend_disable    = rk805_set_suspend_disable,
 };
 
+static struct regulator_ops rk805_buck1_2_ops = {
+		.list_voltage		= regulator_list_voltage_table,
+		.map_voltage		= regulator_map_voltage_ascend,
+		.get_voltage_sel        = regulator_get_voltage_sel_regmap,
+		.set_voltage_sel        = regulator_set_voltage_sel_regmap,
+		.enable                 = regulator_enable_regmap,
+		.disable                = regulator_disable_regmap,
+		.is_enabled             = regulator_is_enabled_regmap,
+		.set_suspend_voltage    = rk805_set_suspend_voltage,
+		.set_suspend_enable     = rk805_set_suspend_enable,
+		.set_suspend_disable    = rk805_set_suspend_disable,
+};
+
 static const struct regulator_ops rk808_buck1_2_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -433,6 +461,17 @@ static const struct regulator_ops rk808_switch_ops = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
+static const int rk805_buck_1_2_voltages[] = {
+	712500, 725000, 737500, 750000, 762500, 775000, 787500, 800000,
+	812500, 825000, 837500, 850000, 862500, 875000, 887500, 900000,
+	912500, 925000, 937500, 950000, 962500, 975000, 987500, 1000000,
+	1012500, 1025000, 1037500, 1050000, 1062500, 1075000, 1087500, 1100000,
+	1112500, 1125000, 1137500, 1150000, 1162500, 1175000, 1187500, 1200000,
+	1212500, 1225000, 1237500, 1250000, 1262500, 1275000, 1287500, 1300000,
+	1312500, 1325000, 1337500, 1350000, 1362500, 1375000, 1387500, 1400000,
+	1412500, 1425000, 1437500, 1450000, 1800000, 2000000, 2200000, 2300000,
+};
+
 static const struct regulator_desc rk805_reg[] = {
 	{
 		.name = "DCDC_REG1",
@@ -440,11 +479,10 @@ static const struct regulator_desc rk805_reg[] = {
 		.of_match = of_match_ptr("DCDC_REG1"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = RK805_ID_DCDC1,
-		.ops = &rk805_reg_ops,
+		.ops = &rk805_buck1_2_ops,
 		.type = REGULATOR_VOLTAGE,
-		.min_uV = 712500,
-		.uV_step = 12500,
-		.n_voltages = 64,
+		.n_voltages = ARRAY_SIZE(rk805_buck_1_2_voltages),
+		.volt_table = rk805_buck_1_2_voltages,
 		.vsel_reg = RK805_BUCK1_ON_VSEL_REG,
 		.vsel_mask = RK818_BUCK_VSEL_MASK,
 		.enable_reg = RK805_DCDC_EN_REG,
@@ -456,11 +494,10 @@ static const struct regulator_desc rk805_reg[] = {
 		.of_match = of_match_ptr("DCDC_REG2"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = RK805_ID_DCDC2,
-		.ops = &rk805_reg_ops,
+		.ops = &rk805_buck1_2_ops,
 		.type = REGULATOR_VOLTAGE,
-		.min_uV = 712500,
-		.uV_step = 12500,
-		.n_voltages = 64,
+		.n_voltages = ARRAY_SIZE(rk805_buck_1_2_voltages),
+		.volt_table = rk805_buck_1_2_voltages,
 		.vsel_reg = RK805_BUCK2_ON_VSEL_REG,
 		.vsel_mask = RK818_BUCK_VSEL_MASK,
 		.enable_reg = RK805_DCDC_EN_REG,
-- 
2.20.1

