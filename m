Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6104ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E8D20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9Q/mDF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E8D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbeGSAhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:37:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39464 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeGSAhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:37:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so5614473lji.6;
        Wed, 18 Jul 2018 16:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qKg7aER+jxf9AHBXCp07Y8X5c6hHXgVTlxOk+xnqwtY=;
        b=L9Q/mDF+3l9WgCXFdGM4wJqVONDYn+CZFoCkc/nTzNNb9uiSXcXbUH/8mkDbxF2eIf
         2ifpybc3DoZ54k8LJaBQdPHBuhHrlk89fHVngQVloIg2+Yb/L54fOzIJqCsJU1B3Zd0b
         d45NbEVFqzBxgBxSilGMoRnr4u3gkmMl7lb1JJ42o7utoR55On9ATWz/MG4Mzj7YAQ2Z
         71Z2dCQ6afxdQ+TvmUw2j8Cq310RVJ7hIT3xdxRc/1EWBesuuo9AX2xhv7Vl03PsY9a5
         bq5OURYyTnsPJmVVn5VYsB/D8vNhmsNrSZ0xLfuN3ts2WoynJ22U/BJCkk8EXIAlgMjA
         pEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qKg7aER+jxf9AHBXCp07Y8X5c6hHXgVTlxOk+xnqwtY=;
        b=b1qCYSKuhypXBjQyaoFXs7WWSVdn4WxnVB84Nr2Xc6o00o6L6xZ1fOqR80B1tbpEME
         XHWBcZ97OGJUrySpIg74LF6J5y3qHiyG+Bv+2zpKdlfr2NPhrF/D4nbvZGnFGQxrJnKi
         DwohIuZwsQ2eW6N1HIpmzeyjr2cOGEvdjaOjguia0dN6AJoHxamvfu4wMIKSVQathJ55
         1NL1fTYw+93ew1mEvUzEYD0kXiZWdP8nD+SCuUtXWLTRD9VRQPuWFU+m8tBc4+/H47Th
         Hz0AVv/s2plWa5E3k2QfUktQnH7L6Si2AJ7PEfZGzf35r3qVd2kMV0DPW8upXNCwSn/A
         N/+A==
X-Gm-Message-State: AOUpUlH9yhkSI4lAIU7a7k4Wt5Oz6Kr0BvHUD5dZstIOUJDAdOFG9Kyt
        DudlcwvorZQN2VT73EGpyWQ=
X-Google-Smtp-Source: AAOMgpdH43I6Pj912VqAU9lEusHCM0mZLeCN0kpKR/0VzPuWNcEHByJleNitI5PZ7b6R11vxDUWeXg==
X-Received: by 2002:a2e:590e:: with SMTP id n14-v6mr5712083ljb.128.1531958211009;
        Wed, 18 Jul 2018 16:56:51 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h7-v6sm826584ljk.27.2018.07.18.16.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:56:50 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 1/8] mtd: rawnand: ams-delta: Use private structure
Date:   Thu, 19 Jul 2018 01:57:03 +0200
Message-Id: <20180718235710.18242-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver private structure and allocate it on device probe.
Use it for storing nand_chip structure, GPIO descriptors prevoiusly
stored in static variables as well as io_base pointer previously passed
as nand controller data or platform driver data.  Subsequent patches
may populate the structure with more members as needed.

While at it, fix missing mtd->dev.parent and drop useless mtd->owner.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 126 +++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 57 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 2a8872ebd14a..48233d638d2a 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -34,14 +34,18 @@
 /*
  * MTD structure for E3 (Delta)
  */
