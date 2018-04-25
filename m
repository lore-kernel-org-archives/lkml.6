Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDYHLn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:11:43 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38934 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDYHLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:11:41 -0400
X-Google-Smtp-Source: AIpwx49Q53eyj2uMGLE5MVCJtuIRY9GGOVUSVuwWKSEif00dLKDncfiTsKMGTQRGqMy/DZz4oykBlA==
From: Vaishali Thakkar <vthakkar1994@gmail.com>
To: eric@anholt.net
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] drm/vc4: make function vc4_allocate_bin_bo static
Date: Wed, 25 Apr 2018 12:39:53 +0530
Message-Id: <20180425070953.17933-1-vthakkar1994@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse complains with following warning:
drivers/gpu/drm/vc4/vc4_v3d.c:222:1: warning: symbol
'vc4_allocate_bin_bo' was not declared. Should it be static?

Make vc4_allocate_bin static as it is not used outside of
vc4_v3d.c.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index bfc2fa73d2ae..e47e29426078 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -218,8 +218,7 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
  * overall CMA pool before they make scenes complicated enough to run
  * out of bin space.
  */
-int
-vc4_allocate_bin_bo(struct drm_device *drm)
+static int vc4_allocate_bin_bo(struct drm_device *drm)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	struct vc4_v3d *v3d = vc4->v3d;
-- 
2.14.1
