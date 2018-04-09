Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbeDIU6Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:58:16 -0400
Received: from anholt.net ([50.246.234.109]:53996 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754125AbeDIU6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:58:15 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm/vc4: Fix leak of the file_priv that stored the perfmon.
Date: Mon,  9 Apr 2018 13:58:13 -0700
Message-Id: <20180409205813.7077-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 65101d8c9108 ("drm/vc4: Expose performance counters to userspace")
---
 drivers/gpu/drm/vc4/vc4_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 94b99c90425a..7c95ed5c5cac 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -130,6 +130,7 @@ static void vc4_close(struct drm_device *dev, struct drm_file *file)
 	struct vc4_file *vc4file = file->driver_priv;
 
 	vc4_perfmon_close_file(vc4file);
+	kfree(vc4file);
 }
 
 static const struct vm_operations_struct vc4_vm_ops = {
-- 
2.17.0
