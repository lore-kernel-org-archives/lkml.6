Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC08C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D849320661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUDtkob9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D849320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeH3WqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:46:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37782 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeH3WqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:46:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so8013014lfb.4;
        Thu, 30 Aug 2018 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U7d9aO6dn5UyS3yhB9Ueq0CuQSS7ZBCmalaDKvVDuEU=;
        b=YUDtkob9YQAmcjZg3NmA8YSytziHDTWLgrzSPrRtufGFFgqT/gE6ZTKAu/N8+3As4n
         Xr7H2RpbYVcjKjjMt6zTfNpdHkXGQHMHZKVWdXUOa8v9xLskb/ez0emtK9fEwKPEgCDo
         4pleQGNjREleUXxTCrY+BrHsRBLpxciKFgTz+kQAIQIf0fyhmL0gH4ruJM7966fs5v50
         UGXnjNn8E6Mb0ToCe8BubU3rWPB1LMPwuhcZDK8zsnzadnMNBkCjJPCnLVHfMZESoi63
         miawomX39C0VIM9CCsUXQNVAekGX5Or/2C8IReWdekQlnXNxSicumL6lWUH+dtx0aOr2
         eT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U7d9aO6dn5UyS3yhB9Ueq0CuQSS7ZBCmalaDKvVDuEU=;
        b=uQ2NxlidW5ufVRwKYgeMdAqfT4hgBY/yRat9okGGMEQODPq5H077L68Gw6ESCFpca8
         Awz1vWRi8MQYBY/VjxxHcw4l3vL0wZwu+u3PwgCqd/EKNNMrEFkJ9VfHFaQgorbYFiu6
         wicc0gpbcpcFp+63PtNemTyHLN4A1gGEuFmrxDMNW9DKx1minuyQzET09UX7df5176sc
         fFlm9ihj6vyhG75JZow5Gf23svD5sJJVItfxaPuhkCG1WGw/7k3xE5VnlggmGWxKuXwP
         xdyQ15SecvU7BN5CMHHeesV1maG3o9xg93zyQqZDvEMVbrIScrl7PoH3tDKJ8CRocY+s
         GVDQ==
X-Gm-Message-State: APzg51AKBopxPsamUDNJBxz3N39xWY1zXMSVedCFfn0FvrO846sUFxa7
        sMzXxBrwS8sgXMlbuAcjfF0=
X-Google-Smtp-Source: ANB0VdZSkusFGHfmaD0NEDkjrGO6pd+NBUmoo8cL1q7MjYo62v1H3Y5AJMlzvfoRczlpKZLYXs6Stg==
X-Received: by 2002:a19:655d:: with SMTP id c29-v6mr1869708lfj.138.1535654568953;
        Thu, 30 Aug 2018 11:42:48 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id m31-v6sm1446169lfi.17.2018.08.30.11.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:42:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] clk: tegra: Don't enable already enabled PLLs
Date:   Thu, 30 Aug 2018 21:42:09 +0300
Message-Id: <20180830184210.5369-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially Common Clock Framework isn't aware of the clock-enable status,
this results in enabling of clocks that were enabled by bootloader. This
is not a big deal for a regular clock-gates, but for PLL's it may have
some unpleasant consequences. Thus re-enabling PLLX (the main CPU parent
clock) may result in extra long period of PLL re-locking.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2:	No change.

 drivers/clk/tegra/clk-pll.c | 50 +++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 830d1c87fa7c..ddb431247f08 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -444,6 +444,9 @@ static int clk_pll_enable(struct clk_hw *hw)
 	unsigned long flags = 0;
 	int ret;
 
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
 	if (pll->lock)
 		spin_lock_irqsave(pll->lock, flags);
 
@@ -939,11 +942,16 @@ static int clk_plle_training(struct tegra_clk_pll *pll)
 static int clk_plle_enable(struct clk_hw *hw)
 {
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
-	unsigned long input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
 	struct tegra_clk_pll_freq_table sel;
+	unsigned long input_rate;
 	u32 val;
 	int err;
 
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
+	input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
+
 	if (_get_table_rate(hw, &sel, pll->params->fixed_rate, input_rate))
 		return -EINVAL;
 
@@ -1354,6 +1362,9 @@ static int clk_pllc_enable(struct clk_hw *hw)
 	int ret;
 	unsigned long flags = 0;
 
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
 	if (pll->lock)
 		spin_lock_irqsave(pll->lock, flags);
 
@@ -1566,7 +1577,12 @@ static int clk_plle_tegra114_enable(struct clk_hw *hw)
 	u32 val;
 	int ret;
 	unsigned long flags = 0;
-	unsigned long input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
+	unsigned long input_rate;
+
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
+	input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
 
 	if (_get_table_rate(hw, &sel, pll->params->fixed_rate, input_rate))
 		return -EINVAL;
@@ -1703,6 +1719,9 @@ static int clk_pllu_tegra114_enable(struct clk_hw *hw)
 		return -EINVAL;
 	}
 
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
 	input_rate = clk_hw_get_rate(__clk_get_hw(osc));
 
 	if (pll->lock)
@@ -2378,6 +2397,16 @@ struct clk *tegra_clk_register_pllre_tegra210(const char *name,
 	return clk;
 }
 
+static int clk_plle_tegra210_is_enabled(struct clk_hw *hw)
+{
+	struct tegra_clk_pll *pll = to_clk_pll(hw);
+	u32 val;
+
+	val = pll_readl_base(pll);
+
+	return val & PLLE_BASE_ENABLE ? 1 : 0;
+}
+
 static int clk_plle_tegra210_enable(struct clk_hw *hw)
 {
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
@@ -2385,7 +2414,12 @@ static int clk_plle_tegra210_enable(struct clk_hw *hw)
 	u32 val;
 	int ret = 0;
 	unsigned long flags = 0;
-	unsigned long input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
+	unsigned long input_rate;
+
+	if (clk_plle_tegra210_is_enabled(hw))
+		return 0;
+
+	input_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
 
 	if (_get_table_rate(hw, &sel, pll->params->fixed_rate, input_rate))
 		return -EINVAL;
@@ -2496,16 +2530,6 @@ static void clk_plle_tegra210_disable(struct clk_hw *hw)
 		spin_unlock_irqrestore(pll->lock, flags);
 }
 
-static int clk_plle_tegra210_is_enabled(struct clk_hw *hw)
-{
-	struct tegra_clk_pll *pll = to_clk_pll(hw);
-	u32 val;
-
-	val = pll_readl_base(pll);
-
-	return val & PLLE_BASE_ENABLE ? 1 : 0;
-}
-
 static const struct clk_ops tegra_clk_plle_tegra210_ops = {
 	.is_enabled =  clk_plle_tegra210_is_enabled,
 	.enable = clk_plle_tegra210_enable,
-- 
2.18.0

