Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AEEC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AF122436
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PrFvoEFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AF122436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbeHJTBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:01:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46188 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeHJTBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IuaH2s2bSfOm7d0jiXgypWdOCcHojmL/sl0gSKQfiIM=; b=PrFvoEFGTOj4
        xz6KwXVndGHkiyPmtZALc/my0YgyW3OKRex/1yImeZmi00k7g13nqlbkUb/ymjmhIWgcL50pl5FU+
        NPIiLEFzyy+XHlLFtB3jR+MfUBTagMQEBvbokuI1298ZYInkYF3a6Mp1MEU5E5hxSUI1/YdtWAhVG
        GBfcQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1foAJo-0004sI-KW; Fri, 10 Aug 2018 16:31:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5CA7D112435F; Fri, 10 Aug 2018 17:31:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: davinci: fix a NULL pointer dereference" to the spi tree
In-Reply-To:  <20180810091352.30227-1-brgl@bgdev.pl>
Message-Id: <20180810163116.5CA7D112435F@debutante.sirena.org.uk>
Date:   Fri, 10 Aug 2018 17:31:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: davinci: fix a NULL pointer dereference

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

From 563a53f3906a6b43692498e5b3ae891fac93a4af Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 10 Aug 2018 11:13:52 +0200
Subject: [PATCH] spi: davinci: fix a NULL pointer dereference

On non-OF systems spi->controlled_data may be NULL. This causes a NULL
pointer derefence on dm365-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 60d59b003aa4..4ffc0f495be8 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -217,7 +217,7 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	pdata = &dspi->pdata;
 
 	/* program delay transfers if tx_delay is non zero */
-	if (spicfg->wdelay)
+	if (spicfg && spicfg->wdelay)
 		spidat1 |= SPIDAT1_WDEL;
 
 	/*
-- 
2.18.0

