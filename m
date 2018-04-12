Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeDLCRq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 22:17:46 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:36459 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752341AbeDLCRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 22:17:45 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w3C2GP9O020821
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] reset: uniphier: fix USB clock line for LD20
Date: Thu, 12 Apr 2018 11:16:10 +0900
Message-Id: <1523499370-17757-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For LD20, the bit 5 of the offset 0x200c turned out to be a USB3
reset.  The hardware document says it is the GIO reset despite LD20
has no GIO bus, confusingly.

Also, fix confusing comments for PXs3.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/reset-uniphier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 360e06b..ac18f2f 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -110,7 +110,7 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
 	UNIPHIER_RESETX(4, 0x200c, 2),		/* eMMC */
 	UNIPHIER_RESETX(6, 0x200c, 6),		/* Ether */
 	UNIPHIER_RESETX(8, 0x200c, 8),		/* STDMAC (HSC) */
-	UNIPHIER_RESETX(12, 0x200c, 5),		/* GIO (PCIe, USB3) */
+	UNIPHIER_RESETX(14, 0x200c, 5),		/* USB30 */
 	UNIPHIER_RESETX(16, 0x200c, 12),	/* USB30-PHY0 */
 	UNIPHIER_RESETX(17, 0x200c, 13),	/* USB30-PHY1 */
 	UNIPHIER_RESETX(18, 0x200c, 14),	/* USB30-PHY2 */
@@ -127,8 +127,8 @@ static const struct uniphier_reset_data uniphier_pxs3_sys_reset_data[] = {
 	UNIPHIER_RESETX(6, 0x200c, 9),		/* Ether0 */
 	UNIPHIER_RESETX(7, 0x200c, 10),		/* Ether1 */
 	UNIPHIER_RESETX(8, 0x200c, 12),		/* STDMAC */
-	UNIPHIER_RESETX(12, 0x200c, 4),		/* USB30 link (GIO0) */
-	UNIPHIER_RESETX(13, 0x200c, 5),		/* USB31 link (GIO1) */
+	UNIPHIER_RESETX(12, 0x200c, 4),		/* USB30 link */
+	UNIPHIER_RESETX(13, 0x200c, 5),		/* USB31 link */
 	UNIPHIER_RESETX(16, 0x200c, 16),	/* USB30-PHY0 */
 	UNIPHIER_RESETX(17, 0x200c, 18),	/* USB30-PHY1 */
 	UNIPHIER_RESETX(18, 0x200c, 20),	/* USB30-PHY2 */
-- 
2.7.4
