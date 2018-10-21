Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1093DECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 11:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B302B204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 11:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SEHmOESE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B302B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeJUTXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 15:23:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54868 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJUTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 15:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uBskeAgrnOYjQQCSkmB+X+5hlM/PjdUehATAx/YNkWc=; b=SEHmOESEPBxK
        kZhEgS2zPqJXtx9c8PG3RZqz6ozXUB7gie2mYygyy1CI9NWoIdlWQYsqRQfvK5Ytw5Cyb9ZQcHjRs
        yUrFcH1rhX0IaKzZdLvM/wU8dQ6yQ3M4cBjhX9w5xgrBM5kY9YsoZSKRJTgxGfwKLWOrXNHKpveQA
        TN4MA=;
Received: from [87.246.76.36] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gEBbg-0003rr-19; Sun, 21 Oct 2018 11:09:16 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A57A6440078; Sun, 21 Oct 2018 13:09:15 +0200 (CEST)
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        jonas.gorski@gmail.com, Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: Allow building SPI_BCM63XX_HSSPI on ARM-based SoCs" to the spi tree
In-Reply-To:  <20181019181233.10227-1-f.fainelli@gmail.com>
Message-Id: <20181021110915.A57A6440078@finisterre.ee.mobilebroadband>
Date:   Sun, 21 Oct 2018 13:09:15 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Allow building SPI_BCM63XX_HSSPI on ARM-based SoCs

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

From 79a15f4974ce9613134648e6e1dd0eb7ca199de6 Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 19 Oct 2018 11:12:32 -0700
Subject: [PATCH] spi: Allow building SPI_BCM63XX_HSSPI on ARM-based SoCs

ARM-based 63xx DSL platforms have the spi-bcm63xx-hsspi controller
present, allow using this driver there as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 71851d00f47d..f756450a8914 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -129,7 +129,7 @@ config SPI_BCM63XX
 
 config SPI_BCM63XX_HSSPI
 	tristate "Broadcom BCM63XX HS SPI controller driver"
-	depends on BCM63XX || COMPILE_TEST
+	depends on BCM63XX || ARCH_BCM_63XX || COMPILE_TEST
 	help
 	  This enables support for the High Speed SPI controller present on
 	  newer Broadcom BCM63XX SoCs.
-- 
2.19.0

