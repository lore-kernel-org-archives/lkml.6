Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18670C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BCE20883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gsJZQ1eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BCE20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeKQHHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:07:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55625 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbeKQHHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:07:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so5954688wmc.5;
        Fri, 16 Nov 2018 12:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Izxh6fMVFA/0xS9HV67hZayJ5aOEqsM4QOvWs81PQVU=;
        b=gsJZQ1egd9+5PkkoGRPjP0LHWw0lAYfyRN+yaJLyTKOtRCg4NDBmzCQUYoEqi7NYH2
         it+c6K81Gyz/7G2g3vgaE1i173cX7xGxJ3C4gxChqMa7bVQ+a623EhJtBvUGAQ/PI1QW
         Hn7bSyWkQjg0fv3XorWcbgc5CRHw2OjbMDEKCnBpWZ1YzB0Ai4M6wyGQHWMeQktudMEj
         BCh0omlWnDRpcsY6i9Ntb1IwPpyVigNK13AT/x0pJTB1LEuTWx2mJ9korhV5+ynq0mBI
         Hba4VqV/xXe0LgFfB/b5SCw2NSFICgud2e5FdedBX/3L+Ngdh7gP0RHjwrYTaSTlZpUS
         lZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Izxh6fMVFA/0xS9HV67hZayJ5aOEqsM4QOvWs81PQVU=;
        b=ZQ6KRdSQwbnZFWwmhBaZRBXv0+I4GV8s6u8tbpUekSLTx0sQAxoYEmqoK1AfRyqJcv
         ojcvI7x/vJqiimneTSoS5WU/MAh0tS4z758dxhmZmT145wTOMAcIVQR3Jli/h9XzW67/
         MGyYebW2xVSSahTrE+O0IbAKAfVYx/qzP3Q2XhvdU2ClzMF9jCs7ptgLv/DCzMwgwf1o
         K3R2QzxzVKcE9ImHLtsDu1NX9LgkRxIE3/Q6RSicHFShyW7ljhujR+9PABIjJXJ3S0g3
         +2RH+VEezpBio3DhqDGLA9TJBXRWSL9MBJRyY8GG5KB2LZgGnf/PQ1s1F30EMe00kUaa
         EEWg==
X-Gm-Message-State: AGRZ1gKiwxumK5nNI6xu8gdQB7/H0AmEmddsEUTZDynsIz5dpPDSg1Fi
        vxxTuLI6vljbJYwYq60HhgE=
X-Google-Smtp-Source: AJdET5cqHu6LyqUnrTbDjCbIoLjE3dF5OytwpD9HmF16C+2MUrpVtRzGSQ1GiH7o+Rr3vI6l9A17wg==
X-Received: by 2002:a1c:730b:: with SMTP id d11-v6mr3584054wmb.107.1542401615615;
        Fri, 16 Nov 2018 12:53:35 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A1006D214A3B023844E6.dip0.t-ipconnect.de. [2003:dc:d717:a100:6d21:4a3b:238:44e6])
        by smtp.googlemail.com with ESMTPSA id z192-v6sm16610273wmc.37.2018.11.16.12.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 12:53:34 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] clk: meson: meson8b: rename cpu_div2/cpu_div3 to cpu_in_div2/cpu_in_div3
Date:   Fri, 16 Nov 2018 21:53:02 +0100
Message-Id: <20181116205303.6354-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
References: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
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

