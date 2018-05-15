Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeEOCOk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:14:40 -0400
Received: from mx.socionext.com ([202.248.49.38]:43834 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752044AbeEOCOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:14:39 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH RESEND] clk: uniphier: add LD11/LD20 stream demux system clock
Date: Tue, 15 May 2018 11:14:16 +0900
Message-Id: <20180515021416.31760-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock for MPEG2 transport stream I/O and demux system (HSC) on
UniPhier LD11/LD20 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-sys.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index ebc78ab2df05..4f5ff9fa11fd 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -51,6 +51,9 @@
 #define UNIPHIER_LD11_SYS_CLK_STDMAC(idx)				\
 	UNIPHIER_CLK_GATE("stdmac", (idx), NULL, 0x210c, 8)
 
+#define UNIPHIER_LD11_SYS_CLK_HSC(idx)					\
+	UNIPHIER_CLK_GATE("hsc", (idx), NULL, 0x210c, 9)
+
 #define UNIPHIER_PRO4_SYS_CLK_GIO(idx)					\
 	UNIPHIER_CLK_GATE("gio", (idx), NULL, 0x2104, 6)
 
@@ -182,6 +185,7 @@ const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
 	/* Index 5 reserved for eMMC PHY */
 	UNIPHIER_LD11_SYS_CLK_ETHER(6),
 	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC, MIO */
+	UNIPHIER_LD11_SYS_CLK_HSC(9),
 	UNIPHIER_CLK_FACTOR("usb2", -1, "ref", 24, 25),
 	UNIPHIER_LD11_SYS_CLK_AIO(40),
 	UNIPHIER_LD11_SYS_CLK_EVEA(41),
@@ -215,6 +219,7 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_LD20_SYS_CLK_SD,
 	UNIPHIER_LD11_SYS_CLK_ETHER(6),
 	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC */
+	UNIPHIER_LD11_SYS_CLK_HSC(9),
 	/* GIO is always clock-enabled: no function for 0x210c bit5 */
 	/*
 	 * clock for USB Link is enabled by the logic "OR" of bit 14 and bit 15.
-- 
2.17.0
