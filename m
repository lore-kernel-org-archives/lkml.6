Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1319C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732E121904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550576846;
	bh=sNyc00Aoga8lt32QTta5vezZTbd5yLoyGFVA3mGo910=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=NFJXiWpiGvAJ9WYHa8PsKsRdtjm7MEEItv7UblAddtLibyJWGB/DGcjGu6rPXHY/s
	 /qOYk6TF0IHqApHLeuSapVNQmxbgKS+7eGa7MXh6/1UZxbU60TQ8UsqHTbbWbpluQN
	 yfPlRC32GyZLiWkrmOWJ57QBdXmwaZvtg4uzNj4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfBSLrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:47:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56428 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfBSLrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QZFf0aLIQq4nED284uDakRaFKI0VD6vGUDbF3vi2O/8=; b=w90eDX4Dur5q
        XSctGAfirC3YYC7CURDND83zJDho0Y0obfKvQM2RVVojsBPHu+c93AK7YL1Ovk15qU3n9l1H7dOp7
        aIEutqDwZH/YwDqoODMoP9PKyFbNmHCqd2HkfnPJX1W80A7Q0efRfOEbK0VDG5JV4P7BlGqlbmWYI
        ov9lw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gw3ru-0008T0-BO; Tue, 19 Feb 2019 11:47:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 76C3A11284A6; Tue, 19 Feb 2019 11:47:21 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     pascal paillet <p.paillet@st.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: stpmic1: Remove support for regulator pull down" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190219114721.76C3A11284A6@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 11:47:21 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stpmic1: Remove support for regulator pull down

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

From 1614f086d5f59358d9a7842d22d950384945e612 Mon Sep 17 00:00:00 2001
From: Pascal PAILLET-LME <p.paillet@st.com>
Date: Tue, 19 Feb 2019 10:04:33 +0000
Subject: [PATCH] regulator: stpmic1: Remove support for regulator pull down

Regulator high pull down are enabled by default so remove support in the
driver.

Signed-off-by: pascal paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stpmic1_regulator.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index f5c0e5887189..6970e4587a57 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -133,7 +133,6 @@ static const struct regulator_ops stpmic1_ldo_ops = {
 	.disable = regulator_disable_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.set_pull_down = regulator_set_pull_down_regmap,
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
@@ -145,7 +144,6 @@ static const struct regulator_ops stpmic1_ldo3_ops = {
 	.disable = regulator_disable_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.set_pull_down = regulator_set_pull_down_regmap,
 	.get_bypass = regulator_get_bypass_regmap,
 	.set_bypass = regulator_set_bypass_regmap,
 	.set_over_current_protection = stpmic1_set_icc,
@@ -155,7 +153,6 @@ static const struct regulator_ops stpmic1_ldo4_fixed_regul_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
-	.set_pull_down = regulator_set_pull_down_regmap,
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
@@ -177,7 +174,6 @@ static const struct regulator_ops stpmic1_vref_ddr_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
-	.set_pull_down = regulator_set_pull_down_regmap,
 };
 
 static const struct regulator_ops stpmic1_switch_regul_ops = {
@@ -203,8 +199,6 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
-	.pull_down_reg = ids##_PULL_DOWN_REG, \
-	.pull_down_mask = ids##_PULL_DOWN_MASK, \
 	.supply_name = #base, \
 }
 
@@ -228,8 +222,6 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.bypass_mask = LDO_BYPASS_MASK, \
 	.bypass_val_on = LDO_BYPASS_MASK, \
 	.bypass_val_off = 0, \
-	.pull_down_reg = ids##_PULL_DOWN_REG, \
-	.pull_down_mask = ids##_PULL_DOWN_MASK, \
 	.supply_name = #base, \
 }
 
@@ -247,8 +239,6 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
-	.pull_down_reg = ids##_PULL_DOWN_REG, \
-	.pull_down_mask = ids##_PULL_DOWN_MASK, \
 	.supply_name = #base, \
 }
 
@@ -288,8 +278,6 @@ static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.enable_val = 1, \
 	.disable_val = 0, \
 	.enable_time = PMIC_ENABLE_TIME_US, \
-	.pull_down_reg = ids##_PULL_DOWN_REG, \
-	.pull_down_mask = ids##_PULL_DOWN_MASK, \
 	.supply_name = #base, \
 }
 
-- 
2.20.1

