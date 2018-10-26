Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D94ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D88520868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWW6wj3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D88520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJ0EBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:01:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46785 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeJ0EBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:01:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id c16-v6so2484919qtj.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bKcX80lQXDdmu5r13AK26upe74/ntuER0HZxy3FtDKU=;
        b=uWW6wj3DjIcQhFBj9VMLViOff4pQsNTcRbHTKzM+ZDHi5AJL2xP5M2o8lekZCa7JtD
         ap45vd8DZXXKC/PCMxz764BjquloKp8PLjYo6E34uYIQIqh6L63/zt3kKy4gI1RCRT/Q
         sZ6dnzjHOThMb5BqcEZdZgiB4csGcbqvjDX024GLNCRswvr0iAUIFjGHQlkc9waEBQiu
         zL9Y3Ran5FpYcfllsiKuYohshL9OtbElUTrpHmAgeP5bPDfLsw+LxITs6ofPbjiKAcSs
         LUU5elKauSDGkhpZkwNT9Fztb27NMc436F+Z6QhfNG6rYJxGTrLiJMqihg37mk0MYbXz
         bMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bKcX80lQXDdmu5r13AK26upe74/ntuER0HZxy3FtDKU=;
        b=HvMGhI9Rkc2OSz7XRrCix/4RORTyNmQ71iTW/UXq6QHkbzYo7JIrFKM+2HD2r44nPa
         LRSVHm7WkoMCLBg7M5W6gSGymUHJ8yEsc0TFHPtJYJfMMLpJur2yRdTZ0lZ9YfTbAcbu
         QVKLj5LLfqQ/Ii0bG4lBS0wppsBmVr0PgVodPdDYITRplzWEl77iLmyVEbsOF2Ep7jlB
         Y/AktJ1BX0ygWyJMto6LDvwgVHPjIF3HwO6K7JrA3cbyvdKto0MboCTg6ETwMb4o5Yjp
         tMO5dGOGrzKaRs0IomtLk7kHddfymwmyLwAfKUDB1QQ3bV270BO5bLJO0m0LFbf6j7Ti
         RViw==
X-Gm-Message-State: AGRZ1gK/51ojwZ2o9bYnOdGU3XdY63H/EzpfhU4AvF5NWjuEkyfQuCns
        zG7ICq7VP/BU8WLF6mm2PUs=
X-Google-Smtp-Source: AJdET5d+JxSCoTWy4Ef6KLzRw1exntUCvcSLImukirRfj/jLRN2tuEEUtXf88zACg5IeLZBxJCuGqw==
X-Received: by 2002:a0c:aa4e:: with SMTP id e14-v6mr3520280qvb.158.1540581780135;
        Fri, 26 Oct 2018 12:23:00 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id f11-v6sm6759982qkb.47.2018.10.26.12.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:22:59 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:22:55 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 2/6] drm/qxl: Add line after variable declarations
Message-ID: <a1d44c4a30f9b52d0aa7113e4e5093e843f9913b.1540579956.git.shayenneluzmoura@gmail.com>
References: <cover.1540579956.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540579956.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add whiteline after variable declarations to remove the checkpath.pl
warning:

WARNING: Missing a blank line after declarations

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_cmd.c     | 4 ++++
 drivers/gpu/drm/qxl/qxl_display.c | 2 ++
 drivers/gpu/drm/qxl/qxl_draw.c    | 2 ++
 drivers/gpu/drm/qxl/qxl_dumb.c    | 1 +
 drivers/gpu/drm/qxl/qxl_image.c   | 2 ++
 drivers/gpu/drm/qxl/qxl_ioctl.c   | 2 ++
 drivers/gpu/drm/qxl/qxl_kms.c     | 1 +
 drivers/gpu/drm/qxl/qxl_object.c  | 1 +
 drivers/gpu/drm/qxl/qxl_object.h  | 2 ++
 9 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 208af9f37914..25ec8e6544ee 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -84,6 +84,7 @@ static int qxl_check_header(struct qxl_ring *ring)
 	int ret;
 	struct qxl_ring_header *header = &(ring->ring->header);
 	unsigned long flags;
+
 	spin_lock_irqsave(&ring->lock, flags);
 	ret = header->prod - header->cons < header->num_items;
 	if (ret == 0)
@@ -97,6 +98,7 @@ int qxl_check_idle(struct qxl_ring *ring)
 	int ret;
 	struct qxl_ring_header *header = &(ring->ring->header);
 	unsigned long flags;
+
 	spin_lock_irqsave(&ring->lock, flags);
 	ret = header->prod == header->cons;
 	spin_unlock_irqrestore(&ring->lock, flags);
