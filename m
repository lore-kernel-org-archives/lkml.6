Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeC3Jov (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:44:51 -0400
Received: from mx.socionext.com ([202.248.49.38]:52277 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbeC3Jot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:44:49 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] reset: uniphier: add PCIe reset control support
Date: Fri, 30 Mar 2018 18:44:43 +0900
Message-Id: <1522403084-18780-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522403084-18780-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403084-18780-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset lines for PCIe controller on UniPhier SoCs. This adds support for
Pro5, LD20 and PXs3.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/reset/reset-uniphier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 360e06b..55ae0f1 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -73,6 +73,7 @@ static const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
 	UNIPHIER_RESETX(12, 0x2000, 6),		/* GIO (PCIe, USB3) */
 	UNIPHIER_RESETX(14, 0x2000, 17),	/* USB30 */
 	UNIPHIER_RESETX(15, 0x2004, 17),	/* USB31 */
+	UNIPHIER_RESETX(24, 0x2008, 2),		/* PCIe */
 	UNIPHIER_RESETX(40, 0x2000, 13),	/* AIO */
 	UNIPHIER_RESET_END,
 };
@@ -115,6 +116,7 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
 	UNIPHIER_RESETX(17, 0x200c, 13),	/* USB30-PHY1 */
 	UNIPHIER_RESETX(18, 0x200c, 14),	/* USB30-PHY2 */
 	UNIPHIER_RESETX(19, 0x200c, 15),	/* USB30-PHY3 */
+	UNIPHIER_RESETX(24, 0x200c, 4),		/* PCIe */
 	UNIPHIER_RESETX(40, 0x2008, 0),		/* AIO */
 	UNIPHIER_RESETX(41, 0x2008, 1),		/* EVEA */
 	UNIPHIER_RESETX(42, 0x2010, 2),		/* EXIV */
@@ -134,6 +136,7 @@ static const struct uniphier_reset_data uniphier_pxs3_sys_reset_data[] = {
 	UNIPHIER_RESETX(18, 0x200c, 20),	/* USB30-PHY2 */
 	UNIPHIER_RESETX(20, 0x200c, 17),	/* USB31-PHY0 */
 	UNIPHIER_RESETX(21, 0x200c, 19),	/* USB31-PHY1 */
+	UNIPHIER_RESETX(24, 0x200c, 3),		/* PCIe */
 	UNIPHIER_RESET_END,
 };
 
-- 
2.7.4
