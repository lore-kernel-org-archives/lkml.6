Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A167CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A4B20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLil0jT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A4B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeH3XZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:25:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43334 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbeH3XZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:25:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id h64-v6so8073248lfi.10;
        Thu, 30 Aug 2018 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+2O3Cw5m0bxu6SAGGlo8p7t7kMskIKMbfPy9QWJp+8w=;
        b=sLil0jT7W/3bT5xoYJieRXhNDaDnGfrdWXao/G3drkH9sXiXAOh0p4AsWsK/i9P2n1
         i/99+/HfW5oJkMKKlqXHHn9PETKYR0Q3hZr5dtItpuxLkcxwCEQhojb2pSTkaSS+h5qH
         m1IODZndybKg6HY9OMBGu2q28rgloAAMr6j6fI+GKI5VXEieaapiBcclX0mA/YdQyNCG
         gZQLvDJ5x23Uu1BoVdOBzBt4kLIxglxTu1WL8ADN5dNoxtkUyRqCWASK3CxJu7DAO+zv
         YrNkkC8vpU0CyCysqptia2TYSJ7NFR+DToaD7MMOQHBxretl2ogzzzk2X9gkN6f2dnGO
         S5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+2O3Cw5m0bxu6SAGGlo8p7t7kMskIKMbfPy9QWJp+8w=;
        b=s0TKYYgv6OSnuMAAESVeBOsAIkK7f6Jq02c12DK4mc5SFIuj0yAdbAUmTsYLKJoIts
         NbuVJ5Bb+wPGI5FGAFDN8KkvbBLAnCDbhqh+nBOklZRWdDceYm0NBpDsRA7wF4vLyO4Z
         iA1WN+iKOKD8+9ZHzbFVNNY/IOpqBO+b7unh22kyDihQyw9CB3c0uR+sS+7sbGFBAXM9
         k6p+h98daypbMknLscuDq7kG65RyjzrLEwAlEtlv94eZ9jF3F3EijvJpNt8DMSaU6lNv
         QhMzNWJx+sYA7xtX9Gyh27kra8Y+d+EGX9ssby/K29sg9KHlKK9QaACOBanQvGOBELzq
         a6fA==
X-Gm-Message-State: APzg51ChmR1ErPjCWAqAgUU1IhRXxQWCH5Gn1mAi8h20b5wXIGy5fkvi
        2Gacd6mAifXjxi1dmQJIcNg=
X-Google-Smtp-Source: ANB0VdZTOgCZJRGxrJJ0tfB6ZyXZ9QkeF6qYWg4rqGe4vfBnrDyaoUk7ifQfsjhXjUFZrVXbtjCsnA==
X-Received: by 2002:a19:e21b:: with SMTP id z27-v6mr8687037lfg.68.1535656910341;
        Thu, 30 Aug 2018 12:21:50 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1403291lfl.1.2018.08.30.12.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:21:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] clk: tegra: Convert CCLKG mux to mux + clock divider on Tegra30
Date:   Thu, 30 Aug 2018 22:20:43 +0300
Message-Id: <20180830192045.11017-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830192045.11017-1-digetx@gmail.com>
References: <20180830192045.11017-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the CCLKG parents aren't accessible via device tree because they
are created as non-DT clocks. Apparently there is no reason to define
these clocks in that manner, hence convert CCLKG mux to mux + clock
divider to remove the non-DT parent clocks. Now it is possible to request
all of CCLKG parents from device tree, which is necessary for the CPUFreq
driver.

Note that CCLKG bypasses clock divider only if PLLX is selected as the
parent, hence previous CCLKG parents definition was incorrect.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-super.c    | 16 +++++++++++++-
 drivers/clk/tegra/clk-tegra210.c |  2 +-
 drivers/clk/tegra/clk-tegra30.c  | 38 +++++---------------------------
 drivers/clk/tegra/clk.h          |  9 ++++++--
 4 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
