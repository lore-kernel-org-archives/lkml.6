Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBWAAG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:00:06 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44060 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeBWAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:00:04 -0500
X-Google-Smtp-Source: AH8x2255pi93CFN2BoIYQwsPbnVXDpf5eVKCjq4wnr9r/vnX7XV5mwt9VC87SVwdkYI7mTHQQK3woA==
Date: Thu, 22 Feb 2018 21:00:00 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/7] drm/virtio: Add blank line after variable declarations
Message-ID: <41767852ff9dc584c825e32db6222b9a311603b9.1519343668.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warnings:

virtgpu_drv.c:57: WARNING: Missing a blank line after declarations
virtgpu_display.c:99: WARNING: Missing a blank line after declarations
...

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 1 +
 drivers/gpu/drm/virtio/virtgpu_drv.c     | 1 +
 drivers/gpu/drm/virtio/virtgpu_fb.c      | 4 ++++
 drivers/gpu/drm/virtio/virtgpu_gem.c     | 1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 2 ++
 drivers/gpu/drm/virtio/virtgpu_vq.c      | 3 +++
 6 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 22513d7f895c..2d1b25630c0e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -96,6 +96,7 @@ virtio_gpu_framebuffer_init(struct drm_device *dev,
 {
 	int ret;
 	struct virtio_gpu_object *bo;
+
 	vgfb->obj = obj;
 
 	bo = gem_to_virtio_gpu_obj(obj);
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 49a3d8d5a249..5d21433b1cdf 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -54,6 +54,7 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 static void virtio_gpu_remove(struct virtio_device *vdev)
 {
 	struct drm_device *dev = vdev->priv;
+
 	drm_put_dev(dev);
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index 15d18fd0c64b..b933cbba0685 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -127,6 +127,7 @@ int virtio_gpu_surface_dirty(struct virtio_gpu_framebuffer *vgfb,
 	int left, right, top, bottom;
 	int i;
 	int inc = 1;
+
 	if (!num_clips) {
 		num_clips = 1;
 		clips = &norect;
@@ -172,6 +173,7 @@ static void virtio_gpu_3d_fillrect(struct fb_info *info,
 				   const struct fb_fillrect *rect)
 {
 	struct virtio_gpu_fbdev *vfbdev = info->par;
+
 	drm_fb_helper_sys_fillrect(info, rect);
 	virtio_gpu_dirty_update(&vfbdev->vgfb, true, rect->dx, rect->dy,
 			     rect->width, rect->height);
@@ -182,6 +184,7 @@ static void virtio_gpu_3d_copyarea(struct fb_info *info,
 				   const struct fb_copyarea *area)
 {
 	struct virtio_gpu_fbdev *vfbdev = info->par;
+
 	drm_fb_helper_sys_copyarea(info, area);
 	virtio_gpu_dirty_update(&vfbdev->vgfb, true, area->dx, area->dy,
 			   area->width, area->height);
@@ -192,6 +195,7 @@ static void virtio_gpu_3d_imageblit(struct fb_info *info,
 				    const struct fb_image *image)
 {
 	struct virtio_gpu_fbdev *vfbdev = info->par;
+
 	drm_fb_helper_sys_imageblit(info, image);
 	virtio_gpu_dirty_update(&vfbdev->vgfb, true, image->dx, image->dy,
 			     image->width, image->height);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 92fb27753b9e..0f2768eacaee 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -124,6 +124,7 @@ int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
 {
 	struct drm_gem_object *gobj;
 	struct virtio_gpu_object *obj;
+
 	BUG_ON(!offset_p);
 	gobj = drm_gem_object_lookup(file_priv, handle);
 	if (gobj == NULL)
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 5720a0d4ac0a..86243f131fc1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -83,6 +83,7 @@ static void virtio_gpu_unref_list(struct list_head *head)
 	struct ttm_validate_buffer *buf;
 	struct ttm_buffer_object *bo;
 	struct virtio_gpu_object *qobj;
+
 	list_for_each_entry(buf, head, head) {
 		bo = buf->bo;
 		qobj = container_of(bo, struct virtio_gpu_object, tbo);
@@ -478,6 +479,7 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 	int ret;
 	struct virtio_gpu_drv_cap_cache *cache_ent;
 	void *ptr;
+
 	if (vgdev->num_capsets == 0)
 		return -ENOSYS;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 9eb96fb2c147..16c05bc34bef 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -62,6 +62,7 @@ void virtio_gpu_ctrl_ack(struct virtqueue *vq)
 {
 	struct drm_device *dev = vq->vdev->priv;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
+
 	schedule_work(&vgdev->ctrlq.dequeue_work);
 }
 
@@ -69,6 +70,7 @@ void virtio_gpu_cursor_ack(struct virtqueue *vq)
 {
 	struct drm_device *dev = vq->vdev->priv;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
+
 	schedule_work(&vgdev->cursorq.dequeue_work);
 }
 
@@ -852,6 +854,7 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 
 	if (!obj->pages) {
 		int ret;
+
 		ret = virtio_gpu_object_get_sg_table(vgdev, obj);
 		if (ret)
 			return ret;
-- 
2.16.2
