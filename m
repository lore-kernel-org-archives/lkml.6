Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5F6C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B58420659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="P+3DBHCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B58420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeLDQx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:53:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34165 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeLDQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:53:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so16734431wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnH7FGlTJZWQDJwQ11hjHMkzzktlzgcwoQuJlMU3p6M=;
        b=P+3DBHCONdq2PYFwQ6qBx6u8gRgZPKfTQCXqtnRdol1bQGHFbtIhAS2LrHb/rw4H+z
         RhvY9VxULVQAUguIETvix8k5QO1LLVDCXbvD9EJntPRvNy3xqhvF4nQFEYfknQu5xdCg
         BxeYib5Ic5I2wyxXr0JzrzJzmuvJPsbC34yO6GgbJQsyEjkYuMiwChvX1qir41wKUuVn
         tE7wUXWPdPN45x9M+c25OxcI5pVZyCPJpiGfcqkqkyYuZ63vsC0yQr2WWyKV8uq86pJC
         HIR9TOrBpMjD2lIxT9h6A5rg1v14stCRpzGyeIC0vPEZtQ2X5yiHTYvxP/a9BwQSi7c6
         w+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnH7FGlTJZWQDJwQ11hjHMkzzktlzgcwoQuJlMU3p6M=;
        b=CaUApiSp+xLkfyL7f1nW9gf4jb2BF1xIYpupbQuW6sH/4r+7IqF5/66Cxnwn/TXYZ9
         eyHHLwP+35ywkEs2hjSMvTOyCIWiN2/gRwPTIQkzSNtzJqkYZriWkbxPqyn68p5EjBx6
         btf6azLlhmkr3tQdCaY7e3TuNLeUI+gB5LTAF2AKlKIHDGGVyuiudsF96jfifegI97FM
         PTn4m7rNxGEkJwtBtPu0j5c649rk2/ARbKQYP3zKEL6nKIvCoA/0Zs0IOKe4EhnCAEA3
         9Hko4utSXyIy5pgNSe76ne+BIsa16c4b0Yp7V7kanIlv8RJMBEceT/6UeCMWBlHJu+PU
         ND/Q==
X-Gm-Message-State: AA+aEWbD+6DrRThvGfs8yKPEq6oHQU+Mzl6n8kOYCY1PljrO5iHEe6py
        Ap/3SGmBBB8ttrDSVxv//GDOjw==
X-Google-Smtp-Source: AFSGD/UvZJMwiQVM9StVye9RvkgyXmq+yJcfzcpk+5dWRcX5UZ9VVYdxL3Lk65x8mSB5oB0ptvla1g==
X-Received: by 2002:adf:f550:: with SMTP id j16mr18360084wrp.258.1543942401528;
        Tue, 04 Dec 2018 08:53:21 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s66sm11581633wmf.34.2018.12.04.08.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:53:20 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/5] clk: meson: add dual divider clock driver
Date:   Tue,  4 Dec 2018 17:53:08 +0100
Message-Id: <20181204165310.20806-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204165310.20806-1-jbrunet@baylibre.com>
References: <20181204165310.20806-1-jbrunet@baylibre.com>
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
 drivers/clk/meson/Makefile      |   1 +
 drivers/clk/meson/clk-dualdiv.c | 130 ++++++++++++++++++++++++++++++++
 drivers/clk/meson/clkc.h        |  19 +++++
 3 files changed, 150 insertions(+)
 create mode 100644 drivers/clk/meson/clk-dualdiv.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 0234767f6cfc..ae3fa2a127d5 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-dualdiv.o
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
index 91666055c75a..1efa6be9cfe4 100644
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
@@ -118,5 +135,7 @@ extern const struct clk_ops meson_clk_mpll_ro_ops;
 extern const struct clk_ops meson_clk_mpll_ops;
 extern const struct clk_ops meson_clk_phase_ops;
 extern const struct clk_ops meson_vid_pll_div_ro_ops;
+extern const struct clk_ops meson_clk_dualdiv_ops;
+extern const struct clk_ops meson_clk_dualdiv_ro_ops;
 
 #endif /* __CLKC_H */
-- 
2.19.1