@@ -110,6 +112,7 @@ int qxl_ring_push(struct qxl_ring *ring,
 	uint8_t *elt;
 	int idx, ret;
 	unsigned long flags;
+
 	spin_lock_irqsave(&ring->lock, flags);
 	if (header->prod - header->cons == header->num_items) {
 		header->notify_on_cons = header->cons + 1;
@@ -156,6 +159,7 @@ static bool qxl_ring_pop(struct qxl_ring *ring,
 	volatile uint8_t *ring_elt;
 	int idx;
 	unsigned long flags;
+
 	spin_lock_irqsave(&ring->lock, flags);
 	if (header->cons == header->prod) {
 		header->notify_on_prod = header->cons + 1;
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 87d16a0ce01e..b7421dcdeeb6 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -259,6 +259,7 @@ static int qxl_add_common_modes(struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	struct drm_display_mode *mode = NULL;
 	int i;
+
 	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h,
 				    60, false, false, false);
@@ -315,6 +316,7 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 	oldcount = qdev->monitors_config->count;
 	if (crtc->state->active) {
 		struct drm_display_mode *mode = &crtc->mode;
+
 		head.width = mode->hdisplay;
 		head.height = mode->vdisplay;
 		head.x = crtc->x;
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index cc5b32e749ce..ed08e9ec4827 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -168,6 +168,7 @@ void qxl_draw_opaque_fb(const struct qxl_fb_image *qxl_fb_image,
 	int ret;
 	struct qxl_drm_image *dimage;
 	struct qxl_bo *palette_bo = NULL;
+
 	if (stride == 0)
 		stride = depth * width / 8;
 
@@ -214,6 +215,7 @@ void qxl_draw_opaque_fb(const struct qxl_fb_image *qxl_fb_image,
 
 	if (depth == 1) {
 		void *ptr;
+
 		ret = qxl_palette_create_1bit(palette_bo, release, qxl_fb_image);
 
 		ptr = qxl_bo_kmap_atomic_page(qdev, dimage->bo, 0);
diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
index 089e5fcf80e0..e3765739c396 100644
--- a/drivers/gpu/drm/qxl/qxl_dumb.c
+++ b/drivers/gpu/drm/qxl/qxl_dumb.c
@@ -38,6 +38,7 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 	int r;
 	struct qxl_surface surf;
 	uint32_t pitch, format;
+
 	pitch = args->width * ((args->bpp + 1) / 8);
 	args->size = pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
diff --git a/drivers/gpu/drm/qxl/qxl_image.c b/drivers/gpu/drm/qxl/qxl_image.c
index 7fbcc35e8ad3..13b9a18ccde5 100644
--- a/drivers/gpu/drm/qxl/qxl_image.c
+++ b/drivers/gpu/drm/qxl/qxl_image.c
@@ -136,6 +136,7 @@ qxl_image_init_helper(struct qxl_device *qdev,
 		int remain;
 		int page;
 		int size;
+
 		if (stride == linesize && chunk_stride == stride) {
 			remain = linesize * height;
 			page = 0;
@@ -163,6 +164,7 @@ qxl_image_init_helper(struct qxl_device *qdev,
 			}
 		} else {
 			unsigned page_base, page_offset, out_offset;
+
 			for (i = 0 ; i < height ; ++i) {
 				i_data = (void *)data + i * stride;
 				remain = linesize;
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 6cc9f3367fa0..6e828158bcb0 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -85,6 +85,7 @@ static void
 apply_reloc(struct qxl_device *qdev, struct qxl_reloc_info *info)
 {
 	void *reloc_page;
+
 	reloc_page = qxl_bo_kmap_atomic_page(qdev, info->dst_bo, info->dst_offset & PAGE_MASK);
 	*(uint64_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) = qxl_bo_physical_address(qdev,
 											      info->src_bo,
@@ -189,6 +190,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 
 	{
 		struct qxl_drawable *draw = fb_cmd;
+
 		draw->mm_time = qdev->rom->mm_clock;
 	}
 
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index e25c589d5f50..d1ba0ab1be82 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -92,6 +92,7 @@ void qxl_reinit_memslots(struct qxl_device *qdev)
 static void qxl_gc_work(struct work_struct *work)
 {
 	struct qxl_device *qdev = container_of(work, struct qxl_device, gc_work);
+
 	qxl_garbage_collect(qdev);
 }
 
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 6a30196e9d6c..e1f2404b8f6f 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -335,6 +335,7 @@ void qxl_bo_fini(struct qxl_device *qdev)
 int qxl_bo_check_id(struct qxl_device *qdev, struct qxl_bo *bo)
 {
 	int ret;
+
 	if (bo->type == QXL_GEM_DOMAIN_SURFACE && bo->surface_id == 0) {
 		/* allocate a surface id for this surface now */
 		ret = qxl_surface_id_alloc(qdev, bo);
diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl_object.h
index 0374fd93f4d6..b40fc9a10406 100644
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -35,6 +35,7 @@ static inline int qxl_bo_reserve(struct qxl_bo *bo, bool no_wait)
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS) {
 			struct drm_device *ddev = bo->gem_base.dev;
+
 			dev_err(ddev->dev, "%p reserve failed\n", bo);
 		}
 		return r;
@@ -71,6 +72,7 @@ static inline int qxl_bo_wait(struct qxl_bo *bo, u32 *mem_type,
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS) {
 			struct drm_device *ddev = bo->gem_base.dev;
+
 			dev_err(ddev->dev, "%p reserve failed for wait\n",
 				bo);
 		}
-- 
2.19.1

