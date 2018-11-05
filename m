Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ADFC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C18120869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRosv9tI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C18120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeKET4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:56:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44970 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbeKET4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:56:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so7499015lji.11;
        Mon, 05 Nov 2018 02:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d8ZSlu+Y6nv+yDo4gO/3KB5Xa01Kve+Kk3amSF4yYhk=;
        b=iRosv9tIyYTGBipCJ0POjff7RnFVeJ2bn94bSz/eIvwN8SHyB8olijkcGNKwZvBAwH
         DLSxecudd9xAHP8Ps5J6M0P8Y9pRziQC65g1pjVZ2hmf+4R/63rdz4tZcSgNW6Twv2gx
         JfXEo97736bRTApF9V9/xg5dF6pAOvob9b5t9yy8wW/KCUMscTxJvb7xP1/ryG10faa5
         G/T8Lf4DcmvhF4vOtRaFSaoq7cqO7sBdTaOlYUG6YyIgcgWW2jFhhBwMblvRvaVVyhq0
         M5bfkGv5B6M1xWjAmFN92yMl2G1TIRRIOpfIfFvy0shSWkvaDTpmmV91xcO2saQuZ8bx
         sarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d8ZSlu+Y6nv+yDo4gO/3KB5Xa01Kve+Kk3amSF4yYhk=;
        b=tqc5RGpTWw/CakMXWX83zHCuOseaMZZTJWNlP56pi2bQSEqbtcw9uT4/KU1YpUdWAl
         DobPQxadmZgujnPssR/B2zdjJ0oQXc8Xo+bZBGCd7Gakzn4aDdxzrbi2otcWhFGN6iDd
         z+HOZ+eFCq6B+T9Oj9ILWysQi0bK80OujwOaJBUGHzpLDloORo6n87HnKrxnFayPV7Vd
         rJ0Kb6ST19KmT6dyIfjlq/208ky1YpnWgm90akAZkJh1mTFqWPHgrZ7nl8BAA1UBsw2k
         doWnFvvyXK5+HbEzXQk7pBXEYBs8pmJnNWfnahBnwPq66fvff7XLpw58PlqosGrSLNUX
         prtA==
X-Gm-Message-State: AGRZ1gKkTK8QNiJeXN1ZeZlcEjX6TmmQdiBeHGCqBOoqISzhTUQx5qu3
        1FPOLOl/DjaE2wQy9UX+/Q==
X-Google-Smtp-Source: AJdET5dypK+N70VJHIumirGkkyD8fusHypCz2k7a6ycduMDvAquDdVkpAjjCQlfzztJ/A/HPlx80nQ==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr13443984ljf.96.1541414229855;
        Mon, 05 Nov 2018 02:37:09 -0800 (PST)
Received: from localhost.localdomain (89-64-7-227.dynamic.chello.pl. [89.64.7.227])
        by smtp.gmail.com with ESMTPSA id h140-v6sm5413605lfg.4.2018.11.05.02.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 02:37:09 -0800 (PST)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>
