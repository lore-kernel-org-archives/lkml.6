Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE02C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084772186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549981350;
	bh=Ou78mKCrDsjcl19+I0PByg8OpSbuhxxCoLeEIP/pOh0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=DUv8cnYcH+xTOw9HQBdh/lAjXAAS/XoPhYEm4KyH/l2pUmFLI1IZml/UhLI18Tjvh
	 Rq9QRL/Kv4k2EP8oKeLlNOv0DaDnb7L16Mr24gZ/kHhfGW2RZi4h9TX7ZeqlkPqCK2
	 BZZBkssRwWkAF+kD28bbJGOJCFKj8XeHteU9dJY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfBLOW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:22:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55698 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfBLOWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8M0hJZpc1pcglrnke4YUFYDX+FZCl7ppL+JsOenUbzQ=; b=nigCjV5q59tr
        zu+iRFixLfUAJTA8VmmABmwpa8fSnY3CSGJ8x3GWiVrSioNKGNxc0RvzGG5ddFpfSFKKK1UnGbpyU
        fUNYBxgI4f+qDApOYuuXC/FbWJRmwWrR5uJ3zFcg/gk1cmQz2DApxXTpcEhdIVidLGIobeXhOFZF4
        BaUqg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtYx2-0004cF-8U; Tue, 12 Feb 2019 14:22:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E673F1128113; Tue, 12 Feb 2019 14:22:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: s2mps11: Fix steps for buck7, buck8 and LDO35" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190212142219.E673F1128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 14:22:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s2mps11: Fix steps for buck7, buck8 and LDO35

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

From 56b5d4ea778c1b0989c5cdb5406d4a488144c416 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 9 Feb 2019 18:14:14 +0100
Subject: [PATCH] regulator: s2mps11: Fix steps for buck7, buck8 and LDO35

LDO35 uses 25 mV step, not 50 mV.  Bucks 7 and 8 use 12.5 mV step
instead of 6.25 mV.  Wrong step caused over-voltage (LDO35) or
under-voltage (buck7 and 8) if regulators were used (e.g. on Exynos5420
Arndale Octa board).

Cc: <stable@vger.kernel.org>
Fixes: cb74685ecb39 ("regulator: s2mps11: Add samsung s2mps11 regulator driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s2mps11.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index ee4a23ab0663..134c62db36c5 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -362,7 +362,7 @@ static const struct regulator_desc s2mps11_regulators[] = {
 	regulator_desc_s2mps11_ldo(32, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(33, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(34, STEP_50_MV),
-	regulator_desc_s2mps11_ldo(35, STEP_50_MV),
+	regulator_desc_s2mps11_ldo(35, STEP_25_MV),
 	regulator_desc_s2mps11_ldo(36, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(37, STEP_50_MV),
 	regulator_desc_s2mps11_ldo(38, STEP_50_MV),
@@ -372,8 +372,8 @@ static const struct regulator_desc s2mps11_regulators[] = {
 	regulator_desc_s2mps11_buck1_4(4),
 	regulator_desc_s2mps11_buck5,
 	regulator_desc_s2mps11_buck67810(6, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck67810(7, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck67810(8, MIN_600_MV, STEP_6_25_MV),
+	regulator_desc_s2mps11_buck67810(7, MIN_600_MV, STEP_12_5_MV),
+	regulator_desc_s2mps11_buck67810(8, MIN_600_MV, STEP_12_5_MV),
 	regulator_desc_s2mps11_buck9,
 	regulator_desc_s2mps11_buck67810(10, MIN_750_MV, STEP_12_5_MV),
 };
-- 
2.20.1

