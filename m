Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04111C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34A121873
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQIT6sqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbeLXWBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:01:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40293 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLXWA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:00:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so12538359wrt.7;
        Mon, 24 Dec 2018 14:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/dxqt3tp6qsJqzp3vdths3EvzvbbJ9XcxYBs6r05qAg=;
        b=jQIT6sqZ7zscFC8xtSSwO92BCkjGbVkFkx+bbAic71TiPvwIngTSXw6/N9GrszJhYc
         Kn10vBCtjLlfwl+XXFlyLC0zPEh1Oqagck9T5R9pwh1F2+OJHC6b9AONTeQal8upA/Nh
         nFfMIFGWM8FIOMslhjf3zPoCFY5vIpmUb43uvq1KCTYkrQae+f5pQNXFe4F+I4ylcZjP
         f6PU9CHyOgaOU1dH2kbYif2IIlLnBMc8B+F+hz5IbwnEyinHIK79NxPk3u2jh3FxrP8a
         EbM4oW/q0GU3JR8EHrL8PKIj1Lmcc9M1rVgr0HyngXuj/BtQCz0zYkwHjofVwN0K4fBb
         RDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/dxqt3tp6qsJqzp3vdths3EvzvbbJ9XcxYBs6r05qAg=;
        b=XbYxweaKV9IuStRZoqC0YNY4wIHpET9NseCeZuo5rDbMHSBPPRdwtooyifW//HfhE8
         IokTRPcaRne3sKXD8PIWVwU7qwplTAr2TpIJfIlbuXBbjHx02ACbCd4Bb8oBi/RUqBNV
         fO1ULfQ00cLUurbGM7mjpNKPlZgVkhPt8gflE+3scD4P5K2047H7Vlj9aip53vUW/9+W
         Tz5KWmxCMCzPZCGVQ5UgJDnv2hdwD1ajr9JW3HOtf9JGeytByYQQT6lxd5pL8LlwDSfh
         Tr+rQEkAYNVZhA2uH1ix5fuhwvH+6OE13IwOhY9Vtp0zznTDh0k5oeScap4h/Qqar+WR
         S5vA==
X-Gm-Message-State: AJcUukfHgvnPJ78KIWy9M89o9+4t2XV/QTJjDZJoNxT6dx9AdmGLBad3
        JhJ3OJ3Uy+LCeVCkJLxq+lM=
X-Google-Smtp-Source: ALg8bN7Zy4jxuXQT5X2n53KQJ7RlIZreYnqPM4t1Yrn+mlVu3nZO3yfNk73YfPUnI4T0LySqWhZc6w==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr13426930wro.262.1545688857400;
        Mon, 24 Dec 2018 14:00:57 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:00:56 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH v2 03/14] spi: stm32: fix DMA configuration with only one channel
Date:   Mon, 24 Dec 2018 23:00:29 +0100
Message-Id: <1545688840-23992-4-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

When SPI driver is configured to work only with TX or RX DMA channel
then dmaengine functions can dereferene NULL pointer.

Running full-duplex mode when when only RX or TX DMA channel is
available can cause overrun condition or incorrect writing to transmit
buffer so disable this types of DMA configuration and go back to
interrupt mode.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 51d7f72..8310f14 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -427,9 +427,9 @@ static void stm32_spi_disable(struct stm32_spi *spi)
 	if (!spi->cur_usedma && spi->rx_buf && (spi->rx_len > 0))
 		stm32_spi_read_rxfifo(spi, true);
 
-	if (spi->cur_usedma && spi->tx_buf)
+	if (spi->cur_usedma && spi->dma_tx)
 		dmaengine_terminate_all(spi->dma_tx);
-	if (spi->cur_usedma && spi->rx_buf)
+	if (spi->cur_usedma && spi->dma_rx)
 		dmaengine_terminate_all(spi->dma_rx);
 
 	stm32_spi_clr_bits(spi, STM32_SPI_CR1, SPI_CR1_SPE);
@@ -750,7 +750,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	spin_lock_irqsave(&spi->lock, flags);
 
 	rx_dma_desc = NULL;
-	if (spi->rx_buf) {
+	if (spi->rx_buf && spi->dma_rx) {
 		stm32_spi_dma_config(spi, &rx_dma_conf, DMA_DEV_TO_MEM);
 		dmaengine_slave_config(spi->dma_rx, &rx_dma_conf);
 
@@ -765,7 +765,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	}
 
 	tx_dma_desc = NULL;
-	if (spi->tx_buf) {
+	if (spi->tx_buf && spi->dma_tx) {
 		stm32_spi_dma_config(spi, &tx_dma_conf, DMA_MEM_TO_DEV);
 		dmaengine_slave_config(spi->dma_tx, &tx_dma_conf);
 
@@ -776,8 +776,11 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 					DMA_PREP_INTERRUPT);
 	}
 
-	if ((spi->tx_buf && !tx_dma_desc) ||
-	    (spi->rx_buf && !rx_dma_desc))
+	if ((spi->tx_buf && spi->dma_tx && !tx_dma_desc) ||
+	    (spi->rx_buf && spi->dma_rx && !rx_dma_desc))
+		goto dma_desc_error;
+
+	if (spi->cur_comm == SPI_FULL_DUPLEX && (!tx_dma_desc || !rx_dma_desc))
 		goto dma_desc_error;
 
 	if (rx_dma_desc) {
@@ -822,7 +825,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	return 1;
 
 dma_submit_error:
-	if (spi->rx_buf)
+	if (spi->dma_rx)
 		dmaengine_terminate_all(spi->dma_rx);
 
 dma_desc_error:
@@ -832,6 +835,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 
 	dev_info(spi->dev, "DMA issue: fall back to irq transfer\n");
 
+	spi->cur_usedma = false;
 	return stm32_spi_transfer_one_irq(spi);
 }
 
@@ -984,7 +988,7 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 	spi->rx_len = spi->rx_buf ? transfer->len : 0;
 
 	spi->cur_usedma = (master->can_dma &&
-			   stm32_spi_can_dma(master, spi_dev, transfer));
+			   master->can_dma(master, spi_dev, transfer));
 
 	ret = stm32_spi_transfer_one_setup(spi, spi_dev, transfer);
 	if (ret) {
-- 
2.7.4

