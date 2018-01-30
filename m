Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbeAaASR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:18:17 -0500
Received: from anholt.net ([50.246.234.109]:55826 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752303AbeAaASQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:18:16 -0500
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm: Print the pid when debug logging an ioctl error.
Date: Tue, 30 Jan 2018 13:56:43 -0800
Message-Id: <20180130215643.11016-1-eric@anholt.net>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we debug print what ioctl we're calling into, we include the pid.
If you have multiple processes rendering simulataneously, the error
return also needs the pid so you can see which of the ioctl calls was
the one to fail.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/drm_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index a9ae6dd2d593..38c302607738 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -842,7 +842,7 @@ long drm_ioctl(struct file *filp,
 	if (kdata != stack_kdata)
 		kfree(kdata);
 	if (retcode)
-		DRM_DEBUG("ret = %d\n", retcode);
+		DRM_DEBUG("pid=%d, ret = %d\n", task_pid_nr(current), retcode);
 	return retcode;
 }
 EXPORT_SYMBOL(drm_ioctl);
-- 
2.15.0
