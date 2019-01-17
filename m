Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81581C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDAB20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547728836;
	bh=znEh5kGmOw3SlPM5Hh6hRwxPvlDsRSEV249QlTjM090=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PGpEzzSoorVS7aN7Nmqbw813sFR65S8XSzaQy0BC/8njP+lS2iwIxrItJtv8Ed5UT
	 pUrjKnT0MSImlWO3zG7elOiM7maviNIoIlrG4xAs03LTAVuoorD5vB6W3ew+OKzUQt
	 vGkmDIOWblnosNSPCWX3LSExgXt39EqXbXCWeTKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfAQMkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:40:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60582 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfAQMkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=J+/ZXPmVkxZnbtyeiHXiz/lksnuUTd9WRlSqDhYcck8=; b=BjifNLH6cVo/
        aa+mvww2CQJ8bqfgaH+5UuLzyjNGPmPU0wG0iCWuR39JQ0OByaR1fSOxV+C1mVpeLvijdQbupm3/s
        Gb8zwdIO9C11rqYJPfrtPh25v6+D05pj6BXOE7eZKjYLUQpN8MJVJ6SuvqNwWFabeksa2lgCZpE5Q
        L2szg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gk6y5-0000ZU-Lh; Thu, 17 Jan 2019 12:40:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 41A871126FE2; Thu, 17 Jan 2019 12:40:20 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: bitbang: Don't call chipselect() in spi_bitbang_setup()" to the spi tree
In-Reply-To:  <20190116185549.23295-1-albeu@free.fr>
X-Patchwork-Hint: ignore
Message-Id: <20190117124020.41A871126FE2@debutante.sirena.org.uk>
Date:   Thu, 17 Jan 2019 12:40:20 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: bitbang: Don't call chipselect() in spi_bitbang_setup()

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

From a666f2619a97ab9264d3b06055a336b3ee75c108 Mon Sep 17 00:00:00 2001
From: Alban Bedel <albeu@free.fr>
Date: Wed, 16 Jan 2019 19:55:44 +0100
Subject: [PATCH] spi: bitbang: Don't call chipselect() in spi_bitbang_setup()

spi_setup() already call spi_set_cs() right after calling the
controller setup method, so there is no need for the bitbang driver to
do that. Because of this the chipselect() callback was confusingly
still called when CS is GPIO based.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bitbang.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index f29176000b8d..dd9a8c54a693 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -213,19 +213,6 @@ int spi_bitbang_setup(struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "%s, %u nsec/bit\n", __func__, 2 * cs->nsecs);
 
-	/* NOTE we _need_ to call chipselect() early, ideally with adapter
-	 * setup, unless the hardware defaults cooperate to avoid confusion
-	 * between normal (active low) and inverted chipselects.
-	 */
-
-	/* deselect chip (low or high) */
-	mutex_lock(&bitbang->lock);
-	if (!bitbang->busy) {
-		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
-		ndelay(cs->nsecs);
-	}
-	mutex_unlock(&bitbang->lock);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_setup);
-- 
2.20.1

