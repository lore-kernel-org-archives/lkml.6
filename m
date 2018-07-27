Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1188EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B12208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/ppXmA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B12208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbeG0NmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:42:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35040 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732122AbeG0NmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:42:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so4862749wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+zPPNNZYMiZSspNuJMykhK88X7EG+k+AphDTjK5/hAM=;
        b=f/ppXmA+J518GMHkq10qO7q9CkFWx20H4Q9Y97vVPl6L9AMZzlzyjN1XdXm4aEzx2p
         f0HJbuuqjolmMnWPR8QaRH0hqGvTsCHXGTbyCF7G4d0rREpBjrIzZkC1UOLxpz2AD7PQ
         LTD7PFp08093uMako20+S/4Ggx6rn/cGioTWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+zPPNNZYMiZSspNuJMykhK88X7EG+k+AphDTjK5/hAM=;
        b=P7/jdIM0LXHyFGtDayYQwRZDpogzrz7Su1oddd9EpjetOUMqn4cT4XWWqyKxDDyi1g
         ElH8HuBq47zzuc+mJeGCOVVPNUFEN582z0AKnG/T3IJmbURuP+ugPAsqVB24i6IZNmwu
         SuQJ0UHbj50SYfl/tJ6gKpgtnP5SaOtQ0xv/5Ey0Tj+xIOA3sNYNvKQLhVPe+F4L9pNA
         PDIrhwVqqlry84Hz8jAs8E1uAfNP7PF3OSae9FrSgj8LeD8267sejK1li9894VWvF0R/
         ND3UIGMc4Tyf3FHJz50FvVZ3ecEyC2hpLG7pPqvSFacKoG26he3JAAAudYpYQLwrnnJt
         2POg==
X-Gm-Message-State: AOUpUlHH8DEhLyq5ApBuvO2nQQlhnYjAo4scE4LhuZi0l+kLjb+B2T1e
        AZOeWQdc1WzOXRFpNTO5T1XICg==
X-Google-Smtp-Source: AAOMgpdPuHG4MS6JtbxrEjVVphkpuSztOjBbvaltXveH00qMI5SVNSadGBL/zVvnvuP/JlzvK/xJHw==
X-Received: by 2002:a5d:62c7:: with SMTP id o7-v6mr4854365wrv.83.1532694031788;
        Fri, 27 Jul 2018 05:20:31 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b126-v6sm6178522wmf.41.2018.07.27.05.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 05:20:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Subject: [PATCH v2 06/10] ASoC: wcd9335: add basic controls
Date:   Fri, 27 Jul 2018 13:18:02 +0100
Message-Id: <20180727121806.18209-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic controls found in wcd9335 codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 358 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 358 insertions(+)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 06c73699f16f..36912838c7c5 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -104,6 +104,18 @@ enum {
 	NUM_CODEC_DAIS,
 };
 
