Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E537C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDD92229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550155894;
	bh=qWivlAkTNR8EYJIJlmFkTYtWfQ/kYgLsp5O0shYdvMM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FlBXvyONkAkoNXtRLAf3SGsB2g7yVspQvcji1bnTriU+HjwfCZjAugfIs2AHQUceK
	 rn3AxLhAS1pEhL7+RKlXCJ2cj3t9A8A/s6qS80Qx2b3+5B7LN5xqTIhAXOzkgWdvH0
	 CWOVWou1dZAGPPJL2cmkG6iBXSAV5873TRB2hZSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439421AbfBNOvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:51:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54712 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407285AbfBNOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KqIga2GQ4QHniwCGxmgxufv90AeJQ6oaACirVASJhRg=; b=xjOjbaJIV3C8
        1s/Bj8Ds50kYs7Ysqz/vmAq7BIXqcQxdMg5UEHQpwa9Rk9Ww6EWgZAI/2koXq26rLYeHp/hJ5+1Jv
        0Q/C9vfo4E7tt/WPogpu1EhCTNq3fv7wW7NLFWo4JUYHdqJLNfli3Frh+eiaUfNrnAO2yxDDq/HBv
        xQ+sM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guIMJ-00058H-0r; Thu, 14 Feb 2019 14:51:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B10F41126F78; Thu, 14 Feb 2019 14:51:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd70528: drop struct bd70528" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190214145125.B10F41126F78@debutante.sirena.org.uk>
Date:   Thu, 14 Feb 2019 14:51:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd70528: drop struct bd70528

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

From e3233d7f2bb5a1362570f3013b1d4b95f3105613 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Thu, 14 Feb 2019 15:15:50 +0200
Subject: [PATCH] regulator: bd70528: drop struct bd70528

As a result of exporting the bd70528 specific locking functions
we no longer need struct bd70528. Remove references to
struct bd70528 from bd70528 regulator.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd70528-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 72c7f9aa84f3..30e3ed430a8a 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -246,7 +246,7 @@ static const struct regulator_desc bd70528_desc[] = {
 
 static int bd70528_probe(struct platform_device *pdev)
 {
-	struct bd70528 *bd70528;
+	struct rohm_regmap_dev *bd70528;
 	int i;
 	struct regulator_config config = {
 		.dev = pdev->dev.parent,
@@ -258,7 +258,7 @@ static int bd70528_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	config.regmap = bd70528->chip.regmap;
+	config.regmap = bd70528->regmap;
 
 	for (i = 0; i < ARRAY_SIZE(bd70528_desc); i++) {
 		struct regulator_dev *rdev;
-- 
2.20.1

