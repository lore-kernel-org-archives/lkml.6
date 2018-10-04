Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ED6C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D59213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="WYd6ijT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D59213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJDOSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:18:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34435 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeJDOSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:18:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id f18-v6so4720593plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=0gACsEi5SzQBmJA5YRO3DwtROkYHQJ1ztFifl7168J4=;
        b=WYd6ijT6mq49Nt0SocoYHZUnejxx4zcp1I6XIjaQnBNEVaCWlSh14wGbyaHuYmyvY2
         qdNtYHGQvZ16SzFsVp/axx8TaAy2ETGZk7MibcwqT50T0YYBT8Q2adSqYjb7gFX1TxjV
         j5OOr82M9d6RalvB70Vrd9mh7nB8AQ6/QXdhs4l+UAJt1XrDO9xbCacqX3xwwx5xD4gg
         +PK8nsXW5vw2IQZ1GYMmTlRdjx14R3R2rTPeAuFRa1yOhIJW/lTt4I7IC83+CJScNeFC
         LwQhZ0Ou3Z4kiortL5u7wLrA6/QbNhgOrV1hL+OJKbwzHlvGJTMy1BJdmefqCEFkS3cO
         ODmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0gACsEi5SzQBmJA5YRO3DwtROkYHQJ1ztFifl7168J4=;
        b=YD/Mvnp5pOcB6A6zmM2IuYYexKPrYQ/E+AzxODNx6cPSWkl6uRKW128zksMmG2Rpwu
         Yx1Ea1AzdgDmcyezfKHVXoRJINMzNf4axtF0bJM1LxwVyH0Wkz3nQqiyne8WkZa/v5fZ
         ehWDj5bwOT4f4zyWRHab+Kt6rAls1BnY+8wyi9R4oWt79d8Rtjjl6Yg56MP8+IeLYrat
         K9Av5/uIhjqrocJ0aQveqcBIJsKVk/YPNGfvDrAjisbQv7veNuBiItQsrnBYc6AgeLAn
         XD9WnmwKtnnMndDX7buqu7vqRgUhkAmkcAHnMGBPqhOywB9uXYpxBnWeysvxclHbc2kI
         tcCA==
X-Gm-Message-State: ABuFfoj5ISKENEoMRdeybZu9pKUD+iKmwUtcppTe7ekcD/STCX707xZx
        Mjawsan4c/55SIKybSc4gDluIQ==
X-Google-Smtp-Source: ACcGV60XcyW5y6eqqirDDe5i3XYaaAp2lgBDWv+CQzMR3jEzGfF19m0sCx33R18DrhjsW5D0Z5B6wA==
X-Received: by 2002:a17:902:2d24:: with SMTP id o33-v6mr5231256plb.211.1538637969412;
        Thu, 04 Oct 2018 00:26:09 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id s14-v6sm3821125pgv.29.2018.10.04.00.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 00:26:08 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v4] regulator: bd718x7: Remove struct bd718xx_pmic
Date:   Thu,  4 Oct 2018 15:25:58 +0800
Message-Id: <20181004072558.10209-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the fields in struct bd718xx_pmic are not really necessary.
Remove struct bd718xx_pmic to simplify the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
v4: Drop the pointer to struct bd718xx_pmic inside the struct bd718xx
v3: Remove the references to struct bd718xx_pmic from include/linux/mfd/rohm-bd718x7.h
v2: Correct mail subject line
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
2.17.1

