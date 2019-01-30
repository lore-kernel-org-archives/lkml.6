Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D357CC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD132087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfA3JH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:07:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40046 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3JH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:07:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so16794371lfe.7;
        Wed, 30 Jan 2019 01:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HR1o3sBwR/+ciyVwBzAQbIdfCuQpEwUZq5F1y9sU/7M=;
        b=QALN9DYRBMXa/jqMV7yFA25hcjRO4jGvmUaeDvzim3V0HLWCZ10mYKCM+JF/9yUUcL
         +eytZNRQjibk6VUNUoiZAVfUe6Cg+AEyHBmw4jRGFHvAmnZxTRegbHyCblZiADZkN0X8
         trdADK2EWaXXz6qzR17NZKqYKTkiRs14/V/N+sI6tO46SzLdveoVRe/6yU/gNb3LPnFS
         CcVZ6QdhT/MIYkUxYyjDVHANyE0AcB9YeRlURHPse9P8+1arxt9Be/5loqChz3sdynIq
         j4FJXlr6VFvxxx20LK9XPu43KSm9cW8xRgVQejmn9PBRqgFI8e5NmFrcHxsEXMiQe1kn
         y0ZA==
X-Gm-Message-State: AJcUukc8FzJzMnHArtjTIkYc0/9kfeuGxqaGxLdd41/Jq3HShMcKW2q5
        PpxOLBe+8udgDv8eR5ksy6g=
X-Google-Smtp-Source: ALg8bN57JUcxIm/s2epB2oAtTPTVLXZ5s9r+53hG2JbrIk1ZPX9DKjc1nAjvv6hRoMV/365R8cR6dA==
X-Received: by 2002:a19:3809:: with SMTP id f9mr23033684lfa.148.1548839273285;
        Wed, 30 Jan 2019 01:07:53 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id z6sm177563lfa.87.2019.01.30.01.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 01:07:52 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:07:39 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH v3 02/10] regulator: bd718x7 use chip specific and
 generic data structs
Message-ID: <5c58562b069b8b09ae44b344bb20252ed385993b.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Header rohm-bd718x7.h was split to generic and component specific
parts. This changed the struct bd718x7. Adapt the regulator driver to
these changes.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd718x7-regulator.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index ccea133778c8..9109920b4a06 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1018,11 +1018,11 @@ static int bd718xx_probe(struct platform_device *pdev)
 	struct bd718xx *mfd;
 	struct regulator_config config = { 0 };
 	struct bd718xx_pmic_inits pmic_regulators[] = {
-		[BD718XX_TYPE_BD71837] = {
+		[ROHM_CHIP_TYPE_BD71837] = {
 			.r_datas = bd71837_regulators,
 			.r_amount = ARRAY_SIZE(bd71837_regulators),
 		},
-		[BD718XX_TYPE_BD71847] = {
+		[ROHM_CHIP_TYPE_BD71847] = {
 			.r_datas = bd71847_regulators,
 			.r_amount = ARRAY_SIZE(bd71847_regulators),
 		},
@@ -1037,15 +1037,15 @@ static int bd718xx_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	if (mfd->chip_type >= BD718XX_TYPE_AMOUNT ||
-	    !pmic_regulators[mfd->chip_type].r_datas) {
+	if (mfd->chip.chip_type >= ROHM_CHIP_TYPE_AMOUNT ||
+	    !pmic_regulators[mfd->chip.chip_type].r_datas) {
 		dev_err(&pdev->dev, "Unsupported chip type\n");
 		err = -EINVAL;
 		goto err;
 	}
 
 	/* Register LOCK release */
-	err = regmap_update_bits(mfd->regmap, BD718XX_REG_REGLOCK,
+	err = regmap_update_bits(mfd->chip.regmap, BD718XX_REG_REGLOCK,
 				 (REGLOCK_PWRSEQ | REGLOCK_VREG), 0);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to unlock PMIC (%d)\n", err);
@@ -1065,7 +1065,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 	 * for all reset types because OTP loading at READY will clear SEL
 	 * bit allowing HW defaults for power rails to be used
 	 */
-	err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
+	err = regmap_update_bits(mfd->chip.regmap, BD718XX_REG_TRANS_COND1,
 				 BD718XX_ON_REQ_POWEROFF_MASK |
 				 BD718XX_SWRESET_POWEROFF_MASK |
 				 BD718XX_WDOG_POWEROFF_MASK |
@@ -1078,17 +1078,17 @@ static int bd718xx_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "Changed all resets from SVNS to READY\n");
 	}
 
-	for (i = 0; i < pmic_regulators[mfd->chip_type].r_amount; i++) {
+	for (i = 0; i < pmic_regulators[mfd->chip.chip_type].r_amount; i++) {
 
 		const struct regulator_desc *desc;
 		struct regulator_dev *rdev;
 		const struct bd718xx_regulator_data *r;
 
-		r = &pmic_regulators[mfd->chip_type].r_datas[i];
+		r = &pmic_regulators[mfd->chip.chip_type].r_datas[i];
 		desc = &r->desc;
 
 		config.dev = pdev->dev.parent;
-		config.regmap = mfd->regmap;
+		config.regmap = mfd->chip.regmap;
 
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
@@ -1104,7 +1104,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 		 * can now switch the control from PMIC state machine to the
 		 * register interface
 		 */
-		err = regmap_update_bits(mfd->regmap, r->init.reg,
+		err = regmap_update_bits(mfd->chip.regmap, r->init.reg,
 					 r->init.mask, r->init.val);
 		if (err) {
 			dev_err(&pdev->dev,
@@ -1113,7 +1113,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 			goto err;
 		}
 		for (j = 0; j < r->additional_init_amnt; j++) {
-			err = regmap_update_bits(mfd->regmap,
+			err = regmap_update_bits(mfd->chip.regmap,
 						 r->additional_inits[j].reg,
 						 r->additional_inits[j].mask,
 						 r->additional_inits[j].val);
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
