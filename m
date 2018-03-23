Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeCWFLv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 01:11:51 -0400
Received: from mx.socionext.com ([202.248.49.38]:3235 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeCWFLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 01:11:49 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] clk: uniphier: add ethernet clock control support for PXs3
Date: Fri, 23 Mar 2018 14:11:41 +0900
Message-Id: <1521781901-20466-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock control for ethernet controller on PXs3 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index d244e72..faadd9b 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -233,6 +233,8 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_LD20_SYS_CLK_SD,
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
+	UNIPHIER_CLK_GATE("ether0", 6, NULL, 0x210c, 9),
+	UNIPHIER_CLK_GATE("ether1", 7, NULL, 0x210c, 10),
 	UNIPHIER_CLK_GATE("usb30", 12, NULL, 0x210c, 4),	/* =GIO0 */
 	UNIPHIER_CLK_GATE("usb31-0", 13, NULL, 0x210c, 5),	/* =GIO1 */
 	UNIPHIER_CLK_GATE("usb31-1", 14, NULL, 0x210c, 6),	/* =GIO1-1 */
-- 
2.7.4
