Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDABC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7109C21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678972;
	bh=oeQWUdnM8pwcJFCX1TI9SDagQAFUzzBqqzM9+msmTnA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=N9r4ncH4Cv+egacjK47oTl9NEAeZF56JwsmprLT9I2yDxYlSKyx+nR6cWbHcA1NmK
	 6c/1NCgIiEd8kA2RlOIwcjSVysdMC973VqCDtXVM7xVGDG6v16OMoC+fPaRMhOw9jS
	 Wei/314OSqp399KATpD3GdIjHhhLIcrqkINI7M1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfA1MgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:36:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42674 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfA1Mf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aG8xj2fS3GEJihfTnsacFbKdv1PSQp3+A9zNaNl7VFc=; b=eLhZ2tkfLuTA
        TPU8gBM4r7cD53tRduIW7Sv5yp6OZ+99zlFTW72vxGmcqZL7Hb1y5y2UnUSDJgUdpVaAyQbJAcAbj
        N4018PLVuhBHrW6Udd2kCoy3dTIM3l+sPD4cOjG8EgrznoUjjJBNfmw61g6b22kTE4xH0n8Y6WoZW
        rmhkM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go68j-0002TY-JE; Mon, 28 Jan 2019 12:35:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3F5551127D29; Mon, 28 Jan 2019 12:35:49 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp8755: Constify lp8755_regulators" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128123549.3F5551127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:35:49 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp8755: Constify lp8755_regulators

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

From 367e90d13e9a49c3a56de0b397abb87ec550b199 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 26 Jan 2019 11:39:04 +0800
Subject: [PATCH] regulator: lp8755: Constify lp8755_regulators

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp8755.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index 6d229ad4ef3e..14fd38807134 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -315,7 +315,7 @@ static int lp8755_init_data(struct lp8755_chip *pchip)
 	.vsel_mask = LP8755_BUCK_VOUT_M,\
 }
 
-static struct regulator_desc lp8755_regulators[] = {
+static const struct regulator_desc lp8755_regulators[] = {
 	lp8755_buck_desc(0),
 	lp8755_buck_desc(1),
 	lp8755_buck_desc(2),
-- 
2.20.1

