Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62E1C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6814320869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g7bwnkA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6814320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389152AbeKGAXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:23:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35806 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389083AbeKGAXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:23:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15-v6so4405725wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WdsKp23CllM9veBjszWTXniXba0VFbe0yGyTUHpLHY4=;
        b=g7bwnkA+ibMFRAjyhWL47EInvX9xHpr/DnKwyW0Mal5Yuo1bydvSZrgfVDIbaZhaAn
         T5D1AXdyv+swEw1ooV7Ckmdngsgck+jtNV88vJsSeG23hfF7rOFLf27DEBdo29QU2huv
         34+1R7hp6hXvF7ReBfpQsb6tbIkNWd7/lu5uazIPLCT4tiDJpYfkBmQEqCByu/d1OuMW
         gN8yP3ki+P8xnik8AxzaALRi0zxNE+wYXfrQ4CGrZLazB0ElCqe1oFdt901kirh0zWOO
         wLhWB/1AQfcJUsrlYKbGyMpMw9wDNoSIKDil1Oy42eCzLlS7YDQccygpEgjvIxQ8Vm9b
         c8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WdsKp23CllM9veBjszWTXniXba0VFbe0yGyTUHpLHY4=;
        b=AVy93mP2/PwrYgwNMP54lsjncxdOyMdWV/cwl7bfM0IbYQtQ1zikzxOAekkNR+jhb4
         SDQhR8g//XN4i8JHD1OVfGghy6e0MONdJO/4mf7thYYnAd8CpaGqal/D5M4Eyz1GrnFP
         D6LEwh0mPdKRN1ptTJncWeEys1QEEh+wOmYnDURRuQr5FSJffazmfBP+FFbL/xhElPhf
         BxaCvOV9OtLRvv45LIYJSaGoGa7eZO9lleXGd/NPmRUWbQdQjtdz0RqafPRmK+3QCR3N
         gdY4vgkuBnR/J3Mf8ukCR3t220Hui2mvkzRcsAoi+YZj3UVJqj6yQKYSz1xaMDvHf37t
         XWDg==
X-Gm-Message-State: AGRZ1gJ5eVjmK/Ap8TqYlax6e5Rz/WSrUTIRjtSU1y2cv4x1GxGklfrL
        01+VLqmloVVXS5Hz+GgOyfp49w==
X-Google-Smtp-Source: AJdET5dSOn6UR6O/yHvjO7TxOxYaf0em+C13M9ZqNYJsjp6zrbEZK9b64rhG0S5O4cVI+f52feQp1w==
X-Received: by 2002:a1c:6382:: with SMTP id x124-v6mr2383001wmb.145.1541516264733;
        Tue, 06 Nov 2018 06:57:44 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y131-v6sm1825375wmc.16.2018.11.06.06.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 06:57:44 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] clk: meson-gxbb: Add video clocks
Date:   Tue,  6 Nov 2018 15:57:37 +0100
Message-Id: <1541516257-16157-5-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clocks entries used in the video clock path, the clock path
is doubled to permit having different synchronized clocks for different
parts of the video pipeline.

All dividers are flagged with CLK_GET_RATE_NOCACHE, and all gates are flagged
with CLK_IGNORE_UNUSED since they are currently directly handled by the
Meson DRM Driver.
Once the DRM Driver is fully migrated to using the Common Clock Framework
to handle the video clock tree, the CLK_GET_RATE_NOCACHE and CLK_IGNORE_UNUSED
will be dropped.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 722 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 722 insertions(+)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 0fd354b..30fbf8f 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1558,6 +1558,616 @@ static struct clk_regmap gxbb_vapb = {
 	},
 };
 
