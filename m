Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408C8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9A120880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548679009;
	bh=dS9+bKUMb+eQDAFSsnXF/Dk8qECDLEavQL0u17qoTu0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1kICLcTgiTVh3R/J215kFywp2p5pGUu9zKupsEOzqlYHZbzcQaO0OSOPHuAWleZ9D
	 rBiR9duw+WzvZNMINGZyGfptNpHXYdXrk6TETT37dDap2iPpeGvQjleu6AfB2oHtWS
	 sJgCXfURTSFm8phXMhtn6Sh76Xd1Wm1XHv8x7B1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfA1Mgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:36:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42262 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfA1Mfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+7xR/0CtsCxmT0722ChyrQLC5oU2Ekzm5DjSGgAgIcY=; b=es+Yb08p5FdS
        pMOmMLG+cANvRaCfqk9INBqMTSl3YyIXEUgvWoZbHWGQs8ytrWErEO5warl9IqecJFSFI5qhgOkAr
        dkQyxWss/g24VmdINBx2Q6nZnRk6qVcxP470/Gup55ksejhr9ljHoGG5NFS8oGNqBlALK+BlFerDm
        LX/WI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go68b-0002T4-J5; Mon, 28 Jan 2019 12:35:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 334DC1127D29; Mon, 28 Jan 2019 12:35:41 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9062: Check return value of devm_regmap_field_alloc calls" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128123541.334DC1127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:35:41 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9062: Check return value of devm_regmap_field_alloc calls

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

From 54129d641cac77b80f3c868a45cd776d783ca57b Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 26 Jan 2019 23:22:33 +0800
Subject: [PATCH] regulator: da9062: Check return value of
 devm_regmap_field_alloc calls

Since devm_regmap_field_alloc can fail, add error checking for it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9062-regulator.c | 29 +++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 34a70d9dc450..d06e9600fa18 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1029,31 +1029,50 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 		regl->desc.type = REGULATOR_VOLTAGE;
 		regl->desc.owner = THIS_MODULE;
 
-		if (regl->info->mode.reg)
+		if (regl->info->mode.reg) {
 			regl->mode = devm_regmap_field_alloc(
 					&pdev->dev,
 					chip->regmap,
 					regl->info->mode);
-		if (regl->info->suspend.reg)
+			if (IS_ERR(regl->mode))
+				return PTR_ERR(regl->mode);
+		}
+
+		if (regl->info->suspend.reg) {
 			regl->suspend = devm_regmap_field_alloc(
 					&pdev->dev,
 					chip->regmap,
 					regl->info->suspend);
-		if (regl->info->sleep.reg)
+			if (IS_ERR(regl->suspend))
+				return PTR_ERR(regl->suspend);
+		}
+
+		if (regl->info->sleep.reg) {
 			regl->sleep = devm_regmap_field_alloc(
 					&pdev->dev,
 					chip->regmap,
 					regl->info->sleep);
-		if (regl->info->suspend_sleep.reg)
+			if (IS_ERR(regl->sleep))
+				return PTR_ERR(regl->sleep);
+		}
+
+		if (regl->info->suspend_sleep.reg) {
 			regl->suspend_sleep = devm_regmap_field_alloc(
 					&pdev->dev,
 					chip->regmap,
 					regl->info->suspend_sleep);
-		if (regl->info->ilimit.reg)
+			if (IS_ERR(regl->suspend_sleep))
+				return PTR_ERR(regl->suspend_sleep);
+		}
+
+		if (regl->info->ilimit.reg) {
 			regl->ilimit = devm_regmap_field_alloc(
 					&pdev->dev,
 					chip->regmap,
 					regl->info->ilimit);
+			if (IS_ERR(regl->ilimit))
+				return PTR_ERR(regl->ilimit);
+		}
 
 		/* Register regulator */
 		memset(&config, 0, sizeof(config));
-- 
2.20.1

