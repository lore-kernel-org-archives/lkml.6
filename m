Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF8C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943F0208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiUNTweH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943F0208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbeFTIfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:35:06 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33629 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754679AbeFTIfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:35:01 -0400
Received: by mail-lf0-f65.google.com with SMTP id y20-v6so3685819lfy.0;
        Wed, 20 Jun 2018 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWYxHHq96iFmNITC1sUwFdoJuI4DigNYHRRkBVglamA=;
        b=ZiUNTweHi3h7t+7D104Q/VYNVkFtZq9l/43uU0CodCAvST3bWOdocyBzAu/LICEi8w
         LyV6qjd5kUv8f+ozlKgOJ6pS9Ta7ZSeY9Q1igFaiIpSPDTD7pKeRVrQYuNCPio7TLFkK
         Ek/W5jR8i7umMo5IpBDR7CdCoHVQZST70pCbqqn/moCZRJaNv5l+0FuBRANNuDq7sxqw
         FDbwzBP5OrpgFRDdPq8a2+a6i6ttfY3ynrbxff8G9scgMBTq2NpWCQF1G4RrEa5ehVV4
         rirtgg3Gl9IhLpH4KHwpCoVxirLm7UEDIF3nWJkEjoLN2OcnS2KYSRxrwxXJTI+gYQQM
         HqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HWYxHHq96iFmNITC1sUwFdoJuI4DigNYHRRkBVglamA=;
        b=Hx2GA9wS8fQKGsouJkdYfHsdTshRNDmhFvKlHg4zOTIotbo7gm+mr713hs65fNX8ff
         nOIzT/C4rqxR0CzQKiGCazAJ7mrYP5UarvW63GQ0CGjyPALFb/TCjM5NMhEPxHmQdZWZ
         rPVzp7c5P37VYz3Y5kjM5pI7cXouDhI+4O+ZvzexlGMx/YIIHeb/DJk3jQKK6wuhPlp9
         OgQXjoEfqX7wJ65h/MK3y8rSbZyJqFYAYBxe7Fqvms5fCmF6UWZwG9rwJzBDCSI71Ndx
         miFjIYRBUA09zAZHqFIXgiZQ/r5XTb1rVJWQUhKWsfpPqXr8CTi7saywi8R5Zc0ZKAjH
         vVBQ==
X-Gm-Message-State: APt69E3pHrf63FKr3fgzL3/4kCr+m3uXuOeTV+89C4iOEdFtD7srg+La
        QUUeIAuhoQ9SdSdJZrxAVfn9rYNq
X-Google-Smtp-Source: ADUXVKLtNDsYlsICh1gPoe5jxYAvNsixO0w3pZ7Ru9DqdSkHw4vVFdOb39Tk9oG8ShspMjCfilKkRg==
X-Received: by 2002:a19:5483:: with SMTP id b3-v6mr11229592lfl.128.1529480101690;
        Wed, 20 Jun 2018 00:35:01 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id b65-v6sm281244lfe.80.2018.06.20.00.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:35:01 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 07/12] spi: spi-fsl-dspi: Fix MCR register handling
Date:   Wed, 20 Jun 2018 09:34:37 +0200
Message-Id: <20180620073442.20913-8-esben.haabendal@gmail.com>
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

The MCR register is not changed, so initialize it in dspi_init().

The exception is the CLR_TXF and CLR_RXF bits, which should be written to
before each transfer to make sure we start with empty FIFOs.  With MCR
register now configured as volatile, the regmap_update_bits will do a real
read-modify-write cycle.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 5c5905b6509f..d83d3496d538 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -120,7 +120,6 @@
 #define DMA_COMPLETION_TIMEOUT	msecs_to_jiffies(3000)
 
 struct chip_data {
-	u32 mcr_val;
 	u32 ctar_val;
 	u16 void_write_data;
 };
@@ -644,10 +643,9 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		else
 			dspi->bytes_per_word = 2;
 
-		regmap_write(dspi->regmap, SPI_MCR, dspi->cur_chip->mcr_val);
 		regmap_update_bits(dspi->regmap, SPI_MCR,
-				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
-				SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
+				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
+				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
 		regmap_write(dspi->regmap, SPI_CTAR(0),
 			     dspi->cur_chip->ctar_val |
 			     SPI_FRAME_BITS(transfer->bits_per_word));
@@ -725,9 +723,6 @@ static int dspi_setup(struct spi_device *spi)
 		sck_cs_delay = pdata->sck_cs_delay;
 	}
 
-	chip->mcr_val = SPI_MCR_MASTER | SPI_MCR_PCSIS |
-		SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF;
-
 	chip->void_write_data = 0;
 
 	clkrate = clk_get_rate(dspi->clk);
@@ -883,6 +878,7 @@ static const struct regmap_config dspi_regmap_config = {
 
 static void dspi_init(struct fsl_dspi *dspi)
 {
+	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS);
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 }
 
-- 
2.17.1

