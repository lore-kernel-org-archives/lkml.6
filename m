Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E32ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41C920C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mHf13mpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41C920C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeGQK2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:28:15 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55830 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbeGQK2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:28:14 -0400
Received: by mail-wm0-f52.google.com with SMTP id f21-v6so840742wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6zdosieg20y52GvQAI9T7aYx1mTachcafh+vnV2lvTo=;
        b=mHf13mpurPieuNjTdFAKD08zvbIAVXUep8tgabdcKUNsjPbgZnE8ceeTU7nPBwCrJy
         6QqpmjncMN8pQufFeD2hcKAlRzKhM7SZ+n+z5fDgRPCheLKDR1aCoZlbiPwgP69Hc2P6
         769SBGH5FNAGsEAlVJwU+P7VQb2sUlqD/NT4zBBVukzW5seOmmeQ6cLC32kX4yFF3N8G
         ZvdrDu1LWcbcjIqX2KlX4TncBepJC1nITsFsO2f0SrIxLAvCsGHfX+cVeUHiF4ttDoGo
         mQmtyeeCzsZ0tV6KsJaw3z+/9yuWzIQIsKogW8qNamyZCt8SxysSEkJJxsS1AhradfP4
         t3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6zdosieg20y52GvQAI9T7aYx1mTachcafh+vnV2lvTo=;
        b=FTvZuzSP1EkCIwMlIIXtP6nWm8gV+nWiQJWoSBI6+/HG+sMNQHqN0RT7aKaqZ/28G+
         f5Yi093wHtR3Jpoy36eQLZKcbslKIb086g+ObgXt5xxkVqOTFlLJWzZtYibXMc6e5okL
         s+sGcHjxT1MFpMOlWdsEyPxaV0v3MtMjmjDHJwyiyqgDwhkNkPAyvmaaBXaDCN5RbT8a
         DXQgGC29VVQLr/vWVYHfUdIZV0uldWEiTnYoX11v8o/CG4nzCq9iG5Ls2ZoQF0ULt4Ts
         q4a1vauUxP7f9ZVHanw3ddAnHw9kKjZC8nrIRWbto61crtLlNC7/AUcC3zDgqLhblNEZ
         a7Rg==
X-Gm-Message-State: AOUpUlGEvFTIYuy3zU455Bi7IMa7JjobQKVDU3bAw5GAkg4xnB49sqe7
        k5omp1qaRSHgDhdCSMa7HYGb8w==
X-Google-Smtp-Source: AAOMgpdJJWH9oYlcm6xCUBgv2250+ic1DMmO9d4GfOOEVltPa0nM/ORzXvEMsboYnASgvCw+L/TTig==
X-Received: by 2002:a1c:f20d:: with SMTP id s13-v6mr857677wmc.36.1531821384240;
        Tue, 17 Jul 2018 02:56:24 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b10-v6sm1199249wrp.49.2018.07.17.02.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 02:56:23 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] clk: meson: clk-pll: drop hard-coded rates from pll tables
Date:   Tue, 17 Jul 2018 11:56:17 +0200
Message-Id: <20180717095617.12240-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717095617.12240-1-jbrunet@baylibre.com>
References: <20180717095617.12240-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting hard-coded rates inside the parameter tables assumes that
the parent is known and will never change. That's a big assumption
we should not make.

We have everything we need to recalculate the output rate using
the parent rate and the rest of the parameters. Let's do so and
drop the rates from the tables.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     |  73 +++++++++++++--------------
 drivers/clk/meson/clk-pll.c |  69 ++++++++++++++++---------
 drivers/clk/meson/clkc.h    |   8 ++-
 drivers/clk/meson/gxbb.c    | 120 ++++++++++++++++++++++----------------------
 drivers/clk/meson/meson8b.c |  34 ++++++-------
 5 files changed, 162 insertions(+), 142 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 572358062459..d34954bd8c5e 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -130,36 +130,36 @@ static struct clk_regmap axg_sys_pll = {
 	},
 };
 
