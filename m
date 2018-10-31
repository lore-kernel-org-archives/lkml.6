Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFF9ECDE4C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C13020657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+DKMA8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C13020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeJaTzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40317 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbeJaTzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id z12-v6so7433742edp.7;
        Wed, 31 Oct 2018 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6L2wU549foJljGPiIBcWFpFzvLuh/Vo0RWU2BfnYb5Q=;
        b=S+DKMA8YkzijxKtjBV/UN4CNsifi0r/9Jxf7KE+vVbbH17/3uD2BjWZlPDJAIT0fif
         NjAzWl98pWmX+AaWUwgj7OxQa0wtaDgegOnqArPgN9uLjTjNIs5eq1mpbMhA6c/i34zw
         Vaqe+OT68VoTTi8qGAUdkt7NMkoz1LPJ9L+swqnf05HQ2myDIf5igNJij6CF3MsKD6Ce
         Z6UCR+MFzmJYjxLP/aB/ZeklC9cvpHOFluuzn8QBIJ/tt/C0AbKqwnkDSM74KrPTVR4m
         BTiVrArQFBUT2qWltp8WWlJo3T3i8MECVZqf4iM50VFInj2ub4r4ocwtGn9JjMYERhsg
         elaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6L2wU549foJljGPiIBcWFpFzvLuh/Vo0RWU2BfnYb5Q=;
        b=G7/oZUz6A1WxgRMahc6/D1Ix3ooSp2CngNfhTSJouMoJym//XMEGwXTUc2br3JG+BU
         DHvGdG+6jVhyT85gWOmaHBprA8vy+9cbs1JzRyenSOaGThkXDCYtWXJqCergHxcMfkr/
         k7kPLyevndRenhMvvtvPhQteYLssN+51pJm8sdT6xIsFtv5s8F5UBssQFErZJWSXWoYe
         pRmKlwxmbDCjsrrd9EfDW5EuPfggZcoZH0TYHPt8/XWE1SJqvqT4dAq7LgWAhKzoYwUx
         HBxdCC3DiK1havolDkmwMgXn2akq5VXOCPktHl1LUH+IP8ghoxyOiSBlNuiyYlrRo1z8
         lVHw==
X-Gm-Message-State: AGRZ1gJ/eS5N9tPzap7x3hKtubWTXR+YmIjBJ619bYfrf61SJtbDx2yD
        ozTyRj7l8KQESKPi0fx7k21CaJxLZ5s=
X-Google-Smtp-Source: AJdET5ewUzozQuWs0+rvVjukpSdwfd5Gmw3h2s5YYYPZ4a4VZoLIGCwBtJ8toxvcmo7DYliRLpLu2w==
X-Received: by 2002:aa7:d7ce:: with SMTP id e14-v6mr1539832eds.69.1540983487239;
        Wed, 31 Oct 2018 03:58:07 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:58:06 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/14] spi: rockchip: don't store dma channels twice
Date:   Wed, 31 Oct 2018 11:57:04 +0100
Message-Id: <20181031105711.19575-8-esmil@mailme.dk>
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

The spi master (aka spi controller) structure already
has two fields for storing the rx and tx dma channels.
Just use them rather than duplicating them in driver data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 76 +++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 5edc51820d35..f3fe6d4cf6f6 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -157,11 +157,6 @@
 
 #define ROCKCHIP_SPI_MAX_CS_NUM			2
 
