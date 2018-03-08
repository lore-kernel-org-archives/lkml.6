Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965346AbeCHIJf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:09:35 -0500
Received: from mx.socionext.com ([202.248.49.38]:23820 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935333AbeCHIJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:09:33 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] reset: uniphier: add Pro4/Pro5/PXs2 audio systems reset control
Date: Thu,  8 Mar 2018 17:09:29 +0900
Message-Id: <20180308080929.30982-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset lines for audio subsystem (AIO) on UniPhier
Pro4/Pro5/PXs2 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 drivers/reset/reset-uniphier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index e8bb023ff15e..0fa23129d343 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -63,6 +63,7 @@ static const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
 	UNIPHIER_RESETX(12, 0x2000, 6),		/* GIO (Ether, SATA, USB3) */
 	UNIPHIER_RESETX(14, 0x2000, 17),	/* USB30 */
 	UNIPHIER_RESETX(15, 0x2004, 17),	/* USB31 */
+	UNIPHIER_RESETX(40, 0x2000, 13),	/* AIO */
 	UNIPHIER_RESET_END,
 };
 
@@ -72,6 +73,7 @@ static const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
 	UNIPHIER_RESETX(12, 0x2000, 6),		/* GIO (PCIe, USB3) */
 	UNIPHIER_RESETX(14, 0x2000, 17),	/* USB30 */
 	UNIPHIER_RESETX(15, 0x2004, 17),	/* USB31 */
+	UNIPHIER_RESETX(40, 0x2000, 13),	/* AIO */
 	UNIPHIER_RESET_END,
 };
 
@@ -88,6 +90,7 @@ static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
 	UNIPHIER_RESETX(21, 0x2014, 1),		/* USB31-PHY1 */
 	UNIPHIER_RESETX(28, 0x2014, 12),	/* SATA */
 	UNIPHIER_RESET(29, 0x2014, 8),		/* SATA-PHY (active high) */
+	UNIPHIER_RESETX(40, 0x2000, 13),	/* AIO */
 	UNIPHIER_RESET_END,
 };
 
-- 
2.16.1
