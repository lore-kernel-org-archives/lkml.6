Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A5ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF67B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxLfenX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF67B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeJaTzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35503 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeJaTzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id d6-v6so5123871edi.2;
        Wed, 31 Oct 2018 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NM/pdnDnROXWun72O7MwXmRWKVMT3A9vxEBhsKr6Owo=;
        b=BxLfenX6EuHvHFiYIyzNLq4O7HDW31+Q2mP4QbINrAsbM4Y5En+mOqriP2L3rh9p8K
         ccBue/Jlfc2U7el7ZlHdbB3Q09AvqtxAGf+SyNnPzdSeiaN5cKlvTq4C/jAPLavTpy0t
         K4LAumY+68xW2yirdo32YnYh564atgvZRnfgK6QcwqHtQgO3GbC95OdkiIilsF+JqUbP
         aVDA4bJYzKVUYJQkCopdrNUzig5tCnPd3XAO+Lhk7kAhqYYpFLZRfo5ThrJ0dZdvUVA0
         ZaXeSyBUBL3pURyKGZuPuca52HFVvB54SM39S/GMptxLxBp1x7rbBSt1H+aEm6oG2Dt1
         EU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NM/pdnDnROXWun72O7MwXmRWKVMT3A9vxEBhsKr6Owo=;
        b=OvTti8Shkm04LwiqyI6phO88WiPj5o58ZiSZwWsJ0O61AphWaC/7yXXEW1+rjX62be
         Yx7sgT/u1ulsSFKM8Vn2oXmbVRW2I8p8+TSguWoeFzYIUnKN+kYodUdvc/WS2FqSbK73
         JLJK5QqGDRm2esRmabmv20I5P+2Vaa0Bx7ZKkrudX2Dq//79WEDjozDjbruu4Ss4Kojr
         GKlw1kr/9cMmyyRZZ9PZTwJ4InmMLr2qXF2Bys8iAIljyFk9Phet4FeSL9SvoedKY2t/
         dmFbnuSEbhf+/F/ifGejTSlk8VfSzUADnshkEbTw0GVfWSYpDizKZwnZiparqrRz2rus
         zklA==
X-Gm-Message-State: AGRZ1gL6jYAHIW8LfRtOmai7PtITy7nRu973cacFHLAklQmAj0U9h+L5
        0rj6aZpCBS1XhZfUMLZAXnpECA9icCI=
X-Google-Smtp-Source: AJdET5f6nT7NVNn34A0VCyEaf+3Bb+GoXkUX9/Y+tecKEI7MuUVf0t0VUFLdqfJeTJHBNP+M0hgksQ==
X-Received: by 2002:a50:c31b:: with SMTP id a27-v6mr1654288edb.160.1540983486081;
        Wed, 31 Oct 2018 03:58:06 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:58:05 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/14] spi: rockchip: read transfer info directly
Date:   Wed, 31 Oct 2018 11:57:03 +0100
Message-Id: <20181031105711.19575-7-esmil@mailme.dk>
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

Just read transfer info directly from the spi device
and transfer structures rather than storing it in
driver data first.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 70 +++++++++++++-------------------------
 1 file changed, 24 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 5729e6071729..5edc51820d35 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -178,12 +178,8 @@ struct rockchip_spi {
 	/* max bus freq supported */
 	u32 max_freq;
 
-	u16 mode;
-	u8 tmode;
-	u8 bpw;
 	u8 n_bytes;
 	u32 rsd_nsecs;
-	unsigned len;
 	u32 speed;
 
 	const void *tx;
@@ -194,8 +190,6 @@ struct rockchip_spi {
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
 	bool use_dma;
-	struct sg_table tx_sg;
-	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
 	struct rockchip_spi_dma_data dma_tx;
 };
@@ -282,17 +276,6 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 	rs->cs_asserted[spi->chip_select] = cs_asserted;
 }
 
-static int rockchip_spi_prepare_message(struct spi_master *master,
-					struct spi_message *msg)
-{
-	struct rockchip_spi *rs = spi_master_get_devdata(master);
-	struct spi_device *spi = msg->spi;
-
-	rs->mode = spi->mode;
-
-	return 0;
-}
-
 static void rockchip_spi_handle_err(struct spi_master *master,
 				    struct spi_message *msg)
 {
@@ -397,14 +380,15 @@ static void rockchip_spi_dma_txcb(void *data)
 	spi_finalize_current_transfer(rs->master);
 }
 
-static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
+static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
+		struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
 	atomic_set(&rs->state, 0);
 
 	rxdesc = NULL;
