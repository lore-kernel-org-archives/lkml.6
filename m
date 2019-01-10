Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36EC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9232177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Og4vUnEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfAJPGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:06:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46586 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbfAJPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:06:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so11714293wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIfagAfw+24prosRgsLet6ibfoEKeofVlJqjin3FUFc=;
        b=Og4vUnEua2uiNCvb35v88H2lXBhTjmSl/vg9ooFbz3sE2+7uAbAcAgdXBjn9Kc2VKT
         UmgYAV5kF3AmkL4ARZ7AELalNELFTqmEUuYjcrzXsrS2VUfc79q4S2x81bg/Agouf7UO
         6zXctFj57f7H85gPJFCQ6ZE1vZahoHg7jxin4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIfagAfw+24prosRgsLet6ibfoEKeofVlJqjin3FUFc=;
        b=o3W+8xMei7lCv6B9HJRF6DJL1ELZmQnagsWoEmk7Eru3GwwUotH3qQfwMNZvg2WwDP
         WAwCYuNMy3FTkIdcI8Yuwk/DagAVMv5Hj0020WMHS8GAWyh8+xpkZa09ZLcQRrbZ5SG0
         D/gaS1ITeKxzwaZvCEJ2lwqrMoWICJjGYwjYJ4uUgiqF1NjKAhCECqNaWtNb56Bf/dru
         Pjhi89dgPuIJnMMQeHHLo3fwlOLocsEaWEKPPjBogDINzksn398sqjtDVSV0rv9KcP4v
         GtoBscWSENJAFWZOF/U7U9Mw6kwmTXzXhNxYHUU3iWvpjTCfKxC7d4Fnt6meedP90Xlt
         4uqw==
X-Gm-Message-State: AJcUukernbxCHWgb7b1w1j7Mlz7CVlt7b0jN7MV+XYSKMCVhaDGFYZvq
        cjF8WnN6Q6+3imOMWSsTPFI9i8awuZM=
X-Google-Smtp-Source: ALg8bN4ECrdyrRxZHbUwiHxOEjEM3yr90IyuIwikIuqG4jSACj8lvcDP5hjLuvwRAIBRFxhEfjFJUA==
X-Received: by 2002:adf:ffca:: with SMTP id x10mr10079543wrs.289.1547132787959;
        Thu, 10 Jan 2019 07:06:27 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b12sm51063754wrt.17.2019.01.10.07.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 07:06:27 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 3/8] ASoC: wcd9335: add CLASS-H Controller support
Date:   Thu, 10 Jan 2019 15:06:11 +0000
Message-Id: <20190110150616.2332-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLASS-H controller/Amplifier is common accorss Qualcomm WCD codec series.
This patchset adds basic CLASS-H controller apis for WCD codecs after
wcd9335 to use.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/Makefile      |   2 +-
 sound/soc/codecs/wcd-clsh-v2.c | 576 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/wcd-clsh-v2.h |  49 +++
 sound/soc/codecs/wcd9335.c     |  10 +
 4 files changed, 636 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.c
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.h

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 1200c200c322..6f7afd84e28d 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -198,7 +198,7 @@ snd-soc-twl4030-objs := twl4030.o
 snd-soc-twl6040-objs := twl6040.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
-snd-soc-wcd9335-objs := wcd9335.o
+snd-soc-wcd9335-objs := wcd-clsh-v2.o wcd9335.o
 snd-soc-wl1273-objs := wl1273.o
 snd-soc-wm-adsp-objs := wm_adsp.o
 snd-soc-wm0010-objs := wm0010.o
diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
new file mode 100644
index 000000000000..1bd70c5a7b63
--- /dev/null
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -0,0 +1,576 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+// Copyright (c) 2017-2018, Linaro Limited
+
+#include <linux/slab.h>
+#include <sound/soc.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include "wcd9335.h"
+#include "wcd-clsh-v2.h"
+
+struct wcd_clsh_ctrl {
+	int state;
+	int mode;
+	int flyback_users;
+	int buck_users;
+	int clsh_users;
+	int codec_version;
+	struct snd_soc_component *comp;
+};
+
+/* Class-H registers for codecs from and above WCD9335 */
+#define WCD9XXX_A_CDC_RX0_RX_PATH_CFG0			WCD9335_REG(0xB, 0x42)
+#define WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK		BIT(6)
+#define WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE		BIT(6)
+#define WCD9XXX_A_CDC_RX_PATH_CLSH_DISABLE		0
+#define WCD9XXX_A_CDC_RX1_RX_PATH_CFG0			WCD9335_REG(0xB, 0x56)
+#define WCD9XXX_A_CDC_RX2_RX_PATH_CFG0			WCD9335_REG(0xB, 0x6A)
+#define WCD9XXX_A_CDC_CLSH_K1_MSB			WCD9335_REG(0xC, 0x08)
+#define WCD9XXX_A_CDC_CLSH_K1_MSB_COEF_MASK		GENMASK(3, 0)
+#define WCD9XXX_A_CDC_CLSH_K1_LSB			WCD9335_REG(0xC, 0x09)
+#define WCD9XXX_A_CDC_CLSH_K1_LSB_COEF_MASK		GENMASK(7, 0)
+#define WCD9XXX_A_ANA_RX_SUPPLIES			WCD9335_REG(0x6, 0x08)
+#define WCD9XXX_A_ANA_RX_REGULATOR_MODE_MASK		BIT(1)
+#define WCD9XXX_A_ANA_RX_REGULATOR_MODE_CLS_H		0
+#define WCD9XXX_A_ANA_RX_REGULATOR_MODE_CLS_AB		BIT(1)
+#define WCD9XXX_A_ANA_RX_VNEG_PWR_LVL_MASK		BIT(2)
+#define WCD9XXX_A_ANA_RX_VNEG_PWR_LVL_UHQA		BIT(2)
+#define WCD9XXX_A_ANA_RX_VNEG_PWR_LVL_DEFAULT		0
+#define WCD9XXX_A_ANA_RX_VPOS_PWR_LVL_MASK		BIT(3)
+#define WCD9XXX_A_ANA_RX_VPOS_PWR_LVL_UHQA		BIT(3)
+#define WCD9XXX_A_ANA_RX_VPOS_PWR_LVL_DEFAULT		0
+#define WCD9XXX_A_ANA_RX_VNEG_EN_MASK			BIT(6)
+#define WCD9XXX_A_ANA_RX_VNEG_EN_SHIFT			6
+#define WCD9XXX_A_ANA_RX_VNEG_ENABLE			BIT(6)
+#define WCD9XXX_A_ANA_RX_VNEG_DISABLE			0
+#define WCD9XXX_A_ANA_RX_VPOS_EN_MASK			BIT(7)
+#define WCD9XXX_A_ANA_RX_VPOS_EN_SHIFT			7
+#define WCD9XXX_A_ANA_RX_VPOS_ENABLE			BIT(7)
+#define WCD9XXX_A_ANA_RX_VPOS_DISABLE			0
+#define WCD9XXX_A_ANA_HPH				WCD9335_REG(0x6, 0x09)
+#define WCD9XXX_A_ANA_HPH_PWR_LEVEL_MASK		GENMASK(3, 2)
+#define WCD9XXX_A_ANA_HPH_PWR_LEVEL_UHQA		0x08
+#define WCD9XXX_A_ANA_HPH_PWR_LEVEL_LP			0x04
+#define WCD9XXX_A_ANA_HPH_PWR_LEVEL_NORMAL		0x0
+#define WCD9XXX_A_CDC_CLSH_CRC				WCD9335_REG(0xC, 0x01)
+#define WCD9XXX_A_CDC_CLSH_CRC_CLK_EN_MASK		BIT(0)
+#define WCD9XXX_A_CDC_CLSH_CRC_CLK_ENABLE		BIT(0)
+#define WCD9XXX_A_CDC_CLSH_CRC_CLK_DISABLE		0
+#define WCD9XXX_FLYBACK_EN				WCD9335_REG(0x6, 0xA4)
+#define WCD9XXX_FLYBACK_EN_DELAY_SEL_MASK		GENMASK(6, 5)
+#define WCD9XXX_FLYBACK_EN_DELAY_26P25_US		0x40
+#define WCD9XXX_FLYBACK_EN_RESET_BY_EXT_MASK		BIT(4)
+#define WCD9XXX_FLYBACK_EN_PWDN_WITHOUT_DELAY		BIT(4)
+#define WCD9XXX_FLYBACK_EN_PWDN_WITH_DELAY			0
+#define WCD9XXX_RX_BIAS_FLYB_BUFF			WCD9335_REG(0x6, 0xC7)
+#define WCD9XXX_RX_BIAS_FLYB_VNEG_5_UA_MASK		GENMASK(7, 4)
+#define WCD9XXX_RX_BIAS_FLYB_VPOS_5_UA_MASK		GENMASK(0, 3)
+#define WCD9XXX_HPH_L_EN				WCD9335_REG(0x6, 0xD3)
+#define WCD9XXX_HPH_CONST_SEL_L_MASK			GENMASK(7, 3)
+#define WCD9XXX_HPH_CONST_SEL_BYPASS			0
+#define WCD9XXX_HPH_CONST_SEL_LP_PATH			0x40
+#define WCD9XXX_HPH_CONST_SEL_HQ_PATH			0x80
+#define WCD9XXX_HPH_R_EN				WCD9335_REG(0x6, 0xD6)
+#define WCD9XXX_HPH_REFBUFF_UHQA_CTL			WCD9335_REG(0x6, 0xDD)
+#define WCD9XXX_HPH_REFBUFF_UHQA_GAIN_MASK		GENMASK(2, 0)
+#define WCD9XXX_CLASSH_CTRL_VCL_2                       WCD9335_REG(0x6, 0x9B)
+#define WCD9XXX_CLASSH_CTRL_VCL_2_VREF_FILT_1_MASK	GENMASK(5, 4)
+#define WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_50KOHM	0x20
+#define WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_0KOHM	0x0
+#define WCD9XXX_CDC_RX1_RX_PATH_CTL			WCD9335_REG(0xB, 0x55)
+#define WCD9XXX_CDC_RX2_RX_PATH_CTL			WCD9335_REG(0xB, 0x69)
+#define WCD9XXX_CDC_CLK_RST_CTRL_MCLK_CONTROL		WCD9335_REG(0xD, 0x41)
+#define WCD9XXX_CDC_CLK_RST_CTRL_MCLK_EN_MASK		BIT(0)
+#define WCD9XXX_CDC_CLK_RST_CTRL_MCLK_11P3_EN_MASK	BIT(1)
+#define WCD9XXX_CLASSH_CTRL_CCL_1                       WCD9335_REG(0x6, 0x9C)
+#define WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_MASK	GENMASK(7, 4)
+#define WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA	0x50
+#define WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_30MA	0x30
+
+#define CLSH_REQ_ENABLE		true
+#define CLSH_REQ_DISABLE	false
+#define WCD_USLEEP_RANGE	50
+
+enum {
+	DAC_GAIN_0DB = 0,
+	DAC_GAIN_0P2DB,
+	DAC_GAIN_0P4DB,
+	DAC_GAIN_0P6DB,
+	DAC_GAIN_0P8DB,
+	DAC_GAIN_M0P2DB,
+	DAC_GAIN_M0P4DB,
+	DAC_GAIN_M0P6DB,
+};
+
+static inline void wcd_enable_clsh_block(struct wcd_clsh_ctrl *ctrl,
+					 bool enable)
+{
+	struct snd_soc_component *comp = ctrl->comp;
+
+	if ((enable && ++ctrl->clsh_users == 1) ||
+	    (!enable && --ctrl->clsh_users == 0))
+		snd_soc_component_update_bits(comp, WCD9XXX_A_CDC_CLSH_CRC,
+				      WCD9XXX_A_CDC_CLSH_CRC_CLK_EN_MASK,
+				      enable);
+	if (ctrl->clsh_users < 0)
+		ctrl->clsh_users = 0;
+}
+
+static inline bool wcd_clsh_enable_status(struct snd_soc_component *comp)
+{
+	return snd_soc_component_read32(comp, WCD9XXX_A_CDC_CLSH_CRC) &
+					WCD9XXX_A_CDC_CLSH_CRC_CLK_EN_MASK;
+}
+
+static inline void wcd_clsh_set_buck_mode(struct snd_soc_component *comp,
+					  int mode)
+{
+	/* set to HIFI */
+	if (mode == CLS_H_HIFI)
+		snd_soc_component_update_bits(comp, WCD9XXX_A_ANA_RX_SUPPLIES,
+					WCD9XXX_A_ANA_RX_VPOS_PWR_LVL_MASK,
+					WCD9XXX_A_ANA_RX_VPOS_PWR_LVL_UHQA);
+	else
+		snd_soc_component_update_bits(comp, WCD9XXX_A_ANA_RX_SUPPLIES,
+					WCD9XXX_A_ANA_RX_VPOS_PWR_LVL_MASK,
+					WCD9XXX_A_ANA_RX_VPOS_PWR_LVL_DEFAULT);
+}
+
+static inline void wcd_clsh_set_flyback_mode(struct snd_soc_component *comp,
+					     int mode)
+{
+	/* set to HIFI */
+	if (mode == CLS_H_HIFI)
+		snd_soc_component_update_bits(comp, WCD9XXX_A_ANA_RX_SUPPLIES,
+					WCD9XXX_A_ANA_RX_VNEG_PWR_LVL_MASK,
+					WCD9XXX_A_ANA_RX_VNEG_PWR_LVL_UHQA);
+	else
+		snd_soc_component_update_bits(comp, WCD9XXX_A_ANA_RX_SUPPLIES,
+					WCD9XXX_A_ANA_RX_VNEG_PWR_LVL_MASK,
+					WCD9XXX_A_ANA_RX_VNEG_PWR_LVL_DEFAULT);
+}
+
+static void wcd_clsh_buck_ctrl(struct wcd_clsh_ctrl *ctrl,
+			       int mode,
+			       bool enable)
+{
+	struct snd_soc_component *comp = ctrl->comp;
+
+	/* enable/disable buck */
+	if ((enable && (++ctrl->buck_users == 1)) ||
+	   (!enable && (--ctrl->buck_users == 0)))
+		snd_soc_component_update_bits(comp, WCD9XXX_A_ANA_RX_SUPPLIES,
+				WCD9XXX_A_ANA_RX_VPOS_EN_MASK,
+				enable << WCD9XXX_A_ANA_RX_VPOS_EN_SHIFT);
+	/*
+	 * 500us sleep is required after buck enable/disable
+	 * as per HW requirement
+	 */
+	usleep_range(500, 500 + WCD_USLEEP_RANGE);
+}
+
+static void wcd_clsh_flyback_ctrl(struct wcd_clsh_ctrl *ctrl,
+				  int mode,
+				  bool enable)
+{
+	struct snd_soc_component *comp = ctrl->comp;
+
+	/* enable/disable flyback */
+	if ((enable && (++ctrl->flyback_users == 1)) ||
+	   (!enable && (--ctrl->flyback_users == 0))) {
+		snd_soc_component_update_bits(comp, WCD9XXX_A_ANA_RX_SUPPLIES,
+				WCD9XXX_A_ANA_RX_VNEG_EN_MASK,
+				enable << WCD9XXX_A_ANA_RX_VNEG_EN_SHIFT);
+		/* 100usec delay is needed as per HW requirement */
+		usleep_range(100, 110);
+	}
+	/*
+	 * 500us sleep is required after flyback enable/disable
+	 * as per HW requirement
+	 */
+	usleep_range(500, 500 + WCD_USLEEP_RANGE);
+}
+
+static void wcd_clsh_set_gain_path(struct wcd_clsh_ctrl *ctrl, int mode)
+{
+	struct snd_soc_component *comp = ctrl->comp;
+	int val = 0;
+
+	switch (mode) {
+	case CLS_H_NORMAL:
+	case CLS_AB:
+		val = WCD9XXX_HPH_CONST_SEL_BYPASS;
+		break;
+	case CLS_H_HIFI:
+		val = WCD9XXX_HPH_CONST_SEL_HQ_PATH;
+		break;
+	case CLS_H_LP:
+		val = WCD9XXX_HPH_CONST_SEL_LP_PATH;
+		break;
+	};
+
+	snd_soc_component_update_bits(comp, WCD9XXX_HPH_L_EN,
+					WCD9XXX_HPH_CONST_SEL_L_MASK,
+					val);
+
+	snd_soc_component_update_bits(comp, WCD9XXX_HPH_R_EN,
+					WCD9XXX_HPH_CONST_SEL_L_MASK,
+					val);
+}
+
+static void wcd_clsh_set_hph_mode(struct snd_soc_component *comp,
+				  int mode)
+{
+	int val = 0, gain = 0, res_val;
+	int ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
+
+	res_val = WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_0KOHM;
+	switch (mode) {
+	case CLS_H_NORMAL:
+		res_val = WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_50KOHM;
+		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_NORMAL;
+		gain = DAC_GAIN_0DB;
+		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
+		break;
+	case CLS_AB:
+		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_NORMAL;
+		gain = DAC_GAIN_0DB;
+		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
+		break;
+	case CLS_H_HIFI:
+		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_UHQA;
+		gain = DAC_GAIN_M0P2DB;
+		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
+		break;
+	case CLS_H_LP:
+		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_LP;
+		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_30MA;
+		break;
+	};
+
+	snd_soc_component_update_bits(comp, WCD9XXX_A_ANA_HPH,
+					WCD9XXX_A_ANA_HPH_PWR_LEVEL_MASK, val);
+	snd_soc_component_update_bits(comp, WCD9XXX_CLASSH_CTRL_VCL_2,
+				WCD9XXX_CLASSH_CTRL_VCL_2_VREF_FILT_1_MASK,
+				res_val);
+	if (mode != CLS_H_LP)
+		snd_soc_component_update_bits(comp,
+					WCD9XXX_HPH_REFBUFF_UHQA_CTL,
+					WCD9XXX_HPH_REFBUFF_UHQA_GAIN_MASK,
+					gain);
+	snd_soc_component_update_bits(comp, WCD9XXX_CLASSH_CTRL_CCL_1,
+				WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_MASK,
+				ipeak);
+}
+
+static void wcd_clsh_set_flyback_current(struct snd_soc_component *comp,
+					 int mode)
+{
+
+	snd_soc_component_update_bits(comp, WCD9XXX_RX_BIAS_FLYB_BUFF,
+				WCD9XXX_RX_BIAS_FLYB_VPOS_5_UA_MASK, 0x0A);
+	snd_soc_component_update_bits(comp, WCD9XXX_RX_BIAS_FLYB_BUFF,
+				WCD9XXX_RX_BIAS_FLYB_VNEG_5_UA_MASK, 0x0A);
+	/* Sleep needed to avoid click and pop as per HW requirement */
+	usleep_range(100, 110);
+}
+
+static void wcd_clsh_set_buck_regulator_mode(struct snd_soc_component *comp,
+					     int mode)
+{
+	if (mode == CLS_AB)
+		snd_soc_component_update_bits(comp, WCD9XXX_A_ANA_RX_SUPPLIES,
+					WCD9XXX_A_ANA_RX_REGULATOR_MODE_MASK,
+					WCD9XXX_A_ANA_RX_REGULATOR_MODE_CLS_AB);
+	else
+		snd_soc_component_update_bits(comp, WCD9XXX_A_ANA_RX_SUPPLIES,
+					WCD9XXX_A_ANA_RX_REGULATOR_MODE_MASK,
+					WCD9XXX_A_ANA_RX_REGULATOR_MODE_CLS_H);
+}
+
+static void wcd_clsh_state_lo(struct wcd_clsh_ctrl *ctrl, int req_state,
+			      bool is_enable, int mode)
+{
+	struct snd_soc_component *comp = ctrl->comp;
+
+	if (mode != CLS_AB) {
+		dev_err(comp->dev, "%s: LO cannot be in this mode: %d\n",
+			__func__, mode);
+		return;
+	}
+
+	if (is_enable) {
+		wcd_clsh_set_buck_regulator_mode(comp, mode);
+		wcd_clsh_set_buck_mode(comp, mode);
+		wcd_clsh_set_flyback_mode(comp, mode);
+		wcd_clsh_flyback_ctrl(ctrl, mode, true);
+		wcd_clsh_set_flyback_current(comp, mode);
+		wcd_clsh_buck_ctrl(ctrl, mode, true);
+	} else {
+		wcd_clsh_buck_ctrl(ctrl, mode, false);
+		wcd_clsh_flyback_ctrl(ctrl, mode, false);
+		wcd_clsh_set_flyback_mode(comp, CLS_H_NORMAL);
+		wcd_clsh_set_buck_mode(comp, CLS_H_NORMAL);
+		wcd_clsh_set_buck_regulator_mode(comp, CLS_H_NORMAL);
+	}
+}
+
+static void wcd_clsh_state_hph_r(struct wcd_clsh_ctrl *ctrl, int req_state,
+				 bool is_enable, int mode)
+{
+	struct snd_soc_component *comp = ctrl->comp;
+
+	if (mode == CLS_H_NORMAL) {
+		dev_err(comp->dev, "%s: Normal mode not applicable for hph_r\n",
+			__func__);
+		return;
+	}
+
+	if (is_enable) {
+		if (mode != CLS_AB) {
+			wcd_enable_clsh_block(ctrl, true);
+			/*
+			 * These K1 values depend on the Headphone Impedance
+			 * For now it is assumed to be 16 ohm
+			 */
+			snd_soc_component_update_bits(comp,
+					WCD9XXX_A_CDC_CLSH_K1_MSB,
+					WCD9XXX_A_CDC_CLSH_K1_MSB_COEF_MASK,
+					0x00);
+			snd_soc_component_update_bits(comp,
+					WCD9XXX_A_CDC_CLSH_K1_LSB,
+					WCD9XXX_A_CDC_CLSH_K1_LSB_COEF_MASK,
+					0xC0);
+			snd_soc_component_update_bits(comp,
+					    WCD9XXX_A_CDC_RX2_RX_PATH_CFG0,
+					    WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
+					    WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE);
+		}
+		wcd_clsh_set_buck_regulator_mode(comp, mode);
+		wcd_clsh_set_flyback_mode(comp, mode);
+		wcd_clsh_flyback_ctrl(ctrl, mode, true);
+		wcd_clsh_set_flyback_current(comp, mode);
+		wcd_clsh_set_buck_mode(comp, mode);
+		wcd_clsh_buck_ctrl(ctrl, mode, true);
+		wcd_clsh_set_hph_mode(comp, mode);
+		wcd_clsh_set_gain_path(ctrl, mode);
+	} else {
+		wcd_clsh_set_hph_mode(comp, CLS_H_NORMAL);
+
+		if (mode != CLS_AB) {
+			snd_soc_component_update_bits(comp,
+					    WCD9XXX_A_CDC_RX2_RX_PATH_CFG0,
+					    WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
+					    WCD9XXX_A_CDC_RX_PATH_CLSH_DISABLE);
+			wcd_enable_clsh_block(ctrl, false);
+		}
+		/* buck and flyback set to default mode and disable */
+		wcd_clsh_buck_ctrl(ctrl, CLS_H_NORMAL, false);
+		wcd_clsh_flyback_ctrl(ctrl, CLS_H_NORMAL, false);
+		wcd_clsh_set_flyback_mode(comp, CLS_H_NORMAL);
+		wcd_clsh_set_buck_mode(comp, CLS_H_NORMAL);
+		wcd_clsh_set_buck_regulator_mode(comp, CLS_H_NORMAL);
+	}
+}
+
+static void wcd_clsh_state_hph_l(struct wcd_clsh_ctrl *ctrl, int req_state,
+				 bool is_enable, int mode)
+{
+	struct snd_soc_component *comp = ctrl->comp;
+
+	if (mode == CLS_H_NORMAL) {
+		dev_err(comp->dev, "%s: Normal mode not applicable for hph_l\n",
+			__func__);
+		return;
+	}
+
+	if (is_enable) {
+		if (mode != CLS_AB) {
+			wcd_enable_clsh_block(ctrl, true);
+			/*
+			 * These K1 values depend on the Headphone Impedance
+			 * For now it is assumed to be 16 ohm
+			 */
+			snd_soc_component_update_bits(comp,
+					WCD9XXX_A_CDC_CLSH_K1_MSB,
+					WCD9XXX_A_CDC_CLSH_K1_MSB_COEF_MASK,
+					0x00);
+			snd_soc_component_update_bits(comp,
+					WCD9XXX_A_CDC_CLSH_K1_LSB,
+					WCD9XXX_A_CDC_CLSH_K1_LSB_COEF_MASK,
+					0xC0);
+			snd_soc_component_update_bits(comp,
+					    WCD9XXX_A_CDC_RX1_RX_PATH_CFG0,
+					    WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
+					    WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE);
+		}
+		wcd_clsh_set_buck_regulator_mode(comp, mode);
+		wcd_clsh_set_flyback_mode(comp, mode);
+		wcd_clsh_flyback_ctrl(ctrl, mode, true);
+		wcd_clsh_set_flyback_current(comp, mode);
+		wcd_clsh_set_buck_mode(comp, mode);
+		wcd_clsh_buck_ctrl(ctrl, mode, true);
+		wcd_clsh_set_hph_mode(comp, mode);
+		wcd_clsh_set_gain_path(ctrl, mode);
+	} else {
+		wcd_clsh_set_hph_mode(comp, CLS_H_NORMAL);
+
+		if (mode != CLS_AB) {
+			snd_soc_component_update_bits(comp,
+					    WCD9XXX_A_CDC_RX1_RX_PATH_CFG0,
+					    WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
+					    WCD9XXX_A_CDC_RX_PATH_CLSH_DISABLE);
+			wcd_enable_clsh_block(ctrl, false);
+		}
+		/* set buck and flyback to Default Mode */
+		wcd_clsh_buck_ctrl(ctrl, CLS_H_NORMAL, false);
+		wcd_clsh_flyback_ctrl(ctrl, CLS_H_NORMAL, false);
+		wcd_clsh_set_flyback_mode(comp, CLS_H_NORMAL);
+		wcd_clsh_set_buck_mode(comp, CLS_H_NORMAL);
+		wcd_clsh_set_buck_regulator_mode(comp, CLS_H_NORMAL);
+	}
+}
+
+static void wcd_clsh_state_ear(struct wcd_clsh_ctrl *ctrl, int req_state,
+			       bool is_enable, int mode)
+{
+	struct snd_soc_component *comp = ctrl->comp;
+
+	if (mode != CLS_H_NORMAL) {
+		dev_err(comp->dev, "%s: mode: %d cannot be used for EAR\n",
+			__func__, mode);
+		return;
+	}
+
+	if (is_enable) {
+		wcd_enable_clsh_block(ctrl, true);
+		snd_soc_component_update_bits(comp,
+					WCD9XXX_A_CDC_RX0_RX_PATH_CFG0,
+					WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
+					WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE);
+		wcd_clsh_set_buck_mode(comp, mode);
+		wcd_clsh_set_flyback_mode(comp, mode);
+		wcd_clsh_flyback_ctrl(ctrl, mode, true);
+		wcd_clsh_set_flyback_current(comp, mode);
+		wcd_clsh_buck_ctrl(ctrl, mode, true);
+	} else {
+		snd_soc_component_update_bits(comp,
+					WCD9XXX_A_CDC_RX0_RX_PATH_CFG0,
+					WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
+					WCD9XXX_A_CDC_RX_PATH_CLSH_DISABLE);
+		wcd_enable_clsh_block(ctrl, false);
+		wcd_clsh_buck_ctrl(ctrl, mode, false);
+		wcd_clsh_flyback_ctrl(ctrl, mode, false);
+		wcd_clsh_set_flyback_mode(comp, CLS_H_NORMAL);
+		wcd_clsh_set_buck_mode(comp, CLS_H_NORMAL);
+	}
+}
+
+static int _wcd_clsh_ctrl_set_state(struct wcd_clsh_ctrl *ctrl, int req_state,
+				    bool is_enable, int mode)
+{
+	switch (req_state) {
+	case WCD_CLSH_STATE_EAR:
+		wcd_clsh_state_ear(ctrl, req_state, is_enable, mode);
+		break;
+	case WCD_CLSH_STATE_HPHL:
+		wcd_clsh_state_hph_l(ctrl, req_state, is_enable, mode);
+		break;
+	case WCD_CLSH_STATE_HPHR:
+		wcd_clsh_state_hph_r(ctrl, req_state, is_enable, mode);
+		break;
+		break;
+	case WCD_CLSH_STATE_LO:
+		wcd_clsh_state_lo(ctrl, req_state, is_enable, mode);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * Function: wcd_clsh_is_state_valid
+ * Params: state
+ * Description:
+ * Provides information on valid states of Class H configuration
+ */
+static bool wcd_clsh_is_state_valid(int state)
+{
+	switch (state) {
+	case WCD_CLSH_STATE_IDLE:
+	case WCD_CLSH_STATE_EAR:
+	case WCD_CLSH_STATE_HPHL:
+	case WCD_CLSH_STATE_HPHR:
+	case WCD_CLSH_STATE_LO:
+		return true;
+	default:
+		return false;
+	};
+}
+
+/*
+ * Function: wcd_clsh_fsm
+ * Params: ctrl, req_state, req_type, clsh_event
+ * Description:
+ * This function handles PRE DAC and POST DAC conditions of different devices
+ * and updates class H configuration of different combination of devices
+ * based on validity of their states. ctrl will contain current
+ * class h state information
+ */
+int wcd_clsh_ctrl_set_state(struct wcd_clsh_ctrl *ctrl,
+			    enum wcd_clsh_event clsh_event,
+			    int nstate,
+			    enum wcd_clsh_mode mode)
+{
+	struct snd_soc_component *comp = ctrl->comp;
+
+	if (nstate == ctrl->state)
+		return 0;
+
+	if (!wcd_clsh_is_state_valid(nstate)) {
+		dev_err(comp->dev, "Class-H not a valid new state:\n");
+		return -EINVAL;
+	}
+
+	switch (clsh_event) {
+	case WCD_CLSH_EVENT_PRE_DAC:
+		_wcd_clsh_ctrl_set_state(ctrl, nstate, CLSH_REQ_ENABLE, mode);
+		break;
+	case WCD_CLSH_EVENT_POST_PA:
+		_wcd_clsh_ctrl_set_state(ctrl, nstate, CLSH_REQ_DISABLE, mode);
+		break;
+	};
+
+	ctrl->state = nstate;
+	ctrl->mode = mode;
+
+	return 0;
+}
+
+int wcd_clsh_ctrl_get_state(struct wcd_clsh_ctrl *ctrl)
+{
+	return ctrl->state;
+}
+
+struct wcd_clsh_ctrl *wcd_clsh_ctrl_alloc(struct snd_soc_component *comp,
+					  int version)
+{
+	struct wcd_clsh_ctrl *ctrl;
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	ctrl->state = WCD_CLSH_STATE_IDLE;
+	ctrl->comp = comp;
+
+	return ctrl;
+}
+
+void wcd_clsh_ctrl_free(struct wcd_clsh_ctrl *ctrl)
+{
+	kfree(ctrl);
+}
diff --git a/sound/soc/codecs/wcd-clsh-v2.h b/sound/soc/codecs/wcd-clsh-v2.h
new file mode 100644
index 000000000000..a902f9893467
--- /dev/null
+++ b/sound/soc/codecs/wcd-clsh-v2.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _WCD_CLSH_V2_H_
+#define _WCD_CLSH_V2_H_
+#include <sound/soc.h>
+
+enum wcd_clsh_event {
+	WCD_CLSH_EVENT_PRE_DAC = 1,
+	WCD_CLSH_EVENT_POST_PA,
+};
+
+/*
+ * Basic states for Class H state machine.
+ * represented as a bit mask within a u8 data type
+ * bit 0: EAR mode
+ * bit 1: HPH Left mode
+ * bit 2: HPH Right mode
+ * bit 3: Lineout mode
+ */
+#define	WCD_CLSH_STATE_IDLE	0
+#define	WCD_CLSH_STATE_EAR	BIT(0)
+#define	WCD_CLSH_STATE_HPHL	BIT(1)
+#define	WCD_CLSH_STATE_HPHR	BIT(2)
+#define	WCD_CLSH_STATE_LO	BIT(3)
+#define WCD_CLSH_STATE_MAX	4
+#define NUM_CLSH_STATES_V2	BIT(WCD_CLSH_STATE_MAX)
+
+enum wcd_clsh_mode {
+	CLS_H_NORMAL = 0, /* Class-H Default */
+	CLS_H_HIFI, /* Class-H HiFi */
+	CLS_H_LP, /* Class-H Low Power */
+	CLS_AB, /* Class-AB */
+	CLS_H_LOHIFI, /* LoHIFI */
+	CLS_NONE, /* None of the above modes */
+};
+
+struct wcd_clsh_ctrl;
+
+extern struct wcd_clsh_ctrl *wcd_clsh_ctrl_alloc(
+				struct snd_soc_component *component,
+				int version);
+extern void wcd_clsh_ctrl_free(struct wcd_clsh_ctrl *ctrl);
+extern int wcd_clsh_ctrl_get_state(struct wcd_clsh_ctrl *ctrl);
+extern int wcd_clsh_ctrl_set_state(struct wcd_clsh_ctrl *ctrl,
+				   enum wcd_clsh_event event,
+				   int state,
+				   enum wcd_clsh_mode mode);
+
+#endif /* _WCD_CLSH_V2_H_ */
diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index a2cd589617e2..238851eca45c 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -22,6 +22,7 @@
 #include <sound/tlv.h>
 #include <sound/info.h>
 #include "wcd9335.h"
+#include "wcd-clsh-v2.h"
 
 #define WCD9335_RATES_MASK (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
 			    SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
@@ -181,6 +182,7 @@ struct wcd9335_codec {
 	int sido_ccl_cnt;
 	enum wcd_clock_type clk_type;
 
+	struct wcd_clsh_ctrl *clsh_ctrl;
 	u32 hph_mode;
 	int intr1;
 	int reset_gpio;
@@ -1104,6 +1106,13 @@ static int wcd9335_codec_probe(struct snd_soc_component *component)
 	int i;
 
 	snd_soc_component_init_regmap(component, wcd->regmap);
+	/* Class-H Init*/
+	wcd->clsh_ctrl = wcd_clsh_ctrl_alloc(component, wcd->version);
+	if (IS_ERR(wcd->clsh_ctrl))
+		return PTR_ERR(wcd->clsh_ctrl);
+
+	/* Default HPH Mode to Class-H HiFi */
+	wcd->hph_mode = CLS_H_HIFI;
 	wcd->component = component;
 
 	wcd9335_codec_init(component);
@@ -1118,6 +1127,7 @@ static void wcd9335_codec_remove(struct snd_soc_component *comp)
 {
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 
+	wcd_clsh_ctrl_free(wcd->clsh_ctrl);
 	free_irq(regmap_irq_get_virq(wcd->irq_data, WCD9335_IRQ_SLIMBUS), wcd);
 }
 
-- 
2.20.1

