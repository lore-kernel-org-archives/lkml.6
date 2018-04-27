Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757131AbeD0Al1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 20:41:27 -0400
Received: from mx.socionext.com ([202.248.49.38]:11225 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbeD0Al0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 20:41:26 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] reset: uniphier: add LD11/LD20 stream demux system reset control
Date: Fri, 27 Apr 2018 09:41:21 +0900
Message-Id: <20180427004121.4143-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset lines for MPEG2 transport stream I/O and demux system (HSC)
on UniPhier LD11/LD20 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 drivers/reset/reset-uniphier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 360e06b20c53..7a3a449c4900 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -99,6 +99,7 @@ static const struct uniphier_reset_data uniphier_ld11_sys_reset_data[] = {
 	UNIPHIER_RESETX(4, 0x200c, 2),		/* eMMC */
 	UNIPHIER_RESETX(6, 0x200c, 6),		/* Ether */
 	UNIPHIER_RESETX(8, 0x200c, 8),		/* STDMAC (HSC, MIO) */
+	UNIPHIER_RESETX(9, 0x200c, 9),		/* HSC */
 	UNIPHIER_RESETX(40, 0x2008, 0),		/* AIO */
 	UNIPHIER_RESETX(41, 0x2008, 1),		/* EVEA */
 	UNIPHIER_RESETX(42, 0x2010, 2),		/* EXIV */
@@ -110,6 +111,7 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
 	UNIPHIER_RESETX(4, 0x200c, 2),		/* eMMC */
 	UNIPHIER_RESETX(6, 0x200c, 6),		/* Ether */
 	UNIPHIER_RESETX(8, 0x200c, 8),		/* STDMAC (HSC) */
+	UNIPHIER_RESETX(9, 0x200c, 9),		/* HSC */
 	UNIPHIER_RESETX(12, 0x200c, 5),		/* GIO (PCIe, USB3) */
 	UNIPHIER_RESETX(16, 0x200c, 12),	/* USB30-PHY0 */
 	UNIPHIER_RESETX(17, 0x200c, 13),	/* USB30-PHY1 */
-- 
2.17.0