+enum {
+	COMPANDER_1, /* HPH_L */
+	COMPANDER_2, /* HPH_R */
+	COMPANDER_3, /* LO1_DIFF */
+	COMPANDER_4, /* LO2_DIFF */
+	COMPANDER_5, /* LO3_SE */
+	COMPANDER_6, /* LO4_SE */
+	COMPANDER_7, /* SWR SPK CH1 */
+	COMPANDER_8, /* SWR SPK CH2 */
+	COMPANDER_MAX,
+};
+
 enum {
 	INTn_2_INP_SEL_ZERO = 0,
 	INTn_2_INP_SEL_RX0,
@@ -184,6 +196,7 @@ struct wcd9335_codec {
 
 	struct wcd_clsh_ctrl *clsh_ctrl;
 	u32 hph_mode;
+	int comp_enabled[COMPANDER_MAX];
 };
 
 static const struct wcd9335_slim_ch wcd9335_rx_chs[WCD9335_RX_MAX] = {
@@ -295,6 +308,118 @@ static const struct wcd9335_reg_mask_val wcd9335_codec_reg_init_common_val[] = {
 	{WCD9335_VBADC_IBIAS_FE, 0x0C, 0x08},
 };
 
+/* Cutoff frequency for high pass filter */
+static const char * const cf_text[] = {
+	"CF_NEG_3DB_4HZ", "CF_NEG_3DB_75HZ", "CF_NEG_3DB_150HZ"
+};
+
+static const char * const rx_cf_text[] = {
+	"CF_NEG_3DB_4HZ", "CF_NEG_3DB_75HZ", "CF_NEG_3DB_150HZ",
+	"CF_NEG_3DB_0P48HZ"
+};
+
+static const char * const wcd9335_ear_pa_gain_text[] = {
+	"G_6_DB", "G_4P5_DB", "G_3_DB", "G_1P5_DB",
+	"G_0_DB", "G_M2P5_DB", "UNDEFINED", "G_M12_DB"
+};
+
+static const char * const rx_hph_mode_mux_text[] = {
+	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI"
+};
+
+static const DECLARE_TLV_DB_SCALE(digital_gain, 0, 1, 0);
+static const DECLARE_TLV_DB_SCALE(line_gain, 0, 7, 1);
+static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
+
+static const struct soc_enum wcd9335_ear_pa_gain_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(wcd9335_ear_pa_gain_text),
+			wcd9335_ear_pa_gain_text);
+
+static const struct soc_enum cf_dec0_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX0_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX1_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec2_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX2_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec3_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX3_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec4_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX4_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec5_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX5_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec6_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX6_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec7_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX7_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec8_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX8_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_int0_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX0_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int0_2_enum, WCD9335_CDC_RX0_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int1_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX1_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int1_2_enum, WCD9335_CDC_RX1_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int2_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX2_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int2_2_enum, WCD9335_CDC_RX2_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int3_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX3_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int3_2_enum, WCD9335_CDC_RX3_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int4_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX4_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int4_2_enum, WCD9335_CDC_RX4_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int5_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX5_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int5_2_enum, WCD9335_CDC_RX5_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int6_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX6_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int6_2_enum, WCD9335_CDC_RX6_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int7_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX7_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int7_2_enum, WCD9335_CDC_RX7_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int8_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX8_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int8_2_enum, WCD9335_CDC_RX8_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum rx_hph_mode_mux_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(rx_hph_mode_mux_text),
+			    rx_hph_mode_mux_text);
+
 static int wcd9335_set_mix_interpolator_rate(struct snd_soc_dai *dai,
 					     int rate_val,
 					     u32 rate)
@@ -670,6 +795,237 @@ static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
 	},
 };
 
