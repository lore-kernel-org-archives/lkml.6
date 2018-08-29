Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE992C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8620520850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8620520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeH2Qfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:35:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40774 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2Qfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:35:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so4222742ljc.7;
        Wed, 29 Aug 2018 05:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qYXZGd4ID+Yw+W8P3a8JlUWbWMTi+zTkmrSUJTk2IX0=;
        b=dZVjD+ZhbSv9+MbTeyxCsdsjVSzXqFlbgoUpf1i5gonMDEISVfiwL+RyNG0ijquzxR
         BN6x4n0aCmV98ssxL9L/56yuPBqztDyz9YgiFLPT4l7h4KP6SxuaeonqoUYn6i7n/jBd
         5MPUydg2SM5UIkLiVSVw2xQu4O9bdx7tqxyPPBLDeHHIXXd0eiAUAS6gXSMjoJeTxPlW
         qS+9GLTb+ZCLKOh9jIRQmk5KEBbJbi0qYiTKKXE0mBB8gkgeLNc05ZQ9zf+PnEpECMbX
         MZsj1Jcv9P0Ncrrn+DqPV1XGKrsj0qR9R9Kq3Qojn5nx/LwcI4gaOu3VC89+CcT+IRt1
         FqSA==
X-Gm-Message-State: APzg51ASWi+jr4V/DC/CigC0x1ueHXEinyVMt2eudgKZkvcFs6E0g2o6
        DlWiGr0QHM4yPl16TTwTomw=
X-Google-Smtp-Source: ANB0VdZ9Et1WdxqTSAQcAZ7aP0Ar2kW8XFeAgvn3aedMiwXJNwe4faQAUHJ8OfaijkuvZ6OskaG0pg==
X-Received: by 2002:a2e:8652:: with SMTP id i18-v6mr79423ljj.43.1535546347100;
        Wed, 29 Aug 2018 05:39:07 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y5-v6sm683516ljj.75.2018.08.29.05.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 05:39:06 -0700 (PDT)
Date:   Wed, 29 Aug 2018 15:38:54 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH 6/8] regulator/mfd: bd718xx: rename bd71837/bd71847 common
 instances
Message-ID: <1f979c0abdea658dbd4b3760fd7c50d1c6bc6da1.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename parts of code that support both BD71837 and BD71847 to BD718XX.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/mfd/rohm-bd718x7.c            | 112 +++++++++++++++++-----------------
 drivers/regulator/bd71837-regulator.c |  24 ++++----
 include/linux/mfd/rohm-bd718x7.h      |  62 +++++++++----------
 3 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index c95f34269bb6..1d0ba2309f57 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -2,9 +2,9 @@
 //
 // Copyright (C) 2018 ROHM Semiconductors
 //
-// ROHM BD71837MWV PMIC driver
+// ROHM BD71837MWV and BD71847MWV PMIC driver
 //
-// Datasheet available from
+// Datasheet for BD71837MWV available from
 // https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
 
 #include <linux/gpio_keys.h>
@@ -48,7 +48,7 @@ static struct gpio_keys_platform_data bd718xx_powerkey_data = {
 	.name = "bd718xx-pwrkey",
 };
 