-	if (rs->rx) {
+	if (xfer->rx_buf) {
 		struct dma_slave_config rxconf = {
 			.direction = DMA_DEV_TO_MEM,
 			.src_addr = rs->dma_rx.addr,
@@ -416,7 +400,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 		rxdesc = dmaengine_prep_slave_sg(
 				rs->dma_rx.ch,
-				rs->rx_sg.sgl, rs->rx_sg.nents,
+				xfer->rx_sg.sgl, xfer->rx_sg.nents,
 				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
 		if (!rxdesc)
 			return -EINVAL;
@@ -426,7 +410,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	}
 
 	txdesc = NULL;
-	if (rs->tx) {
+	if (xfer->tx_buf) {
 		struct dma_slave_config txconf = {
 			.direction = DMA_MEM_TO_DEV,
 			.dst_addr = rs->dma_tx.addr,
@@ -438,7 +422,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 		txdesc = dmaengine_prep_slave_sg(
 				rs->dma_tx.ch,
-				rs->tx_sg.sgl, rs->tx_sg.nents,
+				xfer->tx_sg.sgl, xfer->tx_sg.nents,
 				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 		if (!txdesc) {
 			if (rxdesc)
@@ -469,7 +453,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	return 1;
 }
 
-static void rockchip_spi_config(struct rockchip_spi *rs)
+static void rockchip_spi_config(struct rockchip_spi *rs,
+		struct spi_device *spi, struct spi_transfer *xfer)
 {
 	u32 div = 0;
 	u32 dmacr = 0;
@@ -481,13 +466,19 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	        | CR0_EM_BIG   << CR0_EM_OFFSET;
 
 	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
-	cr0 |= ((rs->mode & 0x3) << CR0_SCPH_OFFSET);
-	cr0 |= (rs->tmode << CR0_XFM_OFFSET);
+	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
+
+	if (xfer->rx_buf && xfer->tx_buf)
+		cr0 |= CR0_XFM_TR << CR0_XFM_OFFSET;
+	else if (xfer->rx_buf)
+		cr0 |= CR0_XFM_RO << CR0_XFM_OFFSET;
+	else
+		cr0 |= CR0_XFM_TO << CR0_XFM_OFFSET;
 
 	if (rs->use_dma) {
-		if (rs->tx)
+		if (xfer->tx_buf)
 			dmacr |= TF_DMA_EN;
-		if (rs->rx)
+		if (xfer->rx_buf)
 			dmacr |= RF_DMA_EN;
 	}
 
@@ -521,11 +512,11 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
 
 	if (rs->n_bytes == 1)
-		writel_relaxed(rs->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+		writel_relaxed(xfer->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 	else if (rs->n_bytes == 2)
-		writel_relaxed((rs->len / 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+		writel_relaxed((xfer->len / 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 	else
-		writel_relaxed((rs->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+		writel_relaxed((xfer->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_TXFTLR);
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
@@ -565,24 +556,12 @@ static int rockchip_spi_transfer_one(
 	}
 
 	rs->speed = xfer->speed_hz;
-	rs->bpw = xfer->bits_per_word;
-	rs->n_bytes = rs->bpw >> 3;
+	rs->n_bytes = xfer->bits_per_word >> 3;
 
 	rs->tx = xfer->tx_buf;
 	rs->tx_end = rs->tx + xfer->len;
 	rs->rx = xfer->rx_buf;
 	rs->rx_end = rs->rx + xfer->len;
-	rs->len = xfer->len;
-
-	rs->tx_sg = xfer->tx_sg;
-	rs->rx_sg = xfer->rx_sg;
-
-	if (rs->tx && rs->rx)
-		rs->tmode = CR0_XFM_TR;
-	else if (rs->tx)
-		rs->tmode = CR0_XFM_TO;
-	else if (rs->rx)
-		rs->tmode = CR0_XFM_RO;
 
 	/* we need prepare dma before spi was enabled */
 	if (master->can_dma && master->can_dma(master, spi, xfer))
@@ -590,10 +569,10 @@ static int rockchip_spi_transfer_one(
 	else
 		rs->use_dma = false;
 
-	rockchip_spi_config(rs);
+	rockchip_spi_config(rs, spi, xfer);
 
 	if (rs->use_dma)
-		return rockchip_spi_prepare_dma(rs);
+		return rockchip_spi_prepare_dma(rs, xfer);
 
 	return rockchip_spi_pio_transfer(rs);
 }
@@ -685,7 +664,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
 
 	master->set_cs = rockchip_spi_set_cs;
-	master->prepare_message = rockchip_spi_prepare_message;
 	master->transfer_one = rockchip_spi_transfer_one;
 	master->max_transfer_size = rockchip_spi_max_transfer_size;
 	master->handle_err = rockchip_spi_handle_err;
-- 
2.19.1

