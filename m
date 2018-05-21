Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZoyXIcAacrgd52/20TtZlH6eK3I3N4+IN+kr7oJxd46U18bPLRHlfsBTLlJyFJGEvFigokv
ARC-Seal: i=1; a=rsa-sha256; t=1526917639; cv=none;
        d=google.com; s=arc-20160816;
        b=IB8pF/LcY08oap2EQlgFrNYM3h4sXRRypgel/5xMbROdZ8Ss/lsSR1BvnPWHQw9n5l
         rQZy2FIBLlaF1J/ELn0IpZc6fUzXz+xvEEQE5bKiaGyCctn/2OCeqjRPuF8kesOTMkqH
         ESni+kxsfiINH8JbKR4rOVOkVB7GcQryEFQOkXIi9A/E9/Y/V4XtVxVKB+Yd6EGJnq22
         ndRpESzWnYecrC6NhHNTwkDUMq/+PxsXhu+A8NZSPcTZ+z4koB+1ws/w8NFRx6EcVAa9
         vgYCswfhAJokB1Vbb5qcMmwPk5d3VWp5gm+Jqh2FmeNV2LouvUXpxewa8nDdF0O+jVPw
         nqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=MPgI5HVdo8Z9ZaAJlmdZfTV6EAkFoX0HfB4vxIqSpgg=;
        b=o+yhyjb5TMBRbNkutX5YXgOxpi3RKxcDyMs3d1p/gxe1ZiYI2BpcCqvahWyKGA651p
         IwmGj8nl88TU03hEvfqxF4/FAQcECQ8LdaMjpof1Xxlu6CuBuT/NcBKPBBYLcKAeFw5P
         WqoOgYiBmKOGlSjIqUPmzT9Zn3Wbre0kaiaIA1aAT1MrWOrpJP47mMsDRKUBM9NHLed1
         TakIAAX/YEg2734i9wsP/9GETIp0jLzKdevd6oy8SkMkVR1NypE2V6iqlx1rYP84iz4P
         eC2CQk+8inIds83U3xE8D1Ojc4alDwBRJ2g936lMJoklfu/uucOCEyzKjQ6QN7wzXC56
         x62Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=RJCOsjLu;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=RJCOsjLu;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, srinivas.kandagatla@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6routing: Add support to MI2S Mixers" to the asoc tree
In-Reply-To: <20180310022456.26739-19-srinivas.kandagatla@linaro.org>
Message-Id: <E1fKn1o-00074c-MT@debutante>
Date: Mon, 21 May 2018 16:47:16 +0100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601089191124424477?=
X-GMAIL-MSGID: =?utf-8?q?1601089191124424477?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: qdsp6: q6routing: Add support to MI2S Mixers

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

>From c8add3fd49fe1547bf2d3209a42543657caa3dad Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 18 May 2018 13:56:06 +0100
Subject: [PATCH] ASoC: qdsp6: q6routing: Add support to MI2S Mixers

This patch add support to MI2S mixers required to select path between
ASM stream and AFE ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 329 +++++++++++++++++++++++++++++++
 1 file changed, 329 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 43086913060a..08c25c26adf4 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -241,6 +241,103 @@ static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
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
+
 static const struct snd_kcontrol_new slimbus_rx_mixer_controls[] = {
 	SOC_SINGLE_EXT("MultiMedia1", SLIMBUS_0_RX,
 	MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
@@ -415,6 +512,126 @@ static const struct snd_kcontrol_new slimbus_6_rx_mixer_controls[] = {
 	msm_routing_put_audio_mixer),
 };
 
+static const struct snd_kcontrol_new mmul1_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA1, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul2_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA2, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul3_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA3, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul4_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA4, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul5_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA5, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul6_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA6, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul7_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA7, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
+static const struct snd_kcontrol_new mmul8_mixer_controls[] = {
+	SOC_SINGLE_EXT("PRI_MI2S_TX", PRIMARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("TERT_MI2S_TX", TERTIARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+	SOC_SINGLE_EXT("SEC_MI2S_TX", SECONDARY_MI2S_TX,
+		MSM_FRONTEND_DAI_MULTIMEDIA8, 1, 0, msm_routing_get_audio_mixer,
+		msm_routing_put_audio_mixer),
+};
+
 static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	/* Frontend AIF */
 	SND_SOC_DAPM_AIF_IN("MM_DL1", "MultiMedia1 Playback", 0, 0, 0, 0),
@@ -460,6 +677,35 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
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
+	SND_SOC_DAPM_MIXER("MultiMedia1 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul1_mixer_controls, ARRAY_SIZE(mmul1_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia2 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul2_mixer_controls, ARRAY_SIZE(mmul2_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia3 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul3_mixer_controls, ARRAY_SIZE(mmul3_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia4 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul4_mixer_controls, ARRAY_SIZE(mmul4_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia5 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul5_mixer_controls, ARRAY_SIZE(mmul5_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia6 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul6_mixer_controls, ARRAY_SIZE(mmul6_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia7 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul7_mixer_controls, ARRAY_SIZE(mmul7_mixer_controls)),
+	SND_SOC_DAPM_MIXER("MultiMedia8 Mixer", SND_SOC_NOPM, 0, 0,
+		mmul8_mixer_controls, ARRAY_SIZE(mmul8_mixer_controls)),
+
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -537,6 +783,89 @@ static const struct snd_soc_dapm_route intercon[] = {
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
+
+	{"MultiMedia1 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia1 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia1 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia1 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia2 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia2 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia2 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia2 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia3 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia3 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia3 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia3 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia4 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia4 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia4 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia4 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia5 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia5 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia5 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia5 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia6 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia6 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia6 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia6 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia7 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia7 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia7 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia7 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MultiMedia8 Mixer", "PRI_MI2S_TX", "PRI_MI2S_TX"},
+	{"MultiMedia8 Mixer", "SEC_MI2S_TX", "SEC_MI2S_TX"},
+	{"MultiMedia8 Mixer", "QUAT_MI2S_TX", "QUAT_MI2S_TX"},
+	{"MultiMedia8 Mixer", "TERT_MI2S_TX", "TERT_MI2S_TX"},
+
+	{"MM_UL1", NULL, "MultiMedia1 Mixer"},
+	{"MM_UL2", NULL, "MultiMedia2 Mixer"},
+	{"MM_UL3", NULL, "MultiMedia3 Mixer"},
+	{"MM_UL4", NULL, "MultiMedia4 Mixer"},
+	{"MM_UL5", NULL, "MultiMedia5 Mixer"},
+	{"MM_UL6", NULL, "MultiMedia6 Mixer"},
+	{"MM_UL7", NULL, "MultiMedia7 Mixer"},
+	{"MM_UL8", NULL, "MultiMedia8 Mixer"},
 };
 
 static int routing_hw_params(struct snd_pcm_substream *substream,
-- 
2.17.0
