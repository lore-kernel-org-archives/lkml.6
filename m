Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C178DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CBD21708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF8iFpXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CBD21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeHHJc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:32:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42796 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeHHJc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:32:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so1009426wrs.9;
        Wed, 08 Aug 2018 00:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=zy4ko3dpdzUpka1lCnwWKHJKCO3d//qbVgzCB2+viZg=;
        b=MF8iFpXbrb9l2zWXx7Cqwd3BFJrDxCjQUnJJwFM5Zcmf5v1Ipj0loHeHsNRlr2Kyn5
         Wq8PhGTmEH46TZ/uvO8DT7+p4ApijgAGV2nVjnyQ24mZouACDLRboXRhobwawgjZ6Gtd
         iU9hkFmBp/thhSdTfZyqeOEzyVBDtV1eIgeQVY5HXHsvay4t19983cCMa5pR0Yl1ZV2l
         YBD/YeZ+mfEJB8vPH1ezRmXvWGJtowHygZ9hJBCiwpFGKzSJVOvltpzYeDfjUKW5vO6f
         oRQPse+28saLVQefPFll3u15Pqzf9IuPzb0zK4NuOexx4Asi08AXF85JLubTUR5BHuBa
         UmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=zy4ko3dpdzUpka1lCnwWKHJKCO3d//qbVgzCB2+viZg=;
        b=uBgR49hyj13o2+jQO7kUC9K75dp3a+qWlFJEw8084HvCw042gb5z0F8LDsrr/wM1vR
         JdYaF22FyWAP7oCsbOGAcWVRM33KFYkGC27RC4VP+VA9NLtARaDTKATZD4jnl6SI2sFP
         VKdPFDaEKMuk7r59s4QKKzBiTwwfpFr3O5jaX5cr5ICu/WOmW3Cq90LhKuBmy70LcJk0
         DZlcR1mSn2nlHGDZn5BNolY60nPnR8PR3QEq9fKjUbyanY2MLeRjjCp17/6yW8ZiNA0B
         w/8rp25nPGn/cCZ6p6jAUneVFf6cIHjTann1ymGO2Bc4rchoXp2DU9wNH/8oQsk7DPgy
         SwKw==
X-Gm-Message-State: AOUpUlG6VVvgbWBiNURjfHJUZ8e9po0xFKqCA89W6elUZZ7NJwfZd82i
        g/95m4f2sguGK41lAgB3+Lg=
X-Google-Smtp-Source: AA+uWPzgTeIAyOobCqfN3Qxv2jrsvnBggUUEerX0jT3kE1kHI2DTANz34/aNG6+ERC9hTqe+I2yb3w==
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr1082647wrr.227.1533712476533;
        Wed, 08 Aug 2018 00:14:36 -0700 (PDT)
Received: from ubuntu.home ([2a02:8071:6a3:700:542c:ff11:9c97:a518])
        by smtp.gmail.com with ESMTPSA id r12-v6sm11971036wmh.0.2018.08.08.00.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 00:14:35 -0700 (PDT)
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw: support 4-16 bits per word
Date:   Wed,  8 Aug 2018 09:14:21 +0200
Message-Id: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-dw driver currently only supports 8 or 16 bits per word.

Since the hardware supports 4-16 bits per word, adapt the driver
to also support this.

Tested on socfpga cyclone5 with a 9-bit SPI display.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
---
 drivers/spi/spi-dw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f693bfe95ab9..2ecbb6b19cea 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -307,14 +307,14 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		dws->current_freq = transfer->speed_hz;
 		spi_set_clk(dws, chip->clk_div);
 	}
-	if (transfer->bits_per_word == 8) {
+	if ((transfer->bits_per_word < 4) || (transfer->bits_per_word > 16))
+		return -EINVAL;
+	if (transfer->bits_per_word <= 8) {
 		dws->n_bytes = 1;
 		dws->dma_width = 1;
-	} else if (transfer->bits_per_word == 16) {
+	} else {
 		dws->n_bytes = 2;
 		dws->dma_width = 2;
-	} else {
-		return -EINVAL;
 	}
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
@@ -493,7 +493,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	}
 
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
-	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
 	master->bus_num = dws->bus_num;
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
-- 
2.17.1

