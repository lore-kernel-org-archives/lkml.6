Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5230C20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="owQht+Xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5230C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbeKEVSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:18:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39866 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeKEVSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=wi/p1M4beRUw0RGcbSg9OnZc6nASNScXxFhHndNUa2Q=; b=owQht+XidfRq
        3W++Fm7YuoeKqEfTbw+nqpJfV3/cCPv95IVRmCIljSI22epMKuo6nnxGh9Vu1SxzmcYMk2S2PD1Fu
        iLe9UR2Lszq5f7ysBvnrsKcZkxPXMMsG58VWn7jpVGqkDHUWLUtgzRaloQ8JSBQw2XzPCMxobmcjQ
        dl9/s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdWm-0008IY-Vt; Mon, 05 Nov 2018 11:58:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ACB431124D98; Mon,  5 Nov 2018 11:58:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Mark Brown <broonie@kernel.org>, Patrick Lai <plai@codeaurora.org>,
        alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6afe-dai: constify snd_soc_dai_ops structures" to the asoc tree
In-Reply-To:  <1540647284-26728-3-git-send-email-Julia.Lawall@lip6.fr>
Message-Id: <20181105115844.ACB431124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 11:58:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6afe-dai: constify snd_soc_dai_ops structures

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

From 7dfcd9d727c3e69ecb51c0bb4d54b3d46de98e87 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 27 Oct 2018 15:34:43 +0200
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: constify snd_soc_dai_ops structures

The snd_soc_dai_ops structures are only stored in the ops field of a
snd_soc_dai_driver structure, so make the snd_soc_dai_ops structures
const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 60ff4a2d3577..a07a4538d5cf 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -561,13 +561,13 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"QUAT_MI2S_TX", NULL, "Quaternary MI2S Capture"},
 };
 
-static struct snd_soc_dai_ops q6hdmi_ops = {
+static const struct snd_soc_dai_ops q6hdmi_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6hdmi_hw_params,
 	.shutdown	= q6afe_dai_shutdown,
 };
 
-static struct snd_soc_dai_ops q6i2s_ops = {
+static const struct snd_soc_dai_ops q6i2s_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6i2s_hw_params,
 	.set_fmt	= q6i2s_set_fmt,
@@ -575,14 +575,14 @@ static struct snd_soc_dai_ops q6i2s_ops = {
 	.set_sysclk	= q6afe_mi2s_set_sysclk,
 };
 
-static struct snd_soc_dai_ops q6slim_ops = {
+static const struct snd_soc_dai_ops q6slim_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6slim_hw_params,
 	.shutdown	= q6afe_dai_shutdown,
 	.set_channel_map = q6slim_set_channel_map,
 };
 
-static struct snd_soc_dai_ops q6tdm_ops = {
+static const struct snd_soc_dai_ops q6tdm_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.shutdown	= q6afe_dai_shutdown,
 	.set_sysclk	= q6afe_mi2s_set_sysclk,
-- 
2.19.0.rc2

