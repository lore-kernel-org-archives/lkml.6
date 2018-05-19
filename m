Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeESSci (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:32:38 -0400
Received: from mailout7.siol.net ([213.250.19.134]:34663 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752590AbeESScc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:32:32 -0400
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 02/15] clk: sunxi-ng: r40: Allow setting parent rate to display related clocks
Date: Sat, 19 May 2018 20:31:14 +0200
Message-Id: <20180519183127.2718-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display related peripherals need precise clocks to operate correctly.

Allow DE2, TCONs and HDMI to set parent clock.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index c16a62a7bdbd..fa5317719684 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -655,7 +655,8 @@ static SUNXI_CCU_GATE(dram_deinterlace_clk,	"dram-deinterlace",	"dram",
 
 static const char * const de_parents[] = { "pll-periph0-2x", "pll-de" };
 static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
-				 0x104, 0, 4, 24, 3, BIT(31), 0);
+				 0x104, 0, 4, 24, 3, BIT(31),
+				 CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M_WITH_MUX_GATE(mp_clk, "mp", de_parents,
 				 0x108, 0, 4, 24, 3, BIT(31), 0);
 
@@ -667,9 +668,11 @@ static SUNXI_CCU_MUX_WITH_GATE(tcon_lcd0_clk, "tcon-lcd0", tcon_parents,
 static SUNXI_CCU_MUX_WITH_GATE(tcon_lcd1_clk, "tcon-lcd1", tcon_parents,
 			       0x114, 24, 3, BIT(31), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M_WITH_MUX_GATE(tcon_tv0_clk, "tcon-tv0", tcon_parents,
-				 0x118, 0, 4, 24, 3, BIT(31), 0);
+				 0x118, 0, 4, 24, 3, BIT(31),
+				 CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M_WITH_MUX_GATE(tcon_tv1_clk, "tcon-tv1", tcon_parents,
-				 0x11c, 0, 4, 24, 3, BIT(31), 0);
+				 0x11c, 0, 4, 24, 3, BIT(31),
+				 CLK_SET_RATE_PARENT);
 
 static const char * const deinterlace_parents[] = { "pll-periph0",
 						    "pll-periph1" };
@@ -699,7 +702,8 @@ static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 
 static const char * const hdmi_parents[] = { "pll-video0", "pll-video1" };
 static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
-				 0x150, 0, 4, 24, 2, BIT(31), 0);
+				 0x150, 0, 4, 24, 2, BIT(31),
+				 CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(hdmi_slow_clk,	"hdmi-slow",	"osc24M",
 		      0x154, BIT(31), 0);
-- 
2.17.0
