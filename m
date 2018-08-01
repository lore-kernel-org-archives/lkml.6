Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9A0C46462
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF6E20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KvuobtzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF6E20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbeHAPq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:46:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42860 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389266AbeHAPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:46:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so20224006wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 07:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nbH7QMBaE9B3OpD1bh82rT7pBCKLjHUwizKOh7ZXD+Y=;
        b=KvuobtzI9uZXvOJ25+dGDiDOym22GgMHn0U1JE8g68DLQaVSvta8ncp3URV2sDqPtW
         vawXX3hjf6XNATPU4LmM0Z9RlLavNn81AGqnw2mIjEQBp2qF1okGAePuk4x/zF8G5Vn5
         5k5GBcp2s+x0T8zcVFOF13kQDT78ss7gGT80PhGAhmv9mM0bSW7HSHzG844JDtvqZOFM
         lZ1zEqH2ZxKUIDV6Re8JLavvmNorwqj1NI1Y4x+RfuVf/OPRbEUf1XLfkbsa82dM4ORp
         ydnVkRZhAoGRzvgfSgwJmUtVs7tcfpZGCpwWJOYJd7/4RjUQdGQqVGH023/s3LqDAQd3
         AGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nbH7QMBaE9B3OpD1bh82rT7pBCKLjHUwizKOh7ZXD+Y=;
        b=hw0E9SsOfkvVk/96JjfnHxGAoSbJTBX/AxbCw4/v33YzUhz4FKZIeb0b+GwD3axYPW
         mJLjDgh4pgnmMffl/zb2JZUyto4yRpCAshF5tlgk+l3mPz7a5fA/uyjByvBQXIT1MT7d
         5xK5wP6zgNCPq4tUNC+Dmnoh2UVczuoPGXuKfW9Hi7kWpnMgjXXwFdjP9TPmnXsVhQnd
         TJPy2D9qLA3j1Jn71g7PqJC196KNOWxjc9o22wbggXi4b8bw6tgCCe/1fZk3CpvQBBT/
         6Zb12x0OvDVB5RqPMUys0Tt0oE5C/7n2WWPeuuU6hHnNwvJyY6OGn2gZ6weh7/maQilt
         xa5g==
X-Gm-Message-State: AOUpUlGemGoUh3Ma6njrqpN74cHyoDYfVW8DIjQqX7VezRP09BWrMXLP
        KL6sn1TixSpxRNGJiJ9MnWdgQw==
X-Google-Smtp-Source: AAOMgpd8F6XPNeFtmAhcTJC+eZ5OuVzpnKy9gj8xRHL0rdeGUrc2oJFGi3rmyYMmkAEFdNNuzw5M5Q==
X-Received: by 2002:adf:c684:: with SMTP id j4-v6mr24724074wrg.243.1533132061150;
        Wed, 01 Aug 2018 07:01:01 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d42-v6sm2816309wma.0.2018.08.01.07.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 07:01:00 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/4] clk: meson: clk-pll: add enable bit
Date:   Wed,  1 Aug 2018 16:00:50 +0200
Message-Id: <20180801140053.25899-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801140053.25899-1-jbrunet@baylibre.com>
References: <20180801140053.25899-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the enable the bit of the pll clocks.
These pll clocks may be disabled but we can't model this as an external
gate since the pll needs to lock when enabled.

Adding this bit allows to drop the poke of the first register of PLL.
This will be useful to model the different components of the pll using
generic clocks elements

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     | 28 +++++++++++++++++++---
 drivers/clk/meson/clk-pll.c | 47 +++++++++++++++++++++++++++++++++----
 drivers/clk/meson/clkc.h    |  1 +
 drivers/clk/meson/gxbb.c    | 32 +++++++++++++++++++++++--
 drivers/clk/meson/meson8b.c | 15 ++++++++++++
 5 files changed, 113 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 00ce62ad6416..6d8976554656 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -24,6 +24,11 @@ static DEFINE_SPINLOCK(meson_clk_lock);
 
 static struct clk_regmap axg_fixed_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_MPLL_CNTL,
 			.shift   = 0,
@@ -65,6 +70,11 @@ static struct clk_regmap axg_fixed_pll = {
 
 static struct clk_regmap axg_sys_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_SYS_PLL_CNTL,
 			.shift   = 0,
@@ -197,11 +207,15 @@ static const struct reg_sequence axg_gp0_init_regs[] = {
 	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a59a288 },
 	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0xc000004d },
 	{ .reg = HHI_GP0_PLL_CNTL5,	.def = 0x00078000 },
-	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x40010250 },
 };
 
 static struct clk_regmap axg_gp0_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_GP0_PLL_CNTL,
 			.shift   = 0,
@@ -250,11 +264,15 @@ static const struct reg_sequence axg_hifi_init_regs[] = {
 	{ .reg = HHI_HIFI_PLL_CNTL3,	.def = 0x0a6a3a88 },
 	{ .reg = HHI_HIFI_PLL_CNTL4,	.def = 0xc000004d },
 	{ .reg = HHI_HIFI_PLL_CNTL5,	.def = 0x00058000 },
-	{ .reg = HHI_HIFI_PLL_CNTL,	.def = 0x40010250 },
 };
 
 static struct clk_regmap axg_hifi_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_HIFI_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_HIFI_PLL_CNTL,
 			.shift   = 0,
