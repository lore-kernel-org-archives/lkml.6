Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B432EC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797AE214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX8ftzhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797AE214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeJJQXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:23:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46412 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeJJQXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:23:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id z144-v6so3360073lff.13;
        Wed, 10 Oct 2018 02:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1wYnlUgcfpcHgJvA96w+RLcQIxhKmNVE/gaATftEyo=;
        b=YX8ftzhcGVUtGMcOs/GPlyGJsTa82qCFw1D3W72YFq761h+2Hsr0RJjEH4sTqiK1l5
         v66ua5nUCMbl9V65AVPwJnGWwNaMzV55W52ry4HBkPOTOmx/OFwfC2ZPDPifnmhLtNbK
         +ix1bDrDrt6hqrrXKV/KXjNrKDfZl/dYalW01ivXIjxvGfVSEm5QXWjv14Qe2zvZDb+W
         xBy260e4sAtaXzV+WZB9lH0llVpqM7uKHQXaSRSwCLNZbZ6tbQXrBwLY+09RWml29U9s
         wSak9hExeKWvRovax5RBq/C7PiEbI+dAltZFngsZER4OlJ0rcIa8+Hd410GO6zICp1z8
         GnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=H1wYnlUgcfpcHgJvA96w+RLcQIxhKmNVE/gaATftEyo=;
        b=BCYW8JGzxSu8KuhLs9PuQmepBBvjZ2b6J7Daz5XaZ0HBkaq8mbnIQLUOhb0g6+LNZI
         LOcWMDHVOhCZCHBQHYbmMw5Z9R1zPyF0wdwhgKFwDIX1IWoyxbvEWn5zk5M2ou9cwqpa
         mbksPzcmWed9iQ21o4f8nz+Sfdsd6qOTCwFZy2tk1Czm6JSU4s5Ub1K/2ZMqo+NCcDjE
         LyFgH1tig0ryi5BEM5wEEMGU7QX9uPihbTcv3Wpr6EESqPRb+R9unOQAfOucxCz7p3bJ
         bL8TCP1lP3i8ivs+TcVpJ3zZnNXcbb1nF7h8tjF3gcfJP1NNV67Ocu9quTCSB12J6N6Z
         CHgw==
X-Gm-Message-State: ABuFfohJaXI4WMTdPE6l0QG+q/cAffbNb0S2GMRd0XdX1aEYA7kz9MEB
        Ss7BPpQjmQ9KS/xi3Nqomn8=
X-Google-Smtp-Source: ACcGV61n5/KgpPFjcr0D0nPzvbXlF4T9M+zjt0qq3dmcy0RcqcjAxHXWT86QY0K2fc8AGUc8OYuTqw==
X-Received: by 2002:a19:5e5d:: with SMTP id z29-v6mr17336105lfi.110.1539162116518;
        Wed, 10 Oct 2018 02:01:56 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id q2-v6sm2150078lfc.67.2018.10.10.02.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 02:01:55 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-rockchip@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 6/7] spi: rockchip: directly use direction constants
Date:   Wed, 10 Oct 2018 11:00:37 +0200
Message-Id: <20181010090038.20834-7-kernel@esmil.dk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181010090038.20834-1-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma direction for the tx and rx dma channels never
change, so just use the constants directly rather
than storing them in device data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1d8bf45304a5..1044849a352d 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -164,7 +164,6 @@ enum rockchip_ssi_type {
 
 struct rockchip_spi_dma_data {
 	struct dma_chan *ch;
-	enum dma_transfer_direction direction;
 	dma_addr_t addr;
 };
 
@@ -454,7 +453,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	rxdesc = NULL;
 	if (rs->rx) {
-		rxconf.direction = rs->dma_rx.direction;
+		rxconf.direction = DMA_DEV_TO_MEM;
 		rxconf.src_addr = rs->dma_rx.addr;
 		rxconf.src_addr_width = rs->n_bytes;
 		rxconf.src_maxburst = 1;
@@ -463,7 +462,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		rxdesc = dmaengine_prep_slave_sg(
 				rs->dma_rx.ch,
 				rs->rx_sg.sgl, rs->rx_sg.nents,
-				rs->dma_rx.direction, DMA_PREP_INTERRUPT);
+				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
 		if (!rxdesc)
 			return -EINVAL;
 
@@ -473,7 +472,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	txdesc = NULL;
 	if (rs->tx) {
-		txconf.direction = rs->dma_tx.direction;
+		txconf.direction = DMA_MEM_TO_DEV;
 		txconf.dst_addr = rs->dma_tx.addr;
 		txconf.dst_addr_width = rs->n_bytes;
 		txconf.dst_maxburst = rs->fifo_len / 2;
@@ -482,7 +481,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		txdesc = dmaengine_prep_slave_sg(
 				rs->dma_tx.ch,
 				rs->tx_sg.sgl, rs->tx_sg.nents,
-				rs->dma_tx.direction, DMA_PREP_INTERRUPT);
+				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 		if (!txdesc) {
 			if (rxdesc)
 				dmaengine_terminate_sync(rs->dma_rx.ch);
@@ -778,8 +777,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	if (rs->dma_tx.ch && rs->dma_rx.ch) {
 		rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
 		rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
-		rs->dma_tx.direction = DMA_MEM_TO_DEV;
-		rs->dma_rx.direction = DMA_DEV_TO_MEM;
 
 		master->can_dma = rockchip_spi_can_dma;
 		master->dma_tx = rs->dma_tx.ch;
-- 
2.19.1

