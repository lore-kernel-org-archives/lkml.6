Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B91FC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C721B20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Fe/ZootO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C721B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeKEVSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:18:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40904 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeKEVSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fBim8hdGXk9nib61Eba4kL2ZqDmJ3lY1QiHMQRs8iDs=; b=Fe/ZootOiRQk
        iFFsprWOFkEegrH2gf9ZdZQNUjY1DPhaBPAyac8/GSENlM+u/KZTgrShHUwG2OgkT1KTVXkI+TWmt
        1obVL/1imQZq0kVxGispVv0X0fEgf70tWg69BmFPNb0l2RP9o59Nq5hTk+M71NSLEx50A/Dp22QP/
        5y8WA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdXL-0008JA-VC; Mon, 05 Nov 2018 11:59:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AE2871124D98; Mon,  5 Nov 2018 11:59:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Mark Brown <broonie@kernel.org>, Patrick Lai <plai@codeaurora.org>,
        alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: smd845: constify snd_soc_ops structure" to the asoc tree
In-Reply-To:  <1541170818-24219-1-git-send-email-Julia.Lawall@lip6.fr>
Message-Id: <20181105115919.AE2871124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 11:59:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: smd845: constify snd_soc_ops structure

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

From ff60005e4598ca9a79fa6d8378dd35a668ae4de7 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Fri, 2 Nov 2018 16:00:18 +0100
Subject: [PATCH] ASoC: smd845: constify snd_soc_ops structure

The snd_soc_ops structure can be const as it is only stored in the
ops field of a snd_soc_dai_link structure and this field is const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 9effbecc571f..8d0cdff64377 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -171,7 +171,7 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
 	}
 }
 
-static struct snd_soc_ops sdm845_be_ops = {
+static const struct snd_soc_ops sdm845_be_ops = {
 	.hw_params = sdm845_snd_hw_params,
 	.startup = sdm845_snd_startup,
 	.shutdown = sdm845_snd_shutdown,
-- 
2.19.0.rc2

