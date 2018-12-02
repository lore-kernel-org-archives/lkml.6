Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD95DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A012082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFWal4Nx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A012082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLBVYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:24:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33123 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbeLBVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:23:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so10155763wrr.0;
        Sun, 02 Dec 2018 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-transfer-encoding;
        bh=HWZokPuBdYpzFsee6/QVIVgo3x19zZKXHjpnQDK1wdY=;
        b=GFWal4NxLSPfHE0c1YIRgRX5iebLopsW7L47FAJ0FkdEV37Dus7YVdP2CqFe77JPNn
         dtqxwbt14AAgiurqQozeN25JAWIzSR7dMDb+tYGA+zZwkI1psEhkbdnIXe4szi1Z3Oeb
         kDoguk1Icj3vNFztpj2Mnbe8P7e5XLFbH9/Ajyads2mtS+2vw1fI1PSz5JaCPz6vZOkc
         CD4b6bRivWa+hvB2ayUnu3i2uxqXf1FsOWBdeVu5aI6E15PIJBqWUrFYm6qMLQFVXx4x
         C2bELMA4CC5v9CQRqFeND0albeLGzb9pBAS3b9OSSutGHM4Xj/xtzKe38+u+i4b3inL1
         3Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:references:content-transfer-encoding;
        bh=HWZokPuBdYpzFsee6/QVIVgo3x19zZKXHjpnQDK1wdY=;
        b=JT/QLit3cjUj9t6OlRmzYuDwZQkUSvVCDN5lAaUcLebMi7C0h/QNJVGmpLEC0DgHxW
         xsprkDOQzuw6IEfPRrAnyV75WPyGlqiGouWaqnCRy1qm5KzgPZZz1MiE7zF6dhvVZ+cC
         u2iM1oP6jSj7bEoxK7cl5xyuEqN0Q4aE7WX3nfiHndE0WwCU4/0WP4IEN/VBzBWt4l14
         EKGyP2d2VcBzXS2OBeJieKMgFiR3PJoWwp2Eme9DMAGMu0feIBrLxakc7vxW1zUwa4CN
         vngG7YD50ODWbXpHpWvt6Mj0UgkBfiLksKSAeqROH1znMGVuC02QhWkHi2RtlymRWBZP
         Rsng==
X-Gm-Message-State: AA+aEWbFj8XnhU6U30omc53F/NMtxT0opjw6x6bM6LVTdtaAhZCfxHh/
        lMO/+m6+HWjar9Hajs/MH0/VEHt22fk=
X-Google-Smtp-Source: AFSGD/Wv5rIm9DizyoW1DTtVer/sgByGEvCy8rOCnkleZtCg+rwupuqeYzLEtXWv+dDNaeUw9QwwsA==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr11958713wrc.168.1543785824340;
        Sun, 02 Dec 2018 13:23:44 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 13:23:43 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 08/10] ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
Date:   Mon,  3 Dec 2018 00:23:15 +0300
Message-Id: <697a9cb417b6d77080ebf7ca2fc5b2dc216ce953.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner suniv F1C100s has similar but primitive audio codec
comparared to sun4i. Add support for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 358 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 358 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 7a9f84e..08a3cb0 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -4,6 +4,7 @@
  * Copyright 2015 Maxime Ripard <maxime.ripard@free-electrons.com>
  * Copyright 2015 Adam Sampson <ats@offog.org>
  * Copyright 2016 Chen-Yu Tsai <wens@csie.org>
+ * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
  *
  * Based on the Allwinner SDK driver, released under the GPL.
  *
@@ -226,6 +227,62 @@
 
 #define SUN4I_DMA_MAX_BURST			(8)
 