-static struct mtd_info *ams_delta_mtd = NULL;
-static struct gpio_desc *gpiod_rdy;
-static struct gpio_desc *gpiod_nce;
-static struct gpio_desc *gpiod_nre;
-static struct gpio_desc *gpiod_nwp;
-static struct gpio_desc *gpiod_nwe;
-static struct gpio_desc *gpiod_ale;
-static struct gpio_desc *gpiod_cle;
+
+struct ams_delta_nand {
+	struct nand_chip	nand_chip;
+	struct gpio_desc	*gpiod_rdy;
+	struct gpio_desc	*gpiod_nce;
+	struct gpio_desc	*gpiod_nre;
+	struct gpio_desc	*gpiod_nwp;
+	struct gpio_desc	*gpiod_nwe;
+	struct gpio_desc	*gpiod_ale;
+	struct gpio_desc	*gpiod_cle;
+	void __iomem		*io_base;
+};
 
 /*
  * Define partitions for flash devices
@@ -71,26 +75,28 @@ static const struct mtd_partition partition_info[] = {
 static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	void __iomem *io_base = priv->io_base;
 
 	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 	writew(byte, this->IO_ADDR_W);
-	gpiod_set_value(gpiod_nwe, 0);
+	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
-	gpiod_set_value(gpiod_nwe, 1);
+	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
 static u_char ams_delta_read_byte(struct mtd_info *mtd)
 {
 	u_char res;
 	struct nand_chip *this = mtd_to_nand(mtd);
-	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	void __iomem *io_base = priv->io_base;
 
-	gpiod_set_value(gpiod_nre, 0);
+	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
 	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
 	res = readw(this->IO_ADDR_R);
-	gpiod_set_value(gpiod_nre, 1);
+	gpiod_set_value(priv->gpiod_nre, 1);
 
 	return res;
 }
@@ -123,11 +129,13 @@ static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 				unsigned int ctrl)
 {
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 
 	if (ctrl & NAND_CTRL_CHANGE) {
-		gpiod_set_value(gpiod_nce, !(ctrl & NAND_NCE));
-		gpiod_set_value(gpiod_cle, !!(ctrl & NAND_CLE));
-		gpiod_set_value(gpiod_ale, !!(ctrl & NAND_ALE));
+		gpiod_set_value(priv->gpiod_nce, !(ctrl & NAND_NCE));
+		gpiod_set_value(priv->gpiod_cle, !!(ctrl & NAND_CLE));
+		gpiod_set_value(priv->gpiod_ale, !!(ctrl & NAND_ALE));
 	}
 
 	if (cmd != NAND_CMD_NONE)
@@ -136,7 +144,10 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 
 static int ams_delta_nand_ready(struct mtd_info *mtd)
 {
-	return gpiod_get_value(gpiod_rdy);
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+
+	return gpiod_get_value(priv->gpiod_rdy);
 }
 
 
@@ -145,7 +156,9 @@ static int ams_delta_nand_ready(struct mtd_info *mtd)
  */
 static int ams_delta_init(struct platform_device *pdev)
 {
+	struct ams_delta_nand *priv;
 	struct nand_chip *this;
+	struct mtd_info *mtd;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *io_base;
 	int err = 0;
@@ -154,15 +167,16 @@ static int ams_delta_init(struct platform_device *pdev)
 		return -ENXIO;
 
 	/* Allocate memory for MTD device structure and private data */
-	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
-	if (!this) {
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct ams_delta_nand),
+			    GFP_KERNEL);
+	if (!priv) {
 		pr_warn("Unable to allocate E3 NAND MTD device structure.\n");
-		err = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
+	this = &priv->nand_chip;
 
-	ams_delta_mtd = nand_to_mtd(this);
-	ams_delta_mtd->owner = THIS_MODULE;
+	mtd = nand_to_mtd(this);
+	mtd->dev.parent = &pdev->dev;
 
 	/*
 	 * Don't try to request the memory region from here,
@@ -177,7 +191,8 @@ static int ams_delta_init(struct platform_device *pdev)
 		goto out_free;
 	}
 
-	nand_set_controller_data(this, (void *)io_base);
+	priv->io_base = io_base;
+	nand_set_controller_data(this, priv);
 
 	/* Set address of NAND IO lines */
 	this->IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
@@ -187,14 +202,14 @@ static int ams_delta_init(struct platform_device *pdev)
 	this->read_buf = ams_delta_read_buf;
 	this->cmd_ctrl = ams_delta_hwcontrol;
 
-	gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
-	if (IS_ERR(gpiod_rdy)) {
-		err = PTR_ERR(gpiod_rdy);
+	priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
+	if (IS_ERR(priv->gpiod_rdy)) {
+		err = PTR_ERR(priv->gpiod_rdy);
 		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
 		goto out_mtd;
 	}
 
-	if (gpiod_rdy)
+	if (priv->gpiod_rdy)
 		this->dev_ready = ams_delta_nand_ready;
 
 	/* 25 us command delay time */
@@ -202,66 +217,64 @@ static int ams_delta_init(struct platform_device *pdev)
 	this->ecc.mode = NAND_ECC_SOFT;
 	this->ecc.algo = NAND_ECC_HAMMING;
 
-	platform_set_drvdata(pdev, io_base);
+	platform_set_drvdata(pdev, priv);
 
 	/* Set chip enabled, but  */
-	gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpiod_nwp)) {
-		err = PTR_ERR(gpiod_nwp);
+	priv->gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpiod_nwp)) {
+		err = PTR_ERR(priv->gpiod_nwp);
 		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
 		goto out_mtd;
 	}
 