+/* Video Clocks */
+
+static struct clk_regmap gxbb_vid_pll_div = {
+	.data = &(struct meson_vid_pll_div_data){
+		.val = {
+			.reg_off = HHI_VID_PLL_CLK_DIV,
+			.shift   = 0,
+			.width   = 15,
+		},
+		.sel = {
+			.reg_off = HHI_VID_PLL_CLK_DIV,
+			.shift   = 16,
+			.width   = 2,
+		},
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vid_pll_div",
+		.ops = &meson_vid_pll_div_ro_ops,
+		.parent_names = (const char *[]){ "hdmi_pll" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+const char *gxbb_vid_pll_parent_names[] = { "vid_pll_div", "hdmi_pll" };
+
+static struct clk_regmap gxbb_vid_pll_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VID_PLL_CLK_DIV,
+		.mask = 0x1,
+		.shift = 18,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vid_pll_sel",
+		.ops = &clk_regmap_mux_ops,
+		/*
+		 * bit 18 selects from 2 possible parents:
+		 * vid_pll_div or hdmi_pll
+		 */
+		.parent_names = gxbb_vid_pll_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_vid_pll_parent_names),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap gxbb_vid_pll = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_PLL_CLK_DIV,
+		.bit_idx = 19,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vid_pll",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vid_pll_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+const char *gxbb_vclk_parent_names[] = {
+	"vid_pll", "fclk_div4", "fclk_div3", "fclk_div5", "vid_pll",
+	"fclk_div7", "mpll1",
+};
+
+static struct clk_regmap gxbb_vclk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VID_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_sel",
+		.ops = &clk_regmap_mux_ops,
+		/*
+		 * bits 16:18 selects from 8 possible parents:
+		 * vid_pll, fclk_div4, fclk_div3, fclk_div5,
+		 * vid_pll, fclk_div7, mp1
+		 */
+		.parent_names = gxbb_vclk_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_vclk_parent_names),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap gxbb_vclk2_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VIID_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_sel",
+		.ops = &clk_regmap_mux_ops,
+		/*
+		 * bits 16:18 selects from 8 possible parents:
+		 * vid_pll, fclk_div4, fclk_div3, fclk_div5,
+		 * vid_pll, fclk_div7, mp1
+		 */
+		.parent_names = gxbb_vclk_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_vclk_parent_names),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap gxbb_vclk_input = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_DIV,
+		.bit_idx = 16,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_input",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk2_input = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.bit_idx = 16,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_input",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk2_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VID_CLK_DIV,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vclk_input" },
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap gxbb_vclk2_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vclk2_input" },
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap gxbb_vclk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL,
+		.bit_idx = 19,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_CNTL,
+		.bit_idx = 19,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk2_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk_div1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_div1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk_div2_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_div2_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk_div4_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL,
+		.bit_idx = 2,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_div4_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk_div6_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL,
+		.bit_idx = 3,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_div6_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk_div12_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL,
+		.bit_idx = 4,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_div12_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk2_div1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_CNTL,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_div1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk2" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk2_div2_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_CNTL,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_div2_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk2" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk2_div4_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_CNTL,
+		.bit_idx = 2,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_div4_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk2" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk2_div6_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_CNTL,
+		.bit_idx = 3,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_div6_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk2" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_vclk2_div12_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VIID_CLK_CNTL,
+		.bit_idx = 4,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_div12_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vclk2" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_fixed_factor gxbb_vclk_div2 = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div2",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk_div2_en" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor gxbb_vclk_div4 = {
+	.mult = 1,
+	.div = 4,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div4",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk_div4_en" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor gxbb_vclk_div6 = {
+	.mult = 1,
+	.div = 6,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div6",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk_div6_en" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor gxbb_vclk_div12 = {
+	.mult = 1,
+	.div = 12,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div12",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk_div12_en" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor gxbb_vclk2_div2 = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div2",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk2_div2_en" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor gxbb_vclk2_div4 = {
+	.mult = 1,
+	.div = 4,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div4",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk2_div4_en" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor gxbb_vclk2_div6 = {
+	.mult = 1,
+	.div = 6,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div6",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk2_div6_en" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor gxbb_vclk2_div12 = {
+	.mult = 1,
+	.div = 12,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div12",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "vclk2_div12_en" },
+		.num_parents = 1,
+	},
+};
+
+static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
+const char *gxbb_cts_parent_names[] = {
+	"vclk_div1", "vclk_div2", "vclk_div4", "vclk_div6",
+	"vclk_div12", "vclk2_div1", "vclk2_div2", "vclk2_div4",
+	"vclk2_div6", "vclk2_div12"
+};
+
+static struct clk_regmap gxbb_cts_enci_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 28,
+		.table = mux_table_cts_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_enci_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = gxbb_cts_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap gxbb_cts_encp_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 20,
+		.table = mux_table_cts_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_encp_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = gxbb_cts_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap gxbb_cts_vdac_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VIID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 28,
+		.table = mux_table_cts_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_vdac_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = gxbb_cts_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+/* TOFIX: add support for cts_tcon */
+static u32 mux_table_hdmi_tx_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
+const char *gxbb_cts_hdmi_tx_parent_names[] = {
+	"vclk_div1", "vclk_div2", "vclk_div4", "vclk_div6",
+	"vclk_div12", "vclk2_div1", "vclk2_div2", "vclk2_div4",
+	"vclk2_div6", "vclk2_div12"
+};
+
+static struct clk_regmap gxbb_hdmi_tx_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_HDMI_CLK_CNTL,
+		.mask = 0xf,
+		.shift = 16,
+		.table = mux_table_hdmi_tx_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_tx_sel",
+		.ops = &clk_regmap_mux_ops,
+		/*
+		 * bits 31:28 selects from 12 possible parents:
+		 * vclk_div1, vclk_div2, vclk_div4, vclk_div6, vclk_div12
+		 * vclk2_div1, vclk2_div2, vclk2_div4, vclk2_div6, vclk2_div12,
+		 * cts_tcon
+		 */
+		.parent_names = gxbb_cts_hdmi_tx_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_cts_hdmi_tx_parent_names),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap gxbb_cts_enci = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL2,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cts_enci",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cts_enci_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_cts_encp = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL2,
+		.bit_idx = 2,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cts_encp",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cts_encp_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_cts_vdac = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL2,
+		.bit_idx = 4,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cts_vdac",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cts_vdac_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap gxbb_hdmi_tx = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_CLK_CNTL2,
+		.bit_idx = 5,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hdmi_tx",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "hdmi_tx_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+/* HDMI Clocks */
+
+static const char * const gxbb_hdmi_parent_names[] = {
+	"xtal", "fclk_div4", "fclk_div3", "fclk_div5"
+};
+
+static struct clk_regmap gxbb_hdmi_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_HDMI_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = gxbb_hdmi_parent_names,
+		.num_parents = ARRAY_SIZE(gxbb_hdmi_parent_names),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap gxbb_hdmi_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_HDMI_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "hdmi_sel" },
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap gxbb_hdmi = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_HDMI_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hdmi",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "hdmi_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
 /* VDEC clocks */
 
 static const char * const gxbb_vdec_parent_names[] = {
@@ -1969,6 +2579,46 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
 		[CLKID_HDMI_PLL_OD2]	    = &gxbb_hdmi_pll_od2.hw,
 		[CLKID_SYS_PLL_DCO]	    = &gxbb_sys_pll_dco.hw,
 		[CLKID_GP0_PLL_DCO]	    = &gxbb_gp0_pll_dco.hw,
+		[CLKID_VID_PLL_DIV]	    = &gxbb_vid_pll_div.hw,
+		[CLKID_VID_PLL_SEL]	    = &gxbb_vid_pll_sel.hw,
+		[CLKID_VID_PLL]		    = &gxbb_vid_pll.hw,
+		[CLKID_VCLK_SEL]	    = &gxbb_vclk_sel.hw,
+		[CLKID_VCLK2_SEL]	    = &gxbb_vclk2_sel.hw,
+		[CLKID_VCLK_INPUT]	    = &gxbb_vclk_input.hw,
+		[CLKID_VCLK2_INPUT]	    = &gxbb_vclk2_input.hw,
+		[CLKID_VCLK_DIV]	    = &gxbb_vclk_div.hw,
+		[CLKID_VCLK2_DIV]	    = &gxbb_vclk2_div.hw,
+		[CLKID_VCLK]		    = &gxbb_vclk.hw,
+		[CLKID_VCLK2]		    = &gxbb_vclk2.hw,
+		[CLKID_VCLK_DIV1]	    = &gxbb_vclk_div1.hw,
+		[CLKID_VCLK_DIV2_EN]	    = &gxbb_vclk_div2_en.hw,
+		[CLKID_VCLK_DIV2]	    = &gxbb_vclk_div2.hw,
+		[CLKID_VCLK_DIV4_EN]	    = &gxbb_vclk_div4_en.hw,
+		[CLKID_VCLK_DIV4]	    = &gxbb_vclk_div4.hw,
+		[CLKID_VCLK_DIV6_EN]	    = &gxbb_vclk_div6_en.hw,
+		[CLKID_VCLK_DIV6]	    = &gxbb_vclk_div6.hw,
+		[CLKID_VCLK_DIV12_EN]	    = &gxbb_vclk_div12_en.hw,
+		[CLKID_VCLK_DIV12]	    = &gxbb_vclk_div12.hw,
+		[CLKID_VCLK2_DIV1]	    = &gxbb_vclk2_div1.hw,
+		[CLKID_VCLK2_DIV2_EN]	    = &gxbb_vclk2_div2_en.hw,
+		[CLKID_VCLK2_DIV2]	    = &gxbb_vclk2_div2.hw,
+		[CLKID_VCLK2_DIV4_EN]	    = &gxbb_vclk2_div4_en.hw,
+		[CLKID_VCLK2_DIV4]	    = &gxbb_vclk2_div4.hw,
+		[CLKID_VCLK2_DIV6_EN]	    = &gxbb_vclk2_div6_en.hw,
+		[CLKID_VCLK2_DIV6]	    = &gxbb_vclk2_div6.hw,
+		[CLKID_VCLK2_DIV12_EN]	    = &gxbb_vclk2_div12_en.hw,
+		[CLKID_VCLK2_DIV12]	    = &gxbb_vclk2_div12.hw,
+		[CLKID_CTS_ENCI_SEL]	    = &gxbb_cts_enci_sel.hw,
+		[CLKID_CTS_ENCP_SEL]	    = &gxbb_cts_encp_sel.hw,
+		[CLKID_CTS_VDAC_SEL]	    = &gxbb_cts_vdac_sel.hw,
+		[CLKID_HDMI_TX_SEL]	    = &gxbb_hdmi_tx_sel.hw,
+		[CLKID_CTS_ENCI]	    = &gxbb_cts_enci.hw,
+		[CLKID_CTS_ENCP]	    = &gxbb_cts_encp.hw,
+		[CLKID_CTS_VDAC]	    = &gxbb_cts_vdac.hw,
+		[CLKID_HDMI_TX]		    = &gxbb_hdmi_tx.hw,
+		[CLKID_HDMI_SEL]	    = &gxbb_hdmi_sel.hw,
+		[CLKID_HDMI_DIV]	    = &gxbb_hdmi_div.hw,
+		[CLKID_HDMI]		    = &gxbb_hdmi.hw,
 		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
@@ -2140,6 +2790,46 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_HDMI_PLL_OD2]	    = &gxl_hdmi_pll_od2.hw,
 		[CLKID_SYS_PLL_DCO]	    = &gxbb_sys_pll_dco.hw,
 		[CLKID_GP0_PLL_DCO]	    = &gxl_gp0_pll_dco.hw,
+		[CLKID_VID_PLL_DIV]	    = &gxbb_vid_pll_div.hw,
+		[CLKID_VID_PLL_SEL]	    = &gxbb_vid_pll_sel.hw,
+		[CLKID_VID_PLL]		    = &gxbb_vid_pll.hw,
+		[CLKID_VCLK_SEL]	    = &gxbb_vclk_sel.hw,
+		[CLKID_VCLK2_SEL]	    = &gxbb_vclk2_sel.hw,
+		[CLKID_VCLK_INPUT]	    = &gxbb_vclk_input.hw,
+		[CLKID_VCLK2_INPUT]	    = &gxbb_vclk2_input.hw,
+		[CLKID_VCLK_DIV]	    = &gxbb_vclk_div.hw,
+		[CLKID_VCLK2_DIV]	    = &gxbb_vclk2_div.hw,
+		[CLKID_VCLK]		    = &gxbb_vclk.hw,
+		[CLKID_VCLK2]		    = &gxbb_vclk2.hw,
+		[CLKID_VCLK_DIV1]	    = &gxbb_vclk_div1.hw,
+		[CLKID_VCLK_DIV2_EN]	    = &gxbb_vclk_div2_en.hw,
+		[CLKID_VCLK_DIV2]	    = &gxbb_vclk_div2.hw,
+		[CLKID_VCLK_DIV4_EN]	    = &gxbb_vclk_div4_en.hw,
+		[CLKID_VCLK_DIV4]	    = &gxbb_vclk_div4.hw,
+		[CLKID_VCLK_DIV6_EN]	    = &gxbb_vclk_div6_en.hw,
+		[CLKID_VCLK_DIV6]	    = &gxbb_vclk_div6.hw,
+		[CLKID_VCLK_DIV12_EN]	    = &gxbb_vclk_div12_en.hw,
+		[CLKID_VCLK_DIV12]	    = &gxbb_vclk_div12.hw,
+		[CLKID_VCLK2_DIV1]	    = &gxbb_vclk2_div1.hw,
+		[CLKID_VCLK2_DIV2_EN]	    = &gxbb_vclk2_div2_en.hw,
+		[CLKID_VCLK2_DIV2]	    = &gxbb_vclk2_div2.hw,
+		[CLKID_VCLK2_DIV4_EN]	    = &gxbb_vclk2_div4_en.hw,
+		[CLKID_VCLK2_DIV4]	    = &gxbb_vclk2_div4.hw,
+		[CLKID_VCLK2_DIV6_EN]	    = &gxbb_vclk2_div6_en.hw,
+		[CLKID_VCLK2_DIV6]	    = &gxbb_vclk2_div6.hw,
+		[CLKID_VCLK2_DIV12_EN]	    = &gxbb_vclk2_div12_en.hw,
+		[CLKID_VCLK2_DIV12]	    = &gxbb_vclk2_div12.hw,
+		[CLKID_CTS_ENCI_SEL]	    = &gxbb_cts_enci_sel.hw,
+		[CLKID_CTS_ENCP_SEL]	    = &gxbb_cts_encp_sel.hw,
+		[CLKID_CTS_VDAC_SEL]	    = &gxbb_cts_vdac_sel.hw,
+		[CLKID_HDMI_TX_SEL]	    = &gxbb_hdmi_tx_sel.hw,
+		[CLKID_CTS_ENCI]	    = &gxbb_cts_enci.hw,
+		[CLKID_CTS_ENCP]	    = &gxbb_cts_encp.hw,
+		[CLKID_CTS_VDAC]	    = &gxbb_cts_vdac.hw,
+		[CLKID_HDMI_TX]		    = &gxbb_hdmi_tx.hw,
+		[CLKID_HDMI_SEL]	    = &gxbb_hdmi_sel.hw,
+		[CLKID_HDMI_DIV]	    = &gxbb_hdmi_div.hw,
+		[CLKID_HDMI]		    = &gxbb_hdmi.hw,
 		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
@@ -2316,6 +3006,38 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_fixed_pll_dco,
 	&gxbb_sys_pll_dco,
 	&gxbb_gp0_pll,
+	&gxbb_vid_pll,
+	&gxbb_vid_pll_sel,
+	&gxbb_vid_pll_div,
+	&gxbb_vclk,
+	&gxbb_vclk_sel,
+	&gxbb_vclk_div,
+	&gxbb_vclk_input,
+	&gxbb_vclk_div1,
+	&gxbb_vclk_div2_en,
+	&gxbb_vclk_div4_en,
+	&gxbb_vclk_div6_en,
+	&gxbb_vclk_div12_en,
+	&gxbb_vclk2,
+	&gxbb_vclk2_sel,
+	&gxbb_vclk2_div,
+	&gxbb_vclk2_input,
+	&gxbb_vclk2_div1,
+	&gxbb_vclk2_div2_en,
+	&gxbb_vclk2_div4_en,
+	&gxbb_vclk2_div6_en,
+	&gxbb_vclk2_div12_en,
+	&gxbb_cts_enci,
+	&gxbb_cts_enci_sel,
+	&gxbb_cts_encp,
+	&gxbb_cts_encp_sel,
+	&gxbb_cts_vdac,
+	&gxbb_cts_vdac_sel,
+	&gxbb_hdmi_tx,
+	&gxbb_hdmi_tx_sel,
+	&gxbb_hdmi_sel,
+	&gxbb_hdmi_div,
+	&gxbb_hdmi,
 };
 
 struct clkc_data {
-- 
2.7.4

