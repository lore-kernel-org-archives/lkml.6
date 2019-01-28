Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B11C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8722F21916
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548699963;
	bh=7vj797Ley0NHnGl14PAXW7OVQGCuqalT1wyDZRNcqlQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Fwdascs+l9w5Bpp9HmEevYOPLZKC14JtgoNa+V8aAgYQvqruA6jrcak8m6WTnFcr3
	 QquoqRcUaKwW7nzvQo5i9s3KBs7lxdUZRQU676WHAnzACPFiwFWO7lqeulCP1OOuMy
	 4cDv/P8huiFIjFgoCBEomPGLu7pTqUvAAwwAIzHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfA1S0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:26:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37294 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfA1SZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sV8LknuzZQHuyZIdsl2a7VWa86fI25NewOtRgMaP8EY=; b=Z+cNhDILFr9Y
        24of+3oWY3DSqx1KXQA12WjuQ/wpBrVQ4Ifi1DU3MliAnY+sis9X7blfJapXV4eT+0m9koFP/PU6k
        rIvZKOkkwLEB7711wMItBt8THHejnvNHsDymdG1kDw9kUo2W8B/cApStPEBqiJNuBuMj9VbSRuMql
        AphaY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goBbU-0003CN-Bw; Mon, 28 Jan 2019 18:25:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F0B301127D29; Mon, 28 Jan 2019 18:25:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: axp20x: Fix incorrect vsel_mask settings" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128182546.F0B301127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 18:25:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: Fix incorrect vsel_mask settings

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

From d02337709390c854186c6a21f997dc39760591e1 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 28 Jan 2019 22:02:19 +0800
Subject: [PATCH] regulator: axp20x: Fix incorrect vsel_mask settings

Fix copy-paste mistake while converting to use defines for masks.

Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 48af859fd053..dd0193d77960 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -573,7 +573,7 @@ static const struct regulator_desc axp22x_regulators[] = {
 		 AXP22X_DCDC3_V_OUT, AXP22X_DCDC3_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL1, AXP22X_PWR_OUT_DCDC3_MASK),
 	AXP_DESC(AXP22X, DCDC4, "dcdc4", "vin4", 600, 1540, 20,
-		 AXP22X_DCDC4_V_OUT, AXP22X_DCDC4_V_OUT,
+		 AXP22X_DCDC4_V_OUT, AXP22X_DCDC4_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL1, AXP22X_PWR_OUT_DCDC4_MASK),
 	AXP_DESC(AXP22X, DCDC5, "dcdc5", "vin5", 1000, 2550, 50,
 		 AXP22X_DCDC5_V_OUT, AXP22X_DCDC5_V_OUT_MASK,
@@ -952,7 +952,7 @@ static const struct regulator_desc axp813_regulators[] = {
 		 AXP22X_ALDO1_V_OUT, AXP22X_ALDO1_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO1_MASK),
 	AXP_DESC(AXP813, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
-		 AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT,
+		 AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO2_MASK),
 	AXP_DESC(AXP813, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
 		 AXP22X_ALDO3_V_OUT, AXP22X_ALDO3_V_OUT_MASK,
@@ -962,7 +962,7 @@ static const struct regulator_desc axp813_regulators[] = {
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO1_MASK),
 	AXP_DESC_RANGES(AXP813, DLDO2, "dldo2", "dldoin",
 			axp803_dldo2_ranges, AXP803_DLDO2_NUM_VOLTAGES,
-			AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT,
+			AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT_MASK,
 			AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO2_MASK),
 	AXP_DESC(AXP813, DLDO3, "dldo3", "dldoin", 700, 3300, 100,
 		 AXP22X_DLDO3_V_OUT, AXP22X_DLDO3_V_OUT_MASK,
@@ -977,7 +977,7 @@ static const struct regulator_desc axp813_regulators[] = {
 		 AXP22X_ELDO2_V_OUT, AXP22X_ELDO2_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO2_MASK),
 	AXP_DESC(AXP813, ELDO3, "eldo3", "eldoin", 700, 1900, 50,
-		 AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT,
+		 AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO3_MASK),
 	/* to do / check ... */
 	AXP_DESC(AXP813, FLDO1, "fldo1", "fldoin", 700, 1450, 50,
-- 
2.20.1

