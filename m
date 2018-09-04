Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AD4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3EE20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEDG+zs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3EE20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeIDOwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:52:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37712 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIDOwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:52:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so3714167wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tDi5zCOoF4Zf3WseBgrH2Rw9Jfhfpe6VMctoVeb2Vns=;
        b=JEDG+zs0BD+eBtlk7oqOpJm9gBOipiSww5OkO3+D+5c6Hcc8JESWnYPKwr0N/FlzD7
         jIPd+JOWvTtGBQNVN0SSvMHYTihugcbE/CltwZFimgXeIp1ragAU+E8TKHtqvZ1oXCRJ
         6cghFfXKNAXrnv/X/k6YOCIa3d3SxpOfxKLBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tDi5zCOoF4Zf3WseBgrH2Rw9Jfhfpe6VMctoVeb2Vns=;
        b=jnHBH7gfzGgq9l1IFfUGyu1xJiSmgB9q1Fs11HIxcebrun+vhoej361qsHyIvJoFmb
         gdh0qKZuKjgvP8IIuSpMQ4TtlmZid02evgUJXxjZi1oVPVw9Dde73n979mlqAQlfq0rp
         CiQAXP4aJAdFw/K2PQsBQUQ+njm4qIuMkN86VwD61LTfxei+tE+FGAxil0E2JQeveOfv
         fuh7qTEXbcxsKWrxASyFqwHrdkzyDbSEY92Xpi5D8xmudRVhPxEduAKCSHzlvHXfd4Yk
         WaQBy0iQ7It98VmWLNJiKG7o0XddH7JFIw9Dv+gyHYduofNmrhFRGTafMk7dtqt/lK5k
         cbng==
X-Gm-Message-State: APzg51DwgPJD3ViFosa0sb4IJIikUv16yebY6d+hk0HX3L/dFR/HiugT
        ovHlEOzr3YqMmg+ArmKIgtQGSw==
X-Google-Smtp-Source: ANB0VdYiLfv1GZ/9yyWWdnq3O6Bmr7GdnvKudANcr7T+RC4rkTZjCLZ7H8Ze57PFzz7ScqdfUO+0FA==
X-Received: by 2002:a1c:a552:: with SMTP id o79-v6mr7390727wme.45.1536056864840;
        Tue, 04 Sep 2018 03:27:44 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id g129-v6sm16903325wmf.42.2018.09.04.03.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 03:27:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 11/13] ASoC: wcd9335: add mbhc support
Date:   Tue,  4 Sep 2018 11:24:58 +0100
Message-Id: <20180904102500.30318-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 268 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 266 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 095e6998e500..8d0f6b21cea0 100644
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
2.18.0

