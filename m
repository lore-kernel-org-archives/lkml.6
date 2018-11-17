Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC793C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934622089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xdm52XkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934622089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbeKQNoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:44:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59298 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbeKQNod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sY/Pt967/ifciVsQRgcIzi9bgMHySvuorhM7+imLMCg=; b=xdm52XkLuPV0
        TWoykwr4lQvAhrF9h4P8KgLxrM9+nDQFQbkm7rlw4/DA3gI0lBFOEhjV1PkYMmytmta7rR3DxnnwL
        NYsqLLYTXt/rgfXVVNqegHfaLPMmLw8bIXcpxMn+I5CWXxDTlde52s11kwftnOd/LOZdsmFhD5UUq
        VQigo=;
Received: from [204.239.253.216] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNrIQ-0008ND-CG; Sat, 17 Nov 2018 03:29:22 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A847B440078; Sat, 17 Nov 2018 03:29:15 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning" to the spi tree
In-Reply-To:  <20181115103209.20619-1-lkundrak@v3.sk>
Message-Id: <20181117032915.A847B440078@finisterre.ee.mobilebroadband>
Date:   Sat, 17 Nov 2018 03:29:15 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning

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

From f0915dfc44365b487a720d447ad3faa66de5205c Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Thu, 15 Nov 2018 11:32:09 +0100
Subject: [PATCH] spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning

A careless oversight. Sorry.

Fixes: 0a897143b7c9 ("spi: pxa2xx: Add slave mode support")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e6a606354f62..d84b893a64d7 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1555,19 +1555,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	}
 #endif
 
-#if CONFIG_OF
-	if (of_id) {
-		pdata->is_slave = of_property_read_bool(pdev->dev.of_node,
-								"spi-slave");
-	}
-#endif
-
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	ssp->irq = platform_get_irq(pdev, 0);
 	ssp->type = type;
 	ssp->pdev = pdev;
 	ssp->port_id = pxa2xx_spi_get_port_id(adev);
 
+	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
 
-- 
2.19.1

