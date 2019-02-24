Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D4C00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E4D206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZSsWIdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfBXPcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:32:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43506 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfBXPcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:32:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id z20so5279878ljj.10;
        Sun, 24 Feb 2019 07:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n52uH9EqvJMEaRetRf+0j3XlFqHt7okOc8jjm051dQE=;
        b=RZSsWIdFwBM91gPA+FbbhUESHzmjPdJ6XRP0Pp+WPsG9NYvk0J5ulkr2PlzXu+90QS
         1sRL+BhL0b9V9Q1wb5GRLjYGC2XFdKNwOua6Bz6U77SkQCD+hjQ61CbfuGaWT1oxbQWF
         RMgaBVlfOINz9eVOyQCY22wTkQQ+5GmP/z5bj//cVzUITR/AAT+rQnfq2ume0YYApo23
         7pfUoSQkMOTmIxSNfKI4IOFVqeyPUZBNaQOicpppZYqJOcNZmejT5TyXLQcYOLpwTFzW
         szPIogeXLTzZYLJwgWnRtY1BTkxwdbCBFc4s70dKtGny5y5AEOCpFrG8cBnGHWa9bZBL
         okoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n52uH9EqvJMEaRetRf+0j3XlFqHt7okOc8jjm051dQE=;
        b=nprItNia3t4yBS6bzUwFB25HV8jIvQdCvcw2cuv7Me36Nr44zc1IBbUVXMa6KbvKNF
         hHHCC1BX0FqKF0KySz0dQPjxMBUylvzHRGmXEEtYazS+jT3US1wVlglH7D0fwnjWd6lx
         O501VQ+qGxamxI1r7qDbM/fCFR+TK2V/Yxf51rjt3lU3+tsoKqtQJ0qjVO9u63w0BlR9
         0Ejudel/v5TgmkV8JgnXs/TIoZ7kpYKeoiEl5h+1Upa1Ua9zBxTOEOJwFeqK1XjZt/2Y
         1RHtO+7ZpcPJ8uAruRzdcWvQ+eqLC4D1K1Te+yaxPp+lM3rNpz/yZwl9Y0WZv3HPkm1P
         JQAg==
X-Gm-Message-State: AHQUAuY/qBq6FrVYIfU3+BbxBBp9FWIzoWacUGVzDKrKXdbow4MaLuW/
        Ur/5FpwL2ATUPjcSSNIBgvY=
X-Google-Smtp-Source: AHgI3IaPRjDQ+DaGaDxKf6xCMVSMj0W/4lCcfItpfpTy1sqZ0UTAZTkfgVNNTGaFW7DsAm2+lcJ6rw==
X-Received: by 2002:a2e:b014:: with SMTP id y20mr7408444ljk.116.1551022371129;
        Sun, 24 Feb 2019 07:32:51 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id c86sm1910161ljf.28.2019.02.24.07.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 07:32:50 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RE-SEND] clk: tegra: Don't enable already enabled PLLs
Date:   Sun, 24 Feb 2019 18:32:22 +0300
Message-Id: <20190224153222.8142-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index b50b7460014b..ebc8481a2122 100644
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
 
@@ -940,11 +943,16 @@ static int clk_plle_training(struct tegra_clk_pll *pll)
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
 
@@ -1355,6 +1363,9 @@ static int clk_pllc_enable(struct clk_hw *hw)
 	int ret;
 	unsigned long flags = 0;
 
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
 	if (pll->lock)
 		spin_lock_irqsave(pll->lock, flags);
 
@@ -1567,7 +1578,12 @@ static int clk_plle_tegra114_enable(struct clk_hw *hw)
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
@@ -1704,6 +1720,9 @@ static int clk_pllu_tegra114_enable(struct clk_hw *hw)
 		return -EINVAL;
 	}
 
+	if (clk_pll_is_enabled(hw))
+		return 0;
+
 	input_rate = clk_hw_get_rate(__clk_get_hw(osc));
 
 	if (pll->lock)
@@ -2379,6 +2398,16 @@ struct clk *tegra_clk_register_pllre_tegra210(const char *name,
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
@@ -2386,7 +2415,12 @@ static int clk_plle_tegra210_enable(struct clk_hw *hw)
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
@@ -2497,16 +2531,6 @@ static void clk_plle_tegra210_disable(struct clk_hw *hw)
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
2.20.1

