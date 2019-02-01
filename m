Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD64C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309B420823
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IrpAmkbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfBAOx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:53:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43939 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbfBAOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:53:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id b4so484578wrq.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 06:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LqAPPSkjpSJhEFdQOgK6T8VKoQsUzH7Y2wdaiKe2ixw=;
        b=IrpAmkbdL8NZ58a7Tgp+PeKEKuJYitxz8KsnE1OzaoVQvCEcgMVzq+gpdNkaQqXUFU
         utYr/N62X0X7TB81aWh7j9IUOc92aL04D3o+M2P9Z5km+thd/bW5pWpUiDKA9xnvEvZV
         OoEcJ1/DK390MYr+Y8deqzZiJNSNxOFiJeLoKONHd3MJvVvcOaT6CjegKZduBcfpvRnp
         68YQTfo7lBGFDO3m9dnS8MqEvgw1tZFuFyuvYcpRVoUTUgEHxxpXJx41p2fHC/2LoL+t
         vJa023jPppBFT+NceY54wouo3QqcJkujO+tY1h4KKNsyScUXRUVZpSLR+BBBoTbJA4wb
         hNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LqAPPSkjpSJhEFdQOgK6T8VKoQsUzH7Y2wdaiKe2ixw=;
        b=HnbXg3lO6k245L7egbwBLq2lHz8DXBAlHiyNTgs1i5ogiqZac5OBgB+5V3LdKrU40k
         3HzfRVjvAsf2Y9P6bZrwYdo6LwgzSHkwipyJ9Px4I+B9rEd8Kfhx9XlbkxMZpgi3z5YN
         y8ClyPjyV7fJdqJcoYazev+dTBMv2309lnNxKPgC4U1HMd81S7QqIOkAUkuyP5/pNK+Z
         zsqre8VNk+a7iCpJExvRGG1J54oH6ya4kI8eXxBYKSNa4RZvfSew004iD8+yT8bfYWvy
         y+KhtFuno+DdzXVO+wXFzW+LOuviBZRfnPNp34LzMEpgM6Tym6rTlwfbnQhMhRJbRjgt
         gAoA==
X-Gm-Message-State: AJcUukf+YtNKFlfOROhEgYVZ/tUjzTP1Y8riZ7uEK4zyDdfsR7WXEu3i
        PoXYeQSAHNJVZv8bngoQLug9Bg==
X-Google-Smtp-Source: ALg8bN7ZKsX4+eFRIyZedX79JpPhzMtgOwDe5l7oPr6h5a7/T1En3wYxotcPtTeqhdGqr+YN1sBnhQ==
X-Received: by 2002:adf:8068:: with SMTP id 95mr39813273wrk.181.1549032833723;
        Fri, 01 Feb 2019 06:53:53 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id x186sm4754644wmg.41.2019.02.01.06.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 06:53:52 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Jian Hu <jian.hu@amlogic.com>
Subject: [PATCH v6 1/4] clk: meson: pll: update driver for the g12a
Date:   Fri,  1 Feb 2019 15:53:42 +0100
Message-Id: <20190201145345.6795-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201145345.6795-1-jbrunet@baylibre.com>
References: <20190201145345.6795-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The g12a use fractional parameter of 17 useful bits. At the moment, this
parameter in encoded using u16 value. Use this opportunity to switch all
the pll to parameter to unsigned int. This should save us some annoying
trouble shooting when and m and n field eventually grow as well.

This patch also introduce pll multiplier range. On the g12a, the hifi and
gp0 plls are able to lock as long as the following condition is met:
55 <= m/n <= 255.

The param table describing this would be huge which is a waste of memory.
Using ranges, we can save memory. Ranges also help find the best pll
parameter significantly faster since we don't have to try all the possible
settings.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Side note:
You may notice that the g12a documentation says that the fractional
parameter of the hifi and gp0 pll is actually 19 bits long.

