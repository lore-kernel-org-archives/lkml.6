Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B9BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C184B2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WBahQy/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C184B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeJSUfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:35:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43912 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSUfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9NfnbJzx6hqcMB0vqyMSMQijHRMIMnezZtKr84yeW18=; b=WBahQy/3YWMx
        c4a7PJJ7jiHxbNafwlGg1tF3x163lx26x6HzBSqYTS8IOTfpOLhbQma0tW/wmJP2DqT8KUIMyN9MR
        nYjD2CKWbbNqDd2Shfu9pRluo8JTPMukcJ5iz2QWybZQSIpglEWCcELxcKilMdXreEQm+/5eysOM8
        lZHH0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTuK-0008WR-IA; Fri, 19 Oct 2018 12:29:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 445E11122548; Fri, 19 Oct 2018 13:29:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd718x7: Remove struct bd718xx_pmic" to the regulator tree
In-Reply-To: 
Message-Id: <20181019122936.445E11122548@debutante.sirena.org.uk>
Date:   Fri, 19 Oct 2018 13:29:36 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd718x7: Remove struct bd718xx_pmic

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

From bcb047ebf28453da56f0265aeeb9edc52b797ea7 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 4 Oct 2018 15:25:58 +0800
Subject: [PATCH] regulator: bd718x7: Remove struct bd718xx_pmic

All the fields in struct bd718xx_pmic are not really necessary.
Remove struct bd718xx_pmic to simplify the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd718x7-regulator.c | 59 +++++++++------------------
 include/linux/mfd/rohm-bd718x7.h      |  2 -
 2 files changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index d2522d4e1505..3a47e0372e77 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -15,13 +15,6 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/slab.h>
 
-struct bd718xx_pmic {
-	struct bd718xx_regulator_data *rdata;
-	struct bd718xx *mfd;
-	struct platform_device *pdev;
-	struct regulator_dev *rdev[BD718XX_REGULATOR_AMOUNT];
-};
-
 /*
  * BUCK1/2/3/4
  * BUCK1RAMPRATE[1:0] BUCK1 DVS ramp rate setting
@@ -33,12 +26,10 @@ struct bd718xx_pmic {
 static int bd718xx_buck1234_set_ramp_delay(struct regulator_dev *rdev,
 					   int ramp_delay)
 {
-	struct bd718xx_pmic *pmic = rdev_get_drvdata(rdev);
-	struct bd718xx *mfd = pmic->mfd;
 	int id = rdev->desc->id;
 	unsigned int ramp_value = BUCK_RAMPRATE_10P00MV;
 
-	dev_dbg(&pmic->pdev->dev, "Buck[%d] Set Ramp = %d\n", id + 1,
+	dev_dbg(&rdev->dev, "Buck[%d] Set Ramp = %d\n", id + 1,
 		ramp_delay);
 	switch (ramp_delay) {
 	case 1 ... 1250:
@@ -55,12 +46,12 @@ static int bd718xx_buck1234_set_ramp_delay(struct regulator_dev *rdev,
 		break;
 	default:
 		ramp_value = BUCK_RAMPRATE_10P00MV;
-		dev_err(&pmic->pdev->dev,
+		dev_err(&rdev->dev,
 			"%s: ramp_delay: %d not supported, setting 10000mV//us\n",
 			rdev->desc->name, ramp_delay);
 	}
 
-	return regmap_update_bits(mfd->regmap, BD718XX_REG_BUCK1_CTRL + id,
+	return regmap_update_bits(rdev->regmap, BD718XX_REG_BUCK1_CTRL + id,
 				  BUCK_RAMPRATE_MASK, ramp_value << 6);
 }
 
@@ -1022,7 +1013,7 @@ struct bd718xx_pmic_inits {
 
 static int bd718xx_probe(struct platform_device *pdev)
 {
-	struct bd718xx_pmic *pmic;
+	struct bd718xx *mfd;
 	struct regulator_config config = { 0 };
 	struct bd718xx_pmic_inits pmic_regulators[] = {
 		[BD718XX_TYPE_BD71837] = {
@@ -1037,54 +1028,46 @@ static int bd718xx_probe(struct platform_device *pdev)
 
 	int i, j, err;
 
-	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
-	if (!pmic)
-		return -ENOMEM;
-
-	pmic->pdev = pdev;
-	pmic->mfd = dev_get_drvdata(pdev->dev.parent);
-
-	if (!pmic->mfd) {
+	mfd = dev_get_drvdata(pdev->dev.parent);
+	if (!mfd) {
 		dev_err(&pdev->dev, "No MFD driver data\n");
 		err = -EINVAL;
 		goto err;
 	}
-	if (pmic->mfd->chip_type >= BD718XX_TYPE_AMOUNT ||
-	    !pmic_regulators[pmic->mfd->chip_type].r_datas) {
+
+	if (mfd->chip_type >= BD718XX_TYPE_AMOUNT ||
+	    !pmic_regulators[mfd->chip_type].r_datas) {
 		dev_err(&pdev->dev, "Unsupported chip type\n");
 		err = -EINVAL;
 		goto err;
 	}
 
-	platform_set_drvdata(pdev, pmic);
-
 	/* Register LOCK release */
