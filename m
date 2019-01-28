Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2DAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089D320880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678948;
	bh=S/e5BCrMEKAzUfpEesgQTqNzlpFPR0qzg4d0WxHHI5E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UTdLmQpD9smddlsz794lUSc3INAOSq/vyFrDudHKhxf2lVopck9BeNnRyRl54i5iY
	 SwWtCBxKVcvPMiOG9/vKDRZ6e3LalE341Lg6OnpnAgRZGaSZzT0LfbuSVHxScecBkB
	 Vu13pCcgJNKRvX7ueWaxmWaSZ+HXlUoU4Mu2NDXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfA1Mfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:35:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfA1Mfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rJRghv1i7F3H8YFQOcs92yfbXCg3MkZFSVFAVO/HzVE=; b=aie25hDSsym2
        sgm3Ey/RSMNR82cmLLO1YD6lIXOU/Zklpgi3+AeJo5Jr7QYksHQWvZIEWlzl3bECYsIvu16ED2JBh
        AAgomnNawjnY323KhPs0aFU3IkPeotogWgZOqrb8pNKkOdJ2VaxnG1xcIKojWKuLFkxKz3Iu4ttqe
        cTTcY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go68d-0002TA-4F; Mon, 28 Jan 2019 12:35:43 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CABAC1127D29; Mon, 28 Jan 2019 12:35:42 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: axp20x: fix ALDO2, DLDO2 and ELDO3 definitions for AXP803" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128123542.CABAC1127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:35:42 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: fix ALDO2, DLDO2 and ELDO3 definitions for AXP803

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

From 252d1c20551b745f33a490892335d2b09f5d48a7 Mon Sep 17 00:00:00 2001
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 25 Jan 2019 22:18:09 -0800
Subject: [PATCH] regulator: axp20x: fix ALDO2, DLDO2 and ELDO3 definitions for
 AXP803

Looks like refactoring didn't go well and left ALDO2, DLDO2 and ELDO3
definitions broken for AXP803 - now they are using register address
instead of mask. Fix it by using mask where necessary.

Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 0dfa4ea6bbdf..087cadb96fab 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -723,7 +723,7 @@ static const struct regulator_desc axp803_regulators[] = {
 		 AXP22X_ALDO1_V_OUT, AXP22X_ALDO1_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO1_MASK),
 	AXP_DESC(AXP803, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
-		 AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT,
+		 AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO2_MASK),
 	AXP_DESC(AXP803, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
 		 AXP22X_ALDO3_V_OUT, AXP22X_ALDO3_V_OUT_MASK,
@@ -733,7 +733,7 @@ static const struct regulator_desc axp803_regulators[] = {
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO1_MASK),
 	AXP_DESC_RANGES(AXP803, DLDO2, "dldo2", "dldoin",
 			axp803_dldo2_ranges, AXP803_DLDO2_NUM_VOLTAGES,
-			AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT,
+			AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT_MASK,
 			AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO2_MASK),
 	AXP_DESC(AXP803, DLDO3, "dldo3", "dldoin", 700, 3300, 100,
 		 AXP22X_DLDO3_V_OUT, AXP22X_DLDO3_V_OUT_MASK,
@@ -748,7 +748,7 @@ static const struct regulator_desc axp803_regulators[] = {
 		 AXP22X_ELDO2_V_OUT, AXP22X_ELDO2_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO2_MASK),
 	AXP_DESC(AXP803, ELDO3, "eldo3", "eldoin", 700, 1900, 50,
-		 AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT,
+		 AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO3_MASK),
 	AXP_DESC(AXP803, FLDO1, "fldo1", "fldoin", 700, 1450, 50,
 		 AXP803_FLDO1_V_OUT, AXP803_FLDO1_V_OUT_MASK,
-- 
2.20.1

