Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5781BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC452177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515819;
	bh=VAShbwJ7YG1dQHqHK7DiKGBZi0w4TU9SxNi4IwgABcQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FrNz3XSsk3CkdBvcu2Hm0hvxGlpVVSkYTu6cN85zj9a+FaQmUVI/DlKWLUwMxXnjR
	 uDkVtpbKWY2aWjSZObDo8Mqofq5tG1anyTglo1r9PtOwi9sPxLNbKoJS1dDVwJYJFF
	 xH4ZRkayRe9LvWNwgll+TAtWuZLLfdJU7T6pHF94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfBRSuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:50:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42684 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfBRSuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lZkbFvGb/pgW7owTXDgQRsSj/A1Ijxw97od1uWeofmU=; b=qKIpTkZlXsOz
        hDzSzD0fexTPHxf5Dyy1E8Q1OQtW9D88SBuWpZJUjQ7rATgRy+hiUWD8Z6H8ETn8vDN8DNN0WkHmO
        ojIO+JyUn8Z1ZGx/ForAm8bk/2TCeyfyT6YUSzblHN9B9TFuTkbHYy+RveNeLMfA8cbf5ahUW/Nys
        yACB4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnzH-0001g8-Br; Mon, 18 Feb 2019 18:49:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DFF7C1128008; Mon, 18 Feb 2019 18:49:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: axp20x: fix DCDCB and BLDO2 definitions for AXP806" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190218184954.DFF7C1128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:49:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: fix DCDCB and BLDO2 definitions for AXP806

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

From 4afa60d3a88aae3d052e0e8e1e62d6fc15a2be82 Mon Sep 17 00:00:00 2001
From: Ondrej Jirman <megous@megous.com>
Date: Mon, 18 Feb 2019 02:01:20 +0100
Subject: [PATCH] regulator: axp20x: fix DCDCB and BLDO2 definitions for AXP806

This fixes another set of errors from the refactoring of literals
to mask preproccesor definitions.

Found by debugging a broken voltage setup on Orange Pi One Plus.

Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
Signed-off-by: Ondrej Jirman <megous@megous.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 1b51d557ab55..62243957bd19 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -791,7 +791,7 @@ static const struct regulator_desc axp806_regulators[] = {
 			AXP806_DCDCA_V_CTRL, AXP806_DCDCA_V_CTRL_MASK,
 			AXP806_PWR_OUT_CTRL1, AXP806_PWR_OUT_DCDCA_MASK),
 	AXP_DESC(AXP806, DCDCB, "dcdcb", "vinb", 1000, 2550, 50,
-		 AXP806_DCDCB_V_CTRL, AXP806_DCDCB_V_CTRL,
+		 AXP806_DCDCB_V_CTRL, AXP806_DCDCB_V_CTRL_MASK,
 		 AXP806_PWR_OUT_CTRL1, AXP806_PWR_OUT_DCDCB_MASK),
 	AXP_DESC_RANGES(AXP806, DCDCC, "dcdcc", "vinc",
 			axp806_dcdca_ranges, AXP806_DCDCA_NUM_VOLTAGES,
@@ -817,7 +817,7 @@ static const struct regulator_desc axp806_regulators[] = {
 		 AXP806_BLDO1_V_CTRL, AXP806_BLDO1_V_CTRL_MASK,
 		 AXP806_PWR_OUT_CTRL2, AXP806_PWR_OUT_BLDO1_MASK),
 	AXP_DESC(AXP806, BLDO2, "bldo2", "bldoin", 700, 1900, 100,
-		 AXP806_BLDO2_V_CTRL, AXP806_BLDO2_V_CTRL,
+		 AXP806_BLDO2_V_CTRL, AXP806_BLDO2_V_CTRL_MASK,
 		 AXP806_PWR_OUT_CTRL2, AXP806_PWR_OUT_BLDO2_MASK),
 	AXP_DESC(AXP806, BLDO3, "bldo3", "bldoin", 700, 1900, 100,
 		 AXP806_BLDO3_V_CTRL, AXP806_BLDO3_V_CTRL_MASK,
-- 
2.20.1

