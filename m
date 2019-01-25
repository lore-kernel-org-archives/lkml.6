Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88295C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497D5218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="GEUhvkW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfAYLol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:44:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38095 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfAYLoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:44:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so8114427lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uu+GXREpN4UO7hWlKWeYJkb2H2GuTbzfegM7LkbZ/S8=;
        b=GEUhvkW0Aw6GHc3vSCXnmV8GTX+YAf3myHFSu3fzEAnbXvX5jP4hXHpfVi7RFjWnja
         elrrK7YvfIRcN9CgC/dZF3gn1rPhSfenaHc44zUrV1dK5Gl2X73Qp2C4YRSEWiyrJXYl
         ZErLRdaCPITbBF5zegxKL9TEv1aW3ySw7OiCPhQKLLJPLuw3ncrhK3VapBNZABn2IFKZ
         VEWtlB1mF61toNnCH8oEtzitthO/MpcHWX5gIyJyfqcLOEZpkLTVqrrrgL4rjQe962m8
         /VKS6rDm++8Wdg1694dCdU/BOaExp+AHisTiVIFzbC8BBmVLmh0fD8k/4qNxrb2NNgeQ
         3RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uu+GXREpN4UO7hWlKWeYJkb2H2GuTbzfegM7LkbZ/S8=;
        b=I3k8eBWspx6N3pEviwboi4uyqj1OCB879+v50OwETz1YCRgVu44pjaT+10eSEc5XvL
         XmQ3gXJ/RFMYhuNE59AnVBC/U7gS3M7gmdMb4kBlK6hK5qZqeDHvMK5h3WtBOrL6IaPR
         6/fg32Gfhzb6ktw6Y8WhSdbIwnc2RNtnuGoEnkzFagRi2Wxr/03xLGIkyvHQ0MURSaxx
         Tt4ZBs9MNOKQwpHVXZ6o3SE3KCVLL0763GEBhKiSpgJZGtt3lSwPPyBpsvQo4FG3wgNm
         MP/KN5z1qCVc7l881XVyQboLkAMjvx+WreCdBbF64Q/ztCJEVy3q4Cnw7e7t5HKQ1XMU
         ARUQ==
X-Gm-Message-State: AJcUukfzVSCqLVU9OsSmPjAwn2WHhR6DSBf2knTj8AzvM2nxGFqc4u8u
        EkkCgSqdJxJquXe+nR0UKUL0m1ClKNk=
X-Google-Smtp-Source: ALg8bN6XRXLKpFi04wXl+PQPSrzZMHYzuhRqTgfnNVEGIcDJwLrq8NNqXEeEDxsjqRcBDXesy2Gkrg==
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr7678933lja.19.1548416674512;
        Fri, 25 Jan 2019 03:44:34 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id l3-v6sm1490962ljg.21.2019.01.25.03.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 03:44:34 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] spi-atmel: support inter-word delay
Date:   Fri, 25 Jan 2019 12:44:29 +0100
Message-Id: <20190125114429.20066-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125114429.20066-1-jonas@norrbonn.se>
References: <20190125114429.20066-1-jonas@norrbonn.se>
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
 drivers/spi/spi-atmel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 74fddcd3282b..88ff3fef56e9 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1209,13 +1209,14 @@ static int atmel_spi_setup(struct spi_device *spi)
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
+		clamp_t(u8, (as->spi_clk/1000000*spi->word_delay)>>5, 1, 255));
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
 	npcs_pin = (unsigned long)spi->controller_data;
-- 
2.19.1

