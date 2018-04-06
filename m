Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeDFHvz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:51:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49353 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751849AbeDFHvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:51:52 -0400
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: vireshk@kernel.org, shiraz.linux.kernel@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 2/2] clk: spear: fix WDT clock definition on SPEAr600
Date: Fri,  6 Apr 2018 09:50:45 +0200
Message-Id: <c7240072ab53d5d34a9756389729343243028eb3.1523000725.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
References: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
References: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no SPEAr600 device named "wdt". Instead, the description of the
WDT (watchdog) was recently added to the Device Tree, and the device
name is "fc880000.wdt", so we should associate the WDT fixed rate clock
to this device name.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/clk/spear/spear6xx_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index f911d9f..47810be 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -147,7 +147,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_fixed_factor(NULL, "wdt_clk", "osc_30m_clk", 0, 1,
 			1);
-	clk_register_clkdev(clk, NULL, "wdt");
+	clk_register_clkdev(clk, NULL, "fc880000.wdt");
 
 	/* clock derived from pll1 clk */
 	clk = clk_register_fixed_factor(NULL, "cpu_clk", "pll1_clk",
-- 
git-series 0.9.1
