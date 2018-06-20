Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A99EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0357A208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJI3WfFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0357A208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbeFTInA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:43:00 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45302 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932527AbeFTImv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:42:51 -0400
Received: by mail-lf0-f66.google.com with SMTP id a13-v6so3657699lfk.12;
        Wed, 20 Jun 2018 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oII4ZMKbJXtwvBgGAutyEFsQJzcGEkFEHVIYwbDTpE8=;
        b=gJI3WfFGKj7f1KrBjHg9da9yDKbv1OUQD5WySvqLq8x6cJ3PPl3IPsokcqf/uDs46l
         tNUQN75VGRkFtPnlnif0OiS2tU1ovTYTe4VI/dx1QNLsDkqksEc1nBGhgC3vwcZFcbOo
         Q9EjixdkpefVFB8qdspfI3rAaC3tyXxaFGPPSJsyrjTV+88G+kb3aF/bwcPU9KDTmV35
         nwej/htmQwe+CObYqWGghC+v6oYNDsw6Bbkd4osZTPml+fr2ytuWiqT4LZTwXllaEn0R
         FkTzIGRex9wHkQhJfYEj2GqXs+yr8YG3hxTf4qQ3euakp2QkH+naDxrdiQL6Gkki4+/e
         DKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oII4ZMKbJXtwvBgGAutyEFsQJzcGEkFEHVIYwbDTpE8=;
        b=IrlSK4KVlnWKtAGHKhIX5TU+de3QbFLXe+977aO2oubuS13j1F9ZcNrRmkvenQVAuL
         R1WVQAlidPtBEn3CNOfWafod0auTxugtV/F7IURq3iEYJYXWpNZjm0TMGbU6uHfaiIU1
         6UMDvAOTAn0AefYoM5NBBE0Ncj7dFu4EFLR5zTsROchhJVORCh8/NdsYB7/Fev/C5TIn
         R5NA8/bghWLaS+KES2Qx8or8bPgytWo/4m7R3lJ11VmiUum7pmAdkyODTuZxvlzg22q1
         tqiK2IsbJGrukw8UFrQpI0gASEYuCmzczngnSEIwuEtuhXBSUobJuZ1EmPoaJ1jvJrZP
         3s0A==
X-Gm-Message-State: APt69E2tGjEyF0M6M+Ebdy53xzaWm5sNhbncRxbYcGpk8CR7xhq9Woah
        JPTYtv0fT67sHu/fmsiKC27GGRP0
X-Google-Smtp-Source: ADUXVKIdW3ofr1MvDhAe0RGI14wsDKIuUHbpMhDiID5RB5jQ4+yhM4tQUYPPKo9loar8es44+mUJeA==
X-Received: by 2002:a2e:428e:: with SMTP id h14-v6mr13911951ljf.136.1529480091789;
        Wed, 20 Jun 2018 00:34:51 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id y71-v6sm123532lfk.5.2018.06.20.00.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:34:51 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 03/12] spi: spi-fsl-dspi: Fix per transfer cs_change handling
Date:   Wed, 20 Jun 2018 09:34:33 +0200
Message-Id: <20180620073442.20913-4-esben.haabendal@gmail.com>
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

As of 92dc20d83adec565378254c0630e839ff5674e14, transfer->cs_change has
been supported for non-last transfers, but not for last transfer.

This change brings handling of cs_change in line with the specification in
spi.h, implementing handling of transfer->cs_change for all transfers.

The value for CMD FIFO is precalculated with transfer->cs_change field
taken into account, allowing for CS de-activate between transfers and
keeping CS activated after last transfer.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>

fixup! spi: spi-fsl-dspi: Fix per transfer cs_change handling
---
 drivers/spi/spi-fsl-dspi.c | 68 ++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3bf135bf8b93..c0c3b8bf2781 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -84,11 +84,16 @@
 #define SPI_RSER_TCFQE		0x80000000
 
 #define SPI_PUSHR		0x34
-#define SPI_PUSHR_CONT		(1 << 31)
-#define SPI_PUSHR_CTAS(x)	(((x) & 0x00000003) << 28)
-#define SPI_PUSHR_EOQ		(1 << 27)
-#define SPI_PUSHR_CTCNT	(1 << 26)
-#define SPI_PUSHR_PCS(x)	(((1 << x) & 0x0000003f) << 16)
+#define SPI_PUSHR_CMD_CONT	(1 << 15)
+#define SPI_PUSHR_CONT		(SPI_PUSHR_CMD_CONT << 16)
+#define SPI_PUSHR_CMD_CTAS(x)	(((x) & 0x0003) << 12)
+#define SPI_PUSHR_CTAS(x)	(SPI_PUSHR_CMD_CTAS(x) << 16)
+#define SPI_PUSHR_CMD_EOQ	(1 << 11)
+#define SPI_PUSHR_EOQ		(SPI_PUSHR_CMD_EOQ << 16)
+#define SPI_PUSHR_CMD_CTCNT	(1 << 10)
+#define SPI_PUSHR_CTCNT		(SPI_PUSHR_CMD_CTCNT << 16)
+#define SPI_PUSHR_CMD_PCS(x)	((1 << x) & 0x003f)
+#define SPI_PUSHR_PCS(x)	(SPI_PUSHR_CMD_PCS(x) << 16)
 #define SPI_PUSHR_TXDATA(x)	((x) & 0x0000ffff)
 
 #define SPI_PUSHR_SLAVE	0x34
