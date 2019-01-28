Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F0320880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678953;
	bh=W/cj52ZVXfDHkUrsPHFXn7+HkyKhq9k4WjOGNVG6aJ4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fl2MFmGzmil3zr+Qctl1zg7bz7bKP6PWvpQgk2+fzrnUSfny3H54MlyqJqi9BugPj
	 n49VqmHbh6CgNx4X2fhbt2oRKvcMs26vDIE3aCVvpPLXZDke/SkrOA98g5aRoMES5p
	 hSbI7iIa3TJ5FHHUuuuDXbmkjKKSW0n27O2XqZY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfA1Mfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:35:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42454 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfA1Mfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cHLtdq/rESaaNM1r/3bgT3kylL/aiIp6bcb2bXIXcNE=; b=l1Sq07SNDlZ4
        opJT0TCgti9lenT2T8CoEyld4ITVX1+HQAJ15GaqP5YanazSHIn65G2OYKo91LsfA1Ea+H16iJ+nz
        IvTo82nBleXdzv5ZtdTyk2XDqkrRRnJKrw3q7lnN4UZI5Nn3Cm1BtTptA+Cj4zZz4LYvhd6ajIXjK
        zCbXM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go68h-0002TS-Vi; Mon, 28 Jan 2019 12:35:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A12921127D29; Mon, 28 Jan 2019 12:35:47 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp87565: Constify lp87565_buck_ramp_delay and lp87565_buck_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128123547.A12921127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:35:47 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp87565: Constify lp87565_buck_ramp_delay and lp87565_buck_ops

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

From b7fbc5928addf36a9463df04de7beff9380486a5 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 26 Jan 2019 11:39:05 +0800
Subject: [PATCH] regulator: lp87565: Constify lp87565_buck_ramp_delay and
 lp87565_buck_ops

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp87565-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index c192357d1dea..4ed41731a5b1 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -51,7 +51,7 @@ static const struct regulator_linear_range buck0_1_2_3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1420000, 0x9e, 0xff, 20000),
 };
 
-static unsigned int lp87565_buck_ramp_delay[] = {
+static const unsigned int lp87565_buck_ramp_delay[] = {
 	30000, 15000, 10000, 7500, 3800, 1900, 940, 470
 };
 
@@ -140,7 +140,7 @@ static int lp87565_buck_get_current_limit(struct regulator_dev *rdev)
 }
 
 /* Operations permitted on BUCK0, BUCK1 */
-static struct regulator_ops lp87565_buck_ops = {
+static const struct regulator_ops lp87565_buck_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
-- 
2.20.1

