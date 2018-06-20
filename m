Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9660C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D24520693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTY9Bo1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D24520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754703AbeFTJnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:43:32 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45395 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754106AbeFTI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:28:36 -0400
Received: by mail-lf0-f67.google.com with SMTP id a13-v6so3595589lfk.12;
        Wed, 20 Jun 2018 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fw3XjwJ0NAMzgkhD7GaMaFf8WDklx65QFGxdKqBfgS4=;
        b=pTY9Bo1ToLWtI+RcY50c3YPbtcie91QH87xx8ZFdMKUGDaIDFwsVjoVOuwWQxhVLCd
         0obt7Oo+wj4hSJs0PzmPBaXaHZSGkk5l8OUlhbHWg2E0SFAHe94R7TI6iLFPobK55jwP
         hOkTaTvIJT7HKvBt7qkGguC1ETMWbYHqGlxDzvGWaX6DipF7yul6xZSHYNgeWDqkX5ay
         mHE1ZRE8FedVLY+sJR4yZtTD6gqJ4/HSLQnLCBEZMNBaNKMb6530C2/4GiMDn0UKAchm
         MiECBosuxLnSLbrXkWpandPCHveME6m89HOwhvCkQQ/SadFzlCdEPRlMH8A1Moe6xfzv
         FFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fw3XjwJ0NAMzgkhD7GaMaFf8WDklx65QFGxdKqBfgS4=;
        b=kk31qDD1IcmWF4w3LyYOnrb78ZOLf6X6Dxi/boSvMG39JDSo5BGEKX9SauGfTEz7RS
         qk2leJeQubqz3CLcdfphYvTie/S/tCSK3ocuI9S/cqurCd5W2nlazOdHi2jL5waMLWyP
         I4eQunDKTawQR9PNPPr6SnKA/tLwbuFFOUSP4v1jqRFK1MNEhQNrY+wG3gyvGSS1YFD1
         gn5ZWKBdL4Qh6+e61CEdXrejsd0HSYU6wLUebej9CNsALkG/UGjv2NpXLcZCmet6coG5
         1KazHpS7UOjoVlOLLrimV1J35hEy/CdjqTghwNrqtqiIVHdFiaG5E6vUquCJVkaEchbq
         DeVA==
X-Gm-Message-State: APt69E2woenHU5vMUyIUG9WnQ5tJR4epMPmd1/U5em8BDOu/CE3fkywi
        O9ftHwhe4g6L8X3ZNxt29cnKaBok
X-Google-Smtp-Source: ADUXVKI6JKX9G+nAubE5INEy+/U4xJA22vjSn6k+MpVCQQWyCz26iFgYRofWFX+4ZDsSeAFoa83lwQ==
X-Received: by 2002:a19:6a0f:: with SMTP id u15-v6mr12805125lfu.81.1529480096950;
        Wed, 20 Jun 2018 00:34:56 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id i5-v6sm281738lfc.83.2018.06.20.00.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:34:56 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 05/12] spi: spi-fsl-dspi: Support 4 to 16 bits per word transfers
Date:   Wed, 20 Jun 2018 09:34:35 +0200
Message-Id: <20180620073442.20913-6-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620073442.20913-1-esben.haabendal@gmail.com>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

This extends the driver with support for all SPI framesizes from 4 to 16
bits, and adds support for per transfer specific bits_per_word, while at
the same time reducing code size and complexity.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 251 +++++++++++++------------------------
 1 file changed, 88 insertions(+), 163 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 2371b9978e65..df07dd4722fb 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -38,8 +38,6 @@
 
 #define DRIVER_NAME "fsl-dspi"
 
-#define TRAN_STATE_WORD_ODD_NUM	0x04
-
 #define DSPI_FIFO_SIZE			4
 #define DSPI_DMA_BUFSIZE		(DSPI_FIFO_SIZE * 1024)
 
