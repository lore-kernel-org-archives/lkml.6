Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D02C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D66217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Wkt0jHHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfBITXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:23:45 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42276 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfBITXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 14:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549740221; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oVmTa5wwgMdjtrB6BDHcCwUsHUwPkCGP3/NcjUpvTmk=;
        b=Wkt0jHHNviMK3eQYmZlRkW0gZNOw5+uZh7qKJfl+DfAb8dKRWIDZ4nTbZCTFu60pb0FuEG
        /K3c2BpG0GUxdjumHYYmCeCfDEVHPqOEiy2AixGtf1OW3CjpTSK66s3q9v8wu+1Zc6PMeo
        RTN0hvsqaDVAjlufs00fpKgfIcicyxM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 5/9] mtd: rawnand: ingenic: Rename jz4780_nand driver to ingenic_nand
Date:   Sat,  9 Feb 2019 16:23:01 -0300
Message-Id: <20190209192305.4434-5-paul@crapouillou.net>
In-Reply-To: <20190209192305.4434-1-paul@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jz4780_nand driver will be modified to handle all the Ingenic
JZ47xx SoCs that the upstream Linux kernel supports (JZ4740, JZ4725B,
JZ4770, JZ4780), so it makes sense to rename it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

v3: New patch

v4: No changes

 drivers/mtd/nand/raw/ingenic/Makefile              |   2 +-
 .../raw/ingenic/{jz4780_nand.c => ingenic_nand.c}  | 146 ++++++++++-----------
 2 files changed, 74 insertions(+), 74 deletions(-)
 rename drivers/mtd/nand/raw/ingenic/{jz4780_nand.c => ingenic_nand.c} (63%)

diff --git a/drivers/mtd/nand/raw/ingenic/Makefile b/drivers/mtd/nand/raw/ingenic/Makefile
index 44c2ca053d24..af2d5de21f60 100644
--- a/drivers/mtd/nand/raw/ingenic/Makefile
+++ b/drivers/mtd/nand/raw/ingenic/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_MTD_NAND_JZ4740) += jz4740_nand.o
-obj-$(CONFIG_MTD_NAND_JZ4780) += jz4780_nand.o jz4780_bch.o
+obj-$(CONFIG_MTD_NAND_JZ4780) += ingenic_nand.o jz4780_bch.o
diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
similarity index 63%
rename from drivers/mtd/nand/raw/ingenic/jz4780_nand.c
rename to drivers/mtd/nand/raw/ingenic/ingenic_nand.c
index 7f55358b860f..8c73f7c5be9a 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * JZ4780 NAND driver
+ * Ingenic JZ47xx NAND driver
  *
  * Copyright (c) 2015 Imagination Technologies
  * Author: Alex Smith <alex.smith@imgtec.com>
@@ -24,7 +24,7 @@
 
 #include "jz4780_bch.h"
 
-#define DRV_NAME	"jz4780-nand"
+#define DRV_NAME	"ingenic-nand"
 
 #define OFFSET_DATA	0x00000000
 #define OFFSET_CMD	0x00400000
@@ -33,22 +33,22 @@
 /* Command delay when there is no R/B pin. */
 #define RB_DELAY_US	100
 
