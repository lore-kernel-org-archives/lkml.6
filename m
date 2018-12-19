Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0CAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA1620672
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545244359;
	bh=c5CD4r95hIigRDKySWKlleuWASZOrmOBYV+Bsu5SRek=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gzP1xpy3C8zZ0EMhGEylV5czrH49/iXrkb2ItRzwip9xqRgTNYhMMIuY+uOYMXS1o
	 FjzKDNr4nqBCcdGNNtYI56fwiy5nQlxM10UE8RXbd11a+C9HHUwlDoORu2+pUmPTj+
	 HiZmSnkeT31uSMyxwU5YTZmGM87Wzpud9mzHiyRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeLSSci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:32:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59024 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeLSSci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5pA5ywXZkUwqkx8d9HW9r1a8f9AutmcPcP/RSkB50cw=; b=Vv026LeM7DCN
        U1ur2P1M68Ksi0Tia8eUDc53xg4Q4c+cNsWW37Tn/wkdC0PbI2EwI/7rghbipg4/TdC7T6QHx7yj6
        M1Dka/C+cVSCPmIvGJ1wKGpO+nMyrK6NE8q08+h9D/AyVmh1Ump560r2F9/h0LwAmQQLz6GDDVE5q
        2XbYs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZge1-0005L1-9H; Wed, 19 Dec 2018 18:32:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E9E1511259E9; Wed, 19 Dec 2018 18:32:32 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: act8945a-regulator: make symbol act8945a_pm static" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181219183232.E9E1511259E9@debutante.sirena.org.uk>
Date:   Wed, 19 Dec 2018 18:32:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8945a-regulator: make symbol act8945a_pm static

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

From 78e6fbf321a9b4cb46b17d83f25abcd318859c70 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Tue, 18 Dec 2018 07:10:21 +0000
Subject: [PATCH] regulator: act8945a-regulator: make symbol act8945a_pm static

Fixes the following sparse warning:

drivers/regulator/act8945a-regulator.c:340:1: warning:
 symbol 'act8945a_pm' was not declared. Should it be static?

Fixes: 7482d6ecc68e ("regulator: act8945a-regulator: Implement PM functionalities")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8945a-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 157272536122..603db77723b6 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -337,7 +337,7 @@ static int __maybe_unused act8945a_suspend(struct device *pdev)
 	return regmap_write(act8945a->regmap, ACT8945A_SYS_CTRL, 0x42);
 }
 
-SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
+static SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
 
 static void act8945a_pmic_shutdown(struct platform_device *pdev)
 {
-- 
2.19.0.rc2

