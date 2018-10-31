Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A612ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3019E20840
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC54jJBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3019E20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeJaTzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38434 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbeJaTzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id c1-v6so13212946ede.5;
        Wed, 31 Oct 2018 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rs2LcgmQGCncpft7MaTg8PjtcQwZ1HH5YMHMu/sFwOI=;
        b=OC54jJBilbUazi6Ne0xC+3kdPSx8z01hM6b7sKqZ5gl+Nfm0ZNuANEiX57ZDEZTC0l
         l1jVwyjvYP4gKr+jVLLvmevoWGMd4HiO/ZbmUiaNyFlghSetXK/bDzyPL6NI5gRfyoC1
         /4Ny5DGAkAdzc5sBSaxv0XdRJkT1PL6zWwURTMMDLCzlIFogMZJGvIMpaqXcRXvVetL1
         NT6rBNk4jjXW5rFPQMTR7gc9MkOnP0PTNsMvs9a4/lrFcmyiHruDVlbb8opLC6q6jEih
         2QyfUq5sNJP6kRuSnH1oF8+szvkKABtbtC3ut7c5hcTUzUk2P7r3vbQxAW7RC5tguqGz
         x62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Rs2LcgmQGCncpft7MaTg8PjtcQwZ1HH5YMHMu/sFwOI=;
        b=X2IVA0vf23TeW4RYMPllsa0U+lpILUC1FvjkQTh+nfncRcponKez5G34f244yWeLwK
         iV1IxvOUBlo6rh+wva77Cjf1TcmfY4lF4FDJbGbwiiX43PvQqa9rUXjS/hRlj2Y6Fk04
         dnj5ZkfrHkZyQHkEubnYzO6C5kzZYiZhEIDhaPfUizDfGE9DjuetamXKoHSA9nio/d3u
         lWtHdOw5GQFlt3kbTsnANhxDvn0jXNJccBGhDE+d1WtfY2yxzGtpqsdBL0ThCDpc1rG1
         4/KGs8oHbKS6ODSTNDa4cVRcB2S/HlIaUS+8uplluvEUlFv4rnShvkG4NFbgubMbhcdD
         7/tQ==
X-Gm-Message-State: AGRZ1gIQv9PbfclOpbe2nkkxPUY5W5v2/BPfLtRXLPlodIOtpW8Z9gwt
        z64goCGh8VaHCPHKfxL+ZNx15ve/QmI=
X-Google-Smtp-Source: AJdET5ea8afZYWNBE9XM+iEa43V8OIl92bvPXVKcuAC9RFGrN7cfMzRRNtvEySZqyFF9ck5/dHsrXA==
X-Received: by 2002:a50:be4c:: with SMTP id b12-v6mr1639738edi.46.1540983484774;
        Wed, 31 Oct 2018 03:58:04 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:58:04 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/14] spi: rockchip: disable spi on error
Date:   Wed, 31 Oct 2018 11:57:02 +0100
Message-Id: <20181031105711.19575-6-esmil@mailme.dk>
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

Successful transfers leave the spi disabled, so if
we just make sure to disable the spi on error
there should be no need to disable the spi from
master->unprepare_message.

This also flushes the tx and rx fifos,
so no need to do that manually.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1c813797f963..5729e6071729 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -210,12 +210,6 @@ static inline void spi_set_clk(struct rockchip_spi *rs, u16 div)
 	writel_relaxed(div, rs->regs + ROCKCHIP_SPI_BAUDR);
 }
 
-static inline void flush_fifo(struct rockchip_spi *rs)
-{
-	while (readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR))
-		readl_relaxed(rs->regs + ROCKCHIP_SPI_RXDR);
-}
-
 static inline void wait_for_idle(struct rockchip_spi *rs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5);
@@ -304,29 +298,16 @@ static void rockchip_spi_handle_err(struct spi_master *master,
 {
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	/*
-	 * For DMA mode, we need terminate DMA channel and flush
-	 * fifo for the next transfer if DMA thansfer timeout.
-	 * handle_err() was called by core if transfer failed.
-	 * Maybe it is reasonable for error handling here.
+	/* stop running spi transfer
+	 * this also flushes both rx and tx fifos
 	 */
+	spi_enable_chip(rs, false);
+
 	if (atomic_read(&rs->state) & TXDMA)
 		dmaengine_terminate_async(rs->dma_tx.ch);
 
-	if (atomic_read(&rs->state) & RXDMA) {
+	if (atomic_read(&rs->state) & RXDMA)
 		dmaengine_terminate_async(rs->dma_rx.ch);
-		flush_fifo(rs);
-	}
-}
-
-static int rockchip_spi_unprepare_message(struct spi_master *master,
-					  struct spi_message *msg)
-{
-	struct rockchip_spi *rs = spi_master_get_devdata(master);
-
-	spi_enable_chip(rs, false);
-
-	return 0;
 }
 
 static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
@@ -705,7 +686,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	master->set_cs = rockchip_spi_set_cs;
 	master->prepare_message = rockchip_spi_prepare_message;
-	master->unprepare_message = rockchip_spi_unprepare_message;
 	master->transfer_one = rockchip_spi_transfer_one;
 	master->max_transfer_size = rockchip_spi_max_transfer_size;
 	master->handle_err = rockchip_spi_handle_err;
-- 
2.19.1

