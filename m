Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27021C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9072086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ct6HK5kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9072086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbeKEVZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:25:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52724 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeKEVZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=anRtuzG54tE9SikVM/b13B3sTjYwYZTxqyVknY0zoo4=; b=ct6HK5kgZ5BZ
        yvL6ebBgVMMgDjiyPGSGk/ii6mn0YAKlfPlAVZJ57765Bn0c7E+QrNRL01JUnlROUGEHZ3LBHx11E
        4UPszzo5FRnxpOskUjjEjpPbBlNDSqaTxCEAtl+9pnXZOrpvfzLYKEzF+34c8EG+GFEscQw6xSTzN
        tGebE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJddx-0008MP-Hj; Mon, 05 Nov 2018 12:06:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 37CCD1124D98; Mon,  5 Nov 2018 12:06:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: support 4bit words" to the spi tree
In-Reply-To:  <20181031105711.19575-14-esmil@mailme.dk>
Message-Id: <20181105120609.37CCD1124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:06:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: support 4bit words

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

From 65498c6ae2414a1425aa6c4231e79e2998afec05 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 31 Oct 2018 11:57:10 +0100
Subject: [PATCH] spi: rockchip: support 4bit words

The hardware supports 4, 8 and 16bit spi words,
so add the missing support for 4bit words.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 41 +++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1297f081818d..9e47e81553a1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -54,6 +54,9 @@
 
 /* Bit fields in CTRLR0 */
 #define CR0_DFS_OFFSET				0
+#define CR0_DFS_4BIT				0x0
+#define CR0_DFS_8BIT				0x1
+#define CR0_DFS_16BIT				0x2
 
 #define CR0_CFS_OFFSET				2
 
@@ -464,15 +467,14 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		struct spi_device *spi, struct spi_transfer *xfer,
 		bool use_dma)
 {
-	u32 dmacr = 0;
-
 	u32 cr0 = CR0_FRF_SPI  << CR0_FRF_OFFSET
 	        | CR0_BHT_8BIT << CR0_BHT_OFFSET
 	        | CR0_SSD_ONE  << CR0_SSD_OFFSET
 	        | CR0_EM_BIG   << CR0_EM_OFFSET;
+	u32 cr1;
+	u32 dmacr = 0;
 
 	cr0 |= rs->rsd << CR0_RSD_OFFSET;
-	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 
 	if (xfer->rx_buf && xfer->tx_buf)
@@ -482,6 +484,27 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	else if (use_dma)
 		cr0 |= CR0_XFM_TO << CR0_XFM_OFFSET;
 
+	switch (xfer->bits_per_word) {
+	case 4:
+		cr0 |= CR0_DFS_4BIT << CR0_DFS_OFFSET;
+		cr1 = xfer->len - 1;
+		break;
+	case 8:
+		cr0 |= CR0_DFS_8BIT << CR0_DFS_OFFSET;
+		cr1 = xfer->len - 1;
+		break;
+	case 16:
+		cr0 |= CR0_DFS_16BIT << CR0_DFS_OFFSET;
+		cr1 = xfer->len / 2 - 1;
+		break;
+	default:
+		/* we only whitelist 4, 8 and 16 bit words in
+		 * master->bits_per_word_mask, so this shouldn't
+		 * happen
+		 */
+		unreachable();
+	}
+
 	if (use_dma) {
 		if (xfer->tx_buf)
 			dmacr |= TF_DMA_EN;
@@ -490,13 +513,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	}
 
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
-
-	if (rs->n_bytes == 1)
-		writel_relaxed(xfer->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
-	else if (rs->n_bytes == 2)
-		writel_relaxed((xfer->len / 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
-	else
-		writel_relaxed((xfer->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	writel_relaxed(cr1, rs->regs + ROCKCHIP_SPI_CTRLR1);
 
 	/* unfortunately setting the fifo threshold level to generate an
 	 * interrupt exactly when the fifo is full doesn't seem to work,
@@ -545,7 +562,7 @@ static int rockchip_spi_transfer_one(
 		return -EINVAL;
 	}
 
-	rs->n_bytes = xfer->bits_per_word >> 3;
+	rs->n_bytes = xfer->bits_per_word <= 8 ? 1 : 2;
 
 	use_dma = master->can_dma ? master->can_dma(master, spi, xfer) : false;
 
@@ -667,7 +684,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
 	master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	master->dev.of_node = pdev->dev.of_node;
-	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8) | SPI_BPW_MASK(4);
 	master->min_speed_hz = rs->freq / BAUDR_SCKDV_MAX;
 	master->max_speed_hz = min(rs->freq / BAUDR_SCKDV_MIN, MAX_SCLK_OUT);
 
-- 
2.19.0.rc2

