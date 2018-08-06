Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282FEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C227521A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyFSQZIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C227521A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbeHGAku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:40:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42991 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387574AbeHGAkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:40:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id u202-v6so10191533lff.9;
        Mon, 06 Aug 2018 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/bFrJqpkYAXIA89qeP/MiX5sn2g+I7ZzvqYqwTt5+3M=;
        b=nyFSQZIgFoC06japxmtl4hUOpncO2u0KUo72C9x12Wj9nY9UKs2lwF8+2azFrfK/8D
         nsIG6bGMySqPaXcAaj5WeoQVO3N//DzjMQLTujsoCeN/RFbjFRC56y5wyPg6eSaWg4TA
         H90b+u0D8IBv2Uk7XfANBJmMxgjNlUnZojwsCaQvNj7Zm8ygtr3gxx+TetQuZ6xQLSu9
         yiX4iJBWYErE8x/Rh1/lnxZW3S8HT7Xnqi7d4HxvBReiluc90NfPKDRrfrcSBPssu37u
         K377uup2Tnz9YVF5ZfvyiU9eFIfu1uihH+pPJ91QwMIZe9y78xmTUp7oiiZP+q91Ki+O
         JNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/bFrJqpkYAXIA89qeP/MiX5sn2g+I7ZzvqYqwTt5+3M=;
        b=pygr4u8dPglP5wAA60Awu/+0ThDUzh+LIoeUocv7UQTj2AyWuxtN931SnCj9R6//+q
         EqGZa55zRLxc9oVNBQMpG8pxW2eBiRXmxMjGHaRlUhskp9kaaw9wgiaPqPwo5WU5F3tP
         3CZmsHo1eXsmzgS1c1uruXPktzrqUFefdxPtbb1oMILpiIIYbodxG+uSvsnGTg723A7s
         e94BpuEXFWSdu43iwTyF9IV0qYvatHqeEgSFVnfV1+HaDLiu21pB7hz8AaNDBPVdorJw
         ND/bUARYzxtvLJ1Cda9UcYwQ6vvEnBBj0kCXPRj3nLQOYkYb6IC6DVClRbK064xEl/bB
         757g==
X-Gm-Message-State: AOUpUlGDKbNCWty0TgcZhgkY3DwniaNOtPpRZOORXnfr9gXbA9aUSnh6
        0LWPnJpU4j+pANBSEcyY6bU=
X-Google-Smtp-Source: AAOMgpeICtnonekoALrQpCgO/KhPn3gCvsWVa6RcYpMYX0ddp0xVRxdUrLc5QM6Ser8285T1uhYRog==
X-Received: by 2002:ac2:428f:: with SMTP id m15-v6mr12815358lfh.52.1533594574784;
        Mon, 06 Aug 2018 15:29:34 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o4-v6sm2438561ljc.67.2018.08.06.15.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 15:29:34 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH v2 05/12] mtd: rawnand: ams-delta: use GPIO API for data read/write
Date:   Tue,  7 Aug 2018 00:29:11 +0200
Message-Id: <20180806222918.12644-6-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't readw()/writew() data directly from/to GPIO port which is under
control of gpio-omap driver, use GPIO API instead.

Degrade of performance on Amstrad Delta is completely not acceptable.

The driver should work with any 8+-bit bidirectional GPIO port, not
only OMAP.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 97 ++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 59 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 09d6901fc94d..78996ddf82e0 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -24,13 +24,10 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_device.h>
 
-#include <asm/io.h>
 #include <asm/sizes.h>
 
-#include <mach/hardware.h>
-
 /*
  * MTD structure for E3 (Delta)
  */
