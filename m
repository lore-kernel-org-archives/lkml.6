Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FD0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D66D217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548188826;
	bh=mmuGj2NjVw0uPzP2r5ZID2STRmvYwZmTUS/n2Sk2H4o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nkxPvtNVgh+j1k/w97pRURnf+d9agl0pgJE/tZQXiu6Si8rXQnveT9dI38bSwcu+x
	 L5J2yA00LcJ1cG+HRb/R8THhU+qr4hX48KNaL5SchMqCGi8m5UbefXl2GOJcZt2F+L
	 1lvO/33kmkSlSVi7l7fQapLjIj8XgpVLPERV1zY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfAVU1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:27:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52920 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfAVU1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=P2w6zw/P3qnOl/Kw19ME3F+bkypknERIc74M+2S8p8o=; b=A+s+GGaHkOhD
        VSZqmwSqWrf+bqNRlSOkmH6ld0f0bjnVSXg1CsOrIixTsjcnUTyqh24Mj14ovIg8x7V7bLO1bEz24
        rnUbZRcs1eOfe5fgUGOmraGhJclyvUE1R9ZuYrAAdppejW/gX1WRP88GWYCjOGjQJbgKUa0FyXRFt
        5GSRc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gm2dO-0007D9-Au; Tue, 22 Jan 2019 20:26:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EB74B1127955; Tue, 22 Jan 2019 20:26:57 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: twl: Use of_device_get_match_data()" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190122202657.EB74B1127955@debutante.sirena.org.uk>
Date:   Tue, 22 Jan 2019 20:26:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: twl: Use of_device_get_match_data()

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

From 93997a05e6bd7347eb8d103c96af7df4625933f1 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jan 2019 20:41:35 +0800
Subject: [PATCH] regulator: twl: Use of_device_get_match_data()

Use of_device_get_match_data() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl-regulator.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 884c7505ed91..402ea43c77d1 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -576,14 +576,9 @@ static int twlreg_probe(struct platform_device *pdev)
 	struct regulator_init_data	*initdata;
 	struct regulation_constraints	*c;
 	struct regulator_dev		*rdev;
-	const struct of_device_id	*match;
 	struct regulator_config		config = { };
 
-	match = of_match_device(twl_of_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
-	template = match->data;
+	template = of_device_get_match_data(&pdev->dev);
 	if (!template)
 		return -ENODEV;
 
-- 
2.20.1

