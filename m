Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A207C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1CA20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547467295;
	bh=6RUKRKY8Qv7ZxaTqqqEn/oGwnkGaqOJljfVGm9FCsvc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1nx1mkXuZP/bYv/0S9hDIMIN297gnwxhffeMJaKrkGVxWzu7GU/oM4l4ohXJ6rw+3
	 6vihwkMWp2RGmwjfdQkEzVsf1CcEip4/WsMWd/mFs36jJ013Gf4E16BCvTPpIj+T4J
	 VX3qjM9ztEwWTyJ6fRcmqmPRGMo1Ct0YmMEwkMag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfANMBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:01:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57046 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfANMBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4EyXa4CYxIyv1MzAOgW23H/TMCgYAak2Xpf4oXP7XSg=; b=Wu5C3iohradz
        zVjiTepGpcKsUSaJIieLrWJBmEaUsLn6WVWNHg3hpP4NhUhezBEduPF8JoMUgOUOaAdcdXDTIicwz
        kR+iiGH4xS+i9tGltZN7H5KxJId+BSlGDHhG+8YBvsGFlyW4ItsY9EkhJLI7HQVLZIfjfE6MbHczy
        UMDK0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj0vp-0004tX-3e; Mon, 14 Jan 2019 12:01:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C30C31127AD2; Mon, 14 Jan 2019 12:01:28 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: twl6030: Use of_device_get_match_data()" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190114120128.C30C31127AD2@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 12:01:28 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: twl6030: Use of_device_get_match_data()

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

From 7085180d6a38197c86a9bea84006fa4a4813c7b7 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 9 Jan 2019 17:30:49 +0800
Subject: [PATCH] regulator: twl6030: Use of_device_get_match_data()

Use of_device_get_match_data() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl6030-regulator.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 219cbd910dbf..78b964539775 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -687,14 +687,9 @@ static int twlreg_probe(struct platform_device *pdev)
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

