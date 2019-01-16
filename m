Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0972EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA33B20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mj2BBHIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfAPRy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:54:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46347 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfAPRyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:54:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so7906345wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PO1Q8Fk8a+GCvLUwshwuMPTHTCeZhTO+WtQpOuaokSk=;
        b=mj2BBHIevH3MnA+YYJaxLgYvfjLiEs7xwvpS8eBy4Q+KIhW9K0kzZvgHmPlhB9kYql
         LIEN852pKEAwbqXkayZDdiv3SV172DJxOpCr+AQ879pDB92TbpdEm4DLSmOysjeQO5mV
         Et1QgmGkSKY1FA6sk6t7z6jvCNMxZz+bi4bavw8IwkLjqhtqaBnt6tMWX8ZGVRFQs6+b
         hHL16AGYTlM0jsb8g5YpxuFTYOyUEht9EyiWyY1kXhhgDFrD5d75dYteTpdNkFhYBIF2
         SdQGEeBZeBrZlZUrWYRFnAm9OunxOKtuEJRSaadTKivnF34mgMq2fnmQK92Z7OUks+HF
         D8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PO1Q8Fk8a+GCvLUwshwuMPTHTCeZhTO+WtQpOuaokSk=;
        b=FzCx69rCtOAc1pksqwcHXwX0DkYIF/Fplq0kCkPwbGgwp4wfm/hc2Ze8zvvPO5k8D/
         +OtWWjk4wmfPnMPbJHP+0cOsb4xLYNXCp9jEjg7N1lv67NBfBl4jBYBR8SgzkMpTfMbu
         KuLb1+pBRIb69kRBSRufQqHBQxROVkskl2sO+ysJMS1tMsK1QZVwc+XJGRm02ju5wYrG
         e3pn3B3bOgCsDC9EH3Olk68i6BePItEMpvKFzfKhfrkvL7YrOfjY1dGdx16DmO2dN8Z0
         wJs2Y97O9VInDQ1Ne1ebR3EUAoBnEzxBg7jfkNQ+DY8B2r6vBiASN0MdemtUob34Da6B
         BEWg==
X-Gm-Message-State: AJcUukfkSiIBcGBYIMpmALUML+C93o7Io/y/PJ73uY5KzPApqKNoESp9
        7S1M0klU0H1hix+S5BQzAZBTVw==
X-Google-Smtp-Source: ALg8bN4pSLxcAop3TLQnfJdwy8u6vXjFUxYUUwrvCvjCyTUjgqPxclTiE6oQvWK+dqgW+hT2jf3VJA==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr8888908wrn.264.1547661291733;
        Wed, 16 Jan 2019 09:54:51 -0800 (PST)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z9sm68703861wrs.63.2019.01.16.09.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 09:54:51 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 2/3] clk: meson: axg: claim clock controller input clock from DT
Date:   Wed, 16 Jan 2019 18:54:34 +0100
Message-Id: <20190116175435.4990-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116175435.4990-1-jbrunet@baylibre.com>
References: <20190116175435.4990-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on a fixed name for the xtal clock, claim the
controller input clock trough DT.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 792735d7e46e..1c6539eeee7c 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -20,6 +20,8 @@
 #include "clkc.h"
 #include "axg.h"
 
+#define IN_PREFIX "ee-in-"
+
 static DEFINE_SPINLOCK(meson_clk_lock);
 
 static struct clk_regmap axg_fixed_pll_dco = {
@@ -58,7 +60,7 @@ static struct clk_regmap axg_fixed_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -113,7 +115,7 @@ static struct clk_regmap axg_sys_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -214,7 +216,7 @@ static struct clk_regmap axg_gp0_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -283,7 +285,7 @@ static struct clk_regmap axg_hifi_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "hifi_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -701,7 +703,7 @@ static struct clk_regmap axg_pcie_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "pcie_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_names = (const char *[]){ "xtal" },
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
 		.num_parents = 1,
 	},
 };
@@ -803,7 +805,7 @@ static struct clk_regmap axg_pcie_cml_en1 = {
 
 static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
 static const char * const clk81_parent_names[] = {
-	"xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
+	IN_PREFIX "xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
 	"fclk_div3", "fclk_div5"
 };
 
@@ -852,7 +854,7 @@ static struct clk_regmap axg_clk81 = {
 };
 
 static const char * const axg_sd_emmc_clk0_parent_names[] = {
-	"xtal", "fclk_div2", "fclk_div3", "fclk_div5", "fclk_div7",
+	IN_PREFIX "xtal", "fclk_div2", "fclk_div3", "fclk_div5", "fclk_div7",
 
 	/*
 	 * Following these parent clocks, we should also have had mpll2, mpll3
@@ -957,7 +959,7 @@ static struct clk_regmap axg_sd_emmc_c_clk0 = {
 static u32 mux_table_gen_clk[]	= { 0, 4, 5, 6, 7, 8,
 				    9, 10, 11, 13, 14, };
 static const char * const gen_clk_parent_names[] = {
-	"xtal", "hifi_pll", "mpll0", "mpll1", "mpll2", "mpll3",
+	IN_PREFIX "xtal", "hifi_pll", "mpll0", "mpll1", "mpll2", "mpll3",
 	"fclk_div4", "fclk_div3", "fclk_div5", "fclk_div7", "gp0_pll",
 };
 
@@ -1263,6 +1265,7 @@ static const struct of_device_id clkc_match_table[] = {
 static int axg_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct clk_hw *input;
 	struct regmap *map;
 	int ret, i;
 
@@ -1273,6 +1276,14 @@ static int axg_clkc_probe(struct platform_device *pdev)
 		return PTR_ERR(map);
 	}
 
+	input = meson_clk_hw_register_input(dev, "xtal", IN_PREFIX "xtal", 0);
+	if (IS_ERR(input)) {
+		ret = PTR_ERR(input);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get input clock");
+		return ret;
+	}
+
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(axg_clk_regmaps); i++)
 		axg_clk_regmaps[i]->map = map;
-- 
2.20.1