-static const struct pll_rate_table axg_gp0_pll_rate_table[] = {
-	PLL_RATE(960000000, 40, 1),
-	PLL_RATE(984000000, 41, 1),
-	PLL_RATE(1008000000, 42, 1),
-	PLL_RATE(1032000000, 43, 1),
-	PLL_RATE(1056000000, 44, 1),
-	PLL_RATE(1080000000, 45, 1),
-	PLL_RATE(1104000000, 46, 1),
-	PLL_RATE(1128000000, 47, 1),
-	PLL_RATE(1152000000, 48, 1),
-	PLL_RATE(1176000000, 49, 1),
-	PLL_RATE(1200000000, 50, 1),
-	PLL_RATE(1224000000, 51, 1),
-	PLL_RATE(1248000000, 52, 1),
-	PLL_RATE(1272000000, 53, 1),
-	PLL_RATE(1296000000, 54, 1),
-	PLL_RATE(1320000000, 55, 1),
-	PLL_RATE(1344000000, 56, 1),
-	PLL_RATE(1368000000, 57, 1),
-	PLL_RATE(1392000000, 58, 1),
-	PLL_RATE(1416000000, 59, 1),
-	PLL_RATE(1440000000, 60, 1),
-	PLL_RATE(1464000000, 61, 1),
-	PLL_RATE(1488000000, 62, 1),
-	PLL_RATE(1512000000, 63, 1),
-	PLL_RATE(1536000000, 64, 1),
-	PLL_RATE(1560000000, 65, 1),
-	PLL_RATE(1584000000, 66, 1),
-	PLL_RATE(1608000000, 67, 1),
-	PLL_RATE(1632000000, 68, 1),
+static const struct pll_params_table axg_gp0_pll_params_table[] = {
+	PLL_PARAMS(40, 1),
+	PLL_PARAMS(41, 1),
+	PLL_PARAMS(42, 1),
+	PLL_PARAMS(43, 1),
+	PLL_PARAMS(44, 1),
+	PLL_PARAMS(45, 1),
+	PLL_PARAMS(46, 1),
+	PLL_PARAMS(47, 1),
+	PLL_PARAMS(48, 1),
+	PLL_PARAMS(49, 1),
+	PLL_PARAMS(50, 1),
+	PLL_PARAMS(51, 1),
+	PLL_PARAMS(52, 1),
+	PLL_PARAMS(53, 1),
+	PLL_PARAMS(54, 1),
+	PLL_PARAMS(55, 1),
+	PLL_PARAMS(56, 1),
+	PLL_PARAMS(57, 1),
+	PLL_PARAMS(58, 1),
+	PLL_PARAMS(59, 1),
+	PLL_PARAMS(60, 1),
+	PLL_PARAMS(61, 1),
+	PLL_PARAMS(62, 1),
+	PLL_PARAMS(63, 1),
+	PLL_PARAMS(64, 1),
+	PLL_PARAMS(65, 1),
+	PLL_PARAMS(66, 1),
+	PLL_PARAMS(67, 1),
+	PLL_PARAMS(68, 1),
 	{ /* sentinel */ },
 };
 
@@ -203,7 +203,7 @@ static struct clk_regmap axg_gp0_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = axg_gp0_pll_rate_table,
+		.table = axg_gp0_pll_params_table,
 		.init_regs = axg_gp0_init_regs,
 		.init_count = ARRAY_SIZE(axg_gp0_init_regs),
 	},
@@ -271,7 +271,7 @@ static struct clk_regmap axg_hifi_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = axg_gp0_pll_rate_table,
+		.table = axg_gp0_pll_params_table,
 		.init_regs = axg_hifi_init_regs,
 		.init_count = ARRAY_SIZE(axg_hifi_init_regs),
 		.flags = CLK_MESON_PLL_ROUND_CLOSEST,
@@ -627,11 +627,10 @@ static struct clk_regmap axg_mpll3 = {
 	},
 };
 
