Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32E4ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8CB20867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XjiDbOhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8CB20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbeIRDEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 23:04:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34318 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbeIRDEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 23:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=z3yKpwZoVctuvB5oL0qqr5vtzVFrGwRf05zvsoZfMak=; b=XjiDbOhytjVP
        EV8xsoRDy/vXe9AwS5l/8H8lKmAGpfHCa1nUEi2F0EcBunnKc17PSc/g9UuOSDUeAX21NufnI1fMg
        5S93yJREMb1MvTxS+L3mEF+xn2q3r/u+gRotfI66mFexf7TCkwshIMNQfwSb95nv5xwagg5kfF+Cq
        pI8gE=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g21AV-0000mh-1r; Mon, 17 Sep 2018 21:34:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id EADDC440078; Mon, 17 Sep 2018 22:34:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Applied "spi: pxa2xx: Remove the shutdown callback" to the spi tree
In-Reply-To:  <20180917121124.21305-1-lkundrak@v3.sk>
Message-Id: <20180917213452.EADDC440078@finisterre.ee.mobilebroadband>
Date:   Mon, 17 Sep 2018 22:34:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: pxa2xx: Remove the shutdown callback

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

From 8089babee17c09cdd51ac1390e444ee0be0c2291 Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Mon, 17 Sep 2018 14:11:24 +0200
Subject: [PATCH] spi: pxa2xx: Remove the shutdown callback

It makes no sense to remove the device on shutdown. And it break things
when the hardware crucial for shutdown (such as the embedded controller)
is attached to the SPI bus.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e3cbc66a7061..fc9aac214239 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1764,14 +1764,6 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void pxa2xx_spi_shutdown(struct platform_device *pdev)
-{
-	int status = 0;
-
-	if ((status = pxa2xx_spi_remove(pdev)) != 0)
-		dev_err(&pdev->dev, "shutdown failed with %d\n", status);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int pxa2xx_spi_suspend(struct device *dev)
 {
@@ -1845,7 +1837,6 @@ static struct platform_driver driver = {
 	},
 	.probe = pxa2xx_spi_probe,
 	.remove = pxa2xx_spi_remove,
-	.shutdown = pxa2xx_spi_shutdown,
 };
 
 static int __init pxa2xx_spi_init(void)
-- 
2.19.0

