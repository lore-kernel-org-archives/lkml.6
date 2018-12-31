Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5409C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFC921019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546285355;
	bh=23j0E7rCnc23NsJ/U27J8LUZ15FT2zdAE473rx4yBFs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=SA4cYQMWfVAhCTBuOGsZCPg6ODui0zb5V9igloAektVK8cBDPieUsLUjVv/Mt4TZE
	 eOsUoQegeG8LMgcHAPUiTXrmNcCLmjgeWMGaZoROJP7DJH3ClthPQdLSZ7S+gYAaZq
	 oHdhnayBzo15K0OYI3RV7HC3w6eSN5kYTxw3xl1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeLaTme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:42:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47508 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeLaTme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fZEelHYqLWfAC67QYWkHlvIr2llmIu5WlNazAPXQHuA=; b=RhDLbibPnbtx
        Q3pMlOgubUV/6i4Hz7qlT3gPN6pOlqfkU+8GMs/z/XXDF2Qd1woO3NagbMtY1H6fNj7ibpuZHP1EV
        Zd1vYIAaE+7UWPrWCAJcuzm3fIEOtWi8/JnkRcFvXFixrKyw/YQFqmGUVIfqIzSxueOqBvedVIyrH
        olPSM=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ge3SI-0002ml-FH; Mon, 31 Dec 2018 19:42:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BB90D440080; Mon, 31 Dec 2018 19:42:29 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: regmap-irq: silently ignore unsupported type settings" to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181231194229.BB90D440080@finisterre.ee.mobilebroadband>
Date:   Mon, 31 Dec 2018 19:42:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: regmap-irq: silently ignore unsupported type settings

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

From 74d4b4e0f43e5ffb61b63f4e3cfcfad3d7398765 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Thu, 27 Dec 2018 10:44:43 +0200
Subject: [PATCH] regmap: regmap-irq: silently ignore unsupported type settings

Do not return error if irq-type setting is requested for
controlloer which does not support this. This is how
regmap-irq has previously handled the undupported type
settings and existing drivers seem to be upset if failure
is now reported.

Fixes: 1c2928e3e321 ("regmap: regmap-irq/gpio-max77620: add level-irq support")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 1bd1145ad8b5..d2d0014b0d23 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -258,7 +258,7 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 	const struct regmap_irq_type *t = &irq_data->type;
 
 	if ((t->types_supported & type) != type)
-		return -ENOTSUPP;
+		return 0;
 
 	reg = t->type_reg_offset / map->reg_stride;
 
-- 
2.20.1

