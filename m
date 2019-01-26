Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E145C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B90E218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="1Dw3YGg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfAZQcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:32:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35150 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfAZQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:32:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so9033978lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 08:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4asA/HrfRTCLZ9s+7ODb9ujqrC02barVnHHP3w4OeE=;
        b=1Dw3YGg8xJI9+QrCu/LPqQ7Tr/GpytlL6Sj9JOqPWV3qR7JsVOZvTwcLkBmBXK2uSZ
         TFcurMiTzkCaWD95yVxh4ISXWz4SAVqgOKY1IaZeYUf/9QFNcV5k7bFGLvIHyADk5vWy
         +YN52P1zK5m6I6mEfnSzjP8VWEep9DACZXPu6VHTUPEnrcK28uoeDKgzsfU/E8PH800R
         HaXLsnx/buy6A5AdzNPoivt2pFHTu4B9tUtKGGpSKXpY9ygCjl8VdKWo/P9tOtBlfeyL
         shX85Yq4wrOuH5UporbikUTEjIY4YqXfIDN1Ar/apyBE8ldFeEmDCvW4015QH3UkobIS
         lhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4asA/HrfRTCLZ9s+7ODb9ujqrC02barVnHHP3w4OeE=;
        b=gYUr5XSeaB8oRuXDaTkODwycfWJGIrrRXHrpuR6gG1n5uyeadcvlaVMhhrNkanlITU
         5iuPalyTCbIELG//SBut6MU1BhxMsC4HYn+MXcy3bbinL96BPtRtcZnbKSpkxIuVh+FK
         WtkKXxGkHinAOrpr0HuyUj+fl3b/SN1Uu+t3LYaXTwKHlgD08DomhFpnPEohzVKoeM7O
         FLKeen/9M5xWEOo7HmWnlol2Vvl583+3hzkqUzRyBBgD3eD/GyQGPfj7KFNpiL5W/1ir
         8Bh6/QIsGHt031qbC7UXIc1EcrZ4SLRodtfGwO+WttCk3tO2Bfl/VD42/L2XZdLqIND5
         w/vw==
X-Gm-Message-State: AJcUukcqV4cBdCUy6P4y3tEVaFKqqt4OhkuMnIkXMZUjmj96iZYZZNqc
        QHrhMxrUwXf/NH6CgAZJ6FRWYvV2a7I=
X-Google-Smtp-Source: ALg8bN7ixO5jynANWXsRXQCc6pion+WBh06LKAJNIlpvS/JPjjM6Ib4nje2yFpEoX9h2Cy6IwOzaeA==
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr12471052lff.141.1548520346833;
        Sat, 26 Jan 2019 08:32:26 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id e94sm2170532lfi.23.2019.01.26.08.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 08:32:26 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] spi-atmel: support inter-word delay
Date:   Sat, 26 Jan 2019 17:32:20 +0100
Message-Id: <20190126163220.26421-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190126163220.26421-1-jonas@norrbonn.se>
References: <20190126163220.26421-1-jonas@norrbonn.se>
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
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: linux-spi@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/spi/spi-atmel.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 74fddcd3282b..24445bfbd74e 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1209,13 +1209,21 @@ static int atmel_spi_setup(struct spi_device *spi)
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
+	if (spi->word_delay) {
+		csr |= SPI_BF(DLYBCT,
+			clamp_t(u8,
+				(as->spi_clk/1000000*spi->word_delay)>>5,
+				1, 255));
+	} else {
+		csr |= SPI_BF(DLYBCT, 0);
+	}
+
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
 	npcs_pin = (unsigned long)spi->controller_data;
-- 
2.19.1