-static struct mfd_cell bd71837_mfd_cells[] = {
+static struct mfd_cell bd718xx_mfd_cells[] = {
 	{
 		.name = "gpio-keys",
 		.platform_data = &bd718xx_powerkey_data,
@@ -58,20 +58,20 @@ static struct mfd_cell bd71837_mfd_cells[] = {
 	{ .name = "bd718xx-pmic", },
 };
 
-static const struct regmap_irq bd71837_irqs[] = {
-	REGMAP_IRQ_REG(BD71837_INT_SWRST, 0, BD71837_INT_SWRST_MASK),
-	REGMAP_IRQ_REG(BD71837_INT_PWRBTN_S, 0, BD71837_INT_PWRBTN_S_MASK),
-	REGMAP_IRQ_REG(BD71837_INT_PWRBTN_L, 0, BD71837_INT_PWRBTN_L_MASK),
-	REGMAP_IRQ_REG(BD71837_INT_PWRBTN, 0, BD71837_INT_PWRBTN_MASK),
-	REGMAP_IRQ_REG(BD71837_INT_WDOG, 0, BD71837_INT_WDOG_MASK),
-	REGMAP_IRQ_REG(BD71837_INT_ON_REQ, 0, BD71837_INT_ON_REQ_MASK),
-	REGMAP_IRQ_REG(BD71837_INT_STBY_REQ, 0, BD71837_INT_STBY_REQ_MASK),
+static const struct regmap_irq bd718xx_irqs[] = {
+	REGMAP_IRQ_REG(BD718XX_INT_SWRST, 0, BD718XX_INT_SWRST_MASK),
+	REGMAP_IRQ_REG(BD718XX_INT_PWRBTN_S, 0, BD718XX_INT_PWRBTN_S_MASK),
+	REGMAP_IRQ_REG(BD718XX_INT_PWRBTN_L, 0, BD718XX_INT_PWRBTN_L_MASK),
+	REGMAP_IRQ_REG(BD718XX_INT_PWRBTN, 0, BD718XX_INT_PWRBTN_MASK),
+	REGMAP_IRQ_REG(BD718XX_INT_WDOG, 0, BD718XX_INT_WDOG_MASK),
+	REGMAP_IRQ_REG(BD718XX_INT_ON_REQ, 0, BD718XX_INT_ON_REQ_MASK),
+	REGMAP_IRQ_REG(BD718XX_INT_STBY_REQ, 0, BD718XX_INT_STBY_REQ_MASK),
 };
 
-static struct regmap_irq_chip bd71837_irq_chip = {
-	.name = "bd71837-irq",
-	.irqs = bd71837_irqs,
-	.num_irqs = ARRAY_SIZE(bd71837_irqs),
+static struct regmap_irq_chip bd718xx_irq_chip = {
+	.name = "bd718xx-irq",
+	.irqs = bd718xx_irqs,
+	.num_irqs = ARRAY_SIZE(bd718xx_irqs),
 	.num_regs = 1,
 	.irq_reg_stride = 1,
 	.status_base = BD718XX_REG_IRQ,
@@ -91,7 +91,7 @@ static const struct regmap_access_table volatile_regs = {
 	.n_yes_ranges = 1,
 };
 
-static const struct regmap_config bd71837_regmap_config = {
+static const struct regmap_config bd718xx_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.volatile_table = &volatile_regs,
@@ -99,16 +99,16 @@ static const struct regmap_config bd71837_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int bd71837_i2c_probe(struct i2c_client *i2c,
+static int bd718xx_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct bd71837 *bd71837;
+	struct bd718xx *bd718xx;
 	int ret, i;
 	const unsigned int *type;
 
-	bd71837 = devm_kzalloc(&i2c->dev, sizeof(struct bd71837), GFP_KERNEL);
+	bd718xx = devm_kzalloc(&i2c->dev, sizeof(struct bd718xx), GFP_KERNEL);
 
-	if (!bd71837)
+	if (!bd718xx)
 		return -ENOMEM;
 
 	type = of_device_get_match_data(&i2c->dev);
@@ -117,50 +117,50 @@ static int bd71837_i2c_probe(struct i2c_client *i2c,
 		return -ENODEV;
 	}
 
-	bd71837->chip_irq = i2c->irq;
+	bd718xx->chip_irq = i2c->irq;
 
-	if (!bd71837->chip_irq) {
+	if (!bd718xx->chip_irq) {
 		dev_err(&i2c->dev, "No IRQ configured\n");
 		return -EINVAL;
 	}
 
-	bd71837->chip_type = *type;
-	bd71837->dev = &i2c->dev;
-	dev_set_drvdata(&i2c->dev, bd71837);
+	bd718xx->chip_type = *type;
+	bd718xx->dev = &i2c->dev;
+	dev_set_drvdata(&i2c->dev, bd718xx);
 
-	bd71837->regmap = devm_regmap_init_i2c(i2c, &bd71837_regmap_config);
-	if (IS_ERR(bd71837->regmap)) {
+	bd718xx->regmap = devm_regmap_init_i2c(i2c, &bd718xx_regmap_config);
+	if (IS_ERR(bd718xx->regmap)) {
 		dev_err(&i2c->dev, "regmap initialization failed\n");
-		return PTR_ERR(bd71837->regmap);
+		return PTR_ERR(bd718xx->regmap);
 	}
 
-	ret = regmap_read(bd71837->regmap, BD718XX_REG_REV, &bd71837->chip_rev);
+	ret = regmap_read(bd718xx->regmap, BD718XX_REG_REV, &bd718xx->chip_rev);
 	if (ret) {
 		dev_err(&i2c->dev, "Failed to read revision register\n");
 		return ret;
 	}
 	for (i = 0;
-	     i < supported_revisions[bd71837->chip_type].known_revisions; i++)
-		if ((*supported_revisions[bd71837->chip_type].revisions)[i] ==
-		    bd71837->chip_rev)
+	     i < supported_revisions[bd718xx->chip_type].known_revisions; i++)
+		if ((*supported_revisions[bd718xx->chip_type].revisions)[i] ==
+		    bd718xx->chip_rev)
 			break;
 
-	if (i == supported_revisions[bd71837->chip_type].known_revisions) {
+	if (i == supported_revisions[bd718xx->chip_type].known_revisions) {
 		dev_err(&i2c->dev, "Unrecognized revision 0x%02x\n",
-			bd71837->chip_rev);
+			bd718xx->chip_rev);
 		return -EINVAL;
 	}
 
-	ret = devm_regmap_add_irq_chip(&i2c->dev, bd71837->regmap,
-				       bd71837->chip_irq, IRQF_ONESHOT, 0,
-				       &bd71837_irq_chip, &bd71837->irq_data);
+	ret = devm_regmap_add_irq_chip(&i2c->dev, bd718xx->regmap,
+				       bd718xx->chip_irq, IRQF_ONESHOT, 0,
+				       &bd718xx_irq_chip, &bd718xx->irq_data);
 	if (ret) {
 		dev_err(&i2c->dev, "Failed to add irq_chip\n");
 		return ret;
 	}
 
 	/* Configure short press to 10 milliseconds */
-	ret = regmap_update_bits(bd71837->regmap,
+	ret = regmap_update_bits(bd718xx->regmap,
 				 BD718XX_REG_PWRONCONFIG0,
 				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
 				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
@@ -171,7 +171,7 @@ static int bd71837_i2c_probe(struct i2c_client *i2c,
 	}
 
 	/* Configure long press to 10 seconds */
-	ret = regmap_update_bits(bd71837->regmap,
+	ret = regmap_update_bits(bd718xx->regmap,
 				 BD718XX_REG_PWRONCONFIG1,
 				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
 				 BD718XX_PWRBTN_LONG_PRESS_10S);
@@ -182,7 +182,7 @@ static int bd71837_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret = regmap_irq_get_virq(bd71837->irq_data, BD71837_INT_PWRBTN_S);
+	ret = regmap_irq_get_virq(bd718xx->irq_data, BD718XX_INT_PWRBTN_S);
 
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to get the IRQ\n");
@@ -191,10 +191,10 @@ static int bd71837_i2c_probe(struct i2c_client *i2c,
 
 	button.irq = ret;
 
-	ret = devm_mfd_add_devices(bd71837->dev, PLATFORM_DEVID_AUTO,
-				   bd71837_mfd_cells,
-				   ARRAY_SIZE(bd71837_mfd_cells), NULL, 0,
-				   regmap_irq_get_domain(bd71837->irq_data));
+	ret = devm_mfd_add_devices(bd718xx->dev, PLATFORM_DEVID_AUTO,
+				   bd718xx_mfd_cells,
+				   ARRAY_SIZE(bd718xx_mfd_cells), NULL, 0,
+				   regmap_irq_get_domain(bd718xx->irq_data));
 	if (ret)
 		dev_err(&i2c->dev, "Failed to create subdevices\n");
 
@@ -205,7 +205,7 @@ static const unsigned int chip_types[] = {
 	[BD718XX_TYPE_BD71847] = BD718XX_TYPE_BD71847,
 };
 
-static const struct of_device_id bd71837_of_match[] = {
+static const struct of_device_id bd718xx_of_match[] = {
 	{
 		.compatible = "rohm,bd71837",
 		.data = &chip_types[BD718XX_TYPE_BD71837]
@@ -216,30 +216,30 @@ static const struct of_device_id bd71837_of_match[] = {
 	},
 	{ }
 };
-MODULE_DEVICE_TABLE(of, bd71837_of_match);
+MODULE_DEVICE_TABLE(of, bd718xx_of_match);
 
-static struct i2c_driver bd71837_i2c_driver = {
+static struct i2c_driver bd718xx_i2c_driver = {
 	.driver = {
 		.name = "rohm-bd718x7",
-		.of_match_table = bd71837_of_match,
+		.of_match_table = bd718xx_of_match,
 	},
-	.probe = bd71837_i2c_probe,
+	.probe = bd718xx_i2c_probe,
 };
 
-static int __init bd71837_i2c_init(void)
+static int __init bd718xx_i2c_init(void)
 {
-	return i2c_add_driver(&bd71837_i2c_driver);
+	return i2c_add_driver(&bd718xx_i2c_driver);
 }
 
 /* Initialise early so consumer devices can complete system boot */
-subsys_initcall(bd71837_i2c_init);
+subsys_initcall(bd718xx_i2c_init);
 
-static void __exit bd71837_i2c_exit(void)
+static void __exit bd718xx_i2c_exit(void)
 {
-	i2c_del_driver(&bd71837_i2c_driver);
+	i2c_del_driver(&bd718xx_i2c_driver);
 }
-module_exit(bd71837_i2c_exit);
+module_exit(bd718xx_i2c_exit);
 
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("ROHM BD71837 Power Management IC driver");
+MODULE_DESCRIPTION("ROHM BD71837/BD71847 Power Management IC driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 49f75258aa20..4780c92db49a 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2018 ROHM Semiconductors
-// bd71837-regulator.c ROHM BD71837MWV regulator driver
+// bd71837-regulator.c ROHM BD71837MWV/BD71847MWV regulator driver
 
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -17,7 +17,7 @@
 
 struct bd718xx_pmic {
 	struct bd718xx_regulator_data *rdata;
-	struct bd71837 *mfd;
+	struct bd718xx *mfd;
 	struct platform_device *pdev;
 	struct regulator_dev *rdev[BD718XX_REGULATOR_MAX];
 };
@@ -30,11 +30,11 @@ struct bd718xx_pmic {
  * 10: 2.50mV/usec	10mV 4uS
  * 11: 1.25mV/usec	10mV 8uS
  */
-static int bd71837_buck1234_set_ramp_delay(struct regulator_dev *rdev,
+static int bd718xx_buck1234_set_ramp_delay(struct regulator_dev *rdev,
 					   int ramp_delay)
 {
 	struct bd718xx_pmic *pmic = rdev_get_drvdata(rdev);
-	struct bd71837 *mfd = pmic->mfd;
+	struct bd718xx *mfd = pmic->mfd;
 	int id = rdev->desc->id;
 	unsigned int ramp_value = BUCK_RAMPRATE_10P00MV;
 
@@ -124,7 +124,7 @@ static struct regulator_ops bd718xx_dvs_buck_regulator_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-	.set_ramp_delay = bd71837_buck1234_set_ramp_delay,
+	.set_ramp_delay = bd718xx_buck1234_set_ramp_delay,
 };
 
 /*
@@ -404,7 +404,7 @@ static const struct bd718xx_regulator_data bd71847_regulators[] = {
 			.id = BD718XX_BUCK6,
 			.ops = &bd718xx_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
-			.n_voltages = BD71837_4TH_NODVS_BUCK_VOLTAGE_NUM,
+			.n_voltages = BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_4th_nodvs_buck_volts,
 			.n_linear_ranges =
 				ARRAY_SIZE(bd718xx_4th_nodvs_buck_volts),
@@ -732,7 +732,7 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 			.id = BD718XX_BUCK8,
 			.ops = &bd718xx_buck_regulator_ops,
 			.type = REGULATOR_VOLTAGE,
-			.n_voltages = BD71837_4TH_NODVS_BUCK_VOLTAGE_NUM,
+			.n_voltages = BD718XX_4TH_NODVS_BUCK_VOLTAGE_NUM,
 			.linear_ranges = bd718xx_4th_nodvs_buck_volts,
 			.n_linear_ranges =
 				ARRAY_SIZE(bd718xx_4th_nodvs_buck_volts),
@@ -923,7 +923,7 @@ struct bd718xx_pmic_inits {
 	unsigned int r_amount;
 };
 
-static int bd71837_probe(struct platform_device *pdev)
+static int bd718xx_probe(struct platform_device *pdev)
 {
 	struct bd718xx_pmic *pmic;
 	struct regulator_config config = { 0 };
@@ -1027,15 +1027,15 @@ static int bd71837_probe(struct platform_device *pdev)
 	return err;
 }
 
-static struct platform_driver bd71837_regulator = {
+static struct platform_driver bd718xx_regulator = {
 	.driver = {
 		.name = "bd718xx-pmic",
 	},
-	.probe = bd71837_probe,
+	.probe = bd718xx_probe,
 };
 
-module_platform_driver(bd71837_regulator);
+module_platform_driver(bd718xx_regulator);
 
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD71837 voltage regulator driver");
+MODULE_DESCRIPTION("BD71837/BD71847 voltage regulator driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
index d1ed232e669e..d1730b97ba52 100644
--- a/include/linux/mfd/rohm-bd718x7.h
+++ b/include/linux/mfd/rohm-bd718x7.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /* Copyright (C) 2018 ROHM Semiconductors */
 
-#ifndef __LINUX_MFD_BD71837_H__
-#define __LINUX_MFD_BD71837_H__
+#ifndef __LINUX_MFD_BD718XX_H__
+#define __LINUX_MFD_BD718XX_H__
 
 #include <linux/regmap.h>
 
@@ -183,7 +183,7 @@ enum {
 #define BD71837_BUCK4_VRMON130          0x80
 #define BD71837_LDO7_VRMON80            0x40
 
-/* BD71837_REG_IRQ bits */
+/* BD718XX_REG_IRQ bits */
 #define IRQ_SWRST		0x40
 #define IRQ_PWRON_S		0x20
 #define IRQ_PWRON_L		0x10
@@ -192,31 +192,31 @@ enum {
 #define IRQ_ON_REQ		0x02
 #define IRQ_STBY_REQ		0x01
 
-/* BD71837_REG_OUT32K bits */
-#define BD71837_OUT32K_EN	0x01
+/* BD718XX_REG_OUT32K bits */
+#define BD718XX_OUT32K_EN	0x01
 
-/* BD71837 gated clock rate */
-#define BD71837_CLK_RATE 32768
+/* BD7183XX gated clock rate */
+#define BD718XX_CLK_RATE 32768
 
-/* ROHM BD71837 irqs */
+/* ROHM BD718XX irqs */
 enum {
-	BD71837_INT_STBY_REQ,
-	BD71837_INT_ON_REQ,
-	BD71837_INT_WDOG,
-	BD71837_INT_PWRBTN,
-	BD71837_INT_PWRBTN_L,
-	BD71837_INT_PWRBTN_S,
-	BD71837_INT_SWRST
+	BD718XX_INT_STBY_REQ,
+	BD718XX_INT_ON_REQ,
+	BD718XX_INT_WDOG,
+	BD718XX_INT_PWRBTN,
+	BD718XX_INT_PWRBTN_L,
+	BD718XX_INT_PWRBTN_S,
+	BD718XX_INT_SWRST
 };
 
-/* ROHM BD71837 interrupt masks */
-#define BD71837_INT_SWRST_MASK		0x40
-#define BD71837_INT_PWRBTN_S_MASK	0x20
-#define BD71837_INT_PWRBTN_L_MASK	0x10
-#define BD71837_INT_PWRBTN_MASK		0x8
-#define BD71837_INT_WDOG_MASK		0x4
-#define BD71837_INT_ON_REQ_MASK		0x2
-#define BD71837_INT_STBY_REQ_MASK	0x1
+/* ROHM BD718XX interrupt masks */
+#define BD718XX_INT_SWRST_MASK		0x40
+#define BD718XX_INT_PWRBTN_S_MASK	0x20
+#define BD718XX_INT_PWRBTN_L_MASK	0x10
+#define BD718XX_INT_PWRBTN_MASK		0x8
+#define BD718XX_INT_WDOG_MASK		0x4
+#define BD718XX_INT_ON_REQ_MASK		0x2
+#define BD718XX_INT_STBY_REQ_MASK	0x1
 
 /* Register write induced reset settings */
 
@@ -226,13 +226,13 @@ enum {
  * write 1 to it we will trigger the action. So always write 0 to it when
  * changning SWRESET action - no matter what we read from it.
  */
-#define BD71837_SWRESET_TYPE_MASK	7
-#define BD71837_SWRESET_TYPE_DISABLED	0
-#define BD71837_SWRESET_TYPE_COLD	4
-#define BD71837_SWRESET_TYPE_WARM	6
+#define BD718XX_SWRESET_TYPE_MASK	7
+#define BD718XX_SWRESET_TYPE_DISABLED	0
+#define BD718XX_SWRESET_TYPE_COLD	4
+#define BD718XX_SWRESET_TYPE_WARM	6
 
-#define BD71837_SWRESET_RESET_MASK	1
-#define BD71837_SWRESET_RESET		1
+#define BD718XX_SWRESET_RESET_MASK	1
+#define BD718XX_SWRESET_RESET		1
 
 /* Poweroff state transition conditions */
 
@@ -320,7 +320,7 @@ enum {
 struct bd718xx_pmic;
 struct bd718xx_clk;
 
-struct bd71837 {
+struct bd718xx {
 	unsigned int chip_type;
 	unsigned int chip_rev;
 	struct device *dev;
@@ -334,4 +334,4 @@ struct bd71837 {
 	struct bd718xx_clk *clk;
 };
 
-#endif /* __LINUX_MFD_BD71837_H__ */
+#endif /* __LINUX_MFD_BD718XX_H__ */
-- 
2.14.3

