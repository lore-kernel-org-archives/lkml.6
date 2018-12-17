Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E39C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914B82146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545064319;
	bh=iVstpJM9s1mRH8P+3AvIMAJ6ix1RosFDCTB9wXJ8YrM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1PIbG5Q31X/hHYgKeJRqttJk0+sdLm0C0mKe0kRQzrSIG9D87FC6aoazvh3e2liYh
	 n5qObr4xlt43Oy62nIUe14+QYD1HdaXvTewz434AFPotkIftGV0iWl6HRrwBSt2gp1
	 AVtN0Hpr6WfAi28d/zLGR+G2ApFO/BBx4KfoInso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbeLQQb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:31:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47238 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbeLQQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=R1RHBq2J/8ZPmuesQTSadhfdxis2AX7khfAtecOtvmg=; b=sgXC5MQC0yBk
        ywiiGAniI92wYm+EebhcZVGZeBCjiHWmNcqQNhYRB0BBy7G5CeyscvlIPVQIeQh+7p8blY+OvEcBZ
        ryFYSQmIqg8H0KgifnuNOol5dd8u4s0u4piTChta21qN6JoJ0mLjfqVhWXlrlM9sbEZhz1QKtu9lo
        zd3IA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gYvoA-0002kz-Ux; Mon, 17 Dec 2018 16:31:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8412F112593C; Mon, 17 Dec 2018 16:31:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: axp20x: fix set_ramp_delay for AXP209/dcdc2" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181217163154.8412F112593C@debutante.sirena.org.uk>
Date:   Mon, 17 Dec 2018 16:31:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: fix set_ramp_delay for AXP209/dcdc2

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

From 918446c96595636be81a224bf663b0f4e669aad7 Mon Sep 17 00:00:00 2001
From: Priit Laes <plaes@plaes.org>
Date: Fri, 14 Dec 2018 22:54:07 +0200
Subject: [PATCH] regulator: axp20x: fix set_ramp_delay for AXP209/dcdc2

Initial commit of set_ramp_delay feature was missing an assignment which
should have populated slew_rate table for dcdc2 regulator. Add it.

Fixes: d29f54df8b16 ("regulator: axp20x: add support for set_ramp_delay for AXP209")

Signed-off-by: Priit Laes <plaes@plaes.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index e8a895b81c90..48af859fd053 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -378,6 +378,7 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 	switch (axp20x->variant) {
 	case AXP209_ID:
 		if (desc->id == AXP20X_DCDC2) {
+			slew_rates = axp209_dcdc2_ldo3_slew_rates;
 			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
 			reg = AXP20X_DCDC2_LDO3_V_RAMP;
 			mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
-- 
2.19.0.rc2

