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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46C7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930FF20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mADI+xRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930FF20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754830AbeFTJjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:39:25 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34974 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754346AbeFTI3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:29:36 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so3644240lfc.2;
        Wed, 20 Jun 2018 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7T5Eb7TPlBIKZUbHnEFXjjKePtflLcyXADjzmV9mDk=;
        b=mADI+xRKT2F+s4FgsOdm/meJxWYnws7m/IZIlc0DAG7SFH37svYmernU4gq0T31O15
         5fQNEgNzStsWnqTBI6sLPU5zYQjXoewqLjeRlk2fsi/xUFksqsQ5Cl8POHqJd1EMcU3A
         3v6taKPiDvjBPXfifGosFguLL/e6ak8Sd97ard9nka/WpEe6FsSn+vieB9bCz7/ytM4G
         jZfCQBuvYvijXuJnltmnO57ursUHF5iSg1MndE2C40bl85NFX5Lh7u8N5iqmUKmFr+qq
         rvpUyVeSKSgBxp4coH1qPBxDNRMxUP8c7IjZukT91AGmG8XYdM2lcLv87glEyoXHAtnm
         +DnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=b7T5Eb7TPlBIKZUbHnEFXjjKePtflLcyXADjzmV9mDk=;
        b=hBbVg/2W1sUkNt9o7i8Bq7EHdw6ay8BvaRNlUzTqWW/pSXB7QIGWkPZqExTMYXhEs9
         u8Oa9Ods1MI4m8DV0vucD/kLNldUQmAJyeAhOYcsQkSn+grx4dgoFQqd2/GdZDnWPCZC
         fogQ5PInoKDfiE9C4ZtZGIBgLzUGsv9tOjHYtTgTyXENkd9Yebb4qImZ8fJKFFPoPQ3D
         O2SRNik8g45lBnww3UXWjWLIay63iJOsYcLRiECw5L0fjPNKwOKjGBy2oLLxvAV4j7wt
         DPHq9MZmax4rfWl7lVWKRDdfgs6qlSxS9UftBqcA3KUtzoj589+YC0xJO8v2E4XM/s64
         AH2A==
X-Gm-Message-State: APt69E3ASpS/TK6v7Vd2PNac7f9luNYzWT7PQ/NB25EhgFgequERQyV6
        7pEhk5XLUfy/aRkgJLLhmh/C0H3M
X-Google-Smtp-Source: ADUXVKIkUOUlbZvycuEnFK5UZg52pQWr8CDTRhUQSBINv5uvDzTpIkwxZLq5FSO9UiKqLc7T+jf6zA==
X-Received: by 2002:a19:2182:: with SMTP id h124-v6mr1230242lfh.27.1529480107951;
        Wed, 20 Jun 2018 00:35:07 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id 4-v6sm274017ljc.1.2018.06.20.00.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:35:07 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 10/12] spi: spi-fsl-dspi: XSPI FIFO handling (in TCFQ mode)
Date:   Wed, 20 Jun 2018 09:34:40 +0200
Message-Id: <20180620073442.20913-11-esben.haabendal@gmail.com>
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

This implements handling of split CMD and TX FIFO queues for XSPI when
running in TCFQ mode.

It should be simple to add it to EOQ mode also.  Currently, EOQ mode is
only used with coldfire.  So if coldfire DSPI supports XSPI, XSPI FIFO
handling should be added to EOQ mode also.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 55 +++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index ba83ff4512c9..67cd2e901255 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -215,15 +215,17 @@ struct fsl_dspi {
 	struct fsl_dspi_dma	*dma;
 };
 
-static u16 dspi_pop_tx(struct fsl_dspi *dspi)
+static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 {
-	u16 txdata = 0;
+	u32 txdata = 0;
 
 	if (dspi->tx) {
 		if (dspi->bytes_per_word == 1)
 			txdata = *(u8 *)dspi->tx;
-		else /* dspi->bytes_per_word == 2 */
+		else if (dspi->bytes_per_word == 2)
 			txdata = *(u16 *)dspi->tx;
+		else  /* dspi->bytes_per_word == 4 */
+			txdata = *(u32 *)dspi->tx;
 		dspi->tx += dspi->bytes_per_word;
 	}
 	dspi->len -= dspi->bytes_per_word;
@@ -249,8 +251,10 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 
 	if (dspi->bytes_per_word == 1)
 		*(u8 *)dspi->rx = rxdata;
-	else /* dspi->bytes_per_word == 2 */
+	else if (dspi->bytes_per_word == 2)
 		*(u16 *)dspi->rx = rxdata;
+	else /* dspi->bytes_per_word == 4 */
+		*(u32 *)dspi->rx = rxdata;
 	dspi->rx += dspi->bytes_per_word;
 }
 
@@ -564,12 +568,47 @@ static void fifo_write(struct fsl_dspi *dspi)
 	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pop_tx_pushr(dspi));
 }
 
+static void cmd_fifo_write(struct fsl_dspi *dspi)
+{
+	u16 cmd = dspi->tx_cmd;
+
+	if (dspi->len > 0)
+		cmd |= SPI_PUSHR_CMD_CONT;
+	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
+}
+
+static void tx_fifo_write(struct fsl_dspi *dspi, u16 txdata)
+{
+	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
+}
+
 static void dspi_tcfq_write(struct fsl_dspi *dspi)
 {
 	/* Clear transfer count */
 	dspi->tx_cmd |= SPI_PUSHR_CMD_CTCNT;
-	/* Write one entry to both TX FIFO and CMD FIFO simultaneously */
-	fifo_write(dspi);
+
+	if (dspi->devtype_data->xspi_mode && dspi->bits_per_word > 16) {
+		/* Write two TX FIFO entries first, and then the corresponding
+		 * CMD FIFO entry.
+		 */
+		u32 data = dspi_pop_tx(dspi);
+
+		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1)) {
+			/* LSB */
+			tx_fifo_write(dspi, data & 0xFFFF);
+			tx_fifo_write(dspi, data >> 16);
+		} else {
+			/* MSB */
+			tx_fifo_write(dspi, data >> 16);
+			tx_fifo_write(dspi, data & 0xFFFF);
+		}
+		cmd_fifo_write(dspi);
+	} else {
+		/* Write one entry to both TX FIFO and CMD FIFO
+		 * simultaneously.
+		 */
+		fifo_write(dspi);
+	}
 }
 
 static u32 fifo_read(struct fsl_dspi *dspi)
@@ -656,8 +695,10 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		dspi->bits_per_word = transfer->bits_per_word;
 		if (transfer->bits_per_word <= 8)
 			dspi->bytes_per_word = 1;
-		else
+		else if (transfer->bits_per_word <= 16)
 			dspi->bytes_per_word = 2;
+		else
+			dspi->bytes_per_word = 4;
 
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
-- 
2.17.1

