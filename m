Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DA6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F76A2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="u265tpON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F76A2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeI1FBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:01:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56678 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeI1FBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DMshufTt+GDXPLXZe3x9xm15d6dsicK1KZtnBKNNS18=; b=u265tpONbBuL
        PlyBoVnaI0tTSkkq4nT14AoDWBv7ZTzKZbgcRyDgWbF8Eg3cd1Vg8wNiLX5u2vtSldpzX8pZ+/QAv
        Udjrp4wyvthUCdb3K2TDOoOnEQ/7xfM4qwiT8F4Hqllvz5v9+Oe03IVCfryEETn9W7k3tk8BY1tyN
        73rNI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5exU-0007UV-Ju; Thu, 27 Sep 2018 22:40:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 61209440078; Thu, 27 Sep 2018 23:40:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: sprd: don't mark remove function as __exit" to the spi tree
In-Reply-To:  <20180926125833.2225931-1-arnd@arndb.de>
Message-Id: <20180927224031.61209440078@finisterre.ee.mobilebroadband>
Date:   Thu, 27 Sep 2018 23:40:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: sprd: don't mark remove function as __exit

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

From 71d9a846fbcac1113b3810c06a8a3ddd936ada01 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Sep 2018 14:58:21 +0200
Subject: [PATCH] spi: sprd: don't mark remove function as __exit

The __exit section is left out for built-in drivers, so a
'remove' callback must not be marked as such to avoid breaking when
we unbind a device at runtime. This was pointed out by kbuild:

`sprd_spi_remove' referenced in section `.data' of drivers/spi/spi-sprd.o: defined in discarded section `.exit.text' of drivers/spi/spi-sprd.o

Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index a9a6c5ed443f..8daa24eec624 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -676,7 +676,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit sprd_spi_remove(struct platform_device *pdev)
+static int sprd_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *sctlr = platform_get_drvdata(pdev);
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
-- 
2.19.0

