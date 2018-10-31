Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3894CECDE4A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0044120685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpIh9R9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0044120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbeJaTzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40311 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbeJaTzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id z12-v6so7433507edp.7;
        Wed, 31 Oct 2018 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbib6+Pg43Lu6Hx+gFx5uFOJQsxtYC1x/SdUYr9c7sk=;
        b=KpIh9R9P5Rhk0lFQ/Zyu/hAbKFoN1QJpGwB+ypPCjbREch5iHc81Y7zIE1oGGGV+a2
         FqOwLxgqPHzPlM0RCnq8F4mRvHCpDsqiuHNvCQ5bhyCAsv2vczAKl6iHwIUiD3jikMXG
         NYHaQkL0Vy7cq6EutwE+XjMtyXcO56s9ZcOAVtLRhWaTpucBrg/0Y7PncqBpMG4yeKlG
         IOcRpr8WwCxYf+UNzkJZ2lO7iH3E9SuLSGiA7xr306A9ZSOWmQmm7Jr9ItPG5aDE0V/p
         NKp4q3EVBELcTvDstiT85jPJ/ofIEFpXcVbPeYhcBhSPPW1AKkBJY+3uEG+7Ufz/6Yqv
         j1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dbib6+Pg43Lu6Hx+gFx5uFOJQsxtYC1x/SdUYr9c7sk=;
        b=o0eECnJi2AA+0Mn4v5l6/M5hGfvXeXhwYh8lP7WR97EH+IjezJmMYEgCbtUruwP2rV
         siTEvPdcKmfEd2qXTUjT/Ocd06YM19DNrGpgh3rVMIs2P3UDEao+/ArxXBgSozPjzkLO
         VZIS8rqlvmJ2ow8nfP5JV+AH7BqHNQiqGJxGe5JPkWWa05EZCnHtx7vMolBZOS0IgYq/
         JULPJEp1s7pgDn5RTY9LKe9AU9sblNqRRs2IArrA1zGtR7CQ5fiGuIVS0CgbPti4KjAJ
         TCF1kgFgNDAxJwIt+2zY1HxwIpaqP6KF22IdWqtt1zihs9tKMW5IJcTWuCVzlX/8JugI
         i5Qw==
X-Gm-Message-State: AGRZ1gKQhTw1n/k19/cQ7GH1YkqnmHI1bI4bGvylMPWza94pXKSzpJWB
        k8YzSgxRLCyKFGAX6uEiehJDtGSmJL0=
X-Google-Smtp-Source: AJdET5cYec+mxKgDji0431AUeFOOGz3I9Hecae8pfliWAblnj3ztKju9VneIAn0b3zQa+SLBNubAvA==
X-Received: by 2002:aa7:c6ca:: with SMTP id b10-v6mr1608166eds.249.1540983482517;
        Wed, 31 Oct 2018 03:58:02 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:58:01 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/14] spi: rockchip: always use SPI mode
Date:   Wed, 31 Oct 2018 11:57:00 +0100
Message-Id: <20181031105711.19575-4-esmil@mailme.dk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

The hardware supports 3 different variants of SPI
and there were some code around it, but nothing
to actually set it to anything but "Motorola SPI".
Just drop that code and always use that mode.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 87d1b9837d94..7fac4253075e 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -156,12 +156,6 @@
 
 #define ROCKCHIP_SPI_MAX_CS_NUM			2
 
-enum rockchip_ssi_type {
-	SSI_MOTO_SPI = 0,
-	SSI_TI_SSP,
-	SSI_NS_MICROWIRE,
-};
-
 struct rockchip_spi_dma_data {
 	struct dma_chan *ch;
 	dma_addr_t addr;
@@ -179,8 +173,6 @@ struct rockchip_spi {
 	u32 fifo_len;
 	/* max bus freq supported */
 	u32 max_freq;
-	/* supported slave numbers */
-	enum rockchip_ssi_type type;
 
 	u16 mode;
 	u8 tmode;
@@ -525,14 +517,14 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	u32 dmacr = 0;
 	int rsd = 0;
 
-	u32 cr0 = (CR0_BHT_8BIT << CR0_BHT_OFFSET)
-		| (CR0_SSD_ONE << CR0_SSD_OFFSET)
-		| (CR0_EM_BIG << CR0_EM_OFFSET);
+	u32 cr0 = CR0_FRF_SPI  << CR0_FRF_OFFSET
+	        | CR0_BHT_8BIT << CR0_BHT_OFFSET
+	        | CR0_SSD_ONE  << CR0_SSD_OFFSET
+	        | CR0_EM_BIG   << CR0_EM_OFFSET;
 
 	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
 	cr0 |= ((rs->mode & 0x3) << CR0_SCPH_OFFSET);
 	cr0 |= (rs->tmode << CR0_XFM_OFFSET);
-	cr0 |= (rs->type << CR0_FRF_OFFSET);
 
 	if (rs->use_dma) {
 		if (rs->tx)
@@ -709,7 +701,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	spi_enable_chip(rs, false);
 
-	rs->type = SSI_MOTO_SPI;
 	rs->master = master;
 	rs->dev = &pdev->dev;
 	rs->max_freq = clk_get_rate(rs->spiclk);
-- 
2.19.1