-struct jz4780_nand_cs {
+struct ingenic_nand_cs {
 	unsigned int bank;
 	void __iomem *base;
 };
 
-struct jz4780_nand_controller {
+struct ingenic_nfc {
 	struct device *dev;
 	struct jz4780_bch *bch;
 	struct nand_controller controller;
 	unsigned int num_banks;
 	struct list_head chips;
 	int selected;
-	struct jz4780_nand_cs cs[];
+	struct ingenic_nand_cs cs[];
 };
 
-struct jz4780_nand_chip {
+struct ingenic_nand {
 	struct nand_chip chip;
 	struct list_head chip_list;
 
@@ -57,22 +57,21 @@ struct jz4780_nand_chip {
 	unsigned int reading: 1;
 };
 
-static inline struct jz4780_nand_chip *to_jz4780_nand_chip(struct mtd_info *mtd)
+static inline struct ingenic_nand *to_ingenic_nand(struct mtd_info *mtd)
 {
-	return container_of(mtd_to_nand(mtd), struct jz4780_nand_chip, chip);
+	return container_of(mtd_to_nand(mtd), struct ingenic_nand, chip);
 }
 
-static inline struct jz4780_nand_controller
-*to_jz4780_nand_controller(struct nand_controller *ctrl)
+static inline struct ingenic_nfc *to_ingenic_nfc(struct nand_controller *ctrl)
 {
-	return container_of(ctrl, struct jz4780_nand_controller, controller);
+	return container_of(ctrl, struct ingenic_nfc, controller);
 }
 
-static void jz4780_nand_select_chip(struct nand_chip *chip, int chipnr)
+static void ingenic_nand_select_chip(struct nand_chip *chip, int chipnr)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
-	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(nand->chip.controller);
-	struct jz4780_nand_cs *cs;
+	struct ingenic_nand *nand = to_ingenic_nand(nand_to_mtd(chip));
+	struct ingenic_nfc *nfc = to_ingenic_nfc(nand->chip.controller);
+	struct ingenic_nand_cs *cs;
 
 	/* Ensure the currently selected chip is deasserted. */
 	if (chipnr == -1 && nfc->selected >= 0) {
@@ -83,12 +82,12 @@ static void jz4780_nand_select_chip(struct nand_chip *chip, int chipnr)
 	nfc->selected = chipnr;
 }
 
-static void jz4780_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
-				 unsigned int ctrl)
+static void ingenic_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
+				  unsigned int ctrl)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
-	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(nand->chip.controller);
-	struct jz4780_nand_cs *cs;
+	struct ingenic_nand *nand = to_ingenic_nand(nand_to_mtd(chip));
+	struct ingenic_nfc *nfc = to_ingenic_nfc(nand->chip.controller);
+	struct ingenic_nand_cs *cs;
 
 	if (WARN_ON(nfc->selected < 0))
 		return;
@@ -106,25 +105,25 @@ static void jz4780_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
 		writeb(cmd, cs->base + OFFSET_CMD);
 }
 
-static int jz4780_nand_dev_ready(struct nand_chip *chip)
+static int ingenic_nand_dev_ready(struct nand_chip *chip)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
+	struct ingenic_nand *nand = to_ingenic_nand(nand_to_mtd(chip));
 
 	return !gpiod_get_value_cansleep(nand->busy_gpio);
 }
 
-static void jz4780_nand_ecc_hwctl(struct nand_chip *chip, int mode)
+static void ingenic_nand_ecc_hwctl(struct nand_chip *chip, int mode)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
+	struct ingenic_nand *nand = to_ingenic_nand(nand_to_mtd(chip));
 
 	nand->reading = (mode == NAND_ECC_READ);
 }
 
-static int jz4780_nand_ecc_calculate(struct nand_chip *chip, const u8 *dat,
-				     u8 *ecc_code)
+static int ingenic_nand_ecc_calculate(struct nand_chip *chip, const u8 *dat,
+				      u8 *ecc_code)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
-	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(nand->chip.controller);
+	struct ingenic_nand *nand = to_ingenic_nand(nand_to_mtd(chip));
+	struct ingenic_nfc *nfc = to_ingenic_nfc(nand->chip.controller);
 	struct jz4780_bch_params params;
 
 	/*
@@ -141,11 +140,11 @@ static int jz4780_nand_ecc_calculate(struct nand_chip *chip, const u8 *dat,
 	return jz4780_bch_calculate(nfc->bch, &params, dat, ecc_code);
 }
 
-static int jz4780_nand_ecc_correct(struct nand_chip *chip, u8 *dat,
-				   u8 *read_ecc, u8 *calc_ecc)
+static int ingenic_nand_ecc_correct(struct nand_chip *chip, u8 *dat,
+				    u8 *read_ecc, u8 *calc_ecc)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
-	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(nand->chip.controller);
+	struct ingenic_nand *nand = to_ingenic_nand(nand_to_mtd(chip));
+	struct ingenic_nfc *nfc = to_ingenic_nfc(nand->chip.controller);
 	struct jz4780_bch_params params;
 
 	params.size = nand->chip.ecc.size;
@@ -155,10 +154,10 @@ static int jz4780_nand_ecc_correct(struct nand_chip *chip, u8 *dat,
 	return jz4780_bch_correct(nfc->bch, &params, dat, read_ecc);
 }
 
-static int jz4780_nand_attach_chip(struct nand_chip *chip)
+static int ingenic_nand_attach_chip(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(chip->controller);
+	struct ingenic_nfc *nfc = to_ingenic_nfc(chip->controller);
 	int eccbytes;
 
 	chip->ecc.bytes = fls((1 + 8) * chip->ecc.size)	*
@@ -167,14 +166,13 @@ static int jz4780_nand_attach_chip(struct nand_chip *chip)
 	switch (chip->ecc.mode) {
 	case NAND_ECC_HW:
 		if (!nfc->bch) {
-			dev_err(nfc->dev,
-				"HW BCH selected, but BCH controller not found\n");
+			dev_err(nfc->dev, "HW BCH selected, but BCH controller not found\n");
 			return -ENODEV;
 		}
 
-		chip->ecc.hwctl = jz4780_nand_ecc_hwctl;
-		chip->ecc.calculate = jz4780_nand_ecc_calculate;
-		chip->ecc.correct = jz4780_nand_ecc_correct;
+		chip->ecc.hwctl = ingenic_nand_ecc_hwctl;
+		chip->ecc.calculate = ingenic_nand_ecc_calculate;
+		chip->ecc.correct = ingenic_nand_ecc_correct;
 		/* fall through */
 	case NAND_ECC_SOFT:
 		dev_info(nfc->dev, "using %s (strength %d, size %d, bytes %d)\n",
@@ -209,18 +207,18 @@ static int jz4780_nand_attach_chip(struct nand_chip *chip)
 	return 0;
 }
 
