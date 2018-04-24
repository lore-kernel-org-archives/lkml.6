Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933516AbeDXNPc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:15:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33105 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932707AbeDXNP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:26 -0400
X-Google-Smtp-Source: AIpwx4+A3OMG6vjdakdELDykn1vIFYtWnaeVggKJS2QNAoEUnfZ4Mai3CF0JfilGgs/KZD5FMhDkJQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] drm/virtio: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:15:24 +0200
Message-Id: <20180424131524.2510-1-luc.vanoostenryck@gmail.com>
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
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 8cc8c34d6..a5edd8660 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -208,7 +208,7 @@ static int virtio_gpu_conn_get_modes(struct drm_connector *connector)
 	return count;
 }
 
-static int virtio_gpu_conn_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status virtio_gpu_conn_mode_valid(struct drm_connector *connector,
 				      struct drm_display_mode *mode)
 {
 	struct virtio_gpu_output *output =
-- 
2.17.0
