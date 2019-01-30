Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC53EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC76A2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548864144;
	bh=4PFaIyMAK3gauqbaThsYzZ119KdQbjDRBjshEoRv1xY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=doASjaalk/wt5CdjvaTX6gz8NNTvKuehn8n/zIMSpMbaEm5sD+/vQr6ScqmmkPrBl
	 13zFl4pT4si4L7APk8KBlnZBj9K4w7KmG91anYPTcerohaXe7kQqAl363WnWl5dKxe
	 XDPpNasisRNoFwW9uPUspbq+NF9Tm49cNBFQBGiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbfA3QCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:02:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56416 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfA3QCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nfjNXCuGzkYYU9tvUdmBziog1UfZweBcbugc/FO+Prk=; b=e9Ucqi42UzGk
        aS7N/WtPWrLYjzQD5W4yH9oBk5pgqEkPSao4MDxTBCm6WW8zwg5y0iDZhkB5Otmc4q36Y3Isg1+TA
        WwrIlOatL8anfPunp5HQT85piOqt84FE3aEfSd6CcaTjGK+JU+xu5YM1pTYztmaranba7AuhxfCr9
        sYRQU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gosJg-0006To-D9; Wed, 30 Jan 2019 16:02:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D14561127D43; Wed, 30 Jan 2019 16:02:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max77650: Fix include files" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190130160219.D14561127D43@debutante.sirena.org.uk>
Date:   Wed, 30 Jan 2019 16:02:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77650: Fix include files

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

From 5358db547813eefe539676c28eab9462269d065a Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 30 Jan 2019 17:07:21 +0800
Subject: [PATCH] regulator: max77650: Fix include files

This is a platform driver, no need to include linux/i2c.h.
Include linux/of.h for of_match_ptr.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 474f2c02f2d5..5afb91400832 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -5,7 +5,7 @@
 //
 // Regulator driver for MAXIM 77650/77651 charger/power-supply.
 
-#include <linux/i2c.h>
+#include <linux/of.h>
 #include <linux/mfd/max77650.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
2.20.1

