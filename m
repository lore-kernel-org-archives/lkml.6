Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA60C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807002084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544491021;
	bh=K0CLqxnZK59VG855cqGVuKKq4aFNBwFSbWxd10wALXg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xTl1tpEKliQ5GfxhWO1g3Ba2F3yLklrzxmUwccUeE8Wc6MIamm37xbNPYyJjUpmFs
	 h7HATsmFwUZRpFIngFlBXC3cMm/ipilPxfEnD+C+kcTcIYtmuDcBi9jwakKS5oC2Br
	 yRmKqYLIj0ruzQKpvSyq+9Y9pWEoupqNl0UCFRyU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807002084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeLKBQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:16:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51324 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbeLKBQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=E7Q9XjeZZEKXn/UC3IbgQ2ABBJbyqOCowEwicM1D+wY=; b=qw+iGfRfidND
        4DwPzalQemJRQPBporl4AAg2a9W5D+3VDIwLtCxF5o/UryfuFvuFZaE71GAgYzqrzlkQd96xmZ3ND
        yejcEckVJGVFTnxZPQIJRNrJe3o8mHd5QO7uWGlmQHCIyQ+GTmLE+SedYRG9Q5QRedhvxoF67CbH3
        OMoWA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWem-0000MF-MJ; Tue, 11 Dec 2018 01:16:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5BA8211254C7; Tue, 11 Dec 2018 01:16:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max8952: Let core handle GPIO descriptor" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011616.5BA8211254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max8952: Let core handle GPIO descriptor

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

From 894077d5c871f86e6c88a70ac016b6811a910b23 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:41 +0100
Subject: [PATCH] regulator: max8952: Let core handle GPIO descriptor

Use the gpiod_get() rather than the devm_* version so that the
regulator core can handle the lifecycle of these descriptors.

Fixes: d7a261c2d1f2 ("regulator: max8952: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8952.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index 6c39fff73b8a..cf2a2912cb1b 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -231,9 +231,13 @@ static int max8952_pmic_probe(struct i2c_client *client,
 	else
 		gflags = GPIOD_OUT_LOW;
 	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
-	gpiod = devm_gpiod_get_optional(&client->dev,
-					"max8952,en",
-					gflags);
+	/*
+	 * Do not use devm* here: the regulator core takes over the
+	 * lifecycle management of the GPIO descriptor.
+	 */
+	gpiod = gpiod_get_optional(&client->dev,
+				   "max8952,en",
+				   gflags);
 	if (IS_ERR(gpiod))
 		return PTR_ERR(gpiod);
 	if (gpiod)
-- 
2.19.0.rc2

