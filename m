Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47262C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A620214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544133564;
	bh=jhxzZMzHe1eBf0uThqqOe48T8IAatDL1YuqKWy4hCZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O1dMqlkBFWpOOJyJKP+xreyiBprBfx0YnxmvVOQePQ+Z7eH0BG2UiNDrgfp85KfCp
	 qIpjIlj1xwjWf+UXZ7B35gB949o2RLX3oLpmCkX6iajXpqR7dUNLGPgiJnI8rk5xH7
	 fng3eX6/5z7a5twC3moGAbE9Nggfz6250v6KmcwU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A620214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbeLFV7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbeLFV7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:59:01 -0500
Received: from mail.kernel.org (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C497214E0;
        Thu,  6 Dec 2018 21:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544133539;
        bh=jhxzZMzHe1eBf0uThqqOe48T8IAatDL1YuqKWy4hCZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tob0MH4vtNlu3MqUjWuGRaHV9JAVP0mOrE3W1+dbZgBi3XSWYTI9cbECi9y22o2S9
         cBn24+N8USuKqBe4cub11/yTxyvmV9SZQkjNX67y3JxMnjL/BjwW7ZxbHnQcRUhkG3
         Uk8tDfn6rKMNrteNBh0UbGfBynMJYZI3NdIx1V18=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/8] clk: renesas: Remove usage of CLK_IS_BASIC
Date:   Thu,  6 Dec 2018 13:58:51 -0800
Message-Id: <20181206215858.3880-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181206215858.3880-1-sboyd@kernel.org>
References: <20181206215858.3880-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag doesn't look to be used by any code, just set in various clk
init structures and then never tested again. Remove it from these
drivers as it doesn't provide any benefit.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: <linux-renesas-soc@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/renesas/clk-div6.c         | 2 +-
 drivers/clk/renesas/clk-mstp.c         | 2 +-
 drivers/clk/renesas/r9a06g032-clocks.c | 8 ++++----
 drivers/clk/renesas/rcar-gen3-cpg.c    | 2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/clk-div6.c b/drivers/clk/renesas/clk-div6.c
index 57c934164306..e98a9f5b3c90 100644
--- a/drivers/clk/renesas/clk-div6.c
+++ b/drivers/clk/renesas/clk-div6.c
@@ -274,7 +274,7 @@ struct clk * __init cpg_div6_register(const char *name,
 	/* Register the clock. */
 	init.name = name;
 	init.ops = &cpg_div6_clock_ops;
-	init.flags = CLK_IS_BASIC;
+	init.flags = 0;
 	init.parent_names = parent_names;
 	init.num_parents = valid_parents;
 
diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 1c1768c2cc82..2ba6105937e3 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -158,7 +158,7 @@ static struct clk * __init cpg_mstp_clock_register(const char *name,
 
 	init.name = name;
 	init.ops = &cpg_mstp_clock_ops;
-	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT;
 	/* INTC-SYS is the module clock of the GIC, and must not be disabled */
 	if (!strcmp(name, "intc-sys")) {
 		pr_debug("MSTP %s setting CLK_IS_CRITICAL\n", name);
diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 6d2b56891559..658cb11b6f55 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -424,7 +424,7 @@ r9a06g032_register_gate(struct r9a06g032_priv *clocks,
 
 	init.name = desc->name;
 	init.ops = &r9a06g032_clk_gate_ops;
-	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = parent_name ? &parent_name : NULL;
 	init.num_parents = parent_name ? 1 : 0;
 
@@ -595,7 +595,7 @@ r9a06g032_register_div(struct r9a06g032_priv *clocks,
 
 	init.name = desc->name;
 	init.ops = &r9a06g032_clk_div_ops;
-	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = parent_name ? &parent_name : NULL;
 	init.num_parents = parent_name ? 1 : 0;
 
@@ -683,7 +683,7 @@ r9a06g032_register_bitsel(struct r9a06g032_priv *clocks,
 
 	init.name = desc->name;
 	init.ops = &clk_bitselect_ops;
-	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = names;
 	init.num_parents = 2;
 
@@ -777,7 +777,7 @@ r9a06g032_register_dualgate(struct r9a06g032_priv *clocks,
 
 	init.name = desc->name;
 	init.ops = &r9a06g032_clk_dualgate_ops;
-	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 	g->hw.init = &init;
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 4ba38f98cc7b..48e003c69cd1 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -368,7 +368,7 @@ static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 
 	init.name = core->name;
 	init.ops = &cpg_sd_clock_ops;
-	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index f7bb817420b4..30df0dc853f0 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -412,7 +412,7 @@ static void __init cpg_mssr_register_mod_clk(const struct mssr_mod_clk *mod,
 
 	init.name = mod->name;
 	init.ops = &cpg_mstp_clock_ops;
-	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT;
 	for (i = 0; i < info->num_crit_mod_clks; i++)
 		if (id == info->crit_mod_clks[i]) {
 			dev_dbg(dev, "MSTP %s setting CLK_IS_CRITICAL\n",
-- 
Sent by a computer through tubes

