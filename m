Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbeC3JoX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:44:23 -0400
Received: from mx.socionext.com ([202.248.49.38]:52269 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbeC3JoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:44:21 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/3] clk: uniphier: add PCIe clock control support
Date: Fri, 30 Mar 2018 18:44:12 +0900
Message-Id: <1522403054-18691-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock control for PCIe controller on UniPhier SoCs. This adds
support for Pro5, LD20 and PXs3.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-sys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index fa7f2f3..d539c82 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -141,6 +141,7 @@ const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),				/* PCIe, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
+	UNIPHIER_CLK_GATE("pcie", 24, NULL, 0x2108, 2),
 	UNIPHIER_PRO5_SYS_CLK_AIO(40),
 	{ /* sentinel */ }
 };
@@ -216,6 +217,7 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_CLK_GATE("usb30", 14, NULL, 0x210c, 14),
 	UNIPHIER_CLK_GATE("usb30-phy0", 16, NULL, 0x210c, 12),
 	UNIPHIER_CLK_GATE("usb30-phy1", 17, NULL, 0x210c, 13),
+	UNIPHIER_CLK_GATE("pcie", 24, NULL, 0x210c, 4),
 	UNIPHIER_LD11_SYS_CLK_AIO(40),
 	UNIPHIER_LD11_SYS_CLK_EVEA(41),
 	UNIPHIER_LD11_SYS_CLK_EXIV(42),
@@ -254,6 +256,7 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_CLK_GATE("usb30-phy2", 18, NULL, 0x210c, 20),
 	UNIPHIER_CLK_GATE("usb31-phy0", 20, NULL, 0x210c, 17),
 	UNIPHIER_CLK_GATE("usb31-phy1", 21, NULL, 0x210c, 19),
+	UNIPHIER_CLK_GATE("pcie", 24, NULL, 0x210c, 3),
 	/* CPU gears */
 	UNIPHIER_CLK_DIV4("cpll", 2, 3, 4, 8),
 	UNIPHIER_CLK_DIV4("spll", 2, 3, 4, 8),
-- 
2.7.4
