Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1A1C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE05221917
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678958;
	bh=sjLmMOigqLlzjyNeT+5oc417HhS/rk4nUqN818muqgk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=OKqpyBLm974KYLvdiczR5PdnB6B3VJxLfBhquyRK/ku2bhVWUkTS60USw301gGjCK
	 qWTGdWtWWI42+kpi4wUvKZPyDkfFAXWewIr/ijGE+RNF+1pU9ejOAPedDc/RaMV8WQ
	 zDlgbzXSjZAvRDlJimS2lTyEJQ2wWhGJ6iW/JN7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfA1Mf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:35:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42546 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfA1Mfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TNw7bCwDQmgh0ZBvyI3/W6dM2aDuWIe6tSoESgtMSYA=; b=uphOgfQh4M8Y
        6ntq272rCGN72SA/fjpFnQTln1foIbquz7sxVa2TJKk+mILLPaqu6DmzFaJJNlU3/4YVgm4C/A8zc
        DRH6eE8gKnc7jhxyTwS+S2HgFPP3fjtNu8L+xJwx6nujMA6QvU2G1Xe+dIRX0oibxMrtvpMd+cavS
        r4Tbo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go68l-0002Tb-7U; Mon, 28 Jan 2019 12:35:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DB33F1127D29; Mon, 28 Jan 2019 12:35:50 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp873x: Constify lp873x_buck01_ops and lp873x_ldo01_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128123550.DB33F1127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:35:50 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp873x: Constify lp873x_buck01_ops and lp873x_ldo01_ops

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

From 699bdc23bd663bdf31306c67336070c5cf1a67f1 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 26 Jan 2019 11:39:03 +0800
Subject: [PATCH] regulator: lp873x: Constify lp873x_buck01_ops and
 lp873x_ldo01_ops

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp873x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index 70e3df653381..2ec5e833c379 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -146,7 +146,7 @@ static int lp873x_buck_get_current_limit(struct regulator_dev *rdev)
 }
 
 /* Operations permitted on BUCK0, BUCK1 */
-static struct regulator_ops lp873x_buck01_ops = {
+static const struct regulator_ops lp873x_buck01_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -161,7 +161,7 @@ static struct regulator_ops lp873x_buck01_ops = {
 };
 
 /* Operations permitted on LDO0 and LDO1 */
-static struct regulator_ops lp873x_ldo01_ops = {
+static const struct regulator_ops lp873x_ldo01_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
-- 
2.20.1

