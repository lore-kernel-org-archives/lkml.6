Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAECC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4434921470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Cmyj2H03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4434921470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJCWVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:21:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44484 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:21:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id r9-v6so1711884pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jVQbz2YLw6PNki+rWbeA49WUzAGYYdXmlsEoCqpvzjM=;
        b=Cmyj2H03XWTRk+GrYoV7/sWuAAsR0+UKuIymViV4sm18YC3f9s58POwlnKx6sp9Y/r
         MzeU3u2N6jQBT3lNiTN+b2H+qO8ld1aSeUTbQ4P+yKVKEuQJ8iJzXOYrhwZLYulEUlNw
         hJaEQu/u1BUCKFBXJgf4QmjYT0bFDvRaI3UfaOLPaDfAlBkv7ZgC/kfTyVCRrcq8UaMj
         4UsCMFcCtHerIw3TfOZWpx94mU9xoAGqwYKqEVZu6/ak3YchXi4sVGyBt06Mrs9IfYZD
         MXcqLJDW/cZsUyubhF5DYHGfGBxq5gL4sJ3M30/DV25XkZWvzEU0dDHF49g2isorb30F
         TESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jVQbz2YLw6PNki+rWbeA49WUzAGYYdXmlsEoCqpvzjM=;
        b=G5IG5GjE71YljXzCf/4vnWA85XLOFnV2QSxMOmNnI1zI9/xIaCpY4BkIBB9KxV0JHY
         KjwVPCtMzVSsDNkbpgelQcQZOf3AElQtdgJQwZqEPDrV9O3bpZBJ2a5e3g+sxxsvzTH9
         x3s9f2gU+iO5ECGXsg8HaWyxsw2kqsyjRTuaEN9tv/EpHLkppSH0tdHZw0CqKUxVP94t
         kU8UV7E4NoqrnUe1zyfB8iQz8MzLQyVreL+Xk7u4+WDrOgH4yJsRRCD+lJ1sNce2Ea07
         lZRuf/xOX9cw4LGS9ofdOBIcA2/k8FkAJX7bOCnWHvoT8hWlZWM/9LH04dtgEbQMRSQz
         TK+Q==
X-Gm-Message-State: ABuFfojgzSeEdJzc3iCYUQ6wxcU+fsBUYxlcwLacxtz6W8b0Tsl/EjEj
        arOeVYAU8fiWerFhRUe/zjXXrg==
X-Google-Smtp-Source: ACcGV63wtHSr5yTynxmeN9iVR5qBH3EH9ruYvDELcCptJAUt/if3T6k/dwGo9YvLCJjJpMrmsufATA==
X-Received: by 2002:a65:5cc3:: with SMTP id b3-v6mr1844484pgt.277.1538580776562;
        Wed, 03 Oct 2018 08:32:56 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id q21-v6sm8924468pfq.51.2018.10.03.08.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:32:55 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] regulator: bd718x7: Remove struct bd718xx_pmic
Date:   Wed,  3 Oct 2018 23:32:46 +0800
Message-Id: <20181003153246.26756-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the fields in struct bd718xx_pmic are not really necessary.
Remove struct bd718xx_pmic to simplify the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2:
Sorry, just update the subject line.

 drivers/regulator/bd718x7-regulator.c | 59 +++++++++------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

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
-- 
2.17.1

