Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FCAC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5885520892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791782;
	bh=Tf8m/u9+0QYRBSNpngiEO7kWKu7juI8bAVGkQQ0cutY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mQ4wpjfuv5hp/tZsS4CIlKTVE39Sk0sSd509WeSfNcUXck+xM8APiiLdtDmjX60h4
	 6rSGqwKFzcFxhOVrkGNLci1Kf497wJDYURiZMod+7p0Vx2Lc+gy7PFTyqnvvBmBzrE
	 DN+lZvEs8yzhbQHqPT1zKLvhchK8u3vY4xz6Mb/o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5885520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbeLNMtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:49:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49792 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbeLNMt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QDmc+Cb9tIkN8TVkY1t4mg+OrNzAXxc1QBo/XAVUtVc=; b=sEwo1hja7Iom
        rFeliiWurMPs2s9uRDp2ZddYyJlI69GMSoIZzQFW45eff/BBaS0dU6XDjSmJ2rEQFg/MntW/6UxYj
        Q0exEmQtQWwiIOYwbhYguVTo0+RGYteICzjh2YMwZMv2OH/B6nBMZHYRbUsRuxhCA2ku/J42/ti2j
        IF/KM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXmu7-0006m6-6k; Fri, 14 Dec 2018 12:49:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DFE7A11258A2; Fri, 14 Dec 2018 12:49:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org,
        asishb@codeaurora.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6afe-dai: add support to Display port RX dais" to the asoc tree
In-Reply-To:  <1544790569-10608-4-git-send-email-rohitkr@codeaurora.org>
X-Patchwork-Hint: ignore
Message-Id: <20181214124918.DFE7A11258A2@debutante.sirena.org.uk>
Date:   Fri, 14 Dec 2018 12:49:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6afe-dai: add support to Display port RX dais

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

From 32d2c61ba05944aa1e61d186611310dd911e1703 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 14 Dec 2018 17:59:28 +0530
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: add support to Display port RX dais

This patch adds support of AFE DAI for Display_port_rx port.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index bfc3bbf1d4de..dc645ba4d8d0 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -341,6 +341,7 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 
 	switch (dai->id) {
 	case HDMI_RX:
+	case DISPLAY_PORT_RX:
 		q6afe_hdmi_port_prepare(dai_data->port[dai->id],
 					&dai_data->port_config[dai->id].hdmi);
 		break;
@@ -445,6 +446,7 @@ static int q6afe_mi2s_set_sysclk(struct snd_soc_dai *dai,
 
 static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"HDMI Playback", NULL, "HDMI_RX"},
+	{"Display Port Playback", NULL, "DISPLAY_PORT_RX"},
 	{"Slimbus1 Playback", NULL, "SLIMBUS_1_RX"},
 	{"Slimbus2 Playback", NULL, "SLIMBUS_2_RX"},
 	{"Slimbus3 Playback", NULL, "SLIMBUS_3_RX"},
@@ -1090,6 +1092,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 	Q6AFE_TDM_CAP_DAI("Quinary", 5, QUINARY_TDM_TX_5),
 	Q6AFE_TDM_CAP_DAI("Quinary", 6, QUINARY_TDM_TX_6),
 	Q6AFE_TDM_CAP_DAI("Quinary", 7, QUINARY_TDM_TX_7),
+	{
+		.playback = {
+			.stream_name = "Display Port Playback",
+			.rates = SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 2,
+			.channels_max = 8,
+			.rate_max =     192000,
+			.rate_min =	48000,
+		},
+		.ops = &q6hdmi_ops,
+		.id = DISPLAY_PORT_RX,
+		.name = "DISPLAY_PORT",
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	},
 };
 
 static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
@@ -1311,6 +1332,7 @@ static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
 						0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_7", NULL,
 						0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("DISPLAY_PORT_RX", "NULL", 0, 0, 0, 0),
 };
 
 static const struct snd_soc_component_driver q6afe_dai_component = {
-- 
2.19.0.rc2

