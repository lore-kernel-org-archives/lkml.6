Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758304AbeDXN6s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:58:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55764 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933397AbeDXNOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:14:48 -0400
X-Google-Smtp-Source: AIpwx48b9s1E8acHIDEa/Mo4ElaRHbVlUHWOyorD3YWemsrNQwglXzv5dMk7HSx5U7JwXNnC3IrULg==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bochs: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:14:45 +0200
Message-Id: <20180424131445.1861-1-luc.vanoostenryck@gmail.com>
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
 drivers/gpu/drm/bochs/bochs_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index a24a18fbd..233980a78 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -188,7 +188,7 @@ static int bochs_connector_get_modes(struct drm_connector *connector)
 	return count;
 }
 
-static int bochs_connector_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status bochs_connector_mode_valid(struct drm_connector *connector,
 				      struct drm_display_mode *mode)
 {
 	struct bochs_device *bochs =
-- 
2.17.0
