Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C860C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C47E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547122079;
	bh=PsdmB2cSgOZqEOBpNBLYpTeBWB8j0WYHEphl/B+kPRA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=p6KtHZ+vOr/mOCZ/fI9m7X6QkEnh2pHvDo0MIc7k4znMgoaQ6D0b0gLc8taNwXgUy
	 DD7W4SDJ2xGbNSO+BCopdws3zIF++qMRTUvpiblnhVt1vJZXx1O9Hx7xjyJie+EGLT
	 buIBr4/IMbkhDk/Pb62Ry8NYRmkvHCgMbL0K6GMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfAJMH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:07:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54986 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfAJMH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LPr/yZcgdvMnwOBfktoKwz9pPOnpPahnc2dT79MP9MA=; b=iKeFAOOTaKAf
        4DoUtaf0oK7YV6YuDZhaSRzCJsNQFNQyFFS/1oh5Qej//6fiuXVXDBktad0rLuQj11nsg8RoJyai2
        tktdo2WW4zuSRMnC0sslwqbk8gfaGk+Q42x5oPLUYlVok7dlTGMy9TCaNv5dpxFg52s1gqwXZLT1P
        hXLMU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghZ7o-0003Ql-VM; Thu, 10 Jan 2019 12:07:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9633B1127052; Thu, 10 Jan 2019 12:07:52 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Mark Zhang <markz@nvidia.com>
Cc:     Jinyoung Park <jinyoungp@nvidia.com>,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: max77620: Initialize values for DT properties" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190110120752.9633B1127052@debutante.sirena.org.uk>
Date:   Thu, 10 Jan 2019 12:07:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77620: Initialize values for DT properties

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

From 0ab66b3c326ef8f77dae9f528118966365757c0c Mon Sep 17 00:00:00 2001
From: Mark Zhang <markz@nvidia.com>
Date: Thu, 10 Jan 2019 12:11:16 +0800
Subject: [PATCH] regulator: max77620: Initialize values for DT properties

If regulator DT node doesn't exist, its of_parse_cb callback
function isn't called. Then all values for DT properties are
filled with zero. This leads to wrong register update for
FPS and POK settings.

Signed-off-by: Jinyoung Park <jinyoungp@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/regulator/max77620-regulator.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index b94e3a721721..cd93cf53e23c 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -1,7 +1,7 @@
 /*
  * Maxim MAX77620 Regulator driver
  *
- * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
  *
  * Author: Mallikarjun Kasoju <mkasoju@nvidia.com>
  *	Laxman Dewangan <ldewangan@nvidia.com>
@@ -803,6 +803,14 @@ static int max77620_regulator_probe(struct platform_device *pdev)
 		rdesc = &rinfo[id].desc;
 		pmic->rinfo[id] = &max77620_regs_info[id];
 		pmic->enable_power_mode[id] = MAX77620_POWER_MODE_NORMAL;
+		pmic->reg_pdata[id].active_fps_src = -1;
+		pmic->reg_pdata[id].active_fps_pd_slot = -1;
+		pmic->reg_pdata[id].active_fps_pu_slot = -1;
+		pmic->reg_pdata[id].suspend_fps_src = -1;
+		pmic->reg_pdata[id].suspend_fps_pd_slot = -1;
+		pmic->reg_pdata[id].suspend_fps_pu_slot = -1;
+		pmic->reg_pdata[id].power_ok = -1;
+		pmic->reg_pdata[id].ramp_rate_setting = -1;
 
 		ret = max77620_read_slew_rate(pmic, id);
 		if (ret < 0)
-- 
2.20.1

