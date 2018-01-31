Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeAaSO3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:14:29 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39170 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbeAaSJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:09:54 -0500
X-Google-Smtp-Source: AH8x227fhbAs0Yq8u4I4nUA3QTTaEU1ISOONVUn4EJPf/hf5y+awwDjhXtMCo621jx/P+o9nNzkHMQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/19] clk: meson: remove obsolete comments
Date: Wed, 31 Jan 2018 19:09:30 +0100
Message-Id: <20180131180945.18025-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over time things changes in CCF and issues have been fixed in meson
controllers.

Now, clk81 is decently modeled by read-only PLLs, a mux, a divider
and a gate. We can remove the FIXME comments related to clk81.
Also remove the comment about devm_clk_hw_register, as there is
apparently nothing wrong with it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     | 5 -----
 drivers/clk/meson/gxbb.c    | 6 ------
 drivers/clk/meson/meson8b.c | 1 -
 3 files changed, 12 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 81565b025b70..f84927e76f88 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -411,11 +411,6 @@ static struct meson_clk_mpll axg_mpll3 = {
 	},
 };
 
-/*
- * FIXME The legacy composite clocks (e.g. clk81) are both PLL post-dividers
- * and should be modeled with their respective PLLs via the forthcoming
- * coordinated clock rates feature
- */
 static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
 static const char * const clk81_parent_names[] = {
 	"xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index e6adab49c0ba..6609024eee00 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -575,12 +575,6 @@ static struct meson_clk_mpll gxbb_mpll2 = {
 	},
 };
 
-/*
- * FIXME The legacy composite clocks (e.g. clk81) are both PLL post-dividers
- * and should be modeled with their respective PLLs via the forthcoming
- * coordinated clock rates feature
- */
-
 static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
 static const char * const clk81_parent_names[] = {
 	"xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index ffadad27375e..db017c29a84c 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -849,7 +849,6 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 		if (!meson8b_hw_onecell_data.hws[i])
 			continue;
 
-		/* FIXME convert to devm_clk_register */
 		ret = devm_clk_hw_register(dev, meson8b_hw_onecell_data.hws[i]);
 		if (ret)
 			return ret;
-- 
2.14.3
