Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C576BECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDE720838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulga7dAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDE720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeJaTzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35515 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeJaTzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id d6-v6so5124232edi.2;
        Wed, 31 Oct 2018 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++UB/yUzA/hcZ0KOxwbRsSFfrZpczcagwpjMv41IvqQ=;
        b=ulga7dAyn+DGwytYeHgUjjcjPtUEeNkZ4VCytHsNSPLubiYrM7HfeUMabQgms9K6wk
         7LmMnF9mzXJ0JpSxIipODWpy6myaeG6NCVaT8i0Oxr2K+nvZBni/G8SsVjqELklwWh9O
         HLjjA4z5/xFHU9de62F8PZQe9WsKwYImlAjbfVG9jJgx0S0Abvb8tBj1TCaP+kFEEldW
         Ie7P8xoWgYyypu1TZ5PoloRNPz8d9Oa/lTy23GFrWQIRmzRxiJfLbPPQUOF9vGqA/47a
         VcqM7CzCq9Zdnr2MFPcm1fFu5jTpBUB80lFsu074iv0/kgtEdHJhtTgRk3SMJ0Yblf1f
         nkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=++UB/yUzA/hcZ0KOxwbRsSFfrZpczcagwpjMv41IvqQ=;
        b=Fl3rqwHXORNXUMdFI1PG0A14YfSP5erm+WNOvRpWMn10EageAzbgVWqSPDI+PDesTH
         5gNmlb6PpVQ9xu8u46Zsyvj3ECsiVJfeV0u0qDfdAqlv1tMTtqhEYmYqLcnHLp8HRsal
         P9Z2m4a9FwixeFkO7M1ZIFdLU5Qoh1Dou5FKuch6emkKGAGz/Ms6npNFwTpVth6zPWuZ
         NT1hLoLtBUFxyrsy/IQOlDh2bvmVgEQIRnRnTPjGIBRuCqKbn5ndcIn/6fgjiGDvB3zt
         DVdAOkqJuOWQFbhU+RYBhewX0KIBzlidD2ciCW69wnhbxxHQxHNhjo6NeDwdtS8LBg7k
         eCFg==
X-Gm-Message-State: AGRZ1gILcfLWWX8JrzRPlJu4t8z2T4IaKB+7EoXGYs/f2kJ7+JkGEA+t
        g6Nu7gnKLsSsM2Odli1+qbuIwhKPeos=
X-Google-Smtp-Source: AJdET5dGUjS+W6tEZnOEWXPIInldSHjteGClsXByMANaXBUe478cvAVGfF7iSi2ch35KNaZ+1TZoaA==
X-Received: by 2002:a50:a985:: with SMTP id n5-v6mr1692833edc.120.1540983494630;
        Wed, 31 Oct 2018 03:58:14 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:58:13 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/14] spi: rockchip: support 4bit words
Date:   Wed, 31 Oct 2018 11:57:10 +0100
Message-Id: <20181031105711.19575-14-esmil@mailme.dk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

The hardware supports 4, 8 and 16bit spi words,
so add the missing support for 4bit words.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 41 +++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1297f081818d..9e47e81553a1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -54,6 +54,9 @@
 
 /* Bit fields in CTRLR0 */
 #define CR0_DFS_OFFSET				0
+#define CR0_DFS_4BIT				0x0
+#define CR0_DFS_8BIT				0x1
+#define CR0_DFS_16BIT				0x2
 
 #define CR0_CFS_OFFSET				2
 
@@ -464,15 +467,14 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		struct spi_device *spi, struct spi_transfer *xfer,
 		bool use_dma)
 {
-	u32 dmacr = 0;
-
 	u32 cr0 = CR0_FRF_SPI  << CR0_FRF_OFFSET
 	        | CR0_BHT_8BIT << CR0_BHT_OFFSET
 	        | CR0_SSD_ONE  << CR0_SSD_OFFSET
 	        | CR0_EM_BIG   << CR0_EM_OFFSET;
+	u32 cr1;
+	u32 dmacr = 0;
 
 	cr0 |= rs->rsd << CR0_RSD_OFFSET;
-	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 
 	if (xfer->rx_buf && xfer->tx_buf)
@@ -482,6 +484,27 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	else if (use_dma)
 		cr0 |= CR0_XFM_TO << CR0_XFM_OFFSET;
 
+	switch (xfer->bits_per_word) {
+	case 4:
+		cr0 |= CR0_DFS_4BIT << CR0_DFS_OFFSET;
+		cr1 = xfer->len - 1;
+		break;
+	case 8:
+		cr0 |= CR0_DFS_8BIT << CR0_DFS_OFFSET;
+		cr1 = xfer->len - 1;
+		break;
+	case 16:
+		cr0 |= CR0_DFS_16BIT << CR0_DFS_OFFSET;
+		cr1 = xfer->len / 2 - 1;
+		break;
+	default:
+		/* we only whitelist 4, 8 and 16 bit words in
+		 * master->bits_per_word_mask, so this shouldn't
+		 * happen
+		 */
+		unreachable();
+	}
+
 	if (use_dma) {
 		if (xfer->tx_buf)
 			dmacr |= TF_DMA_EN;
@@ -490,13 +513,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	}
 
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
-
-	if (rs->n_bytes == 1)
-		writel_relaxed(xfer->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
-	else if (rs->n_bytes == 2)
-		writel_relaxed((xfer->len / 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
-	else
-		writel_relaxed((xfer->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	writel_relaxed(cr1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 
 	/* unfortunately setting the fifo threshold level to generate an
 	 * interrupt exactly when the fifo is full doesn't seem to work,
@@ -545,7 +562,7 @@ static int rockchip_spi_transfer_one(
 		return -EINVAL;
 	}
 
-	rs->n_bytes = xfer->bits_per_word >> 3;
+	rs->n_bytes = xfer->bits_per_word <= 8 ? 1 : 2;
 
 	use_dma = master->can_dma ? master->can_dma(master, spi, xfer) : false;
 
@@ -667,7 +684,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
 	master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	master->dev.of_node = pdev->dev.of_node;
-	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8) | SPI_BPW_MASK(4);
 	master->min_speed_hz = rs->freq / BAUDR_SCKDV_MAX;
 	master->max_speed_hz = min(rs->freq / BAUDR_SCKDV_MIN, MAX_SCLK_OUT);
 
-- 
2.19.1