index 84267cfc4433..8ba58f7942d9 100644
--- a/drivers/clk/tegra/clk-super.c
+++ b/drivers/clk/tegra/clk-super.c
@@ -65,6 +65,8 @@ static u8 clk_super_get_parent(struct clk_hw *hw)
 	    (source == mux->pllx_index))
 		source = mux->div2_index;
 
+	mux->pllx_parent = (source == mux->pllx_index);
+
 	return source;
 }
 
@@ -114,6 +116,8 @@ static int clk_super_set_parent(struct clk_hw *hw, u8 index)
 	writel_relaxed(val, mux->reg);
 	udelay(2);
 
+	mux->pllx_parent = (index == mux->pllx_index);
+
 out:
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
@@ -132,6 +136,9 @@ static long clk_super_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct tegra_clk_super_mux *super = to_clk_super_mux(hw);
 	struct clk_hw *div_hw = &super->frac_div.hw;
 
+	if ((super->flags & TEGRA_CCLKG_DIVIDER) && super->pllx_parent)
+		return *parent_rate;
+
 	__clk_hw_set_clk(div_hw, hw);
 
 	return super->div_ops->round_rate(div_hw, rate, parent_rate);
@@ -143,6 +150,9 @@ static unsigned long clk_super_recalc_rate(struct clk_hw *hw,
 	struct tegra_clk_super_mux *super = to_clk_super_mux(hw);
 	struct clk_hw *div_hw = &super->frac_div.hw;
 
+	if ((super->flags & TEGRA_CCLKG_DIVIDER) && super->pllx_parent)
+		return parent_rate;
+
 	__clk_hw_set_clk(div_hw, hw);
 
 	return super->div_ops->recalc_rate(div_hw, parent_rate);
@@ -154,6 +164,9 @@ static int clk_super_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct tegra_clk_super_mux *super = to_clk_super_mux(hw);
 	struct clk_hw *div_hw = &super->frac_div.hw;
 
+	if ((super->flags & TEGRA_CCLKG_DIVIDER) && super->pllx_parent)
+		return 0;
+
 	__clk_hw_set_clk(div_hw, hw);
 
 	return super->div_ops->set_rate(div_hw, rate, parent_rate);
@@ -204,7 +217,7 @@ struct clk *tegra_clk_register_super_mux(const char *name,
 }
 
 struct clk *tegra_clk_register_super_clk(const char *name,
-		const char * const *parent_names, u8 num_parents,
+		const char * const *parent_names, u8 num_parents, u8 pllx_index,
 		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
 		spinlock_t *lock)
 {
@@ -232,6 +245,7 @@ struct clk *tegra_clk_register_super_clk(const char *name,
 	super->frac_div.frac_width = 1;
 	super->frac_div.lock = lock;
 	super->div_ops = &tegra_clk_frac_div_ops;
+	super->pllx_index = pllx_index;
 
 	/* Data in .init is copied by clk_register(), so stack variable OK */
 	super->hw.init = &init;
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 9eb1cb14fce1..990c8773e50c 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -3026,7 +3026,7 @@ static __init void tegra210_periph_clk_init(void __iomem *clk_base,
 	clks[TEGRA210_CLK_CML1] = clk;
 
 	clk = tegra_clk_register_super_clk("aclk", aclk_parents,
-				ARRAY_SIZE(aclk_parents), 0, clk_base + 0x6e0,
+				ARRAY_SIZE(aclk_parents), 0, 0, clk_base + 0x6e0,
 				0, NULL);
 	clks[TEGRA210_CLK_ACLK] = clk;
 
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index acfe661b2ae7..c4b78316ba8a 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -902,8 +902,8 @@ static void __init tegra30_pll_init(void)
 }
 
 static const char *cclk_g_parents[] = { "clk_m", "pll_c", "clk_32k", "pll_m",
-					"pll_p_cclkg", "pll_p_out4_cclkg",
-					"pll_p_out3_cclkg", "unused", "pll_x" };
+					"pll_p", "pll_p_out4", "pll_p_out3",
+					"unused", "pll_x" };
 static const char *cclk_lp_parents[] = { "clk_m", "pll_c", "clk_32k", "pll_m",
 					 "pll_p_cclklp", "pll_p_out4_cclklp",
 					 "pll_p_out3_cclklp", "unused", "pll_x",
@@ -916,39 +916,11 @@ static void __init tegra30_super_clk_init(void)
 {
 	struct clk *clk;
 
-	/*
-	 * Clock input to cclk_g divided from pll_p using
-	 * U71 divider of cclk_g.
-	 */
-	clk = tegra_clk_register_divider("pll_p_cclkg", "pll_p",
-				clk_base + SUPER_CCLKG_DIVIDER, 0,
-				TEGRA_DIVIDER_INT, 16, 8, 1, NULL);
-	clk_register_clkdev(clk, "pll_p_cclkg", NULL);
-
-	/*
-	 * Clock input to cclk_g divided from pll_p_out3 using
-	 * U71 divider of cclk_g.
-	 */
-	clk = tegra_clk_register_divider("pll_p_out3_cclkg", "pll_p_out3",
-				clk_base + SUPER_CCLKG_DIVIDER, 0,
-				TEGRA_DIVIDER_INT, 16, 8, 1, NULL);
-	clk_register_clkdev(clk, "pll_p_out3_cclkg", NULL);
-
-	/*
-	 * Clock input to cclk_g divided from pll_p_out4 using
-	 * U71 divider of cclk_g.
-	 */
-	clk = tegra_clk_register_divider("pll_p_out4_cclkg", "pll_p_out4",
-				clk_base + SUPER_CCLKG_DIVIDER, 0,
-				TEGRA_DIVIDER_INT, 16, 8, 1, NULL);
-	clk_register_clkdev(clk, "pll_p_out4_cclkg", NULL);
-
 	/* CCLKG */
-	clk = tegra_clk_register_super_mux("cclk_g", cclk_g_parents,
-				  ARRAY_SIZE(cclk_g_parents),
-				  CLK_SET_RATE_PARENT,
+	clk = tegra_clk_register_super_clk("cclk_g", cclk_g_parents,
+				  ARRAY_SIZE(cclk_g_parents), 8, 0,
 				  clk_base + CCLKG_BURST_POLICY,
-				  0, 4, 0, 0, NULL);
+				  TEGRA_CCLKG_DIVIDER, NULL);
 	clks[TEGRA30_CLK_CCLK_G] = clk;
 
 	/*
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index d2c3a010f8e9..64922f0f5fdd 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -680,6 +680,9 @@ struct clk *tegra_clk_register_periph_data(void __iomem *clk_base,
  * Flags:
  * TEGRA_DIVIDER_2 - LP cluster has additional divider. This flag indicates
  *     that this is LP cluster clock.
+ *
+ * TEGRA_CCLKG_DIVIDER - G cluster clock may bypass clocks divider. This flag
+ *     indicates that this is G cluster clock.
  */
 struct tegra_clk_super_mux {
 	struct clk_hw	hw;
@@ -691,11 +694,13 @@ struct tegra_clk_super_mux {
 	u8		div2_index;
 	u8		pllx_index;
 	spinlock_t	*lock;
+	bool		pllx_parent;
 };
 
 #define to_clk_super_mux(_hw) container_of(_hw, struct tegra_clk_super_mux, hw)
 
-#define TEGRA_DIVIDER_2 BIT(0)
+#define TEGRA_DIVIDER_2		BIT(0)
+#define TEGRA_CCLKG_DIVIDER	BIT(1)
 
 extern const struct clk_ops tegra_clk_super_ops;
 struct clk *tegra_clk_register_super_mux(const char *name,
@@ -703,7 +708,7 @@ struct clk *tegra_clk_register_super_mux(const char *name,
 		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
 		u8 width, u8 pllx_index, u8 div2_index, spinlock_t *lock);
 struct clk *tegra_clk_register_super_clk(const char *name,
-		const char * const *parent_names, u8 num_parents,
+		const char * const *parent_names, u8 num_parents, u8 pllx_index,
 		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
 		spinlock_t *lock);
 
-- 
2.18.0

