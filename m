Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D37C1B0F7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B368D208B4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqfeClOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B368D208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754787AbeFTIhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:37:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37041 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeFTIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:37:02 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21-v6so3680480lfb.4;
        Wed, 20 Jun 2018 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUBVxY3XWkhC9ZtepE3dagP2Ibsu2wk5lPjBQy2A2rA=;
        b=tqfeClOJjKs0YbQJmA4f4phlCR8d/Io7WFoZ4lSz/UF/omTSLs6qfYj8ycDvjbTwwk
         /KHP9A2bk8JbYnciQRbU6wLbECNzUrBboiZbDwun378El++xWZTqMOdq2dASmX6vzeAL
         /Wz6HeXHS+JoivSY6mJ76bvRjy5aBUpK8ZwayXgGWAvBvLtNjPNQoxz3cB20zjq8u4YQ
         jWCjeW0SuTsMuZDul5Gg+BwMDa4JBUvHCUybm4fR1cotaVmBuYfrUb0PZ6trpNGnuHas
         PgNqTY5dGJskz31Rpz8IIG9mI0AKQla6hgQLPcrDbnIE61B1Qi5RsjUFjB5MwOYdKUT3
         j5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yUBVxY3XWkhC9ZtepE3dagP2Ibsu2wk5lPjBQy2A2rA=;
        b=Hkvg4qXslQ/5nztcOM4xSL5GSFtyLW6ygkeNsvDgXhp2IPNpxO6fWU6arUNRomWA7D
         bzOqEJ1DOABRcTYyA81jtSTQ5uT5ngAW7EJ4Dgg5iO77rr8qXmjaSirMYh4Nr7fqc9i0
         nT+Rr3AU+CtcQjigjG2uskbaYqg0GLFvIRqFROKhdJaofvcOuLzQrDGQRv0s8jpqTiLg
         e2AEcwpP0jHTb7PAj+wx7sNwFO/6j8Q/mZTdXXeCY1nTHMMVWS8lixEcV8Muf+fEFHLI
         6118pm8U5bOlZx8DtLK4EDTP2ARlbya9AM2Tpeueq01sJj0QZLfiwey6PdFrLtwG/Jqw
         ZthQ==
X-Gm-Message-State: APt69E2AKiTowC3ZiuSkBNrBqpT58sCULlLfHuxSMmOfV08SJTFVPj6v
        4tarrzN/6srEZxExwe2KJm1Te/Uy
X-Google-Smtp-Source: ADUXVKLgT+bP+aBkg3U1hUKO+f7bObbGmAkO1s5Y1oZkW7uBMDWIn13s32pbAPdmJm9rZoUbaVWAFw==
X-Received: by 2002:a2e:5358:: with SMTP id t24-v6mr13793436ljd.129.1529480112692;
        Wed, 20 Jun 2018 00:35:12 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id n84-v6sm287354lfi.19.2018.06.20.00.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:35:11 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 12/12] spi: spi-fsl-dspi: Enable extended SPI mode
Date:   Wed, 20 Jun 2018 09:34:42 +0200
Message-Id: <20180620073442.20913-13-esben.haabendal@gmail.com>
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

Set the XSPI bit for devices configured for XSPI mode (currently LS1021A),
and thereby switch to extended SPI mode, allowing for SPI transfers using
from 4 to 32 bits per word instead of 4 to 16 bits per word.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index eed55491b2c9..1f85dcdb2203 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -46,6 +46,7 @@
 #define SPI_MCR_PCSIS		(0x3F << 16)
 #define SPI_MCR_CLR_TXF	(1 << 11)
 #define SPI_MCR_CLR_RXF	(1 << 10)
+#define SPI_MCR_XSPI		(1 << 3)
 
 #define SPI_TCR			0x08
 #define SPI_TCR_GET_TCNT(x)	(((x) & 0xffff0000) >> 16)
@@ -968,7 +969,8 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 
 static void dspi_init(struct fsl_dspi *dspi)
 {
-	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS);
+	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS |
+		     (dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI : 0));
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 	if (dspi->devtype_data->xspi_mode)
 		regmap_write(dspi->regmap, SPI_CTARE(0),
-- 
2.17.1

