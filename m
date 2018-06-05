Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeFETDa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:03:30 -0400
Received: from anholt.net ([50.246.234.109]:40568 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbeFETDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:03:07 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        amd-gfx@lists.freedesktop.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/3] drm/v3d: Add a note about locking of v3d_fence_create().
Date: Tue,  5 Jun 2018 12:03:02 -0700
Message-Id: <20180605190302.18279-3-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180605190302.18279-1-eric@anholt.net>
References: <20180605190302.18279-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't the first time I've had to argue to myself why the '++' was
safe.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_fence.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
index bfe31a89668b..6265e9ab4a13 100644
--- a/drivers/gpu/drm/v3d/v3d_fence.c
+++ b/drivers/gpu/drm/v3d/v3d_fence.c
@@ -3,6 +3,9 @@
 
 #include "v3d_drv.h"
 
+/* Note that V3D fences are created during v3d_job_run(), so we're
+ * already implictly locked.
+ */
 struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum v3d_queue queue)
 {
 	struct v3d_fence *fence;
-- 
2.17.0