@@ -189,9 +194,8 @@ struct fsl_dspi {
 	void			*rx;
 	void			*rx_end;
 	char			dataflags;
-	u8			cs;
 	u16			void_write_data;
-	u32			cs_change;
+	u16			tx_cmd;
 	const struct fsl_dspi_devtype_data *devtype_data;
 
 	wait_queue_head_t	waitq;
@@ -254,8 +258,6 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	for (i = 0; i < dma->curr_xfer_len; i++) {
 		dspi->dma->tx_dma_buf[i] = dspi_data_to_pushr(dspi, tx_word);
-		if ((dspi->cs_change) && (!dspi->len))
-			dspi->dma->tx_dma_buf[i] &= ~SPI_PUSHR_CONT;
 	}
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
@@ -534,21 +536,22 @@ static void ns_delay_scale(char *psc, char *sc, int delay_ns,
 
 static u32 dspi_data_to_pushr(struct fsl_dspi *dspi, int tx_word)
 {
-	u16 d16;
+	u16 data, cmd;
 
 	if (dspi->tx) {
-		d16 = tx_word ? *(u16 *)dspi->tx : *(u8 *)dspi->tx;
+		data = tx_word ? *(u16 *)dspi->tx : *(u8 *)dspi->tx;
 		dspi->tx += tx_word + 1;
 	} else {
-		d16 = dspi->void_write_data;
+		data = dspi->void_write_data;
 	}
 
 	dspi->len -= tx_word + 1;
 
-	return	SPI_PUSHR_TXDATA(d16) |
-		SPI_PUSHR_PCS(dspi->cs) |
-		SPI_PUSHR_CTAS(0) |
-		SPI_PUSHR_CONT;
+	cmd = dspi->tx_cmd;
+	if (dspi->len > 0)
+		cmd |= SPI_PUSHR_CMD_CONT;
+
+	return (cmd << 16) | SPI_PUSHR_TXDATA(data);
 }
 
 static void dspi_data_from_popr(struct fsl_dspi *dspi, int rx_word)
@@ -587,12 +590,9 @@ static int dspi_eoq_write(struct fsl_dspi *dspi)
 
 		dspi_pushr = dspi_data_to_pushr(dspi, tx_word);
 
-		if (dspi->len == 0 || tx_count == DSPI_FIFO_SIZE - 1) {
-			/* last transfer in the transfer */
+		if (dspi->len == 0 || tx_count == DSPI_FIFO_SIZE - 1)
+			/* request EOQ flag for last transfer in queue */
 			dspi_pushr |= SPI_PUSHR_EOQ;
-			if ((dspi->cs_change) && (!dspi->len))
-				dspi_pushr &= ~SPI_PUSHR_CONT;
-		}
 
 		regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
 
@@ -635,9 +635,6 @@ static int dspi_tcfq_write(struct fsl_dspi *dspi)
 
 	dspi_pushr = dspi_data_to_pushr(dspi, tx_word);
 
-	if ((dspi->cs_change) && (!dspi->len))
-		dspi_pushr &= ~SPI_PUSHR_CONT;
-
 	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
 
 	return tx_word + 1;
@@ -672,11 +669,26 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		dspi->cur_transfer = transfer;
 		dspi->cur_msg = message;
 		dspi->cur_chip = spi_get_ctldata(spi);
-		dspi->cs = spi->chip_select;
-		dspi->cs_change = 0;
+		/* Prepare command word for CMD FIFO */
+		dspi->tx_cmd = SPI_PUSHR_CMD_CTAS(0) |
+			SPI_PUSHR_CMD_PCS(spi->chip_select);
 		if (list_is_last(&dspi->cur_transfer->transfer_list,
-				 &dspi->cur_msg->transfers) || transfer->cs_change)
-			dspi->cs_change = 1;
+				 &dspi->cur_msg->transfers)) {
+			/* Leave PCS activated after last transfer when
+			 * cs_change is set.
+			 */
+			if (transfer->cs_change)
+				dspi->tx_cmd |= SPI_PUSHR_CMD_CONT;
+		} else {
+			/* Keep PCS active between transfers in same message
+			 * when cs_change is not set, and de-activate PCS
+			 * between transfers in the same message when
+			 * cs_change is set.
+			 */
+			if (!transfer->cs_change)
+				dspi->tx_cmd |= SPI_PUSHR_CMD_CONT;
+		}
+
 		dspi->void_write_data = dspi->cur_chip->void_write_data;
 
 		dspi->dataflags = 0;
-- 
2.17.1

