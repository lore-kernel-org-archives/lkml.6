Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA19C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAB620838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549981342;
	bh=e78pNsxUGlcCFe67APJg4A5epD/BQs3fY49lqDF8k28=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yrdfM5lv0vMkFvr7xpdyxVO2i/q9mvbX4vxrDhaM1Mk8YRj2AjVA6+QJXDlO+EVKR
	 vaJ6vXsZFnlNoPx0zBq8T+lIbSUnUCCnRjytaV3DwDteDnCyR/5gtQVyJ7XddGUvXH
	 wysGiIkz8W7oikB9TO1w2w9Robk9or4zTgCyxh7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfBLOWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:22:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55632 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfBLOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WyfyCfB+Bid+dart33bHJL9N1IR139oQD3+CczmtzQs=; b=KjB9aRR6+f8L
        a5MfsN0UZoBJ3F3oSufxq0mRpfvs0d3V4Dtfo+g3DWe4ercj03iOJU806rKZmk65IlGP2oyHabg6y
        i3wku2GlpNIPun8EXc6++OHfJB6a0pR/WcSmA4UeWT6IhHzOR6LaQsfnVaVnJRQfLlMTaeIXyIY3b
        iDC1s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtYwz-0004c1-1I; Tue, 12 Feb 2019 14:22:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A85FB1128113; Tue, 12 Feb 2019 14:22:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max77802-regulator: fix indentation in if statement" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190212142216.A85FB1128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 14:22:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77802-regulator: fix indentation in if statement

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

From c79fba835ca8a5affe3564a7a2b4f90bbcdfde36 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Tue, 12 Feb 2019 13:46:16 +0000
Subject: [PATCH] regulator: max77802-regulator: fix indentation in if
 statement

There are several lines in an if statement that are not indented
correctly. Fix these by removing the tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77802-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index c30cf5c9f2de..ea7b50397300 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -248,9 +248,9 @@ static int max77802_set_ramp_delay_2bit(struct regulator_dev *rdev,
 	unsigned int ramp_value;
 
 	if (id > MAX77802_BUCK4) {
-			dev_warn(&rdev->dev,
-				 "%s: regulator: ramp delay not supported\n",
-				 rdev->desc->name);
+		dev_warn(&rdev->dev,
+			 "%s: regulator: ramp delay not supported\n",
+			 rdev->desc->name);
 		return -EINVAL;
 	}
 	ramp_value = max77802_find_ramp_value(rdev, ramp_table_77802_2bit,
-- 
2.20.1

