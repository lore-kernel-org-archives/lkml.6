Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0306AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFE7214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CiD7bZ/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFE7214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeIQGXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:23:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36109 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbeIQGXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:23:10 -0400
Received: by mail-io1-f68.google.com with SMTP id q5-v6so10131755iop.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 17:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t/yDYirAirVizch+KmvrazWXv+T2Dng6luS+zRdCtkk=;
        b=CiD7bZ/ozg8Ivjv90oGii0aWyP36dEYM6xD2rtfTA04CWXpifEDzAt9BelLgPUKPHV
         3nhBU1bViODiaMZrY1uUOdxA7qTi9ojk7bsox46zXVQaq8MYO8t4NVHJXYOv/abolL5w
         j1a37CXXcdkADL4aP9IRdMLj+PFXpra/CDxjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t/yDYirAirVizch+KmvrazWXv+T2Dng6luS+zRdCtkk=;
        b=smc0WESQ6nTcrnCvMOhy/33HhVgSmlRu1/ON+0yforD+G8KiVjAtWv24FJciCgKduv
         6QKlw03n1qf7Bm7SYZ2rxpTQOchua9jE8+8rBxYEPhD8iE+ygOssmPlRhhol/XXu7ljb
         v84YnIBlTUDviWByqinbKns2WyOYX05BlDLKggF4G3Kco6OLTnr8iltMAhWvwjGLmBx8
         5YHpW9QITaMn3kEFK3AtdBxIdvKAMdKx2BVnr9c0GbjDMQW+7vac7UNbbvZVnugGiGsp
         v6McSx9nBTgz0knRkgcvbn1OHYcA2BpL9I4ze0clKbOxeI2WZWPuBgNPpQFBcXY+5w1g
         AZGQ==
X-Gm-Message-State: APzg51AGZf8V227gAr5HRssbhvNEG5BHv6aUSpd39KB9xPN1oDw5k+Rt
        8l0Vq4NnPEfIhsjGrCe43I7TIg==
X-Google-Smtp-Source: ANB0Vdaql+ooKMVwuFqN58on2qE0t42lmvX7kvhzlBY4JPRu+220jJwD7W5zBZb0UqZlf3L+W4u9fw==
X-Received: by 2002:a5e:da49:: with SMTP id o9-v6mr18728422iop.215.1537145896371;
        Sun, 16 Sep 2018 17:58:16 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id f64-v6sm829972ite.4.2018.09.16.17.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 17:58:15 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 11/14] ASoC: wcd9335: add mbhc support
Date:   Sun, 16 Sep 2018 17:57:24 -0700
Message-Id: <20180917005727.32728-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 268 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 266 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index efbb698..6c95cff 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -11,6 +11,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <sound/jack.h>
 #include <linux/kernel.h>
 #include <linux/slimbus.h>
 #include <sound/soc.h>
@@ -89,12 +90,18 @@
 #define  CF_MIN_3DB_75HZ		0x1
 #define  CF_MIN_3DB_150HZ		0x2
 
+#define WCD9335_MBHC_MAX_BUTTONS	(8)
+
 #define WCD9335_SLIM_RX_CH(p) \
 	{.port = p + WCD9335_RX_START, .shift = p,}
 
 #define WCD9335_SLIM_TX_CH(p) \
 	{.port = p, .shift = p,}
 
+static int btn_mask = SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+	       SND_JACK_BTN_2 | SND_JACK_BTN_3 | SND_JACK_BTN_4;
+static int hs_jack_mask = SND_JACK_HEADPHONE | SND_JACK_HEADSET;
+
 /* vout step value */
 #define WCD9335_CALCULATE_VOUT_D(req_mv) (((req_mv - 650) * 10) / 25)
 
