Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933508AbeDXNP0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:15:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36477 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933484AbeDXNPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:18 -0400
X-Google-Smtp-Source: AIpwx4+0sFSIOpJHB8Ytoi0YCwPAGITnTqbC5mjrUDd8oVF/yuEVsjcAvKC5skAWm48aS9iiBuA5cg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/qxl: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:15:15 +0200
Message-Id: <20180424131515.2360-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method struct drm_connector_helper_funcs::mode_valid is defined
as returning an 'enum drm_mode_status' but the driver implementation
for this method uses an 'int' for it.

Fix this by using 'enum drm_mode_status' in the driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index ecb35ed0e..820cbca3b 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1037,7 +1037,7 @@ static int qxl_conn_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static int qxl_conn_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status qxl_conn_mode_valid(struct drm_connector *connector,
 			       struct drm_display_mode *mode)
 {
 	struct drm_device *ddev = connector->dev;
-- 
2.17.0
