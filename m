Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC613C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A292520892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PuqfysYz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E99+NhPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A292520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeLNMal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:30:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60674 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbeLNMab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:30:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E358607DF; Fri, 14 Dec 2018 12:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790630;
        bh=6htPgsOrg+y1Nvs7WhpyQocYQvQzd97HLAyU+5lN2T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PuqfysYzC5KPLRtvGC2EcjTfYnL2kmEs5hEZQ8P0WYvMz1gZuDGw3dJ92xkvFs+QB
         3axS8oRVra/LjINS4xzZKYQbH7hLfgB7alvI1BLen9mtT4CW0xAm6xWQnqDFAdlFWe
         SsWOuTGZlEj7wIySu28+aHp83jxQlqPMoqECVEu8=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1F326087B;
        Fri, 14 Dec 2018 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544790627;
        bh=6htPgsOrg+y1Nvs7WhpyQocYQvQzd97HLAyU+5lN2T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E99+NhPn2yDTGZFbbv3IkpnlBh+MrGsw07c7wrqm/vOJVQuSVwRkaUx1RpXyxdahr
         k1gICXOvqxSuYre6ROkLGCVeLlPpRL39FT9NrfYpv7tePKbfLNeWPHXU9QFiZ1IGe9
         vPHCQ9/9HOFZ435g4MV7Bs9/IGRFD/3HUEAB0FCA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1F326087B
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
Subject: [PATCH 4/4] ASoC: qdsp6: q6routing: add display_port_rx port routing
Date:   Fri, 14 Dec 2018 17:59:29 +0530
Message-Id: <1544790569-10608-5-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
References: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support to Display_port_rx mixers required to
select path between ASM stream and AFE ports.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index d61b840..ddcd997 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -453,6 +453,9 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
 static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
 	Q6ROUTING_RX_MIXERS(HDMI_RX) };
 
+static const struct snd_kcontrol_new display_port_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(DISPLAY_PORT_RX) };
+
 static const struct snd_kcontrol_new primary_mi2s_rx_mixer_controls[] = {
 	Q6ROUTING_RX_MIXERS(PRIMARY_MI2S_RX) };
 
@@ -655,6 +658,10 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
 			   hdmi_mixer_controls,
 			   ARRAY_SIZE(hdmi_mixer_controls)),
 
+	SND_SOC_DAPM_MIXER("DISPLAY_PORT_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   display_port_mixer_controls,
+			   ARRAY_SIZE(display_port_mixer_controls)),
+
 	SND_SOC_DAPM_MIXER("SLIMBUS_0_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
 			   slimbus_rx_mixer_controls,
 			   ARRAY_SIZE(slimbus_rx_mixer_controls)),
@@ -833,6 +840,8 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
 
 static const struct snd_soc_dapm_route intercon[] = {
 	Q6ROUTING_RX_DAPM_ROUTE("HDMI Mixer", "HDMI_RX"),
+	Q6ROUTING_RX_DAPM_ROUTE("DISPLAY_PORT_RX Audio Mixer",
+				"DISPLAY_PORT_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("SLIMBUS_0_RX Audio Mixer", "SLIMBUS_0_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("SLIMBUS_1_RX Audio Mixer", "SLIMBUS_1_RX"),
 	Q6ROUTING_RX_DAPM_ROUTE("SLIMBUS_2_RX Audio Mixer", "SLIMBUS_2_RX"),
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

