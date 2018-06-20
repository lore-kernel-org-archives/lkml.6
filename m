Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D088DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8E2208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTqgOS99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8E2208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932504AbeFTIh3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:37:29 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38252 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932314AbeFTIhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:37:25 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so3661404lfh.5;
        Wed, 20 Jun 2018 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T9Bbom5AxDXAKMDWUsMhIH1DpC0pCiwXcclpItONub4=;
        b=iTqgOS99gx18FQ/b+2C5TbdxRVj6b0yZowv16DTiu6BtN91yqQBpNzHRUNWqfRKL/k
         0f0gn5xerm3lbafwIz/fuGz4fg/53jP0eHMTRgrfzGAv9eHWNO7TjaDWltxsnj4NX72P
         F+1fxb4YPINi9wTKv22a53GXi4ySFvxJUK77Zurw4g5/ypuvV/+2CNBHw9YMF1Klo0tD
         iUpAgEoHg0h0UKNTH1HshtMQ+a/5V03Ql7bhsY5vD5BIhVYVLIeRG0KOPDtBPe1bj3vi
         fm6iD0reHq7QIjv6kgcrrRjztxreu7wMc20YqifSjsf5Ca7nbwm9Degsg6el3jKyCI4n
         eKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=T9Bbom5AxDXAKMDWUsMhIH1DpC0pCiwXcclpItONub4=;
        b=GXtJlsTaWT1JAOw2prrsuLxgLf7Ef8txknd8hkb8WKxj2m5ySmEm4EnWtbeP0n4EF5
         CRQSQABQaRNJLGjmu6c3hgDJnZqm9DbQe2TjjEJ8Rqkcigexdy8ZPamvXd7oN4vqy88z
         tcTLRyQ/RlSLFfiH8FTH3uZnGehQiKtBEhGycD+iiqVIPsn5f28YGseIGa8f/YZyKA+O
         iyiTHCy2YfaCnuEl4eTk3nFQeAl98tjm2XcAZ4t3rrzm2felWT5AoW/OvNhZXJfZMDkX
         4a8gTDhGek7xtC+0gSI7W95cDT71rLawmP2ynGLQANXPlvVN3pFg3thaqeV6fV7C+cII
         FeTg==
X-Gm-Message-State: APt69E05fGgBOzKZ5GUz5I3LYLFyB2IKvi4+ZqLbPc7kArOMYl7okI1I
        Z1CT81rntGjoH2CKh6LkOPG8Oxfr
X-Google-Smtp-Source: ADUXVKL1JPFMuiRYS43iYpKqs04taVuID2PFRFE27UPwPx7HsVeDUeZNVRZFPolBzoG/LZGyS4KycQ==
X-Received: by 2002:a2e:4189:: with SMTP id d9-v6mr12846354ljf.36.1529480105752;
        Wed, 20 Jun 2018 00:35:05 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id m186-v6sm286747lfe.16.2018.06.20.00.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:35:05 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 09/12] spi: spi-fsl-dspi: Framesize control for XSPI mode
Date:   Wed, 20 Jun 2018 09:34:39 +0200
Message-Id: <20180620073442.20913-10-esben.haabendal@gmail.com>
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

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3e9dd645ee54..ba83ff4512c9 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -119,6 +119,9 @@
 #define SPI_FRAME_BITS_16	SPI_CTAR_FMSZ(0xf)
 #define SPI_FRAME_BITS_8	SPI_CTAR_FMSZ(0x7)
 
+#define SPI_FRAME_EBITS(bits)	SPI_CTARE_FMSZE(((bits) - 1) >> 4)
+#define SPI_FRAME_EBITS_MASK	SPI_CTARE_FMSZE(1)
+
 /* Register offsets for regmap_pushr */
 #define PUSHR_CMD		0x0
 #define PUSHR_TX		0x2
@@ -662,6 +665,10 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		regmap_write(dspi->regmap, SPI_CTAR(0),
 			     dspi->cur_chip->ctar_val |
 			     SPI_FRAME_BITS(transfer->bits_per_word));
+		if (dspi->devtype_data->xspi_mode)
+			regmap_write(dspi->regmap, SPI_CTARE(0),
+				     SPI_FRAME_EBITS(transfer->bits_per_word)
+				     | SPI_CTARE_DTCP(1));
 
 		trans_mode = dspi->devtype_data->trans_mode;
 		switch (trans_mode) {
@@ -922,6 +929,9 @@ static void dspi_init(struct fsl_dspi *dspi)
 {
 	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS);
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
+	if (dspi->devtype_data->xspi_mode)
+		regmap_write(dspi->regmap, SPI_CTARE(0),
+			     SPI_CTARE_FMSZE(0) | SPI_CTARE_DTCP(1));
 }
 
 static int dspi_probe(struct platform_device *pdev)
-- 
2.17.1

