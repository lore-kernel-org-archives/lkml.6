Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C91C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E08125250
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aHKvkk1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E08125250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965174AbeGBKMX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:12:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45480 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964922AbeGBKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ShRGzw0q2bhy11hufmIasG0fPkCzY1G7/rMuNSX1qu0=; b=aHKvkk1F8VdB
        j8UTh7dkuS+THculQUntnEOx1NsjmH5n1tjZNwE17Sa2SFQ18pzZ76KwUWNIAVRCgMCgu2uiIqNG9
        j5J3nT5+/6siOJ6LeLv3Nlcrb2789aRjkGFNTPSzXhVYGEl885E9R2bPgTAYsX548e02NcWo9sjnc
        +IBEw=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvod-00045T-IF; Mon, 02 Jul 2018 10:12:15 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvoc-0006jz-SZ; Mon, 02 Jul 2018 11:12:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <fabio.estevam@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        shawnguo@kernel.org, anson.huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Revert "regulator: pfuze100: add enable/disable for switch"" to the regulator tree
In-Reply-To:  <1530494307-9234-1-git-send-email-festevam@gmail.com>
Message-Id: <E1fZvoc-0006jz-SZ@debutante>
Date:   Mon, 02 Jul 2018 11:12:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Revert "regulator: pfuze100: add enable/disable for switch"

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

From 464a5686e6c9df364fbfa9a6d0f61276a777d550 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 1 Jul 2018 22:18:27 -0300
Subject: [PATCH] regulator: Revert "regulator: pfuze100: add enable/disable
 for switch"

This reverts commit 5fe156f1cab4f340ddb6283c993912be77594016.

Commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")
causes boot regression on some platforms such as imx6sl-evk and
imx6sll-evk.

After this commit the SW4 regulator will be turned
off and since it supplies the DDR voltage on these boards, a
kernel hang is observed.

Revert it to avoid breaking old dtb's.

Fixes: 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pfuze100-regulator.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 32f9af7f87c4..cde6eda1d283 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -163,9 +163,6 @@ static const struct regulator_ops pfuze100_fixed_regulator_ops = {
 };
 
 static const struct regulator_ops pfuze100_sw_regulator_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -212,11 +209,6 @@ static const struct regulator_ops pfuze100_swb_regulator_ops = {
 			.uV_step = (step),	\
 			.vsel_reg = (base) + PFUZE100_VOL_OFFSET,	\
 			.vsel_mask = 0x3f,	\
-			.enable_reg = (base) + PFUZE100_MODE_OFFSET,	\
-			.enable_val = 0xc,	\
-			.disable_val = 0x0,	\
-			.enable_mask = 0xf,	\
-			.enable_time = 500,	\
 		},	\
 		.stby_reg = (base) + PFUZE100_STANDBY_OFFSET,	\
 		.stby_mask = 0x3f,	\
-- 
2.18.0.rc2

