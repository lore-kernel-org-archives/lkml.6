Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932746AbeCIXdg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:33:36 -0500
Received: from anholt.net ([50.246.234.109]:38342 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeCIXdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:33:35 -0500
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] drm/panel: simple: Fix the bus_format for the Ontat panel.
Date: Fri,  9 Mar 2018 15:33:32 -0800
Message-Id: <20180309233332.1769-1-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes bad color output.  When I was first testing the device I
had the DPI hardware set to 666 mode, but apparently in the refactor
to use the bus_format information from the panel driver, I failed to
actually update the panel.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: e8b6f561b2ee ("drm/panel: simple: Add the 7" DPI panel from Adafruit")
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5591984a392b..f9649bded63f 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1597,7 +1597,7 @@ static const struct panel_desc ontat_yx700wv03 = {
 		.width = 154,
 		.height = 83,
 	},
-	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
 static const struct drm_display_mode ortustech_com43h4m85ulc_mode  = {
-- 
2.16.2
