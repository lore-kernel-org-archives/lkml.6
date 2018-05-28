Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161348AbeE1Kbn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161332AbeE1Kbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:31:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 122/329] drm/exynos: fix comparison to bitshift when dealing with a mask
Date: Mon, 28 May 2018 12:00:51 +0200
Message-Id: <20180528100252.827586876@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 1293b6191010672c0c9dacae8f71c6f3e4d70cbe ]

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/regs-fimc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
