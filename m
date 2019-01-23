Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918BCC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F44B218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548266266;
	bh=EJ7ILQDd6C42K4oVSUSFI6DLwT2L0QuMkHDOSgeyfyc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=etxMMhmkjhztAzIOau7tLLeQ8N21mrb68s7MDgzKUrcKmvbcjgeXesS7wT27lDLuX
	 hlRmpdzHJxmeVxeRxHTS7cG/F3sFmDedGh/XJnFdH+rOy9mtLxPGnx1fLCGWFjOhpu
	 taiRteYLwS5Kga5zauRfgYFW4qkp6V9yfgO33tHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfAWR5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:57:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45550 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfAWR5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6t1WPBo/nP+117JZPnXxMOHXfVXYbp1ymDG+VoVsImY=; b=g3ixmsDoyzT8
        EnVIc8y9sTFWLSWjm8QfH+mnHryovGHYQOnKAA4YY7WXXMD+ZdF1RcwDSDaNOg4hAOGvYrDMj051C
        ETbgVrbFh8iY4mMiBn4jnaPbT1U/YIymXT6QYviZV1mocKOvD9YsFJoywGMrgSFQwOf8PPduBVRf9
        /dGyM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmMmS-0006qB-Ve; Wed, 23 Jan 2019 17:57:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C001F1127ABA; Wed, 23 Jan 2019 17:57:39 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: stpmic1: Add static const qualifier at peroper places" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190123175739.C001F1127ABA@debutante.sirena.org.uk>
Date:   Wed, 23 Jan 2019 17:57:39 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stpmic1: Add static const qualifier at peroper places

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

From 7c027c66f2b529a1e298eed76adb9bd6509d5325 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 23 Jan 2019 20:26:39 +0800
Subject: [PATCH] regulator: stpmic1: Add static const qualifier at peroper
 places

The regulator_linear_range arrays and stpmic1_regulator_cfgs are only
accessed by this driver and the values are never changed so make them
static const. regulator_ops variables can also be const.
Also clean up a few empty lines in regulator_linear_range array.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stpmic1_regulator.c | 38 ++++++++++++---------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 16ba0297f709..963e67fa9ca6 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -40,7 +40,7 @@ struct stpmic1_regulator_cfg {
 struct stpmic1_regulator {
 	unsigned int regul_id;
 	struct device_node *reg_node;
-	struct stpmic1_regulator_cfg *cfg;
+	const struct stpmic1_regulator_cfg *cfg;
 	u8 mask_reset;
 	int irq_curlim;
 	struct regmap *regmap;
@@ -75,12 +75,12 @@ enum {
 #define STPMIC1_BUCK_MODE_NORMAL 0
 #define STPMIC1_BUCK_MODE_LP BUCK_HPLP_ENABLE_MASK
 
-struct regulator_linear_range buck1_ranges[] = {
+static const struct regulator_linear_range buck1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 30, 25000),
 	REGULATOR_LINEAR_RANGE(1350000, 31, 63, 0),
 };
 
-struct regulator_linear_range buck2_ranges[] = {
+static const struct regulator_linear_range buck2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0, 17, 0),
 	REGULATOR_LINEAR_RANGE(1050000, 18, 19, 0),
 	REGULATOR_LINEAR_RANGE(1100000, 20, 21, 0),
@@ -94,7 +94,7 @@ struct regulator_linear_range buck2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1500000, 36, 63, 0),
 };
 
-struct regulator_linear_range buck3_ranges[] = {
+static const struct regulator_linear_range buck3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0, 19, 0),
 	REGULATOR_LINEAR_RANGE(1100000, 20, 23, 0),
 	REGULATOR_LINEAR_RANGE(1200000, 24, 27, 0),
@@ -102,10 +102,9 @@ struct regulator_linear_range buck3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1400000, 32, 35, 0),
 	REGULATOR_LINEAR_RANGE(1500000, 36, 55, 100000),
 	REGULATOR_LINEAR_RANGE(3400000, 56, 63, 0),
-
 };
 
-struct regulator_linear_range buck4_ranges[] = {
+static const struct regulator_linear_range buck4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 27, 25000),
 	REGULATOR_LINEAR_RANGE(1300000, 28, 29, 0),
 	REGULATOR_LINEAR_RANGE(1350000, 30, 31, 0),
@@ -113,24 +112,21 @@ struct regulator_linear_range buck4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1450000, 34, 35, 0),
 	REGULATOR_LINEAR_RANGE(1500000, 36, 60, 100000),
 	REGULATOR_LINEAR_RANGE(3900000, 61, 63, 0),
-
 };
 
-struct regulator_linear_range ldo1_ranges[] = {
+static const struct regulator_linear_range ldo1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 31, 0),
-
 };
 
-struct regulator_linear_range ldo2_ranges[] = {
+static const struct regulator_linear_range ldo2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 30, 0),
-
 };
 
-struct regulator_linear_range ldo3_ranges[] = {
+static const struct regulator_linear_range ldo3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 30, 0),
@@ -138,18 +134,18 @@ struct regulator_linear_range ldo3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(500000, 31, 31, 0),
 };
 
-struct regulator_linear_range ldo5_ranges[] = {
+static const struct regulator_linear_range ldo5_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 30, 100000),
 	REGULATOR_LINEAR_RANGE(3900000, 31, 31, 0),
 };
 
-struct regulator_linear_range ldo6_ranges[] = {
+static const struct regulator_linear_range ldo6_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 31, 0),
 };
 
-static struct regulator_ops stpmic1_ldo_ops = {
+static const struct regulator_ops stpmic1_ldo_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_linear_range,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -161,7 +157,7 @@ static struct regulator_ops stpmic1_ldo_ops = {
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
-static struct regulator_ops stpmic1_ldo3_ops = {
+static const struct regulator_ops stpmic1_ldo3_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_iterate,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -175,7 +171,7 @@ static struct regulator_ops stpmic1_ldo3_ops = {
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
-static struct regulator_ops stpmic1_ldo4_fixed_regul_ops = {
+static const struct regulator_ops stpmic1_ldo4_fixed_regul_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -183,7 +179,7 @@ static struct regulator_ops stpmic1_ldo4_fixed_regul_ops = {
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
-static struct regulator_ops stpmic1_buck_ops = {
+static const struct regulator_ops stpmic1_buck_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_linear_range,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -197,14 +193,14 @@ static struct regulator_ops stpmic1_buck_ops = {
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
-static struct regulator_ops stpmic1_vref_ddr_ops = {
+static const struct regulator_ops stpmic1_vref_ddr_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.set_pull_down = regulator_set_pull_down_regmap,
 };
 
-static struct regulator_ops stpmic1_switch_regul_ops = {
+static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -334,7 +330,7 @@ static struct regulator_ops stpmic1_switch_regul_ops = {
 	.supply_name = #base, \
 }
 
-struct stpmic1_regulator_cfg stpmic1_regulator_cfgs[] = {
+static const struct stpmic1_regulator_cfg stpmic1_regulator_cfgs[] = {
 	[STPMIC1_BUCK1] = {
 		.desc = REG_BUCK(BUCK1, buck1),
 		.icc_reg = BUCKS_ICCTO_CR,
-- 
2.20.1

