Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeBEUKy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:10:54 -0500
Received: from sauhun.de ([88.99.104.3]:34234 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeBEUKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:10:25 -0500
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/4] drm/exynos: fix comparison to bitshift when dealing with a mask
Date: Mon,  5 Feb 2018 21:09:59 +0100
Message-Id: <20180205201002.23621-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Only build tested. To be applied individually per subsystem.

 drivers/gpu/drm/exynos/regs-fimc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/regs-fimc.h b/drivers/gpu/drm/exynos/regs-fimc.h
index 30496134a3d072..d7cbe53c4c01f4 100644
--- a/drivers/gpu/drm/exynos/regs-fimc.h
+++ b/drivers/gpu/drm/exynos/regs-fimc.h
@@ -569,7 +569,7 @@
 #define EXYNOS_CIIMGEFF_FIN_EMBOSSING		(4 << 26)
 #define EXYNOS_CIIMGEFF_FIN_SILHOUETTE		(5 << 26)
 #define EXYNOS_CIIMGEFF_FIN_MASK			(7 << 26)
-#define EXYNOS_CIIMGEFF_PAT_CBCR_MASK		((0xff < 13) | (0xff < 0))
+#define EXYNOS_CIIMGEFF_PAT_CBCR_MASK		((0xff << 13) | (0xff << 0))
 
 /* Real input DMA size register */
 #define EXYNOS_CIREAL_ISIZE_AUTOLOAD_ENABLE	(1 << 31)
-- 
2.11.0
