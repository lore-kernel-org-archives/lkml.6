Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F988ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4BD2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzj2SHgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4BD2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeGPGvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:51:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43404 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeGPGvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:51:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so7117068pgr.10;
        Sun, 15 Jul 2018 23:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sxuTlQsvACylqRlgNPFp8PwoHEgqMMevgBYnJPwe8o0=;
        b=nzj2SHgrCEdW05NIUWi4zdbnxxgP6+45ljbrAdjFDReuKuB/dxYIC+RMUo+1aU/ScA
         gucnX27iDXyeCAIRIHTcZ7bQn65csI2RSNMp7FirbQVo+JiT7UjZYCk0lhPMJcAw85eA
         woEJnINxIhi7EIXY2oL9iqXPVU5nHKCc/5QdWH4mkzaIGBXIlfgpwmZN4Av7JEepVPuW
         70la6PvsuGe/+XIvRglJQP4bkdPHy5ESo5bOuQKRXxR9VA87Y1Dnrc6HCisCF8o8LRNO
         3Rwdrx4w7pAZSmpNLkXVpGUGJ6u5EmIezR9MW3VlKDqAY7c70xiHTOz+RwSq7ebDqNXn
         dVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sxuTlQsvACylqRlgNPFp8PwoHEgqMMevgBYnJPwe8o0=;
        b=OVj1NMbHslTEz2D6JBuUv6IlZP5Sd4uaBEIGzHztaqRWeiS/GO8RvBcn5BBYQvmbfz
         lwgwEg/BOb7BQtKsu/Bc/jcM983NDrYGRPqELCcDQtqqXdiE7jj8QpPjClC2FZbnjG2k
         TjqbhQG4UEkHDv1Bw67QvUGL3eqO+vmEebPkHBmFCdtfOZ8cS2IRHChok5uc95yBmxvy
         +rGydb/6nDr6znuBoi5ExqXIO88LY/HONnk7ADIjWu+MXjA4iTKNMaxan1/XjliFv+X2
         5Vh+6hU24kSN5m+oOQ/GqOv80UHFusBndQ1/10sF9PMT7ssLd4hvGN3QxE8RudceEHBO
         AMzQ==
X-Gm-Message-State: AOUpUlFNRwSCldRTCMvkEsHpBgRvmWc2JCLeL3RV9EJ8baXToR2mlenv
        KrhLZqjAKI7ee5/Ub9nv1Cun6p2F
X-Google-Smtp-Source: AAOMgpdXoh9IgFBsrdNjYtG9mg2IlimIuXNhLUYmTfxK9F7dQu9wC853HiMGv0f0KNc9/6WyKxRkxQ==
X-Received: by 2002:a65:44c3:: with SMTP id g3-v6mr14361166pgs.231.1531722330930;
        Sun, 15 Jul 2018 23:25:30 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t78-v6sm55170715pfa.160.2018.07.15.23.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 23:25:29 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Stefan Agner <stefan@agner.ch>, cphealy@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-fsl-dspi: Fill actual_length when doing DMA transfer
Date:   Sun, 15 Jul 2018 23:25:08 -0700
Message-Id: <20180716062508.7726-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of SPI device drivers may rely on 'actual_length', so it is
important that information is correctly reported. One example would be
spi_mem_exec_op() which will fail if 'actual_length' doesn't match
requested transfer length. To fix the problem, add necessary code to
populate 'actual_length'.

Cc: Mark Brown <broonie@kernel.org>
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: cphealy@gmail.com
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0630962ce442..8877dd1e18dc 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -327,6 +327,7 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct fsl_dspi_dma *dma = dspi->dma;
 	struct device *dev = &dspi->pdev->dev;
+	struct spi_message *message = dspi->cur_msg;
 	int curr_remaining_bytes;
 	int bytes_per_buffer;
 	int word = 1;
@@ -348,7 +349,10 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 			goto exit;
 
 		} else {
-			curr_remaining_bytes -= dma->curr_xfer_len * word;
+			const int len = dma->curr_xfer_len * word;
+
+			curr_remaining_bytes -= len;
+			message->actual_length += len;
 			if (curr_remaining_bytes < 0)
 				curr_remaining_bytes = 0;
 		}
-- 
2.17.1

