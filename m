Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B6FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2E420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="o1EXDWkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2E420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbeGRPz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:55:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49956 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeGRPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=A29VCH7mTU0VzadmcO9JJBMiJQYZtnkkGOHWwcWiJ6M=; b=o1EXDWkIFHev
        eNE2e4F9vM4JI/gB3KElR0gW8jfoCbsip8jIOI+bpMIyx2xyYquq2TzDfJSB6AJVHmQu6ahKJbdCr
        CXK7fPjb3RabWp/nfSg0jho8AjHMYs9bddIqM0lS8/nxN25/DpX/9YShJzknLSTk9MVGyKgW+s9uS
        KoRik=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffoCT-0003fs-Eq; Wed, 18 Jul 2018 15:17:09 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffoCT-0004O3-0g; Wed, 18 Jul 2018 16:17:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-bitbang: change flags from u8 to u16" to the spi tree
In-Reply-To:  <20180717032052.12273-2-david@lechnology.com>
Message-Id: <E1ffoCT-0004O3-0g@debutante>
Date:   Wed, 18 Jul 2018 16:17:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-bitbang: change flags from u8 to u16

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

From 7c201ead1bfd19935f689fca69100c335028c047 Mon Sep 17 00:00:00 2001
From: David Lechner <david@lechnology.com>
Date: Mon, 16 Jul 2018 22:20:49 -0500
Subject: [PATCH] spi: spi-bitbang: change flags from u8 to u16

This changes the data type of the flags field in struct spi_bitbang from
u8 to u16. This matches the size of the mode field of struct spi_device
where these flags are also used.

This is done in preparation of adding a new SPI mode flag that will be
used with this field that would otherwise not fit in 8 bits.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi_bitbang.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index 51d8c060e513..c1e61641a7f1 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -8,7 +8,7 @@ struct spi_bitbang {
 	struct mutex		lock;
 	u8			busy;
 	u8			use_dma;
-	u8			flags;		/* extra spi->mode support */
+	u16			flags;		/* extra spi->mode support */
 
 	struct spi_master	*master;
 
-- 
2.18.0

