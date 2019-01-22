Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D39C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B43217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548188829;
	bh=9RDXHb70pmGJqGXfFWUZ8MVyTvzv2Z3nrJ6Hh4MJ7DQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gwOiUmAalTD4ulc0rxJX4vCNENE56UznjF5Z0Qlnt5hb6JRTAJNee9YokbnARQk48
	 X48+Fdr33KMn1rfWny2rCZ9x8YMxDtg4jpNIc8X1o0riw0jF82XKPnLzmrjyzPIczs
	 4hut3ur3bEdbV+b2K1PNZI8yn6yqIWPHceI0XIP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfAVU1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:27:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53096 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVU1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=m3RlphaRG/2B2jcugXLoZt/JuViV3K6XWXvzHNZx23g=; b=CXYQaks+xZv2
        Vf9PUeCiUgUfMHIbzYPi8MJr3z25hkxANGIWQZD+uVT6dyq8jlGP4s2UenUo+2cb4m6Sk0e153qQs
        unYz01htHYGqL7v4TZ8Mwd1lYSS78kDfQ3ZT2vCg/eIP/1mfxFfvOyWStN6EJu6Y0Mctg8B+rkXVI
        5X1HI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gm2dQ-0007DF-Ca; Tue, 22 Jan 2019 20:27:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0A8C51127955; Tue, 22 Jan 2019 20:27:00 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: arizona-ldo1: Convert to use regulator_linear_range for ldo1_hc" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190122202700.0A8C51127955@debutante.sirena.org.uk>
Date:   Tue, 22 Jan 2019 20:27:00 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: arizona-ldo1: Convert to use regulator_linear_range for ldo1_hc

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

From 37b9ef9c777538db2c024ae934fd0ac73ad48b13 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jan 2019 20:36:36 +0800
Subject: [PATCH] regulator: arizona-ldo1: Convert to use
 regulator_linear_range for ldo1_hc

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-ldo1.c | 37 ++++++++------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index b9a93049e41e..dfed6d3f03ad 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -40,30 +40,6 @@ struct arizona_ldo1 {
 	struct gpio_desc *ena_gpiod;
 };
 
-static int arizona_ldo1_hc_list_voltage(struct regulator_dev *rdev,
-					unsigned int selector)
-{
-	if (selector >= rdev->desc->n_voltages)
-		return -EINVAL;
-
-	if (selector == rdev->desc->n_voltages - 1)
-		return 1800000;
-	else
-		return rdev->desc->min_uV + (rdev->desc->uV_step * selector);
-}
-
-static int arizona_ldo1_hc_map_voltage(struct regulator_dev *rdev,
-				       int min_uV, int max_uV)
-{
-	int sel;
-
-	sel = DIV_ROUND_UP(min_uV - rdev->desc->min_uV, rdev->desc->uV_step);
-	if (sel >= rdev->desc->n_voltages)
-		sel = rdev->desc->n_voltages - 1;
-
-	return sel;
-}
-
 static int arizona_ldo1_hc_set_voltage_sel(struct regulator_dev *rdev,
 					   unsigned sel)
 {
@@ -113,14 +89,19 @@ static int arizona_ldo1_hc_get_voltage_sel(struct regulator_dev *rdev)
 }
 
 static const struct regulator_ops arizona_ldo1_hc_ops = {
-	.list_voltage = arizona_ldo1_hc_list_voltage,
-	.map_voltage = arizona_ldo1_hc_map_voltage,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
 	.get_voltage_sel = arizona_ldo1_hc_get_voltage_sel,
 	.set_voltage_sel = arizona_ldo1_hc_set_voltage_sel,
 	.get_bypass = regulator_get_bypass_regmap,
 	.set_bypass = regulator_set_bypass_regmap,
 };
 
+static const struct regulator_linear_range arizona_ldo1_hc_ranges[] = {
+	REGULATOR_LINEAR_RANGE(900000, 0, 0x6, 50000),
+	REGULATOR_LINEAR_RANGE(1800000, 0x7, 0x7, 0),
+};
+
 static const struct regulator_desc arizona_ldo1_hc = {
 	.name = "LDO1",
 	.supply_name = "LDOVDD",
@@ -129,8 +110,8 @@ static const struct regulator_desc arizona_ldo1_hc = {
 
 	.bypass_reg = ARIZONA_LDO1_CONTROL_1,
 	.bypass_mask = ARIZONA_LDO1_BYPASS,
-	.min_uV = 900000,
-	.uV_step = 50000,
+	.linear_ranges = arizona_ldo1_hc_ranges,
+	.n_linear_ranges = ARRAY_SIZE(arizona_ldo1_hc_ranges),
 	.n_voltages = 8,
 	.enable_time = 1500,
 	.ramp_delay = 24000,
-- 
2.20.1

