Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A956CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7526E2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515769;
	bh=EK3mHZDtHUhFoY5ZAYwFkIu2chk/mSe7eq6FQzfDdp8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Ab6lEzFU4kzFvLuKeVrFjR4V4nXs0YbGRPkG27jRtvI9IrNZEYBtlESzQm1UyGLD/
	 9adM4+KZsDTgLv9SgQA2hCVTiLD1iWQV35OCl+tAcwPoGOIF6bHQYTJYkcRgrGNtF0
	 6HKs2aSXkx9UXkjJjOJWg9I+qc0rmtSOcqakuvF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfBRSt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:49:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41454 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBRStX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=h3IvtyV+tDBtFWNwf1GwwoOFE6oJ9gCF69TG37Rz5oY=; b=urPlsA1GUsU9
        kQpJ28+JHB0uKzGg7oDOPtuWNNfEvyMouss7KSefb3x7Khc98FlVzfEzyQbRgHGwCn8mfk4gVla4f
        R9yf4T4ZT6wB8KBspwFKkK6S48io3IXCadLinvpAf682WgxK0gQymwfOJNBadhPmkN5GcExSQIr3V
        3skYE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnyb-0001dH-VF; Mon, 18 Feb 2019 18:49:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 737051128008; Mon, 18 Feb 2019 18:49:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Vicente Bergas <vicencb@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "vicencb@gmail.com" <vicencb@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: simple-card: Fix refcount underflow" to the asoc tree
In-Reply-To:  <20190216100927.10017-1-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190218184913.737051128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:49:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-card: Fix refcount underflow

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 461d854c0dba3cdf63cce37ffb9423eca0793a47 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Sat, 16 Feb 2019 10:09:42 +0000
Subject: [PATCH] ASoC: simple-card: Fix refcount underflow

of_get_child_by_name() takes a reference we'll need to drop
later so when we substitute in top we need to take a reference
as well as just assigning.

Without this patch we hit the following error:

[    1.246852] OF: ERROR: Bad of_node_put() on /sound-wm8524
[    1.262261] Hardware name: NXP i.MX8MQ EVK (DT)
[    1.266807] Workqueue: events deferred_probe_work_func
[    1.271950] Call trace:
[    1.274406]  dump_backtrace+0x0/0x158
[    1.278074]  show_stack+0x14/0x20
[    1.281396]  dump_stack+0xa8/0xcc
[    1.284717]  of_node_release+0xb0/0xc8
[    1.288474]  kobject_put+0x74/0xf0
[    1.291879]  of_node_put+0x14/0x28
[    1.295286]  __of_get_next_child+0x44/0x70
[    1.299387]  of_get_next_child+0x3c/0x60
[    1.303315]  simple_for_each_link+0x1dc/0x230
[    1.307676]  simple_probe+0x80/0x540
[    1.311256]  platform_drv_probe+0x50/0xa0

This patch is based on an earlier version posted by Kuninori Morimoto
and commit message includes explanations from Mark Brown.

https://patchwork.kernel.org/patch/10814255/

Reported-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 08df261024cf..dc18c4492955 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -445,7 +445,7 @@ static int simple_for_each_link(struct simple_priv *priv,
 	/* Check if it has dai-link */
 	node = of_get_child_by_name(top, PREFIX "dai-link");
 	if (!node) {
-		node = top;
+		node = of_node_get(top);
 		is_top = 1;
 	}
 
-- 
2.20.1