-static const struct pll_rate_table axg_pcie_pll_rate_table[] = {
+static const struct pll_params_table axg_pcie_pll_params_table[] = {
 	{
-		.rate	= 1600000000,
-		.m	= 200,
-		.n	= 3,
+		.m = 200,
+		.n = 3,
 	},
 	{ /* sentinel */ },
 };
@@ -678,7 +677,7 @@ static struct clk_regmap axg_pcie_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = axg_pcie_pll_rate_table,
+		.table = axg_pcie_pll_params_table,
 		.init_regs = axg_pcie_init_regs,
 		.init_count = ARRAY_SIZE(axg_pcie_init_regs),
 	},
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 348a866f09eb..f5b5b3fabe3c 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -45,7 +45,7 @@ meson_clk_pll_data(struct clk_regmap *clk)
 }
 
 static unsigned long __pll_params_to_rate(unsigned long parent_rate,
-					  const struct pll_rate_table *pllt,
+					  const struct pll_params_table *pllt,
 					  u16 frac,
 					  struct meson_clk_pll_data *pll)
 {
@@ -66,7 +66,7 @@ static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	struct pll_rate_table pllt;
+	struct pll_params_table pllt;
 	u16 frac;
 
 	pllt.n = meson_parm_read(clk->map, &pll->n);
@@ -81,7 +81,7 @@ static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
 
 static u16 __pll_params_with_frac(unsigned long rate,
 				  unsigned long parent_rate,
-				  const struct pll_rate_table *pllt,
+				  const struct pll_params_table *pllt,
 				  struct meson_clk_pll_data *pll)
 {
 	u16 frac_max = (1 << pll->frac.width);
@@ -97,29 +97,50 @@ static u16 __pll_params_with_frac(unsigned long rate,
 	return min((u16)val, (u16)(frac_max - 1));
 }
 
-static const struct pll_rate_table *
+static bool meson_clk_pll_is_better(unsigned long rate,
+				    unsigned long best,
+				    unsigned long now,
+				    struct meson_clk_pll_data *pll)
+{
+	if (!(pll->flags & CLK_MESON_PLL_ROUND_CLOSEST) ||
+	    MESON_PARM_APPLICABLE(&pll->frac)) {
+		/* Round down */
+		if (now < rate && best < now)
+			return true;
+	} else {
+		/* Round Closest */
+		if (abs(now - rate) < abs(best - rate))
+			return true;
+	}
+
+	return false;
+}
+
+static const struct pll_params_table *
 meson_clk_get_pll_settings(unsigned long rate,
+			   unsigned long parent_rate,
 			   struct meson_clk_pll_data *pll)
 {
-	const struct pll_rate_table *table = pll->table;
-	unsigned int i = 0;
+	const struct pll_params_table *table = pll->table;
+	unsigned long best = 0, now = 0;
+	unsigned int i, best_i = 0;
 
 	if (!table)
 		return NULL;
 
-	/* Find the first table element exceeding rate */
-	while (table[i].rate && table[i].rate <= rate)
-		i++;
+	for (i = 0; table[i].n; i++) {
+		now = __pll_params_to_rate(parent_rate, &table[i], 0, pll);
 
-	if (i != 0) {
-		if (MESON_PARM_APPLICABLE(&pll->frac) ||
-		    !(pll->flags & CLK_MESON_PLL_ROUND_CLOSEST) ||
-		    (abs(rate - table[i - 1].rate) <
-		     abs(rate - table[i].rate)))
-			i--;
+		/* If we get an exact match, don't bother any further */
+		if (now == rate) {
+			return &table[i];
+		} else if (meson_clk_pll_is_better(rate, best, now, pll)) {
+			best = now;
+			best_i = i;
+		}
 	}
 
-	return (struct pll_rate_table *)&table[i];
+	return (struct pll_params_table *)&table[best_i];
 }
 
 static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -127,16 +148,18 @@ static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	const struct pll_rate_table *pllt =
-		meson_clk_get_pll_settings(rate, pll);
+	const struct pll_params_table *pllt =
+		meson_clk_get_pll_settings(rate, *parent_rate, pll);
+	unsigned long round;
 	u16 frac;
 
 	if (!pllt)
 		return meson_clk_pll_recalc_rate(hw, *parent_rate);
 
-	if (!MESON_PARM_APPLICABLE(&pll->frac)
-	    || rate == pllt->rate)
-		return pllt->rate;
+	round = __pll_params_to_rate(*parent_rate, pllt, 0, pll);
+
+	if (!MESON_PARM_APPLICABLE(&pll->frac) || rate == round)
+		return round;
 
 	/*
 	 * The rate provided by the setting is not an exact match, let's
@@ -214,7 +237,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	const struct pll_rate_table *pllt;
+	const struct pll_params_table *pllt;
 	unsigned int enabled;
 	unsigned long old_rate;
 	u16 frac = 0;
@@ -224,7 +247,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	old_rate = rate;
 
-	pllt = meson_clk_get_pll_settings(rate, pll);
+	pllt = meson_clk_get_pll_settings(rate, parent_rate, pll);
 	if (!pllt)
 		return -EINVAL;
 
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index a2245e857f70..6b96d55c047d 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -43,15 +43,13 @@ static inline void meson_parm_write(struct regmap *map, struct parm *p,
 }
 
 
-struct pll_rate_table {
-	unsigned long	rate;
+struct pll_params_table {
 	u16		m;
 	u16		n;
 };
 
-#define PLL_RATE(_r, _m, _n)						\
+#define PLL_PARAMS(_m, _n)						\
 	{								\
-		.rate		= (_r),					\
 		.m		= (_m),					\
 		.n		= (_n),					\
 	}
@@ -67,7 +65,7 @@ struct meson_clk_pll_data {
 	struct parm rst;
 	const struct reg_sequence *init_regs;
 	unsigned int init_count;
-	const struct pll_rate_table *table;
+	const struct pll_params_table *table;
 	u8 flags;
 };
 
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index e2d94498f098..9ac03c7bfbaa 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -18,67 +18,67 @@
 
 static DEFINE_SPINLOCK(meson_clk_lock);
 
-static const struct pll_rate_table gxbb_gp0_pll_rate_table[] = {
-	PLL_RATE(768000000, 32, 1),
-	PLL_RATE(792000000, 33, 1),
-	PLL_RATE(816000000, 34, 1),
-	PLL_RATE(840000000, 35, 1),
-	PLL_RATE(864000000, 36, 1),
-	PLL_RATE(888000000, 37, 1),
-	PLL_RATE(912000000, 38, 1),
-	PLL_RATE(936000000, 39, 1),
-	PLL_RATE(960000000, 40, 1),
-	PLL_RATE(984000000, 41, 1),
-	PLL_RATE(1008000000, 42, 1),
-	PLL_RATE(1032000000, 43, 1),
-	PLL_RATE(1056000000, 44, 1),
-	PLL_RATE(1080000000, 45, 1),
-	PLL_RATE(1104000000, 46, 1),
-	PLL_RATE(1128000000, 47, 1),
-	PLL_RATE(1152000000, 48, 1),
-	PLL_RATE(1176000000, 49, 1),
-	PLL_RATE(1200000000, 50, 1),
-	PLL_RATE(1224000000, 51, 1),
-	PLL_RATE(1248000000, 52, 1),
-	PLL_RATE(1272000000, 53, 1),
-	PLL_RATE(1296000000, 54, 1),
-	PLL_RATE(1320000000, 55, 1),
-	PLL_RATE(1344000000, 56, 1),
-	PLL_RATE(1368000000, 57, 1),
-	PLL_RATE(1392000000, 58, 1),
-	PLL_RATE(1416000000, 59, 1),
-	PLL_RATE(1440000000, 60, 1),
-	PLL_RATE(1464000000, 61, 1),
-	PLL_RATE(1488000000, 62, 1),
+static const struct pll_params_table gxbb_gp0_pll_params_table[] = {
+	PLL_PARAMS(32, 1),
+	PLL_PARAMS(33, 1),
+	PLL_PARAMS(34, 1),
+	PLL_PARAMS(35, 1),
+	PLL_PARAMS(36, 1),
+	PLL_PARAMS(37, 1),
+	PLL_PARAMS(38, 1),
+	PLL_PARAMS(39, 1),
+	PLL_PARAMS(40, 1),
+	PLL_PARAMS(41, 1),
+	PLL_PARAMS(42, 1),
+	PLL_PARAMS(43, 1),
+	PLL_PARAMS(44, 1),
+	PLL_PARAMS(45, 1),
+	PLL_PARAMS(46, 1),
+	PLL_PARAMS(47, 1),
+	PLL_PARAMS(48, 1),
+	PLL_PARAMS(49, 1),
+	PLL_PARAMS(50, 1),
+	PLL_PARAMS(51, 1),
+	PLL_PARAMS(52, 1),
+	PLL_PARAMS(53, 1),
+	PLL_PARAMS(54, 1),
+	PLL_PARAMS(55, 1),
+	PLL_PARAMS(56, 1),
+	PLL_PARAMS(57, 1),
+	PLL_PARAMS(58, 1),
+	PLL_PARAMS(59, 1),
+	PLL_PARAMS(60, 1),
+	PLL_PARAMS(61, 1),
+	PLL_PARAMS(62, 1),
 	{ /* sentinel */ },
 };
 
-static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
-	PLL_RATE(1008000000, 42, 1),
-	PLL_RATE(1032000000, 43, 1),
-	PLL_RATE(1056000000, 44, 1),
-	PLL_RATE(1080000000, 45, 1),
-	PLL_RATE(1104000000, 46, 1),
-	PLL_RATE(1128000000, 47, 1),
-	PLL_RATE(1152000000, 48, 1),
-	PLL_RATE(1176000000, 49, 1),
-	PLL_RATE(1200000000, 50, 1),
-	PLL_RATE(1224000000, 51, 1),
-	PLL_RATE(1248000000, 52, 1),
-	PLL_RATE(1272000000, 53, 1),
-	PLL_RATE(1296000000, 54, 1),
-	PLL_RATE(1320000000, 55, 1),
-	PLL_RATE(1344000000, 56, 1),
-	PLL_RATE(1368000000, 57, 1),
-	PLL_RATE(1392000000, 58, 1),
-	PLL_RATE(1416000000, 59, 1),
-	PLL_RATE(1440000000, 60, 1),
-	PLL_RATE(1464000000, 61, 1),
-	PLL_RATE(1488000000, 62, 1),
-	PLL_RATE(1512000000, 63, 1),
-	PLL_RATE(1536000000, 64, 1),
-	PLL_RATE(1560000000, 65, 1),
-	PLL_RATE(1584000000, 66, 1),
+static const struct pll_params_table gxl_gp0_pll_params_table[] = {
+	PLL_PARAMS(42, 1),
+	PLL_PARAMS(43, 1),
+	PLL_PARAMS(44, 1),
+	PLL_PARAMS(45, 1),
+	PLL_PARAMS(46, 1),
+	PLL_PARAMS(47, 1),
+	PLL_PARAMS(48, 1),
+	PLL_PARAMS(49, 1),
+	PLL_PARAMS(50, 1),
+	PLL_PARAMS(51, 1),
+	PLL_PARAMS(52, 1),
+	PLL_PARAMS(53, 1),
+	PLL_PARAMS(54, 1),
+	PLL_PARAMS(55, 1),
+	PLL_PARAMS(56, 1),
+	PLL_PARAMS(57, 1),
+	PLL_PARAMS(58, 1),
+	PLL_PARAMS(59, 1),
+	PLL_PARAMS(60, 1),
+	PLL_PARAMS(61, 1),
+	PLL_PARAMS(62, 1),
+	PLL_PARAMS(63, 1),
+	PLL_PARAMS(64, 1),
+	PLL_PARAMS(65, 1),
+	PLL_PARAMS(66, 1),
 	{ /* sentinel */ },
 };
 
@@ -374,7 +374,7 @@ static struct clk_regmap gxbb_gp0_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = gxbb_gp0_pll_rate_table,
+		.table = gxbb_gp0_pll_params_table,
 		.init_regs = gxbb_gp0_init_regs,
 		.init_count = ARRAY_SIZE(gxbb_gp0_init_regs),
 	},
