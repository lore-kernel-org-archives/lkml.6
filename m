Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FC3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA94205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661277;
	bh=PVlVb/ntxdvjpb4dKOJAXLyRTiAzxk0cYbYC8ONUnhU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MexUSLjYQ/Y/Y+oz7tAbhOSHqxOId1ZMdZNsGqMV1YRDfaRs+M7BbIgcc4Bsolx0n
	 c9G+p6gaMTwZ/9bu3DHtgAwQzcp/Iqxfy+I8OAhigyeCjvK4Xuy9RMb2Whd1Q7zG9z
	 LF+tH0rrsfdAmwLPxVyTAnlkLV9q8FkQl+33mces=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfBTLNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:13:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44918 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfBTLNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qNcnRJc51OGkh8k6Nh4PfPQ3dI8PoGZLPjQDJ7G31w4=; b=VWOwk+0kY0uv
        1OIS2qcxK/85y3uHCCB5oE1kxW4ZvWuS9agKz5r0orhHwUSCLz5JUophWBby7KhmydC5T1czSz3Bt
        jCLBea49swXpodo/xKJ+fwTqmHWD9fBO2H2aKj2XuTvjQg8MUKzZNbibZzbO9AyPHt0tTAuK84yMM
        UNs5I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwPom-00011l-Mn; Wed, 20 Feb 2019 11:13:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 67EAC11284C9; Tue, 19 Feb 2019 15:50:30 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: axp20x: remove a redundant null check on rdev" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190219155030.67EAC11284C9@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 15:50:30 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: remove a redundant null check on rdev

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

From ea7b971cd64b45c6be08c02e14d30ec3c9a5b336 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 15 Feb 2019 09:45:54 +0000
Subject: [PATCH] regulator: axp20x: remove a redundant null check on rdev

Currently rdev is dereferenced when assigning desc before rdev is null
checked, this is leading to static analysis warnings.  However, rdev
can never be null, so the null check is redundant and can be removed.

Detected by CoverityScan, CID#1476031 ("Dereference before null check")

Fixes: 77e3e3b165db ("regulator: axp20x: add software based soft_start for AXP209 LDO3")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 98efc28f65ed..fba8f58ab769 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -372,9 +372,6 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 	const int *slew_rates;
 	int rate_count = 0;
 
-	if (!rdev)
-		return -EINVAL;
-
 	desc = rdev->desc;
 
 	switch (axp20x->variant) {
-- 
2.20.1

