Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4725CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95702177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeqgySlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfAJPHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:07:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40314 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbfAJPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:06:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so12352768wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QB5nQrLuYz3B7M2uSikXp5STd4IueVTTTNw0Acax1U=;
        b=eeqgySljxk1gJ58WON+IWHCNt69rKCof4BTka5YEikoFiTDYKQdZlpbt4FdQx609P3
         5lYkVwz+vicoraw1ngh3VVDRr1VcpWUTOq/5o6HLa+hzo5IDkwT0uDfjWvBGHUbSRV7D
         hl6JfCd1H0yS0eVIHWFZUhcOFcWM+nnhszQLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QB5nQrLuYz3B7M2uSikXp5STd4IueVTTTNw0Acax1U=;
        b=Ez1NVR9rJosgvv5OswHWsdpHO1cnAjM73SFNfGFzfLbnPNdcTl5whLhbAMZgMJQgOn
         GhjxsoPoBgXbNfTPTHC4/EM8au8LbIU4kf+XReTv6pAf/q6CxvnNLcE803cJuq2Nff+1
         29hRDbCKVJ/9GcCQKWdAtylKJHZnaE5U8fzMMxz9IaR7M1pVpNnnILEVkShlVvaABttj
         YHS6yXp5kct08DSSEIJLv64O991MCPTDZNrHr/6bacW5kIPzb+G8Po6dJtHh+ip5nuF5
         QjOuzAGNwOYYPojd/4aPH7OHeFRc/me9gx10TchWAEkN7Atyn/ZtC8WTkrVyaLyitRSV
         Nhtw==
X-Gm-Message-State: AJcUukf8E2cIoNPff5/M+xorRd21TsepfiRT/1IjXBo4zszP1z0/jh3W
        pFF2pBMpyfbfKYqT5QwUaNDJbg==
X-Google-Smtp-Source: ALg8bN7GM/BusjlXGf78tgqxSHhHF3YW3DDCyT6mJIRUnIk09yGhjp9M5LoVkJy9Ye4wF9meDxP5Cg==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr10267702wmk.149.1547132786913;
        Thu, 10 Jan 2019 07:06:26 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b12sm51063754wrt.17.2019.01.10.07.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 07:06:26 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 2/8] ASoC: wcd9335: add support to wcd9335 codec
Date:   Thu, 10 Jan 2019 15:06:10 +0000
Message-Id: <20190110150616.2332-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
It supports both I2S/I2C and SLIMbus audio interfaces.
On slimbus interface it supports two data lanes; 16 Tx ports
and 8 Rx ports. It has Seven DACs and nine dedicated interpolators,
Seven (six audio ADCs, and one VBAT ADC), Multibutton headset
control (MBHC), Active noise cancellation and Sidetone paths
and processing.

This patchset adds very basic support for playback and capture
via the 9 interpolators and ADC respectively.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/Kconfig   |    6 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/wcd9335.c | 1476 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wcd9335.h |  640 ++++++++++++++++
 4 files changed, 2124 insertions(+)
 create mode 100644 sound/soc/codecs/wcd9335.c
 create mode 100644 sound/soc/codecs/wcd9335.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 62bdb7e333b8..1c4904940621 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1100,6 +1100,12 @@ config SND_SOC_UDA1380
         tristate
 	depends on I2C
 
+config SND_SOC_WCD9335
+	tristate "WCD9335 Codec"
+	depends on SLIMBUS
+	select REGMAP_SLIMBUS
+        tristate
+
 config SND_SOC_WL1273
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 66f55d185620..1200c200c322 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -198,6 +198,7 @@ snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
+snd-soc-wcd9335-objs := wcd9335.o
 snd-soc-wl1273-objs := wl1273.o
 snd-soc-wm-adsp-objs := wm_adsp.o
 snd-soc-wm0010-objs := wm0010.o
@@ -463,6 +464,7 @@ obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
+obj-$(CONFIG_SND_SOC_WCD9335)	+= snd-soc-wcd9335.o
 obj-$(CONFIG_SND_SOC_WL1273)	+= snd-soc-wl1273.o
 obj-$(CONFIG_SND_SOC_WM0010)	+= snd-soc-wm0010.o
 obj-$(CONFIG_SND_SOC_WM1250_EV1) += snd-soc-wm1250-ev1.o
diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
new file mode 100644
index 000000000000..a2cd589617e2
--- /dev/null
+++ b/sound/soc/codecs/wcd9335.c
@@ -0,0 +1,1476 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+// Copyright (c) 2017-2018, Linaro Limited
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/wait.h>
+#include <linux/bitops.h>
+#include <linux/regulator/consumer.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/slimbus.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <sound/soc-dapm.h>
+#include <linux/of_gpio.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <sound/tlv.h>
+#include <sound/info.h>
+#include "wcd9335.h"
+
+#define WCD9335_RATES_MASK (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+			    SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
+			    SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
+/* Fractional Rates */
+#define WCD9335_FRAC_RATES_MASK (SNDRV_PCM_RATE_44100)
+#define WCD9335_FORMATS_S16_S24_LE (SNDRV_PCM_FMTBIT_S16_LE | \
+				  SNDRV_PCM_FMTBIT_S24_LE)
+
+/* slave port water mark level
+ *   (0: 6bytes, 1: 9bytes, 2: 12 bytes, 3: 15 bytes)
+ */
+#define SLAVE_PORT_WATER_MARK_6BYTES  0
+#define SLAVE_PORT_WATER_MARK_9BYTES  1
+#define SLAVE_PORT_WATER_MARK_12BYTES 2
+#define SLAVE_PORT_WATER_MARK_15BYTES 3
+#define SLAVE_PORT_WATER_MARK_SHIFT 1
+#define SLAVE_PORT_ENABLE           1
+#define SLAVE_PORT_DISABLE          0
+#define WCD9335_SLIM_WATER_MARK_VAL \
+	((SLAVE_PORT_WATER_MARK_12BYTES << SLAVE_PORT_WATER_MARK_SHIFT) | \
+	 (SLAVE_PORT_ENABLE))
+
+#define WCD9335_SLIM_NUM_PORT_REG 3
+#define WCD9335_SLIM_PGD_PORT_INT_TX_EN0 (WCD9335_SLIM_PGD_PORT_INT_EN0 + 2)
+
+#define WCD9335_MCLK_CLK_12P288MHZ	12288000
+#define WCD9335_MCLK_CLK_9P6MHZ		9600000
+
+#define WCD9335_SLIM_CLOSE_TIMEOUT 1000
+#define WCD9335_SLIM_IRQ_OVERFLOW (1 << 0)
+#define WCD9335_SLIM_IRQ_UNDERFLOW (1 << 1)
+#define WCD9335_SLIM_IRQ_PORT_CLOSED (1 << 2)
+
+#define WCD9335_NUM_INTERPOLATORS 9
+#define WCD9335_RX_START	16
+#define WCD9335_SLIM_CH_START 128
+
+#define WCD9335_SLIM_RX_CH(p) \
+	{.port = p + WCD9335_RX_START, .shift = p,}
+
+/* vout step value */
+#define WCD9335_CALCULATE_VOUT_D(req_mv) (((req_mv - 650) * 10) / 25)
+
+enum {
+	WCD9335_RX0 = 0,
+	WCD9335_RX1,
+	WCD9335_RX2,
+	WCD9335_RX3,
+	WCD9335_RX4,
+	WCD9335_RX5,
+	WCD9335_RX6,
+	WCD9335_RX7,
+	WCD9335_RX8,
+	WCD9335_RX9,
+	WCD9335_RX10,
+	WCD9335_RX11,
+	WCD9335_RX12,
+	WCD9335_RX_MAX,
+};
+
+enum {
+	SIDO_SOURCE_INTERNAL = 0,
+	SIDO_SOURCE_RCO_BG,
+};
+
+enum wcd9335_sido_voltage {
+	SIDO_VOLTAGE_SVS_MV = 950,
+	SIDO_VOLTAGE_NOMINAL_MV = 1100,
+};
+
+enum {
+	AIF1_PB = 0,
+	AIF1_CAP,
+	AIF2_PB,
+	AIF2_CAP,
+	AIF3_PB,
+	AIF3_CAP,
+	AIF4_PB,
+	NUM_CODEC_DAIS,
+};
+
+enum {
+	INTn_2_INP_SEL_ZERO = 0,
+	INTn_2_INP_SEL_RX0,
+	INTn_2_INP_SEL_RX1,
+	INTn_2_INP_SEL_RX2,
+	INTn_2_INP_SEL_RX3,
+	INTn_2_INP_SEL_RX4,
+	INTn_2_INP_SEL_RX5,
+	INTn_2_INP_SEL_RX6,
+	INTn_2_INP_SEL_RX7,
+	INTn_2_INP_SEL_PROXIMITY,
+};
+
+enum {
+	INTn_1_MIX_INP_SEL_ZERO = 0,
+	INTn_1_MIX_INP_SEL_DEC0,
+	INTn_1_MIX_INP_SEL_DEC1,
+	INTn_1_MIX_INP_SEL_IIR0,
+	INTn_1_MIX_INP_SEL_IIR1,
+	INTn_1_MIX_INP_SEL_RX0,
+	INTn_1_MIX_INP_SEL_RX1,
+	INTn_1_MIX_INP_SEL_RX2,
+	INTn_1_MIX_INP_SEL_RX3,
+	INTn_1_MIX_INP_SEL_RX4,
+	INTn_1_MIX_INP_SEL_RX5,
+	INTn_1_MIX_INP_SEL_RX6,
+	INTn_1_MIX_INP_SEL_RX7,
+
+};
+
+enum wcd_clock_type {
+	WCD_CLK_OFF,
+	WCD_CLK_RCO,
+	WCD_CLK_MCLK,
+};
+
+struct wcd9335_slim_ch {
+	u32 ch_num;
+	u16 port;
+	u16 shift;
+	struct list_head list;
+};
+
+struct wcd_slim_codec_dai_data {
+	struct list_head slim_ch_list;
+	struct slim_stream_config sconfig;
+	struct slim_stream_runtime *sruntime;
+};
+
+struct wcd9335_codec {
+	struct device *dev;
+	struct clk *mclk;
+	struct clk *native_clk;
+	u32 mclk_rate;
+	u8 version;
+
+	struct slim_device *slim;
+	struct slim_device *slim_ifc_dev;
+	struct regmap *regmap;
+	struct regmap *if_regmap;
+	struct regmap_irq_chip_data *irq_data;
+
+	struct wcd9335_slim_ch rx_chs[WCD9335_RX_MAX];
+	u32 num_rx_port;
+
+	int sido_input_src;
+	enum wcd9335_sido_voltage sido_voltage;
+
+	struct wcd_slim_codec_dai_data dai[NUM_CODEC_DAIS];
+	struct snd_soc_component *component;
+
+	int master_bias_users;
+	int clk_mclk_users;
+	int clk_rco_users;
+	int sido_ccl_cnt;
+	enum wcd_clock_type clk_type;
+
+	u32 hph_mode;
+	int intr1;
+	int reset_gpio;
+	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
+};
+
+struct wcd9335_irq {
+	int irq;
+	irqreturn_t (*handler)(int irq, void *data);
+	char *name;
+};
+
+static const struct wcd9335_slim_ch wcd9335_rx_chs[WCD9335_RX_MAX] = {
+	WCD9335_SLIM_RX_CH(0),	 /* 16 */
+	WCD9335_SLIM_RX_CH(1),	 /* 17 */
+	WCD9335_SLIM_RX_CH(2),
+	WCD9335_SLIM_RX_CH(3),
+	WCD9335_SLIM_RX_CH(4),
+	WCD9335_SLIM_RX_CH(5),
+	WCD9335_SLIM_RX_CH(6),
+	WCD9335_SLIM_RX_CH(7),
+	WCD9335_SLIM_RX_CH(8),
+	WCD9335_SLIM_RX_CH(9),
+	WCD9335_SLIM_RX_CH(10),
+	WCD9335_SLIM_RX_CH(11),
+	WCD9335_SLIM_RX_CH(12),
+};
+
+struct interp_sample_rate {
+	int rate;
+	int rate_val;
+};
+
+static struct interp_sample_rate int_mix_rate_val[] = {
+	{48000, 0x4},	/* 48K */
+	{96000, 0x5},	/* 96K */
+	{192000, 0x6},	/* 192K */
+};
+
+static struct interp_sample_rate int_prim_rate_val[] = {
+	{8000, 0x0},	/* 8K */
+	{16000, 0x1},	/* 16K */
+	{24000, -EINVAL},/* 24K */
+	{32000, 0x3},	/* 32K */
+	{48000, 0x4},	/* 48K */
+	{96000, 0x5},	/* 96K */
+	{192000, 0x6},	/* 192K */
+	{384000, 0x7},	/* 384K */
+	{44100, 0x8}, /* 44.1K */
+};
+
+struct wcd9335_reg_mask_val {
+	u16 reg;
+	u8 mask;
+	u8 val;
+};
+
+static const struct wcd9335_reg_mask_val wcd9335_codec_reg_init[] = {
+	/* Rbuckfly/R_EAR(32) */
+	{WCD9335_CDC_CLSH_K2_MSB, 0x0F, 0x00},
+	{WCD9335_CDC_CLSH_K2_LSB, 0xFF, 0x60},
+	{WCD9335_CPE_SS_DMIC_CFG, 0x80, 0x00},
+	{WCD9335_CDC_BOOST0_BOOST_CTL, 0x70, 0x50},
+	{WCD9335_CDC_BOOST1_BOOST_CTL, 0x70, 0x50},
+	{WCD9335_CDC_RX7_RX_PATH_CFG1, 0x08, 0x08},
+	{WCD9335_CDC_RX8_RX_PATH_CFG1, 0x08, 0x08},
+	{WCD9335_ANA_LO_1_2, 0x3C, 0X3C},
+	{WCD9335_DIFF_LO_COM_SWCAP_REFBUF_FREQ, 0x70, 0x00},
+	{WCD9335_DIFF_LO_COM_PA_FREQ, 0x70, 0x40},
+	{WCD9335_SOC_MAD_AUDIO_CTL_2, 0x03, 0x03},
+	{WCD9335_CDC_TOP_TOP_CFG1, 0x02, 0x02},
+	{WCD9335_CDC_TOP_TOP_CFG1, 0x01, 0x01},
+	{WCD9335_EAR_CMBUFF, 0x08, 0x00},
+	{WCD9335_CDC_TX9_SPKR_PROT_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_TX10_SPKR_PROT_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_TX11_SPKR_PROT_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_TX12_SPKR_PROT_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_COMPANDER7_CTL3, 0x80, 0x80},
+	{WCD9335_CDC_COMPANDER8_CTL3, 0x80, 0x80},
+	{WCD9335_CDC_COMPANDER7_CTL7, 0x01, 0x01},
+	{WCD9335_CDC_COMPANDER8_CTL7, 0x01, 0x01},
+	{WCD9335_CDC_RX0_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX1_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX2_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX3_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX4_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX5_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX6_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX7_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX8_RX_PATH_CFG0, 0x01, 0x01},
+	{WCD9335_CDC_RX0_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX1_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX2_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX3_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX4_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX5_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX6_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX7_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_CDC_RX8_RX_PATH_MIX_CFG, 0x01, 0x01},
+	{WCD9335_VBADC_IBIAS_FE, 0x0C, 0x08},
+	{WCD9335_RCO_CTRL_2, 0x0F, 0x08},
+	{WCD9335_RX_BIAS_FLYB_MID_RST, 0xF0, 0x10},
+	{WCD9335_FLYBACK_CTRL_1, 0x20, 0x20},
+	{WCD9335_HPH_OCP_CTL, 0xFF, 0x5A},
+	{WCD9335_HPH_L_TEST, 0x01, 0x01},
+	{WCD9335_HPH_R_TEST, 0x01, 0x01},
+	{WCD9335_CDC_BOOST0_BOOST_CFG1, 0x3F, 0x12},
+	{WCD9335_CDC_BOOST0_BOOST_CFG2, 0x1C, 0x08},
+	{WCD9335_CDC_COMPANDER7_CTL7, 0x1E, 0x18},
+	{WCD9335_CDC_BOOST1_BOOST_CFG1, 0x3F, 0x12},
+	{WCD9335_CDC_BOOST1_BOOST_CFG2, 0x1C, 0x08},
+	{WCD9335_CDC_COMPANDER8_CTL7, 0x1E, 0x18},
+	{WCD9335_CDC_TX0_TX_PATH_SEC7, 0xFF, 0x45},
+	{WCD9335_CDC_RX0_RX_PATH_SEC0, 0xFC, 0xF4},
+	{WCD9335_HPH_REFBUFF_LP_CTL, 0x08, 0x08},
+	{WCD9335_HPH_REFBUFF_LP_CTL, 0x06, 0x02},
+};
+
+static int wcd9335_set_mix_interpolator_rate(struct snd_soc_dai *dai,
+					     int rate_val,
+					     u32 rate)
+{
+	struct snd_soc_component *component = dai->component;
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	struct wcd9335_slim_ch *ch;
+	int val, j;
+
+	list_for_each_entry(ch, &wcd->dai[dai->id].slim_ch_list, list) {
+		for (j = 0; j < WCD9335_NUM_INTERPOLATORS; j++) {
+			val = snd_soc_component_read32(component,
+					WCD9335_CDC_RX_INP_MUX_RX_INT_CFG1(j)) &
+					WCD9335_CDC_RX_INP_MUX_RX_INT_SEL_MASK;
+
+			if (val == (ch->shift + INTn_2_INP_SEL_RX0))
+				snd_soc_component_update_bits(component,
+						WCD9335_CDC_RX_PATH_MIX_CTL(j),
+						WCD9335_CDC_MIX_PCM_RATE_MASK,
+						rate_val);
+		}
+	}
+
+	return 0;
+}
+
+static int wcd9335_set_prim_interpolator_rate(struct snd_soc_dai *dai,
+					      u8 rate_val,
+					      u32 rate)
+{
+	struct snd_soc_component *comp = dai->component;
+	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
+	struct wcd9335_slim_ch *ch;
+	u8 cfg0, cfg1, inp0_sel, inp1_sel, inp2_sel;
+	int inp, j;
+
+	list_for_each_entry(ch, &wcd->dai[dai->id].slim_ch_list, list) {
+		inp = ch->shift + INTn_1_MIX_INP_SEL_RX0;
+		/*
+		 * Loop through all interpolator MUX inputs and find out
+		 * to which interpolator input, the slim rx port
+		 * is connected
+		 */
+		for (j = 0; j < WCD9335_NUM_INTERPOLATORS; j++) {
+			cfg0 = snd_soc_component_read32(comp,
+					WCD9335_CDC_RX_INP_MUX_RX_INT_CFG0(j));
+			cfg1 = snd_soc_component_read32(comp,
+					WCD9335_CDC_RX_INP_MUX_RX_INT_CFG1(j));
+
+			inp0_sel = cfg0 &
+				 WCD9335_CDC_RX_INP_MUX_RX_INT_SEL_MASK;
+			inp1_sel = (cfg0 >> 4) &
+				 WCD9335_CDC_RX_INP_MUX_RX_INT_SEL_MASK;
+			inp2_sel = (cfg1 >> 4) &
+				 WCD9335_CDC_RX_INP_MUX_RX_INT_SEL_MASK;
+
+			if ((inp0_sel == inp) ||  (inp1_sel == inp) ||
+			    (inp2_sel == inp)) {
+				/* rate is in Hz */
+				if ((j == 0) && (rate == 44100))
+					dev_info(wcd->dev,
+						"Cannot set 44.1KHz on INT0\n");
+				else
+					snd_soc_component_update_bits(comp,
+						WCD9335_CDC_RX_PATH_CTL(j),
+						WCD9335_CDC_MIX_PCM_RATE_MASK,
+						rate_val);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int wcd9335_set_interpolator_rate(struct snd_soc_dai *dai, u32 rate)
+{
+	int i;
+
+	/* set mixing path rate */
+	for (i = 0; i < ARRAY_SIZE(int_mix_rate_val); i++) {
+		if (rate == int_mix_rate_val[i].rate) {
+			wcd9335_set_mix_interpolator_rate(dai,
+					int_mix_rate_val[i].rate_val, rate);
+			break;
+		}
+	}
+
+	/* set primary path sample rate */
+	for (i = 0; i < ARRAY_SIZE(int_prim_rate_val); i++) {
+		if (rate == int_prim_rate_val[i].rate) {
+			wcd9335_set_prim_interpolator_rate(dai,
+					int_prim_rate_val[i].rate_val, rate);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int wcd9335_slim_set_hw_params(struct wcd9335_codec *wcd,
+				 struct wcd_slim_codec_dai_data *dai_data,
+				 int direction)
+{
+	struct list_head *slim_ch_list = &dai_data->slim_ch_list;
+	struct slim_stream_config *cfg = &dai_data->sconfig;
+	struct wcd9335_slim_ch *ch;
+	u16 payload = 0;
+	int ret, i;
+
+	cfg->ch_count = 0;
+	cfg->direction = direction;
+	cfg->port_mask = 0;
+
+	/* Configure slave interface device */
+	list_for_each_entry(ch, slim_ch_list, list) {
+		cfg->ch_count++;
+		payload |= 1 << ch->shift;
+		cfg->port_mask |= BIT(ch->port);
+	}
+
+	cfg->chs = kcalloc(cfg->ch_count, sizeof(unsigned int), GFP_KERNEL);
+	if (!cfg->chs)
+		return -ENOMEM;
+
+	i = 0;
+	list_for_each_entry(ch, slim_ch_list, list) {
+		cfg->chs[i++] = ch->ch_num;
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
+			/* write to interface device */
+			ret = regmap_write(wcd->if_regmap,
+				WCD9335_SLIM_PGD_RX_PORT_MULTI_CHNL_0(ch->port),
+				payload);
+
+			if (ret < 0)
+				goto err;
+
+			/* configure the slave port for water mark and enable*/
+			ret = regmap_write(wcd->if_regmap,
+					WCD9335_SLIM_PGD_RX_PORT_CFG(ch->port),
+					WCD9335_SLIM_WATER_MARK_VAL);
+			if (ret < 0)
+				goto err;
+		}
+	}
+
+	dai_data->sruntime = slim_stream_allocate(wcd->slim, "WCD9335-SLIM");
+
+	return 0;
+
+err:
+	dev_err(wcd->dev, "Error Setting slim hw params\n");
+	kfree(cfg->chs);
+	cfg->chs = NULL;
+
+	return ret;
+}
+
+static int wcd9335_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct wcd9335_codec *wcd;
+	int ret;
+
+	wcd = snd_soc_component_get_drvdata(dai->component);
+
+	switch (substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		ret = wcd9335_set_interpolator_rate(dai, params_rate(params));
+		if (ret) {
+			dev_err(wcd->dev, "cannot set sample rate: %u\n",
+				params_rate(params));
+			return ret;
+		}
+		switch (params_width(params)) {
+		case 16 ... 24:
+			wcd->dai[dai->id].sconfig.bps = params_width(params);
+			break;
+		default:
+			dev_err(wcd->dev, "%s: Invalid format 0x%x\n",
+				__func__, params_width(params));
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(wcd->dev, "Invalid stream type %d\n",
+			substream->stream);
+		return -EINVAL;
+	};
+
+	wcd->dai[dai->id].sconfig.rate = params_rate(params);
+	wcd9335_slim_set_hw_params(wcd, &wcd->dai[dai->id], substream->stream);
+
+	return 0;
+}
+
+static int wcd9335_trigger(struct snd_pcm_substream *substream, int cmd,
+			   struct snd_soc_dai *dai)
+{
+	struct wcd_slim_codec_dai_data *dai_data;
+	struct wcd9335_codec *wcd;
+	struct slim_stream_config *cfg;
+
+	wcd = snd_soc_component_get_drvdata(dai->component);
+
+	dai_data = &wcd->dai[dai->id];
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		cfg = &dai_data->sconfig;
+		slim_stream_prepare(dai_data->sruntime, cfg);
+		slim_stream_enable(dai_data->sruntime);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		slim_stream_unprepare(dai_data->sruntime);
+		slim_stream_disable(dai_data->sruntime);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int wcd9335_set_channel_map(struct snd_soc_dai *dai,
+				   unsigned int tx_num, unsigned int *tx_slot,
+				   unsigned int rx_num, unsigned int *rx_slot)
+{
+	struct wcd9335_codec *wcd;
+	int i;
+
+	wcd = snd_soc_component_get_drvdata(dai->component);
+
+	if (!tx_slot || !rx_slot) {
+		dev_err(wcd->dev, "Invalid tx_slot=%p, rx_slot=%p\n",
+			tx_slot, rx_slot);
+		return -EINVAL;
+	}
+
+	if (wcd->rx_chs) {
+		wcd->num_rx_port = rx_num;
+		for (i = 0; i < rx_num; i++) {
+			wcd->rx_chs[i].ch_num = rx_slot[i];
+			INIT_LIST_HEAD(&wcd->rx_chs[i].list);
+		}
+	}
+
+	return 0;
+}
+
+static int wcd9335_get_channel_map(struct snd_soc_dai *dai,
+				   unsigned int *tx_num, unsigned int *tx_slot,
+				   unsigned int *rx_num, unsigned int *rx_slot)
+{
+	struct wcd9335_slim_ch *ch;
+	struct wcd9335_codec *wcd;
+	int i = 0;
+
+	wcd = snd_soc_component_get_drvdata(dai->component);
+
+	switch (dai->id) {
+	case AIF1_PB:
+	case AIF2_PB:
+	case AIF3_PB:
+	case AIF4_PB:
+		if (!rx_slot || !rx_num) {
+			dev_err(wcd->dev, "Invalid rx_slot %p or rx_num %p\n",
+				rx_slot, rx_num);
+			return -EINVAL;
+		}
+
+		list_for_each_entry(ch, &wcd->dai[dai->id].slim_ch_list, list)
+			rx_slot[i++] = ch->ch_num;
+
+		*rx_num = i;
+		break;
+	default:
+		dev_err(wcd->dev, "Invalid DAI ID %x\n", dai->id);
+		break;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops wcd9335_dai_ops = {
+	.hw_params = wcd9335_hw_params,
+	.trigger = wcd9335_trigger,
+	.set_channel_map = wcd9335_set_channel_map,
+	.get_channel_map = wcd9335_get_channel_map,
+};
+
+static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
+	[0] = {
+		.name = "wcd9335_rx1",
+		.id = AIF1_PB,
+		.playback = {
+			.stream_name = "AIF1 Playback",
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.formats = WCD9335_FORMATS_S16_S24_LE,
+			.rate_max = 192000,
+			.rate_min = 8000,
+			.channels_min = 1,
+			.channels_max = 2,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[1] = {
+		.name = "wcd9335_tx1",
+		.id = AIF1_CAP,
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.rates = WCD9335_RATES_MASK,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 4,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[2] = {
+		.name = "wcd9335_rx2",
+		.id = AIF2_PB,
+		.playback = {
+			.stream_name = "AIF2 Playback",
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.formats = WCD9335_FORMATS_S16_S24_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 2,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[3] = {
+		.name = "wcd9335_tx2",
+		.id = AIF2_CAP,
+		.capture = {
+			.stream_name = "AIF2 Capture",
+			.rates = WCD9335_RATES_MASK,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 4,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[4] = {
+		.name = "wcd9335_rx3",
+		.id = AIF3_PB,
+		.playback = {
+			.stream_name = "AIF3 Playback",
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.formats = WCD9335_FORMATS_S16_S24_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 2,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[5] = {
+		.name = "wcd9335_tx3",
+		.id = AIF3_CAP,
+		.capture = {
+			.stream_name = "AIF3 Capture",
+			.rates = WCD9335_RATES_MASK,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 4,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+	[6] = {
+		.name = "wcd9335_rx4",
+		.id = AIF4_PB,
+		.playback = {
+			.stream_name = "AIF4 Playback",
+			.rates = WCD9335_RATES_MASK | WCD9335_FRAC_RATES_MASK,
+			.formats = WCD9335_FORMATS_S16_S24_LE,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.channels_min = 1,
+			.channels_max = 2,
+		},
+		.ops = &wcd9335_dai_ops,
+	},
+};
+
+static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
+{
+	struct wcd9335_codec *wcd = data;
+	unsigned long status = 0;
+	int i, j, port_id;
+	unsigned int val, int_val = 0;
+	bool tx;
+	unsigned short reg = 0;
+
+	for (i = WCD9335_SLIM_PGD_PORT_INT_STATUS_RX_0, j = 0;
+	     i <= WCD9335_SLIM_PGD_PORT_INT_STATUS_TX_1; i++, j++) {
+		regmap_read(wcd->if_regmap, i, &val);
+		status |= ((u32)val << (8 * j));
+	}
+
+	for_each_set_bit(j, &status, 32) {
+		tx = (j >= 16 ? true : false);
+		port_id = (tx ? j - 16 : j);
+		regmap_read(wcd->if_regmap,
+				WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0 + j, &val);
+		if (val) {
+			if (!tx)
+				reg = WCD9335_SLIM_PGD_PORT_INT_EN0 +
+					(port_id / 8);
+			else
+				reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 +
+					(port_id / 8);
+			regmap_read(
+				wcd->if_regmap, reg, &int_val);
+			/*
+			 * Ignore interrupts for ports for which the
+			 * interrupts are not specifically enabled.
+			 */
+			if (!(int_val & (1 << (port_id % 8))))
+				continue;
+		}
+		if (val & WCD9335_SLIM_IRQ_OVERFLOW)
+			dev_err_ratelimited(wcd->dev,
+			   "%s: overflow error on %s port %d, value %x\n",
+			   __func__, (tx ? "TX" : "RX"), port_id, val);
+		if (val & WCD9335_SLIM_IRQ_UNDERFLOW)
+			dev_err_ratelimited(wcd->dev,
+			   "%s: underflow error on %s port %d, value %x\n",
+			   __func__, (tx ? "TX" : "RX"), port_id, val);
+		if ((val & WCD9335_SLIM_IRQ_OVERFLOW) ||
+			(val & WCD9335_SLIM_IRQ_UNDERFLOW)) {
+			if (!tx)
+				reg = WCD9335_SLIM_PGD_PORT_INT_EN0 +
+					(port_id / 8);
+			else
+				reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 +
+					(port_id / 8);
+			regmap_read(
+				wcd->if_regmap, reg, &int_val);
+			if (int_val & (1 << (port_id % 8))) {
+				int_val = int_val ^ (1 << (port_id % 8));
+				regmap_write(wcd->if_regmap,
+					reg, int_val);
+			}
+		}
+
+		regmap_write(wcd->if_regmap,
+				WCD9335_SLIM_PGD_PORT_INT_CLR_RX_0 + (j / 8),
+				BIT(j % 8));
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct wcd9335_irq wcd9335_irqs[] = {
+	{
+		.irq = WCD9335_IRQ_SLIMBUS,
+		.handler = wcd9335_slimbus_irq,
+		.name = "SLIM Slave",
+	},
+};
+
+static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
+{
+	int irq, ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(wcd9335_irqs); i++) {
+		irq = regmap_irq_get_virq(wcd->irq_data, wcd9335_irqs[i].irq);
+		if (irq < 0) {
+			dev_err(wcd->dev, "Failed to get %s\n",
+					wcd9335_irqs[i].name);
+			return irq;
+		}
+
+		ret = devm_request_threaded_irq(wcd->dev, irq, NULL,
+						wcd9335_irqs[i].handler,
+						IRQF_TRIGGER_RISING,
+						wcd9335_irqs[i].name, wcd);
+		if (ret) {
+			dev_err(wcd->dev, "Failed to request %s\n",
+					wcd9335_irqs[i].name);
+			return ret;
+		}
+	}
+
+	/* enable interrupts on all slave ports */
+	for (i = 0; i < WCD9335_SLIM_NUM_PORT_REG; i++)
+		regmap_write(wcd->if_regmap, WCD9335_SLIM_PGD_PORT_INT_EN0 + i,
+			     0xFF);
+
+	return ret;
+}
+
+static void wcd9335_cdc_sido_ccl_enable(struct wcd9335_codec *wcd,
+					bool ccl_flag)
+{
+	struct snd_soc_component *comp = wcd->component;
+
+	if (ccl_flag) {
+		if (++wcd->sido_ccl_cnt == 1)
+			snd_soc_component_write(comp, WCD9335_SIDO_SIDO_CCL_10,
+					WCD9335_SIDO_SIDO_CCL_DEF_VALUE);
+	} else {
+		if (wcd->sido_ccl_cnt == 0) {
+			dev_err(wcd->dev, "sido_ccl already disabled\n");
+			return;
+		}
+		if (--wcd->sido_ccl_cnt == 0)
+			snd_soc_component_write(comp, WCD9335_SIDO_SIDO_CCL_10,
+				WCD9335_SIDO_SIDO_CCL_10_ICHARG_PWR_SEL_C320FF);
+	}
+}
+
+static int wcd9335_enable_master_bias(struct wcd9335_codec *wcd)
+{
+	wcd->master_bias_users++;
+	if (wcd->master_bias_users == 1) {
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+					WCD9335_ANA_BIAS_EN_MASK,
+					WCD9335_ANA_BIAS_ENABLE);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+					WCD9335_ANA_BIAS_PRECHRG_EN_MASK,
+					WCD9335_ANA_BIAS_PRECHRG_ENABLE);
+		/*
+		 * 1ms delay is required after pre-charge is enabled
+		 * as per HW requirement
+		 */
+		usleep_range(1000, 1100);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+					WCD9335_ANA_BIAS_PRECHRG_EN_MASK,
+					WCD9335_ANA_BIAS_PRECHRG_DISABLE);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+				WCD9335_ANA_BIAS_PRECHRG_CTL_MODE,
+				WCD9335_ANA_BIAS_PRECHRG_CTL_MODE_MANUAL);
+	}
+
+	return 0;
+}
+
+static int wcd9335_enable_mclk(struct wcd9335_codec *wcd)
+{
+	/* Enable mclk requires master bias to be enabled first */
+	if (wcd->master_bias_users <= 0)
+		return -EINVAL;
+
+	if (((wcd->clk_mclk_users == 0) && (wcd->clk_type == WCD_CLK_MCLK)) ||
+	    ((wcd->clk_mclk_users > 0) && (wcd->clk_type != WCD_CLK_MCLK))) {
+		dev_err(wcd->dev, "Error enabling MCLK, clk_type: %d\n",
+			wcd->clk_type);
+		return -EINVAL;
+	}
+
+	if (++wcd->clk_mclk_users == 1) {
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_EXT_CLKBUF_EN_MASK,
+					WCD9335_ANA_CLK_EXT_CLKBUF_ENABLE);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_MCLK_SRC_MASK,
+					WCD9335_ANA_CLK_MCLK_SRC_EXTERNAL);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_MCLK_EN_MASK,
+					WCD9335_ANA_CLK_MCLK_ENABLE);
+		regmap_update_bits(wcd->regmap,
+				   WCD9335_CDC_CLK_RST_CTRL_FS_CNT_CONTROL,
+				   WCD9335_CDC_CLK_RST_CTRL_FS_CNT_EN_MASK,
+				   WCD9335_CDC_CLK_RST_CTRL_FS_CNT_ENABLE);
+		regmap_update_bits(wcd->regmap,
+				   WCD9335_CDC_CLK_RST_CTRL_MCLK_CONTROL,
+				   WCD9335_CDC_CLK_RST_CTRL_MCLK_EN_MASK,
+				   WCD9335_CDC_CLK_RST_CTRL_MCLK_ENABLE);
+		/*
+		 * 10us sleep is required after clock is enabled
+		 * as per HW requirement
+		 */
+		usleep_range(10, 15);
+	}
+
+	wcd->clk_type = WCD_CLK_MCLK;
+
+	return 0;
+}
+
+static int wcd9335_disable_mclk(struct wcd9335_codec *wcd)
+{
+	if (wcd->clk_mclk_users <= 0)
+		return -EINVAL;
+
+	if (--wcd->clk_mclk_users == 0) {
+		if (wcd->clk_rco_users > 0) {
+			/* MCLK to RCO switch */
+			regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_MCLK_SRC_MASK,
+					WCD9335_ANA_CLK_MCLK_SRC_RCO);
+			wcd->clk_type = WCD_CLK_RCO;
+		} else {
+			regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_MCLK_EN_MASK,
+					WCD9335_ANA_CLK_MCLK_DISABLE);
+			wcd->clk_type = WCD_CLK_OFF;
+		}
+
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_CLK_TOP,
+					WCD9335_ANA_CLK_EXT_CLKBUF_EN_MASK,
+					WCD9335_ANA_CLK_EXT_CLKBUF_DISABLE);
+	}
+
+	return 0;
+}
+
+static int wcd9335_disable_master_bias(struct wcd9335_codec *wcd)
+{
+	if (wcd->master_bias_users <= 0)
+		return -EINVAL;
+
+	wcd->master_bias_users--;
+	if (wcd->master_bias_users == 0) {
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+				WCD9335_ANA_BIAS_EN_MASK,
+				WCD9335_ANA_BIAS_DISABLE);
+		regmap_update_bits(wcd->regmap, WCD9335_ANA_BIAS,
+				WCD9335_ANA_BIAS_PRECHRG_CTL_MODE,
+				WCD9335_ANA_BIAS_PRECHRG_CTL_MODE_MANUAL);
+	}
+	return 0;
+}
+
+static int wcd9335_cdc_req_mclk_enable(struct wcd9335_codec *wcd,
+				     bool enable)
+{
+	int ret = 0;
+
+	if (enable) {
+		wcd9335_cdc_sido_ccl_enable(wcd, true);
+		ret = clk_prepare_enable(wcd->mclk);
+		if (ret) {
+			dev_err(wcd->dev, "%s: ext clk enable failed\n",
+				__func__);
+			goto err;
+		}
+		/* get BG */
+		wcd9335_enable_master_bias(wcd);
+		/* get MCLK */
+		wcd9335_enable_mclk(wcd);
+
+	} else {
+		/* put MCLK */
+		wcd9335_disable_mclk(wcd);
+		/* put BG */
+		wcd9335_disable_master_bias(wcd);
+		clk_disable_unprepare(wcd->mclk);
+		wcd9335_cdc_sido_ccl_enable(wcd, false);
+	}
+err:
+	return ret;
+}
+
+static void wcd9335_codec_apply_sido_voltage(struct wcd9335_codec *wcd,
+					     enum wcd9335_sido_voltage req_mv)
+{
+	struct snd_soc_component *comp = wcd->component;
+	int vout_d_val;
+
+	if (req_mv == wcd->sido_voltage)
+		return;
+
+	/* compute the vout_d step value */
+	vout_d_val = WCD9335_CALCULATE_VOUT_D(req_mv) &
+			WCD9335_ANA_BUCK_VOUT_MASK;
+	snd_soc_component_write(comp, WCD9335_ANA_BUCK_VOUT_D, vout_d_val);
+	snd_soc_component_update_bits(comp, WCD9335_ANA_BUCK_CTL,
+				WCD9335_ANA_BUCK_CTL_RAMP_START_MASK,
+				WCD9335_ANA_BUCK_CTL_RAMP_START_ENABLE);
+
+	/* 1 msec sleep required after SIDO Vout_D voltage change */
+	usleep_range(1000, 1100);
+	wcd->sido_voltage = req_mv;
+	snd_soc_component_update_bits(comp, WCD9335_ANA_BUCK_CTL,
+				WCD9335_ANA_BUCK_CTL_RAMP_START_MASK,
+				WCD9335_ANA_BUCK_CTL_RAMP_START_DISABLE);
+}
+
+static int wcd9335_codec_update_sido_voltage(struct wcd9335_codec *wcd,
+					     enum wcd9335_sido_voltage req_mv)
+{
+	int ret = 0;
+
+	/* enable mclk before setting SIDO voltage */
+	ret = wcd9335_cdc_req_mclk_enable(wcd, true);
+	if (ret) {
+		dev_err(wcd->dev, "Ext clk enable failed\n");
+		goto err;
+	}
+
+	wcd9335_codec_apply_sido_voltage(wcd, req_mv);
+	wcd9335_cdc_req_mclk_enable(wcd, false);
+
+err:
+	return ret;
+}
+
+static int _wcd9335_codec_enable_mclk(struct snd_soc_component *component,
+				      int enable)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	int ret;
+
+	if (enable) {
+		ret = wcd9335_cdc_req_mclk_enable(wcd, true);
+		if (ret)
+			return ret;
+
+		wcd9335_codec_apply_sido_voltage(wcd,
+				SIDO_VOLTAGE_NOMINAL_MV);
+	} else {
+		wcd9335_codec_update_sido_voltage(wcd,
+					wcd->sido_voltage);
+		wcd9335_cdc_req_mclk_enable(wcd, false);
+	}
+
+	return 0;
+}
+
+static void wcd9335_enable_sido_buck(struct snd_soc_component *component)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+
+	snd_soc_component_update_bits(component, WCD9335_ANA_RCO,
+					WCD9335_ANA_RCO_BG_EN_MASK,
+					WCD9335_ANA_RCO_BG_ENABLE);
+	snd_soc_component_update_bits(component, WCD9335_ANA_BUCK_CTL,
+					WCD9335_ANA_BUCK_CTL_VOUT_D_IREF_MASK,
+					WCD9335_ANA_BUCK_CTL_VOUT_D_IREF_EXT);
+	/* 100us sleep needed after IREF settings */
+	usleep_range(100, 110);
+	snd_soc_component_update_bits(component, WCD9335_ANA_BUCK_CTL,
+					WCD9335_ANA_BUCK_CTL_VOUT_D_VREF_MASK,
+					WCD9335_ANA_BUCK_CTL_VOUT_D_VREF_EXT);
+	/* 100us sleep needed after VREF settings */
+	usleep_range(100, 110);
+	wcd->sido_input_src = SIDO_SOURCE_RCO_BG;
+}
+
+static int wcd9335_enable_efuse_sensing(struct snd_soc_component *comp)
+{
+	_wcd9335_codec_enable_mclk(comp, true);
+	snd_soc_component_update_bits(comp,
+				WCD9335_CHIP_TIER_CTRL_EFUSE_CTL,
+				WCD9335_CHIP_TIER_CTRL_EFUSE_EN_MASK,
+				WCD9335_CHIP_TIER_CTRL_EFUSE_ENABLE);
+	/*
+	 * 5ms sleep required after enabling efuse control
+	 * before checking the status.
+	 */
+	usleep_range(5000, 5500);
+
+	if (!(snd_soc_component_read32(comp,
+					WCD9335_CHIP_TIER_CTRL_EFUSE_STATUS) &
+					WCD9335_CHIP_TIER_CTRL_EFUSE_EN_MASK))
+		WARN(1, "%s: Efuse sense is not complete\n", __func__);
+
+	wcd9335_enable_sido_buck(comp);
+	_wcd9335_codec_enable_mclk(comp, false);
+
+	return 0;
+}
+
+static void wcd9335_codec_init(struct snd_soc_component *component)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	int i;
+
+	/* ungate MCLK and set clk rate */
+	regmap_update_bits(wcd->regmap, WCD9335_CODEC_RPM_CLK_GATE,
+				WCD9335_CODEC_RPM_CLK_GATE_MCLK_GATE_MASK, 0);
+
+	regmap_update_bits(wcd->regmap, WCD9335_CODEC_RPM_CLK_MCLK_CFG,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_9P6MHZ);
+
+	for (i = 0; i < ARRAY_SIZE(wcd9335_codec_reg_init); i++)
+		snd_soc_component_update_bits(component,
+					wcd9335_codec_reg_init[i].reg,
+					wcd9335_codec_reg_init[i].mask,
+					wcd9335_codec_reg_init[i].val);
+
+	wcd9335_enable_efuse_sensing(component);
+}
+
+static int wcd9335_codec_probe(struct snd_soc_component *component)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	int i;
+
+	snd_soc_component_init_regmap(component, wcd->regmap);
+	wcd->component = component;
+
+	wcd9335_codec_init(component);
+
+	for (i = 0; i < NUM_CODEC_DAIS; i++)
+		INIT_LIST_HEAD(&wcd->dai[i].slim_ch_list);
+
+	return wcd9335_setup_irqs(wcd);
+}
+
+static void wcd9335_codec_remove(struct snd_soc_component *comp)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
+
+	free_irq(regmap_irq_get_virq(wcd->irq_data, WCD9335_IRQ_SLIMBUS), wcd);
+}
+
+static int wcd9335_codec_set_sysclk(struct snd_soc_component *comp,
+				    int clk_id, int source,
+				    unsigned int freq, int dir)
+{
+	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
+
+	wcd->mclk_rate = freq;
+
+	if (wcd->mclk_rate == WCD9335_MCLK_CLK_12P288MHZ)
+		snd_soc_component_update_bits(comp,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_12P288MHZ);
+	else if (wcd->mclk_rate == WCD9335_MCLK_CLK_9P6MHZ)
+		snd_soc_component_update_bits(comp,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,
+				WCD9335_CODEC_RPM_CLK_MCLK_CFG_9P6MHZ);
+
+	return clk_set_rate(wcd->mclk, freq);
+}
+
+static const struct snd_soc_component_driver wcd9335_component_drv = {
+	.probe = wcd9335_codec_probe,
+	.remove = wcd9335_codec_remove,
+	.set_sysclk = wcd9335_codec_set_sysclk,
+};
+
+static int wcd9335_probe(struct wcd9335_codec *wcd)
+{
+	struct device *dev = wcd->dev;
+
+	memcpy(wcd->rx_chs, wcd9335_rx_chs, sizeof(wcd9335_rx_chs));
+
+	wcd->sido_input_src = SIDO_SOURCE_INTERNAL;
+	wcd->sido_voltage = SIDO_VOLTAGE_NOMINAL_MV;
+
+	return devm_snd_soc_register_component(dev, &wcd9335_component_drv,
+					       wcd9335_slim_dais,
+					       ARRAY_SIZE(wcd9335_slim_dais));
+}
+
+static const struct regmap_range_cfg wcd9335_ranges[] = {
+	{
+		.name = "WCD9335",
+		.range_min =  0x0,
+		.range_max =  WCD9335_MAX_REGISTER,
+		.selector_reg = WCD9335_REG(0x0, 0),
+		.selector_mask = 0xff,
+		.selector_shift = 0,
+		.window_start = 0x0,
+		.window_len = 0x1000,
+	},
+};
+
+static bool wcd9335_is_volatile_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WCD9335_INTR_PIN1_STATUS0...WCD9335_INTR_PIN2_CLEAR3:
+	case WCD9335_ANA_MBHC_RESULT_3:
+	case WCD9335_ANA_MBHC_RESULT_2:
+	case WCD9335_ANA_MBHC_RESULT_1:
+	case WCD9335_ANA_MBHC_MECH:
+	case WCD9335_ANA_MBHC_ELECT:
+	case WCD9335_ANA_MBHC_ZDET:
+	case WCD9335_ANA_MICB2:
+	case WCD9335_ANA_RCO:
+	case WCD9335_ANA_BIAS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static struct regmap_config wcd9335_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = WCD9335_MAX_REGISTER,
+	.can_multi_write = true,
+	.ranges = wcd9335_ranges,
+	.num_ranges = ARRAY_SIZE(wcd9335_ranges),
+	.volatile_reg = wcd9335_is_volatile_register,
+};
+
+static const struct regmap_range_cfg wcd9335_ifc_ranges[] = {
+	{
+		.name = "WCD9335-IFC-DEV",
+		.range_min =  0x0,
+		.range_max = WCD9335_REG(0, 0x7ff),
+		.selector_reg = WCD9335_REG(0, 0x0),
+		.selector_mask = 0xff,
+		.selector_shift = 0,
+		.window_start = 0x0,
+		.window_len = 0x1000,
+	},
+};
+
+static struct regmap_config wcd9335_ifc_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.can_multi_write = true,
+	.max_register = WCD9335_REG(0, 0x7FF),
+	.ranges = wcd9335_ifc_ranges,
+	.num_ranges = ARRAY_SIZE(wcd9335_ifc_ranges),
+};
+
+static const struct regmap_irq wcd9335_codec_irqs[] = {
+	/* INTR_REG 0 */
+	[WCD9335_IRQ_SLIMBUS] = {
+		.reg_offset = 0,
+		.mask = BIT(0),
+		.type = {
+			.type_reg_offset = 0,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+			.type_reg_mask	= BIT(0),
+		},
+	},
+};
+
+static const struct regmap_irq_chip wcd9335_regmap_irq1_chip = {
+	.name = "wcd9335_pin1_irq",
+	.status_base = WCD9335_INTR_PIN1_STATUS0,
+	.mask_base = WCD9335_INTR_PIN1_MASK0,
+	.ack_base = WCD9335_INTR_PIN1_CLEAR0,
+	.type_base = WCD9335_INTR_LEVEL0,
+	.num_type_reg = 4,
+	.num_regs = 4,
+	.irqs = wcd9335_codec_irqs,
+	.num_irqs = ARRAY_SIZE(wcd9335_codec_irqs),
+};
+
+static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
+{
+	struct device *dev = wcd->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	wcd->reset_gpio = of_get_named_gpio(np,	"reset-gpios", 0);
+	if (wcd->reset_gpio < 0) {
+		dev_err(dev, "Reset GPIO missing from DT\n");
+		return wcd->reset_gpio;
+	}
+
+	wcd->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(wcd->mclk)) {
+		dev_err(dev, "mclk not found\n");
+		return PTR_ERR(wcd->mclk);
+	}
+
+	wcd->native_clk = devm_clk_get(dev, "slimbus");
+	if (IS_ERR(wcd->native_clk)) {
+		dev_err(dev, "slimbus clock not found\n");
+		return PTR_ERR(wcd->native_clk);
+	}
+
+	wcd->supplies[0].supply = "vdd-buck";
+	wcd->supplies[1].supply = "vdd-buck-sido";
+	wcd->supplies[2].supply = "vdd-tx";
+	wcd->supplies[3].supply = "vdd-rx";
+	wcd->supplies[4].supply = "vdd-io";
+
+	ret = regulator_bulk_get(dev, WCD9335_MAX_SUPPLY, wcd->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int wcd9335_power_on_reset(struct wcd9335_codec *wcd)
+{
+	struct device *dev = wcd->dev;
+	int ret;
+
+	ret = regulator_bulk_enable(WCD9335_MAX_SUPPLY, wcd->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * For WCD9335, it takes about 600us for the Vout_A and
+	 * Vout_D to be ready after BUCK_SIDO is powered up.
+	 * SYS_RST_N shouldn't be pulled high during this time
+	 * Toggle the reset line to make sure the reset pulse is
+	 * correctly applied
+	 */
+	usleep_range(600, 650);
+
+	gpio_direction_output(wcd->reset_gpio, 0);
+	msleep(20);
+	gpio_set_value(wcd->reset_gpio, 1);
+	msleep(20);
+
+	return 0;
+}
+
+static int wcd9335_bring_up(struct wcd9335_codec *wcd)
+{
+	struct regmap *rm = wcd->regmap;
+	int val, byte0;
+
+	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_EFUSE_VAL_OUT0, &val);
+	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_CHIP_ID_BYTE0, &byte0);
+
+	if ((val < 0) || (byte0 < 0)) {
+		dev_err(wcd->dev, "WCD9335 CODEC version detection fail!\n");
+		return -EINVAL;
+	}
+
+	if (byte0 == 0x1) {
+		dev_info(wcd->dev, "WCD9335 CODEC version is v2.0\n");
+		wcd->version = WCD9335_VERSION_2_0;
+		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x01);
+		regmap_write(rm, WCD9335_SIDO_SIDO_TEST_2, 0x00);
+		regmap_write(rm, WCD9335_SIDO_SIDO_CCL_8, 0x6F);
+		regmap_write(rm, WCD9335_BIAS_VBG_FINE_ADJ, 0x65);
+		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x5);
+		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x7);
+		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x3);
+		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x3);
+	} else {
+		dev_err(wcd->dev, "WCD9335 CODEC version not supported\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int wcd9335_irq_init(struct wcd9335_codec *wcd)
+{
+	int ret;
+
+	/*
+	 * INTR1 consists of all possible interrupt sources Ear OCP,
+	 * HPH OCP, MBHC, MAD, VBAT, and SVA
+	 * INTR2 is a subset of first interrupt sources MAD, VBAT, and SVA
+	 */
+	wcd->intr1 = of_irq_get_byname(wcd->dev->of_node, "intr1");
+	if (wcd->intr1 < 0) {
+		if (wcd->intr1 != -EPROBE_DEFER)
+			dev_err(wcd->dev, "Unable to configure IRQ\n");
+
+		return wcd->intr1;
+	}
+
+	ret = devm_regmap_add_irq_chip(wcd->dev, wcd->regmap, wcd->intr1,
+				 IRQF_TRIGGER_HIGH, 0,
+				 &wcd9335_regmap_irq1_chip, &wcd->irq_data);
+	if (ret)
+		dev_err(wcd->dev, "Failed to register IRQ chip: %d\n", ret);
+
+	return ret;
+}
+
+static int wcd9335_slim_probe(struct slim_device *slim)
+{
+	struct device *dev = &slim->dev;
+	struct wcd9335_codec *wcd;
+	int ret;
+
+	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
+	if (!wcd)
+		return	-ENOMEM;
+
+	wcd->dev = dev;
+	ret = wcd9335_parse_dt(wcd);
+	if (ret) {
+		dev_err(dev, "Error parsing DT: %d\n", ret);
+		return ret;
+	}
+
+	ret = wcd9335_power_on_reset(wcd);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, wcd);
+
+	return 0;
+}
+
+static int wcd9335_slim_status(struct slim_device *sdev,
+			       enum slim_device_status status)
+{
+	struct device *dev = &sdev->dev;
+	struct device_node *ifc_dev_np;
+	struct wcd9335_codec *wcd;
+	int ret;
+
+	wcd = dev_get_drvdata(dev);
+
+	ifc_dev_np = of_parse_phandle(dev->of_node, "slim-ifc-dev", 0);
+	if (!ifc_dev_np) {
+		dev_err(dev, "No Interface device found\n");
+		return -EINVAL;
+	}
+
+	wcd->slim = sdev;
+	wcd->slim_ifc_dev = of_slim_get_device(sdev->ctrl, ifc_dev_np);
+	if (!wcd->slim_ifc_dev) {
+		dev_err(dev, "Unable to get SLIM Interface device\n");
+		return -EINVAL;
+	}
+
+	slim_get_logical_addr(wcd->slim_ifc_dev);
+
+	wcd->regmap = regmap_init_slimbus(sdev, &wcd9335_regmap_config);
+	if (IS_ERR(wcd->regmap)) {
+		dev_err(dev, "Failed to allocate slim register map\n");
+		return PTR_ERR(wcd->regmap);
+	}
+
+	wcd->if_regmap = regmap_init_slimbus(wcd->slim_ifc_dev,
+						  &wcd9335_ifc_regmap_config);
+	if (IS_ERR(wcd->if_regmap)) {
+		dev_err(dev, "Failed to allocate ifc register map\n");
+		return PTR_ERR(wcd->if_regmap);
+	}
+
+	ret = wcd9335_bring_up(wcd);
+	if (ret) {
+		dev_err(dev, "Failed to bringup WCD9335\n");
+		return ret;
+	}
+
+	ret = wcd9335_irq_init(wcd);
+	if (ret)
+		return ret;
+
+	wcd9335_probe(wcd);
+
+	return ret;
+}
+
+static const struct slim_device_id wcd9335_slim_id[] = {
+	{SLIM_MANF_ID_QCOM, SLIM_PROD_CODE_WCD9335, 0x1, 0x0},
+	{}
+};
+
+static struct slim_driver wcd9335_slim_driver = {
+	.driver = {
+		.name = "wcd9335-slim",
+	},
+	.probe = wcd9335_slim_probe,
+	.device_status = wcd9335_slim_status,
+	.id_table = wcd9335_slim_id,
+};
+
+module_slim_driver(wcd9335_slim_driver);
+MODULE_DESCRIPTION("WCD9335 slim driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wcd9335.h b/sound/soc/codecs/wcd9335.h
new file mode 100644
index 000000000000..4d9be2496c30
--- /dev/null
+++ b/sound/soc/codecs/wcd9335.h
@@ -0,0 +1,640 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __WCD9335_H__
+#define __WCD9335_H__
+
+/*
+ * WCD9335 register base can change according to the mode it works in
+ * in slimbus mode the reg base starts from 0x800
+ * in i2s/i2c mode the reg base is 0x0
+ */
+#define WCD9335_REG(pg, r)	((pg << 12) | (r) | 0x800)
+#define WCD9335_REG_OFFSET(r)	(r & 0xFF)
+#define WCD9335_PAGE_OFFSET(r)	((r >> 12) & 0xFF)
+
+/* Page-0 Registers */
+#define WCD9335_PAGE0_PAGE_REGISTER		WCD9335_REG(0x00, 0x000)
+#define WCD9335_CODEC_RPM_CLK_GATE		WCD9335_REG(0x00, 0x002)
+#define WCD9335_CODEC_RPM_CLK_GATE_MCLK_GATE_MASK	GENMASK(1, 0)
+#define WCD9335_CODEC_RPM_CLK_MCLK_CFG		WCD9335_REG(0x00, 0x003)
+#define WCD9335_CODEC_RPM_CLK_MCLK_CFG_9P6MHZ	BIT(0)
+#define WCD9335_CODEC_RPM_CLK_MCLK_CFG_12P288MHZ	BIT(0)
+#define WCD9335_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK	GENMASK(1, 0)
+#define WCD9335_CODEC_RPM_RST_CTL		WCD9335_REG(0x00, 0x009)
+#define WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL	WCD9335_REG(0x00, 0x011)
+#define WCD9335_CHIP_TIER_CTRL_CHIP_ID_BYTE0	WCD9335_REG(0x00, 0x021)
+#define WCD9335_CHIP_TIER_CTRL_EFUSE_CTL	WCD9335_REG(0x00, 0x025)
+#define WCD9335_CHIP_TIER_CTRL_EFUSE_SSTATE_MASK GENMASK(4, 1)
+#define WCD9335_CHIP_TIER_CTRL_EFUSE_EN_MASK	BIT(0)
+#define WCD9335_CHIP_TIER_CTRL_EFUSE_ENABLE	BIT(0)
+#define WCD9335_CHIP_TIER_CTRL_EFUSE_VAL_OUT0	WCD9335_REG(0x00, 0x029)
+#define WCD9335_CHIP_TIER_CTRL_EFUSE_STATUS	WCD9335_REG(0x00, 0x039)
+#define WCD9335_INTR_CFG			WCD9335_REG(0x00, 0x081)
+#define WCD9335_INTR_CLR_COMMIT			WCD9335_REG(0x00, 0x082)
+#define WCD9335_INTR_PIN1_MASK0			WCD9335_REG(0x00, 0x089)
+#define WCD9335_INTR_PIN1_MASK1			WCD9335_REG(0x00, 0x08a)
+#define WCD9335_INTR_PIN1_MASK2			WCD9335_REG(0x00, 0x08b)
+#define WCD9335_INTR_PIN1_MASK3			WCD9335_REG(0x00, 0x08c)
+#define WCD9335_INTR_PIN1_STATUS0		WCD9335_REG(0x00, 0x091)
+#define WCD9335_INTR_PIN1_STATUS1		WCD9335_REG(0x00, 0x092)
+#define WCD9335_INTR_PIN1_STATUS2		WCD9335_REG(0x00, 0x093)
+#define WCD9335_INTR_PIN1_STATUS3		WCD9335_REG(0x00, 0x094)
+#define WCD9335_INTR_PIN1_CLEAR0		WCD9335_REG(0x00, 0x099)
+#define WCD9335_INTR_PIN1_CLEAR1		WCD9335_REG(0x00, 0x09a)
+#define WCD9335_INTR_PIN1_CLEAR2		WCD9335_REG(0x00, 0x09b)
+#define WCD9335_INTR_PIN1_CLEAR3		WCD9335_REG(0x00, 0x09c)
+#define WCD9335_INTR_PIN2_MASK0			WCD9335_REG(0x00, 0x0a1)
+#define WCD9335_INTR_PIN2_MASK1			WCD9335_REG(0x00, 0x0a2)
+#define WCD9335_INTR_PIN2_MASK2			WCD9335_REG(0x00, 0x0a3)
+#define WCD9335_INTR_PIN2_MASK3			WCD9335_REG(0x00, 0x0a4)
+#define WCD9335_INTR_PIN2_STATUS0		WCD9335_REG(0x00, 0x0a9)
+#define WCD9335_INTR_PIN2_STATUS1		WCD9335_REG(0x00, 0x0aa)
+#define WCD9335_INTR_PIN2_STATUS2		WCD9335_REG(0x00, 0x0ab)
+#define WCD9335_INTR_PIN2_STATUS3		WCD9335_REG(0x00, 0x0ac)
+#define WCD9335_INTR_PIN2_CLEAR0		WCD9335_REG(0x00, 0x0b1)
+#define WCD9335_INTR_PIN2_CLEAR1		WCD9335_REG(0x00, 0x0b2)
+#define WCD9335_INTR_PIN2_CLEAR2		WCD9335_REG(0x00, 0x0b3)
+#define WCD9335_INTR_PIN2_CLEAR3		WCD9335_REG(0x00, 0x0b4)
+#define WCD9335_INTR_LEVEL0			WCD9335_REG(0x00, 0x0e1)
+#define WCD9335_INTR_LEVEL1			WCD9335_REG(0x00, 0x0e2)
+#define WCD9335_INTR_LEVEL2			WCD9335_REG(0x00, 0x0e3)
+#define WCD9335_INTR_LEVEL3			WCD9335_REG(0x00, 0x0e4)
+
+/* Page-1 Registers */
+#define WCD9335_CPE_FLL_USER_CTL_0		WCD9335_REG(0x01, 0x001)
+#define WCD9335_CPE_FLL_USER_CTL_1		WCD9335_REG(0x01, 0x002)
+#define WCD9335_CPE_FLL_USER_CTL_2		WCD9335_REG(0x01, 0x003)
+#define WCD9335_CPE_FLL_USER_CTL_3		WCD9335_REG(0x01, 0x004)
+#define WCD9335_CPE_FLL_USER_CTL_4		WCD9335_REG(0x01, 0x005)
+#define WCD9335_CPE_FLL_USER_CTL_5		WCD9335_REG(0x01, 0x006)
+#define WCD9335_CPE_FLL_USER_CTL_6		WCD9335_REG(0x01, 0x007)
+#define WCD9335_CPE_FLL_USER_CTL_7		WCD9335_REG(0x01, 0x008)
+#define WCD9335_CPE_FLL_USER_CTL_8		WCD9335_REG(0x01, 0x009)
+#define WCD9335_CPE_FLL_USER_CTL_9		WCD9335_REG(0x01, 0x00a)
+#define WCD9335_CPE_FLL_L_VAL_CTL_0		WCD9335_REG(0x01, 0x00b)
+#define WCD9335_CPE_FLL_L_VAL_CTL_1		WCD9335_REG(0x01, 0x00c)
+#define WCD9335_CPE_FLL_DSM_FRAC_CTL_0		WCD9335_REG(0x01, 0x00d)
+#define WCD9335_CPE_FLL_DSM_FRAC_CTL_1		WCD9335_REG(0x01, 0x00e)
+#define WCD9335_CPE_FLL_CONFIG_CTL_0		WCD9335_REG(0x01, 0x00f)
+#define WCD9335_CPE_FLL_CONFIG_CTL_1		WCD9335_REG(0x01, 0x010)
+#define WCD9335_CPE_FLL_CONFIG_CTL_2		WCD9335_REG(0x01, 0x011)
+#define WCD9335_CPE_FLL_CONFIG_CTL_3		WCD9335_REG(0x01, 0x012)
+#define WCD9335_CPE_FLL_CONFIG_CTL_4		WCD9335_REG(0x01, 0x013)
+#define WCD9335_CPE_FLL_TEST_CTL_0		WCD9335_REG(0x01, 0x014)
+#define WCD9335_CPE_FLL_TEST_CTL_1		WCD9335_REG(0x01, 0x015)
+#define WCD9335_CPE_FLL_TEST_CTL_2		WCD9335_REG(0x01, 0x016)
+#define WCD9335_CPE_FLL_TEST_CTL_3		WCD9335_REG(0x01, 0x017)
+#define WCD9335_CPE_FLL_TEST_CTL_4		WCD9335_REG(0x01, 0x018)
+#define WCD9335_CPE_FLL_TEST_CTL_5		WCD9335_REG(0x01, 0x019)
+#define WCD9335_CPE_FLL_TEST_CTL_6		WCD9335_REG(0x01, 0x01a)
+#define WCD9335_CPE_FLL_TEST_CTL_7		WCD9335_REG(0x01, 0x01b)
+#define WCD9335_CPE_FLL_FREQ_CTL_0		WCD9335_REG(0x01, 0x01c)
+#define WCD9335_CPE_FLL_FREQ_CTL_1		WCD9335_REG(0x01, 0x01d)
+#define WCD9335_CPE_FLL_FREQ_CTL_2		WCD9335_REG(0x01, 0x01e)
+#define WCD9335_CPE_FLL_FREQ_CTL_3		WCD9335_REG(0x01, 0x01f)
+#define WCD9335_CPE_FLL_SSC_CTL_0		WCD9335_REG(0x01, 0x020)
+#define WCD9335_CPE_FLL_SSC_CTL_1		WCD9335_REG(0x01, 0x021)
+#define WCD9335_CPE_FLL_SSC_CTL_2		WCD9335_REG(0x01, 0x022)
+#define WCD9335_CPE_FLL_SSC_CTL_3		WCD9335_REG(0x01, 0x023)
+#define WCD9335_CPE_FLL_FLL_MODE		WCD9335_REG(0x01, 0x024)
+#define WCD9335_CPE_FLL_STATUS_0		WCD9335_REG(0x01, 0x025)
+#define WCD9335_CPE_FLL_STATUS_1		WCD9335_REG(0x01, 0x026)
+#define WCD9335_CPE_FLL_STATUS_2		WCD9335_REG(0x01, 0x027)
+#define WCD9335_CPE_FLL_STATUS_3		WCD9335_REG(0x01, 0x028)
+#define WCD9335_I2S_FLL_USER_CTL_0		WCD9335_REG(0x01, 0x041)
+#define WCD9335_I2S_FLL_USER_CTL_1		WCD9335_REG(0x01, 0x042)
+#define WCD9335_I2S_FLL_USER_CTL_2		WCD9335_REG(0x01, 0x043)
+#define WCD9335_I2S_FLL_USER_CTL_3		WCD9335_REG(0x01, 0x044)
+#define WCD9335_I2S_FLL_USER_CTL_4		WCD9335_REG(0x01, 0x045)
+#define WCD9335_I2S_FLL_USER_CTL_5		WCD9335_REG(0x01, 0x046)
+#define WCD9335_I2S_FLL_USER_CTL_6		WCD9335_REG(0x01, 0x047)
+#define WCD9335_I2S_FLL_USER_CTL_7		WCD9335_REG(0x01, 0x048)
+#define WCD9335_I2S_FLL_USER_CTL_8		WCD9335_REG(0x01, 0x049)
+#define WCD9335_I2S_FLL_USER_CTL_9		WCD9335_REG(0x01, 0x04a)
+#define WCD9335_I2S_FLL_L_VAL_CTL_0		WCD9335_REG(0x01, 0x04b)
+#define WCD9335_I2S_FLL_L_VAL_CTL_1		WCD9335_REG(0x01, 0x04c)
+#define WCD9335_I2S_FLL_DSM_FRAC_CTL_0		WCD9335_REG(0x01, 0x04d)
+#define WCD9335_I2S_FLL_DSM_FRAC_CTL_1		WCD9335_REG(0x01, 0x04e)
+#define WCD9335_I2S_FLL_CONFIG_CTL_0		WCD9335_REG(0x01, 0x04f)
+#define WCD9335_I2S_FLL_CONFIG_CTL_1		WCD9335_REG(0x01, 0x050)
+#define WCD9335_I2S_FLL_CONFIG_CTL_2		WCD9335_REG(0x01, 0x051)
+#define WCD9335_I2S_FLL_CONFIG_CTL_3		WCD9335_REG(0x01, 0x052)
+#define WCD9335_I2S_FLL_CONFIG_CTL_4		WCD9335_REG(0x01, 0x053)
+#define WCD9335_I2S_FLL_TEST_CTL_0		WCD9335_REG(0x01, 0x054)
+#define WCD9335_I2S_FLL_TEST_CTL_1		WCD9335_REG(0x01, 0x055)
+#define WCD9335_I2S_FLL_TEST_CTL_2		WCD9335_REG(0x01, 0x056)
+#define WCD9335_I2S_FLL_TEST_CTL_3		WCD9335_REG(0x01, 0x057)
+#define WCD9335_I2S_FLL_TEST_CTL_4		WCD9335_REG(0x01, 0x058)
+#define WCD9335_I2S_FLL_TEST_CTL_5		WCD9335_REG(0x01, 0x059)
+#define WCD9335_I2S_FLL_TEST_CTL_6		WCD9335_REG(0x01, 0x05a)
+#define WCD9335_I2S_FLL_TEST_CTL_7		WCD9335_REG(0x01, 0x05b)
+#define WCD9335_I2S_FLL_FREQ_CTL_0		WCD9335_REG(0x01, 0x05c)
+#define WCD9335_I2S_FLL_FREQ_CTL_1		WCD9335_REG(0x01, 0x05d)
+#define WCD9335_I2S_FLL_FREQ_CTL_2		WCD9335_REG(0x01, 0x05e)
+#define WCD9335_I2S_FLL_FREQ_CTL_3		WCD9335_REG(0x01, 0x05f)
+#define WCD9335_I2S_FLL_SSC_CTL_0		WCD9335_REG(0x01, 0x060)
+#define WCD9335_I2S_FLL_SSC_CTL_1		WCD9335_REG(0x01, 0x061)
+#define WCD9335_I2S_FLL_SSC_CTL_2		WCD9335_REG(0x01, 0x062)
+#define WCD9335_I2S_FLL_SSC_CTL_3		WCD9335_REG(0x01, 0x063)
+#define WCD9335_I2S_FLL_FLL_MODE		WCD9335_REG(0x01, 0x064)
+#define WCD9335_I2S_FLL_STATUS_0		WCD9335_REG(0x01, 0x065)
+#define WCD9335_I2S_FLL_STATUS_1		WCD9335_REG(0x01, 0x066)
+#define WCD9335_I2S_FLL_STATUS_2		WCD9335_REG(0x01, 0x067)
+#define WCD9335_I2S_FLL_STATUS_3		WCD9335_REG(0x01, 0x068)
+#define WCD9335_SB_FLL_USER_CTL_0		WCD9335_REG(0x01, 0x081)
+#define WCD9335_SB_FLL_USER_CTL_1		WCD9335_REG(0x01, 0x082)
+#define WCD9335_SB_FLL_USER_CTL_2		WCD9335_REG(0x01, 0x083)
+#define WCD9335_SB_FLL_USER_CTL_3		WCD9335_REG(0x01, 0x084)
+#define WCD9335_SB_FLL_USER_CTL_4		WCD9335_REG(0x01, 0x085)
+#define WCD9335_SB_FLL_USER_CTL_5		WCD9335_REG(0x01, 0x086)
+#define WCD9335_SB_FLL_USER_CTL_6		WCD9335_REG(0x01, 0x087)
+#define WCD9335_SB_FLL_USER_CTL_7		WCD9335_REG(0x01, 0x088)
+#define WCD9335_SB_FLL_USER_CTL_8		WCD9335_REG(0x01, 0x089)
+#define WCD9335_SB_FLL_USER_CTL_9		WCD9335_REG(0x01, 0x08a)
+#define WCD9335_SB_FLL_L_VAL_CTL_0		WCD9335_REG(0x01, 0x08b)
+#define WCD9335_SB_FLL_L_VAL_CTL_1		WCD9335_REG(0x01, 0x08c)
+#define WCD9335_SB_FLL_DSM_FRAC_CTL_0		WCD9335_REG(0x01, 0x08d)
+#define WCD9335_SB_FLL_DSM_FRAC_CTL_1		WCD9335_REG(0x01, 0x08e)
+#define WCD9335_SB_FLL_CONFIG_CTL_0		WCD9335_REG(0x01, 0x08f)
+#define WCD9335_SB_FLL_CONFIG_CTL_1		WCD9335_REG(0x01, 0x090)
+#define WCD9335_SB_FLL_CONFIG_CTL_2		WCD9335_REG(0x01, 0x091)
+#define WCD9335_SB_FLL_CONFIG_CTL_3		WCD9335_REG(0x01, 0x092)
+#define WCD9335_SB_FLL_CONFIG_CTL_4		WCD9335_REG(0x01, 0x093)
+#define WCD9335_SB_FLL_TEST_CTL_0		WCD9335_REG(0x01, 0x094)
+#define WCD9335_SB_FLL_TEST_CTL_1		WCD9335_REG(0x01, 0x095)
+#define WCD9335_SB_FLL_TEST_CTL_2		WCD9335_REG(0x01, 0x096)
+#define WCD9335_SB_FLL_TEST_CTL_3		WCD9335_REG(0x01, 0x097)
+#define WCD9335_SB_FLL_TEST_CTL_4		WCD9335_REG(0x01, 0x098)
+#define WCD9335_SB_FLL_TEST_CTL_5		WCD9335_REG(0x01, 0x099)
+#define WCD9335_SB_FLL_TEST_CTL_6		WCD9335_REG(0x01, 0x09a)
+#define WCD9335_SB_FLL_TEST_CTL_7		WCD9335_REG(0x01, 0x09b)
+#define WCD9335_SB_FLL_FREQ_CTL_0		WCD9335_REG(0x01, 0x09c)
+#define WCD9335_SB_FLL_FREQ_CTL_1		WCD9335_REG(0x01, 0x09d)
+#define WCD9335_SB_FLL_FREQ_CTL_2		WCD9335_REG(0x01, 0x09e)
+#define WCD9335_SB_FLL_FREQ_CTL_3		WCD9335_REG(0x01, 0x09f)
+#define WCD9335_SB_FLL_SSC_CTL_0		WCD9335_REG(0x01, 0x0a0)
+#define WCD9335_SB_FLL_SSC_CTL_1		WCD9335_REG(0x01, 0x0a1)
+#define WCD9335_SB_FLL_SSC_CTL_2		WCD9335_REG(0x01, 0x0a2)
+#define WCD9335_SB_FLL_SSC_CTL_3		WCD9335_REG(0x01, 0x0a3)
+#define WCD9335_SB_FLL_FLL_MODE			WCD9335_REG(0x01, 0x0a4)
+#define WCD9335_SB_FLL_STATUS_0			WCD9335_REG(0x01, 0x0a5)
+#define WCD9335_SB_FLL_STATUS_1			WCD9335_REG(0x01, 0x0a6)
+#define WCD9335_SB_FLL_STATUS_2			WCD9335_REG(0x01, 0x0a7)
+#define WCD9335_SB_FLL_STATUS_3			WCD9335_REG(0x01, 0x0a8)
+
+/* Page-2 Registers */
+#define WCD9335_PAGE2_PAGE_REGISTER		WCD9335_REG(0x02, 0x000)
+#define WCD9335_CPE_SS_DMIC0_CTL		WCD9335_REG(0x02, 0x063)
+#define WCD9335_CPE_SS_DMIC1_CTL		WCD9335_REG(0x02, 0x064)
+#define WCD9335_CPE_SS_DMIC2_CTL		WCD9335_REG(0x02, 0x065)
+#define WCD9335_CPE_SS_DMIC_CFG			WCD9335_REG(0x02, 0x066)
+#define WCD9335_SOC_MAD_AUDIO_CTL_2		WCD9335_REG(0x02, 0x084)
+
+/* Page-6 Registers */
+#define WCD9335_PAGE6_PAGE_REGISTER		WCD9335_REG(0x06, 0x000)
+#define WCD9335_ANA_BIAS			WCD9335_REG(0x06, 0x001)
+#define WCD9335_ANA_BIAS_EN_MASK		BIT(7)
+#define WCD9335_ANA_BIAS_ENABLE			BIT(7)
+#define WCD9335_ANA_BIAS_DISABLE		0
+#define WCD9335_ANA_BIAS_PRECHRG_EN_MASK	BIT(6)
+#define WCD9335_ANA_BIAS_PRECHRG_ENABLE		BIT(6)
+#define WCD9335_ANA_BIAS_PRECHRG_DISABLE	0
+#define WCD9335_ANA_BIAS_PRECHRG_CTL_MODE	BIT(5)
+#define WCD9335_ANA_BIAS_PRECHRG_CTL_MODE_AUTO	BIT(5)
+#define WCD9335_ANA_BIAS_PRECHRG_CTL_MODE_MANUAL	0
+#define WCD9335_ANA_CLK_TOP			WCD9335_REG(0x06, 0x002)
+#define WCD9335_ANA_CLK_MCLK_EN_MASK		BIT(2)
+#define WCD9335_ANA_CLK_MCLK_ENABLE		BIT(2)
+#define WCD9335_ANA_CLK_MCLK_DISABLE		0
+#define WCD9335_ANA_CLK_MCLK_SRC_MASK		BIT(3)
+#define WCD9335_ANA_CLK_MCLK_SRC_RCO		BIT(3)
+#define WCD9335_ANA_CLK_MCLK_SRC_EXTERNAL	0
+#define WCD9335_ANA_CLK_EXT_CLKBUF_EN_MASK	BIT(7)
+#define WCD9335_ANA_CLK_EXT_CLKBUF_ENABLE	BIT(7)
+#define WCD9335_ANA_CLK_EXT_CLKBUF_DISABLE	0
+#define WCD9335_ANA_RCO				WCD9335_REG(0x06, 0x003)
+#define WCD9335_ANA_RCO_BG_EN_MASK		BIT(7)
+#define WCD9335_ANA_RCO_BG_ENABLE		BIT(7)
+#define WCD9335_ANA_BUCK_VOUT_D			WCD9335_REG(0x06, 0x005)
+#define WCD9335_ANA_BUCK_VOUT_MASK		GENMASK(7, 0)
+#define WCD9335_ANA_BUCK_CTL			WCD9335_REG(0x06, 0x006)
+#define WCD9335_ANA_BUCK_CTL_VOUT_D_IREF_MASK	BIT(1)
+#define WCD9335_ANA_BUCK_CTL_VOUT_D_IREF_EXT	BIT(1)
+#define WCD9335_ANA_BUCK_CTL_VOUT_D_IREF_INT	0
+#define WCD9335_ANA_BUCK_CTL_VOUT_D_VREF_MASK	BIT(2)
+#define WCD9335_ANA_BUCK_CTL_VOUT_D_VREF_EXT	BIT(2)
+#define WCD9335_ANA_BUCK_CTL_VOUT_D_VREF_INT	0
+#define WCD9335_ANA_BUCK_CTL_RAMP_START_MASK	BIT(7)
+#define WCD9335_ANA_BUCK_CTL_RAMP_START_ENABLE	BIT(7)
+#define WCD9335_ANA_BUCK_CTL_RAMP_START_DISABLE	0
+#define WCD9335_ANA_RX_SUPPLIES			WCD9335_REG(0x06, 0x008)
+#define WCD9335_ANA_RX_BIAS_ENABLE_MASK		BIT(0)
+#define WCD9335_ANA_RX_BIAS_ENABLE		BIT(0)
+#define WCD9335_ANA_RX_BIAS_DISABLE		0
+#define WCD9335_ANA_HPH				WCD9335_REG(0x06, 0x009)
+#define WCD9335_ANA_EAR				WCD9335_REG(0x06, 0x00a)
+#define WCD9335_ANA_LO_1_2			WCD9335_REG(0x06, 0x00b)
+#define WCD9335_ANA_LO_3_4			WCD9335_REG(0x06, 0x00c)
+#define WCD9335_ANA_AMIC1			WCD9335_REG(0x06, 0x00e)
+#define WCD9335_ANA_AMIC2			WCD9335_REG(0x06, 0x00f)
+#define WCD9335_ANA_AMIC3			WCD9335_REG(0x06, 0x010)
+#define WCD9335_ANA_AMIC4			WCD9335_REG(0x06, 0x011)
+#define WCD9335_ANA_AMIC5			WCD9335_REG(0x06, 0x012)
+#define WCD9335_ANA_AMIC6			WCD9335_REG(0x06, 0x013)
+#define WCD9335_ANA_MBHC_MECH			WCD9335_REG(0x06, 0x014)
+#define WCD9335_MBHC_L_DET_EN_MASK		BIT(7)
+#define WCD9335_MBHC_L_DET_EN			BIT(7)
+#define WCD9335_MBHC_GND_DET_EN_MASK		BIT(6)
+#define WCD9335_MBHC_MECH_DETECT_TYPE_MASK	BIT(5)
+#define WCD9335_MBHC_MECH_DETECT_TYPE_SHIFT	5
+#define WCD9335_MBHC_HPHL_PLUG_TYPE_MASK	BIT(4)
+#define WCD9335_MBHC_HPHL_PLUG_TYPE_NO		BIT(4)
+#define WCD9335_MBHC_GND_PLUG_TYPE_MASK		BIT(3)
+#define WCD9335_MBHC_GND_PLUG_TYPE_NO		BIT(3)
+#define WCD9335_MBHC_HSL_PULLUP_COMP_EN		BIT(2)
+#define WCD9335_MBHC_HPHL_100K_TO_GND_EN	BIT(0)
+
+#define WCD9335_ANA_MBHC_ELECT			WCD9335_REG(0x06, 0x015)
+#define WCD9335_ANA_MBHC_BD_ISRC_CTL_MASK	GENMASK(6, 4)
+#define WCD9335_ANA_MBHC_BD_ISRC_100UA		GENMASK(5, 4)
+#define WCD9335_ANA_MBHC_BD_ISRC_OFF		0
+#define WCD9335_ANA_MBHC_BIAS_EN_MASK		BIT(0)
+#define WCD9335_ANA_MBHC_BIAS_EN		BIT(0)
+#define WCD9335_ANA_MBHC_ZDET			WCD9335_REG(0x06, 0x016)
+#define WCD9335_ANA_MBHC_RESULT_1		WCD9335_REG(0x06, 0x017)
+#define WCD9335_ANA_MBHC_RESULT_2		WCD9335_REG(0x06, 0x018)
+#define WCD9335_ANA_MBHC_RESULT_3		WCD9335_REG(0x06, 0x019)
+#define WCD9335_MBHC_BTN_RESULT_MASK		GENMASK(2, 0)
+#define WCD9335_ANA_MBHC_BTN0			WCD9335_REG(0x06, 0x01a)
+#define WCD9335_ANA_MBHC_BTN1			WCD9335_REG(0x06, 0x01b)
+#define WCD9335_ANA_MBHC_BTN2			WCD9335_REG(0x06, 0x01c)
+#define WCD9335_ANA_MBHC_BTN3			WCD9335_REG(0x06, 0x01d)
+#define WCD9335_ANA_MBHC_BTN4			WCD9335_REG(0x06, 0x01e)
+#define WCD9335_ANA_MBHC_BTN5			WCD9335_REG(0x06, 0x01f)
+#define WCD9335_ANA_MBHC_BTN6			WCD9335_REG(0x06, 0x020)
+#define WCD9335_ANA_MBHC_BTN7			WCD9335_REG(0x06, 0x021)
+#define WCD9335_ANA_MICB1			WCD9335_REG(0x06, 0x022)
+#define WCD9335_ANA_MICB2			WCD9335_REG(0x06, 0x023)
+#define WCD9335_ANA_MICB2_ENABLE		BIT(6)
+#define WCD9335_ANA_MICB2_RAMP			WCD9335_REG(0x06, 0x024)
+#define WCD9335_ANA_MICB3			WCD9335_REG(0x06, 0x025)
+#define WCD9335_ANA_MICB4			WCD9335_REG(0x06, 0x026)
+#define WCD9335_ANA_VBADC			WCD9335_REG(0x06, 0x027)
+#define WCD9335_BIAS_VBG_FINE_ADJ		WCD9335_REG(0x06, 0x029)
+#define WCD9335_RCO_CTRL_2			WCD9335_REG(0x06, 0x02f)
+#define WCD9335_SIDO_SIDO_CCL_2			WCD9335_REG(0x06, 0x042)
+#define WCD9335_SIDO_SIDO_CCL_4			WCD9335_REG(0x06, 0x044)
+#define WCD9335_SIDO_SIDO_CCL_8			WCD9335_REG(0x06, 0x048)
+#define WCD9335_SIDO_SIDO_CCL_10		WCD9335_REG(0x06, 0x04a)
+#define WCD9335_SIDO_SIDO_CCL_10_ICHARG_PWR_SEL_C320FF		0x2
+/* Comparator 1 and 2 Bias current at 1P0UA with start pulse width of C320FF */
+#define WCD9335_SIDO_SIDO_CCL_DEF_VALUE		0x6e
+#define WCD9335_SIDO_SIDO_TEST_2		WCD9335_REG(0x06, 0x055)
+#define WCD9335_MBHC_CTL_1			WCD9335_REG(0x06, 0x056)
+#define WCD9335_MBHC_BTN_DBNC_MASK		GENMASK(1, 0)
+#define WCD9335_MBHC_BTN_DBNC_T_16_MS		0x2
+#define WCD9335_MBHC_CTL_RCO_EN_MASK		BIT(7)
+#define WCD9335_MBHC_CTL_RCO_EN			BIT(7)
+
+#define WCD9335_MBHC_CTL_2			WCD9335_REG(0x06, 0x057)
+#define WCD9335_MBHC_HS_VREF_CTL_MASK		GENMASK(1, 0)
+#define WCD9335_MBHC_HS_VREF_1P5_V		0x1
+#define WCD9335_MBHC_PLUG_DETECT_CTL		WCD9335_REG(0x06, 0x058)
+#define WCD9335_MBHC_HSDET_PULLUP_CTL_MASK	GENMASK(7, 6)
+#define WCD9335_MBHC_HSDET_PULLUP_CTL_SHIFT	6
+#define WCD9335_MBHC_HSDET_PULLUP_CTL_1_2P0_UA	0x80
+#define WCD9335_MBHC_DBNC_TIMER_INSREM_DBNC_T_96_MS	0x6
+
+#define WCD9335_MBHC_ZDET_RAMP_CTL		WCD9335_REG(0x06, 0x05a)
+#define WCD9335_VBADC_IBIAS_FE			WCD9335_REG(0x06, 0x05e)
+#define WCD9335_FLYBACK_CTRL_1			WCD9335_REG(0x06, 0x0b1)
+#define WCD9335_RX_BIAS_HPH_PA			WCD9335_REG(0x06, 0x0bb)
+#define WCD9335_RX_BIAS_HPH_PA_AMP_5_UA_MASK	GENMASK(3, 0)
+#define WCD9335_RX_BIAS_HPH_RDACBUFF_CNP2	WCD9335_REG(0x06, 0x0bc)
+#define WCD9335_RX_BIAS_HPH_RDAC_LDO		WCD9335_REG(0x06, 0x0bd)
+#define WCD9335_RX_BIAS_FLYB_BUFF		WCD9335_REG(0x06, 0x0c7)
+#define WCD9335_RX_BIAS_FLYB_VPOS_5_UA_MASK	GENMASK(3, 0)
+#define WCD9335_RX_BIAS_FLYB_I_0P0_UA		0
+#define WCD9335_RX_BIAS_FLYB_VNEG_5_UA_MASK	GENMASK(7, 4)
+#define WCD9335_RX_BIAS_FLYB_MID_RST		WCD9335_REG(0x06, 0x0c8)
+#define WCD9335_HPH_CNP_WG_CTL			WCD9335_REG(0x06, 0x0cc)
+#define WCD9335_HPH_CNP_WG_CTL_CURR_LDIV_MASK	GENMASK(2, 0)
+#define WCD9335_HPH_CNP_WG_CTL_CURR_LDIV_RATIO_500 0x2
+#define WCD9335_HPH_CNP_WG_CTL_CURR_LDIV_RATIO_1000 0x3
+#define WCD9335_HPH_OCP_CTL			WCD9335_REG(0x06, 0x0ce)
+#define WCD9335_HPH_AUTO_CHOP			WCD9335_REG(0x06, 0x0cf)
+#define WCD9335_HPH_AUTO_CHOP_MASK		BIT(5)
+#define WCD9335_HPH_AUTO_CHOP_FORCE_ENABLE		BIT(5)
+#define WCD9335_HPH_AUTO_CHOP_ENABLE_BY_CMPDR_GAIN		0
+#define WCD9335_HPH_PA_CTL1			WCD9335_REG(0x06, 0x0d1)
+#define WCD9335_HPH_PA_GM3_IB_SCALE_MASK		GENMASK(3, 1)
+#define WCD9335_HPH_PA_CTL2			WCD9335_REG(0x06, 0x0d2)
+#define WCD9335_HPH_PA_CTL2_FORCE_PSRREH_MASK	BIT(2)
+#define WCD9335_HPH_PA_CTL2_FORCE_PSRREH_ENABLE	BIT(2)
+#define WCD9335_HPH_PA_CTL2_FORCE_PSRREH_DISABLE 0
+#define WCD9335_HPH_PA_CTL2_FORCE_IQCTRL_MASK	BIT(3)
+#define WCD9335_HPH_PA_CTL2_FORCE_IQCTRL_ENABLE	BIT(3)
+#define WCD9335_HPH_PA_CTL2_FORCE_IQCTRL_DISABLE	0
+#define WCD9335_HPH_PA_CTL2_HPH_PSRR_ENH_MASK	BIT(5)
+#define WCD9335_HPH_PA_CTL2_HPH_PSRR_ENABLE	BIT(5)
+#define WCD9335_HPH_PA_CTL2_HPH_PSRR_DISABLE	0
+#define WCD9335_HPH_L_EN			WCD9335_REG(0x06, 0x0d3)
+#define WCD9335_HPH_CONST_SEL_L_MASK		GENMASK(7, 6)
+#define WCD9335_HPH_CONST_SEL_L_BYPASS		0
+#define WCD9335_HPH_CONST_SEL_L_LP_PATH		0x40
+#define WCD9335_HPH_CONST_SEL_L_HQ_PATH		0x80
+#define WCD9335_HPH_PA_GAIN_MASK		GENMASK(4, 0)
+#define WCD9335_HPH_GAIN_SRC_SEL_MASK		BIT(5)
+#define WCD9335_HPH_GAIN_SRC_SEL_COMPANDER	0
+#define WCD9335_HPH_GAIN_SRC_SEL_REGISTER	BIT(5)
+#define WCD9335_HPH_L_TEST			WCD9335_REG(0x06, 0x0d4)
+#define WCD9335_HPH_R_EN			WCD9335_REG(0x06, 0x0d6)
+#define WCD9335_HPH_R_TEST			WCD9335_REG(0x06, 0x0d7)
+#define WCD9335_HPH_R_ATEST			WCD9335_REG(0x06, 0x0d8)
+#define WCD9335_HPH_RDAC_LDO_CTL		WCD9335_REG(0x06, 0x0db)
+#define WCD9335_HPH_RDAC_N1P65_LD_OUTCTL_MASK	GENMASK(2, 0)
+#define WCD9335_HPH_RDAC_N1P65_LD_OUTCTL_V_N1P60	0x1
+#define WCD9335_HPH_RDAC_1P65_LD_OUTCTL_MASK	GENMASK(6, 4)
+#define WCD9335_HPH_RDAC_1P65_LD_OUTCTL_V_N1P60	0x10
+#define WCD9335_HPH_REFBUFF_LP_CTL		WCD9335_REG(0x06, 0x0de)
+#define WCD9335_HPH_L_DAC_CTL			WCD9335_REG(0x06, 0x0df)
+#define WCD9335_HPH_DAC_LDO_POWERMODE_MASK	BIT(0)
+#define WCD9335_HPH_DAC_LDO_POWERMODE_LOWPOWER	0
+#define WCD9335_HPH_DAC_LDO_POWERMODE_UHQA	BIT(0)
+#define WCD9335_HPH_DAC_LDO_UHQA_OV_MASK	BIT(1)
+#define WCD9335_HPH_DAC_LDO_UHQA_OV_ENABLE	BIT(1)
+#define WCD9335_HPH_DAC_LDO_UHQA_OV_DISABLE	0
+
+#define WCD9335_EAR_CMBUFF			WCD9335_REG(0x06, 0x0e2)
+#define WCD9335_DIFF_LO_LO2_COMPANDER		WCD9335_REG(0x06, 0x0ea)
+#define WCD9335_DIFF_LO_LO1_COMPANDER		WCD9335_REG(0x06, 0x0eb)
+#define WCD9335_DIFF_LO_COM_SWCAP_REFBUF_FREQ	WCD9335_REG(0x06, 0x0f1)
+#define WCD9335_DIFF_LO_COM_PA_FREQ		WCD9335_REG(0x06, 0x0f2)
+#define WCD9335_SE_LO_LO3_GAIN			WCD9335_REG(0x06, 0x0f8)
+#define WCD9335_SE_LO_LO3_CTRL			WCD9335_REG(0x06, 0x0f9)
+#define WCD9335_SE_LO_LO4_GAIN			WCD9335_REG(0x06, 0x0fa)
+
+/* Page-10 Registers */
+#define WCD9335_CDC_TX0_TX_PATH_CTL		WCD9335_REG(0x0a, 0x031)
+#define WCD9335_CDC_TX_PATH_CTL_PCM_RATE_MASK	GENMASK(3, 0)
+#define WCD9335_CDC_TX_PATH_CTL(dec)	WCD9335_REG(0xa, (0x31 + dec * 0x10))
+#define WCD9335_CDC_TX0_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x032)
+#define WCD9335_CDC_TX_ADC_AMIC_DMIC_SEL_MASK	BIT(7)
+#define WCD9335_CDC_TX_ADC_DMIC_SEL		BIT(7)
+#define WCD9335_CDC_TX_ADC_AMIC_SEL		0
+#define WCD9335_CDC_TX0_TX_VOL_CTL		WCD9335_REG(0x0a, 0x034)
+#define WCD9335_CDC_TX0_TX_PATH_SEC2		WCD9335_REG(0x0a, 0x039)
+#define WCD9335_CDC_TX0_TX_PATH_SEC7		WCD9335_REG(0x0a, 0x03e)
+#define WCD9335_CDC_TX1_TX_PATH_CTL		WCD9335_REG(0x0a, 0x041)
+#define WCD9335_CDC_TX1_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x042)
+#define WCD9335_CDC_TX2_TX_PATH_CTL		WCD9335_REG(0x0a, 0x051)
+#define WCD9335_CDC_TX2_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x052)
+#define WCD9335_CDC_TX2_TX_VOL_CTL		WCD9335_REG(0x0a, 0x054)
+#define WCD9335_CDC_TX3_TX_PATH_CTL		WCD9335_REG(0x0a, 0x061)
+#define WCD9335_CDC_TX3_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x062)
+#define WCD9335_CDC_TX3_TX_VOL_CTL		WCD9335_REG(0x0a, 0x064)
+#define WCD9335_CDC_TX4_TX_PATH_CTL		WCD9335_REG(0x0a, 0x071)
+#define WCD9335_CDC_TX4_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x072)
+#define WCD9335_CDC_TX4_TX_VOL_CTL		WCD9335_REG(0x0a, 0x074)
+#define WCD9335_CDC_TX5_TX_PATH_CTL		WCD9335_REG(0x0a, 0x081)
+#define WCD9335_CDC_TX5_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x082)
+#define WCD9335_CDC_TX5_TX_VOL_CTL		WCD9335_REG(0x0a, 0x084)
+#define WCD9335_CDC_TX6_TX_PATH_CTL		WCD9335_REG(0x0a, 0x091)
+#define WCD9335_CDC_TX6_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x092)
+#define WCD9335_CDC_TX6_TX_VOL_CTL		WCD9335_REG(0x0a, 0x094)
+#define WCD9335_CDC_TX7_TX_PATH_CTL		WCD9335_REG(0x0a, 0x0a1)
+#define WCD9335_CDC_TX7_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x0a2)
+#define WCD9335_CDC_TX7_TX_VOL_CTL		WCD9335_REG(0x0a, 0x0a4)
+#define WCD9335_CDC_TX8_TX_PATH_CTL		WCD9335_REG(0x0a, 0x0b1)
+#define WCD9335_CDC_TX8_TX_PATH_CFG0		WCD9335_REG(0x0a, 0x0b2)
+#define WCD9335_CDC_TX8_TX_VOL_CTL		WCD9335_REG(0x0a, 0x0b4)
+#define WCD9335_CDC_TX9_SPKR_PROT_PATH_CFG0	WCD9335_REG(0x0a, 0x0c3)
+#define WCD9335_CDC_TX10_SPKR_PROT_PATH_CFG0	WCD9335_REG(0x0a, 0x0c7)
+#define WCD9335_CDC_TX11_SPKR_PROT_PATH_CFG0	WCD9335_REG(0x0a, 0x0cb)
+#define WCD9335_CDC_TX12_SPKR_PROT_PATH_CFG0	WCD9335_REG(0x0a, 0x0cf)
+
+/* Page-11 Registers */
+#define WCD9335_PAGE11_PAGE_REGISTER		WCD9335_REG(0x0b, 0x000)
+#define WCD9335_CDC_COMPANDER1_CTL0		WCD9335_REG(0x0b, 0x001)
+#define WCD9335_CDC_COMPANDER1_CTL(c)	WCD9335_REG(0x0b, (0x001 + c * 0x8))
+#define WCD9335_CDC_COMPANDER_CLK_EN_MASK	BIT(0)
+#define WCD9335_CDC_COMPANDER_CLK_ENABLE	BIT(0)
+#define WCD9335_CDC_COMPANDER_CLK_DISABLE	0
+#define WCD9335_CDC_COMPANDER_SOFT_RST_MASK	BIT(1)
+#define WCD9335_CDC_COMPANDER_SOFT_RST_ENABLE	BIT(1)
+#define WCD9335_CDC_COMPANDER_SOFT_RST_DISABLE	0
+#define WCD9335_CDC_COMPANDER_HALT_MASK		BIT(2)
+#define WCD9335_CDC_COMPANDER_HALT		BIT(2)
+#define WCD9335_CDC_COMPANDER_NOHALT		0
+#define WCD9335_CDC_COMPANDER7_CTL3		WCD9335_REG(0x0b, 0x034)
+#define WCD9335_CDC_COMPANDER7_CTL7		WCD9335_REG(0x0b, 0x038)
+#define WCD9335_CDC_COMPANDER8_CTL3		WCD9335_REG(0x0b, 0x03c)
+#define WCD9335_CDC_COMPANDER8_CTL7		WCD9335_REG(0x0b, 0x040)
+#define WCD9335_CDC_RX0_RX_PATH_CTL		WCD9335_REG(0x0b, 0x041)
+#define WCD9335_CDC_RX_PGA_MUTE_EN_MASK		BIT(4)
+#define WCD9335_CDC_RX_PGA_MUTE_ENABLE		BIT(4)
+#define WCD9335_CDC_RX_PGA_MUTE_DISABLE		0
+#define WCD9335_CDC_RX_CLK_EN_MASK		BIT(5)
+#define WCD9335_CDC_RX_CLK_ENABLE		BIT(5)
+#define WCD9335_CDC_RX_CLK_DISABLE		0
+#define WCD9335_CDC_RX_RESET_MASK		BIT(6)
+#define WCD9335_CDC_RX_RESET_ENABLE		BIT(6)
+#define WCD9335_CDC_RX_RESET_DISABLE		0
+#define WCD9335_CDC_RX_PATH_CTL(rx)	WCD9335_REG(0x0b, (0x041 + rx * 0x14))
+#define WCD9335_CDC_RX0_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x042)
+#define WCD9335_CDC_RX0_RX_PATH_CFG1		WCD9335_REG(0x0b, 0x043)
+#define WCD9335_CDC_RX0_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x044)
+#define WCD9335_CDC_RX0_RX_VOL_CTL		WCD9335_REG(0x0b, 0x045)
+#define WCD9335_CDC_RX0_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x046)
+#define WCD9335_CDC_MIX_PCM_RATE_MASK		GENMASK(3, 0)
+#define WCD9335_CDC_RX_PATH_MIX_CTL(rx)	WCD9335_REG(0x0b, (0x46 + rx * 0x14))
+#define WCD9335_CDC_RX0_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x047)
+#define WCD9335_CDC_RX0_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x048)
+#define WCD9335_CDC_RX0_RX_PATH_SEC0		WCD9335_REG(0x0b, 0x049)
+#define WCD9335_CDC_RX0_RX_PATH_SEC7		WCD9335_REG(0x0b, 0x050)
+#define WCD9335_CDC_RX0_RX_PATH_MIX_SEC0	WCD9335_REG(0x0b, 0x051)
+#define WCD9335_CDC_RX1_RX_PATH_CTL		WCD9335_REG(0x0b, 0x055)
+#define WCD9335_CDC_RX1_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x056)
+#define WCD9335_CDC_RX1_RX_PATH_CFG(c)	WCD9335_REG(0x0b, (0x056 + c * 0x14))
+#define WCD9335_CDC_RX_PATH_CFG_CMP_EN_MASK	BIT(1)
+#define WCD9335_CDC_RX_PATH_CFG_CMP_ENABLE	BIT(1)
+#define WCD9335_CDC_RX_PATH_CFG_CMP_DISABLE	0
+#define WCD9335_CDC_RX_PATH_CFG_HD2_EN_MASK	BIT(2)
+#define WCD9335_CDC_RX_PATH_CFG_HD2_ENABLE	BIT(2)
+#define WCD9335_CDC_RX_PATH_CFG_HD2_DISABLE	0
+#define WCD9335_CDC_RX_PATH_CFG0_DLY_ZN_EN_MASK	BIT(3)
+#define WCD9335_CDC_RX_PATH_CFG0_DLY_ZN_EN	BIT(3)
+#define WCD9335_CDC_RX_PATH_CFG0_DLY_ZN_DISABLE	0
+#define WCD9335_CDC_RX1_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x058)
+#define WCD9335_CDC_RX1_RX_VOL_CTL		WCD9335_REG(0x0b, 0x059)
+#define WCD9335_CDC_RX1_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x05a)
+#define WCD9335_CDC_RX1_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x05b)
+#define WCD9335_CDC_RX1_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x05c)
+#define WCD9335_CDC_RX1_RX_PATH_SEC0		WCD9335_REG(0x0b, 0x05d)
+#define WCD9335_CDC_RX1_RX_PATH_SEC3		WCD9335_REG(0x0b, 0x060)
+#define WCD9335_CDC_RX_PATH_SEC_HD2_SCALE_MASK	GENMASK(1, 0)
+#define WCD9335_CDC_RX_PATH_SEC_HD2_SCALE_2	0x1
+#define WCD9335_CDC_RX_PATH_SEC_HD2_SCALE_1	0
+#define WCD9335_CDC_RX_PATH_SEC_HD2_ALPHA_MASK	GENMASK(5, 2)
+#define WCD9335_CDC_RX_PATH_SEC_HD2_ALPHA_0P2500	0x10
+#define WCD9335_CDC_RX_PATH_SEC_HD2_ALPHA_0P0000	0
+#define WCD9335_CDC_RX2_RX_PATH_CTL		WCD9335_REG(0x0b, 0x069)
+#define WCD9335_CDC_RX2_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x06a)
+#define WCD9335_CDC_RX2_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x06c)
+#define WCD9335_CDC_RX2_RX_VOL_CTL		WCD9335_REG(0x0b, 0x06d)
+#define WCD9335_CDC_RX2_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x06e)
+#define WCD9335_CDC_RX2_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x06f)
+#define WCD9335_CDC_RX2_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x070)
+#define WCD9335_CDC_RX2_RX_PATH_SEC0		WCD9335_REG(0x0b, 0x071)
+#define WCD9335_CDC_RX_PATH_DEM_INP_SEL_MASK	GENMASK(1, 0)
+#define WCD9335_CDC_RX2_RX_PATH_SEC3		WCD9335_REG(0x0b, 0x074)
+#define WCD9335_CDC_RX3_RX_PATH_CTL		WCD9335_REG(0x0b, 0x07d)
+#define WCD9335_CDC_RX3_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x07e)
+#define WCD9335_CDC_RX3_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x080)
+#define WCD9335_CDC_RX3_RX_VOL_CTL		WCD9335_REG(0x0b, 0x081)
+#define WCD9335_CDC_RX3_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x082)
+#define WCD9335_CDC_RX3_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x083)
+#define WCD9335_CDC_RX3_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x084)
+#define WCD9335_CDC_RX4_RX_PATH_CTL		WCD9335_REG(0x0b, 0x091)
+#define WCD9335_CDC_RX4_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x092)
+#define WCD9335_CDC_RX4_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x094)
+#define WCD9335_CDC_RX4_RX_VOL_CTL		WCD9335_REG(0x0b, 0x095)
+#define WCD9335_CDC_RX4_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x096)
+#define WCD9335_CDC_RX4_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x097)
+#define WCD9335_CDC_RX4_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x098)
+#define WCD9335_CDC_RX5_RX_PATH_CTL		WCD9335_REG(0x0b, 0x0a5)
+#define WCD9335_CDC_RX5_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x0a6)
+#define WCD9335_CDC_RX5_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x0a8)
+#define WCD9335_CDC_RX5_RX_VOL_CTL		WCD9335_REG(0x0b, 0x0a9)
+#define WCD9335_CDC_RX5_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x0aa)
+#define WCD9335_CDC_RX5_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x0ab)
+#define WCD9335_CDC_RX5_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x0ac)
+#define WCD9335_CDC_RX6_RX_PATH_CTL		WCD9335_REG(0x0b, 0x0b9)
+#define WCD9335_CDC_RX6_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x0ba)
+#define WCD9335_CDC_RX6_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x0bc)
+#define WCD9335_CDC_RX6_RX_VOL_CTL		WCD9335_REG(0x0b, 0x0bd)
+#define WCD9335_CDC_RX6_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x0be)
+#define WCD9335_CDC_RX6_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x0bf)
+#define WCD9335_CDC_RX6_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x0c0)
+#define WCD9335_CDC_RX7_RX_PATH_CTL		WCD9335_REG(0x0b, 0x0cd)
+#define WCD9335_CDC_RX7_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x0ce)
+#define WCD9335_CDC_RX7_RX_PATH_CFG1		WCD9335_REG(0x0b, 0x0cf)
+#define WCD9335_CDC_RX7_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x0d0)
+#define WCD9335_CDC_RX7_RX_VOL_CTL		WCD9335_REG(0x0b, 0x0d1)
+#define WCD9335_CDC_RX7_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x0d2)
+#define WCD9335_CDC_RX7_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x0d3)
+#define WCD9335_CDC_RX7_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x0d4)
+#define WCD9335_CDC_RX8_RX_PATH_CTL		WCD9335_REG(0x0b, 0x0e1)
+#define WCD9335_CDC_RX8_RX_PATH_CFG0		WCD9335_REG(0x0b, 0x0e2)
+#define WCD9335_CDC_RX8_RX_PATH_CFG1		WCD9335_REG(0x0b, 0x0e3)
+#define WCD9335_CDC_RX8_RX_PATH_CFG2		WCD9335_REG(0x0b, 0x0e4)
+#define WCD9335_CDC_RX8_RX_VOL_CTL		WCD9335_REG(0x0b, 0x0e5)
+#define WCD9335_CDC_RX8_RX_PATH_MIX_CTL		WCD9335_REG(0x0b, 0x0e6)
+#define WCD9335_CDC_RX8_RX_PATH_MIX_CFG		WCD9335_REG(0x0b, 0x0e7)
+#define WCD9335_CDC_RX8_RX_VOL_MIX_CTL		WCD9335_REG(0x0b, 0x0e8)
+
+/* Page-12 Registers */
+#define WCD9335_PAGE12_PAGE_REGISTER		WCD9335_REG(0x0c, 0x000)
+#define WCD9335_CDC_CLSH_K2_MSB			WCD9335_REG(0x0c, 0x00a)
+#define WCD9335_CDC_CLSH_K2_LSB			WCD9335_REG(0x0c, 0x00b)
+#define WCD9335_CDC_BOOST0_BOOST_CTL		WCD9335_REG(0x0c, 0x01a)
+#define WCD9335_CDC_BOOST0_BOOST_CFG1		WCD9335_REG(0x0c, 0x01b)
+#define WCD9335_CDC_BOOST0_BOOST_CFG2		WCD9335_REG(0x0c, 0x01c)
+#define WCD9335_CDC_BOOST1_BOOST_CTL		WCD9335_REG(0x0c, 0x022)
+#define WCD9335_CDC_BOOST1_BOOST_CFG1		WCD9335_REG(0x0c, 0x023)
+#define WCD9335_CDC_BOOST1_BOOST_CFG2		WCD9335_REG(0x0c, 0x024)
+
+/* Page-13 Registers */
+#define WCD9335_PAGE13_PAGE_REGISTER		WCD9335_REG(0x0d, 0x000)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT0_CFG0	WCD9335_REG(0x0d, 0x001)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT_CFG0(i) WCD9335_REG(0xd, (0x1 + i * 0x2))
+#define WCD9335_CDC_RX_INP_MUX_RX_INT0_CFG1	WCD9335_REG(0xd, 0x002)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT_SEL_MASK	GENMASK(3, 0)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT_CFG1(i) WCD9335_REG(0xd, (0x2 + i * 0x2))
+
+#define WCD9335_CDC_RX_INP_MUX_RX_INT1_CFG0	WCD9335_REG(0x0d, 0x003)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT1_CFG1	WCD9335_REG(0x0d, 0x004)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT2_CFG0	WCD9335_REG(0x0d, 0x005)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT2_CFG1	WCD9335_REG(0x0d, 0x006)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT3_CFG0	WCD9335_REG(0x0d, 0x007)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT3_CFG1	WCD9335_REG(0x0d, 0x008)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT4_CFG0	WCD9335_REG(0x0d, 0x009)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT4_CFG1	WCD9335_REG(0x0d, 0x00a)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT5_CFG0	WCD9335_REG(0x0d, 0x00b)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT5_CFG1	WCD9335_REG(0x0d, 0x00c)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT6_CFG0	WCD9335_REG(0x0d, 0x00d)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT6_CFG1	WCD9335_REG(0x0d, 0x00e)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT7_CFG0	WCD9335_REG(0x0d, 0x00f)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT7_CFG1	WCD9335_REG(0x0d, 0x010)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT8_CFG0	WCD9335_REG(0x0d, 0x011)
+#define WCD9335_CDC_RX_INP_MUX_RX_INT8_CFG1	WCD9335_REG(0x0d, 0x012)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX0_CFG0	WCD9335_REG(0x0d, 0x01d)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX0_CFG1	WCD9335_REG(0x0d, 0x01e)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX1_CFG0	WCD9335_REG(0x0d, 0x01f)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX1_CFG1	WCD9335_REG(0x0d, 0x020)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX2_CFG0	WCD9335_REG(0x0d, 0x021)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX2_CFG1	WCD9335_REG(0x0d, 0x022)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX3_CFG0	WCD9335_REG(0x0d, 0x023)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX3_CFG1	WCD9335_REG(0x0d, 0x024)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX4_CFG0	WCD9335_REG(0x0d, 0x025)
+#define WCD9335_CDC_TX_INP_MUX_SEL_AMIC	0x1
+#define WCD9335_CDC_TX_INP_MUX_SEL_DMIC	0
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX5_CFG0	WCD9335_REG(0x0d, 0x026)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX6_CFG0	WCD9335_REG(0x0d, 0x027)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX7_CFG0	WCD9335_REG(0x0d, 0x028)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX8_CFG0	WCD9335_REG(0x0d, 0x029)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX10_CFG0	WCD9335_REG(0x0d, 0x02b)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX11_CFG0	WCD9335_REG(0x0d, 0x02c)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX12_CFG0	WCD9335_REG(0x0d, 0x02d)
+#define WCD9335_CDC_TX_INP_MUX_ADC_MUX13_CFG0	WCD9335_REG(0x0d, 0x02e)
+#define WCD9335_CDC_IF_ROUTER_TX_MUX_CFG0	WCD9335_REG(0x0d, 0x03a)
+#define WCD9335_CDC_IF_ROUTER_TX_MUX_CFG1	WCD9335_REG(0x0d, 0x03b)
+#define WCD9335_CDC_IF_ROUTER_TX_MUX_CFG2	WCD9335_REG(0x0d, 0x03c)
+#define WCD9335_CDC_IF_ROUTER_TX_MUX_CFG3	WCD9335_REG(0x0d, 0x03d)
+#define WCD9335_CDC_CLK_RST_CTRL_MCLK_CONTROL	WCD9335_REG(0x0d, 0x041)
+#define WCD9335_CDC_CLK_RST_CTRL_MCLK_EN_MASK	BIT(0)
+#define WCD9335_CDC_CLK_RST_CTRL_MCLK_ENABLE	BIT(0)
+#define WCD9335_CDC_CLK_RST_CTRL_MCLK_DISABLE	0
+#define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_CONTROL	WCD9335_REG(0x0d, 0x042)
+#define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_EN_MASK	BIT(0)
+#define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_ENABLE	BIT(0)
+#define WCD9335_CDC_CLK_RST_CTRL_FS_CNT_DISABLE	0
+#define WCD9335_CDC_TOP_TOP_CFG1	WCD9335_REG(0x0d, 0x082)
+#define WCD9335_MAX_REGISTER	WCD9335_REG(0x80, 0x0FF)
+
+/* SLIMBUS Slave Registers */
+#define WCD9335_SLIM_PGD_PORT_INT_EN0	WCD9335_REG(0, 0x30)
+#define WCD9335_SLIM_PGD_PORT_INT_STATUS_RX_0	WCD9335_REG(0, 0x34)
+#define WCD9335_SLIM_PGD_PORT_INT_STATUS_RX_1	WCD9335_REG(0, 0x35)
+#define WCD9335_SLIM_PGD_PORT_INT_STATUS_TX_0	WCD9335_REG(0, 0x36)
+#define WCD9335_SLIM_PGD_PORT_INT_STATUS_TX_1	WCD9335_REG(0, 0x37)
+#define WCD9335_SLIM_PGD_PORT_INT_CLR_RX_0	WCD9335_REG(0, 0x38)
+#define WCD9335_SLIM_PGD_PORT_INT_CLR_RX_1	WCD9335_REG(0, 0x39)
+#define WCD9335_SLIM_PGD_PORT_INT_CLR_TX_0	WCD9335_REG(0, 0x3A)
+#define WCD9335_SLIM_PGD_PORT_INT_CLR_TX_1	WCD9335_REG(0, 0x3B)
+#define WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0	WCD9335_REG(0, 0x60)
+#define WCD9335_SLIM_PGD_PORT_INT_TX_SOURCE0	WCD9335_REG(0, 0x70)
+#define WCD9335_SLIM_PGD_RX_PORT_CFG(p)	WCD9335_REG(0, (0x30 + p))
+#define WCD9335_SLIM_PGD_PORT_CFG(p)	WCD9335_REG(0, (0x40 + p))
+#define WCD9335_SLIM_PGD_TX_PORT_CFG(p)	WCD9335_REG(0, (0x50 + p))
+#define WCD9335_SLIM_PGD_PORT_INT_SRC(p)	WCD9335_REG(0, (0x60 + p))
+#define WCD9335_SLIM_PGD_PORT_INT_STATUS(p)	WCD9335_REG(0, (0x80 + p))
+#define WCD9335_SLIM_PGD_TX_PORT_MULTI_CHNL_0(p) WCD9335_REG(0, (0x100 + 4 * p))
+/* ports range from 10-16 */
+#define WCD9335_SLIM_PGD_TX_PORT_MULTI_CHNL_1(p) WCD9335_REG(0, (0x101 + 4 * p))
+#define WCD9335_SLIM_PGD_RX_PORT_MULTI_CHNL_0(p) WCD9335_REG(0, (0x140 + 4 * p))
+
+#define	WCD9335_IRQ_SLIMBUS			0
+#define	WCD9335_IRQ_MBHC_SW_DET			8
+#define	WCD9335_IRQ_MBHC_ELECT_INS_REM_DET	9
+#define	WCD9335_IRQ_MBHC_BUTTON_PRESS_DET	10
+#define	WCD9335_IRQ_MBHC_BUTTON_RELEASE_DET	11
+#define	WCD9335_IRQ_MBHC_ELECT_INS_REM_LEG_DET	12
+
+#define SLIM_MANF_ID_QCOM			0x217
+#define SLIM_PROD_CODE_WCD9335			0x1a0
+
+#define WCD9335_VERSION_2_0     2
+#define WCD9335_MAX_SUPPLY	5
+
+#endif /* __WCD9335_H__ */
-- 
2.20.1

