Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CFEC282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DF1218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="Be58ebP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfAYMYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:24:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36604 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfAYMYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:24:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so8229480ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 04:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4asA/HrfRTCLZ9s+7ODb9ujqrC02barVnHHP3w4OeE=;
        b=Be58ebP2NyXkKjVLpYKmbQRZZfz3qxFpZX7JJYIlPVc6kI0GGagVOkjSCFTr14Ep+t
         FlIUuKrIHL8l2PmaM4wewKSzvatj23DhHsfnun9xWLo0OS/geLz2KKMzWndKvVEz+Oy1
         DTlyM6cACpHEwEssEelAj/7ctskzid88crHwIz36ABtIHF9JUT04DkyWk5t5Pp8KsKWa
         FeagTCAQNkJMnmDdG1TOui7yuBE4MZlzJCRRo8pN7L+2sbT3QFFCLKKieVOikawdEH/1
         /KTwz+u9RAwyEOcAfFs72Rocd5M1PIxQVf8Qa/Inbule02RoAPGYLaKSh0eZJGq0qKtf
         JiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4asA/HrfRTCLZ9s+7ODb9ujqrC02barVnHHP3w4OeE=;
        b=cmPBnM7k9orQ4ahtIw9FloZ+3f+uWnpWFzcCRGlTUTDzshBUIfiCKbU4jTmSt1ak8Y
         Ufz2XjfI48mBIcJV4Ce1P5oY3Fm3CE27AJ+XJCy4NoBM0sFZqy9L5EwlzDFINNEfqJxZ
         avq5xTUvHBMASmUqZaZcuHs/7tjyfCuAj/PeHrYSmEDjAMRrefI5GBxUL198iZ2MzGAh
         Q+AHciTVALcgR7k+XkXzZW2BeHEP3jQDkEirVnR4uf9AecNvdGJ4Qpuee7uImCb7GByD
         zcf5pV1aoiH0fdT9EBJEyKsLuexfJXSvuRNrxSHBHfg68JfzrfYMgOoFf8go5LcvZun5
         CGtw==
X-Gm-Message-State: AJcUukfk08Jk0NyZC7RV+DPOWunzjucYT9AVtbqsApNut/xmcx1Q09R8
        ZIoO8WNR2ht8jEMDJ9HAA6rquezvpUQ=
X-Google-Smtp-Source: ALg8bN4X4/JA2vr3rvz97Rl0G1OZlJYP7AKI1v1U8VIF8CdEcalqNEa9fD/7XSaILMfEB9KpjufNBQ==
X-Received: by 2002:a2e:7d15:: with SMTP id y21-v6mr8583036ljc.77.1548419070963;
        Fri, 25 Jan 2019 04:24:30 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id y81-v6sm1508376lje.30.2019.01.25.04.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:24:30 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] spi-atmel: support inter-word delay
Date:   Fri, 25 Jan 2019 13:24:25 +0100
Message-Id: <20190125122425.30676-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125122425.30676-1-jonas@norrbonn.se>
References: <20190125122425.30676-1-jonas@norrbonn.se>
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

