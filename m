Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C73DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B221F21521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY4uDjYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B221F21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbeITEcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:32:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37701 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733034AbeITEbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:31:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so6576795ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eb5psFtCv/AGghQzFTT1yQ2Wu3jOpiiRfBYYjNUC3mo=;
        b=SY4uDjYMIxAGKCixIkDHgQCItdRPcrjDlHiXPkm20MR+Kg84UsFDAzKq9BsV2EXtHn
         m/TBmLY18FiCbf9QILj02dE2+T/PkuRKFOHAhskN2sFxm4GtaSu32S91folT9Uw8Ic5X
         rbbx1yVnxF+XgCF2sPCbC5UYCemVBpGL5GaesLPO3tHQyxOrspTJlOVMQ9DdKmg558Pg
         7jR2PUAAI6fvrVhPPGP/3TVsyaNHC0DxAGvfjnQL65s7VpFzuEie0/ChRRQ7NSrQ9nW7
         Un1Jn/9BmFBccE57rVWX/erhxo+MCN3RX7fc+3bIoNnAmDFDVMpv/8TIPkTq5JTWJCmX
         zoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eb5psFtCv/AGghQzFTT1yQ2Wu3jOpiiRfBYYjNUC3mo=;
        b=QFtqiv2qE2ELh7Vj8BY6quEcBwObt6Jxw4mOfLm7JoNvn0ysl06GD0hbvndDcZ7kWC
         ZvHfb5Xn1ufOIljbVCPRJX8qHb+dkzc2eKCGmL1DbPJiGhl99l5Unn2wUf+g3G5xGKpe
         5wvd0yBctyrhxYZ1TUaZdqWmr5+5cX+Y4bqWGgOAL6WsNZILcAKY5qBEUf3Qe/dZ5n9F
         zT+zGrxapHscLlX6d27U6ZamT1jDTywgkYjfYIVpej3ckGLj2reQMt+0Hic2RsihFCqq
         amDeP44IjCUpQFtuF9HKQdqnJncu6DGNIFg6GUmIRE8k7twcoldQf/f4m1Iz60zwhGnV
         vTWg==
X-Gm-Message-State: APzg51CWvz6mBo+oDcKMhkaXsdAgJi9eJxUzX6ZqyaLWu8dA/ozCRgSW
        4psEtfji0qNU0MiqN0iD+h4=
X-Google-Smtp-Source: ANB0VdYOsKhtB4DtTS7wB+gCfCQC3OL0pew7DL3gERa+Y9LCflkuYysU5S9ry6Gi32xBqcdNVua2EA==
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr9238384ljt.8.1537397503136;
        Wed, 19 Sep 2018 15:51:43 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id q22-v6sm1249211lff.10.2018.09.19.15.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 15:51:42 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] mtd: rawnand: ams-delta: Use private structure
Date:   Thu, 20 Sep 2018 00:52:54 +0200
Message-Id: <20180919225255.31175-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919225255.31175-1-jmkrzyszt@gmail.com>
References: <20180820213904.13475-1-jmkrzyszt@gmail.com>
 <20180919225255.31175-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver private structure and allocate it on device probe.
Use it for storing nand_chip structure, GPIO descriptors prevoiusly
stored in static variables as well as io_base pointer previously passed
as nand controller data or platform driver data.  Subsequent patches
may populate the structure with more members as needed.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 122 +++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 56 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index efe12066dfbc..eb2aeadc3b65 100644
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
@@ -70,25 +74,27 @@ static const struct mtd_partition partition_info[] = {
 
 static void ams_delta_write_byte(struct nand_chip *this, u_char byte)
 {
-	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	void __iomem *io_base = priv->io_base;
 
 	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 	writew(byte, this->legacy.IO_ADDR_W);
-	gpiod_set_value(gpiod_nwe, 0);
+	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
-	gpiod_set_value(gpiod_nwe, 1);
+	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
 static u_char ams_delta_read_byte(struct nand_chip *this)
 {
 	u_char res;
-	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	void __iomem *io_base = priv->io_base;
 
-	gpiod_set_value(gpiod_nre, 0);
+	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
 	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
 	res = readw(this->legacy.IO_ADDR_R);
-	gpiod_set_value(gpiod_nre, 1);
+	gpiod_set_value(priv->gpiod_nre, 1);
 
 	return res;
 }
@@ -121,11 +127,12 @@ static void ams_delta_read_buf(struct nand_chip *this, u_char *buf, int len)
 static void ams_delta_hwcontrol(struct nand_chip *this, int cmd,
 				unsigned int ctrl)
 {
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
@@ -134,7 +141,9 @@ static void ams_delta_hwcontrol(struct nand_chip *this, int cmd,
 
 static int ams_delta_nand_ready(struct nand_chip *this)
 {
-	return gpiod_get_value(gpiod_rdy);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+
+	return gpiod_get_value(priv->gpiod_rdy);
 }
 
 
@@ -143,7 +152,9 @@ static int ams_delta_nand_ready(struct nand_chip *this)
  */
 static int ams_delta_init(struct platform_device *pdev)
 {
+	struct ams_delta_nand *priv;
 	struct nand_chip *this;
+	struct mtd_info *mtd;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *io_base;
 	int err = 0;
@@ -152,15 +163,16 @@ static int ams_delta_init(struct platform_device *pdev)
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
-	ams_delta_mtd->dev.parent = &pdev->dev;
+	mtd = nand_to_mtd(this);
+	mtd->dev.parent = &pdev->dev;
 
 	/*
 	 * Don't try to request the memory region from here,
@@ -175,7 +187,8 @@ static int ams_delta_init(struct platform_device *pdev)
 		goto out_free;
 	}
 
-	nand_set_controller_data(this, (void *)io_base);
+	priv->io_base = io_base;
+	nand_set_controller_data(this, priv);
 
 	/* Set address of NAND IO lines */
 	this->legacy.IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
@@ -185,14 +198,14 @@ static int ams_delta_init(struct platform_device *pdev)
 	this->legacy.read_buf = ams_delta_read_buf;
 	this->legacy.cmd_ctrl = ams_delta_hwcontrol;
 
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
 		this->legacy.dev_ready = ams_delta_nand_ready;
 
 	/* 25 us command delay time */
@@ -200,47 +213,47 @@ static int ams_delta_init(struct platform_device *pdev)
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
@@ -251,15 +264,13 @@ static int ams_delta_init(struct platform_device *pdev)
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
@@ -269,16 +280,15 @@ static int ams_delta_init(struct platform_device *pdev)
  */
 static int ams_delta_cleanup(struct platform_device *pdev)
 {
-	void __iomem *io_base = platform_get_drvdata(pdev);
+	struct ams_delta_nand *priv = platform_get_drvdata(pdev);
+	struct mtd_info *mtd = nand_to_mtd(&priv->nand_chip);
+	void __iomem *io_base = priv->io_base;
 
 	/* Release resources, unregister device */
-	nand_release(mtd_to_nand(ams_delta_mtd));
+	nand_release(mtd_to_nand(mtd));
 
 	iounmap(io_base);
 
-	/* Free the MTD device structure */
-	kfree(mtd_to_nand(ams_delta_mtd));
-
 	return 0;
 }
 
-- 
2.16.4

