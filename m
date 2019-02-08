Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E65C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB83218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549631497;
	bh=6WMapUN72qPW3G8nJ2fad4lOVRwVDvupjNe85n8J2RA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BNas+Zo2DXLxrm9PF6Qf4suDQygB+DbP/E6DAr+5G/GmIRtB8SSrmD0H7xJPLk6Cc
	 UcYqKbIDTqX5RVQ3lMQfParxMtq74IhsrPd90W32r1G5GSjss5ZJ5kO96wMYTyJ08F
	 YWGPVTfAtWipiRigdj/2+T/4OTDzzLa4YywV7jZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfBHNLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:11:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38510 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBHNLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=U1DSxI99NqnFxgHoTohvWUmfdJSYAKQ0LmnI1J0eDoE=; b=ufQhNqssaYZS
        DvAm8y5NOFmMcWU5zOxMA1oguXhgbtFCTtJNW9uXzZ56dd4DJ8L1EDFGtfnlmLo21zhuSst2ky3Ff
        K/Q1akeXpuqtAXR94RlPBTHwoJ7lAWo7Xj/mpPETvfLlYVoIL7KHuTvCYm82OentEpeUAlyvh0bVK
        RSVIg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gs5wG-0001KQ-6N; Fri, 08 Feb 2019 13:11:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B75BE1127F31; Fri,  8 Feb 2019 13:11:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: fix device unlinking" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190208131127.B75BE1127F31@debutante.sirena.org.uk>
Date:   Fri,  8 Feb 2019 13:11:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fix device unlinking

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

From 82874ba4c6455ca8a90a8fe59834baa4cd4a1e50 Mon Sep 17 00:00:00 2001
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Date: Fri, 8 Feb 2019 08:41:53 +0100
Subject: [PATCH] regulator: fix device unlinking

Device links are refcounted, device_link_remove() has to be called as
many times as device_link_add().

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b9d7b45c7295..2994ee023b40 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2058,15 +2058,7 @@ static void _regulator_put(struct regulator *regulator)
 	debugfs_remove_recursive(regulator->debugfs);
 
 	if (regulator->dev) {
-		int count = 0;
-		struct regulator *r;
-
-		list_for_each_entry(r, &rdev->consumer_list, list)
-			if (r->dev == regulator->dev)
-				count++;
-
-		if (count == 1)
-			device_link_remove(regulator->dev, &rdev->dev);
+		device_link_remove(regulator->dev, &rdev->dev);
 
 		/* remove any sysfs entries */
 		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
-- 
2.20.1