On older plls, frac was a ratio in the [0, 1[ range.
On the newer plls, the range is ]-2, 2[.

The last 2 bits give the sign and allows to go over 1. Supporting this
would complicate things a lot while not bringing anything useful.
Instead of using this extended frac range, we can simply adjust m and
reach the same solution.

Discarding the last two bits allows to treat older and newer pll models
indifferently.

 drivers/clk/meson/clk-pll.c | 203 ++++++++++++++++++++++++++----------
 drivers/clk/meson/clk-pll.h |  10 +-
 2 files changed, 154 insertions(+), 59 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 4a8c68ae8801..7946d21a4ff4 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/rational.h>
 
 #include "clk-regmap.h"
 #include "clk-pll.h"
@@ -42,12 +43,21 @@ meson_clk_pll_data(struct clk_regmap *clk)
 	return (struct meson_clk_pll_data *)clk->data;
 }
 
+static int __pll_round_closest_mult(struct meson_clk_pll_data *pll)
+{
+	if ((pll->flags & CLK_MESON_PLL_ROUND_CLOSEST) &&
+	    !MESON_PARM_APPLICABLE(&pll->frac))
+		return 1;
+
+	return 0;
+}
+
 static unsigned long __pll_params_to_rate(unsigned long parent_rate,
-					  const struct pll_params_table *pllt,
-					  u16 frac,
+					  unsigned int m, unsigned int n,
+					  unsigned int frac,
 					  struct meson_clk_pll_data *pll)
 {
-	u64 rate = (u64)parent_rate * pllt->m;
+	u64 rate = (u64)parent_rate * m;
 
 	if (frac && MESON_PARM_APPLICABLE(&pll->frac)) {
 		u64 frac_rate = (u64)parent_rate * frac;
@@ -56,7 +66,7 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
 					 (1 << pll->frac.width));
 	}
 
-	return DIV_ROUND_UP_ULL(rate, pllt->n);
+	return DIV_ROUND_UP_ULL(rate, n);
 }
 
 static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
@@ -64,35 +74,39 @@ static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	struct pll_params_table pllt;
-	u16 frac;
+	unsigned int m, n, frac;
 
-	pllt.n = meson_parm_read(clk->map, &pll->n);
-	pllt.m = meson_parm_read(clk->map, &pll->m);
+	n = meson_parm_read(clk->map, &pll->n);
+	m = meson_parm_read(clk->map, &pll->m);
 
 	frac = MESON_PARM_APPLICABLE(&pll->frac) ?
 		meson_parm_read(clk->map, &pll->frac) :
 		0;
 
-	return __pll_params_to_rate(parent_rate, &pllt, frac, pll);
+	return __pll_params_to_rate(parent_rate, m, n, frac, pll);
 }
 