-	err = regmap_update_bits(pmic->mfd->regmap, BD718XX_REG_REGLOCK,
+	err = regmap_update_bits(mfd->regmap, BD718XX_REG_REGLOCK,
 				 (REGLOCK_PWRSEQ | REGLOCK_VREG), 0);
 	if (err) {
-		dev_err(&pmic->pdev->dev, "Failed to unlock PMIC (%d)\n", err);
+		dev_err(&pdev->dev, "Failed to unlock PMIC (%d)\n", err);
 		goto err;
 	} else {
-		dev_dbg(&pmic->pdev->dev, "Unlocked lock register 0x%x\n",
+		dev_dbg(&pdev->dev, "Unlocked lock register 0x%x\n",
 			BD718XX_REG_REGLOCK);
 	}
 
-	for (i = 0; i < pmic_regulators[pmic->mfd->chip_type].r_amount; i++) {
+	for (i = 0; i < pmic_regulators[mfd->chip_type].r_amount; i++) {
 
 		const struct regulator_desc *desc;
 		struct regulator_dev *rdev;
 		const struct bd718xx_regulator_data *r;
 
-		r = &(*pmic_regulators[pmic->mfd->chip_type].r_datas)[i];
+		r = &(*pmic_regulators[mfd->chip_type].r_datas)[i];
 		desc = &r->desc;
 
 		config.dev = pdev->dev.parent;
-		config.driver_data = pmic;
-		config.regmap = pmic->mfd->regmap;
+		config.regmap = mfd->regmap;
 
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
-			dev_err(pmic->mfd->dev,
+			dev_err(&pdev->dev,
 				"failed to register %s regulator\n",
 				desc->name);
 			err = PTR_ERR(rdev);
@@ -1096,28 +1079,26 @@ static int bd718xx_probe(struct platform_device *pdev)
 		 * can now switch the control from PMIC state machine to the
 		 * register interface
 		 */
-		err = regmap_update_bits(pmic->mfd->regmap, r->init.reg,
+		err = regmap_update_bits(mfd->regmap, r->init.reg,
 					 r->init.mask, r->init.val);
 		if (err) {
-			dev_err(&pmic->pdev->dev,
+			dev_err(&pdev->dev,
 				"Failed to write BUCK/LDO SEL bit for (%s)\n",
 				desc->name);
 			goto err;
 		}
 		for (j = 0; j < r->additional_init_amnt; j++) {
-			err = regmap_update_bits(pmic->mfd->regmap,
+			err = regmap_update_bits(mfd->regmap,
 						 r->additional_inits[j].reg,
 						 r->additional_inits[j].mask,
 						 r->additional_inits[j].val);
 			if (err) {
-				dev_err(&pmic->pdev->dev,
+				dev_err(&pdev->dev,
 					"Buck (%s) initialization failed\n",
 					desc->name);
 				goto err;
 			}
 		}
-
-		pmic->rdev[i] = rdev;
 	}
 
 err:
diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
index 26acf9a92498..fd194bfc836f 100644
--- a/include/linux/mfd/rohm-bd718x7.h
+++ b/include/linux/mfd/rohm-bd718x7.h
@@ -321,7 +321,6 @@ enum {
 	BD718XX_PWRBTN_LONG_PRESS_15S
 };
 
-struct bd718xx_pmic;
 struct bd718xx_clk;
 
 struct bd718xx {
@@ -333,7 +332,6 @@ struct bd718xx {
 	int chip_irq;
 	struct regmap_irq_chip_data *irq_data;
 
-	struct bd718xx_pmic *pmic;
 	struct bd718xx_clk *clk;
 };
 
-- 
2.19.0.rc2

