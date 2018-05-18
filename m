Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeERK6p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:58:45 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:60036 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbeERK6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:58:43 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clkdev: Remove duplicated negative index check from __of_clk_get()
Date: Fri, 18 May 2018 12:58:40 +0200
Message-Id: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__of_clk_get() calls of_parse_phandle_with_args(), which rejects
negative indices since commit bd69f73f2c81eed9 ("of: Create function for
counting number of phandles in a property").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Commit bd69f73f2c81eed9 is in v3.9.
---
 drivers/clk/clkdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 7513411140b693ec..02fcee2012e05250 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -35,9 +35,6 @@ static struct clk *__of_clk_get(struct device_node *np, int index,
 	struct clk *clk;
 	int rc;
 
-	if (index < 0)
-		return ERR_PTR(-EINVAL);
-
 	rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
 					&clkspec);
 	if (rc)
-- 
2.7.4
