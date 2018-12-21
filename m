Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBDCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F3221920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wnppx2t5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbeLUQC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:02:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39231 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387953AbeLUQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:02:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so5786152wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FLkfbrFTeHQRtZznQmsDFo42KqctA5AQOYQ6mqTjbJM=;
        b=wnppx2t5Vr1TlkjvF86pUCcvQUgNVK1bUbdZZ5+VOROVCe7dKGOkSE580fscLyag31
         oHt8voN8AayeXZkDWH17hC1Hv83KFWhYBtEjkuSqneVUjx2bEz7IzpUqhuVZrLKxD2+c
         AneJc37CrhmrD/Ihd7EWiG8Zc/Icj5m97qABWqtEU3h3Xbh0iZqYpJ03R9gjIm7e4JFt
         Uv2oLI4k+HETpfRUOi/S1GVQUo+1rbthcDX37UXAJatRoI4Un3JcSdz6G3CXlgYpESoA
         cIlPauMhw4aTU1ejJCKw/VnWGNqFM3crDgRMn8j4Hz2yGnHB94SX0km4H2UDMTHyS9bR
         HWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FLkfbrFTeHQRtZznQmsDFo42KqctA5AQOYQ6mqTjbJM=;
        b=NHahLr0Z4702zNBeKvIMc+grlbrsKWHI2eVpPJllJ0q6TkB2W+rorBOkPomxt4tkss
         pCUyPtccbZ7D2IXX4Tym4wWI2fN8vMuFOhn8c/EDUGlrgPw8v/t/uv8rhCTQLdXVBwWW
         LMhPBHdMmjVU6HUNgJ5QuFZ7aaToIx3ztanHvgCusgUK4id0cy2aED+HZNmHbHnBuyOc
         0jO1vEbkJ4Za4H05JRnpnxmeoQcTlM9Jxf9Z59nKioar4ZHA2h92/6QmcApZGcUwn7x7
         4tlhqhOKDISupPTGpi62XAwFlO6ZmCtG8lBXY6PqLHQcLsZzLJ4qER8L/zjuMcWB/oku
         Ftig==
X-Gm-Message-State: AJcUukehBmjL0wNffHeQfyA/KDm+3rQvG5SDVS4EV6u+VfRQjrOCjOak
        O9CvQia18Ym7ReN/NebPE8g+vQ==
X-Google-Smtp-Source: ALg8bN4wK0mgC+iPzOU99D9ClBMJ3BbHGDvMhfoO0nTs+a1U7Qz6tFbZYIdmCzD+z1iYphcPMhGsMw==
X-Received: by 2002:adf:9382:: with SMTP id 2mr3140125wrp.269.1545408172554;
        Fri, 21 Dec 2018 08:02:52 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y138sm13044021wmc.16.2018.12.21.08.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 08:02:51 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] clk: meson: add dual divider clock driver
Date:   Fri, 21 Dec 2018 17:02:37 +0100
Message-Id: <20181221160239.26265-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221160239.26265-1-jbrunet@baylibre.com>
References: <20181221160239.26265-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dual divider driver. This special divider make a weighted
average between 2 dividers to reach fractional divider values.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Makefile      |   2 +-
 drivers/clk/meson/clk-dualdiv.c | 130 ++++++++++++++++++++++++++++++++
 drivers/clk/meson/clkc.h        |  19 +++++
 3 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/clk-dualdiv.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index a849aa809825..f1fcafc046d5 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o clk-dualdiv.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
