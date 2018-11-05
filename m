Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E072C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AA920854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="fwQKq/0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AA920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbeKEVVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:21:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45024 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeKEVVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=AKh5mOY/r5VLx0NJBjhFxlW6nwTZMVjL9b2fTvAUTgU=; b=fwQKq/0S0OTS
        wJ7vp6MFkKMyOWoXMGEjq5bU62ETYd6eSE/kFTql20xVDsai8y49XR8c29Af3192Ex5z2pVz03+6j
        7LF80D1IHj2IuOVniGIC+/izRDPDOQmZCVwM++7OzM65vhgzfJRHGeKfXzau8NuLoSCgEHFOmDTEI
        n/G+A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdZl-0008KK-VC; Mon, 05 Nov 2018 12:01:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A4F341124D98; Mon,  5 Nov 2018 12:01:49 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: spi-sh-msiof: simplify getting .driver_data" to the spi tree
In-Reply-To:  <20181021200048.2114-3-wsa+renesas@sang-engineering.com>
Message-Id: <20181105120149.A4F341124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:01:49 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-sh-msiof: simplify getting .driver_data

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

From 07c7df3ecdba3d8b9a4145edd9cac47b27dd7f67 Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sun, 21 Oct 2018 22:00:46 +0200
Subject: [PATCH] spi: spi-sh-msiof: simplify getting .driver_data

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index adf384323934..d495d8604397 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1426,16 +1426,14 @@ MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 #ifdef CONFIG_PM_SLEEP
 static int sh_msiof_spi_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+	struct sh_msiof_spi_priv *p = dev_get_drvdata(dev);
 
 	return spi_master_suspend(p->master);
 }
 
 static int sh_msiof_spi_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
+	struct sh_msiof_spi_priv *p = dev_get_drvdata(dev);
 
 	return spi_master_resume(p->master);
 }
-- 
2.19.0.rc2

