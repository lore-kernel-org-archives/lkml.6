Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77B9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9572E217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182829;
	bh=4HGvttP/hLX2+xX0l1iZqoCnEeM+zbUVia3l86BkI8c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wPxGrez36wpxQfjfhxaH6uL9XDm9DrgfMaTAaYzGEuhSB1SJR8735f1+2I3ekzObQ
	 zIXU0H1boOJaJ785Vnxz7zKkRuntYpu4/MTwTpdylBczVoBvISFIDNC7BtHPDvN+bY
	 X/QofdStS5ux7MFcU61F3NN3ZsncbYPDe/uVqmBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfBZMHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:07:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58582 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfBZMHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XjZL5Q27oznUygp+eAqGrFyBcmLd8fW0IBcdCn5fHiw=; b=hYlFnrN+3o6l
        T+hWs6wDaDRmyFef8av+c+Orq/+F9/Q0B354ZpTClht8P9wWOEO5ohOW+ejo8E/0iFChXE/IfVsus
        Py0mWqt8C8vE6zuY2kqZb7t9sndqLmVBSsTWbLf7ABceEvpoRd787oApoz//jFM/ylTwBV1X8ac8V
        yCQTM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gybVh-0007jR-U2; Tue, 26 Feb 2019 12:06:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 634CE11284E3; Tue, 26 Feb 2019 12:06:57 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max77650: Fix set_current_limit implementation" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190226120657.634CE11284E3@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 12:06:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77650: Fix set_current_limit implementation

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

From d3d1a6a72b2337437f13be75c64af4ecc386661f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 22 Feb 2019 17:09:21 +0800
Subject: [PATCH] regulator: max77650: Fix set_current_limit implementation

Current code always return error, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 411912d5278b..a1af414db751 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -243,7 +243,7 @@ static int max77650_regulator_set_current_limit(struct regulator_dev *rdev,
 {
 	struct max77650_regulator_desc *rdesc;
 	struct regmap *map;
-	int rv, i, limit;
+	int i, limit;
 
 	rdesc = rdev_get_drvdata(rdev);
 	map = rdev_get_regmap(rdev);
@@ -252,11 +252,9 @@ static int max77650_regulator_set_current_limit(struct regulator_dev *rdev,
 		limit = max77650_current_limit_table[i];
 
 		if (limit >= min_uA && limit <= max_uA) {
-			rv = regmap_update_bits(map, rdesc->regA,
+			return regmap_update_bits(map, rdesc->regA,
 					MAX77650_REGULATOR_CURR_LIM_MASK,
 					MAX77650_REGULATOR_CURR_LIM_SHIFT(i));
-			if (rv)
-				return rv;
 		}
 	}
 
-- 
2.20.1

