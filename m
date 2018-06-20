Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999A0C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F26C20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PVZ8AytX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F26C20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeFTKG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:06:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37344 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754137AbeFTKGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:06:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id r125-v6so5741279wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6q2toK54fEHCDkr1ddWCW+wwe2hAKOxiZQKeKjvFnL4=;
        b=PVZ8AytXaJJCJ2pzZ+kUWMfV7pySTfZDjxz7aqcA5D6Fk1pHX6jZO19iTrLMrzOdV/
         rRontj4/rwGfuQ73+Tx/iwSJsO6Edb84w2+jLV6I2sDmQkDrpReEo17gac6mrhq/N1wN
         ijpxsWJyMV36rWg9KA0FAJ22bxItpLnoHb1BZCKnDx1i57h2q5Mjgf9gucNsr+TlCQBp
         ccnKncwByOBgaIjRmKi+UTi4jQ8AwIgs50T/e4yq6UXqRFn45fWQHDR3mgRAQt0nKicu
         L0WJGb24rGk4h8KiLQXiO9+EPHtB2+NX7yQfwKiBifQ+u6iPUOOcBxVdNmZGUACGJddC
         BDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6q2toK54fEHCDkr1ddWCW+wwe2hAKOxiZQKeKjvFnL4=;
        b=jnJvraiiL/y9Ri3GtbZr3NwWGOWQ4Dz9el7X2bXgNep61Z7iJWjJSkE2A8yYeYCreY
         0v209L7raT4t+Hn/U1iSGOO3KwiQ2FgM47WWgv9em1qUIX5e3Zu/l1nBQwxsQ6G/0QtD
         qNbhG6mWJttCtmzeEBXg0mhYCyXNPYk9WLAP+aGa764kjiAL4CmZ4ZIGV6jgN/cLPYRn
         au2KPpo3pJ6b4+zBc741JXtplrll0akDx8RjZfbu7+adFz2lEpS4q9FUOeBTMy2dOoxx
         sPFLdIbhz69gvIOoKWOUvO21oNrPvF8TRS3RYR7aYiWRzloYjp7QzCCi89lAszc7JMD1
         mpnA==
X-Gm-Message-State: APt69E1b8mhoK/aTlMGhc6Jej1BHZw+Hhub8d7KCsCtaBmCJlTGIeWPB
        2t/lM1DyQLGVSJ3HEZ0KpBBxfg==
X-Google-Smtp-Source: ADUXVKK4f6LOrx+DpXao+bJJg4JiWSOR1foIIy385/sz0/ixxmTMIuCXtP9169uIP0GW3NhvtTJMVA==
X-Received: by 2002:a1c:c208:: with SMTP id s8-v6mr1210383wmf.29.1529489181298;
        Wed, 20 Jun 2018 03:06:21 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m10-v6sm2685852wrq.56.2018.06.20.03.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 03:06:20 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: meson: remove unused clk-audio-divider driver