-static const struct nand_controller_ops jz4780_nand_controller_ops = {
-	.attach_chip = jz4780_nand_attach_chip,
+static const struct nand_controller_ops ingenic_nand_controller_ops = {
+	.attach_chip = ingenic_nand_attach_chip,
 };
 
-static int jz4780_nand_init_chip(struct platform_device *pdev,
-				struct jz4780_nand_controller *nfc,
-				struct device_node *np,
-				unsigned int chipnr)
+static int ingenic_nand_init_chip(struct platform_device *pdev,
+				  struct ingenic_nfc *nfc,
+				  struct device_node *np,
+				  unsigned int chipnr)
 {
 	struct device *dev = &pdev->dev;
-	struct jz4780_nand_chip *nand;
-	struct jz4780_nand_cs *cs;
+	struct ingenic_nand *nand;
+	struct ingenic_nand_cs *cs;
 	struct resource *res;
 	struct nand_chip *chip;
 	struct mtd_info *mtd;
@@ -253,7 +251,7 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
 		dev_err(dev, "failed to request busy GPIO: %d\n", ret);
 		return ret;
 	} else if (nand->busy_gpio) {
-		nand->chip.legacy.dev_ready = jz4780_nand_dev_ready;
+		nand->chip.legacy.dev_ready = ingenic_nand_dev_ready;
 	}
 
 	nand->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_LOW);
@@ -276,13 +274,13 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
 	chip->legacy.IO_ADDR_W = cs->base + OFFSET_DATA;
 	chip->legacy.chip_delay = RB_DELAY_US;
 	chip->options = NAND_NO_SUBPAGE_WRITE;
-	chip->legacy.select_chip = jz4780_nand_select_chip;
-	chip->legacy.cmd_ctrl = jz4780_nand_cmd_ctrl;
+	chip->legacy.select_chip = ingenic_nand_select_chip;
+	chip->legacy.cmd_ctrl = ingenic_nand_cmd_ctrl;
 	chip->ecc.mode = NAND_ECC_HW;
 	chip->controller = &nfc->controller;
 	nand_set_flash_node(chip, np);
 
-	chip->controller->ops = &jz4780_nand_controller_ops;
+	chip->controller->ops = &ingenic_nand_controller_ops;
 	ret = nand_scan(chip, 1);
 	if (ret)
 		return ret;
@@ -298,19 +296,20 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
 	return 0;
 }
 
-static void jz4780_nand_cleanup_chips(struct jz4780_nand_controller *nfc)
+static void ingenic_nand_cleanup_chips(struct ingenic_nfc *nfc)
 {
-	struct jz4780_nand_chip *chip;
+	struct ingenic_nand *chip;
 
 	while (!list_empty(&nfc->chips)) {
-		chip = list_first_entry(&nfc->chips, struct jz4780_nand_chip, chip_list);
+		chip = list_first_entry(&nfc->chips,
+					struct ingenic_nand, chip_list);
 		nand_release(&chip->chip);
 		list_del(&chip->chip_list);
 	}
 }
 
