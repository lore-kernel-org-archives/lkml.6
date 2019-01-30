Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66777C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CF52184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="dmjrwl7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfA3IkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:40:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46665 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbfA3IkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:40:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so19914916ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4YH1qzEHTsrJPYWTxDoTQQojGlkWsi2+2TPbuMpCJp8=;
        b=dmjrwl7a+PyLOExvhqVETNBsg9L2raflvETv36m3+TLSGt3mG1OxVjze34yNEZFGPn
         POiZGeCQ4b0ABoPEzKomDnavISSlV9FKY7MVqalDKzp1AUGVPxsIt1woChp3imUwnz2G
         J1sdUj0q709LDqQmI5ViUIxnL7BGtHdVX32/joz7AW63jDiVoksYsJHJJXBppVuLXvAj
         kr07AqrIhJY5dQRVILRQg68DSN7vFRPdsiKziasuu7OweOEcZIM7ijPHSASBG9tqeDUq
         FA3hHamxpp5vrOYKjqu1GQYkxYoaKyYzGAiS2B1mt/jwo6JMF1zL2mJ0tt9O1cDVTz4e
         DAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4YH1qzEHTsrJPYWTxDoTQQojGlkWsi2+2TPbuMpCJp8=;
        b=VAYg2aHZKeMj3vUTMG635n3+E57v8Zjlk9CP9UqhiHVwKowVRu80LvEx+BmO3KR2DO
         Qb23pJEO5XQV7v+ucxuScMXBMs/dpEEDM7Et+L+RvO5dMt0fQgsURKoLbzbvWU3Zqi/s
         7hx/HEo/Wixaem47f4ikC4vKGrrv28HEFNbftRZbiotoR2S3IxTRb7cJROvd8/vt7ou9
         9KkHZuzfhSuK54baq1nBO0ANNmLlC3IQ9ggdBbvtPCIqv4RtwWU3PylFjjBCVd6f5zjy
         yQmEgW/BKL/Hz8b9O3kk7WPSOg93rdj+v0OEz05KoSSSKNdW22i1QwkM77PkoBFU+pJZ
         c7cw==
X-Gm-Message-State: AJcUukcIlsogQFqYPK37hR3ZKT74HG8hG4XKvIrUaXlER3w8/jy/jbEY
        T1PMTrY19MQPch1WBOR/2ECeak5o3AU=
X-Google-Smtp-Source: ALg8bN4N+z1oUOLWxj3BtwtxZeQyWP5iPwSp51f13wh7g+Yr3bzLODwzkmouBkcGq76+wFKvU+ZufQ==
X-Received: by 2002:a2e:8087:: with SMTP id i7-v6mr23266267ljg.179.1548837611033;
        Wed, 30 Jan 2019 00:40:11 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id q67sm176734lfe.19.2019.01.30.00.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 00:40:10 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 2/2] spi-atmel: support inter-word delay
Date:   Wed, 30 Jan 2019 09:40:05 +0100
Message-Id: <20190130084005.18649-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190130084005.18649-1-jonas@norrbonn.se>
References: <20190130084005.18649-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the SPI slave requires an inter-word delay, configure the DLYBCT
register accordingly.

Tested on a SAMA5D2 board (derived from SAMA5D2-Xplained reference
board).

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: linux-spi@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/spi/spi-atmel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f53f0c5e63da..4954f0ab1606 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1201,13 +1201,14 @@ static int atmel_spi_setup(struct spi_device *spi)
 		csr |= SPI_BIT(CSAAT);
 
 	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
-	 *
-	 * DLYBCT would add delays between words, slowing down transfers.
-	 * It could potentially be useful to cope with DMA bottlenecks, but
-	 * in those cases it's probably best to just use a lower bitrate.
 	 */
 	csr |= SPI_BF(DLYBS, 0);
-	csr |= SPI_BF(DLYBCT, 0);
+
+	/* DLYBCT adds delays between words.  This is useful for slow devices
+	 * that need a bit of time to setup the next transfer.
+	 */
+	csr |= SPI_BF(DLYBCT,
+			(as->spi_clk / 1000000 * spi->word_delay_usecs) >> 5);
 
 	asd = spi->controller_state;
 	if (!asd) {
-- 
2.19.1

