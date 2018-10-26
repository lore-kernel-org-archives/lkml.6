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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B99ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8569A20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4qzKfgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8569A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeJ0ECN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:02:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33953 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJ0ECN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:02:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id a132so1380207qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0sRGfOrS7j7KNmQkSeou1HwAcHYhY3KQCIvUbukYRWQ=;
        b=t4qzKfgCqaSYnVuUfxHKCtDBIEJNmrXnrkD/dj8jQMPXSFboHuEupsR4TDu5EjIID9
         O3uKR68y45SO9qDkytMnd57kwTBo/RKB9raCEB+CkAsJmkGrvIKT1W1cznNrUuFng7C1
         oBWn7V9CGhY36o+hCig4wLKCBd+IswkFbJsJ6fxamKO/74Aa3eSmZ3cwQufKevkHW23A
         O1gAmuCz5KjOcNda7eGTZ6Aw0BnoB/SaanlFOhdsuFX7wuNYd1L4MEUZ/ESJLA+mpp3H
         20qJDUldmKmuyvemIP4UGFX3Vq5mQaG1VJgA3wFgzino3C8OCpiPvO+WvAGzHAe6v5GE
         VwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0sRGfOrS7j7KNmQkSeou1HwAcHYhY3KQCIvUbukYRWQ=;
        b=ehk97x614XK2tOhD1sIctUvgdCODKR0SC1kbKkdK6juE2IclbqEdQM+4INLby8Uvwy
         KQRoPDTbOpXM7MKY7viGoBt1nO3kvjdsJJjCD1HoVYPnbgBsCLTa1yLjLWdieSOQwZrp
         NX0e9dzFA3W8iyylhdYdZBgbbzwdAlvtbhmSqEUYdOciRqXjg13BGkN5yis56IG2y6A7
         JqO86k5AfEvr1mKb9OXlw3v/2WiElLGSxm4j0Vs/YFXgbiDdPPJYJXc+wXYRMMh1NXue
         bx47/PySEv28i8AXLU+lmkYZsxQF3jhfrYYWsexY/GUgkDBR/hIsPLjG+rgx/FMbdjHD
         9oaA==
X-Gm-Message-State: AGRZ1gIt0QS0xsiZRTAkRLFMrTaBnRAw3EqXZyEZm692J+oikks3/D8v
        6pIvahwBd+Tu4PbPHe9ZplvXC8EwB38=
X-Google-Smtp-Source: AJdET5cNpPRRtuWunWA70eRRhFJB0xgqN6jHsEwLvdrjchHkjJZSNBwUhsW6OptYcfcZUz7AMEWTmg==
X-Received: by 2002:a37:c94:: with SMTP id 142-v6mr4010310qkm.51.1540581834413;
        Fri, 26 Oct 2018 12:23:54 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id z3-v6sm8607898qka.61.2018.10.26.12.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:23:53 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:23:49 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 4/6] drm/qxl: Use 'unsigned int' instead of 'usigned'
Message-ID: <52604806eb18bc25e7e429f5b229fe8c1d271b5c.1540579956.git.shayenneluzmoura@gmail.com>
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

