Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AFEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2192520836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550776413;
	bh=id/2bA2ecDDC6+aYOfQh+slVULieoIR7o/D6U2FxvOA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=uoDufAu+o8jPR84CQrtLWcqE+8wU3//a2jZR7sYU52squg6WQgBRauW8ogG1fApQC
	 XrANaQPBvzFWxlcDreemjvyfopVdBg9ffn0fhv0K+6HgmJH/l4yz0s3XBKd1l2e9lh
	 33zCnG0pkmBty8I5kRmGY972z3f/3hwDGhXbEcFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfBUTNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:13:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38260 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfBUTNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=L2rbEij8d4V1PBLX7s0y39QD1JU7rzTsANVDS/oXAac=; b=IiTCxXT0fZ/b
        nEEe8BPE0c52T6wQz9dS8aPj3VxsYNMduGTKZQopRb+0dxwJQ7La70Nou9T290fz76B5XWFuUmyk7
        pJXQxSMJHL8V9IPUi1NWW+QpkqBy3QlKMQ7u5S6BHqi0ovO23j165Z+qHPV3HPD0F0kSLBKjCNT1v
        MZwYw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwtmc-0005xa-Ba; Thu, 21 Feb 2019 19:13:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 78B0011227D7; Thu, 21 Feb 2019 19:13:21 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp873x: Constify lp873x_buck_ramp_delay array" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190221191321.78B0011227D7@debutante.sirena.org.uk>
Date:   Thu, 21 Feb 2019 19:13:21 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp873x: Constify lp873x_buck_ramp_delay array

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

From 921b2b3acc0664e1c78b6d9e383be224de74103d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 21 Feb 2019 23:01:11 +0800
Subject: [PATCH] regulator: lp873x: Constify lp873x_buck_ramp_delay array

The lp873x_buck_ramp_delay should never change, make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp873x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index 2ec5e833c379..70651fec8fd9 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -61,7 +61,7 @@ static const struct regulator_linear_range ldo0_ldo1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0x0, 0x19, 100000),
 };
 
-static unsigned int lp873x_buck_ramp_delay[] = {
+static const unsigned int lp873x_buck_ramp_delay[] = {
 	30000, 15000, 10000, 7500, 3800, 1900, 940, 470
 };
 
-- 
2.20.1