+/* suniv specific registers */
+
+#define SUNIV_DMA_MAX_BURST			(4)
+
+/* Codec DAC digital controls and FIFO registers */
+#define SUNIV_CODEC_ADC_FIFOC			(0x10)
+#define SUNIV_CODEC_ADC_FIFOC_EN_AD		(28)
+#define SUNIV_CODEC_ADC_FIFOS			(0x14)
+#define SUNIV_CODEC_ADC_RXDATA			(0x18)
+
+/* Output mixer and gain controls */
+#define SUNIV_CODEC_OM_DACA_CTRL			(0x20)
+#define SUNIV_CODEC_OM_DACA_CTRL_DACAREN		(31)
+#define SUNIV_CODEC_OM_DACA_CTRL_DACALEN		(30)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXEN			(29)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXEN			(28)
+#define SUNIV_CODEC_OM_DACA_CTRL_RHPPAMUTE		(27)
+#define SUNIV_CODEC_OM_DACA_CTRL_LHPPAMUTE		(26)
+#define SUNIV_CODEC_OM_DACA_CTRL_RHPIS			(25)
+#define SUNIV_CODEC_OM_DACA_CTRL_LHPIS			(24)
+#define SUNIV_CODEC_OM_DACA_CTRL_HPCOM_CTL		(22)
+#define SUNIV_CODEC_OM_DACA_CTRL_COMPTEN		(21)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_MICIN		(20)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LINEIN	(19)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_FMIN		(18)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_RDAC		(17)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LDAC		(16)
+#define SUNIV_CODEC_OM_DACA_CTRL_HPPAEN			(15)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_MICIN		(12)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LINEIN	(11)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_FMIN		(10)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LDAC		(9)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_RDAC		(8)
+#define SUNIV_CODEC_OM_DACA_CTRL_LTLNMUTE		(7)
+#define SUNIV_CODEC_OM_DACA_CTRL_RTLNMUTE		(6)
+#define SUNIV_CODEC_OM_DACA_CTRL_HPVOL			(0)
+
+/* Analog Input Mixer controls */
+#define SUNIV_CODEC_ADC_ACTL		(0x24)
+#define SUNIV_CODEC_ADC_ADCEN		(31)
+#define SUNIV_CODEC_ADC_MICG		(24)
+#define SUNIV_CODEC_ADC_LINEINVOL	(21)
+#define SUNIV_CODEC_ADC_ADCG		(16)
+#define SUNIV_CODEC_ADC_ADCMIX_MIC	(13)
+#define SUNIV_CODEC_ADC_ADCMIX_FMINL	(12)
+#define SUNIV_CODEC_ADC_ADCMIX_FMINR	(11)
+#define SUNIV_CODEC_ADC_ADCMIX_LINEIN	(10)
+#define SUNIV_CODEC_ADC_ADCMIX_LOUT	(9)
+#define SUNIV_CODEC_ADC_ADCMIX_ROUT	(8)
+#define SUNIV_CODEC_ADC_PASPEEDSELECT	(7)
+#define SUNIV_CODEC_ADC_FMINVOL		(4)
+#define SUNIV_CODEC_ADC_MICAMPEN	(3)
+#define SUNIV_CODEC_ADC_MICBOOST	(0)
+
+#define SUNIV_CODEC_ADC_DBG		(0x4c)
+
 struct sun4i_codec {
 	struct device	*dev;
 	struct regmap	*regmap;
@@ -1143,6 +1200,233 @@ static const struct snd_soc_component_driver sun8i_a23_codec_codec = {
 	.non_legacy_dai_naming	= 1,
 };
 
+/*suniv F1C100s codec */
+
+/* headphone controls */
+static const char * const suniv_codec_hp_src_enum_text[] = {
+	"DAC", "Mixer",
+};
+
+static SOC_ENUM_DOUBLE_DECL(suniv_codec_hp_src_enum,
+			    SUNIV_CODEC_OM_DACA_CTRL,
+			    SUNIV_CODEC_OM_DACA_CTRL_LHPIS,
+			    SUNIV_CODEC_OM_DACA_CTRL_RHPIS,
+			    suniv_codec_hp_src_enum_text);
+
+static const struct snd_kcontrol_new suniv_codec_hp_src[] = {
+	SOC_DAPM_ENUM("Headphone Source Playback Route",
+		      suniv_codec_hp_src_enum),
+};
+
+
+/* mixer controls */
+static const struct snd_kcontrol_new suniv_codec_adc_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Right Out Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_ROUT, 1, 0),
+	SOC_DAPM_SINGLE("Left Out Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_LOUT, 1, 0),
+	SOC_DAPM_SINGLE("Line In Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_LINEIN, 1, 0),
+	SOC_DAPM_SINGLE("Right FM In Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_FMINR, 1, 0),
+	SOC_DAPM_SINGLE("Left FM In Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_FMINL, 1, 0),
+	SOC_DAPM_SINGLE("Mic Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_MIC, 1, 0),
+};
+
+static const struct snd_kcontrol_new suniv_codec_dac_lmixer_controls[] = {
+	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_RDAC, 1, 0),
+	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LDAC, 1, 0),
+	SOC_DAPM_SINGLE("FM In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_FMIN, 1, 0),
+	SOC_DAPM_SINGLE("Line In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LINEIN, 1, 0),
+	SOC_DAPM_SINGLE("Mic In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_MICIN, 1, 0),
+};
+
+static const struct snd_kcontrol_new suniv_codec_dac_rmixer_controls[] = {
+	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LDAC, 1, 0),
+	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_RDAC, 1, 0),
+	SOC_DAPM_SINGLE("FM In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_FMIN, 1, 0),
+	SOC_DAPM_SINGLE("Line In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LINEIN, 1, 0),
+	SOC_DAPM_SINGLE("Mic In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_MICIN, 1, 0),
+};
+
+
+static const DECLARE_TLV_DB_SCALE(suniv_codec_dvol_scale, -7308, 116, 0);
+static const DECLARE_TLV_DB_SCALE(suniv_codec_hp_vol_scale, -6300, 100, 1);
+static const DECLARE_TLV_DB_SCALE(suniv_codec_out_mixer_pregain_scale,
+				  -450, 150, 0);
+
+static const DECLARE_TLV_DB_RANGE(suniv_codec_mic_gain_scale,
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0),
+);
+
+
+static const struct snd_kcontrol_new suniv_codec_codec_widgets[] = {
+	SOC_SINGLE_TLV("DAC Playback Volume", SUN4I_CODEC_DAC_DPC,
+		       SUN4I_CODEC_DAC_DPC_DVOL, 0x3f, 1,
+		       suniv_codec_dvol_scale),
+	SOC_SINGLE_TLV("Headphone Playback Volume",
+		       SUNIV_CODEC_OM_DACA_CTRL,
+		       SUNIV_CODEC_OM_DACA_CTRL_HPVOL, 0x3f, 0,
+		       suniv_codec_hp_vol_scale),
+	SOC_DOUBLE("Headphone Playback Switch",
+		   SUNIV_CODEC_OM_DACA_CTRL,
+		   SUNIV_CODEC_OM_DACA_CTRL_LHPPAMUTE,
+		   SUNIV_CODEC_OM_DACA_CTRL_RHPPAMUTE, 1, 0),
+	SOC_SINGLE_TLV("Line In Playback Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_LINEINVOL,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+	SOC_SINGLE_TLV("FM In Playback Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_FMINVOL,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+	SOC_SINGLE_TLV("Mic In Playback Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_MICG,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+
+	/* Microphone Amp boost gains */
+	SOC_SINGLE_TLV("Mic Boost Volume", SUNIV_CODEC_ADC_ACTL,
+		       SUNIV_CODEC_ADC_MICBOOST, 0x7, 0,
+		       suniv_codec_mic_gain_scale),
+	SOC_SINGLE_TLV("ADC Capture Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_ADCG,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+};
+
+static const struct snd_soc_dapm_widget suniv_codec_codec_dapm_widgets[] = {
+	/* Microphone inputs */
+	SND_SOC_DAPM_INPUT("MIC"),
+
+	/* Microphone Bias */
+	/* deleted: HBIAS, MBIAS */
+
+	/* Mic input path */
+	SND_SOC_DAPM_PGA("Mic Amplifier", SUNIV_CODEC_ADC_ACTL,
+			 SUNIV_CODEC_ADC_MICAMPEN, 0, NULL, 0),
+
+	/* Line In */
+	SND_SOC_DAPM_INPUT("LINEIN"),
+
+	/* FM In */
+	SND_SOC_DAPM_INPUT("FMINR"),
+	SND_SOC_DAPM_INPUT("FMINL"),
+
+	/* Digital parts of the ADCs */
+	SND_SOC_DAPM_SUPPLY("ADC Enable", SUNIV_CODEC_ADC_FIFOC,
+			    SUNIV_CODEC_ADC_FIFOC_EN_AD, 0,
+			    NULL, 0),
+
+	/* Analog parts of the ADCs */
+	SND_SOC_DAPM_ADC("ADC", "Codec Capture", SUNIV_CODEC_ADC_ACTL,
+			 SUNIV_CODEC_ADC_ADCEN, 0),
+
+	/* ADC Mixers */
+	SOC_MIXER_ARRAY("ADC Mixer", SUNIV_CODEC_ADC_ACTL,
+			 SND_SOC_NOPM, 0,
+			 suniv_codec_adc_mixer_controls),
+
+	/* Digital parts of the DACs */
+	SND_SOC_DAPM_SUPPLY("DAC Enable", SUN4I_CODEC_DAC_DPC,
+			    SUN4I_CODEC_DAC_DPC_EN_DA, 0,
+			    NULL, 0),
+
+	/* Analog parts of the DACs */
+	SND_SOC_DAPM_DAC("Left DAC", "Codec Playback",
+			 SUNIV_CODEC_OM_DACA_CTRL,
+			 SUNIV_CODEC_OM_DACA_CTRL_DACALEN, 0),
+	SND_SOC_DAPM_DAC("Right DAC", "Codec Playback",
+			 SUNIV_CODEC_OM_DACA_CTRL,
+			 SUNIV_CODEC_OM_DACA_CTRL_DACAREN, 0),
+
+	/* Mixers */
+	SOC_MIXER_ARRAY("Left Mixer", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXEN, 0,
+			suniv_codec_dac_lmixer_controls),
+	SOC_MIXER_ARRAY("Right Mixer", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXEN, 0,
+			suniv_codec_dac_rmixer_controls),
+
+	/* Headphone output path */
+	SND_SOC_DAPM_MUX("Headphone Source Playback Route",
+			 SND_SOC_NOPM, 0, 0, suniv_codec_hp_src),
+	SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUNIV_CODEC_OM_DACA_CTRL,
+			     SUNIV_CODEC_OM_DACA_CTRL_HPPAEN, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("HPCOM Protection", SUNIV_CODEC_OM_DACA_CTRL,
+			    SUNIV_CODEC_OM_DACA_CTRL_COMPTEN, 0, NULL, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_supply, "HPCOM", SUNIV_CODEC_OM_DACA_CTRL,
+			 SUNIV_CODEC_OM_DACA_CTRL_HPCOM_CTL, 0x3, 0x3, 0),
+	SND_SOC_DAPM_OUTPUT("HP"),
+};
+
+static const struct snd_soc_dapm_route suniv_codec_codec_dapm_routes[] = {
+	/* DAC Routes */
+	{ "Left DAC", NULL, "DAC Enable" },
+	{ "Right DAC", NULL, "DAC Enable" },
+
+	/* Microphone Routes */
+	{ "Mic Amplifier", NULL, "MIC"},
+
+	/* Left Mixer Routes */
+	{ "Left Mixer", "Right DAC Playback Switch", "Right DAC" },
+	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "FM In Playback Switch", "FMINL" },
+	{ "Left Mixer", "Line In Playback Switch", "LINEIN" },
+	{ "Left Mixer", "Mic In Playback Switch", "Mic Amplifier" },
+
+	/* Right Mixer Routes */
+	{ "Right Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Right Mixer", "Right DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "FM In Playback Switch", "FMINR" },
+	{ "Right Mixer", "Line In Playback Switch", "LINEIN" },
+	{ "Right Mixer", "Mic In Playback Switch", "Mic Amplifier" },
+
+	/* ADC Mixer Routes */
+	{ "ADC Mixer", "Right Out Capture Switch", "Right Mixer" },
+	{ "ADC Mixer", "Left Out Capture Switch", "Left Mixer" },
+	{ "ADC Mixer", "Line In Capture Switch", "LINEIN" },
+	{ "ADC Mixer", "Right FM In Capture Switch", "FMINR" },
+	{ "ADC Mixer", "Left FM In Capture Switch", "FMINL" },
+	{ "ADC Mixer", "Mic Capture Switch", "Mic Amplifier" },
+
+	/* Headphone Routes */
+	{ "Headphone Source Playback Route", "DAC", "Left DAC" },
+	{ "Headphone Source Playback Route", "DAC", "Right DAC" },
+	{ "Headphone Source Playback Route", "Mixer", "Left Mixer" },
+	{ "Headphone Source Playback Route", "Mixer", "Right Mixer" },
+	{ "Headphone Amp", NULL, "Headphone Source Playback Route" },
+	{ "HP", NULL, "Headphone Amp" },
+	{ "HPCOM", NULL, "HPCOM Protection" },
+
+	/* ADC Routes */
+	{ "ADC", NULL, "ADC Mixer" },
+	{ "ADC", NULL, "ADC Enable" },
+};
+
+static const struct snd_soc_component_driver suniv_codec_codec = {
+	.controls		= suniv_codec_codec_widgets,
+	.num_controls		= ARRAY_SIZE(suniv_codec_codec_widgets),
+	.dapm_widgets		= suniv_codec_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(suniv_codec_codec_dapm_widgets),
+	.dapm_routes		= suniv_codec_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(suniv_codec_codec_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+
 static const struct snd_soc_component_driver sun4i_codec_component = {
 	.name = "sun4i-codec",
 };
@@ -1414,6 +1698,57 @@ static struct snd_soc_card *sun8i_v3s_codec_create_card(struct device *dev)
 	return card;
 };
 
+static const struct snd_soc_dapm_widget suniv_codec_card_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_LINE("Right FM In", NULL),
+	SND_SOC_DAPM_LINE("Left FM In", NULL),
+	SND_SOC_DAPM_MIC("Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", sun4i_codec_spk_event),
+};
+
+/* Connect digital side enables to analog side widgets */
+static const struct snd_soc_dapm_route suniv_codec_card_routes[] = {
+	/* ADC Routes */
+	{ "ADC", NULL, "ADC Enable" },
+	{ "Codec Capture", NULL, "ADC" },
+
+	/* DAC Routes */
+	{ "Left DAC", NULL, "DAC Enable" },
+	{ "Right DAC", NULL, "DAC Enable" },
+	{ "Left DAC", NULL, "Codec Playback" },
+	{ "Right DAC", NULL, "Codec Playback" },
+};
+
+
+static struct snd_soc_card *suniv_codec_create_card(struct device *dev)
+{
+	struct snd_soc_card *card;
+	int ret;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return ERR_PTR(-ENOMEM);
+
+	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
+	if (!card->dai_link)
+		return ERR_PTR(-ENOMEM);
+
+	card->dev		= dev;
+	card->name		= "F1C100s Audio Codec";
+	card->dapm_widgets	= suniv_codec_card_dapm_widgets;
+	card->num_dapm_widgets	= ARRAY_SIZE(suniv_codec_card_dapm_widgets);
+	card->dapm_routes	= suniv_codec_card_routes;
+	card->num_dapm_routes	= ARRAY_SIZE(suniv_codec_card_routes);
+	card->fully_routed	= true;
+
+	ret = snd_soc_of_parse_audio_routing(card, "allwinner,audio-routing");
+	if (ret)
+		dev_warn(dev, "failed to parse audio-routing: %d\n", ret);
+
+	return card;
+};
+
 static const struct regmap_config sun4i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1456,6 +1791,13 @@ static const struct regmap_config sun8i_v3s_codec_regmap_config = {
 	.max_register	= SUN8I_H3_CODEC_ADC_DBG,
 };
 
+static const struct regmap_config suniv_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUNIV_CODEC_ADC_DBG,
+};
+
 struct sun4i_codec_quirks {
 	const struct regmap_config *regmap_config;
 	const struct snd_soc_component_driver *codec;
@@ -1540,6 +1882,17 @@ static const struct sun4i_codec_quirks sun8i_v3s_codec_quirks = {
 	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
+static const struct sun4i_codec_quirks suniv_f1c100s_codec_quirks = {
+	.regmap_config	= &suniv_codec_regmap_config,
+	.codec		= &suniv_codec_codec,
+	.create_card	= suniv_codec_create_card,
+	.reg_adc_fifoc	= REG_FIELD(SUNIV_CODEC_ADC_FIFOC, 0, 31),
+	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
+	.reg_adc_rxdata	= SUNIV_CODEC_ADC_RXDATA,
+	.has_reset	= true,
+	.dma_max_burst	= SUNIV_DMA_MAX_BURST,
+};
+
 static const struct of_device_id sun4i_codec_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-codec",
@@ -1565,6 +1918,10 @@ static const struct of_device_id sun4i_codec_of_match[] = {
 		.compatible = "allwinner,sun8i-v3s-codec",
 		.data = &sun8i_v3s_codec_quirks,
 	},
+	{
+		.compatible = "allwinner,suniv-f1c100s-codec",
+		.data = &suniv_f1c100s_codec_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
@@ -1746,4 +2103,5 @@ MODULE_AUTHOR("Emilio López <emilio@elopez.com.ar>");
 MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
 MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
+MODULE_AUTHOR("Mesih Kilinc <mesikilinc@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
2.7.4

