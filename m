Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2111C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC4A217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182840;
	bh=q3aWMDD3gadcZcWZEcYOLD3FxEBAbooGrQvnMpALrkY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kDEvSvIs8WiRzvV9TXl+oEfAPvX1Cm/+naaR0DQIqXP+64AvtauvedLV24icFv/SY
	 NkDa3V8XiYZy32565sivZqWb9Nvlp1xE2a4K88r2QuCd6Oa0VwaWjFwokomoHMOl0m
	 pb4BfCNh5naXcvGryhQNC+EivbEwerd367cXJA+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfBZMG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:06:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58412 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfBZMGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aXQQLVy1Oc4uJfR89KGPTEv7oIyx0DTz1QL1p/7dwJc=; b=s+R7nWIv0l3Q
        Y/Ep6AM8qM85YKcIzYqGPMBBeeSHlb4sC+uIJ8t2fawxnRG535y3sKw4O2nnMTbXt+WW+jRx1TZQM
        cM4nxLwnyxs1b3UBOGGhN1JsJ1hadmbbxTuBMmDQb+sFD8UYVGrbu/tp0Yi778b/dPiL5g5kQCFnH
        c4Xtg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gybVb-0007ip-13; Tue, 26 Feb 2019 12:06:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A20BE11284F0; Tue, 26 Feb 2019 12:06:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: arizona_ldo1: Simplify arizona_ldo1_hc_set/get_voltage_sel" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190226120650.A20BE11284F0@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 12:06:50 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: arizona_ldo1: Simplify arizona_ldo1_hc_set/get_voltage_sel

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

From 5db2efbe115e53153aba2e02a87c62f2e78e3102 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 25 Feb 2019 17:13:49 +0800
Subject: [PATCH] regulator: arizona_ldo1: Simplify
 arizona_ldo1_hc_set/get_voltage_sel

Setup .vsel_reg and .vsel_mask then we can use the standard
set/get_voltage_sel_regmap helpers to simplify the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-ldo1.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index dfed6d3f03ad..bf3ab405eed1 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -43,8 +43,7 @@ struct arizona_ldo1 {
 static int arizona_ldo1_hc_set_voltage_sel(struct regulator_dev *rdev,
 					   unsigned sel)
 {
-	struct arizona_ldo1 *ldo = rdev_get_drvdata(rdev);
-	struct regmap *regmap = ldo->regmap;
+	struct regmap *regmap = rdev_get_regmap(rdev);
 	unsigned int val;
 	int ret;
 
@@ -61,16 +60,12 @@ static int arizona_ldo1_hc_set_voltage_sel(struct regulator_dev *rdev,
 	if (val)
 		return 0;
 
-	val = sel << ARIZONA_LDO1_VSEL_SHIFT;
-
-	return regmap_update_bits(regmap, ARIZONA_LDO1_CONTROL_1,
-				  ARIZONA_LDO1_VSEL_MASK, val);
+	return regulator_set_voltage_sel_regmap(rdev, sel);
 }
 
 static int arizona_ldo1_hc_get_voltage_sel(struct regulator_dev *rdev)
 {
-	struct arizona_ldo1 *ldo = rdev_get_drvdata(rdev);
-	struct regmap *regmap = ldo->regmap;
+	struct regmap *regmap = rdev_get_regmap(rdev);
 	unsigned int val;
 	int ret;
 
@@ -81,11 +76,7 @@ static int arizona_ldo1_hc_get_voltage_sel(struct regulator_dev *rdev)
 	if (val & ARIZONA_LDO1_HI_PWR)
 		return rdev->desc->n_voltages - 1;
 
-	ret = regmap_read(regmap, ARIZONA_LDO1_CONTROL_1, &val);
-	if (ret != 0)
-		return ret;
-
-	return (val & ARIZONA_LDO1_VSEL_MASK) >> ARIZONA_LDO1_VSEL_SHIFT;
+	return regulator_get_voltage_sel_regmap(rdev);
 }
 
 static const struct regulator_ops arizona_ldo1_hc_ops = {
@@ -108,6 +99,8 @@ static const struct regulator_desc arizona_ldo1_hc = {
 	.type = REGULATOR_VOLTAGE,
 	.ops = &arizona_ldo1_hc_ops,
 
+	.vsel_reg = ARIZONA_LDO1_CONTROL_1,
+	.vsel_mask = ARIZONA_LDO1_VSEL_MASK,
 	.bypass_reg = ARIZONA_LDO1_CONTROL_1,
 	.bypass_mask = ARIZONA_LDO1_BYPASS,
 	.linear_ranges = arizona_ldo1_hc_ranges,
-- 
2.20.1

