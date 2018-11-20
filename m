Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA35C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE7F2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="r7eWIX+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE7F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeKUC6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:58:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59492 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeKUC6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=z2GiT52jrHlONczLXnkaA8jHyW6uiagj5fPH6Qpecq8=; b=r7eWIX+0wr3x
        CqmEwMqLUtTHDAj3j0yWnwrk3yUdCXsyVUeax+jNF0yQIN0Wh9Gwnis5jebijn42LFqlmqgkNsPDC
        QnB0Jo3ehnRhLBfkbzvGRLhY1PLbbi/5wR7otKTrXipRRFs0kNstIsRoojonjMrIA9BKY1oZlZb1b
        61m2M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP8sp-0001ma-FG; Tue, 20 Nov 2018 16:28:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 262471124DC2; Tue, 20 Nov 2018 16:28:15 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: s2mps11: Fix GPIO descriptor initialization" to the regulator tree
In-Reply-To: 
Message-Id: <20181120162815.262471124DC2@debutante.sirena.org.uk>
Date:   Tue, 20 Nov 2018 16:28:15 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s2mps11: Fix GPIO descriptor initialization

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

From d7c7fc442fa6f6f0cd0115d7b8dbdf6fe2eeea44 Mon Sep 17 00:00:00 2001
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Tue, 20 Nov 2018 13:38:44 +0100
Subject: [PATCH] regulator: s2mps11: Fix GPIO descriptor initialization

GPIO descriptor array must be zero initialized to ensure that core will
properly handle also the case when no external GPIO pin is defined.

Fixes: 1c984942f0a4 ("regulator: s2mps11: Pass descriptor instead of GPIO number")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s2mps11.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 6fec45897194..63e66f485cc0 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1134,9 +1134,8 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s2mps11->ext_control_gpiod = devm_kmalloc_array(&pdev->dev,
-			rdev_num, sizeof(*s2mps11->ext_control_gpiod),
-			GFP_KERNEL);
+	s2mps11->ext_control_gpiod = devm_kcalloc(&pdev->dev, rdev_num,
+			       sizeof(*s2mps11->ext_control_gpiod), GFP_KERNEL);
 	if (!s2mps11->ext_control_gpiod)
 		return -ENOMEM;
 
-- 
2.19.0.rc2

