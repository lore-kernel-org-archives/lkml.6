Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC0C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC63208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR8jlBCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC63208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754739AbeFTIgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:36:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42845 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754600AbeFTIgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:36:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id z207-v6so3646669lff.9;
        Wed, 20 Jun 2018 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=os2jWIyNjyQIQlNS6hNEY+WsDmaAeS3Y6PSobsw0hXI=;
        b=bR8jlBCVm+ywzWhiR4a++CiHeumABJ8ogAeKC43cxJj0xbbkfTGLVxaalPogHfxtix
         UasBiw61fpAIoiRn6csDVpe4OXUFJlS1XudtaliaZ5jbBQkA511qEkG/X0wE0Bf03CXq
         5pdA9cgs59JsTbFiW6aMX1585iWxEKg0lZmkly8225gAYDytrB8oxAIL9VGQuuowjTaQ
         p9xvJH2KmdiJA8v+WVeCE+G5If/VfWR3mvm7Kx9akqdNJsdDY1ld/mzAPgtuv7oCoFFW
         hDtaNpG2K9qQ7RIrpA/fE/dhho7tp79Yfy3jVG2d1kTi4W1ks+2dj2S65H5XK93q/kcr
         +Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=os2jWIyNjyQIQlNS6hNEY+WsDmaAeS3Y6PSobsw0hXI=;
        b=dtUXWk+2NAQhw7U4DZz8O5yV/QgMMsB/745ZOxg4lOhpedDq3BRV275iThuXnZEe+l
         YqyE9xlWgZWK0uKdtOdaeMtRkXIJwUpDY/EYUlYph2EF8QaFVPEAv3UhhYTg6CgYCw7E
         b+O2z98rhY5T057qK93eSY6jKBLz7aOHnDWWnwex/PdXlGLRsWxHvG4A0Q/+b2j2YtVE
         lqA0dY7ZpEDQ27BK/2AA6xTjKbpuYkTtmdB3a+hSdWD1PV4PN7uQYJ04ub1e1wnRd1om
         s9PGkzbC9v7wEsHLl7ZxHGSSZZ2R6pc4fRktO4ToeFGRtx25N/NqWwczGmfJvmsvlfqy
         1J1w==
X-Gm-Message-State: APt69E27ca5fWhzZU8N3Pg2kwBoZtXhHleL2UOIsfD+5MczoNQCtydds
        bLVq834aSDA+f5NVRtSF7lBTeyoz
X-Google-Smtp-Source: ADUXVKI0v+RYw1nFvJF9nSXZLGC2Tn26dzgqJPKtP/NZzTKmSRXVLaknez9Iyb0w08H2zLBmp4goCw==
X-Received: by 2002:a19:a302:: with SMTP id m2-v6mr3330667lfe.5.1529480094332;
        Wed, 20 Jun 2018 00:34:54 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id l25-v6sm274422ljj.30.2018.06.20.00.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:34:53 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 04/12] spi: spi-fsl-dspi: Simplify transfer counter handling
Date:   Wed, 20 Jun 2018 09:34:34 +0200
Message-Id: <20180620073442.20913-5-esben.haabendal@gmail.com>
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

Simplify driver by avoiding counter wrapping by clearing transfer counter
on first SPI transfer per interrupt instead of tracking what it was before.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 39 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c0c3b8bf2781..2371b9978e65 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -119,8 +119,6 @@
 #define SPI_CS_ASSERT		0x02
 #define SPI_CS_DROP		0x04
 
-#define SPI_TCR_TCNT_MAX	0x10000
-
 #define DMA_COMPLETION_TIMEOUT	msecs_to_jiffies(3000)
 
 struct chip_data {
@@ -201,7 +199,6 @@ struct fsl_dspi {
 	wait_queue_head_t	waitq;
 	u32			waitflags;
 
-	u32			spi_tcnt;
 	struct fsl_dspi_dma	*dma;
 };
 
@@ -594,6 +591,10 @@ static int dspi_eoq_write(struct fsl_dspi *dspi)
 			/* request EOQ flag for last transfer in queue */
 			dspi_pushr |= SPI_PUSHR_EOQ;
 
+		/* Clear transfer counter on first transfer (in FIFO) */
+		if (tx_count == 0)
+			dspi_pushr |= SPI_PUSHR_CTCNT;
+
 		regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
 
 		tx_count++;
@@ -635,6 +636,9 @@ static int dspi_tcfq_write(struct fsl_dspi *dspi)
 
 	dspi_pushr = dspi_data_to_pushr(dspi, tx_word);
 
+	/* Clear transfer counter on each transfer */
+	dspi_pushr |= SPI_PUSHR_CTCNT;
+
 	regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
 
 	return tx_word + 1;
@@ -658,10 +662,6 @@ static int dspi_transfer_one_message(struct spi_master *master,
 	struct spi_transfer *transfer;
 	int status = 0;
 	enum dspi_trans_mode trans_mode;
-	u32 spi_tcr;
-
-	regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
-	dspi->spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
 
 	message->actual_length = 0;
 
@@ -831,7 +831,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	struct spi_message *msg = dspi->cur_msg;
 	enum dspi_trans_mode trans_mode;
 	u32 spi_sr, spi_tcr;
-	u32 spi_tcnt, tcnt_diff;
+	u16 spi_tcnt;
 	int tx_word;
 
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
@@ -841,26 +841,15 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)) {
 		tx_word = is_double_byte_mode(dspi);
 
+		/* Get transfer counter (in number of SPI transfers). It was
+		 * reset to 0 when transfer(s) were started.
+		 */
 		regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
 		spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
-		/*
-		 * The width of SPI Transfer Counter in SPI_TCR is 16bits,
-		 * so the max couner is 65535. When the counter reach 65535,
-		 * it will wrap around, counter reset to zero.
-		 * spi_tcnt my be less than dspi->spi_tcnt, it means the
-		 * counter already wrapped around.
-		 * SPI Transfer Counter is a counter of transmitted frames.
-		 * The size of frame maybe two bytes.
-		 */
-		tcnt_diff = ((spi_tcnt + SPI_TCR_TCNT_MAX) - dspi->spi_tcnt)
-			% SPI_TCR_TCNT_MAX;
-		tcnt_diff *= (tx_word + 1);
-		if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM)
-			tcnt_diff--;
-
-		msg->actual_length += tcnt_diff;
 
-		dspi->spi_tcnt = spi_tcnt;
+		/* Update total number of bytes that were transferred */
+		msg->actual_length += spi_tcnt * (tx_word + 1) -
+			(dspi->dataflags & TRAN_STATE_WORD_ODD_NUM ? 1 : 0);
 
 		trans_mode = dspi->devtype_data->trans_mode;
 		switch (trans_mode) {
-- 
2.17.1

