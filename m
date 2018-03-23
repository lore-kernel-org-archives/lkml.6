Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeCWFMp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 01:12:45 -0400
Received: from mx.socionext.com ([202.248.49.38]:3269 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751491AbeCWFMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 01:12:44 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] reset: uniphier: add ethernet reset control support for PXs3
Date: Fri, 23 Mar 2018 14:12:34 +0900
Message-Id: <1521781954-20526-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset lines for ethernet controller on PXs3 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/reset/reset-uniphier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index e8bb023..fd3afbd 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -121,6 +121,8 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
 static const struct uniphier_reset_data uniphier_pxs3_sys_reset_data[] = {
 	UNIPHIER_RESETX(2, 0x200c, 0),		/* NAND */
 	UNIPHIER_RESETX(4, 0x200c, 2),		/* eMMC */
+	UNIPHIER_RESETX(6, 0x200c, 9),		/* Ether0 */
+	UNIPHIER_RESETX(7, 0x200c, 10),		/* Ether1 */
 	UNIPHIER_RESETX(8, 0x200c, 12),		/* STDMAC */
 	UNIPHIER_RESETX(12, 0x200c, 4),		/* USB30 link (GIO0) */
 	UNIPHIER_RESETX(13, 0x200c, 5),		/* USB31 link (GIO1) */
-- 
2.7.4