@@ -187,13 +185,13 @@ struct fsl_dspi {
 	struct spi_message	*cur_msg;
 	struct chip_data	*cur_chip;
 	size_t			len;
-	void			*tx;
-	void			*tx_end;
+	const void		*tx;
 	void			*rx;
 	void			*rx_end;
-	char			dataflags;
 	u16			void_write_data;
 	u16			tx_cmd;
+	u8			bits_per_word;
+	u8			bytes_per_word;
 	const struct fsl_dspi_devtype_data *devtype_data;
 
 	wait_queue_head_t	waitq;
@@ -202,15 +200,43 @@ struct fsl_dspi {
 	struct fsl_dspi_dma	*dma;
 };
 
-static u32 dspi_data_to_pushr(struct fsl_dspi *dspi, int tx_word);
+static u16 dspi_pop_tx(struct fsl_dspi *dspi)
+{
+	u16 txdata = 0;
+
+	if (dspi->tx) {
+		if (dspi->bytes_per_word == 1)
+			txdata = *(u8 *)dspi->tx;
+		else /* dspi->bytes_per_word == 2 */
+			txdata = *(u16 *)dspi->tx;
+		dspi->tx += dspi->bytes_per_word;
+	}
+	dspi->len -= dspi->bytes_per_word;
+	return txdata;
+}
 
-static inline int is_double_byte_mode(struct fsl_dspi *dspi)
+static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
-	unsigned int val;
+	u16 cmd = dspi->tx_cmd, data = dspi_pop_tx(dspi);
 
-	regmap_read(dspi->regmap, SPI_CTAR(0), &val);
+	if (dspi->len > 0)
+		cmd |= SPI_PUSHR_CMD_CONT;
+	return cmd << 16 | data;
+}
+
+static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
+{
+	if (!dspi->rx)
+		return;
+
+	/* Mask of undefined bits */
+	rxdata &= (1 << dspi->bits_per_word) - 1;
 
-	return ((val & SPI_FRAME_BITS_MASK) == SPI_FRAME_BITS(8)) ? 0 : 1;
+	if (dspi->bytes_per_word == 1)
+		*(u8 *)dspi->rx = rxdata;
+	else /* dspi->bytes_per_word == 2 */
+		*(u16 *)dspi->rx = rxdata;
+	dspi->rx += dspi->bytes_per_word;
 }
 
 static void dspi_tx_dma_callback(void *arg)
@@ -225,19 +251,11 @@ static void dspi_rx_dma_callback(void *arg)
 {
 	struct fsl_dspi *dspi = arg;
 	struct fsl_dspi_dma *dma = dspi->dma;
-	int rx_word;
 	int i;
-	u16 d;
-
-	rx_word = is_double_byte_mode(dspi);
 
 	if (dspi->rx) {
-		for (i = 0; i < dma->curr_xfer_len; i++) {
-			d = dspi->dma->rx_dma_buf[i];
-			rx_word ? (*(u16 *)dspi->rx = d) :
-						(*(u8 *)dspi->rx = d);
-			dspi->rx += rx_word + 1;
-		}
+		for (i = 0; i < dma->curr_xfer_len; i++)
+			dspi_push_rx(dspi, dspi->dma->rx_dma_buf[i]);
 	}
 
 	complete(&dma->cmd_rx_complete);
@@ -248,14 +266,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	struct fsl_dspi_dma *dma = dspi->dma;
 	struct device *dev = &dspi->pdev->dev;
 	int time_left;
-	int tx_word;
 	int i;
 
-	tx_word = is_double_byte_mode(dspi);
-
-	for (i = 0; i < dma->curr_xfer_len; i++) {
-		dspi->dma->tx_dma_buf[i] = dspi_data_to_pushr(dspi, tx_word);
-	}
+	for (i = 0; i < dma->curr_xfer_len; i++)
+		dspi->dma->tx_dma_buf[i] = dspi_pop_tx_pushr(dspi);
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
 					dma->tx_dma_phys,
@@ -326,16 +340,14 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 	struct device *dev = &dspi->pdev->dev;
 	int curr_remaining_bytes;
 	int bytes_per_buffer;
-	int word = 1;
 	int ret = 0;
 
-	if (is_double_byte_mode(dspi))
-		word = 2;
 	curr_remaining_bytes = dspi->len;
 	bytes_per_buffer = DSPI_DMA_BUFSIZE / DSPI_FIFO_SIZE;
 	while (curr_remaining_bytes) {
 		/* Check if current transfer fits the DMA buffer */
-		dma->curr_xfer_len = curr_remaining_bytes / word;
+		dma->curr_xfer_len = curr_remaining_bytes
+			/ dspi->bytes_per_word;
 		if (dma->curr_xfer_len > bytes_per_buffer)
 			dma->curr_xfer_len = bytes_per_buffer;
 
@@ -345,7 +357,8 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 			goto exit;
 
 		} else {
-			curr_remaining_bytes -= dma->curr_xfer_len * word;
+			curr_remaining_bytes -= dma->curr_xfer_len
+				* dspi->bytes_per_word;
 			if (curr_remaining_bytes < 0)
 				curr_remaining_bytes = 0;
 		}
@@ -531,127 +544,56 @@ static void ns_delay_scale(char *psc, char *sc, int delay_ns,
 	}
 }
 
