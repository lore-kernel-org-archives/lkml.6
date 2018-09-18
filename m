Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B710CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679752150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="J4B6PPoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679752150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbeIRXUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:20:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34304 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbeIRXUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zKI4Kj4ahwadqOUaI8J707VCqYsUn2Mkh5071Zvum6w=; b=J4B6PPoCyBxf
        a+ZYtaNkByZBC1TDo/apu7ZOjWyAZkzQkN8eOmMdVqRB+es1BTT3qn6PzflXXBxr+Y9A1fx8uKmv2
        7/HRxJ3KxQRyKELtGvZAr2toJKsXt4YjdmXMq8ZON6TIH/+nQAy05GJm76ybeU2oTq/F5M1YeXAOB
        Dywj4=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g2K4N-0003XN-Oh; Tue, 18 Sep 2018 17:45:52 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id DE9B4440078; Tue, 18 Sep 2018 18:45:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: spi-davinci: Don't error when SPI_CS_WORD and cs_gpio" to the spi tree
In-Reply-To:  <20180918170850.2749-3-david@lechnology.com>
Message-Id: <20180918174549.DE9B4440078@finisterre.ee.mobilebroadband>
Date:   Tue, 18 Sep 2018 18:45:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-davinci: Don't error when SPI_CS_WORD and cs_gpio

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

From f34ecdbd5661816ce8bbd7511f33181ffa8f4895 Mon Sep 17 00:00:00 2001
From: David Lechner <david@lechnology.com>
Date: Tue, 18 Sep 2018 12:08:49 -0500
Subject: [PATCH] spi: spi-davinci: Don't error when SPI_CS_WORD and cs_gpio

This remove the check and subsequent return of error for the case when
a SPI device requires SPI_CS_WORD and is also configured to use a GPIO
for the CS line.

Commit a134cc414e86 ("spi: always use software fallback for SPI_CS_WORD
when using cs_gio") handles this case now, so this check is no longer
necessary.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-davinci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 205f763c7383..56adec83f8fc 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -441,9 +441,6 @@ static int davinci_spi_setup(struct spi_device *spi)
 
 		if (internal_cs) {
 			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
-		} else if (spi->mode & SPI_CS_WORD) {
-			dev_err(&spi->dev, "SPI_CS_WORD can't be use with GPIO CS\n");
-			return -EINVAL;
 		}
 	}
 
-- 
2.19.0