+static int wcd9335_get_compander(struct snd_kcontrol *kc,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	int comp = ((struct soc_mixer_control *)kc->private_value)->shift;
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+
+	ucontrol->value.integer.value[0] = wcd->comp_enabled[comp];
+	return 0;
+}
+
+static int wcd9335_set_compander(struct snd_kcontrol *kc,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	int comp = ((struct soc_mixer_control *) kc->private_value)->shift;
+	int value = ucontrol->value.integer.value[0];
+	int sel;
+
+	wcd->comp_enabled[comp] = value;
+	sel = value ? WCD9335_HPH_GAIN_SRC_SEL_COMPANDER :
+		WCD9335_HPH_GAIN_SRC_SEL_REGISTER;
+
+	/* Any specific register configuration for compander */
+	switch (comp) {
+	case COMPANDER_1:
+		/* Set Gain Source Select based on compander enable/disable */
+		snd_soc_component_update_bits(component, WCD9335_HPH_L_EN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	case COMPANDER_2:
+		snd_soc_component_update_bits(component, WCD9335_HPH_R_EN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	case COMPANDER_5:
+		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO3_GAIN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	case COMPANDER_6:
+		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO4_GAIN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	default:
+		break;
+	};
+
+	return 0;
+}
+
+static int wcd9335_rx_hph_mode_get(struct snd_kcontrol *kc,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+
+	ucontrol->value.enumerated.item[0] = wcd->hph_mode;
+
+	return 0;
+}
+
+static int wcd9335_rx_hph_mode_put(struct snd_kcontrol *kc,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	u32 mode_val;
+
+	mode_val = ucontrol->value.enumerated.item[0];
+
+	if (mode_val == 0) {
+		dev_err(wcd->dev, "Invalid HPH Mode, default to ClSH HiFi\n");
+		mode_val = CLS_H_HIFI;
+	}
+	wcd->hph_mode = mode_val;
+
+	return 0;
+}
+
+static int wcd9335_ear_pa_gain_get(struct snd_kcontrol *kc,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	int ear_pa_gain;
+
+	ear_pa_gain = snd_soc_component_read32(component, WCD9335_ANA_EAR);
+	ear_pa_gain = (ear_pa_gain & 0x70) >> 4;
+	ucontrol->value.enumerated.item[0] = ear_pa_gain;
+
+	return 0;
+}
+
+static int wcd9335_ear_pa_gain_put(struct snd_kcontrol *kc,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	u8 ear_pa_gain;
+
+	ear_pa_gain =  ucontrol->value.enumerated.item[0] << 4;
+	snd_soc_component_update_bits(component, WCD9335_ANA_EAR,
+					0x70, ear_pa_gain);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new wcd9335_snd_controls[] = {
+	/* -84dB min - 40dB max */
+	SOC_SINGLE_SX_TLV("RX0 Digital Volume", WCD9335_CDC_RX0_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX1 Digital Volume", WCD9335_CDC_RX1_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX2 Digital Volume", WCD9335_CDC_RX2_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX3 Digital Volume", WCD9335_CDC_RX3_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX4 Digital Volume", WCD9335_CDC_RX4_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX5 Digital Volume", WCD9335_CDC_RX5_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX6 Digital Volume", WCD9335_CDC_RX6_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX7 Digital Volume", WCD9335_CDC_RX7_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX8 Digital Volume", WCD9335_CDC_RX8_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX0 Mix Digital Volume",
+			  WCD9335_CDC_RX0_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX1 Mix Digital Volume",
+			  WCD9335_CDC_RX1_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX2 Mix Digital Volume",
+			  WCD9335_CDC_RX2_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX3 Mix Digital Volume",
+			  WCD9335_CDC_RX3_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX4 Mix Digital Volume",
+			  WCD9335_CDC_RX4_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX5 Mix Digital Volume",
+			  WCD9335_CDC_RX5_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX6 Mix Digital Volume",
+			  WCD9335_CDC_RX6_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX7 Mix Digital Volume",
+			  WCD9335_CDC_RX7_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX8 Mix Digital Volume",
+			  WCD9335_CDC_RX8_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_ENUM("RX INT0_1 HPF cut off", cf_int0_1_enum),
+	SOC_ENUM("RX INT0_2 HPF cut off", cf_int0_2_enum),
+	SOC_ENUM("RX INT1_1 HPF cut off", cf_int1_1_enum),
+	SOC_ENUM("RX INT1_2 HPF cut off", cf_int1_2_enum),
+	SOC_ENUM("RX INT2_1 HPF cut off", cf_int2_1_enum),
+	SOC_ENUM("RX INT2_2 HPF cut off", cf_int2_2_enum),
+	SOC_ENUM("RX INT3_1 HPF cut off", cf_int3_1_enum),
+	SOC_ENUM("RX INT3_2 HPF cut off", cf_int3_2_enum),
+	SOC_ENUM("RX INT4_1 HPF cut off", cf_int4_1_enum),
+	SOC_ENUM("RX INT4_2 HPF cut off", cf_int4_2_enum),
+	SOC_ENUM("RX INT5_1 HPF cut off", cf_int5_1_enum),
+	SOC_ENUM("RX INT5_2 HPF cut off", cf_int5_2_enum),
+	SOC_ENUM("RX INT6_1 HPF cut off", cf_int6_1_enum),
+	SOC_ENUM("RX INT6_2 HPF cut off", cf_int6_2_enum),
+	SOC_ENUM("RX INT7_1 HPF cut off", cf_int7_1_enum),
+	SOC_ENUM("RX INT7_2 HPF cut off", cf_int7_2_enum),
+	SOC_ENUM("RX INT8_1 HPF cut off", cf_int8_1_enum),
+	SOC_ENUM("RX INT8_2 HPF cut off", cf_int8_2_enum),
+	SOC_SINGLE_EXT("COMP1 Switch", SND_SOC_NOPM, COMPANDER_1, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP2 Switch", SND_SOC_NOPM, COMPANDER_2, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP3 Switch", SND_SOC_NOPM, COMPANDER_3, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP4 Switch", SND_SOC_NOPM, COMPANDER_4, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP5 Switch", SND_SOC_NOPM, COMPANDER_5, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP6 Switch", SND_SOC_NOPM, COMPANDER_6, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP7 Switch", SND_SOC_NOPM, COMPANDER_7, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP8 Switch", SND_SOC_NOPM, COMPANDER_8, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
+		       wcd9335_rx_hph_mode_get, wcd9335_rx_hph_mode_put),
+
+	/* Gain Controls */
+	SOC_ENUM_EXT("EAR PA Gain", wcd9335_ear_pa_gain_enum,
+		wcd9335_ear_pa_gain_get, wcd9335_ear_pa_gain_put),
+
+	SOC_SINGLE_TLV("HPHL Volume", WCD9335_HPH_L_EN, 0, 20, 1,
+		line_gain),
+	SOC_SINGLE_TLV("HPHR Volume", WCD9335_HPH_R_EN, 0, 20, 1,
+		line_gain),
+	SOC_SINGLE_TLV("LINEOUT1 Volume", WCD9335_DIFF_LO_LO1_COMPANDER,
+			3, 16, 1, line_gain),
+	SOC_SINGLE_TLV("LINEOUT2 Volume", WCD9335_DIFF_LO_LO2_COMPANDER,
+			3, 16, 1, line_gain),
+	SOC_SINGLE_TLV("LINEOUT3 Volume", WCD9335_SE_LO_LO3_GAIN, 0, 20, 1,
+			line_gain),
+	SOC_SINGLE_TLV("LINEOUT4 Volume", WCD9335_SE_LO_LO4_GAIN, 0, 20, 1,
+			line_gain),
+
+	SOC_SINGLE_TLV("ADC1 Volume", WCD9335_ANA_AMIC1, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC2 Volume", WCD9335_ANA_AMIC2, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC3 Volume", WCD9335_ANA_AMIC3, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC4 Volume", WCD9335_ANA_AMIC4, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC5 Volume", WCD9335_ANA_AMIC5, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC6 Volume", WCD9335_ANA_AMIC6, 0, 20, 0,
+			analog_gain),
+
+	SOC_ENUM("TX0 HPF cut off", cf_dec0_enum),
+	SOC_ENUM("TX1 HPF cut off", cf_dec1_enum),
+	SOC_ENUM("TX2 HPF cut off", cf_dec2_enum),
+	SOC_ENUM("TX3 HPF cut off", cf_dec3_enum),
+	SOC_ENUM("TX4 HPF cut off", cf_dec4_enum),
+	SOC_ENUM("TX5 HPF cut off", cf_dec5_enum),
+	SOC_ENUM("TX6 HPF cut off", cf_dec6_enum),
+	SOC_ENUM("TX7 HPF cut off", cf_dec7_enum),
+	SOC_ENUM("TX8 HPF cut off", cf_dec8_enum),
+};
+
 static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
 {
 	struct wcd9335_codec *wcd = data;
@@ -1119,6 +1475,8 @@ static const struct snd_soc_component_driver wcd9335_component_drv = {
 	.probe = wcd9335_codec_probe,
 	.remove = wcd9335_codec_remove,
 	.set_sysclk = wcd9335_codec_set_sysclk,
+	.controls = wcd9335_snd_controls,
+	.num_controls = ARRAY_SIZE(wcd9335_snd_controls),
 };
 
 static int wcd9335_probe(struct platform_device *pdev)
-- 
2.16.2

