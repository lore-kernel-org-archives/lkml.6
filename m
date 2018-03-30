Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbeC3Jo2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:44:28 -0400
Received: from mx.socionext.com ([202.248.49.38]:52266 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbeC3JoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:44:24 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/3] clk: uniphier: add additional ethernet clock lines for Pro4
Date: Fri, 30 Mar 2018 18:44:14 +0900
Message-Id: <1522403054-18691-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pro4 SoC has clock lines for Giga-bit feature and ethernet phy,
and these are mandatory to activate the ethernet controller. This adds
support for the clock lines.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-sys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index 7d66dfb..ebc78ab2 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -102,13 +102,16 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("upll", -1, "ref", 288, 25),	/* 288 MHz */
 	UNIPHIER_CLK_FACTOR("a2pll", -1, "upll", 256, 125),	/* 589.824 MHz */
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 270, 25),	/* 270 MHz */
+	UNIPHIER_CLK_FACTOR("gpll", -1, "ref", 10, 1),		/* 250 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 8),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 32),
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
 	UNIPHIER_PRO4_SYS_CLK_ETHER(6),
+	UNIPHIER_CLK_GATE("ether-gb", 7, "gpll", 0x2104, 5),
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),			/* HSC, MIO, RLE */
+	UNIPHIER_CLK_GATE("ether-phy", 10, "ref", 0x2260, 0),
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),			/* Ether, SATA, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
-- 
2.7.4
