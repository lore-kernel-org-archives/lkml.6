Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeBSLX1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:23:27 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39817 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbeBSLV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:21:57 -0500
X-Google-Smtp-Source: AH8x227oZJg7q+tBBsPG0qFpexH9a/h0XLN3zJslmDp831RwHsCrwbuDbPW8142SFsXJn2Wcvq7mJA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] clk: meson: add gp0 frac parameter for axg and gxl
Date: Mon, 19 Feb 2018 12:21:40 +0100
Message-Id: <20180219112146.21746-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219112146.21746-1-jbrunet@baylibre.com>
References: <20180219112146.21746-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the frac parameter for the gp0 pll of the axg and gxl.
This allows to achieve rates between the fixed settings provided
by the table.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c  | 7 ++++++-
 drivers/clk/meson/gxbb.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 4f13929cd594..892572a2d70f 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -193,7 +193,7 @@ static const struct pll_rate_table axg_gp0_pll_rate_table[] = {
 };
 
 const struct reg_sequence axg_gp0_init_regs[] = {
-	{ .reg = HHI_GP0_PLL_CNTL1,	.def = 0xc084a000 },
+	{ .reg = HHI_GP0_PLL_CNTL1,	.def = 0xc084b000 },
 	{ .reg = HHI_GP0_PLL_CNTL2,	.def = 0xb75020be },
 	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a59a288 },
 	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0xc000004d },
@@ -218,6 +218,11 @@ static struct clk_regmap axg_gp0_pll = {
 			.shift   = 16,
 			.width   = 2,
 		},
+		.frac = {
+			.reg_off = HHI_GP0_PLL_CNTL1,
+			.shift   = 0,
+			.width   = 10,
+		},
 		.l = {
 			.reg_off = HHI_GP0_PLL_CNTL,
 			.shift   = 31,
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index ac48eef0f490..fdeb372863de 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -437,7 +437,7 @@ static struct clk_regmap gxbb_gp0_pll = {
 };
 
 const struct reg_sequence gxl_gp0_init_regs[] = {
-	{ .reg = HHI_GP0_PLL_CNTL1,	.def = 0xc084a000 },
+	{ .reg = HHI_GP0_PLL_CNTL1,	.def = 0xc084b000 },
 	{ .reg = HHI_GP0_PLL_CNTL2,	.def = 0xb75020be },
 	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a59a288 },
 	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0xc000004d },
@@ -462,6 +462,11 @@ static struct clk_regmap gxl_gp0_pll = {
 			.shift   = 16,
 			.width   = 2,
 		},
+		.frac = {
+			.reg_off = HHI_GP0_PLL_CNTL1,
+			.shift   = 0,
+			.width   = 10,
+		},
 		.l = {
 			.reg_off = HHI_GP0_PLL_CNTL,
 			.shift   = 31,
-- 
2.14.3
