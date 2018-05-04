Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeEDOYu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:24:50 -0400
Received: from vern.gendns.com ([206.190.152.46]:44098 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeEDOYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:24:49 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH] clk: davinci: pll-dm355: fix SYSCLKn parent names
Date: Fri,  4 May 2018 09:24:26 -0500
Message-Id: <20180504142426.4764-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the parent clock names of the SYSCLKn clocks for the DM355
SoC in the TI DaVinici PLL clock driver.

It appears that this name just didn't get updated to the correct name
like the other SoCs during the driver's development.

Reported-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: David Lechner <david@lechnology.com>
---

Sekhar, can you please test to make sure this works?


 drivers/clk/davinci/pll-dm355.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/davinci/pll-dm355.c b/drivers/clk/davinci/pll-dm355.c
index a0cff4212ac3..13dc6b8ea97a 100644
--- a/drivers/clk/davinci/pll-dm355.c
+++ b/drivers/clk/davinci/pll-dm355.c
@@ -22,10 +22,10 @@ static const struct davinci_pll_clk_info dm355_pll1_info = {
 		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
 };
 
-SYSCLK(1, pll1_sysclk1, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
-SYSCLK(2, pll1_sysclk2, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
-SYSCLK(3, pll1_sysclk3, pll1, 5, SYSCLK_ALWAYS_ENABLED);
-SYSCLK(4, pll1_sysclk4, pll1, 5, SYSCLK_ALWAYS_ENABLED);
+SYSCLK(1, pll1_sysclk1, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
+SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
+SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
+SYSCLK(4, pll1_sysclk4, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
 
 int dm355_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
@@ -62,8 +62,8 @@ static const struct davinci_pll_clk_info dm355_pll2_info = {
 		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
 };
 
-SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV);
-SYSCLK(2, pll2_sysclk2, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
+SYSCLK(1, pll2_sysclk1, pll2_pllen, 5, SYSCLK_FIXED_DIV);
+SYSCLK(2, pll2_sysclk2, pll2_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
 
 int dm355_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
-- 
2.17.0
