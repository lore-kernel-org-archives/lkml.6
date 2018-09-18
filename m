Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F97ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A44214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="quDj35DM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A44214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeIRXUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:20:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34810 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbeIRXUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QETj2pbbYb1+/OERz5MqFx4srnnM7A1YCyErXN1/GH4=; b=quDj35DM6rU7
        FlNHkXDH8xgSnNhcoMSlNp/3598p9Z+KVdYCU1722e8Q4CvA2H7MX+YWHjlfdt35rMagYCoXbmdS4
        ToPNe43UlPNSiLpK376NvdDzlg+yTvXuzYyH7e55lq5bMGAtKd7sOsaxWN9boYr+xsw9x1sdPMBsc
        TPgjo=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g2K4Q-0003XS-Kd; Tue, 18 Sep 2018 17:45:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AAC6D440078; Tue, 18 Sep 2018 18:45:52 +0100 (BST)
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
Subject: Applied "spi: always use software fallback for SPI_CS_WORD when using cs_gio" to the spi tree
In-Reply-To:  <20180918170850.2749-2-david@lechnology.com>
Message-Id: <20180918174552.AAC6D440078@finisterre.ee.mobilebroadband>
Date:   Tue, 18 Sep 2018 18:45:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: always use software fallback for SPI_CS_WORD when using cs_gio

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

From 71388b21569754ecd36eabd66fd9ca8c6d761fed Mon Sep 17 00:00:00 2001
From: David Lechner <david@lechnology.com>
Date: Tue, 18 Sep 2018 12:08:48 -0500
Subject: [PATCH] spi: always use software fallback for SPI_CS_WORD when using
 cs_gio

This modifies the condition for using the software fallback
implementation for SPI_CS_WORD when the SPI controller is using a GPIO
for the CS line. When using a GPIO for CS, the hardware implementation
won't work, so we just enable the software fallback globally in this
case.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index be73d236919f..a358acdd98d3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2832,11 +2832,13 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		return -EINVAL;
 
 	/* If an SPI controller does not support toggling the CS line on each
-	 * transfer (indicated by the SPI_CS_WORD flag), we can emulate it by
+	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
+	 * for the CS line, we can emulate the CS-per-word hardware function by
 	 * splitting transfers into one-word transfers and ensuring that
 	 * cs_change is set for each transfer.
 	 */
-	if ((spi->mode & SPI_CS_WORD) && !(ctlr->mode_bits & SPI_CS_WORD)) {
+	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
+					  gpio_is_valid(spi->cs_gpio))) {
 		size_t maxsize;
 		int ret;
 
-- 
2.19.0

