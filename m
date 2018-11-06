Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1508DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D4220685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Xn01n/gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D4220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389140AbeKGAXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:23:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35803 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388851AbeKGAXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:23:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15-v6so4405514wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=egmGYpAgTbHSpOTm02WOveYiiWODWwGKRSLoXnPf65M=;
        b=Xn01n/gqLasPNJCE8sDuqGymux87hCPUphuthmmEtKnIxlGkkX2dkGwHt7LcM5lTtS
         A1Ie7csB7BWNmTSrK+uaVZRi2BUENVGlq71uB3HPRS8Df6aE5RPYYuLHTl2kMfgFPYlK
         ku5SD7Ic6fUc9o/wKdvdAtREE5h+KAeRmxlYY55w4R80UNiV/4i0C8T8hSWGUWqatiyW
         xqrf6KwkS3JovMLKJtmz3VJ6cFV5oP+lJH9aWb8Kg/rMd8d6lIQug50iNFSqRMV3usMF
         KF+mZ76N3T2XtC70QNdbUcpNNVgoehNAvDfIT0kNZ61xF22CfQK1fq2AA3h/DXyWYlgV
         MOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=egmGYpAgTbHSpOTm02WOveYiiWODWwGKRSLoXnPf65M=;
        b=Owg0PVO2EIZXvvU5oiG9797UqINyiJ8fo1Mq5A6ZI/5PqSYO1TC6fVHPtX9N5N6yDm
         OjPrOkY3x5MrGDXcPIx1gtNlSkanf2ES8+eYCmTuvCiG3P8jfw4QWACO2uToklC4lEBx
         SsSMwNjaRslgtjxTv9wSOV2cr0P1coG0cz5bUDkuqgz4hBUn5jlUdYXmbcLXXo/rK4nx
         ngweFaUAeZrhel7o7zRJsHCfLolDC8zK5GZVGpvMubNtyNPyVcYBRvGvPsy2h5TuoFl1
         jhvNGiyFII1Kyz3IdqcDwsgUg+j0Wgkua8Fl+OsKkmG2w1XTzfqrZDimvRTssCQfNgll
         6EiA==
X-Gm-Message-State: AGRZ1gII5Qz99gxbkRyktkX0X5kcnNkc+5YZfnJYOZeKMhG+fTj7gdwt
        pujgZlmj33QDwO7bSlzezQIjMEHOJuo=
X-Google-Smtp-Source: AJdET5dbl7HRlDi8T51ljxKxvjtpRMPlk3MOTkmaakcSucAdvfn8xBtjZ79u04Fgd/M3UOApCLuXuw==
X-Received: by 2002:a1c:880e:: with SMTP id k14-v6mr2357830wmd.88.1541516261808;
        Tue, 06 Nov 2018 06:57:41 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y131-v6sm1825375wmc.16.2018.11.06.06.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 06:57:41 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] clk: meson-gxbb: Fix HDMI PLL for GXL SoCs
Date:   Tue,  6 Nov 2018 15:57:35 +0100
Message-Id: <1541516257-16157-3-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an attempt to better describe the HDMI PLL, a single DCO clock was
left for GXBB and GXL, but the GXL DCO does not have a pre-multiplier.

This patch adds back a GXL specific HDMI PLL DCO with xtal as parent.

Fixes: 87173557d2f6 ("clk: meson: clk-pll: remove od parameters")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 9309cfa..0fd354b 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -199,6 +199,52 @@ static struct clk_regmap gxbb_hdmi_pll_dco = {
 	},
 };
 
+static struct clk_regmap gxl_hdmi_pll_dco = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = HHI_HDMI_PLL_CNTL2,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.l = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 28,
+			.width   = 1,
+		},
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_pll_dco",
+		.ops = &meson_clk_pll_ro_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+		/*
+		 * Display directly handle hdmi pll registers ATM, we need
+		 * NOCACHE to keep our view of the clock as accurate as possible
+		 */
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
 static struct clk_regmap gxbb_hdmi_pll_od = {
 	.data = &(struct clk_regmap_div_data){
 		.offset = HHI_HDMI_PLL_CNTL2,
@@ -2089,7 +2135,7 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_GEN_CLK_DIV]	    = &gxbb_gen_clk_div.hw,
 		[CLKID_GEN_CLK]		    = &gxbb_gen_clk.hw,
 		[CLKID_FIXED_PLL_DCO]	    = &gxbb_fixed_pll_dco.hw,
-		[CLKID_HDMI_PLL_DCO]	    = &gxbb_hdmi_pll_dco.hw,
+		[CLKID_HDMI_PLL_DCO]	    = &gxl_hdmi_pll_dco.hw,
 		[CLKID_HDMI_PLL_OD]	    = &gxl_hdmi_pll_od.hw,
 		[CLKID_HDMI_PLL_OD2]	    = &gxl_hdmi_pll_od2.hw,
 		[CLKID_SYS_PLL_DCO]	    = &gxbb_sys_pll_dco.hw,
@@ -2104,6 +2150,7 @@ static struct clk_regmap *const gxbb_clk_regmaps[] = {
 	&gxbb_hdmi_pll,
 	&gxbb_hdmi_pll_od,
 	&gxbb_hdmi_pll_od2,
+	&gxbb_hdmi_pll_dco,
 };
 
 static struct clk_regmap *const gxl_clk_regmaps[] = {
@@ -2111,6 +2158,7 @@ static struct clk_regmap *const gxl_clk_regmaps[] = {
 	&gxl_hdmi_pll,
 	&gxl_hdmi_pll_od,
 	&gxl_hdmi_pll_od2,
+	&gxl_hdmi_pll_dco,
 };
 
 static struct clk_regmap *const gx_clk_regmaps[] = {
@@ -2266,7 +2314,6 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_gen_clk_div,
 	&gxbb_gen_clk,
 	&gxbb_fixed_pll_dco,
-	&gxbb_hdmi_pll_dco,
 	&gxbb_sys_pll_dco,
 	&gxbb_gp0_pll,
 };
-- 
2.7.4