-static u16 __pll_params_with_frac(unsigned long rate,
-				  unsigned long parent_rate,
-				  const struct pll_params_table *pllt,
-				  struct meson_clk_pll_data *pll)
+static unsigned int __pll_params_with_frac(unsigned long rate,
+					   unsigned long parent_rate,
+					   unsigned int m,
+					   unsigned int n,
+					   struct meson_clk_pll_data *pll)
 {
-	u16 frac_max = (1 << pll->frac.width);
-	u64 val = (u64)rate * pllt->n;
+	unsigned int frac_max = (1 << pll->frac.width);
+	u64 val = (u64)rate * n;
+
+	/* Bail out if we are already over the requested rate */
+	if (rate < parent_rate * m / n)
+		return 0;
 
 	if (pll->flags & CLK_MESON_PLL_ROUND_CLOSEST)
 		val = DIV_ROUND_CLOSEST_ULL(val * frac_max, parent_rate);
 	else
 		val = div_u64(val * frac_max, parent_rate);
 
-	val -= pllt->m * frac_max;
+	val -= m * frac_max;
 
-	return min((u16)val, (u16)(frac_max - 1));
+	return min((unsigned int)val, (frac_max - 1));
 }
 
 static bool meson_clk_pll_is_better(unsigned long rate,
@@ -100,45 +114,123 @@ static bool meson_clk_pll_is_better(unsigned long rate,
 				    unsigned long now,
 				    struct meson_clk_pll_data *pll)
 {
-	if (!(pll->flags & CLK_MESON_PLL_ROUND_CLOSEST) ||
-	    MESON_PARM_APPLICABLE(&pll->frac)) {
-		/* Round down */
-		if (now < rate && best < now)
-			return true;
-	} else {
+	if (__pll_round_closest_mult(pll)) {
 		/* Round Closest */
 		if (abs(now - rate) < abs(best - rate))
 			return true;
+	} else {
+		/* Round down */
+		if (now < rate && best < now)
+			return true;
 	}
 
 	return false;
 }
 
-static const struct pll_params_table *
-meson_clk_get_pll_settings(unsigned long rate,
-			   unsigned long parent_rate,
-			   struct meson_clk_pll_data *pll)
+static int meson_clk_get_pll_table_index(unsigned int index,
+					 unsigned int *m,
+					 unsigned int *n,
+					 struct meson_clk_pll_data *pll)
 {
-	const struct pll_params_table *table = pll->table;
-	unsigned long best = 0, now = 0;
-	unsigned int i, best_i = 0;
+	if (!pll->table[index].n)
+		return -EINVAL;
+
+	*m = pll->table[index].m;
+	*n = pll->table[index].n;
+
+	return 0;
+}
+
+static unsigned int meson_clk_get_pll_range_m(unsigned long rate,
+					      unsigned long parent_rate,
+					      unsigned int n,
+					      struct meson_clk_pll_data *pll)
+{
+	u64 val = (u64)rate * n;
+
+	if (__pll_round_closest_mult(pll))
+		return DIV_ROUND_CLOSEST_ULL(val, parent_rate);
 
-	if (!table)
-		return NULL;
+	return val / parent_rate;
+}
+
+static int meson_clk_get_pll_range_index(unsigned long rate,
+					 unsigned long parent_rate,
+					 unsigned int index,
+					 unsigned int *m,
+					 unsigned int *n,
+					 struct meson_clk_pll_data *pll)
+{
+	*n = index + 1;
+
+	/* Check the predivider range */
+	if (*n >= (1 << pll->n.width))
+		return -EINVAL;
+
+	if (*n == 1) {
+		/* Get the boundaries out the way */
+		if (rate <= pll->range->min * parent_rate) {
+			*m = pll->range->min;
+			return -ENODATA;
+		} else if (rate >= pll->range->max * parent_rate) {
+			*m = pll->range->max;
+			return -ENODATA;
+		}
+	}
+
+	*m = meson_clk_get_pll_range_m(rate, parent_rate, *n, pll);
+
+	/* the pre-divider gives a multiplier too big - stop */
+	if (*m >= (1 << pll->m.width))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int meson_clk_get_pll_get_index(unsigned long rate,
+				       unsigned long parent_rate,
+				       unsigned int index,
+				       unsigned int *m,
+				       unsigned int *n,
+				       struct meson_clk_pll_data *pll)
+{
+	if (pll->range)
+		return meson_clk_get_pll_range_index(rate, parent_rate,
+						     index, m, n, pll);
+	else if (pll->table)
+		return meson_clk_get_pll_table_index(index, m, n, pll);
+
+	return -EINVAL;
+}
 
-	for (i = 0; table[i].n; i++) {
-		now = __pll_params_to_rate(parent_rate, &table[i], 0, pll);
+static int meson_clk_get_pll_settings(unsigned long rate,
+				      unsigned long parent_rate,
+				      unsigned int *best_m,
+				      unsigned int *best_n,
+				      struct meson_clk_pll_data *pll)
+{
+	unsigned long best = 0, now = 0;
+	unsigned int i, m, n;
+	int ret;
+
+	for (i = 0, ret = 0; !ret; i++) {
+		ret = meson_clk_get_pll_get_index(rate, parent_rate,
+						  i, &m, &n, pll);
+		if (ret == -EINVAL)
+			break;
 
-		/* If we get an exact match, don't bother any further */
-		if (now == rate) {
-			return &table[i];
-		} else if (meson_clk_pll_is_better(rate, best, now, pll)) {
+		now = __pll_params_to_rate(parent_rate, m, n, 0, pll);
+		if (meson_clk_pll_is_better(rate, best, now, pll)) {
 			best = now;
-			best_i = i;
+			*best_m = m;
+			*best_n = n;
+
+			if (now == rate)
+				break;
 		}
 	}
 
-	return (struct pll_params_table *)&table[best_i];
+	return best ? 0 : -EINVAL;
 }
 
 static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -146,15 +238,15 @@ static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	const struct pll_params_table *pllt =
-		meson_clk_get_pll_settings(rate, *parent_rate, pll);
+	unsigned int m, n, frac;
 	unsigned long round;
-	u16 frac;
+	int ret;
 
-	if (!pllt)
+	ret = meson_clk_get_pll_settings(rate, *parent_rate, &m, &n, pll);
+	if (ret)
 		return meson_clk_pll_recalc_rate(hw, *parent_rate);
 
-	round = __pll_params_to_rate(*parent_rate, pllt, 0, pll);
+	round = __pll_params_to_rate(*parent_rate, m, n, 0, pll);
 
 	if (!MESON_PARM_APPLICABLE(&pll->frac) || rate == round)
 		return round;
@@ -163,9 +255,9 @@ static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * The rate provided by the setting is not an exact match, let's
 	 * try to improve the result using the fractional parameter
 	 */
-	frac = __pll_params_with_frac(rate, *parent_rate, pllt, pll);
+	frac = __pll_params_with_frac(rate, *parent_rate, m, n, pll);
 
-	return __pll_params_to_rate(*parent_rate, pllt, frac, pll);
+	return __pll_params_to_rate(*parent_rate, m, n, frac, pll);
 }
 
 static int meson_clk_pll_wait_lock(struct clk_hw *hw)
@@ -252,30 +344,27 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	const struct pll_params_table *pllt;
-	unsigned int enabled;
+	unsigned int enabled, m, n, frac = 0, ret;
 	unsigned long old_rate;
-	u16 frac = 0;
 
 	if (parent_rate == 0 || rate == 0)
 		return -EINVAL;
 
 	old_rate = rate;
 
-	pllt = meson_clk_get_pll_settings(rate, parent_rate, pll);
-	if (!pllt)
-		return -EINVAL;
+	ret = meson_clk_get_pll_settings(rate, parent_rate, &m, &n, pll);
+	if (ret)
+		return ret;
 
 	enabled = meson_parm_read(clk->map, &pll->en);
 	if (enabled)
 		meson_clk_pll_disable(hw);
 
-	meson_parm_write(clk->map, &pll->n, pllt->n);
-	meson_parm_write(clk->map, &pll->m, pllt->m);
-
+	meson_parm_write(clk->map, &pll->n, n);
+	meson_parm_write(clk->map, &pll->m, m);
 
 	if (MESON_PARM_APPLICABLE(&pll->frac)) {
-		frac = __pll_params_with_frac(rate, parent_rate, pllt, pll);
+		frac = __pll_params_with_frac(rate, parent_rate, m, n, pll);
 		meson_parm_write(clk->map, &pll->frac, frac);
 	}
 
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index 5ccf0854d932..55af2e285b1b 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -12,8 +12,13 @@
 #include "parm.h"
 
 struct pll_params_table {
-	u16		m;
-	u16		n;
+	unsigned int	m;
+	unsigned int	n;
+};
+
+struct pll_mult_range {
+	unsigned int	min;
+	unsigned int	max;
 };
 
 #define PLL_PARAMS(_m, _n)						\
@@ -34,6 +39,7 @@ struct meson_clk_pll_data {
 	const struct reg_sequence *init_regs;
 	unsigned int init_count;
 	const struct pll_params_table *table;
+	const struct pll_mult_range *range;
 	u8 flags;
 };
 
-- 
2.20.1

