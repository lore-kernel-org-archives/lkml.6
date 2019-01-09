Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145FDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33AC206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547038186;
	bh=0JQXQ8tg6rrUbMMD7jsJhDyhhhq6Ta8O+t+Js54LyDE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xSb0iAkzfRpTN2daHu6c4nB4gUCkS0GI8Qo3vKogkxz5dDAoKGP2UKamE0hb/bt49
	 r6XA0qphL2Bf6WvY0Lh5C/dhLQujKHrwUvB4BWoG40Xf/ADjgeRO5hdcHWxB1ofY+s
	 OH4Ac9+ckRH5yjZ/ttH2ydkPb04DZH5/1mB4+P4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfAIMtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:49:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50298 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbfAIMtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=XMqI1r2Y8+Gc6wIK9C2Ro2ygAakrwmUjqcZGiBbe6go=; b=Q5VwZk2So0H1
        9jiGQXEoyWGP0Y2J0ZjON+UIO/leS4FuF7WH9sSjspsta6KgvGSSxQbnyKXl02wG9gwZXGDHudfRe
        egwywS/kZFzEFxzjrvBK/9LvdeVMeCBb4MTcrIHzgQml7rp81X+u68D5vjg9rEzE+iAgqrrRLQ7nm
        8mKew=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghDI6-0007yM-Tb; Wed, 09 Jan 2019 12:49:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 672EB1127528; Wed,  9 Jan 2019 12:49:02 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Ajit Pandey <ajitp@codeaurora.org>
Cc:     Rohit kumar <rohitkr@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, asishb@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, vinod.koul@linaro.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: soc-core: defer card probe until all component is added to list" to the asoc tree
In-Reply-To:  <1547023627-30312-1-git-send-email-rohitkr@codeaurora.org>
X-Patchwork-Hint: ignore
Message-Id: <20190109124902.672EB1127528@debutante.sirena.org.uk>
Date:   Wed,  9 Jan 2019 12:49:02 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-core: defer card probe until all component is added to list

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

From 8780cf1142a59568a3aa77959cbd76b2edb6fd81 Mon Sep 17 00:00:00 2001
From: Ajit Pandey <ajitp@codeaurora.org>
Date: Wed, 9 Jan 2019 14:17:07 +0530
Subject: [PATCH] ASoC: soc-core: defer card probe until all component is added
 to list

DAI component probe is not called if it is not present
in component list during sound card registration.
Check if component is available in component list for
platform and cpu dai before soundcard registration.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0462b3ec977a..eec92f17dd15 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1027,7 +1027,6 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_dai_link_component *platform = dai_link->platform;
-
 	/*
 	 * FIXME
 	 *
@@ -1129,6 +1128,14 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 			link->name);
 		return -EINVAL;
 	}
+
+	/*
+	 * Defer card registartion if platform dai component is not added to
+	 * component list.
+	 */
+	if (!soc_find_component(link->platform->of_node, link->platform->name))
+		return -EPROBE_DEFER;
+
 	/*
 	 * CPU device may be specified by either name or OF node, but
 	 * can be left unspecified, and will be matched based on DAI
@@ -1140,6 +1147,14 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 			link->name);
 		return -EINVAL;
 	}
+
+	/*
+	 * Defer card registartion if cpu dai component is not added to
+	 * component list.
+	 */
+	if (!soc_find_component(link->cpu_of_node, link->cpu_name))
+		return -EPROBE_DEFER;
+
 	/*
 	 * At least one of CPU DAI name or CPU device name/node must be
 	 * specified
-- 
2.20.1

