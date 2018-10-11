Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5CCC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D722075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="isk/OrD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D722075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeJKWYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:24:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJKWYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tUNhb6urJ8LbtfFt9qhzSLr4glnksGdzBwS54MNsasM=; b=isk/OrD1RFec
        f21Mxg8hNkFLV4D8uhY7ihPamE5y2a0ZZi6tuet5T22PLb7gjSyE6WF2fWulSGCEUfJJDajKV631e
        +qIN3czoUVWMt5VdEPFWis9aGPS+SJuDBvYIEcf0DIatBHtVZdUz4sLqFiwM4mZFm3jTBTmv2oWJx
        urf1c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAcNV-0001sU-7r; Thu, 11 Oct 2018 14:55:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 07C8111223ED; Thu, 11 Oct 2018 15:55:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-rockchip@lists.infradead.org,
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
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: simplify spi enable logic" to the spi tree
In-Reply-To:  <20181010090038.20834-8-kernel@esmil.dk>
Message-Id: <20181011145553.07C8111223ED@debutante.sirena.org.uk>
Date:   Thu, 11 Oct 2018 15:55:53 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: simplify spi enable logic

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From a3c174021ce780f5d2e9b2105e2cb4903a37226d Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 10 Oct 2018 11:00:38 +0200
Subject: [PATCH] spi: rockchip: simplify spi enable logic

Let the dma/non-dma code paths handle the spi enable
flag themselves. This removes some logic to determine
if the flag should be turned on before or after dma
and also don't leave the spi enabled if the dma path
fails.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 6fa809da61dd..ffa564fbf970 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -379,6 +379,8 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 {
 	int remain = 0;
 
+	spi_enable_chip(rs, 1);
+
 	do {
 		if (rs->tx) {
 			remain = rs->tx_end - rs->tx;
@@ -498,6 +500,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_rx.ch);
 	}
 
+	spi_enable_chip(rs, 1);
+
 	if (txdesc) {
 		spin_lock_irqsave(&rs->lock, flags);
 		rs->state |= TXBUSY;
@@ -506,7 +510,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_tx.ch);
 	}
 
-	return 0;
+	/* 1 means the transfer is in progress */
+	return 1;
 }
 
 static void rockchip_spi_config(struct rockchip_spi *rs)
@@ -589,7 +594,6 @@ static int rockchip_spi_transfer_one(
 		struct spi_device *spi,
 		struct spi_transfer *xfer)
 {
-	int ret = 0;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
 	WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
@@ -633,24 +637,10 @@ static int rockchip_spi_transfer_one(
 
 	rockchip_spi_config(rs);
 
-	if (rs->use_dma) {
-		if (rs->tmode == CR0_XFM_RO) {
-			/* rx: dma must be prepared first */
-			ret = rockchip_spi_prepare_dma(rs);
-			spi_enable_chip(rs, 1);
-		} else {
-			/* tx or tr: spi must be enabled first */
-			spi_enable_chip(rs, 1);
-			ret = rockchip_spi_prepare_dma(rs);
-		}
-		/* successful DMA prepare means the transfer is in progress */
-		ret = ret ? ret : 1;
-	} else {
-		spi_enable_chip(rs, 1);
-		ret = rockchip_spi_pio_transfer(rs);
-	}
+	if (rs->use_dma)
+		return rockchip_spi_prepare_dma(rs);
 
-	return ret;
+	return rockchip_spi_pio_transfer(rs);
 }
 
 static bool rockchip_spi_can_dma(struct spi_master *master,
-- 
2.19.0.rc2

