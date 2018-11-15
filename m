Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780F6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369D02133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oQxAiuhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369D02133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389127AbeKPIvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:51:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39955 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeKPIvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:51:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so13735206wrt.7;
        Thu, 15 Nov 2018 14:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvGZTbDWv4lGUG5na7L9lqIQ6L4IllGuR7w0yW3E6tM=;
        b=oQxAiuhuTC19CmRlMCwooBbPO2w9P3XOaYYQh7Zz/A+hOni6DBJ/8AyWZlnofgQ2OH
         DifB9Z17WK1WhwNOreLQyDUZ4sPyQuGIzsDtxG1VUKg/Hbc0R6CO07h44gAmF59Z/65I
         zize5Nhz0jfXBnReE7dKkxYkGCnXQCr8PNYVDdjipAzsqGeOv5AnuM7IiE0/2+PHd3/C
         yXpRKQ7EpR+3e9yqmwYfyCff6JEzPtZU++cMnoqkTpWx3tUv0qXSaDEEaFwvtdLIolhr
         PxeX7WpZT7gbXdyGMW8PN8o3oKlPS3W8y4l1b0xmqkS4Ch3q2V2YEg/idBpWom+8Yhlm
         v18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvGZTbDWv4lGUG5na7L9lqIQ6L4IllGuR7w0yW3E6tM=;
        b=jP+o3BPW/5IGjivOji/2IYBkhwjFj8+PYzKRMBT9PDJ/Q2DdHhz3NPZ8/g15zuFIqt
         luDJWHC3XTkHOdWgTcv0aQXhg+oKU3gQY1+3AtZgLSIL5+8t43bDgEMjZw9AXVYGkp5n
         oZYRMecaxCGXa6Q7IJlWsvwtEpXXAfa/pbJZvlhkqw3JF+5B3XkVoFDTdUdKNYmU3PUU
         HdMMtjMbRGPDj8yeJUh3Vv3GGCljFv5yGtG30nn+QNo5c7JEMNFTyi928wSqMiXCfD9G
         UqgWcvcZwwrZhMCKoD4pNP9VhT/c+nJhAObvN6LgPCV/hIYG4ITbaF/U+fn/pZnlZnh/
         9dkQ==
X-Gm-Message-State: AA+aEWZvvr1KInWt8gicfoVydX3iZZb+jrTVyFiQqdgIQ8qf6eOF+aNQ
        g0tQs3XOU2QjmNFQg/7tEJs=
X-Google-Smtp-Source: AFSGD/XNFfL2ZMvD06MV6no/EWJzMZwwmDO+jWIos7isur5U5l3sgy1sEnxUzws07S16dDsNLCPnrQ==
X-Received: by 2002:a5d:4c42:: with SMTP id n2-v6mr1698860wrt.298.1542321682553;
        Thu, 15 Nov 2018 14:41:22 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100B85ACE585A885C51.dip0.t-ipconnect.de. [2003:dc:d717:a100:b85a:ce58:5a88:5c51])
        by smtp.googlemail.com with ESMTPSA id x12sm2076388wmc.37.2018.11.15.14.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:41:21 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 6/6] clk: meson: meson8b: allow changing the CPU clock tree
Date:   Thu, 15 Nov 2018 23:40:48 +0100
Message-Id: <20181115224048.13511-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
References: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all clocks in the CPU clock tree are marked as read-only
(using the corresponding _ro_ clk_ops). This was correct since changing
the clock tree could cause the system to lock up.
Switch all clocks to their corresponding clk_ops variant which is not
read-only to allow changing the CPU clock tree since the bug which
locked up the system is now fixed (by switching the CPU clock temporary
to run off XTAL while changing the CPU clock tree).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index c06a1a7faa4c..b3bdc7e05441 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -203,7 +203,7 @@ static struct clk_regmap meson8b_sys_pll_dco = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll_dco",
-		.ops = &meson_clk_pll_ro_ops,
+		.ops = &meson_clk_pll_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
 	},
@@ -218,7 +218,7 @@ static struct clk_regmap meson8b_sys_pll = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "sys_pll_dco" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -552,7 +552,7 @@ static struct clk_regmap meson8b_cpu_in_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_in_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = (const char *[]){ "xtal", "sys_pll" },
 		.num_parents = 2,
 		.flags = (CLK_SET_RATE_PARENT |
@@ -606,7 +606,7 @@ static struct clk_regmap meson8b_cpu_scale_div = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_scale_div",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "cpu_in_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -623,7 +623,7 @@ static struct clk_regmap meson8b_cpu_scale_out_sel = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_scale_out_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		/*
 		 * NOTE: We are skipping the parent with value 0x2 (which is
 		 * "cpu_div3") because it results in a duty cycle of 33% which
@@ -646,7 +646,7 @@ static struct clk_regmap meson8b_cpu_clk = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = (const char *[]){ "xtal",
 						  "cpu_scale_out_sel" },
 		.num_parents = 2,
-- 
2.19.1

