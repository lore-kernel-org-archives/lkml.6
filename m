Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F979C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250F120666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="df+Y0eWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250F120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeJBVnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:43:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42186 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbeJBVm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EPeaTZ9SuhOHdVCwnYxCSzbwRaMSruvgRlCKMN5b+fo=; b=df+Y0eWu2fre
        OkIx3Teout5Y4Hu/PSgdvacluevURzsgVWs0t+yy7Zem7FlMLiVjGsT5K0pRmCaBR2x2P8HwCD9ST
        Ok+yhwmYbBRFod0FTZnTX6LDesOBkMZB5dm3HFM+2G61CNZ/KnbXxu7FCXb+l877llFGCxJg4DPU+
        wIzuQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g7M8c-00022m-11; Tue, 02 Oct 2018 14:59:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 899D41121A41; Tue,  2 Oct 2018 15:59:01 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd718xx: fix build warning on x86_64" to the regulator tree
In-Reply-To: 
Message-Id: <20181002145901.899D41121A41@debutante.sirena.org.uk>
Date:   Tue,  2 Oct 2018 15:59:01 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd718xx: fix build warning on x86_64

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

From eb108c3611dd21d5d058cee25fec1c29baf5b0c9 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Tue, 2 Oct 2018 10:16:50 +0300
Subject: [PATCH] regulator: bd718xx: fix build warning on x86_64

Casting address to unsigned int causes a warning on some 64 bit
architectures. Fix the cast.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/rohm-bd718x7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index 161c8aac6d86..a29d529a96f4 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -98,7 +98,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	bd718xx->chip_irq = i2c->irq;
-	bd718xx->chip_type = (unsigned int)
+	bd718xx->chip_type = (unsigned int)(uintptr_t)
 				of_device_get_match_data(&i2c->dev);
 	bd718xx->dev = &i2c->dev;
 	dev_set_drvdata(&i2c->dev, bd718xx);
-- 
2.19.0.rc2

