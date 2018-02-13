Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965385AbeBMRDN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:03:13 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38064 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965513AbeBMRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:45 -0500
X-Google-Smtp-Source: AH8x225IOZFbQQ7JVdA1/VRUbu5dcfsSKeQEKO1XlZQNAIfWdoV5cCkXlIiRsTkXFzkyH5fHa3kAQA==
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
Subject: [PATCH v3 22/25] ASoC: qcom: q6routing: add support to MI2S Mixers
Date: Tue, 13 Feb 2018 16:58:34 +0000
Message-Id: <20180213165837.1620-23-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add support to MI2S mixers required to select path between
ASM stream and AFE ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 142 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 8c9b5d899ba7..8ffcc49a79a1 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -232,6 +232,102 @@ static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
 		       msm_routing_put_audio_mixer),
 };
 
+static const struct snd_kcontrol_new primary_mi2s_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", PRIMARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new secondary_mi2s_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", SECONDARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new quaternary_mi2s_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia5", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia6", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia7", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia8", QUATERNARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new tertiary_mi2s_rx_mixer_controls[] = {
+	SOC_SINGLE_EXT("MultiMedia1", TERTIARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia2", TERTIARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia3", TERTIARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("MultiMedia4", TERTIARY_MI2S_RX,
+	MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+	msm_routing_put_audio_mixer),
+};
+
 static const struct snd_kcontrol_new slimbus_rx_mixer_controls[] = {
 	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_0_RX,
 	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
@@ -443,6 +539,18 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	SND_SOC_DAPM_MIXER("SLIMBUS_6_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
 			   slimbus_6_rx_mixer_controls,
 			   ARRAY_SIZE(slimbus_6_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("PRI_MI2S_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   primary_mi2s_rx_mixer_controls,
+			   ARRAY_SIZE(primary_mi2s_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("SEC_MI2S_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   secondary_mi2s_rx_mixer_controls,
+			   ARRAY_SIZE(secondary_mi2s_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("QUAT_MI2S_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   quaternary_mi2s_rx_mixer_controls,
+			   ARRAY_SIZE(quaternary_mi2s_rx_mixer_controls)),
+	SND_SOC_DAPM_MIXER("TERT_MI2S_RX Audio Mixer", SND_SOC_NOPM, 0, 0,
+			   tertiary_mi2s_rx_mixer_controls,
+			   ARRAY_SIZE(tertiary_mi2s_rx_mixer_controls)),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -520,6 +628,40 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
 	{"SLIMBUS_6_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
 	{"SLIMBUS_6_RX", NULL, "SLIMBUS_6_RX Audio Mixer"},
+
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia6", "MM_DL6"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"QUAT_MI2S_RX Audio Mixer", "MultiMedia8", "MM_DL8"},
+	{"QUAT_MI2S_RX", NULL, "QUAT_MI2S_RX Audio Mixer"},
+
+	{"TERT_MI2S_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"TERT_MI2S_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"TERT_MI2S_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"TERT_MI2S_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"TERT_MI2S_RX", NULL, "TERT_MI2S_RX Audio Mixer"},
+
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia6", "MM_DL5"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"SEC_MI2S_RX Audio Mixer", "MultiMedia8", "MM_DL7"},
+	{"SEC_MI2S_RX", NULL, "SEC_MI2S_RX Audio Mixer"},
+
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia1", "MM_DL1"},
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia2", "MM_DL2"},
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia3", "MM_DL3"},
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia4", "MM_DL4"},
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia5", "MM_DL5"},
+	{"PRI_MI2S_RX Audio Mixer", "MultiMedia7", "MM_DL7"},
+	{"PRI_MI2S_RX", NULL, "PRI_MI2S_RX Audio Mixer"},
 };
 
 static int routing_hw_params(struct snd_pcm_substream *substream,
-- 
2.15.1