Use 'usigned int' instead of 'usigned' to remove the checkpath.pl warning:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_cmd.c     |  2 +-
 drivers/gpu/drm/qxl/qxl_debugfs.c |  4 ++--
 drivers/gpu/drm/qxl/qxl_display.c | 12 ++++++------
 drivers/gpu/drm/qxl/qxl_draw.c    |  8 ++++----
 drivers/gpu/drm/qxl/qxl_drv.h     | 18 +++++++++---------
 drivers/gpu/drm/qxl/qxl_fb.c      |  4 ++--
 drivers/gpu/drm/qxl/qxl_image.c   |  2 +-
 drivers/gpu/drm/qxl/qxl_object.c  |  2 +-
 drivers/gpu/drm/qxl/qxl_ttm.c     | 10 +++++-----
 9 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 6ec4b84a6bd4..dffc5093ff16 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -376,7 +376,7 @@ void qxl_io_destroy_primary(struct qxl_device *qdev)
 }
 
 void qxl_io_create_primary(struct qxl_device *qdev,
-			   unsigned offset, struct qxl_bo *bo)
+			   unsigned int offset, struct qxl_bo *bo)
 {
 	struct qxl_surface_create *create;
 
diff --git a/drivers/gpu/drm/qxl/qxl_debugfs.c b/drivers/gpu/drm/qxl/qxl_debugfs.c
index 8c35b3433f00..118422549828 100644
--- a/drivers/gpu/drm/qxl/qxl_debugfs.c
+++ b/drivers/gpu/drm/qxl/qxl_debugfs.c
@@ -101,9 +101,9 @@ qxl_debugfs_init(struct drm_minor *minor)
 
 int qxl_debugfs_add_files(struct qxl_device *qdev,
 			  struct drm_info_list *files,
-			  unsigned nfiles)
+			  unsigned int nfiles)
 {
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < qdev->debugfs_count; i++) {
 		if (qdev->debugfs[i].files == files) {
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index f88dbfa4656a..5b00e0f26de1 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -253,8 +253,8 @@ static struct mode_size {
 };
 
 static int qxl_add_common_modes(struct drm_connector *connector,
-                                unsigned pwidth,
-                                unsigned pheight)
+                                unsigned int pwidth,
+                                unsigned int pheight)
 {
 	struct drm_device *dev = connector->dev;
 	struct drm_display_mode *mode = NULL;
@@ -393,9 +393,9 @@ static const struct drm_crtc_funcs qxl_crtc_funcs = {
 
 static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 					 struct drm_file *file_priv,
-					 unsigned flags, unsigned color,
+					 unsigned int flags, unsigned int color,
 					 struct drm_clip_rect *clips,
-					 unsigned num_clips)
+					 unsigned int num_clips)
 {
 	/* TODO: vmwgfx where this was cribbed from had locking. Why? */
 	struct qxl_device *qdev = fb->dev->dev_private;
@@ -919,8 +919,8 @@ static int qdev_crtc_init(struct drm_device *dev, int crtc_id)
 
 static int qxl_conn_get_modes(struct drm_connector *connector)
 {
-	unsigned pwidth = 1024;
-	unsigned pheight = 768;
+	unsigned int pwidth = 1024;
+	unsigned int pheight = 768;
 	int ret = 0;
 
 	ret = qxl_add_monitors_config_modes(connector, &pwidth, &pheight);
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index a41d48eb1374..c34e45662965 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -25,7 +25,7 @@
 
 static int alloc_clips(struct qxl_device *qdev,
 		       struct qxl_release *release,
-		       unsigned num_clips,
+		       unsigned int num_clips,
 		       struct qxl_bo **clips_bo)
 {
 	int size = sizeof(struct qxl_clip_rects) + sizeof(struct qxl_rect) * num_clips;
@@ -37,7 +37,7 @@ static int alloc_clips(struct qxl_device *qdev,
  * the qxl_clip_rects. This is *not* the same as the memory allocated
  * on the device, it is offset to qxl_clip_rects.chunk.data */
 static struct qxl_rect *drawable_set_clipping(struct qxl_device *qdev,
-					      unsigned num_clips,
+					      unsigned int num_clips,
 					      struct qxl_bo *clips_bo)
 {
 	struct qxl_clip_rects *dev_clips;
@@ -266,9 +266,9 @@ void qxl_draw_opaque_fb(const struct qxl_fb_image *qxl_fb_image,
 void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       struct drm_framebuffer *fb,
 		       struct qxl_bo *bo,
-		       unsigned flags, unsigned color,
+		       unsigned int flags, unsigned int color,
 		       struct drm_clip_rect *clips,
-		       unsigned num_clips, int inc)
+		       unsigned int num_clips, int inc)
 {
 	/*
 	 * TODO: if flags & DRM_MODE_FB_DIRTY_ANNOTATE_FILL then we should
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 4b90f9bd7280..d78bcb95df3e 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -82,7 +82,7 @@ struct qxl_bo {
 	struct ttm_placement		placement;
 	struct ttm_buffer_object	tbo;
 	struct ttm_bo_kmap_obj		kmap;
-	unsigned			pin_count;
+	unsigned int pin_count;
 	void				*kptr;
 	int                             type;
 
@@ -189,12 +189,12 @@ struct qxl_draw_fill {
  */
 struct qxl_debugfs {
 	struct drm_info_list	*files;
-	unsigned		num_files;
+	unsigned int num_files;
 };
 
 int qxl_debugfs_add_files(struct qxl_device *rdev,
 			     struct drm_info_list *files,
-			     unsigned nfiles);
+			     unsigned int nfiles);
 int qxl_debugfs_fence_init(struct qxl_device *rdev);
 
 struct qxl_device;
@@ -252,7 +252,7 @@ struct qxl_device {
 	atomic_t irq_received_display;
 	atomic_t irq_received_cursor;
 	atomic_t irq_received_io_cmd;
-	unsigned irq_received_error;
+	unsigned int irq_received_error;
 	wait_queue_head_t display_event;
 	wait_queue_head_t cursor_event;
 	wait_queue_head_t io_cmd_event;
@@ -260,7 +260,7 @@ struct qxl_device {
 
 	/* debugfs */
 	struct qxl_debugfs	debugfs[QXL_DEBUGFS_MAX_COMPONENTS];
-	unsigned		debugfs_count;
+	unsigned int debugfs_count;
 
 	struct mutex		update_area_mutex;
 
@@ -395,7 +395,7 @@ void qxl_update_screen(struct qxl_device *qxl);
 /* qxl io operations (qxl_cmd.c) */
 
 void qxl_io_create_primary(struct qxl_device *qdev,
-			   unsigned offset,
+			   unsigned int offset,
 			   struct qxl_bo *bo);
 void qxl_io_destroy_primary(struct qxl_device *qdev);
 void qxl_io_memslot_add(struct qxl_device *qdev, uint8_t id);
@@ -446,9 +446,9 @@ void qxl_draw_opaque_fb(const struct qxl_fb_image *qxl_fb_image,
 void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       struct drm_framebuffer *fb,
 		       struct qxl_bo *bo,
-		       unsigned flags, unsigned color,
+		       unsigned int flags, unsigned int color,
 		       struct drm_clip_rect *clips,
-		       unsigned num_clips, int inc);
+		       unsigned int num_clips, int inc);
 
 void qxl_draw_fill(struct qxl_draw_fill *qxl_draw_fill_rec);
 
@@ -493,7 +493,7 @@ bool qxl_fbdev_qobj_is_fb(struct qxl_device *qdev, struct qxl_bo *qobj);
 
 int qxl_debugfs_add_files(struct qxl_device *qdev,
 			  struct drm_info_list *files,
-			  unsigned nfiles);
+			  unsigned int nfiles);
 
 int qxl_surface_id_alloc(struct qxl_device *qdev,
 			 struct qxl_bo *surf);
diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index 2294b7f14fdf..7e047c985ea6 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -134,9 +134,9 @@ static int qxlfb_create_pinned_object(struct qxl_device *qdev,
  */
 static int qxlfb_framebuffer_dirty(struct drm_framebuffer *fb,
 				   struct drm_file *file_priv,
-				   unsigned flags, unsigned color,
+				   unsigned int flags, unsigned int color,
 				   struct drm_clip_rect *clips,
-				   unsigned num_clips)
+				   unsigned int num_clips)
 {
 	struct qxl_device *qdev = fb->dev->dev_private;
 	struct fb_info *info = qdev->fb_helper.fbdev;
diff --git a/drivers/gpu/drm/qxl/qxl_image.c b/drivers/gpu/drm/qxl/qxl_image.c
index 13b9a18ccde5..43688ecdd8a0 100644
--- a/drivers/gpu/drm/qxl/qxl_image.c
+++ b/drivers/gpu/drm/qxl/qxl_image.c
@@ -163,7 +163,7 @@ qxl_image_init_helper(struct qxl_device *qdev,
 				page++;
 			}
 		} else {
-			unsigned page_base, page_offset, out_offset;
+			unsigned int page_base, page_offset, out_offset;
 
 			for (i = 0 ; i < height ; ++i) {
 				i_data = (void *)data + i * stride;
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 18e67903b01b..f67a3c535afb 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -54,7 +54,7 @@ void qxl_ttm_placement_from_domain(struct qxl_bo *qbo, u32 domain, bool pinned)
 {
 	u32 c = 0;
 	u32 pflag = pinned ? TTM_PL_FLAG_NO_EVICT : 0;
-	unsigned i;
+	unsigned int i;
 
 	qbo->placement.placement = qbo->placements;
 	qbo->placement.busy_placement = qbo->placements;
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 1824ff3ef2a5..559a10113837 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -174,7 +174,7 @@ static int qxl_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 		man->default_caching = TTM_PL_FLAG_CACHED;
 		break;
 	default:
-		DRM_ERROR("Unsupported memory type %u\n", (unsigned)type);
+		DRM_ERROR("Unsupported memory type %u\n", (unsigned int)type);
 		return -EINVAL;
 	}
 	return 0;
@@ -400,11 +400,11 @@ int qxl_ttm_init(struct qxl_device *qdev)
 		return r;
 	}
 	DRM_INFO("qxl: %uM of VRAM memory size\n",
-		 (unsigned)qdev->vram_size / (1024 * 1024));
+		 (unsigned int)qdev->vram_size / (1024 * 1024));
 	DRM_INFO("qxl: %luM of IO pages memory ready (VRAM domain)\n",
-		 ((unsigned)num_io_pages * PAGE_SIZE) / (1024 * 1024));
+		 ((unsigned int)num_io_pages * PAGE_SIZE) / (1024 * 1024));
 	DRM_INFO("qxl: %uM of Surface memory size\n",
-		 (unsigned)qdev->surfaceram_size / (1024 * 1024));
+		 (unsigned int)qdev->surfaceram_size / (1024 * 1024));
 	return 0;
 }
 
@@ -441,7 +441,7 @@ int qxl_ttm_debugfs_init(struct qxl_device *qdev)
 #if defined(CONFIG_DEBUG_FS)
 	static struct drm_info_list qxl_mem_types_list[QXL_DEBUGFS_MEM_TYPES];
 	static char qxl_mem_types_names[QXL_DEBUGFS_MEM_TYPES][32];
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0; i < QXL_DEBUGFS_MEM_TYPES; i++) {
 		if (i == 0)
-- 
2.19.1

