Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeETQcr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 12:32:47 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:32864 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752570AbeETQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 12:32:15 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/6] clk: ingenic: jz4770: Add 150us delay after enabling VPU clock
Date: Sun, 20 May 2018 16:31:17 +0000
Message-Id: <20180520163117.14125-6-paul@crapouillou.net>
In-Reply-To: <20180520163117.14125-1-paul@crapouillou.net>
References: <20180520163117.14125-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required, as we must not use the AHB1 bus before it is stable.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4770-cgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index f83852db1e27..c988759cb940 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -362,7 +362,7 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 	[JZ4770_CLK_VPU] = {
 		"vpu", CGU_CLK_GATE,
 		.parents = { JZ4770_CLK_H1CLK, },
-		.gate = { CGU_REG_LCR, 30 },
+		.gate = { CGU_REG_LCR, 30, false, 150 },
 	},
 	[JZ4770_CLK_MMC0] = {
 		"mmc0", CGU_CLK_GATE,
-- 
2.17.0
