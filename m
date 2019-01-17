Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A609C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6BD20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547728820;
	bh=TR0G15CjA4sXCj/vZBtwgVWEuHf6HtZn1HQTmPqFLKA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Bck+69fNPhsRuhiDhpxlbzhoCaKpmBPwkEcV9yYOVq4qHpRTtBh/JjV09WZfda0wz
	 r6Ljlo7WIH22p5UcINmPVZ4m6vaJwHk821umXMFLCBd8Qxna04Fu/Mq7WdJ8+YDFml
	 OESGMIRABt2ea3Ns2mKY6QcwV5GKozSuXGW9DpMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfAQMkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:40:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60352 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfAQMkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jG5WUhG6OdPd3gSf1gnyNHcXhYSta8gmBgSkujOYyDo=; b=oZCx9XuYwYS7
        eQe/eCYSO1Z629dZ1AP28o8Ep2aQvMHxjIXGWiGdB4KtIysm5D8L3Z0RISdfgJACMsICKklhOG3ZV
        UpKI66uZymHbZw6YN3ZAx3xomak5XzVinykAn4eUFaCfu82C/QlMyg4KQOTDcnAljwHAPI1F8DoXs
        Tvmms=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gk6xy-0000Z6-NY; Thu, 17 Jan 2019 12:40:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 55E0D1126FE2; Thu, 17 Jan 2019 12:40:14 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: ath79: Remove now useless code" to the spi tree
In-Reply-To:  <20190116185549.23295-4-albeu@free.fr>
X-Patchwork-Hint: ignore
Message-Id: <20190117124014.55E0D1126FE2@debutante.sirena.org.uk>
Date:   Thu, 17 Jan 2019 12:40:14 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: ath79: Remove now useless code

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

From f1b2c1c84f7f04d91749e1550f24510c6b6eac73 Mon Sep 17 00:00:00 2001
From: Alban Bedel <albeu@free.fr>
Date: Wed, 16 Jan 2019 19:55:47 +0100
Subject: [PATCH] spi: ath79: Remove now useless code

The custom setup/cleanup routines included in the ath79 driver only
take care of setting the initial CS state. However that is already
handled by the bitbang code, so this code can be removed.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ath79.c | 43 ++---------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 09c4fb7fcf7a..847f354ebef1 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -109,44 +109,6 @@ static void ath79_spi_disable(struct ath79_spi *sp)
 	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, 0);
 }
 
-static int ath79_spi_setup_cs(struct spi_device *spi)
-{
-	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
-
-	if (!spi->cs_gpiod) {
-		u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
-
-		if (spi->mode & SPI_CS_HIGH)
-			sp->ioc_base &= ~cs_bit;
-		else
-			sp->ioc_base |= cs_bit;
-
-		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
-	}
-
-	return 0;
-}
-
-static int ath79_spi_setup(struct spi_device *spi)
-{
-	int status = 0;
-
-	if (!spi->controller_state) {
-		status = ath79_spi_setup_cs(spi);
-		if (status)
-			return status;
-	}
-
-	status = spi_bitbang_setup(spi);
-
-	return status;
-}
-
-static void ath79_spi_cleanup(struct spi_device *spi)
-{
-	spi_bitbang_cleanup(spi);
-}
-
 static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned int nsecs,
 			       u32 word, u8 bits, unsigned flags)
 {
@@ -199,8 +161,8 @@ static int ath79_spi_probe(struct platform_device *pdev)
 
 	master->use_gpio_descriptors = true;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->setup = ath79_spi_setup;
-	master->cleanup = ath79_spi_cleanup;
+	master->setup = spi_bitbang_setup;
+	master->cleanup = spi_bitbang_cleanup;
 	if (pdata) {
 		master->bus_num = pdata->bus_num;
 		master->num_chipselect = pdata->num_chipselect;
@@ -209,7 +171,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	sp->bitbang.master = master;
 	sp->bitbang.chipselect = ath79_spi_chipselect;
 	sp->bitbang.txrx_word[SPI_MODE_0] = ath79_spi_txrx_mode0;
-	sp->bitbang.setup_transfer = spi_bitbang_setup_transfer;
 	sp->bitbang.flags = SPI_CS_HIGH;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.20.1

