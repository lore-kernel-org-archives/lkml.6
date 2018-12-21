Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE357C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1D821906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545399781;
	bh=tXQSBDZ+IXnD124BPPDHB/CzykkoVejH2uJJF0nAMo8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vKnBv7r7PH0m1O8ND04k/C4K7CN6TL0fdw6nBIJha0jQ1bOsQXe26SdTzJr+DYikZ
	 4UR/CUM6TTeX6vB6sDRLNoAz6LJhgxW6SNgPpGmP+INYV88XXbThHdvqIw9bEW9BWF
	 SWnQcza0F/LUO4ebjw2dQWp8wL/81bRt8Gu9LlsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403808AbeLUNm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:42:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59200 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403782AbeLUNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EFeLoW9W76Bip7GofDixv+8MHFzoqarzZwkx1IxHH0o=; b=QsEuc0oJhdBH
        gqlMzJqdr5wgxMn5OIIVC/9uGHPM9OoVzRnxjIgmho14Qudr0OQeojb+R7/5QPUEHJFoBPs8mzXh1
        CV3+kBAaV5Aw/X3qDcDv2OmoqvjBJV9JbUFj2fD014vV1RvNC+sS9JGSc7XGIZS7ZhquyiVRUQFNf
        iCl0I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gaL4e-0002V9-Ik; Fri, 21 Dec 2018 13:42:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3F0951121B93; Fri, 21 Dec 2018 13:42:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: tps65910: fix a missing check of return value" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181221134244.3F0951121B93@debutante.sirena.org.uk>
Date:   Fri, 21 Dec 2018 13:42:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps65910: fix a missing check of return value

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

From cd07e3701fa6a4c68f8493ee1d12caa18d46ec6a Mon Sep 17 00:00:00 2001
From: Kangjie Lu <kjlu@umn.edu>
Date: Fri, 21 Dec 2018 00:29:19 -0600
Subject: [PATCH] regulator: tps65910: fix a missing check of return value

tps65910_reg_set_bits() may fail. The fix checks if it fails, and if so,
returns with its error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65910-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 02ccdaa226a7..5ebb6ee73f07 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1102,8 +1102,10 @@ static int tps65910_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pmic);
 
 	/* Give control of all register to control port */
-	tps65910_reg_set_bits(pmic->mfd, TPS65910_DEVCTRL,
+	err = tps65910_reg_set_bits(pmic->mfd, TPS65910_DEVCTRL,
 				DEVCTRL_SR_CTL_I2C_SEL_MASK);
+	if (err < 0)
+		return err;
 
 	switch (tps65910_chip_id(tps65910)) {
 	case TPS65910:
-- 
2.20.1

