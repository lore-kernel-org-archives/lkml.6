Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933613AbeDXN4H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:56:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36456 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933369AbeDXNPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:11 -0400
X-Google-Smtp-Source: AIpwx4/E5KJfIZA9tDVaU6Nxh6kyesa0EoA9S9Kl32NZdJvcdV6hvhqNTSlu7LGg/tlXsi64+iRohA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, Peter Rosin <peda@axentia.se>,
        Sean Paul <seanpaul@chromium.org>, Keith Packard <keithp@keithp.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mathieu Larouche <mathieu.larouche@matrox.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/mgag200: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:15:06 +0200
Message-Id: <20180424131508.2210-1-luc.vanoostenryck@gmail.com>
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
 drivers/gpu/drm/mgag200/mgag200_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index fb50a9dda..8918539a1 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -1586,7 +1586,7 @@ static uint32_t mga_vga_calculate_mode_bandwidth(struct drm_display_mode *mode,
 
 #define MODE_BANDWIDTH	MODE_BAD
 
-static int mga_vga_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status mga_vga_mode_valid(struct drm_connector *connector,
 				 struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
-- 
2.17.0