@@ -427,7 +427,7 @@ static struct clk_regmap gxl_gp0_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = gxl_gp0_pll_rate_table,
+		.table = gxl_gp0_pll_params_table,
 		.init_regs = gxl_gp0_init_regs,
 		.init_count = ARRAY_SIZE(gxl_gp0_init_regs),
 	},
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 17bcf0be56ba..30ae849ff53f 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -29,22 +29,22 @@ struct meson8b_clk_reset {
 	void __iomem *base;
 };
 
-static const struct pll_rate_table sys_pll_rate_table[] = {
-	PLL_RATE(1200000000, 50, 1),
-	PLL_RATE(1224000000, 51, 1),
-	PLL_RATE(1248000000, 52, 1),
-	PLL_RATE(1272000000, 53, 1),
-	PLL_RATE(1296000000, 54, 1),
-	PLL_RATE(1320000000, 55, 1),
-	PLL_RATE(1344000000, 56, 1),
-	PLL_RATE(1368000000, 57, 1),
-	PLL_RATE(1392000000, 58, 1),
-	PLL_RATE(1416000000, 59, 1),
-	PLL_RATE(1440000000, 60, 1),
-	PLL_RATE(1464000000, 61, 1),
-	PLL_RATE(1488000000, 62, 1),
-	PLL_RATE(1512000000, 63, 1),
-	PLL_RATE(1536000000, 64, 1),
+static const struct pll_params_table sys_pll_params_table[] = {
+	PLL_PARAMS(50, 1),
+	PLL_PARAMS(51, 1),
+	PLL_PARAMS(52, 1),
+	PLL_PARAMS(53, 1),
+	PLL_PARAMS(54, 1),
+	PLL_PARAMS(55, 1),
+	PLL_PARAMS(56, 1),
+	PLL_PARAMS(57, 1),
+	PLL_PARAMS(58, 1),
+	PLL_PARAMS(59, 1),
+	PLL_PARAMS(60, 1),
+	PLL_PARAMS(61, 1),
+	PLL_PARAMS(62, 1),
+	PLL_PARAMS(63, 1),
+	PLL_PARAMS(64, 1),
 	{ /* sentinel */ },
 };
 
@@ -195,7 +195,7 @@ static struct clk_regmap meson8b_sys_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = sys_pll_rate_table,
+		.table = sys_pll_params_table,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll_dco",
-- 
2.14.4