-static u32 dspi_data_to_pushr(struct fsl_dspi *dspi, int tx_word)
+static void fifo_write(struct fsl_dspi *dspi)
 {
-	u16 data, cmd;
-
-	if (dspi->tx) {
-		data = tx_word ? *(u16 *)dspi->tx : *(u8 *)dspi->tx;
-		dspi->tx += tx_word + 1;
-	} else {
-		data = dspi->void_write_data;
-	}
-
-	dspi->len -= tx_word + 1;
-
-	cmd = dspi->tx_cmd;
-	if (dspi->len > 0)
-		cmd |= SPI_PUSHR_CMD_CONT;
-
-	return (cmd << 16) | SPI_PUSHR_TXDATA(data);
+	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pop_tx_pushr(dspi));
 }
 
-static void dspi_data_from_popr(struct fsl_dspi *dspi, int rx_word)
+static void dspi_tcfq_write(struct fsl_dspi *dspi)
 {
-	u16 d;
-	unsigned int val;
-
-	regmap_read(dspi->regmap, SPI_POPR, &val);
-	d = SPI_POPR_RXDATA(val);
-
-	if (dspi->rx) {
-		rx_word ? (*(u16 *)dspi->rx = d) : (*(u8 *)dspi->rx = d);
-		dspi->rx += rx_word + 1;
-	}
+	/* Clear transfer count */
+	dspi->tx_cmd |= SPI_PUSHR_CMD_CTCNT;
+	/* Write one entry to both TX FIFO and CMD FIFO simultaneously */
+	fifo_write(dspi);
 }
 
