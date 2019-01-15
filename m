Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB25C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFAB20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547579329;
	bh=33wV/ZCjVeE/rHBbVxudVsPuw+awL3YkZu+Ox7wuR0M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=n9xt8pSoe1TT5BLyYm6Baef2egB7+7Zk3L8hkDJijalb4OhuI9FWPSLrMRGtqzNlR
	 DpCft1Tsts7y3ZKvmV4PM6sKST+HepwyI/VGQfYsYDpu3rvhzqMJJf627REnhxj/h/
	 Yjx0KXdN4+AJ6nHNXFT4wcJPaQ3oKK2bizJdeZdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbfAOTIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:08:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57208 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732387AbfAOTIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vTwjV8Z9149BVSSK7fdSWFacNeADPC0eQaIXkteG95s=; b=ty8b1OINnPHC
        Q1Jsgh1rYNi+HEWtqVrj9Qrg1Ogcp7szXS7jMua27/WSwqf4jknz6XRRDTWpFNYbFaaybl9A8p8f6
        xQYxFLIUtdNqXV9J1sJWKmcmcwM+wCFnfkJqbyywzJ3axl1C2TlsQjZDfA/O4ivf3iu6ZJL0cYVYK
        C8r9M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjU4j-00028B-NJ; Tue, 15 Jan 2019 19:08:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4BBE11127848; Tue, 15 Jan 2019 19:08:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     stable@vger.kernel.org, David Lechner <david@lechnology.com>,
        David Lechner <david@lechnology.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: omap2-mcspi: Fix DMA and FIFO event trigger size mismatch" to the spi tree
In-Reply-To:  <20190115065832.23705-1-vigneshr@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20190115190837.4BBE11127848@debutante.sirena.org.uk>
Date:   Tue, 15 Jan 2019 19:08:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: omap2-mcspi: Fix DMA and FIFO event trigger size mismatch

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

From baf8b9f8d260c55a86405f70a384c29cda888476 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Tue, 15 Jan 2019 12:28:32 +0530
Subject: [PATCH] spi: omap2-mcspi: Fix DMA and FIFO event trigger size
 mismatch

Commit b682cffa3ac6 ("spi: omap2-mcspi: Set FIFO DMA trigger level to word length")
broke SPI transfers where bits_per_word != 8. This is because of
mimsatch between McSPI FIFO level event trigger size (SPI word length) and
DMA request size(word length * maxburst). This leads to data
corruption, lockup and errors like:

	spi1.0: EOW timed out

Fix this by setting DMA maxburst size to 1 so that
McSPI FIFO level event trigger size matches DMA request size.

Fixes: b682cffa3ac6 ("spi: omap2-mcspi: Set FIFO DMA trigger level to word length")
Cc: stable@vger.kernel.org
Reported-by: David Lechner <david@lechnology.com>
Tested-by: David Lechner <david@lechnology.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 2fd8881fcd65..8be304379628 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -623,8 +623,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
 	cfg.src_addr_width = width;
 	cfg.dst_addr_width = width;
-	cfg.src_maxburst = es;
-	cfg.dst_maxburst = es;
+	cfg.src_maxburst = 1;
+	cfg.dst_maxburst = 1;
 
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
-- 
2.20.1