-struct rockchip_spi_dma_data {
-	struct dma_chan *ch;
-	dma_addr_t addr;
-};
-
 struct rockchip_spi {
 	struct device *dev;
 	struct spi_master *master;
@@ -170,6 +165,8 @@ struct rockchip_spi {
 	struct clk *apb_pclk;
 
 	void __iomem *regs;
+	dma_addr_t dma_addr_rx;
+	dma_addr_t dma_addr_tx;
 
 	atomic_t state;
 
@@ -190,8 +187,6 @@ struct rockchip_spi {
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
 	bool use_dma;
-	struct rockchip_spi_dma_data dma_rx;
-	struct rockchip_spi_dma_data dma_tx;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
@@ -287,10 +282,10 @@ static void rockchip_spi_handle_err(struct spi_master *master,
 	spi_enable_chip(rs, false);
 
 	if (atomic_read(&rs->state) & TXDMA)
-		dmaengine_terminate_async(rs->dma_tx.ch);
+		dmaengine_terminate_async(master->dma_tx);
 
 	if (atomic_read(&rs->state) & RXDMA)
-		dmaengine_terminate_async(rs->dma_rx.ch);
+		dmaengine_terminate_async(master->dma_rx);
 }
 
 static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
@@ -381,7 +376,7 @@ static void rockchip_spi_dma_txcb(void *data)
 }
 
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
-		struct spi_transfer *xfer)
+		struct spi_master *master, struct spi_transfer *xfer)
 {
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
@@ -391,15 +386,15 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 	if (xfer->rx_buf) {
 		struct dma_slave_config rxconf = {
 			.direction = DMA_DEV_TO_MEM,
-			.src_addr = rs->dma_rx.addr,
+			.src_addr = rs->dma_addr_rx,
 			.src_addr_width = rs->n_bytes,
 			.src_maxburst = 1,
 		};
 
-		dmaengine_slave_config(rs->dma_rx.ch, &rxconf);
+		dmaengine_slave_config(master->dma_rx, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
-				rs->dma_rx.ch,
+				master->dma_rx,
 				xfer->rx_sg.sgl, xfer->rx_sg.nents,
 				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
 		if (!rxdesc)
@@ -413,20 +408,20 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 	if (xfer->tx_buf) {
 		struct dma_slave_config txconf = {
 			.direction = DMA_MEM_TO_DEV,
-			.dst_addr = rs->dma_tx.addr,
+			.dst_addr = rs->dma_addr_tx,
 			.dst_addr_width = rs->n_bytes,
 			.dst_maxburst = rs->fifo_len / 2,
 		};
 
-		dmaengine_slave_config(rs->dma_tx.ch, &txconf);
+		dmaengine_slave_config(master->dma_tx, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
-				rs->dma_tx.ch,
+				master->dma_tx,
 				xfer->tx_sg.sgl, xfer->tx_sg.nents,
 				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 		if (!txdesc) {
 			if (rxdesc)
-				dmaengine_terminate_sync(rs->dma_rx.ch);
+				dmaengine_terminate_sync(master->dma_rx);
 			return -EINVAL;
 		}
 
@@ -438,7 +433,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 	if (rxdesc) {
 		atomic_or(RXDMA, &rs->state);
 		dmaengine_submit(rxdesc);
-		dma_async_issue_pending(rs->dma_rx.ch);
+		dma_async_issue_pending(master->dma_rx);
 	}
 
 	spi_enable_chip(rs, true);
@@ -446,7 +441,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 	if (txdesc) {
 		atomic_or(TXDMA, &rs->state);
 		dmaengine_submit(txdesc);
-		dma_async_issue_pending(rs->dma_tx.ch);
+		dma_async_issue_pending(master->dma_tx);
 	}
 
 	/* 1 means the transfer is in progress */
@@ -572,7 +567,7 @@ static int rockchip_spi_transfer_one(
 	rockchip_spi_config(rs, spi, xfer);
 
 	if (rs->use_dma)
-		return rockchip_spi_prepare_dma(rs, xfer);
+		return rockchip_spi_prepare_dma(rs, master, xfer);
 
 	return rockchip_spi_pio_transfer(rs);
 }
@@ -669,34 +664,31 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->handle_err = rockchip_spi_handle_err;
 	master->flags = SPI_MASTER_GPIO_SS;
 
-	rs->dma_tx.ch = dma_request_chan(rs->dev, "tx");
-	if (IS_ERR(rs->dma_tx.ch)) {
+	master->dma_tx = dma_request_chan(rs->dev, "tx");
+	if (IS_ERR(master->dma_tx)) {
 		/* Check tx to see if we need defer probing driver */
-		if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
+		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			goto err_disable_pm_runtime;
 		}
 		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
-		rs->dma_tx.ch = NULL;
+		master->dma_tx = NULL;
 	}
 
-	rs->dma_rx.ch = dma_request_chan(rs->dev, "rx");
-	if (IS_ERR(rs->dma_rx.ch)) {
-		if (PTR_ERR(rs->dma_rx.ch) == -EPROBE_DEFER) {
+	master->dma_rx = dma_request_chan(rs->dev, "rx");
+	if (IS_ERR(master->dma_rx)) {
+		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			goto err_free_dma_tx;
 		}
 		dev_warn(rs->dev, "Failed to request RX DMA channel\n");
-		rs->dma_rx.ch = NULL;
+		master->dma_rx = NULL;
 	}
 
-	if (rs->dma_tx.ch && rs->dma_rx.ch) {
-		rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
-		rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
-
+	if (master->dma_tx && master->dma_rx) {
+		rs->dma_addr_tx = mem->start + ROCKCHIP_SPI_TXDR;
+		rs->dma_addr_rx = mem->start + ROCKCHIP_SPI_RXDR;
 		master->can_dma = rockchip_spi_can_dma;
-		master->dma_tx = rs->dma_tx.ch;
-		master->dma_rx = rs->dma_rx.ch;
 	}
 
 	ret = devm_spi_register_master(&pdev->dev, master);
@@ -708,11 +700,11 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_dma_rx:
-	if (rs->dma_rx.ch)
-		dma_release_channel(rs->dma_rx.ch);
+	if (master->dma_rx)
+		dma_release_channel(master->dma_rx);
 err_free_dma_tx:
-	if (rs->dma_tx.ch)
-		dma_release_channel(rs->dma_tx.ch);
+	if (master->dma_tx)
+		dma_release_channel(master->dma_tx);
 err_disable_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
 err_disable_spiclk:
@@ -739,10 +731,10 @@ static int rockchip_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-	if (rs->dma_tx.ch)
-		dma_release_channel(rs->dma_tx.ch);
-	if (rs->dma_rx.ch)
-		dma_release_channel(rs->dma_rx.ch);
+	if (master->dma_tx)
+		dma_release_channel(master->dma_tx);
+	if (master->dma_rx)
+		dma_release_channel(master->dma_rx);
 
 	spi_master_put(master);
 
-- 
2.19.1

