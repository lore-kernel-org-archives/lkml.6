Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE48ECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD12620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yA17GWxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD12620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeGTK1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:27:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34613 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbeGTK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:27:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so10697216wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r89F07SsCYfM0evtFjPvaEjDsHGhuHBufj6VMwBtu5A=;
        b=yA17GWxA2ee2bM54q0VFr785PC3bmNA8mj5SaLLO8dLTM8J0eIff6q4aHWwH8ChpTH
         nML+EYtsucbVklAH/qy0Gbyptrx73OEieGUpIvC/AqgiwZg+N2YxUTxYqaGTOIZvFiK1
         d6X0dopH8kZnrmC03QessGGBKyIs8LKMeDsKfmKsVtTbJLtz1RSVuyUo3V4wldd9GHkY
         TgtWzun751LPHbp5bITe4xgXbH0pG8ALj8yFIzCuvuU2AReyCmq0nvz1+bi3cuZCtRXG
         E7b02iAYeGzAtrn3FMEwj0XDiae05xIo4QV90+/rDFzAnJlbsv0zjar0cx5s9CzvFa4L
         lIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r89F07SsCYfM0evtFjPvaEjDsHGhuHBufj6VMwBtu5A=;
        b=chjo5W+dlPZZvAmtmSRtJ/g7V+n5K2SNRujXIofRjUPyd/dsqEaE0gP8UYGZgLYTSo
         eS6CKCAHMg4oMhER5ZKA6MNQf8+nqDmOqyWNgYKjmiPF6FFiBplQSvDBidXbrHHspdVx
         8SqWedU22cL3UhTr7TsW3FGFtHjlUGVxa14I83rUPsC1jgcvaAvvTmenlqbUbtp7UGZC
         2e3NdA/8qR7GpucX4s25LoRBWF3dVXgYFiezKBSLLTV5uIFZxqBQrbHwmfjV1EnUqvVJ
         fGLUJt0uL88bEXuVIyVBz+vMLbLBsAqNqkx/SnRfKIKMEKKlO0SrChO32rfUlAzQJv88
         O7PA==
X-Gm-Message-State: AOUpUlEewmpi1Fogedqc7+nc8Ug5G/JI5QzCAPzn4KyHgjpgWlvWbnxZ
        ezUink1gKmCtEWiNPdsRTi+VQw==
X-Google-Smtp-Source: AAOMgpeihIIwakz7P3p6wdI66HtyUzmU8p6C0i+vjtNGL9vWIWV2zVUJHPd/Hc5b0bbcaC5vIIL5KA==
X-Received: by 2002:adf:80aa:: with SMTP id 39-v6mr970496wrl.57.1532079585647;
        Fri, 20 Jul 2018 02:39:45 -0700 (PDT)
Received: from bender.home (LFbn-MAR-1-570-38.w90-118.abo.wanadoo.fr. [90.118.15.38])
        by smtp.gmail.com with ESMTPSA id z5-v6sm1917070wrv.2.2018.07.20.02.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jul 2018 02:39:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: meson: Add vid_pll divider driver
Date:   Fri, 20 Jul 2018 11:39:40 +0200
Message-Id: <1532079581-978-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532079581-978-1-git-send-email-narmstrong@baylibre.com>
References: <1532079581-978-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support the VID_PLL fully programmable divider used right after the
HDMI PLL clock source. It is used to achieve complex fractional division
with a programmble bitfield.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/Makefile      |  2 +-
 drivers/clk/meson/clkc.h        |  6 +++
 drivers/clk/meson/vid-pll-div.c | 90 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/vid-pll-div.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 72ec8c4..0234767 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Meson specific clk
 #
 
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 6b96d55..9166605 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -90,6 +90,11 @@ struct meson_clk_phase_data {
 int meson_clk_degrees_from_val(unsigned int val, unsigned int width);
 unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width);
 