-static int dspi_eoq_write(struct fsl_dspi *dspi)
+static u32 fifo_read(struct fsl_dspi *dspi)
 {
-	int tx_count = 0;
-	int tx_word;
-	u32 dspi_pushr = 0;
-
-	tx_word = is_double_byte_mode(dspi);
+	u32 rxdata = 0;
 
-	while (dspi->len && (tx_count < DSPI_FIFO_SIZE)) {
-		/* If we are in word mode, only have a single byte to transfer
-		 * switch to byte mode temporarily.  Will switch back at the
-		 * end of the transfer.
-		 */
-		if (tx_word && (dspi->len == 1)) {
-			dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
-			regmap_update_bits(dspi->regmap, SPI_CTAR(0),
-					SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
-			tx_word = 0;
-		}
-
-		dspi_pushr = dspi_data_to_pushr(dspi, tx_word);
-
-		if (dspi->len == 0 || tx_count == DSPI_FIFO_SIZE - 1)
-			/* request EOQ flag for last transfer in queue */
-			dspi_pushr |= SPI_PUSHR_EOQ;
-
-		/* Clear transfer counter on first transfer (in FIFO) */
-		if (tx_count == 0)
-			dspi_pushr |= SPI_PUSHR_CTCNT;
-
-		regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
-
-		tx_count++;
-	}
-
-	return tx_count * (tx_word + 1);
+	regmap_read(dspi->regmap, SPI_POPR, &rxdata);
+	return rxdata;
 }
 
-static int dspi_eoq_read(struct fsl_dspi *dspi)
+static void dspi_tcfq_read(struct fsl_dspi *dspi)
 {
-	int rx_count = 0;
-	int rx_word = is_double_byte_mode(dspi);
-
-	while ((dspi->rx < dspi->rx_end)
-			&& (rx_count < DSPI_FIFO_SIZE)) {
-		if (rx_word && (dspi->rx_end - dspi->rx) == 1)
-			rx_word = 0;
-
-		dspi_data_from_popr(dspi, rx_word);
-		rx_count++;
-	}
-
-	return rx_count;
+	dspi_push_rx(dspi, fifo_read(dspi));
 }
 
-static int dspi_tcfq_write(struct fsl_dspi *dspi)
+static void dspi_eoq_write(struct fsl_dspi *dspi)
 {
-	int tx_word;
-	u32 dspi_pushr = 0;
-
-	tx_word = is_double_byte_mode(dspi);
-
-	if (tx_word && (dspi->len == 1)) {
-		dspi->dataflags |= TRAN_STATE_WORD_ODD_NUM;
-		regmap_update_bits(dspi->regmap, SPI_CTAR(0),
-				SPI_FRAME_BITS_MASK, SPI_FRAME_BITS(8));
-		tx_word = 0;
+	int fifo_size = DSPI_FIFO_SIZE;
+
+	/* Fill TX FIFO with as many transfers as possible */
+	while (dspi->len && fifo_size--) {
+		/* Request EOQF for last transfer in FIFO */
+		if (dspi->len == dspi->bytes_per_word || fifo_size == 0)
+			dspi->tx_cmd |= SPI_PUSHR_CMD_EOQ;
+		/* Clear transfer count for first transfer in FIFO */
+		if (fifo_size == (DSPI_FIFO_SIZE - 1))
+			dspi->tx_cmd |= SPI_PUSHR_CMD_CTCNT;
+		/* Write combined TX FIFO and CMD FIFO entry */
+		fifo_write(dspi);
 	}
-
-	dspi_pushr = dspi_data_to_pushr(dspi, tx_word);
-
-	/* Clear transfer counter on each transfer */
-	dspi_pushr |= SPI_PUSHR_CTCNT;
-
-	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
-
-	return tx_word + 1;
 }
 
-static void dspi_tcfq_read(struct fsl_dspi *dspi)
+static void dspi_eoq_read(struct fsl_dspi *dspi)
 {
-	int rx_word = is_double_byte_mode(dspi);
-
-	if (rx_word && (dspi->rx_end - dspi->rx) == 1)
-		rx_word = 0;
+	int fifo_size = DSPI_FIFO_SIZE;
 
-	dspi_data_from_popr(dspi, rx_word);
+	/* Read one FIFO entry at and push to rx buffer */
+	while ((dspi->rx < dspi->rx_end) && fifo_size--)
+		dspi_push_rx(dspi, fifo_read(dspi));
 }
 
 static int dspi_transfer_one_message(struct spi_master *master,
@@ -691,19 +633,24 @@ static int dspi_transfer_one_message(struct spi_master *master,
 
 		dspi->void_write_data = dspi->cur_chip->void_write_data;
 
-		dspi->dataflags = 0;
-		dspi->tx = (void *)transfer->tx_buf;
-		dspi->tx_end = dspi->tx + transfer->len;
+		dspi->tx = transfer->tx_buf;
 		dspi->rx = transfer->rx_buf;
 		dspi->rx_end = dspi->rx + transfer->len;
 		dspi->len = transfer->len;
+		/* Validated transfer specific frame size (defaults applied) */
+		dspi->bits_per_word = transfer->bits_per_word;
+		if (transfer->bits_per_word <= 8)
+			dspi->bytes_per_word = 1;
+		else
+			dspi->bytes_per_word = 2;
 
 		regmap_write(dspi->regmap, SPI_MCR, dspi->cur_chip->mcr_val);
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
 				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
 		regmap_write(dspi->regmap, SPI_CTAR(0),
-				dspi->cur_chip->ctar_val);
+			     dspi->cur_chip->ctar_val |
+			     SPI_FRAME_BITS(transfer->bits_per_word));
 
 		trans_mode = dspi->devtype_data->trans_mode;
 		switch (trans_mode) {
@@ -754,16 +701,9 @@ static int dspi_setup(struct spi_device *spi)
 	struct fsl_dspi_platform_data *pdata;
 	u32 cs_sck_delay = 0, sck_cs_delay = 0;
 	unsigned char br = 0, pbr = 0, pcssck = 0, cssck = 0;
-	unsigned char pasc = 0, asc = 0, fmsz = 0;
+	unsigned char pasc = 0, asc = 0;
 	unsigned long clkrate;
 
-	if ((spi->bits_per_word >= 4) && (spi->bits_per_word <= 16)) {
-		fmsz = spi->bits_per_word - 1;
-	} else {
-		pr_err("Invalid wordsize\n");
-		return -ENODEV;
-	}
-
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
 	if (chip == NULL) {
@@ -799,8 +739,7 @@ static int dspi_setup(struct spi_device *spi)
 	/* Set After SCK delay scale values */
 	ns_delay_scale(&pasc, &asc, sck_cs_delay, clkrate);
 
-	chip->ctar_val =  SPI_CTAR_FMSZ(fmsz)
-		| SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
+	chip->ctar_val = SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
 		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0)
 		| SPI_CTAR_LSBFE(spi->mode & SPI_LSB_FIRST ? 1 : 0)
 		| SPI_CTAR_PCSSCK(pcssck)
@@ -832,24 +771,19 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	enum dspi_trans_mode trans_mode;
 	u32 spi_sr, spi_tcr;
 	u16 spi_tcnt;
-	int tx_word;
 
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
 
 	if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)) {
-		tx_word = is_double_byte_mode(dspi);
-
 		/* Get transfer counter (in number of SPI transfers). It was
 		 * reset to 0 when transfer(s) were started.
 		 */
 		regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
 		spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
-
 		/* Update total number of bytes that were transferred */
-		msg->actual_length += spi_tcnt * (tx_word + 1) -
-			(dspi->dataflags & TRAN_STATE_WORD_ODD_NUM ? 1 : 0);
+		msg->actual_length += spi_tcnt * dspi->bytes_per_word;
 
 		trans_mode = dspi->devtype_data->trans_mode;
 		switch (trans_mode) {
@@ -866,14 +800,6 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 		}
 
 		if (!dspi->len) {
-			if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM) {
-				regmap_update_bits(dspi->regmap,
-						   SPI_CTAR(0),
-						   SPI_FRAME_BITS_MASK,
-						   SPI_FRAME_BITS(16));
-				dspi->dataflags &= ~TRAN_STATE_WORD_ODD_NUM;
-			}
-
 			dspi->waitflags = 1;
 			wake_up_interruptible(&dspi->waitq);
 		} else {
@@ -973,8 +899,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 	master->cleanup = dspi_cleanup;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_MASK(4) | SPI_BPW_MASK(8) |
-					SPI_BPW_MASK(16);
+	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata) {
-- 
2.17.1

