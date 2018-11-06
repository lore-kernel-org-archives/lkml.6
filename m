Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3572EC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F153320869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xvNFBV/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F153320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389081AbeKGAXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:23:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34093 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388950AbeKGAXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:23:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so13865534wre.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L0NzcZk0B6yUzOANOH8zHphKYYRmNnkEHy1YNOx1YHw=;
        b=xvNFBV/+9G4WpB8lvDTLBQwpHX1WWVRyDOKZB87vTTA3X0jOFsmErnfFgUOqtfzKc/
         lBWu95hoAj4trJF9FD8US1lL8KB2X0ph0utp9bszkVMzYgJV2MTlv1EObT/2tKB2pXke
         bjn5H5zfS1v5IKM/Ic3v+nnsexFdRz9kKM8rJwgoswA4A7xN/GljFfQ6yW1yel8ELf0P
         /2CrzRISi2tS6DkD5E3IY7ROKFukg0yrxi+sibxPoJKEJQvUitERFrZizcpf07mvZOZ+
         HY+dXUCV1rz7PHXUUxkUtINoVd9i6sFNLvvESw165B9QxQ93v0fs8kqLfEDNRLoNiRhU
         OtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L0NzcZk0B6yUzOANOH8zHphKYYRmNnkEHy1YNOx1YHw=;
        b=XrHi2ougahxeybvNCa5AQchAPbZk+eIE78fuaq3VhDxvbXztUvckKERPn6+5Ot3mvv
         7hYjCdzI8vyyPr2agX2Li98qMYMMGlqgwMpK2NRQz/JDtkvVL+likcRXUWBo/JoDGUqR
         itMxqGXdsc0/1mT5fq0Ranm8TUIxIIhfDwHo8C7BWB8dM/GcXVKJONksM1jBZC2EVSv0
         hvhLZlD9a+LU5n8kjfBm2V/fAzi6er6Vq5tu4k/wXLPT4iEM5POPt6KQ89G3buPJ49ru
         VIYmPRj0YsGN8dVHfCqMsJDom+KIOE8LtvdHtymKHZ4OFEiYjO7WxQKJs6j7qRAWFgkF
         HVmA==
X-Gm-Message-State: AGRZ1gKNWbNwkhiqxzDlyPGFWO9FHhrmNFlSG80SYMkbNhUlngH5uwlj
        nH30JBckkX+XUDWLB0LmbaN4Cw==
X-Google-Smtp-Source: AJdET5fMEnptL54Pztgx8T3L7ShSvKn6daopFXtnJshYi2LWNjI+qHkaYpODkwA7PbK14PkUe8+N1w==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14-v6mr24170154wrt.326.1541516260978;
        Tue, 06 Nov 2018 06:57:40 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y131-v6sm1825375wmc.16.2018.11.06.06.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 06:57:40 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] clk: meson: Add vid_pll divider driver
Date:   Tue,  6 Nov 2018 15:57:34 +0100
Message-Id: <1541516257-16157-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
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
 drivers/clk/meson/vid-pll-div.c | 91 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)
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
index 0000000..b3370ea
--- /dev/null
+++ b/drivers/clk/meson/vid-pll-div.c
@@ -0,0 +1,91 @@
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
+	unsigned int divider;
+	unsigned int multiplier;
+};
+
+#define VID_PLL_DIV(_val, _sel, _ft, _fb)				\
+	{								\
+		.shift_val = (_val),					\
+		.shift_sel = (_sel),					\
+		.divider = (_ft),					\
+		.multiplier = (_fb),					\
+	}
+
+static const struct vid_pll_div vid_pll_div_table[] = {
+	VID_PLL_DIV(0x0aaa, 0, 2, 1),	/* 2/1  => /2 */
+	VID_PLL_DIV(0x5294, 2, 5, 2),	/* 5/2  => /2.5 */
+	VID_PLL_DIV(0x0db6, 0, 3, 1),	/* 3/1  => /3 */
+	VID_PLL_DIV(0x36cc, 1, 7, 2),	/* 7/2  => /3.5 */
+	VID_PLL_DIV(0x6666, 2, 15, 4),	/* 15/4 => /3.75 */
+	VID_PLL_DIV(0x0ccc, 0, 4, 1),	/* 4/1  => /4 */
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
+#define to_meson_vid_pll_div(_hw) \
+	container_of(_hw, struct meson_vid_pll_div, hw)
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
+	if (!div || !div->divider) {
+		pr_info("%s: Invalid config value for vid_pll_div\n", __func__);
+		return parent_rate;
+	}
+
+	return DIV_ROUND_UP_ULL(parent_rate * div->multiplier, div->divider);
+}
+
+const struct clk_ops meson_vid_pll_div_ro_ops = {
+	.recalc_rate	= meson_vid_pll_div_recalc_rate,
+};
-- 
2.7.4