@@ -44,7 +41,7 @@ struct ams_delta_nand {
 	struct gpio_desc	*gpiod_nwe;
 	struct gpio_desc	*gpiod_ale;
 	struct gpio_desc	*gpiod_cle;
-	void __iomem		*io_base;
+	struct gpio_descs	*data_gpiods;
 };
 
 /*
@@ -76,10 +73,14 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	unsigned long bits = byte;
+	int i;
+
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		gpiod_direction_output_raw(data_gpiods->desc[i],
+					   test_bit(i, &bits));
 
-	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
-	writew(byte, this->IO_ADDR_W);
 	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
 	gpiod_set_value(priv->gpiod_nwe, 1);
@@ -87,18 +88,28 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 
 static u_char ams_delta_read_byte(struct mtd_info *mtd)
 {
-	u_char res;
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	unsigned long bits = 0;
+	int i, value_array[data_gpiods->ndescs];
+
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		gpiod_direction_input(data_gpiods->desc[i]);
 
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
-	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
-	res = readw(this->IO_ADDR_R);
+
+	gpiod_get_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
+				  value_array);
+
 	gpiod_set_value(priv->gpiod_nre, 1);
 
-	return res;
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		if (value_array[i])
+			__set_bit(i, &bits);
+
+	return bits;
 }
 
 static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
@@ -159,14 +170,8 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct ams_delta_nand *priv;
 	struct nand_chip *this;
 	struct mtd_info *mtd;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	void __iomem *io_base;
-	struct gpio_descs *data_gpiods;
 	int err = 0;
 
-	if (!res)
-		return -ENXIO;
-
 	/* Allocate memory for MTD device structure and private data */
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct ams_delta_nand),
 			    GFP_KERNEL);
@@ -179,25 +184,8 @@ static int ams_delta_init(struct platform_device *pdev)
 	mtd = nand_to_mtd(this);
 	mtd->dev.parent = &pdev->dev;
 
-	/*
-	 * Don't try to request the memory region from here,
-	 * it should have been already requested from the
-	 * gpio-omap driver and requesting it again would fail.
-	 */
-
-	io_base = ioremap(res->start, resource_size(res));
-	if (io_base == NULL) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		err = -EIO;
-		goto out_free;
-	}
-
-	priv->io_base = io_base;
 	nand_set_controller_data(this, priv);
 
-	/* Set address of NAND IO lines */
-	this->IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
-	this->IO_ADDR_W = io_base + OMAP_MPUIO_OUTPUT;
 	this->read_byte = ams_delta_read_byte;
 	this->write_buf = ams_delta_write_buf;
 	this->read_buf = ams_delta_read_buf;
@@ -207,7 +195,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	if (IS_ERR(priv->gpiod_rdy)) {
 		err = PTR_ERR(priv->gpiod_rdy);
 		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	if (priv->gpiod_rdy)
@@ -225,66 +213,60 @@ static int ams_delta_init(struct platform_device *pdev)
 	if (IS_ERR(priv->gpiod_nwp)) {
 		err = PTR_ERR(priv->gpiod_nwp);
 		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nce)) {
 		err = PTR_ERR(priv->gpiod_nce);
 		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nre)) {
 		err = PTR_ERR(priv->gpiod_nre);
 		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nwe)) {
 		err = PTR_ERR(priv->gpiod_nwe);
 		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_ale)) {
 		err = PTR_ERR(priv->gpiod_ale);
 		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_cle)) {
 		err = PTR_ERR(priv->gpiod_cle);
 		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 	/* Request array of data pins, initialize them as input */
-	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
-	if (IS_ERR(data_gpiods)) {
-		err = PTR_ERR(data_gpiods);
+	priv->data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
+	if (IS_ERR(priv->data_gpiods)) {
+		err = PTR_ERR(priv->data_gpiods);
 		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	/* Scan to find existence of the device */
 	err = nand_scan(mtd, 1);
 	if (err)
-		goto out_mtd;
+		return err;
 
 	/* Register the partitions */
 	mtd_device_register(mtd, partition_info, ARRAY_SIZE(partition_info));
 
-	goto out;
-
- out_mtd:
-	iounmap(io_base);
-out_free:
- out:
-	return err;
+	return 0;
 }
 
 /*
@@ -294,13 +276,10 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 {
 	struct ams_delta_nand *priv = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = nand_to_mtd(&priv->nand_chip);
-	void __iomem *io_base = priv->io_base;
 
-	/* Release resources, unregister device */
+	/* Unregister device */
 	nand_release(mtd);
 
-	iounmap(io_base);
-
 	return 0;
 }
 
-- 
2.16.4

