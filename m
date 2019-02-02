Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA92BC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0B2205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549124321;
	bh=gRnoy1Z1O6MWUx0mbQa90MuzbZlJkifLulXhkZqHkAQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YEdDV3oPFzE6BsVO8nX+AHpV6KmvVd34hpFkqIgigXKD9ashaJ4F8HbEJ/s8V3q1T
	 pohr/QbPHnue4+zxu+Ew+thJ8REkGLM7YUkhdjvCvSv2GblmRQZ8BM5gUg9iBdy2mp
	 kZ3QZwZLHEw1MBWkq+SgoTeTYbD7OvvilCXg2SXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfBBQSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:18:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50622 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfBBQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gugM2t868rA4nYhTMK+NTbOlsjxVNJnDX8rarX8QsZ8=; b=WxOxyRxFMBJc
        lP2PUy1NCDxdMfO/RGH0uITnyUWThESYCHE553JcEG6V0mm5gYHnwgoX6Q8dUALoCadrjQ0yNSN0n
        pdCBuIzPCoeWQhTQYtte+8xz7b8xX+Qey0w1vUffqX/+kDA9Z2CxOkt9xr8KlH+UvQs07fVE0vLqn
        CmG2I=;
Received: from [151.216.140.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gpy02-0007dd-1u; Sat, 02 Feb 2019 16:18:34 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BA412440082; Sat,  2 Feb 2019 16:18:33 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: uniphier: Constify uniphier_regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190202161833.BA412440082@finisterre.ee.mobilebroadband>
Date:   Sat,  2 Feb 2019 16:18:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: uniphier: Constify uniphier_regulator_ops

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

From 8cf268e535e827925558034c60ce0e69400feff4 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 30 Jan 2019 15:11:10 +0800
Subject: [PATCH] regulator: uniphier: Constify uniphier_regulator_ops

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/uniphier-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
index 6ba0ae405f2b..9026d5a3e964 100644
--- a/drivers/regulator/uniphier-regulator.c
+++ b/drivers/regulator/uniphier-regulator.c
@@ -32,7 +32,7 @@ struct uniphier_regulator_priv {
 	const struct uniphier_regulator_soc_data *data;
 };
 
-static struct regulator_ops uniphier_regulator_ops = {
+static const struct regulator_ops uniphier_regulator_ops = {
 	.enable     = regulator_enable_regmap,
 	.disable    = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
-- 
2.20.1

