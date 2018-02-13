Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965480AbeBMREo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:04:44 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38051 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965483AbeBMRBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:41 -0500
X-Google-Smtp-Source: AH8x226DqjZGYL1eHysvUuRr2qgOsH017Mg5rV9opOIiDK280OC6PnlwEdIl8iAHAKpaNIbAScVnpg==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
        spatakok@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 18/25] ASoC: qcom: q6routing: add support to all SLIMBus Mixers
Date: Tue, 13 Feb 2018 16:58:30 +0000
Message-Id: <20180213165837.1620-19-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to SLIMBus related mixers to control mux between
ASM stream and AFE port.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 261 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 828243c58569..8c9b5d899ba7 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -232,6 +232,180 @@ static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
 		       msm_routing_put_audio_mixer),
 };
 
+static const struct snd_kcontrol_new slimbus_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_0_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_1_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_1_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_2_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_2_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_3_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_3_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_4_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_4_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_4_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_4_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_5_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_5_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new slimbus_6_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SLIMBUS_6_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
 static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	/* Frontend AIF */
 	SND_SOC_DAPM_AIF_IN("MM_DL1", "MultiMedia1 Playback", 0, 0, 0, 0),
@@ -247,6 +421,28 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	SND_SOC_DAPM_MIXER("HDMI Mixer", SND_SOC_NOPM, 0, 0,
 			   hdmi_mixer_controls,
 			   ARRAY_SIZE(hdmi_mixer_controls)),
+
+	SND_SOC_DAPM_MIXER("SLIMBUS_0_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_1_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_1_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_1_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_2_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_2_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_2_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_3_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_3_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_3_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_4_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_4_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_4_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_5_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_5_rx_mixer_controls,
+			    ARRAY_SIZE(slimbus_5_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SLIMBUS_6_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   slimbus_6_rx_mixer_controls,
+			   ARRAY_SIZE(slimbus_6_rx_mixer_controls)),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -259,6 +455,71 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HDMI Mixer", "MultiMedia7", "MM_DL7"},
 	{"HDMI Mixer", "MultiMedia8", "MM_DL8"},
 	{"HDMI_RX", NULL, "HDMI Mixer"},
+
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_0_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_0_RX", NULL, "SLIMBUS_0_RX Audio Mixer"},
+
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_1_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_1_RX", NULL, "SLIMBUS_1_RX Audio Mixer"},
+
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_2_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_2_RX", NULL, "SLIMBUS_2_RX Audio Mixer"},
+
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_3_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_3_RX", NULL, "SLIMBUS_3_RX Audio Mixer"},
+
+	{"SLIMBUS_4_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_4_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_4_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_4_RX", NULL, "SLIMBUS_4_RX Audio Mixer"},
+
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_5_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_5_RX", NULL, "SLIMBUS_5_RX Audio Mixer"},
+
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"SLIMBUS_6_RX", NULL, "SLIMBUS_6_RX Audio Mixer"},
 };
 
 static int routing_hw_params(struct snd_pcm_substream *substream,
-- 
2.15.1
