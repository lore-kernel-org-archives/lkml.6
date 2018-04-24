Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbeDXNzB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:55:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37782 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933499AbeDXNPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:24 -0400
X-Google-Smtp-Source: AIpwx4/DDgGiYXw+/3u1NJHh4HZoQGTrmB68mOEP+HKIMEft+pVFJEwcsae3dqwsPHnUrWIeaeB5gw==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i2c: tda998x: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:15:21 +0200
Message-Id: <20180424131522.2460-1-luc.vanoostenryck@gmail.com>
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
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 9e67a7b4e..421c8a723 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1106,7 +1106,7 @@ static int tda998x_connector_get_modes(struct drm_connector *connector)
 	return n;
 }
 
-static int tda998x_connector_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status tda998x_connector_mode_valid(struct drm_connector *connector,
 					struct drm_display_mode *mode)
 {
 	/* TDA19988 dotclock can go up to 165MHz */
-- 
2.17.0