@@ -637,7 +655,6 @@ static const struct pll_rate_table axg_pcie_pll_rate_table[] = {
 };
 
 static const struct reg_sequence axg_pcie_init_regs[] = {
-	{ .reg = HHI_PCIE_PLL_CNTL,	.def = 0x400106c8 },
 	{ .reg = HHI_PCIE_PLL_CNTL1,	.def = 0x0084a2aa },
 	{ .reg = HHI_PCIE_PLL_CNTL2,	.def = 0xb75020be },
 	{ .reg = HHI_PCIE_PLL_CNTL3,	.def = 0x0a47488e },
@@ -648,6 +665,11 @@ static const struct reg_sequence axg_pcie_init_regs[] = {
 
 static struct clk_regmap axg_pcie_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_PCIE_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_PCIE_PLL_CNTL,
 			.shift   = 0,
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 3e04617ac47f..8aaefe67025f 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -185,12 +185,45 @@ static void meson_clk_pll_init(struct clk_hw *hw)
 	}
 }
 
+static int meson_clk_pll_enable(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+
+	/* Make sure the pll is in reset */
+	meson_parm_write(clk->map, &pll->rst, 1);
+
+	/* Enable the pll */
+	meson_parm_write(clk->map, &pll->en, 1);
+
+	/* Take the pll out reset */
+	meson_parm_write(clk->map, &pll->rst, 0);
+
+	if (meson_clk_pll_wait_lock(hw))
+		return -EIO;
+
+	return 0;
+}
+
+static void meson_clk_pll_disable(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+
+	/* Put the pll is in reset */
+	meson_parm_write(clk->map, &pll->rst, 1);
+
+	/* Disable the pll */
+	meson_parm_write(clk->map, &pll->en, 0);
+}
+
 static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long parent_rate)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 	const struct pll_rate_table *pllt;
+	unsigned int enabled;
 	unsigned long old_rate;
 	u16 frac = 0;
 
@@ -203,8 +236,9 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!pllt)
 		return -EINVAL;
 
-	/* Put the pll in reset to write the params */
-	meson_parm_write(clk->map, &pll->rst, 1);
+	enabled = meson_parm_read(clk->map, &pll->en);
+	if (enabled)
+		meson_clk_pll_disable(hw);
 
 	meson_parm_write(clk->map, &pll->n, pllt->n);
 	meson_parm_write(clk->map, &pll->m, pllt->m);
@@ -221,10 +255,11 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 		meson_parm_write(clk->map, &pll->frac, frac);
 	}
 
-	/* make sure the reset is cleared at this point */
-	meson_parm_write(clk->map, &pll->rst, 0);
+	/* If the pll is stopped, bail out now */
+	if (!enabled)
+		return 0;
 
-	if (meson_clk_pll_wait_lock(hw)) {
+	if (meson_clk_pll_enable(hw)) {
 		pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
 			__func__, old_rate);
 		/*
@@ -244,6 +279,8 @@ const struct clk_ops meson_clk_pll_ops = {
 	.recalc_rate	= meson_clk_pll_recalc_rate,
 	.round_rate	= meson_clk_pll_round_rate,
 	.set_rate	= meson_clk_pll_set_rate,
+	.enable		= meson_clk_pll_enable,
+	.disable	= meson_clk_pll_disable
 };
 
 const struct clk_ops meson_clk_pll_ro_ops = {
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 24cec16b6038..c2ee37a78ceb 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -63,6 +63,7 @@ struct pll_rate_table {
 #define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
 
 struct meson_clk_pll_data {
+	struct parm en;
 	struct parm m;
 	struct parm n;
 	struct parm frac;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 86d3ae58e84c..5ed34566917c 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -177,6 +177,11 @@ static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
 
 static struct clk_regmap gxbb_fixed_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_MPLL_CNTL,
 			.shift   = 0,
@@ -230,6 +235,11 @@ static struct clk_fixed_factor gxbb_hdmi_pll_pre_mult = {
 
 static struct clk_regmap gxbb_hdmi_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_HDMI_PLL_CNTL,
 			.shift   = 0,
@@ -282,6 +292,11 @@ static struct clk_regmap gxbb_hdmi_pll = {
 
 static struct clk_regmap gxl_hdmi_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_HDMI_PLL_CNTL,
 			.shift   = 0,
@@ -340,6 +355,11 @@ static struct clk_regmap gxl_hdmi_pll = {
 
 static struct clk_regmap gxbb_sys_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_SYS_PLL_CNTL,
 			.shift   = 0,
@@ -379,11 +399,15 @@ static const struct reg_sequence gxbb_gp0_init_regs[] = {
 	{ .reg = HHI_GP0_PLL_CNTL2,	.def = 0x69c80000 },
 	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a5590c4 },
 	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0x0000500d },
-	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x4a000228 },
 };
 
 static struct clk_regmap gxbb_gp0_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_GP0_PLL_CNTL,
 			.shift   = 0,
@@ -428,11 +452,15 @@ static const struct reg_sequence gxl_gp0_init_regs[] = {
 	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a59a288 },
 	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0xc000004d },
 	{ .reg = HHI_GP0_PLL_CNTL5,	.def = 0x00078000 },
-	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x40010250 },
 };
 
 static struct clk_regmap gxl_gp0_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_GP0_PLL_CNTL,
 			.shift   = 0,
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 7447d96a265f..fd4c414893f5 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -96,6 +96,11 @@ static struct clk_fixed_rate meson8b_xtal = {
 
 static struct clk_regmap meson8b_fixed_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_MPLL_CNTL,
 			.shift   = 0,
@@ -138,6 +143,11 @@ static struct clk_regmap meson8b_fixed_pll = {
 
 static struct clk_regmap meson8b_vid_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_VID_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_VID_PLL_CNTL,
 			.shift   = 0,
@@ -175,6 +185,11 @@ static struct clk_regmap meson8b_vid_pll = {
 
 static struct clk_regmap meson8b_sys_pll = {
 	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
 		.m = {
 			.reg_off = HHI_SYS_PLL_CNTL,
 			.shift   = 0,
-- 
2.17.1