-static int jz4780_nand_init_chips(struct jz4780_nand_controller *nfc,
-				  struct platform_device *pdev)
+static int ingenic_nand_init_chips(struct ingenic_nfc *nfc,
+				   struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
@@ -319,14 +318,15 @@ static int jz4780_nand_init_chips(struct jz4780_nand_controller *nfc,
 	int num_chips = of_get_child_count(dev->of_node);
 
 	if (num_chips > nfc->num_banks) {
-		dev_err(dev, "found %d chips but only %d banks\n", num_chips, nfc->num_banks);
+		dev_err(dev, "found %d chips but only %d banks\n",
+			num_chips, nfc->num_banks);
 		return -EINVAL;
 	}
 
 	for_each_child_of_node(dev->of_node, np) {
-		ret = jz4780_nand_init_chip(pdev, nfc, np, i);
+		ret = ingenic_nand_init_chip(pdev, nfc, np, i);
 		if (ret) {
-			jz4780_nand_cleanup_chips(nfc);
+			ingenic_nand_cleanup_chips(nfc);
 			return ret;
 		}
 
@@ -336,11 +336,11 @@ static int jz4780_nand_init_chips(struct jz4780_nand_controller *nfc,
 	return 0;
 }
 
-static int jz4780_nand_probe(struct platform_device *pdev)
+static int ingenic_nand_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	unsigned int num_banks;
-	struct jz4780_nand_controller *nfc;
+	struct ingenic_nfc *nfc;
 	int ret;
 
 	num_banks = jz4780_nemc_num_banks(dev);
@@ -367,7 +367,7 @@ static int jz4780_nand_probe(struct platform_device *pdev)
 	nand_controller_init(&nfc->controller);
 	INIT_LIST_HEAD(&nfc->chips);
 
-	ret = jz4780_nand_init_chips(nfc, pdev);
+	ret = ingenic_nand_init_chips(nfc, pdev);
 	if (ret) {
 		if (nfc->bch)
 			jz4780_bch_release(nfc->bch);
@@ -378,35 +378,35 @@ static int jz4780_nand_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int jz4780_nand_remove(struct platform_device *pdev)
+static int ingenic_nand_remove(struct platform_device *pdev)
 {
-	struct jz4780_nand_controller *nfc = platform_get_drvdata(pdev);
+	struct ingenic_nfc *nfc = platform_get_drvdata(pdev);
 
 	if (nfc->bch)
 		jz4780_bch_release(nfc->bch);
 
-	jz4780_nand_cleanup_chips(nfc);
+	ingenic_nand_cleanup_chips(nfc);
 
 	return 0;
 }
 
-static const struct of_device_id jz4780_nand_dt_match[] = {
+static const struct of_device_id ingenic_nand_dt_match[] = {
 	{ .compatible = "ingenic,jz4780-nand" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, jz4780_nand_dt_match);
+MODULE_DEVICE_TABLE(of, ingenic_nand_dt_match);
 
-static struct platform_driver jz4780_nand_driver = {
-	.probe		= jz4780_nand_probe,
-	.remove		= jz4780_nand_remove,
+static struct platform_driver ingenic_nand_driver = {
+	.probe		= ingenic_nand_probe,
+	.remove		= ingenic_nand_remove,
 	.driver	= {
 		.name	= DRV_NAME,
-		.of_match_table = of_match_ptr(jz4780_nand_dt_match),
+		.of_match_table = of_match_ptr(ingenic_nand_dt_match),
 	},
 };
-module_platform_driver(jz4780_nand_driver);
+module_platform_driver(ingenic_nand_driver);
 
 MODULE_AUTHOR("Alex Smith <alex@alex-smith.me.uk>");
 MODULE_AUTHOR("Harvey Hunt <harveyhuntnexus@gmail.com>");
-MODULE_DESCRIPTION("Ingenic JZ4780 NAND driver");
+MODULE_DESCRIPTION("Ingenic JZ47xx NAND driver");
 MODULE_LICENSE("GPL v2");
-- 
2.11.0

