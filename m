Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC2CC04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDDF20818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="W7Eqpwou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDDF20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407550AbeKWIVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:21:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38652 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407522AbeKWIVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:21:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id k198so10360525wmd.3;
        Thu, 22 Nov 2018 13:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DownjwjeOEnZH3e88ykBjvED3HOTGAzn5RoqAbXS+qA=;
        b=W7EqpwoufhiW52oKaFV8zmAwVwCbly9g/Kp0fQuBw37Y22K2iuhtdmrSgzgmePsj+n
         YQMkolFBaaWTXAxe/3t0sh/eT9PRFQ5Wa92rtrI4ND52Dzo2SLwci7dRdcXsjCo9ZkfA
         2PdzqP1kMGWVksabKMqNh+IgHRiTWWOQG/CFo3lwOZdiHz6cTdS0WQcB3hhoeWUZkX82
         MzTOCLeIiZII4wROHaCpUhfowuZcN6bl3NiKFUoQk3XkWuva5322cbGp7+IMlfJ5JSN6
         Fo7cIr31tqeOvAEtoLslB9kc0+f32CwvaYKSqeLKUHXyj9HYzyVRdxQdWunsAyvSnCwn
         zxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DownjwjeOEnZH3e88ykBjvED3HOTGAzn5RoqAbXS+qA=;
        b=syS9hHxDxAjhVzcf9mJxxInPYzzUEknuZG38IcswwtxJBAY6POj9zs3J36akmVnv47
         KnwG/rOzF47Heyp5o8wSEcRZFKor4BLl9GyW1TaypBzp0Mc4g2I/7VeyCT21x65YS4bc
         1PYVGbN6I4XRHAOPHoNr9n7pVJyEyedqqKkOOdwppfoejwqI45dS0ysnkDRO4pXOlMrZ
         gG0sYzQebXL9tStMwLB6wKyvaq/F411R6QmqEWHrT4JlFsJV4kzRlX5AHB4UqRXGcg/n
         0w+VuVn4htZKUdnUHVt7q4py6rCYkv64AqxM3W38AiQXHE7AB/zjUqKJlqDXBbyclU6z
         czQQ==
X-Gm-Message-State: AGRZ1gIZ7pa54YUghM2UcFEtzRGuizyAJs/z4UbvmtSLNqGmTI9w4+cs
        tyuKxKvxlNuwyKFEAMJ4I8Q=
X-Google-Smtp-Source: AFSGD/XDnHNF1qWcHGFT3fRwS02TvIwwxiWnXZqaCAaQvwA6urL+H6xZwO+Gg8ZDOPXweFl4ribSUg==
X-Received: by 2002:a1c:d14d:: with SMTP id i74mr10716213wmg.100.1542922828527;
        Thu, 22 Nov 2018 13:40:28 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F5007DE18DA1F72FF8D9.dip0.t-ipconnect.de. [2003:dc:d732:f500:7de1:8da1:f72f:f8d9])
        by smtp.googlemail.com with ESMTPSA id x14sm29755554wrm.65.2018.11.22.13.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 13:40:27 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/4] clk: meson: meson8b: rename cpu_div2/cpu_div3 to cpu_in_div2/cpu_in_div3
Date:   Thu, 22 Nov 2018 22:40:16 +0100
Message-Id: <20181122214017.25643-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
References: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "cpu_div2" and "cpu_div3" take "cpu_in" as input and divide that by
2 or 3. The clock controller can also generate various CPU clock
post-dividers (2, 3, 4, 5, 6, 7, 8) which are derived from "cpu_clk".
When adding support for these post-dividers our clock naming could be
misleading as we have "cpu_div2" as well as "cpu_clk_div2".
Rename the existing "cpu_in" dividers so the name of the divider's
parent is part of the divider clock's name.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 20 ++++++++++----------
 drivers/clk/meson/meson8b.h |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index b3bdc7e05441..010dccc86b5d 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -560,11 +560,11 @@ static struct clk_regmap meson8b_cpu_in_sel = {
 	},
 };
 
-static struct clk_fixed_factor meson8b_cpu_div2 = {
+static struct clk_fixed_factor meson8b_cpu_in_div2 = {
 	.mult = 1,
 	.div = 2,
 	.hw.init = &(struct clk_init_data){
-		.name = "cpu_div2",
+		.name = "cpu_in_div2",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "cpu_in_sel" },
 		.num_parents = 1,
@@ -572,11 +572,11 @@ static struct clk_fixed_factor meson8b_cpu_div2 = {
 	},
 };
 
-static struct clk_fixed_factor meson8b_cpu_div3 = {
+static struct clk_fixed_factor meson8b_cpu_in_div3 = {
 	.mult = 1,
 	.div = 3,
 	.hw.init = &(struct clk_init_data){
-		.name = "cpu_div3",
+		.name = "cpu_in_div3",
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "cpu_in_sel" },
 		.num_parents = 1,
@@ -626,12 +626,12 @@ static struct clk_regmap meson8b_cpu_scale_out_sel = {
 		.ops = &clk_regmap_mux_ops,
 		/*
 		 * NOTE: We are skipping the parent with value 0x2 (which is
-		 * "cpu_div3") because it results in a duty cycle of 33% which
-		 * makes the system unstable and can result in a lockup of the
-		 * whole system.
+		 * "cpu_in_div3") because it results in a duty cycle of 33%
+		 * which makes the system unstable and can result in a lockup
+		 * of the whole system.
 		 */
 		.parent_names = (const char *[]) { "cpu_in_sel",
-						   "cpu_div2",
+						   "cpu_in_div2",
 						   "cpu_scale_div" },
 		.num_parents = 3,
 		.flags = CLK_SET_RATE_PARENT,
@@ -889,8 +889,8 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_MPLL1_DIV]	    = &meson8b_mpll1_div.hw,
 		[CLKID_MPLL2_DIV]	    = &meson8b_mpll2_div.hw,
 		[CLKID_CPU_IN_SEL]	    = &meson8b_cpu_in_sel.hw,
-		[CLKID_CPU_DIV2]	    = &meson8b_cpu_div2.hw,
-		[CLKID_CPU_DIV3]	    = &meson8b_cpu_div3.hw,
+		[CLKID_CPU_IN_DIV2]	    = &meson8b_cpu_in_div2.hw,
+		[CLKID_CPU_IN_DIV3]	    = &meson8b_cpu_in_div3.hw,
 		[CLKID_CPU_SCALE_DIV]	    = &meson8b_cpu_scale_div.hw,
 		[CLKID_CPU_SCALE_OUT_SEL]   = &meson8b_cpu_scale_out_sel.hw,
 		[CLKID_MPLL_PREDIV]	    = &meson8b_mpll_prediv.hw,
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 1c6fb180e6a2..9cba34c6cb92 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -63,8 +63,8 @@
 #define CLKID_MPLL1_DIV		97
 #define CLKID_MPLL2_DIV		98
 #define CLKID_CPU_IN_SEL	99
-#define CLKID_CPU_DIV2		100
-#define CLKID_CPU_DIV3		101
+#define CLKID_CPU_IN_DIV2	100
+#define CLKID_CPU_IN_DIV3	101
 #define CLKID_CPU_SCALE_DIV	102
 #define CLKID_CPU_SCALE_OUT_SEL	103
 #define CLKID_MPLL_PREDIV	104
-- 
2.19.1

