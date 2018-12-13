Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF713C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715DA20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544702961;
	bh=qeFRZ+D/lrxu72LUXEoZNtsPk3cUVu+AMyhSHOIh67U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EtEg8WvfsAHyVxh52VmNsXtA4kD6Fb4Ta3ChlG6Uq58XUzGdsjVoBFmXn3tXm3qD2
	 UGuVB0hDx+sWyrrER5VNDFE5pYJS0YIJuQJ/2FH+X4pjVpehvznFuoOrWM6JackGLu
	 v+lYpSUB1hP3HUZqvNxIn45HnSpYbMgm1eoum+Dc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715DA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeLMMJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:09:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50322 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbeLMMJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4Pdibq4JLvelDe0mNfau29MoONqe9UnU7hAMaJuLphs=; b=U+WkMJD9X5/T
        i00ePz379vMdNlm0MNvnVyUJmpp9X+2v6nqkKFB8Sy0i8ll0xKb+UGjxPSG9B+ogBxEyaen5TxEST
        lHg7NdBpHLvjhP83szWFzeRMWL29QxWSXwUJXD9I85nF5dLEvYDGKyCwXAEM2i8+3P7VwEwNpfJIT
        Oy7/8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXPng-0000zP-5w; Thu, 13 Dec 2018 12:09:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D6B4711254D1; Thu, 13 Dec 2018 12:09:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: arizona-ldo1: Rely on core to handle GPIO descriptor" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213120907.D6B4711254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 12:09:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: arizona-ldo1: Rely on core to handle GPIO descriptor

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

From f306d76082358fa9a3fb3e66674a5852bb48845f Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Dec 2018 10:53:19 +0100
Subject: [PATCH] regulator: arizona-ldo1: Rely on core to handle GPIO
 descriptor

After making sure that the regulator core always take over
handling of the GPIO descriptors, the gpiod_put()
on the errorpath of the Arizona LDO1 driver becomes
redundant.

Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-ldo1.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 9a72eae4926d..b9a93049e41e 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -283,9 +283,6 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
 	of_node_put(config.of_node);
 
 	if (IS_ERR(ldo1->regulator)) {
-		if (config.ena_gpiod)
-			gpiod_put(config.ena_gpiod);
-
 		ret = PTR_ERR(ldo1->regulator);
 		dev_err(&pdev->dev, "Failed to register LDO1 supply: %d\n",
 			ret);
-- 
2.19.0.rc2

