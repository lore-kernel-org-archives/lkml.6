Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52CCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0F52084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544491004;
	bh=Ww1i0Py/dYFcS3/r8geUHIC0DLhic+0YEIvaagDfa8c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Pa4T6CYbvGnyonzVTSl/L7LCkmeV1rsAx5Z9mMTYS/rPAt/zoyV/7Jko9u42zfrTe
	 Cfy2JOqHqcKNLXmpj09PqjS1GNtbtWwbA38IxuD6j3v8tZttuForbQLb2a9QtYIelJ
	 rI4PpaXTqbUGKo07Z/z8XusPZIBVoQzdNZE50jGA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0F52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeLKBQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:16:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51452 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbeLKBQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fSkytNa14hCn1O9sSvBenoyVgWMmZ6s0CIKqxfUWiLU=; b=CCfFhWFX8LFK
        0/2mo7ediT6xpY8N+jUSq+qOxCwXVoY+LsrXyZgLRS+BcnmXaxa6O0pNgVjjD5vpRkmM+4zxre0Vs
        +u1Y/JqfCj/GIDMuJEtDsyqNy9+H+Xtvfw+LttVHWrr0h4NN6DLkjMarXps8AUzOQlMyZnNEa3v89
        dog7g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWer-0000MZ-ET; Tue, 11 Dec 2018 01:16:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2213B11254C7; Tue, 11 Dec 2018 01:16:21 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: fixed: Let core handle GPIO descriptor" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011621.2213B11254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:21 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fixed: Let core handle GPIO descriptor

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

From 5e6f3ae5c13b12ecd440da2f511fc5fd3c8de520 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:38 +0100
Subject: [PATCH] regulator: fixed: Let core handle GPIO descriptor

Use the gpiod_get() rather than the devm_* version so that the
regulator core can handle the lifecycle of these descriptors.

Fixes: efdfeb079cc3 ("regulator: fixed: Convert to use GPIO descriptor only")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/fixed.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index ccc29038f19a..9abdb9130766 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -183,7 +183,11 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	 */
 	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, gflags);
+	/*
+	 * Do not use devm* here: the regulator core takes over the
+	 * lifecycle management of the GPIO descriptor.
+	 */
+	cfg.ena_gpiod = gpiod_get_optional(&pdev->dev, NULL, gflags);
 	if (IS_ERR(cfg.ena_gpiod))
 		return PTR_ERR(cfg.ena_gpiod);
 
-- 
2.19.0.rc2

