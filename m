Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EE5C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638222146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549647523;
	bh=xQT9h8WMnR5wewn/xl9MPB+4qCgYGzhzEIW6WF34rKI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=CMnYGzPqPFYfWGfHZjWwkqmYym16/+E8L2T14Q/R/IYP4ny0elTVADi3AZrwZnY5w
	 WGaxoA6zFSKcvkEJ1ihq0fnAOo1nFZ6Ru0mD6zXkRWzP5d9lzNKRvKKqSLtqYyVAwK
	 wG47Tyedbor9dtvrRjqo4FZnVqE43kIZDzYcY8Gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfBHRim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:38:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57416 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbfBHRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rtu0eLpKJwn8VKCAPhaF2xDi46qnu1GuwvFFtYQ2/5c=; b=u46H0VinlJch
        paok9V209F9LJaKhRwg4Ya4GerHSu3I2QAo2wMgxO1UDeqJwMhp+NTMt7yjiOa9dqHIjE6sbp8CCN
        WN/tfR04onHZc1UbBKPsRar7vdzGvk+xQN5LHQFYhsF7+ac315oDrhShg/AlcgT6zUYEs1W17rfv3
        qB4Sg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gsA3R-0002JN-3y; Fri, 08 Feb 2019 17:35:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A7B8D1127F2F; Fri,  8 Feb 2019 17:35:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lm363x: Check return value of gpiod_get_index_optional" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190208173508.A7B8D1127F2F@debutante.sirena.org.uk>
Date:   Fri,  8 Feb 2019 17:35:08 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lm363x: Check return value of gpiod_get_index_optional

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

From c68f47aa0260eb530561b768ffc260d9c7e47a55 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 8 Feb 2019 22:11:52 +0800
Subject: [PATCH] regulator: lm363x: Check return value of
 gpiod_get_index_optional

gpiod_get_index_optional can return ERR_PTR, add IS_ERR checking for it.
While at it, also remove a redundant NULL test for gpiod in error path.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lm363x-regulator.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index 8c0e8419c43f..c876e161052a 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -258,6 +258,9 @@ static int lm363x_regulator_probe(struct platform_device *pdev)
 	 * Register update is required if the pin is used.
 	 */
 	gpiod = lm363x_regulator_of_get_enable_gpio(dev, id);
+	if (IS_ERR(gpiod))
+		return PTR_ERR(gpiod);
+
 	if (gpiod) {
 		cfg.ena_gpiod = gpiod;
 
@@ -265,8 +268,7 @@ static int lm363x_regulator_probe(struct platform_device *pdev)
 					 LM3632_EXT_EN_MASK,
 					 LM3632_EXT_EN_MASK);
 		if (ret) {
-			if (gpiod)
-				gpiod_put(gpiod);
+			gpiod_put(gpiod);
 			dev_err(dev, "External pin err: %d\n", ret);
 			return ret;
 		}
-- 
2.20.1

