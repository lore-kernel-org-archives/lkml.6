Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964940AbeCHIXj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:23:39 -0500
Received: from mx.socionext.com ([202.248.49.38]:24040 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935488AbeCHIXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:23:36 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] clk: uniphier: add Pro4/Pro5/PXs2 audio system clock
Date: Thu,  8 Mar 2018 17:23:32 +0900
Message-Id: <20180308082332.31063-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock for audio subsystem (AIO) on UniPhier
Pro4/Pro5/PXs2 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-sys.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index d244e724e198..06c5269f63f5 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -57,6 +57,14 @@
 #define UNIPHIER_PRO4_SYS_CLK_USB3(idx, ch)				\
 	UNIPHIER_CLK_GATE("usb3" #ch, (idx), NULL, 0x2104, 16 + (ch))
 
+#define UNIPHIER_PRO4_SYS_CLK_AIO(idx)					\
+	UNIPHIER_CLK_FACTOR("aio-io200m", -1, "spll", 1, 8),		\
+	UNIPHIER_CLK_GATE("aio", (idx), "aio-io200m", 0x2104, 13)
+
+#define UNIPHIER_PRO5_SYS_CLK_AIO(idx)					\
+	UNIPHIER_CLK_FACTOR("aio-io200m", -1, "spll", 1, 12),		\
+	UNIPHIER_CLK_GATE("aio", (idx), "aio-io200m", 0x2104, 13)
+
 #define UNIPHIER_LD11_SYS_CLK_AIO(idx)					\
 	UNIPHIER_CLK_FACTOR("aio-io200m", -1, "spll", 1, 10),		\
 	UNIPHIER_CLK_GATE("aio", (idx), "aio-io200m", 0x2108, 0)
@@ -104,6 +112,7 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),			/* Ether, SATA, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
+	UNIPHIER_PRO4_SYS_CLK_AIO(40),
 	{ /* sentinel */ }
 };
 
@@ -132,6 +141,7 @@ const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),				/* PCIe, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
+	UNIPHIER_PRO5_SYS_CLK_AIO(40),
 	{ /* sentinel */ }
 };
 
@@ -149,6 +159,7 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	/* The document mentions 0x2104 bit 18, but not functional */
 	UNIPHIER_CLK_GATE("usb30-phy", 16, NULL, 0x2104, 19),
 	UNIPHIER_CLK_GATE("usb31-phy", 20, NULL, 0x2104, 20),
+	UNIPHIER_PRO5_SYS_CLK_AIO(40),
 	{ /* sentinel */ }
 };
 
-- 
2.16.1
