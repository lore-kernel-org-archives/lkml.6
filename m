Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753288AbeCPR4I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:56:08 -0400
Received: from hermes.aosc.io ([199.195.250.187]:52793 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752048AbeCPR4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:56:05 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 4/7] clk: sunxi-ng: add A64 compatible string
Date: Sat, 17 Mar 2018 01:53:51 +0800
Message-Id: <20180316175354.21437-5-icenowy@aosc.io>
In-Reply-To: <20180316175354.21437-1-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As claiming Allwinner A64 SRAM C is a prerequisite for all sub-blocks of
the A64 DE2, not only the CCU sub-block, a bus driver is then written for
enabling the access to the whole DE2 part by claiming the SRAM.

In this situation, the A64 compatible string will be just added with no
other requirments, as they're processed by the parent bus driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index 468d1abaf0ee..8df7cd93453e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -292,13 +292,10 @@ static const struct of_device_id sunxi_de2_clk_ids[] = {
 		.compatible = "allwinner,sun50i-h5-de2-clk",
 		.data = &sun50i_a64_de2_clk_desc,
 	},
-	/*
-	 * The Allwinner A64 SoC needs some bit to be poke in syscon to make
-	 * DE2 really working.
-	 * So there's currently no A64 compatible here.
-	 * H5 shares the same reset line with A64, so here H5 is using the
-	 * clock description of A64.
-	 */
+	{
+		.compatible = "allwinner,sun50i-a64-de2-clk",
+		.data = &sun50i_a64_de2_clk_desc,
+	},
 	{ }
 };
 
-- 
2.15.1
