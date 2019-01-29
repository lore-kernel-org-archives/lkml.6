Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DEFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECA820855
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="CL5xW77T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfA2Ii6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:38:58 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33496 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfA2Iiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:38:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so14019926lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFJ3nBA8p9KGkEXUMN8LgR+LVkNu7VqCUoJbVk76olw=;
        b=CL5xW77Thup6ohaDQqVmY1HP62gAvOC1xMEf+n/Mbwy7R9/dkXjl6tsL5bf7xyPdqR
         v1GpdH34nhEmAZ+kcWCqjBG0E9VDWJqcl/TJGdM4dV39rT1Cbc2okrCOIoHVvK3omiGu
         54Te3Wc0Au0j1SELZT75IdQ1+UXMpkoajMT4Q0kHL2OhBr7NAuP789CTuNpfiAQ21wmV
         eWF5Uxx7VkkPeLAeTPXLXIYMIDYIP+AQIawhM7X/qm96aFuL99oWC5c8FesqiAAY5Vx9
         sSSzXAc+GBHL0oC4tIsgNC2VM0e3XsH/K9AuVzq6LWNI0wLd+TceMDIsXRMvd+GTyUrz
         4iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFJ3nBA8p9KGkEXUMN8LgR+LVkNu7VqCUoJbVk76olw=;
        b=JJi1npS4eoKtEyNoC585ElR+Y/xF48IuaEPa9cWrtYsOuUjY70WXG7kbWVPinUur9w
         9ZIYYeTImNXDjhKQkCwOIC+tDp6J/Cej6nUXfAo1NN/trSW9yMKOgAQ0Mgn6WJ4xiehf
         gJWH2Qzv73DvrYS5krWHcE+SZw8KNwqvV34USmsqgsOiVvt87ZVNpWd70gee8st5vLl6
         d8z2EKy2LUDQQvyjPNt+CBXPKOc5Y+n1BA3PJzdoXQOH4vNo0G6NXszI7RhTwKMXWBIS
         oMhIaHuqaU8i4SSrv0zzKJStF4H74HcZnAM5NAYne9yaUrgfr5Bpd08xdUg555FpFD8A
         GysQ==
X-Gm-Message-State: AJcUukfYLI/Lz1ec3OEGSoloiwD/lK2I8J+OtWblb/K8bgD06f7GKWQy
        +ZuAujn4/ZgC1gDSkJ7fMid+DExZI24=
X-Google-Smtp-Source: ALg8bN6lpEv3wzPw3S7JpYCz5CoMP59wC3+ohlF42zABtxIdUVUisID8Z8e8md6wy9SmjKO2ggClJg==
X-Received: by 2002:a19:660a:: with SMTP id a10mr20615215lfc.146.1548751131801;
        Tue, 29 Jan 2019 00:38:51 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id v17-v6sm3378774ljg.32.2019.01.29.00.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:38:51 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/2] spi-atmel: support inter-word delay
Date:   Tue, 29 Jan 2019 09:38:44 +0100
Message-Id: <20190129083844.20572-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129083844.20572-1-jonas@norrbonn.se>
References: <20190129083844.20572-1-jonas@norrbonn.se>
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
index 74fddcd3282b..6389a228d2f5 100644
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
+	if (spi->word_delay_us) {
+		csr |= SPI_BF(DLYBCT,
+			clamp_t(u8,
+				(as->spi_clk/1000000*spi->word_delay_us)>>5,
+				1, 255));
+	} else {
+		csr |= SPI_BF(DLYBCT, 0);
+	}
+
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
 	npcs_pin = (unsigned long)spi->controller_data;
-- 
2.19.1

