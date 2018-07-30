Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA1016256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A2A205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="iHLYTs2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A2A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeG3RjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:39:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeG3RjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GxCFZRent24yHL9FAhfIdYGnYBLZx/oBjnbopKpzPC4=; b=iHLYTs2NopTn
        68ldsm81lG+uG+KdayBj7YbGd6ppGqd5jP4X1jhl/Wz6Ws3ZT7yTax00aI/HljDBBBQ/IS7oXAfNM
        gB0gbL+nL4vV4TIcEoTMJCK6EC4dTfCmb/03RAC8V0Iy8C1jiwcsqcZ8IHGBCLP3BBI43InLQ8bSL
        +VdSM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkAdl-0005YL-Ay; Mon, 30 Jul 2018 16:03:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 15054112421C; Mon, 30 Jul 2018 17:03:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: omap2-mcspi: remove several redundant variables" to the spi tree
In-Reply-To:  <20180730144546.10699-1-colin.king@canonical.com>
Message-Id: <20180730160321.15054112421C@debutante.sirena.org.uk>
Date:   Mon, 30 Jul 2018 17:03:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: omap2-mcspi: remove several redundant variables

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

From 45e41bc5259242921da755c60c705ff368beb8ce Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 30 Jul 2018 15:45:46 +0100
Subject: [PATCH] spi: omap2-mcspi: remove several redundant variables

Variable count, l, mcspi and spi_cntrl are being assigned but are
never used hence they are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'count' set but not used [-Wunused-but-set-variable]
warning: variable 'l' set but not used [-Wunused-but-set-variable]
warning: variable 'mcspi' set but not used [-Wunused-but-set-variable]
warning: variable 'spi_cntrl' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 6c628a54e946..508c61c669e7 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -398,11 +398,9 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
-	unsigned int		count;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
-	count = xfer->len;
 
 	if (mcspi_dma->dma_tx) {
 		struct dma_async_tx_descriptor *tx;
@@ -582,7 +580,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	struct omap2_mcspi_dma  *mcspi_dma;
 	unsigned int		count;
-	u32			l;
 	u8			*rx;
 	const u8		*tx;
 	struct dma_slave_config	cfg;
@@ -595,8 +592,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
-	l = mcspi_cached_chconf0(spi);
-
 
 	if (cs->word_len <= 8) {
 		width = DMA_SLAVE_BUSWIDTH_1_BYTE;
@@ -676,7 +671,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 static unsigned
 omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 {
-	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	unsigned int		count, c;
 	u32			l;
@@ -686,7 +680,6 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 	void __iomem		*chstat_reg;
 	int			word_len;
 
-	mcspi = spi_master_get_devdata(spi->master);
 	count = xfer->len;
 	c = count;
 	word_len = cs->word_len;
@@ -883,13 +876,11 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 {
 	struct omap2_mcspi_cs *cs = spi->controller_state;
 	struct omap2_mcspi *mcspi;
-	struct spi_master *spi_cntrl;
 	u32 l = 0, clkd = 0, div, extclk = 0, clkg = 0;
 	u8 word_len = spi->bits_per_word;
 	u32 speed_hz = spi->max_speed_hz;
 
 	mcspi = spi_master_get_devdata(spi->master);
-	spi_cntrl = mcspi->master;
 
 	if (t != NULL && t->bits_per_word)
 		word_len = t->bits_per_word;
-- 
2.18.0

