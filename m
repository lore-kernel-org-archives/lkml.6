Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021B3C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9732175F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8dQ7fun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9732175F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeHRTRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:17:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39740 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeHRTRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:17:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so6128310edi.6;
        Sat, 18 Aug 2018 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eAXDA4L2XNCa7fRLWajNCHMLixTYEALdY6pJJQF87d8=;
        b=X8dQ7funMjSS+5pJ6C05cgqkQF29S3+M78LGH/9jYmgKE2+37nF9g2KgjImz8eaiCb
         Y46whSXWODaDHiKIDajwBwnFJlsAVKQ85zILUoUTjr1GvbvrIkFVks+I9T5LZVcY422u
         qpBBHVRUw2gXhcpEQH6JSS7iEB0wIId1DgN556STKhEV/ZVf1mlnxkAGV1RtuSWmn2V5
         O/cxO998w5HP8KM9TqVMeRrQxaLZfQhzEIgmpZrKezeqGeZsqU2o/PBgvReHahxibvif
         uygDTAGRWukn8wdzGU9loa7N7YQW9ls8FDR65ksWQsibUwktWhQ9grbkhFRoZ6uoKMdY
         t51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eAXDA4L2XNCa7fRLWajNCHMLixTYEALdY6pJJQF87d8=;
        b=UqdpDHYl1z/Vb+GBqekHdf4XLuEXp9QkmcXKJSOP/XtRHX1W0S5Sn67TzlYNCmhAkG
         T8wNNFXTaYlxdMF0InCmE+g1rtn4buyYq7IZTGDwkx3xLsBTUKYA9tths6GDRX2bYSTk
         MIJcIujpfKifygbEkgs4ClnOvBcsUEs3063+QClM8JwUvF/Y0y786WL+Uljf7VpUjPDc
         cH45i+9+YvztWtvMYmOvZBapmAquoGtRobkDl5CbYg7KCMV/0I2yp7UgxmkTa50dbHbO
         NA+me2aXzmzbBp6EnwUihuRscHKsHjt0s1KOt6pxXhJPPNIgHKXm4OTegJkRl21NcQUs
         86Sw==
X-Gm-Message-State: AOUpUlGjNWlLqhMzXjModUEAkCH5R4tId+mF1XhuziDBW4KJr6X3tKqj
        7bJul0OJcrm5QGyCwttgIN3LVI+V
X-Google-Smtp-Source: AA+uWPxE4BqAJ/W8Ue6drCiOmLslp+val+m76Maktr9pvAK2Vq49SfGZpUXhtaO4OqBZ+AmS6xoPVg==
X-Received: by 2002:aa7:d993:: with SMTP id u19-v6mr46029889eds.125.1534608545655;
        Sat, 18 Aug 2018 09:09:05 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j10-v6sm2751211eds.8.2018.08.18.09.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 09:09:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] clk: tegra: Don't enable already enabled PLLs
Date:   Sat, 18 Aug 2018 19:08:27 +0300
Message-Id: <20180818160828.8198-1-digetx@gmail.com>
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

