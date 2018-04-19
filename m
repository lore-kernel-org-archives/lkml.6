Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbeDSJde (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:33:34 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:35670 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752780AbeDSJce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:32:34 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Liu <net147@gmail.com>
Subject: [PATCH 2/6] drm/sun4i: tcon: Rename Dithering related register macros
Date: Thu, 19 Apr 2018 17:32:21 +0800
Message-Id: <20180419093225.614-3-wens@csie.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419093225.614-1-wens@csie.org>
References: <20180419093225.614-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dithering is only supported for TCON channel 0. Throughout the datasheet
all the names associated with these register are prefixed "TCON0",
instead of "TCON". The only exception is the control register
"TCON_FRM_CTL_REG".

Rename the macros to reflect this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index f6a071cd5a6f..3d492c8be1fc 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -37,18 +37,21 @@
 #define SUN4I_TCON_GINT1_REG			0x8
 
 #define SUN4I_TCON_FRM_CTL_REG			0x10
-#define SUN4I_TCON_FRM_CTL_EN				BIT(31)
-
-#define SUN4I_TCON_FRM_SEED_PR_REG		0x14
-#define SUN4I_TCON_FRM_SEED_PG_REG		0x18
-#define SUN4I_TCON_FRM_SEED_PB_REG		0x1c
-#define SUN4I_TCON_FRM_SEED_LR_REG		0x20
-#define SUN4I_TCON_FRM_SEED_LG_REG		0x24
-#define SUN4I_TCON_FRM_SEED_LB_REG		0x28
-#define SUN4I_TCON_FRM_TBL0_REG			0x2c
-#define SUN4I_TCON_FRM_TBL1_REG			0x30
-#define SUN4I_TCON_FRM_TBL2_REG			0x34
-#define SUN4I_TCON_FRM_TBL3_REG			0x38
+#define SUN4I_TCON0_FRM_CTL_EN				BIT(31)
+#define SUN4I_TCON0_FRM_CTL_MODE_R			BIT(6)
+#define SUN4I_TCON0_FRM_CTL_MODE_G			BIT(5)
+#define SUN4I_TCON0_FRM_CTL_MODE_B			BIT(4)
+
+#define SUN4I_TCON0_FRM_SEED_PR_REG		0x14
+#define SUN4I_TCON0_FRM_SEED_PG_REG		0x18
+#define SUN4I_TCON0_FRM_SEED_PB_REG		0x1c
+#define SUN4I_TCON0_FRM_SEED_LR_REG		0x20
+#define SUN4I_TCON0_FRM_SEED_LG_REG		0x24
+#define SUN4I_TCON0_FRM_SEED_LB_REG		0x28
+#define SUN4I_TCON0_FRM_TBL0_REG		0x2c
+#define SUN4I_TCON0_FRM_TBL1_REG		0x30
+#define SUN4I_TCON0_FRM_TBL2_REG		0x34
+#define SUN4I_TCON0_FRM_TBL3_REG		0x38
 
 #define SUN4I_TCON0_CTL_REG			0x40
 #define SUN4I_TCON0_CTL_TCON_ENABLE			BIT(31)
-- 
2.17.0