+struct meson_vid_pll_div_data {
+	struct parm val;
+	struct parm sel;
+};
+
 #define MESON_GATE(_name, _reg, _bit)					\
 struct clk_regmap _name = {						\
 	.data = &(struct clk_regmap_gate_data){				\
@@ -112,5 +117,6 @@ extern const struct clk_ops meson_clk_cpu_ops;
 extern const struct clk_ops meson_clk_mpll_ro_ops;
 extern const struct clk_ops meson_clk_mpll_ops;
 extern const struct clk_ops meson_clk_phase_ops;
+extern const struct clk_ops meson_vid_pll_div_ro_ops;
 
 #endif /* __CLKC_H */
diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
new file mode 100644
index 0000000..5f267be
--- /dev/null
+++ b/drivers/clk/meson/vid-pll-div.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/clk-provider.h>
+#include "clkc.h"
+
+static inline struct meson_vid_pll_div_data *
+meson_vid_pll_div_data(struct clk_regmap *clk)
+{
+	return (struct meson_vid_pll_div_data *)clk->data;
+}
+
+/*
+ * This vid_pll divided is a fully programmable fractionnal divider to
+ * achieve complex video clock rates.
+ *
+ * Here are provided the commonly used fraction values provided by Amlogic.
+ */
+
+struct vid_pll_div {
+	unsigned int shift_val;
+	unsigned int shift_sel;
+	unsigned int frac_top;
+	unsigned int frac_bot;
+};
+
+#define VID_PLL_DIV(_val, _sel, _ft, _fb)				\
+	{								\
+		.shift_val = (_val),					\
+		.shift_sel = (_sel),					\
+		.frac_top = (_ft),					\
+		.frac_bot = (_fb),					\
+	}
+
+static const struct vid_pll_div vid_pll_div_table[] = {
+	VID_PLL_DIV(0x0aaa, 0, 2, 1),	/* 2/1  => /2 */
+	VID_PLL_DIV(0x5294, 2, 5, 2),	/* 5/2  => /2.5 */
+	VID_PLL_DIV(0x0db6, 0, 3, 1),	/* 3/1  => /3 */
+	VID_PLL_DIV(0x36cc, 1, 7, 2),	/* 7/2  => /3.5 */
+	VID_PLL_DIV(0x6666, 2, 15, 4),	/* 15/4 => /3.75 */
+	VID_PLL_DIV(0x0ccc, 4, 4, 1),	/* 4/1  => /4 */
+	VID_PLL_DIV(0x739c, 2, 5, 1),	/* 5/1  => /5 */
+	VID_PLL_DIV(0x0e38, 0, 6, 1),	/* 6/1  => /6 */
+	VID_PLL_DIV(0x0000, 3, 25, 4),	/* 25/4 => /6.25 */
+	VID_PLL_DIV(0x3c78, 1, 7, 1),	/* 7/1  => /7 */
+	VID_PLL_DIV(0x78f0, 2, 15, 2),	/* 15/2 => /7.5 */
+	VID_PLL_DIV(0x0fc0, 0, 12, 1),	/* 12/1 => /12 */
+	VID_PLL_DIV(0x3f80, 1, 14, 1),	/* 14/1 => /14 */
+	VID_PLL_DIV(0x7f80, 2, 15, 1),	/* 15/1 => /15 */
+};
+
+#define to_meson_vid_pll_div(_hw) container_of(_hw, struct meson_vid_pll_div, hw)
+
+const struct vid_pll_div *_get_table_val(unsigned int shift_val,
+					 unsigned int shift_sel)
+{
+	int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(vid_pll_div_table) ; ++i) {
+		if (vid_pll_div_table[i].shift_val == shift_val &&
+		    vid_pll_div_table[i].shift_sel == shift_sel)
+			return &vid_pll_div_table[i];
+	}
+
+	return NULL;
+}
+
+static unsigned long meson_vid_pll_div_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vid_pll_div_data *pll_div = meson_vid_pll_div_data(clk);
+	const struct vid_pll_div *div;
+
+	div = _get_table_val(meson_parm_read(clk->map, &pll_div->val),
+			     meson_parm_read(clk->map, &pll_div->sel));
+	if (!div || !div->frac_top) {
+		pr_info("%s: Invalid config value for vid_pll_div\n", __func__);
+		return parent_rate;
+	}
+
+	return DIV_ROUND_UP_ULL(parent_rate * div->frac_bot, div->frac_top);
+}
+
+const struct clk_ops meson_vid_pll_div_ro_ops = {
+	.recalc_rate	= meson_vid_pll_div_recalc_rate,
+};
-- 
2.7.4

