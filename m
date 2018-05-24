Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754862AbeEXFYB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:24:01 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58115 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeEXFX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:23:58 -0400
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: sboyd@kernel.org, linux-clk@vger.kernel.org
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mvebu: use correct bit for 98DX3236 NAND
Date: Thu, 24 May 2018 17:23:41 +1200
Message-Id: <20180524052341.12422-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct fieldbit value for the NAND PLL reload trigger is 27.

Fixes: commit e120c17a70e5 ("clk: mvebu: support for 98DX3236 SoC")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
I can't remember where the value of 26 came from. Looking at the lsp source I
have from Marvell it's always been 27, so I suspect I just messed up when
porting. The only documentation I have is that register field is bits 21:27
without adding any detail as to which clock trees correspond to the individual
bits so I'm not sure which clock tree was being triggered.

 drivers/clk/mvebu/clk-corediv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-corediv.c
index 8491979f4096..68f05c53d40e 100644
--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -72,7 +72,7 @@ static const struct clk_corediv_desc mvebu_corediv_desc[] = {
 };
 
 static const struct clk_corediv_desc mv98dx3236_corediv_desc[] = {
-	{ .mask = 0x0f, .offset = 6, .fieldbit = 26 }, /* NAND clock */
+	{ .mask = 0x0f, .offset = 6, .fieldbit = 27 }, /* NAND clock */
 };
 
 #define to_corediv_clk(p) container_of(p, struct clk_corediv, hw)
-- 
2.17.0