Date:   Wed, 20 Jun 2018 12:06:10 +0200
Message-Id: <20180620100610.29010-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180620100610.29010-1-jbrunet@baylibre.com>
References: <20180620100610.29010-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk-audio-divider is no longer used, we can remove it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Makefile            |   2 +-
 drivers/clk/meson/clk-audio-divider.c | 110 ----------------------------------
 drivers/clk/meson/clkc.h              |   7 ---
 3 files changed, 1 insertion(+), 118 deletions(-)
 delete mode 100644 drivers/clk/meson/clk-audio-divider.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index d0d13aeb369a..e40fea96069b 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Meson specific clk
 #
 
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
diff --git a/drivers/clk/meson/clk-audio-divider.c b/drivers/clk/meson/clk-audio-divider.c
deleted file mode 100644
index e4cf96ba704e..000000000000
--- a/drivers/clk/meson/clk-audio-divider.c
+++ /dev/null
@@ -1,110 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2017 AmLogic, Inc.
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-/*
- * i2s master clock divider: The algorithm of the generic clk-divider used with
- * a very precise clock parent such as the mpll tends to select a low divider
- * factor. This gives poor results with this particular divider, especially with
- * high frequencies (> 100 MHz)
- *
- * This driver try to select the maximum possible divider with the rate the
- * upstream clock can provide.
- */
-
-#include <linux/clk-provider.h>
-#include "clkc.h"
-
-static inline struct meson_clk_audio_div_data *
-meson_clk_audio_div_data(struct clk_regmap *clk)
-{
-	return (struct meson_clk_audio_div_data *)clk->data;
-}
-
-static int _div_round(unsigned long parent_rate, unsigned long rate,
-		      unsigned long flags)
-{
-	if (flags & CLK_DIVIDER_ROUND_CLOSEST)
-		return DIV_ROUND_CLOSEST_ULL((u64)parent_rate, rate);
-
-	return DIV_ROUND_UP_ULL((u64)parent_rate, rate);
-}
-
-static int _get_val(unsigned long parent_rate, unsigned long rate)
-{
-	return DIV_ROUND_UP_ULL((u64)parent_rate, rate) - 1;
-}
-
-static int _valid_divider(unsigned int width, int divider)
-{
-	int max_divider = 1 << width;
-
-	return clamp(divider, 1, max_divider);
-}
-
-static unsigned long audio_divider_recalc_rate(struct clk_hw *hw,
-					       unsigned long parent_rate)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_audio_div_data *adiv = meson_clk_audio_div_data(clk);
-	unsigned long divider;
-
-	divider = meson_parm_read(clk->map, &adiv->div) + 1;
-
-	return DIV_ROUND_UP_ULL((u64)parent_rate, divider);
-}
-
-static long audio_divider_round_rate(struct clk_hw *hw,
-				     unsigned long rate,
-				     unsigned long *parent_rate)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_audio_div_data *adiv = meson_clk_audio_div_data(clk);
-	unsigned long max_prate;
-	int divider;
-
-	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
-		divider = _div_round(*parent_rate, rate, adiv->flags);
-		divider = _valid_divider(adiv->div.width, divider);
-		return DIV_ROUND_UP_ULL((u64)*parent_rate, divider);
-	}
-
-	/* Get the maximum parent rate */
-	max_prate = clk_hw_round_rate(clk_hw_get_parent(hw), ULONG_MAX);
-
-	/* Get the corresponding rounded down divider */
-	divider = max_prate / rate;
-	divider = _valid_divider(adiv->div.width, divider);
-
-	/* Get actual rate of the parent */
-	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
-					 divider * rate);
-
-	return DIV_ROUND_UP_ULL((u64)*parent_rate, divider);
-}
-
-static int audio_divider_set_rate(struct clk_hw *hw,
-				  unsigned long rate,
-				  unsigned long parent_rate)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_audio_div_data *adiv = meson_clk_audio_div_data(clk);
-	int val = _get_val(parent_rate, rate);
-
-	meson_parm_write(clk->map, &adiv->div, val);
-
-	return 0;
-}
-
-const struct clk_ops meson_clk_audio_divider_ro_ops = {
-	.recalc_rate	= audio_divider_recalc_rate,
-	.round_rate	= audio_divider_round_rate,
-};
-
-const struct clk_ops meson_clk_audio_divider_ops = {
-	.recalc_rate	= audio_divider_recalc_rate,
-	.round_rate	= audio_divider_round_rate,
-	.set_rate	= audio_divider_set_rate,
-};
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 2fb084330ee9..48db02424f02 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -91,11 +91,6 @@ struct meson_clk_mpll_data {
 
 #define CLK_MESON_MPLL_ROUND_CLOSEST	BIT(0)
 
-struct meson_clk_audio_div_data {
-	struct parm div;
-	u8 flags;
-};
-
 #define MESON_GATE(_name, _reg, _bit)					\
 struct clk_regmap _name = {						\
 	.data = &(struct clk_regmap_gate_data){				\
@@ -117,7 +112,5 @@ extern const struct clk_ops meson_clk_pll_ops;
 extern const struct clk_ops meson_clk_cpu_ops;
 extern const struct clk_ops meson_clk_mpll_ro_ops;
 extern const struct clk_ops meson_clk_mpll_ops;
-extern const struct clk_ops meson_clk_audio_divider_ro_ops;
-extern const struct clk_ops meson_clk_audio_divider_ops;
 
 #endif /* __CLKC_H */
-- 
2.14.3

