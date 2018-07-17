Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37018ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FBF20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uFT9rVxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FBF20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeGQK2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:28:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52524 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbeGQK2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:28:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so840381wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o23cLAcmO3Ihf/F/pypL9i5YrE/HHx9Cqr04IO7qiW4=;
        b=uFT9rVxebI/fsZsf0YIrUPkP/1dY6xDD8GQvhT3gUflUVFckJQku1Fbm1qHg7f8wzy
         KCHDssPTdAUFwh4Q3JP0DWVZiHGBzxjoAh63gna3rl6r8IztzOcD0o0qDtxWMVdbZIyb
         RpzozcH2VqjCi3rV4ETtqVPm2SW0125qa+lgDcgtV4WZlh+gDBAX7nK1urM2ERhxThwN
         G42q6HaHF2iSJ2DouKkWhw9BLZHFg2jUl57Y5yq3EwNB1jycmsogxSdS2fw9+84btBPZ
         Oek2fUkGXfmC+pSfkaMo2Zyl4sLQ5RFsGnPEJ1okDODYfT9ywHWL9qG1R6pyxXESmEHm
         re1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o23cLAcmO3Ihf/F/pypL9i5YrE/HHx9Cqr04IO7qiW4=;
        b=kcYzDwNCSuMuY08qXRrmueG6RZVSeNwfmJIFaIWL+AdphgQSCYRKZhrAiJfu1qJO2a
         vdSB7D/OdQOZD5QIGnfr7taaAEMJJx1ApbCi4kI2kAZ9mj1hcGMZCP0fYnBO+31XA/ap
         Hf4F+CDf/JEQ3pLg4sOLsO2kCKhTu5xNFxjYfe6DjRbRnFU6HTZ7y7djTo1hL3h/PXIv
         c38nYmN5nYqDNCfB8mvTT8+2bqMJ0FD/PcGOHPYN0JV4XTOPCzXBrWE4MZcieWzxwPAA
         1lCSgejWR4zc0OFluLX/GdT1j03Lo0UcvPObAry8jXUB1q4pMmYJAqoPbzlLkcvOlEMD
         Zulw==
X-Gm-Message-State: AOUpUlGJLkcmQwKwomfPgwVBu4sR+ozve1+cdSZzQGj7LDo1Si6DI4jE
        ELRRFeNMJjyBuUinxYP9j+8A/w==
X-Google-Smtp-Source: AAOMgpchEyC6YRli6aVgA3XaRqmOKx0pfElVeUZ9AgyGa0GEpjK7kb/CkSILPeXtMzVU0N+QKdQ2VA==
X-Received: by 2002:a1c:c60a:: with SMTP id w10-v6mr890145wmf.26.1531821381955;
        Tue, 17 Jul 2018 02:56:21 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b10-v6sm1199249wrp.49.2018.07.17.02.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 02:56:21 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] clk: meson: clk-pll: add enable bit
Date:   Tue, 17 Jul 2018 11:56:15 +0200
Message-Id: <20180717095617.12240-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717095617.12240-1-jbrunet@baylibre.com>
References: <20180717095617.12240-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the enable the bit of the pll clocks.
These pll clocks may be disabled but we can't model this as an external
gate since the pll needs to lock when enabled.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     | 28 ++++++++++++++++++++++++---
 drivers/clk/meson/clk-pll.c | 47 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/clk/meson/clkc.h    |  1 +
 drivers/clk/meson/gxbb.c    | 32 ++++++++++++++++++++++++++++--
 drivers/clk/meson/meson8b.c | 15 +++++++++++++++
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
2.14.4

