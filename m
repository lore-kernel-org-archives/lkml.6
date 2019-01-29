Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682B0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9FE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548782192;
	bh=rb8o7QsHj/ThOcfSZ5kpRbwzwl/MfTTWFVMRA394HMI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wM1MGmRx7HPXhhHfmD9Rfr0lAf6dlLhxQZyUVXY5tvyEDHMovLNXnk+By35ZmPvB0
	 JetNAI8RMLNib472zhxNAWl5wUSX4C2d8WlNqoc3qa6aF7ABRyHbkjKCaGueQ06/Nj
	 JZkbUoNPTbNyHCqGIW3nJ+Kj53wsGTZzB/PY/kM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfA2RQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:16:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbfA2RQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VuDpNZ87pKKJ5E6W6LSs6+1dnx+kIMY3Je4tKSt7UQs=; b=mKQo+Qa5OqB3
        MR0Fa8XNdAXHzsHvG0ogR63sha40+ti2W+deLP3/1RVS4LjWA9xjPlufxihT45ZFqcxeKmxJlxBQU
        FKMb83CAJSs7tigU8PlYhi5Hv0CFaQueTO/pryyLTn9x964MI5pgqkRPZCjj0jarYKUnfwA1gJU3B
        neiRY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goWzf-0000jg-NO; Tue, 29 Jan 2019 17:16:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4E8031127D50; Tue, 29 Jan 2019 17:16:15 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Remove attribute packed from struct 'regcache_rbtree_node'" to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190129171615.4E8031127D50@debutante.sirena.org.uk>
Date:   Tue, 29 Jan 2019 17:16:15 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Remove attribute packed from struct 'regcache_rbtree_node'

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

From 435bba0f11f06789be59757719c161915e92f889 Mon Sep 17 00:00:00 2001
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 24 Jan 2019 19:06:24 +0100
Subject: [PATCH] regmap: Remove attribute packed from struct
 'regcache_rbtree_node'

On one hand commit 28644c809f44 ("regmap: Add the rbtree cache support")
added 'regcache_rbtree_node' as packed structure, while on the other hand
commit e977145aeaad ("[RBTREE] Add explicit alignment to sizeof(long)
for struct rb_node.") declared struct 'rb_node' as aligned.

Solve the ambiguity of placing aligned structure in a packed one by
removing the packed attribute from struct. This seems to be the behavior
of gcc anyway.

This removes the following warning (W=1):

  drivers/base/regmap/regcache-rbtree.c:36:1: warning: alignment 1 of 'struct regcache_rbtree_node' is less than 4 [-Wpacked-not-aligned]

Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache-rbtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index 2e8f0144f9ab..9cbb4b0cd01b 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -33,7 +33,7 @@ struct regcache_rbtree_node {
 	unsigned int blklen;
 	/* the actual rbtree node holding this block */
 	struct rb_node node;
-} __attribute__ ((packed));
+};
 
 struct regcache_rbtree_ctx {
 	struct rb_root root;
-- 
2.20.1

