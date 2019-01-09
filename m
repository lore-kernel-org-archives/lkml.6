Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DEBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9A120859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547057729;
	bh=u2g/O9tJVdHWRcAH1Za19cSDoreYa7imCsqmHxePYbI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=S/QaCsmmW32o9GC8abpnonyeAhVY365nLQ5o66TjcATea0Bd9JapTg74ME1daCmRR
	 FkXdAcqCrB8c9dP7tYcWaK3ImrcB3lbwQLRSyTBOV6zj/2Ev4ms57mo8hUh6RJfP0A
	 nq3VDlKAc077GDpe1UJsbOTcMHb/aVoG3UaxrY/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfAISP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:15:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32908 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfAISP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GFH2Ml5KtJ+RwA08xm7COevFeRKtLqPHQlXd1gbYDA0=; b=usIZoExyX3jF
        vmW+r7RjkoZUy3amRwkteXO9m8edq8W1hrTq6qwICjqPJFC7AJ80YsSrsmzZDLgbYVYzS/v+e8R+i
        cZRQJYacwpe2xPtSnVJfJjEACQnFHKuGRSRXWkBNsjK4dzvATbBKnuOJZaratab7B+sDInf9d5U9u
        1LpQI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghINy-0000Zv-EF; Wed, 09 Jan 2019 18:15:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 05E871127528; Wed,  9 Jan 2019 18:15:26 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: axp20x: check rdev is null before dereferencing it" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190109181526.05E871127528@debutante.sirena.org.uk>
Date:   Wed,  9 Jan 2019 18:15:26 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: check rdev is null before dereferencing it

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

From 6f3656f3552a3b32c625c93ddafcbe10bf0fea6d Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sat, 22 Dec 2018 11:31:59 +0000
Subject: [PATCH] regulator: axp20x: check rdev is null before dereferencing it

Currently rdev is dereferenced when assigning desc before rdev is null
checked, hence there is a potential null pointer dereference on rdev.
Fix this by null checking rdev first.

Detected by CoverityScan, CID#1476031 ("Dereference before null check")

Fixes: 77e3e3b165db ("regulator: axp20x: add software based soft_start for AXP209 LDO3")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 48af859fd053..0dfa4ea6bbdf 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -367,7 +367,7 @@ static const int axp209_dcdc2_ldo3_slew_rates[] = {
 static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 {
 	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
-	const struct regulator_desc *desc = rdev->desc;
+	const struct regulator_desc *desc;
 	u8 reg, mask, enable, cfg = 0xff;
 	const int *slew_rates;
 	int rate_count = 0;
@@ -375,6 +375,8 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 	if (!rdev)
 		return -EINVAL;
 
+	desc = rdev->desc;
+
 	switch (axp20x->variant) {
 	case AXP209_ID:
 		if (desc->id == AXP20X_DCDC2) {
@@ -436,11 +438,13 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 static int axp20x_regulator_enable_regmap(struct regulator_dev *rdev)
 {
 	struct axp20x_dev *axp20x = rdev_get_drvdata(rdev);
-	const struct regulator_desc *desc = rdev->desc;
+	const struct regulator_desc *desc;
 
 	if (!rdev)
 		return -EINVAL;
 
+	desc = rdev->desc;
+
 	switch (axp20x->variant) {
 	case AXP209_ID:
 		if ((desc->id == AXP20X_LDO3) &&
-- 
2.20.1