Subject: [PATCH v3 3/6] mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi driver
Date:   Mon,  5 Nov 2018 11:36:22 +0100
Message-Id: <20181105103625.9644-4-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181105103625.9644-1-bugalski.piotr@gmail.com>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously added spi-mem interface is now used instead of older approach.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 91 ++++++++-----------------------------
 1 file changed, 18 insertions(+), 73 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 896478a290ec..644e3f0c1558 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -766,27 +766,9 @@ static ssize_t atmel_qspi_read(struct spi_nor *nor, loff_t from, size_t len,
 
 static int atmel_qspi_init(struct atmel_qspi *aq)
 {
-	unsigned long src_rate;
-	u32 mr, scr, scbr;
-
 	/* Reset the QSPI controller */
 	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
 
-	/* Set the QSPI controller in Serial Memory Mode */
-	mr = QSPI_MR_NBBITS(8) | QSPI_MR_SMM;
-	qspi_writel(aq, QSPI_MR, mr);
-
-	src_rate = clk_get_rate(aq->clk);
-	if (!src_rate)
-		return -EINVAL;
-
-	/* Compute the QSPI baudrate */
-	scbr = DIV_ROUND_UP(src_rate, aq->clk_rate);
-	if (scbr > 0)
-		scbr--;
-	scr = QSPI_SCR_SCBR(scbr);
-	qspi_writel(aq, QSPI_SCR, scr);
-
 	/* Enable the QSPI controller */
 	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
 
@@ -814,38 +796,25 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 
 static int atmel_qspi_probe(struct platform_device *pdev)
 {
-	const struct spi_nor_hwcaps hwcaps = {
-		.mask = SNOR_HWCAPS_READ |
-			SNOR_HWCAPS_READ_FAST |
-			SNOR_HWCAPS_READ_1_1_2 |
-			SNOR_HWCAPS_READ_1_2_2 |
-			SNOR_HWCAPS_READ_2_2_2 |
-			SNOR_HWCAPS_READ_1_1_4 |
-			SNOR_HWCAPS_READ_1_4_4 |
-			SNOR_HWCAPS_READ_4_4_4 |
-			SNOR_HWCAPS_PP |
-			SNOR_HWCAPS_PP_1_1_4 |
-			SNOR_HWCAPS_PP_1_4_4 |
-			SNOR_HWCAPS_PP_4_4_4,
-	};
-	struct device_node *child, *np = pdev->dev.of_node;
+	struct spi_controller *ctrl;
 	struct atmel_qspi *aq;
 	struct resource *res;
-	struct spi_nor *nor;
-	struct mtd_info *mtd;
 	int irq, err = 0;
 
-	if (of_get_child_count(np) != 1)
-		return -ENODEV;
-	child = of_get_next_child(np, NULL);
+	ctrl = spi_alloc_master(&pdev->dev, sizeof(*aq));
+	if (!ctrl)
+		return -ENOMEM;
 
-	aq = devm_kzalloc(&pdev->dev, sizeof(*aq), GFP_KERNEL);
-	if (!aq) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
+	ctrl->setup = atmel_qspi_setup;
+	ctrl->bus_num = -1;
+	ctrl->mem_ops = &atmel_qspi_mem_ops;
+	ctrl->num_chipselect = 1;
+	ctrl->dev.of_node = pdev->dev.of_node;
+	platform_set_drvdata(pdev, ctrl);
+
+	aq = spi_controller_get_devdata(ctrl);
 
-	platform_set_drvdata(pdev, aq);
 	init_completion(&aq->cmd_completion);
 	aq->pdev = pdev;
 
@@ -894,54 +863,30 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (err)
 		goto disable_clk;
 
-	/* Setup the spi-nor */
-	nor = &aq->nor;
-	mtd = &nor->mtd;
-
-	nor->dev = &pdev->dev;
-	spi_nor_set_flash_node(nor, child);
-	nor->priv = aq;
-	mtd->priv = nor;
-
-	nor->read_reg = atmel_qspi_read_reg;
-	nor->write_reg = atmel_qspi_write_reg;
-	nor->read = atmel_qspi_read;
-	nor->write = atmel_qspi_write;
-	nor->erase = atmel_qspi_erase;
-
-	err = of_property_read_u32(child, "spi-max-frequency", &aq->clk_rate);
-	if (err < 0)
-		goto disable_clk;
-
 	err = atmel_qspi_init(aq);
 	if (err)
 		goto disable_clk;
 
-	err = spi_nor_scan(nor, NULL, &hwcaps);
-	if (err)
-		goto disable_clk;
-
-	err = mtd_device_register(mtd, NULL, 0);
+	err = spi_register_controller(ctrl);
 	if (err)
 		goto disable_clk;
 
-	of_node_put(child);
-
 	return 0;
 
 disable_clk:
 	clk_disable_unprepare(aq->clk);
 exit:
-	of_node_put(child);
+	spi_controller_put(ctrl);
 
 	return err;
 }
 
 static int atmel_qspi_remove(struct platform_device *pdev)
 {
-	struct atmel_qspi *aq = platform_get_drvdata(pdev);
+	struct spi_controller *ctrl = platform_get_drvdata(pdev);
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 
-	mtd_device_unregister(&aq->nor.mtd);
+	spi_unregister_controller(ctrl);
 	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
 	clk_disable_unprepare(aq->clk);
 	return 0;
-- 
2.11.0

