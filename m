Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0E6C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38D320892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ibm+F9Ph";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PfwU7pfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38D320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbeLNMac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:30:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731187AbeLNMaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:30:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8EA4760312; Fri, 14 Dec 2018 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790624;
        bh=pqxZA/cnA0C9XNHhBktYHe8V0J80MPBgfMkooG5cjIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibm+F9PhFdm9ElV7l8M1N5cdfxX3gykfqwfXuClPNJtngtqRxH57oeWXe3jwPKV5x
         CxhVHRX6fpxQzrIm5WsCJ9xTSZfwSX6spkv2ADba0GKyYnPWs3aVGQXEmxH7ycEMbE
         qAaYgk7slSWD5/ALPUXw92EGJYAywFtT9SCY+JSU=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 56C756081E;
        Fri, 14 Dec 2018 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790620;
        bh=pqxZA/cnA0C9XNHhBktYHe8V0J80MPBgfMkooG5cjIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfwU7pfB7doVAfONNHktdHXGW8rXguCWFQ8FBZMtx1KEVnWUXcHx8ufcVEr1ErUwL
         odUPsD4NJbX5ZAhgVuBsqCrdzEjU6EdzG8Sw6KYRTyK5X3RzzqkbVCtAytv6/D4zcQ
         kbufSiJJhNhMgR8yOeeCFLdu6atAtSRC7oQum81w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56C756081E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org,
        asishb@codeaurora.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 3/4] ASoC: qdsp6: q6afe-dai: add support to Display port RX dais
Date:   Fri, 14 Dec 2018 17:59:28 +0530
Message-Id: <1544790569-10608-4-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
References: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support of AFE DAI for Display_port_rx port.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index bfc3bbf..dc645ba 100644
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
@@ -1090,6 +1092,25 @@ static int msm_dai_q6_dai_remove(struct snd_soc_dai *dai)
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
@@ -1311,6 +1332,7 @@ static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
 						0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_7", NULL,
 						0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("DISPLAY_PORT_RX", "NULL", 0, 0, 0, 0),
 };
 
 static const struct snd_soc_component_driver q6afe_dai_component = {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

