Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E9EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20601214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="E0ZnijJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20601214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbeKVAFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:05:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60182 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbeKVAFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5k+IW9bMaZqalvgv/26Xp6B+EaxuK1LmxMzWJzi0gpc=; b=E0ZnijJoeoxA
        a9eLG4mHG721TGUg7f6er7HOZgzQ1uT6v/QxYMg7eaAwWsH3YPv1hUFiiOxXwW+DP45Zs+t09PZSm
        9j+tJjJ903nSU3kXG331WWiLH+ze7Gj4m7eZ6+2JXfvhvHhszxm7mPgefbPenGmTfdECIIe5Cb5lM
        EE6DM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gPSac-0003a9-1f; Wed, 21 Nov 2018 13:30:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B649511250AE; Wed, 21 Nov 2018 13:30:45 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm8994: Don't use devres for enable GPIOs" to the regulator tree
In-Reply-To: 
Message-Id: <20181121133045.B649511250AE@debutante.sirena.org.uk>
Date:   Wed, 21 Nov 2018 13:30:45 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm8994: Don't use devres for enable GPIOs

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 466affa06703d5668b06b25fe34942a784506b62 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 21 Nov 2018 10:13:16 +0000
Subject: [PATCH] regulator: wm8994: Don't use devres for enable GPIOs

The regulator core takes over managing the lifetime of the enable GPIO
once the regulator is registered. As such we shouldn't register the
enable GPIO using devm, or it will be freed twice.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm8994-regulator.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index d7fec533c403..46e6b4ee1491 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -147,11 +147,14 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	config.regmap = wm8994->regmap;
 	config.init_data = &ldo->init_data;
 
-	/* Look up LDO enable GPIO from the parent device node */
-	gpiod = devm_gpiod_get_optional(pdev->dev.parent,
-					id ? "wlf,ldo2ena" : "wlf,ldo1ena",
-					GPIOD_OUT_LOW |
-					GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	/*
+	 * Look up LDO enable GPIO from the parent device node, we don't
+	 * use devm because the regulator core will free the GPIO
+	 */
+	gpiod = gpiod_get_optional(pdev->dev.parent,
+				   id ? "wlf,ldo2ena" : "wlf,ldo1ena",
+				   GPIOD_OUT_LOW |
+				   GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(gpiod))
 		return PTR_ERR(gpiod);
 	config.ena_gpiod = gpiod;
@@ -184,6 +187,7 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	return 0;
 
 err:
+	gpiod_put(gpiod);
 	return ret;
 }
 
-- 
2.19.0.rc2

