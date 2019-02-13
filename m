Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6296C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83614222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061114;
	bh=YoL/ZyZp5Peap9O2ree5+HzkW37sEK6CD5YSCdcS0FA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XLg0sXSpeeBXSjd0jFXyi2glZ6Exg2nELBmByKKRxxKxPWWLYkcyzDdzLqEqnFw/g
	 QJAEvI0DPy2fvYZX2dDD8U0lIG28ArdlM2t9zT3NYnU+aN2x/19QCWMYlKULBW15NB
	 VIlnmYMRwKhXRdoJrKVdZ4j+RnYCf7EheA9kbVEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404102AbfBMMbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:31:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57366 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbfBMMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QVn2zHrczkfUSyo4aDui01HM9WC0lsJEgF1resN0Wro=; b=Tt5KHITvoOhG
        2SbYss8Jv1L9TyJ1SjUe3Q6ylIcZj4GH/zJJD3GGc1Fkfc0QkrfwdN5ZW6Hj2tnSwvdAklaRGoHoJ
        oWOgZh+1q0PlwpvbfDaEJaVbSTt8TiayoasKxQIEh4EukStp71enY5BarzaOlZi8OadVT2BgLaPT/
        UqGu0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtthe-0004JK-7v; Wed, 13 Feb 2019 12:31:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 98F981128159; Wed, 13 Feb 2019 12:31:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Stuart Menefy <stuart.menefy@mathembedded.com>
Cc:     Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: s2mpa01: Fix step values for some LDOs" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190213123144.98F981128159@debutante.sirena.org.uk>
Date:   Wed, 13 Feb 2019 12:31:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s2mpa01: Fix step values for some LDOs

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

From 28c4f730d2a44f2591cb104091da29a38dac49fe Mon Sep 17 00:00:00 2001
From: Stuart Menefy <stuart.menefy@mathembedded.com>
Date: Tue, 12 Feb 2019 21:51:18 +0000
Subject: [PATCH] regulator: s2mpa01: Fix step values for some LDOs

The step values for some of the LDOs appears to be incorrect, resulting
in incorrect voltages (or at least, ones which are different from the
Samsung 3.4 vendor kernel).

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/regulator/s2mpa01.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index 095d25f3d2ea..58a1fe583a6c 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -298,13 +298,13 @@ static const struct regulator_desc regulators[] = {
 	regulator_desc_ldo(2, STEP_50_MV),
 	regulator_desc_ldo(3, STEP_50_MV),
 	regulator_desc_ldo(4, STEP_50_MV),
-	regulator_desc_ldo(5, STEP_50_MV),
+	regulator_desc_ldo(5, STEP_25_MV),
 	regulator_desc_ldo(6, STEP_25_MV),
 	regulator_desc_ldo(7, STEP_50_MV),
 	regulator_desc_ldo(8, STEP_50_MV),
 	regulator_desc_ldo(9, STEP_50_MV),
 	regulator_desc_ldo(10, STEP_50_MV),
-	regulator_desc_ldo(11, STEP_25_MV),
+	regulator_desc_ldo(11, STEP_50_MV),
 	regulator_desc_ldo(12, STEP_50_MV),
 	regulator_desc_ldo(13, STEP_50_MV),
 	regulator_desc_ldo(14, STEP_50_MV),
@@ -315,11 +315,11 @@ static const struct regulator_desc regulators[] = {
 	regulator_desc_ldo(19, STEP_50_MV),
 	regulator_desc_ldo(20, STEP_50_MV),
 	regulator_desc_ldo(21, STEP_50_MV),
-	regulator_desc_ldo(22, STEP_25_MV),
-	regulator_desc_ldo(23, STEP_25_MV),
+	regulator_desc_ldo(22, STEP_50_MV),
+	regulator_desc_ldo(23, STEP_50_MV),
 	regulator_desc_ldo(24, STEP_50_MV),
 	regulator_desc_ldo(25, STEP_50_MV),
-	regulator_desc_ldo(26, STEP_50_MV),
+	regulator_desc_ldo(26, STEP_25_MV),
 	regulator_desc_buck1_4(1),
 	regulator_desc_buck1_4(2),
 	regulator_desc_buck1_4(3),
-- 
2.20.1

