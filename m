Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B618C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0172A20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="R/bfSx2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0172A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeIFPpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:45:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42562 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbeIFPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xfpdmsSsukgD64Mf0TiOVIK3TP7YFYUKtiJjo7eWb/A=; b=R/bfSx2mocuB
        9vuTDNVg5Y4/sZqkshqvpKE8Vuj1g5ajV1y6ZQMUYewMFXK3LSca1yV52ifafDJFyRca8NtDY088Z
        J6fLyeIb8eNR89hGoXSB276d1tqzwJK7TUYa+yrt8iznG3/OLK23pyTPGpc65fG+m+xRSFJ+WblnT
        HORaA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxsAm-0004B0-Or; Thu, 06 Sep 2018 11:10:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 77B0A1122A1F; Thu,  6 Sep 2018 12:10:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>, linux-spi@vger.kernel.org
Subject: Applied "spi: dw: support 4-16 bits per word" to the spi tree
In-Reply-To:  <20180904194944.19721-1-simon.k.r.goldschmidt@gmail.com>
Message-Id: <20180906111004.77B0A1122A1F@debutante.sirena.org.uk>
Date:   Thu,  6 Sep 2018 12:10:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw: support 4-16 bits per word

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

From af060b3f72b801962033f75a2fda25fff992796d Mon Sep 17 00:00:00 2001
From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date: Tue, 4 Sep 2018 21:49:44 +0200
Subject: [PATCH] spi: dw: support 4-16 bits per word

The spi-dw driver currently only supports 8 or 16 bits per word.

Since the hardware supports 4-16 bits per word, adapt the driver
to also support this.

Tested on socfpga cyclone5 with a 9-bit SPI display.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 1736612ee86b..3e205ab60cd4 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -308,15 +308,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		dws->current_freq = transfer->speed_hz;
 		spi_set_clk(dws, chip->clk_div);
 	}
-	if (transfer->bits_per_word == 8) {
-		dws->n_bytes = 1;
-		dws->dma_width = 1;
-	} else if (transfer->bits_per_word == 16) {
-		dws->n_bytes = 2;
-		dws->dma_width = 2;
-	} else {
-		return -EINVAL;
-	}
+
+	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+	dws->dma_width = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
@@ -496,7 +491,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	}
 
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
-	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
 	master->bus_num = dws->bus_num;
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
-- 
2.19.0.rc1

