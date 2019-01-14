Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3118DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E5120656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547467316;
	bh=LyeJLRU/Um2wkDQlc8f1rq3JMq1s8Sq3SDYGVcOIbJk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MyMhFShrImRqaqdWoVT8lQDWIxYwtNSF5AlI9LsaVJoO7up6jHVSdch+7Odl3jU2T
	 F/2POk5R3OgFvhyBxt4IkXelcCJ/mLqrsz8ROEIf7e3riQYUnLUTOOaxz8QCf95rHJ
	 q2b3vfsjr6COvp1if9gx5R+rkxlt0wbHbskSe+5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbfANMBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:01:54 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57136 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfANMBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8Tw2lyi24LumGyW7Go7MM9QbxeE6pjt/gHKAANj6wlI=; b=jw4Hoz/vVJxO
        n8sNWTJls+uncntceH2ej31RBUo5NYaxmARZQBLMcsxvKbG6t5L2kdiB+0WKHQNgH4FnfK+keKV6B
        70uKpDmxWOgDIuXAIIHbtuH/9BcY9hZzlhinVsG+DzZA+0x1+8iZYs3duNbFzONneBzSLwnYdMc75
        ftKhg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj0vq-0004tX-JH; Mon, 14 Jan 2019 12:01:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6A7A11127AD2; Mon, 14 Jan 2019 12:01:30 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max14577: Remove redundant MODULE_ALIAS" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190114120130.6A7A11127AD2@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 12:01:30 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max14577: Remove redundant MODULE_ALIAS

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

From 67cc7ca316c4167cc5aca54b7f63a55de356d976 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 11 Jan 2019 10:58:22 +0800
Subject: [PATCH] regulator: max14577: Remove redundant MODULE_ALIAS

The modalias is set by the MODULE_DEVICE_TABLE, thus remove redundant
MODULE_ALIAS.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max14577-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index bc7f4751bf9c..85a88a9e4d42 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -324,4 +324,3 @@ module_exit(max14577_regulator_exit);
 MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
 MODULE_DESCRIPTION("Maxim 14577/77836 regulator driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:max14577-regulator");
-- 
2.20.1

