Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbeDYMLP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:11:15 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37482 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeDYMLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:11:09 -0400
X-Google-Smtp-Source: AIpwx4/ToWG9T+u8+KJ9RceA5myEyyBHsvt93Id1EeXnF8Ron9FhUZKl+gQA6XI0Vcxi6ZL4ayjc+A==
From: Vaishali Thakkar <vthakkar1994@gmail.com>
To: laurent.pinchart@ideasonboard.com
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] drm: rcar-du: Use drm_dev_put
Date: Wed, 25 Apr 2018 17:40:36 +0530
Message-Id: <20180425121036.28965-1-vthakkar1994@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As specified in drm_drv.c, drm_dev_unref is a compatibility alias
for drm_dev_put and shouldn't be used in new code. So, use
drm_dev_put instead.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 05745e86d73e..418a80e6b2f4 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -378,7 +378,7 @@ static int rcar_du_remove(struct platform_device *pdev)
 	drm_kms_helper_poll_fini(ddev);
 	drm_mode_config_cleanup(ddev);
 
-	drm_dev_unref(ddev);
+	drm_dev_put(ddev);
 
 	return 0;
 }
-- 
2.14.1
