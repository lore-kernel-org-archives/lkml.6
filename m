Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965055AbeEIPhL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:37:11 -0400
Received: from vern.gendns.com ([206.190.152.46]:47005 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935346AbeEIPhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:37:08 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] clk: davinci: pll-dm355: drop pll2_sysclk2
Date: Wed,  9 May 2018 10:36:41 -0500
Message-Id: <20180509153642.22399-2-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509153642.22399-1-david@lechnology.com>
References: <20180509153642.22399-1-david@lechnology.com>
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

This removes pll2_sysclk2 from the TI DM355 clock driver. This SoC
doesn't have such a clock. Also, SYSCLK_ALWAYS_ENABLED is transferred
to pll2_sysclk1 since it drives the DDR and doesn't have another
mechanism to keep it on.

Reported-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/pll-dm355.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/davinci/pll-dm355.c b/drivers/clk/davinci/pll-dm355.c
index 5345f8286c50..718d9bbbf30d 100644
--- a/drivers/clk/davinci/pll-dm355.c
+++ b/drivers/clk/davinci/pll-dm355.c
@@ -62,8 +62,7 @@ static const struct davinci_pll_clk_info dm355_pll2_info = {
 		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
 };
 
-SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV);
-SYSCLK(2, pll2_sysclk2, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
+SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
 
 int dm355_pll2_init(struct device *dev, void __iomem *base)
 {
@@ -71,8 +70,6 @@ int dm355_pll2_init(struct device *dev, void __iomem *base)
 
 	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
 
-	davinci_pll_sysclk_register(dev, &pll2_sysclk2, base);
-
 	davinci_pll_sysclkbp_clk_register(dev, "pll2_sysclkbp", base);
 
 	return 0;
-- 
2.17.0