@@ -323,6 +330,16 @@ struct wcd9335_codec {
 	u32 num_rx_port;
 	u32 num_tx_port;
 
+	struct snd_soc_jack *jack;
+	bool hphl_jack_type_normally_open;
+	bool gnd_jack_type_normally_open;
+	bool	mbhc_btn_enabled;
+	int	mbhc_btn0_released;
+	bool	detect_accessory_type;
+	int	accessory_type;
+	/* Voltage threshold for button detection */
+	u32 vref_btn[WCD9335_MBHC_MAX_BUTTONS];
+
 	int sido_input_src;
 	enum wcd9335_sido_voltage sido_voltage;
 
@@ -2829,7 +2846,6 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		snd_soc_component_update_bits(comp, hpf_gate_reg, 0x01, 0x00);
-
 		if (decimator == 0) {
 			snd_soc_component_write(comp,
 					WCD9335_MBHC_ZDET_RAMP_CTL, 0x83);
@@ -2840,7 +2856,6 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
 			snd_soc_component_write(comp,
 					WCD9335_MBHC_ZDET_RAMP_CTL, 0x03);
 		}
-
 		snd_soc_component_update_bits(comp, hpf_gate_reg,
 						0x01, 0x01);
 		snd_soc_component_update_bits(comp, tx_vol_ctl_reg,
@@ -3988,6 +4003,131 @@ static int wcd9335_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
 	return ret;
 }
 
+static irqreturn_t wcd9335_mbhc_sw_irq(int irq, void *data)
+{
+	struct wcd9335_codec *wcd = data;
+	struct snd_soc_component *component = wcd->component;
+	bool ins = false;
+
+	if (snd_soc_component_read32(component, WCD9335_ANA_MBHC_MECH) &
+			WCD9335_MBHC_MECH_DETECT_TYPE_MASK)
+		ins = true;
+
+	/* Set the detection type appropriately */
+	snd_soc_component_update_bits(component, WCD9335_ANA_MBHC_MECH,
+			    WCD9335_MBHC_MECH_DETECT_TYPE_MASK,
+			    (!ins << WCD9335_MBHC_MECH_DETECT_TYPE_SHIFT));
+
+	if (ins) { /* hs insertion */
+		u32 btndet_curr_src;
+
+		/*
+		 * If no micbias is enabled, then enable 100uA internal
+		 * current source for Button detection
+		 */
+		if (snd_soc_component_read32(component, WCD9335_ANA_MICB2) &
+						WCD9335_ANA_MICB2_ENABLE)
+			btndet_curr_src = WCD9335_ANA_MBHC_BD_ISRC_OFF;
+		else
+			btndet_curr_src = WCD9335_ANA_MBHC_BD_ISRC_100UA;
+
+		snd_soc_component_update_bits(component,
+					WCD9335_ANA_MBHC_ELECT,
+					WCD9335_ANA_MBHC_BD_ISRC_CTL_MASK,
+					btndet_curr_src);
+
+		/*
+		 * if only a btn0 press event is receive just before
+		 * insert event then its a 3 pole headphone else if
+		 * both press and release event received then its
+		 * a headset.
+		 */
+		if (wcd->mbhc_btn0_released) {
+			snd_soc_jack_report(wcd->jack,
+					    SND_JACK_HEADSET, hs_jack_mask);
+			wcd->accessory_type = SND_JACK_HEADSET;
+		} else {
+			snd_soc_jack_report(wcd->jack,
+					    SND_JACK_HEADPHONE, hs_jack_mask);
+			wcd->accessory_type = SND_JACK_HEADPHONE;
+		}
+
+		wcd->detect_accessory_type = false;
+
+	} else { /* removal */
+		snd_soc_jack_report(wcd->jack, 0, hs_jack_mask);
+		wcd->detect_accessory_type = true;
+		wcd->mbhc_btn0_released = false;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t wcd9335_mbhc_btn_press_irq(int irq, void *data)
+{
+	struct wcd9335_codec *wcd = data;
+	struct snd_soc_component *comp = wcd->component;
+	u32 btn_result, result;
+
+	/* do not handle any button events for headset without buttons */
+	if (wcd->accessory_type == SND_JACK_HEADPHONE)
+		return IRQ_HANDLED;
+
+	result = snd_soc_component_read32(comp, WCD9335_ANA_MBHC_RESULT_3);
+	btn_result = result & WCD9335_MBHC_BTN_RESULT_MASK;
+
+	switch (btn_result) {
+	case 0xf:
+		snd_soc_jack_report(wcd->jack, SND_JACK_BTN_4, btn_mask);
+		break;
+	case 0x4:
+		snd_soc_jack_report(wcd->jack, SND_JACK_BTN_4, btn_mask);
+		break;
+	case 0x3:
+		snd_soc_jack_report(wcd->jack, SND_JACK_BTN_3, btn_mask);
+		break;
+	case 0x2:
+		snd_soc_jack_report(wcd->jack, SND_JACK_BTN_2, btn_mask);
+		break;
+	case 0x1:
+		snd_soc_jack_report(wcd->jack, SND_JACK_BTN_1, btn_mask);
+		break;
+	case 0x0:
+		/* handle BTN_0 specially for type detection */
+		if (!wcd->detect_accessory_type)
+			snd_soc_jack_report(wcd->jack,
+					    SND_JACK_BTN_0, btn_mask);
+		break;
+	default:
+		dev_err(comp->dev,
+			"Unexpected button press result (%x)", btn_result);
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t wcd9335_mbhc_bt_rel_irq(int irq, void *data)
+{
+	struct wcd9335_codec *wcd = data;
+
+
+	if (wcd->detect_accessory_type) {
+		u32 result = snd_soc_component_read32(wcd->component,
+						WCD9335_ANA_MBHC_RESULT_3);
+
+		/* check if its BTN0 thats released */
+		if (!(result & WCD9335_MBHC_BTN_RESULT_MASK))
+			wcd->mbhc_btn0_released = true;
+
+	} else {
+		if (wcd->accessory_type != SND_JACK_HEADPHONE)
+			snd_soc_jack_report(wcd->jack, 0, btn_mask);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
 {
 	struct wcd9335_codec *wcd = data;
@@ -4057,11 +4197,95 @@ static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void wcd9335_program_btn_threshold(struct wcd9335_codec *wcd)
+{
+	int i, vth;
+
+	for (i = 0; i < WCD9335_MBHC_MAX_BUTTONS; i++) {
+		vth = ((wcd->vref_btn[i] * 2) / 25) & 0x3F;
+		snd_soc_component_update_bits(wcd->component,
+					WCD9335_ANA_MBHC_BTN0 + i,
+					0xFC, vth << 2);
+	}
+}
+
+static void wcd9335_mbhc_initialise(struct wcd9335_codec *wcd)
+{
+	struct snd_soc_component *comp = wcd->component;
+	u32 plug_type = 0;
+
+	snd_soc_component_update_bits(comp, WCD9335_MBHC_PLUG_DETECT_CTL,
+			WCD9335_MBHC_HSDET_PULLUP_CTL_MASK,
+			WCD9335_MBHC_HSDET_PULLUP_CTL_1_2P0_UA);
+
+	if (wcd->hphl_jack_type_normally_open)
+		plug_type |= WCD9335_MBHC_HPHL_PLUG_TYPE_NO;
+
+	if (wcd->gnd_jack_type_normally_open)
+		plug_type |= WCD9335_MBHC_GND_PLUG_TYPE_NO;
+
+	snd_soc_component_write(wcd->component, WCD9335_ANA_MBHC_MECH,
+			plug_type |
+			WCD9335_MBHC_L_DET_EN |
+			WCD9335_MBHC_HSL_PULLUP_COMP_EN |
+			WCD9335_MBHC_HPHL_100K_TO_GND_EN);
+
+	/* Insertion debounce set to 96ms */
+	snd_soc_component_write(wcd->component,
+			WCD9335_MBHC_PLUG_DETECT_CTL,
+			WCD9335_MBHC_DBNC_TIMER_INSREM_DBNC_T_96_MS|
+			WCD9335_MBHC_HSDET_PULLUP_CTL_1_2P0_UA);
+	/* Button Debounce set to 16ms */
+	snd_soc_component_update_bits(wcd->component, WCD9335_MBHC_CTL_1,
+			WCD9335_MBHC_BTN_DBNC_MASK,
+			WCD9335_MBHC_BTN_DBNC_T_16_MS);
+
+	/* enable bias distribution control */
+	snd_soc_component_update_bits(comp, WCD9335_ANA_MBHC_ELECT,
+				WCD9335_ANA_MBHC_BIAS_EN_MASK,
+				WCD9335_ANA_MBHC_BIAS_EN);
+
+	snd_soc_component_update_bits(wcd->component,
+				WCD9335_ANA_MBHC_ELECT,
+				WCD9335_ANA_MBHC_BD_ISRC_CTL_MASK,
+				WCD9335_ANA_MBHC_BD_ISRC_100UA);
+
+	/* enable MBHC clock */
+	snd_soc_component_update_bits(wcd->component, WCD9335_MBHC_CTL_1,
+			WCD9335_MBHC_CTL_RCO_EN_MASK,
+			WCD9335_MBHC_CTL_RCO_EN);
+
+	snd_soc_component_update_bits(wcd->component, WCD9335_MBHC_CTL_2,
+			WCD9335_MBHC_HS_VREF_CTL_MASK,
+			WCD9335_MBHC_HS_VREF_1P5_V);
+
+	/* program HS_VREF value */
+	wcd9335_program_btn_threshold(wcd);
+	/* Start FSM */
+	snd_soc_component_update_bits(wcd->component, WCD9335_ANA_MBHC_ELECT,
+			BIT(7), BIT(7));
+
+	wcd->mbhc_btn0_released = false;
+	wcd->detect_accessory_type = true;
+}
+
 static struct wcd9335_irq wcd9335_irqs[] = {
 	{
 		.irq = WCD9335_IRQ_SLIMBUS,
 		.handler = wcd9335_slimbus_irq,
 		.name = "SLIM Slave",
+	}, {
+		.irq = WCD9335_IRQ_MBHC_SW_DET,
+		.handler = wcd9335_mbhc_sw_irq,
+		.name = "Headset Mech Insert Removal",
+	}, {
+		.irq = WCD9335_IRQ_MBHC_BUTTON_PRESS_DET,
+		.handler = wcd9335_mbhc_btn_press_irq,
+		.name = "Headset Button Press",
+	}, {
+		.irq = WCD9335_IRQ_MBHC_BUTTON_RELEASE_DET,
+		.handler = wcd9335_mbhc_bt_rel_irq,
+		.name = "Headset Button Release",
 	},
 };
 
@@ -4859,6 +5083,7 @@ static void wcd9335_codec_init(struct snd_soc_component *component)
 					wcd9335_codec_reg_init[i].val);
 
 	wcd9335_enable_efuse_sensing(component);
+	wcd9335_mbhc_initialise(wcd);
 }
 
 static int wcd9335_codec_probe(struct snd_soc_component *component)
@@ -4914,10 +5139,21 @@ static int wcd9335_codec_set_sysclk(struct snd_soc_component *comp,
 	return clk_set_rate(wcd->mclk, freq);
 }
 
+static int wcd9335_codec_set_jack(struct snd_soc_component *comp,
+				  struct snd_soc_jack *jack, void *data)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
+
+	wcd->jack = jack;
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver wcd9335_component_drv = {
 	.probe = wcd9335_codec_probe,
 	.remove = wcd9335_codec_remove,
 	.set_sysclk = wcd9335_codec_set_sysclk,
+	.set_jack = wcd9335_codec_set_jack,
 	.controls = wcd9335_snd_controls,
 	.num_controls = ARRAY_SIZE(wcd9335_snd_controls),
 	.dapm_widgets = wcd9335_dapm_widgets,
@@ -4926,6 +5162,33 @@ static const struct snd_soc_component_driver wcd9335_component_drv = {
 	.num_dapm_routes = ARRAY_SIZE(wcd9335_audio_map),
 };
 
+static void of_parse_mbhc_data(struct device *dev, struct wcd9335_codec *wcd)
+{
+	int rval;
+
+	if (of_property_read_bool(dev->of_node,
+				  "qcom,hphl-jack-type-normally-open"))
+		wcd->hphl_jack_type_normally_open = true;
+	else
+		wcd->hphl_jack_type_normally_open = false;
+
+	if (of_property_read_bool(dev->of_node,
+				  "qcom,gnd-jack-type-normally-open"))
+		wcd->gnd_jack_type_normally_open = true;
+	else
+		wcd->gnd_jack_type_normally_open = false;
+
+	wcd->mbhc_btn_enabled = true;
+	rval = of_property_read_u32_array(dev->of_node,
+					  "qcom,mbhc-vthreshold",
+					  &wcd->vref_btn[0],
+					  WCD9335_MBHC_MAX_BUTTONS);
+	if (rval < 0) {
+		wcd->mbhc_btn_enabled = false;
+		dev_err(dev, "MBHC btn detection disabled\n");
+	}
+}
+
 static int wcd9335_probe(struct platform_device *pdev)
 {
 	struct wcd9335 *pdata = dev_get_drvdata(pdev->dev.parent);
@@ -4937,6 +5200,7 @@ static int wcd9335_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, wcd);
+	of_parse_mbhc_data(pdev->dev.parent, wcd);
 
 	memcpy(wcd->rx_chs, wcd9335_rx_chs, sizeof(wcd9335_rx_chs));
 	memcpy(wcd->tx_chs, wcd9335_tx_chs, sizeof(wcd9335_tx_chs));
-- 
2.9.3