-	gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpiod_nce)) {
-		err = PTR_ERR(gpiod_nce);
+	priv->gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpiod_nce)) {
+		err = PTR_ERR(priv->gpiod_nce);
 		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
 		goto out_mtd;
 	}
 
-	gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpiod_nre)) {
-		err = PTR_ERR(gpiod_nre);
+	priv->gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpiod_nre)) {
+		err = PTR_ERR(priv->gpiod_nre);
 		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
 		goto out_mtd;
 	}
 
-	gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpiod_nwe)) {
-		err = PTR_ERR(gpiod_nwe);
+	priv->gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->gpiod_nwe)) {
+		err = PTR_ERR(priv->gpiod_nwe);
 		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
 		goto out_mtd;
 	}
 
-	gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod_ale)) {
-		err = PTR_ERR(gpiod_ale);
+	priv->gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->gpiod_ale)) {
+		err = PTR_ERR(priv->gpiod_ale);
 		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
 		goto out_mtd;
 	}
 
-	gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
-	if (IS_ERR(gpiod_cle)) {
-		err = PTR_ERR(gpiod_cle);
+	priv->gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->gpiod_cle)) {
+		err = PTR_ERR(priv->gpiod_cle);
 		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
 		goto out_mtd;
 	}
 
 	/* Scan to find existence of the device */
-	err = nand_scan(ams_delta_mtd, 1);
+	err = nand_scan(mtd, 1);
 	if (err)
 		goto out_mtd;
 
 	/* Register the partitions */
-	mtd_device_register(ams_delta_mtd, partition_info,
-			    ARRAY_SIZE(partition_info));
+	mtd_device_register(mtd, partition_info, ARRAY_SIZE(partition_info));
 
 	goto out;
 
  out_mtd:
 	iounmap(io_base);
 out_free:
-	kfree(this);
  out:
 	return err;
 }
@@ -271,16 +284,15 @@ static int ams_delta_init(struct platform_device *pdev)
  */
 static int ams_delta_cleanup(struct platform_device *pdev)
 {
-	void __iomem *io_base = platform_get_drvdata(pdev);
+	struct ams_delta_nand *priv = platform_get_drvdata(pdev);
+	struct mtd_info *mtd = nand_to_mtd(&priv->nand_chip);
+	void __iomem *io_base = priv->io_base;
 
 	/* Release resources, unregister device */
-	nand_release(ams_delta_mtd);
+	nand_release(mtd);
 
 	iounmap(io_base);
 
-	/* Free the MTD device structure */
-	kfree(mtd_to_nand(ams_delta_mtd));
-
 	return 0;
 }
 
-- 
2.16.4

