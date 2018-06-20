Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA820C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB5320652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2MhU+hL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB5320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754692AbeFTJNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:13:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33464 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754113AbeFTIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:33:49 -0400
Received: by mail-lf0-f66.google.com with SMTP id y20-v6so3680435lfy.0;
        Wed, 20 Jun 2018 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7wTLhP/fkMnuY6/EfqISEodQam5oq1wjS1vYGEVP1s=;
        b=q2MhU+hLC3yJish60vjdXIzLWvDw9IdKpbrgTTTwq1LaQmi2iuVQ1i6hYml6QvMbVA
         DNMf7y7v4MohWTZcj3sE+wR4Nmfjke5LjSLJ3mZsPHg6xwhyfSsLh6551RKYV3+jUM3g
         RruYERdvNLxxi+6d2Jr+bKk2mnbIiey/ea9lEWb+YsCQUJb6QrPZWxM+mOpFtTnvthIE
         uB3X25gIR54yEvGi8OOOtTt1ErCmZrmfG6o/XDwpflR0ubsE62qPLTzsBU1h+MZhH+tq
         wPOlne4qsxyWUmg+rwsvZ2L+tSHt2gvdccF+7nckyNKR7LcAS7GrvqqA5ZjiHMzczrYE
         EpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=t7wTLhP/fkMnuY6/EfqISEodQam5oq1wjS1vYGEVP1s=;
        b=YRRpdBK/h1Zbgzn53pneUgGsAI0XrzFvbFyFEbhZyzFyoMeEgHrlim3ZwGQv546bCw
         GLxLfS2ojIK6lht87Y4Jcjw8fNFmwzAAGwQjbRcw56Kp+FUhIyL/0NLyxy0yQ3qdhE2R
         HlwP/6EWZqXXUrQLLLbxgi8Plaz925XdC8bm2zXGdhO7fggZeJRVCpbjfZJT9ua+xFZp
         T5VvM9nd+hPd/G7lSjdBT4tfn93AV3fkXHR5EizLkeyWR+9xvmPEtj0W/BsMm60hnFBJ
         WCjWgPEM3tLxdE7W3EOgILWV4z82CgMPpFwjlKVREGSCeK6/9h7zZLOAOTnNB8CWWKUI
         B6jw==
X-Gm-Message-State: APt69E1/s9aYe7taK+TUvqbLHaNbDiGsab3O1GKfvKUU6XIjfXj1aMFI
        yIalzMRWEb2qG2+EdjzRn55CdjAD
X-Google-Smtp-Source: ADUXVKI0gcsXFz2UNy47qsMT4ub9A3O6jPGmnXKgIAL1kOT2iCDruCGeZoNE+zPidcEO02Of5fdTeQ==
X-Received: by 2002:a2e:9187:: with SMTP id f7-v6mr14268095ljg.98.1529480089680;
        Wed, 20 Jun 2018 00:34:49 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id n19-v6sm272102lja.32.2018.06.20.00.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:34:49 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 02/12] spi: spi-fsl-dspi: Drop unneeded use of dataflags bits
Date:   Wed, 20 Jun 2018 09:34:32 +0200
Message-Id: <20180620073442.20913-3-esben.haabendal@gmail.com>
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

Checking directly against pointer value should be at least as fast as doing
bitmasking and compare, so let's keep it simple.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3ca9b9608801..3bf135bf8b93 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -38,8 +38,6 @@
 
 #define DRIVER_NAME "fsl-dspi"
 
-#define TRAN_STATE_RX_VOID		0x01
-#define TRAN_STATE_TX_VOID		0x02
 #define TRAN_STATE_WORD_ODD_NUM	0x04
 
 #define DSPI_FIFO_SIZE			4
@@ -232,7 +230,7 @@ static void dspi_rx_dma_callback(void *arg)
 
 	rx_word = is_double_byte_mode(dspi);
 
-	if (!(dspi->dataflags & TRAN_STATE_RX_VOID)) {
+	if (dspi->rx) {
 		for (i = 0; i < dma->curr_xfer_len; i++) {
 			d = dspi->dma->rx_dma_buf[i];
 			rx_word ? (*(u16 *)dspi->rx = d) :
@@ -538,12 +536,13 @@ static u32 dspi_data_to_pushr(struct fsl_dspi *dspi, int tx_word)
 {
 	u16 d16;
 
-	if (!(dspi->dataflags & TRAN_STATE_TX_VOID))
+	if (dspi->tx) {
 		d16 = tx_word ? *(u16 *)dspi->tx : *(u8 *)dspi->tx;
-	else
+		dspi->tx += tx_word + 1;
+	} else {
 		d16 = dspi->void_write_data;
+	}
 
-	dspi->tx += tx_word + 1;
 	dspi->len -= tx_word + 1;
 
 	return	SPI_PUSHR_TXDATA(d16) |
@@ -560,10 +559,10 @@ static void dspi_data_from_popr(struct fsl_dspi *dspi, int rx_word)
 	regmap_read(dspi->regmap, SPI_POPR, &val);
 	d = SPI_POPR_RXDATA(val);
 
-	if (!(dspi->dataflags & TRAN_STATE_RX_VOID))
+	if (dspi->rx) {
 		rx_word ? (*(u16 *)dspi->rx = d) : (*(u8 *)dspi->rx = d);
-
-	dspi->rx += rx_word + 1;
+		dspi->rx += rx_word + 1;
+	}
 }
 
 static int dspi_eoq_write(struct fsl_dspi *dspi)
@@ -687,12 +686,6 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		dspi->rx_end = dspi->rx + transfer->len;
 		dspi->len = transfer->len;
 
-		if (!dspi->rx)
-			dspi->dataflags |= TRAN_STATE_RX_VOID;
-
-		if (!dspi->tx)
-			dspi->dataflags |= TRAN_STATE_TX_VOID;
-
 		regmap_write(dspi->regmap, SPI_MCR, dspi->cur_chip->mcr_val);
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
-- 
2.17.1