diff --git a/drivers/clk/meson/clk-dualdiv.c b/drivers/clk/meson/clk-dualdiv.c
new file mode 100644
index 000000000000..4d9e161de627
--- /dev/null
+++ b/drivers/clk/meson/clk-dualdiv.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+/*
+ * The AO Domain embeds a dual/divider to generate a more precise
+ * 32,768KHz clock for low-power suspend mode and CEC.
+ *     ______   ______
+ *    |      | |      |
+ *    | Div1 |-| Cnt1 |
+ *   /|______| |______|\
+ * -|  ______   ______  X--> Out
+ *   \|      | |      |/
+ *    | Div2 |-| Cnt2 |
+ *    |______| |______|
+ *
+ * The dividing can be switched to single or dual, with a counter
+ * for each divider to set when the switching is done.
+ */
+
+#include <linux/clk-provider.h>
+#include "clkc.h"
+
+static inline struct meson_clk_dualdiv_data *
+meson_clk_dualdiv_data(struct clk_regmap *clk)
+{
+	return (struct meson_clk_dualdiv_data *)clk->data;
+}
+
+static unsigned long
+__dualdiv_param_to_rate(unsigned long parent_rate,
+			const struct meson_clk_dualdiv_param *p)
+{
+	if (!p->dual)
+		return DIV_ROUND_CLOSEST(parent_rate, p->n1);
+
+	return DIV_ROUND_CLOSEST(parent_rate * (p->m1 + p->m2),
+				 p->n1 * p->m1 + p->n2 * p->m2);
+}
+
+static unsigned long meson_clk_dualdiv_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_dualdiv_data *dualdiv = meson_clk_dualdiv_data(clk);
+	struct meson_clk_dualdiv_param setting;
+
+	setting.dual = meson_parm_read(clk->map, &dualdiv->dual);
+	setting.n1 = meson_parm_read(clk->map, &dualdiv->n1) + 1;
+	setting.m1 = meson_parm_read(clk->map, &dualdiv->m1) + 1;
+	setting.n2 = meson_parm_read(clk->map, &dualdiv->n2) + 1;
+	setting.m2 = meson_parm_read(clk->map, &dualdiv->m2) + 1;
+
+	return __dualdiv_param_to_rate(parent_rate, &setting);
+}
+
+static const struct meson_clk_dualdiv_param *
+__dualdiv_get_setting(unsigned long rate, unsigned long parent_rate,
+		      struct meson_clk_dualdiv_data *dualdiv)
+{
+	const struct meson_clk_dualdiv_param *table = dualdiv->table;
+	unsigned long best = 0, now = 0;
+	unsigned int i, best_i = 0;
+
+	if (!table)
+		return NULL;
+
+	for (i = 0; table[i].n1; i++) {
+		now = __dualdiv_param_to_rate(parent_rate, &table[i]);
+
+		/* If we get an exact match, don't bother any further */
+		if (now == rate) {
+			return &table[i];
+		} else if (abs(now - rate) < abs(best - rate)) {
+			best = now;
+			best_i = i;
+		}
+	}
+
+	return (struct meson_clk_dualdiv_param *)&table[best_i];
+}
+
+static long meson_clk_dualdiv_round_rate(struct clk_hw *hw, unsigned long rate,
+					 unsigned long *parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_dualdiv_data *dualdiv = meson_clk_dualdiv_data(clk);
+	const struct meson_clk_dualdiv_param *setting =
+		__dualdiv_get_setting(rate, *parent_rate, dualdiv);
+
+	if (!setting)
+		return meson_clk_dualdiv_recalc_rate(hw, *parent_rate);
+
+	return __dualdiv_param_to_rate(*parent_rate, setting);
+}
+
+static int meson_clk_dualdiv_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_dualdiv_data *dualdiv = meson_clk_dualdiv_data(clk);
+	const struct meson_clk_dualdiv_param *setting =
+		__dualdiv_get_setting(rate, parent_rate, dualdiv);
+
+	if (!setting)
+		return -EINVAL;
+
+	meson_parm_write(clk->map, &dualdiv->dual, setting->dual);
+	meson_parm_write(clk->map, &dualdiv->n1, setting->n1 - 1);
+	meson_parm_write(clk->map, &dualdiv->m1, setting->m1 - 1);
+	meson_parm_write(clk->map, &dualdiv->n2, setting->n2 - 1);
+	meson_parm_write(clk->map, &dualdiv->m2, setting->m2 - 1);
+
+	return 0;
+}
+
+const struct clk_ops meson_clk_dualdiv_ops = {
+	.recalc_rate	= meson_clk_dualdiv_recalc_rate,
+	.round_rate	= meson_clk_dualdiv_round_rate,
+	.set_rate	= meson_clk_dualdiv_set_rate,
+};
+EXPORT_SYMBOL_GPL(meson_clk_dualdiv_ops);
+
+const struct clk_ops meson_clk_dualdiv_ro_ops = {
+	.recalc_rate	= meson_clk_dualdiv_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(meson_clk_dualdiv_ro_ops);
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 6183b22c4bf2..e3cd442db739 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -110,6 +110,23 @@ struct clk_regmap _name = {						\
 	},								\
 };
 
+struct meson_clk_dualdiv_param {
+	unsigned int n1;
+	unsigned int n2;
+	unsigned int m1;
+	unsigned int m2;
+	unsigned int dual;
+};
+
+struct meson_clk_dualdiv_data {
+	struct parm n1;
+	struct parm n2;
+	struct parm m1;
+	struct parm m2;
+	struct parm dual;
+	const struct meson_clk_dualdiv_param *table;
+};
+
 /* clk_ops */
 extern const struct clk_ops meson_clk_pll_ro_ops;
 extern const struct clk_ops meson_clk_pll_ops;
@@ -118,6 +135,8 @@ extern const struct clk_ops meson_clk_mpll_ro_ops;
 extern const struct clk_ops meson_clk_mpll_ops;
 extern const struct clk_ops meson_clk_phase_ops;
 extern const struct clk_ops meson_vid_pll_div_ro_ops;
+extern const struct clk_ops meson_clk_dualdiv_ops;
+extern const struct clk_ops meson_clk_dualdiv_ro_ops;
 
 struct clk_hw *meson_clk_hw_register_input(struct device *dev,
 					   const char *of_name,
-- 
2.19.2

