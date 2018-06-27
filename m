Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F4C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772262625F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfp4zZlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772262625F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965298AbeF0NRl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:17:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39417 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeF0NQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:16:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id w14-v6so3065111eds.6;
        Wed, 27 Jun 2018 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UC2nOLMv2DHOdwZMD5oSjeIq3UuNKut/u3rcAgSeRJQ=;
        b=jfp4zZlLXgIm3ppTcGVKzAV1qHeTh13a6PIdf+Y8GYmlRR+Zs+zp1f4BbP0Mi69vNR
         H3rj/gTiv7UIuE7kWviee48iGhax/GxZLUY5FDj4S9xuH93QOV85+8u4DXXv5kxSTA6C
         l86K+LqFXt6qHUnqb0opLtO5kv2+QpoJ78R9/4CDXzuMGLxorgcQ/q2+kJJ+P/2rxHlo
         Xz/BFQQyq/Liu64dWmkSIvGAqI6N01VgtbYwB0Q51dobl+F0IKRZNsx81Ht/HnbZxSVq
         g6qNBjaoMmZMr6906Za0gNAVoPPCVgul4yz70nkCEgVQQJQARLQMqunR6MSZTeaust5i
         SC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UC2nOLMv2DHOdwZMD5oSjeIq3UuNKut/u3rcAgSeRJQ=;
        b=ZeK2FjE4ZHJsvF44IQNuosv5Dh5Hl/9NsKLOgARYIjXR6ZcRi9KkKRC7WDQypf9p4k
         AS348DX1FhFYHACFZqy606sXEgIsbkEKScEtEF9Xeg4P3PfTT9TDmlZScASEABuCTRzg
         FFQvRguYNl/kSwYwbh/t4ZnfsrXoPmqQtJ61aP904GrKI02iYzchyim9cjFF1Q7rX+UB
         H8uXrzkMMfseQfXAp/09QutNaDx8ax7A6SvTHgqP/t/ZZWcDKg6NjMQapjtsWm0N75kB
         yMI3OJ0BgQ6GN0xDBbSzXq9DFUIeot6knuDYTDP+VE20Bvwryivo9q2r2iKNU7y3hIRt
         XNXQ==
X-Gm-Message-State: APt69E0+q9/sD9a2QRIPkWvWJxI1QVcdlv46SyEoebFm7v7bz+WqeFIu
        pOhfj+zteqZoh3dC2PwqNQ==
X-Google-Smtp-Source: AAOMgpcW1hUlM8EcJzoM8M7xousEemDpwpsgyZE7aot25izZraCdO71n0MYidsSo8rn1XDTv9+hYSA==
X-Received: by 2002:a50:b7fc:: with SMTP id i57-v6mr5664313ede.284.1530105382379;
        Wed, 27 Jun 2018 06:16:22 -0700 (PDT)
Received: from carbonite.sagemdenmark.dk ([130.228.251.5])
        by smtp.gmail.com with ESMTPSA id i34-v6sm1953000edc.29.2018.06.27.06.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:16:21 -0700 (PDT)
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
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: [RFC PATCH v2 3/6] mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi driver
Date:   Wed, 27 Jun 2018 15:16:06 +0200
Message-Id: <20180627131609.13681-4-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180627131609.13681-1-bugalski.piotr@gmail.com>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously added spi-mem interface is now used instead of older approach.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <pbu@cryptera.com>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 91 ++++++++-----------------------------
 1 file changed, 18 insertions(+), 73 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index c36fcecd569a..3c98a3ee480a 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -760,27 +760,9 @@ static ssize_t atmel_qspi_read(struct spi_nor *nor, loff_t from, size_t len,
 
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
 
@@ -808,38 +790,25 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 
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
 
@@ -888,54 +857,30 @@ static int atmel_qspi_probe(struct platform_device *pdev)
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

