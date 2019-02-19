Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B48C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F7721479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550576888;
	bh=7mPxu5e6FrTOv2nHxZi4tchAP9upgVPN/uRtw5oJLjo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PwDMJ4aBPVIOi1L2izecjgEhZud4Od6aNK4nk0YIqHDpFct9hwye1eDp+Y+9bMv2W
	 7cWJ0BxFi27VvDSTWyErq1lt67TaL3xxwSrlruZBkOi0RMl65hosEDNUmzcz39avwi
	 2tpaa8eJbhgOcIj+HFnUo4cr3/fDz1QtKETNeJ/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfBSLsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:48:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56468 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfBSLr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yzIHyaLKwUmIhAJGgTMwKbl12JmM/7dbtZMAGnbr2rI=; b=JY4pwLBdop89
        +ApGwYES4fMB/WGJ8riQQlJaVpM36X/es2ik4a4zpZaSXglPvebvM5rKktRgLNa9yi1DQMgoMC47j
        5D3jbme0aI81Al9CCdRGccva5EPsRqya20E6ZgSp/bl810UT+titAamHX0ra9ulWReFVuqZj+NYtJ
        mRNQk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gw3rq-0008So-O6; Tue, 19 Feb 2019 11:47:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0FE1F11284A6; Tue, 19 Feb 2019 11:47:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     pascal paillet <p.paillet@st.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: stpmic1: Add active discharge support" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190219114718.0FE1F11284A6@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 11:47:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stpmic1: Add active discharge support

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

From e6fff62ab8ac81fe42c407b1b2cfbffcb50c7d01 Mon Sep 17 00:00:00 2001
From: Pascal PAILLET-LME <p.paillet@st.com>
Date: Tue, 19 Feb 2019 10:04:35 +0000
Subject: [PATCH] regulator: stpmic1: Add active discharge support

Add support for active discharge for USB power switches.

Signed-off-by: pascal paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stpmic1_regulator.c | 68 ++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 6970e4587a57..0668d61df7d4 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -176,11 +176,19 @@ static const struct regulator_ops stpmic1_vref_ddr_ops = {
 	.disable = regulator_disable_regmap,
 };
 
+static const struct regulator_ops stpmic1_boost_regul_ops = {
+	.is_enabled = regulator_is_enabled_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_over_current_protection = stpmic1_set_icc,
+};
+
 static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.set_over_current_protection = stpmic1_set_icc,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
 };
 
 #define REG_LDO(ids, base) { \
@@ -281,7 +289,44 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.supply_name = #base, \
 }
 
-#define REG_SWITCH(ids, base, reg, mask, val) { \
+#define REG_BOOST(ids, base) { \
+	.name = #ids, \
+	.id = STPMIC1_##ids, \
+	.n_voltages = 1, \
+	.ops = &stpmic1_boost_regul_ops, \
+	.type = REGULATOR_VOLTAGE, \
+	.owner = THIS_MODULE, \
+	.min_uV = 0, \
+	.fixed_uV = 5000000, \
+	.enable_reg = BST_SW_CR, \
+	.enable_mask = BOOST_ENABLED, \
+	.enable_val = BOOST_ENABLED, \
+	.disable_val = 0, \
+	.enable_time = PMIC_ENABLE_TIME_US, \
+	.supply_name = #base, \
+}
+
+#define REG_VBUS_OTG(ids, base) { \
+	.name = #ids, \
+	.id = STPMIC1_##ids, \
+	.n_voltages = 1, \
+	.ops = &stpmic1_switch_regul_ops, \
+	.type = REGULATOR_VOLTAGE, \
+	.owner = THIS_MODULE, \
+	.min_uV = 0, \
+	.fixed_uV = 5000000, \
+	.enable_reg = BST_SW_CR, \
+	.enable_mask = USBSW_OTG_SWITCH_ENABLED, \
+	.enable_val = USBSW_OTG_SWITCH_ENABLED, \
+	.disable_val = 0, \
+	.enable_time = PMIC_ENABLE_TIME_US, \
+	.supply_name = #base, \
+	.active_discharge_reg = BST_SW_CR, \
+	.active_discharge_mask = VBUS_OTG_DISCHARGE, \
+	.active_discharge_on = VBUS_OTG_DISCHARGE, \
+}
+
+#define REG_SW_OUT(ids, base) { \
 	.name = #ids, \
 	.id = STPMIC1_##ids, \
 	.n_voltages = 1, \
@@ -290,12 +335,15 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.owner = THIS_MODULE, \
 	.min_uV = 0, \
 	.fixed_uV = 5000000, \
-	.enable_reg = (reg), \
-	.enable_mask = (mask), \
-	.enable_val = (val), \
+	.enable_reg = BST_SW_CR, \
+	.enable_mask = SWIN_SWOUT_ENABLED, \
+	.enable_val = SWIN_SWOUT_ENABLED, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
 	.supply_name = #base, \
+	.active_discharge_reg = BST_SW_CR, \
+	.active_discharge_mask = SW_OUT_DISCHARGE, \
+	.active_discharge_on = SW_OUT_DISCHARGE, \
 }
 
 static const struct stpmic1_regulator_cfg stpmic1_regulator_cfgs[] = {
@@ -375,23 +423,17 @@ static const struct stpmic1_regulator_cfg stpmic1_regulator_cfgs[] = {
 		.mask_reset_mask = BIT(6),
 	},
 	[STPMIC1_BOOST] = {
-		.desc = REG_SWITCH(BOOST, boost, BST_SW_CR,
-				   BOOST_ENABLED,
-				   BOOST_ENABLED),
+		.desc = REG_BOOST(BOOST, boost),
 		.icc_reg = BUCKS_ICCTO_CR,
 		.icc_mask = BIT(6),
 	},
 	[STPMIC1_VBUS_OTG] = {
-		.desc = REG_SWITCH(VBUS_OTG, pwr_sw1, BST_SW_CR,
-				   USBSW_OTG_SWITCH_ENABLED,
-				   USBSW_OTG_SWITCH_ENABLED),
+		.desc = REG_VBUS_OTG(VBUS_OTG, pwr_sw1),
 		.icc_reg = BUCKS_ICCTO_CR,
 		.icc_mask = BIT(4),
 	},
 	[STPMIC1_SW_OUT] = {
-		.desc = REG_SWITCH(SW_OUT, pwr_sw2, BST_SW_CR,
-				   SWIN_SWOUT_ENABLED,
-				   SWIN_SWOUT_ENABLED),
+		.desc = REG_SW_OUT(SW_OUT, pwr_sw2),
 		.icc_reg = BUCKS_ICCTO_CR,
 		.icc_mask = BIT(5),
 	},
-- 
2.20.1

