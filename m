Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9573C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E0620659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547507056;
	bh=tmPIFuUl0epmY2+VEwk+iKj8tcXxixVcFheeMp5Vk6g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nysEhcozTRGuJKl8vCCRAhRiVpp/S83ZepM4dzH6A16V5+DO9/4FZfWecKGpj+JLX
	 3gzmLRjtOo3U+vU3JCoz/JrJ3UPgaQ8F8PW6nkxgN6eDyVPLkXHvUT3IphYw8XVVZv
	 qbHsSmbIk7YvSK3KywaJU5Fl71THDDM34kGuHD0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfANXEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:04:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40200 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfANXEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mmO0gfAZlukenUH8oUgOBwwngVNRIRbotvB94HozIDA=; b=ZYp8vsYqxvxE
        4NxxipVg3tYXG/t2UnPXkkx76/NFx78827mJslwE8tJVGBSELj/P7qpDkfdNSJgZ9LTfAXOZ9Qne4
        /fBgpDoFvpazxabRZkvg4bt/bF/0dHnAstzoqgACyxXrtTYGstM4fRSwDMUkNjmzH361S7/lOHaTc
        ph0So=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjBH7-0000TH-Fb; Mon, 14 Jan 2019 23:04:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2193B1127AD1; Mon, 14 Jan 2019 23:04:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Mark Zhang <markz@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jinyoung Park <jinyoungp@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap-irq: do not write mask register if mask_base is zero" to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190114230409.2193B1127AD1@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 23:04:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap-irq: do not write mask register if mask_base is zero

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

From 7151449fe7fa5962c6153355f9779d6be99e8e97 Mon Sep 17 00:00:00 2001
From: Mark Zhang <markz@nvidia.com>
Date: Mon, 14 Jan 2019 17:32:58 +0800
Subject: [PATCH] regmap-irq: do not write mask register if mask_base is zero

If client have not provided the mask base register then do not
write into the mask register.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Jinyoung Park <jinyoungp@nvidia.com>
Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index d2d0014b0d23..330c1f7e9665 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -108,6 +108,9 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	 * suppress pointless writes.
 	 */
 	for (i = 0; i < d->chip->num_regs; i++) {
+		if (!d->chip->mask_base)
+			continue;
+
 		reg = d->chip->mask_base +
 			(i * map->reg_stride * d->irq_reg_stride);
 		if (d->chip->mask_invert) {
@@ -588,6 +591,9 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	/* Mask all the interrupts by default */
 	for (i = 0; i < chip->num_regs; i++) {
 		d->mask_buf[i] = d->mask_buf_def[i];
+		if (!chip->mask_base)
+			continue;
+
 		reg = chip->mask_base +
 			(i * map->reg_stride * d->irq_reg_stride);
 		if (chip->mask_invert)
-- 
2.20.1

