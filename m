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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D568AECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E66F2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjfbfMD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E66F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeJ0EBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:01:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36548 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeJ0EBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:01:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so2528898qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ephMQtX6szxfy2t+x3mOkjChAL/PNR6I3wnsrbkyA5A=;
        b=DjfbfMD/ftOJ/mUvI/0w7F6tukwaW7FdlXiwOtoKtDlmBPNxZqQ8lstpfTFQswzoK4
         VivmsYU943LUFD+FlFKyzUUcZhXYXuEgyKJ3OBpDQzD5j4Yz0BijETb5qTwcHD5gUj75
         /ybBcgwxcKiery2t20eLBHIvWW3SoAxRsQ6YMmqr7cQ70q1byuBWzgm1GS/er/cU/lYX
         3B6lHp5KHgACjwGTQT90nexa44EAfEklZBxDIMlei7zMXpRaSInvuyhxeq62M5aNCnph
         AhjKIgRmNpd7s6cpUPK2E/tuySi+7LqZtfAr7Tp5/3PosyAAhrJcC/JLw74ujLFKW67x
         V8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ephMQtX6szxfy2t+x3mOkjChAL/PNR6I3wnsrbkyA5A=;
        b=qmlfzr0p4s7W0tPIhWG6gNFUrBQ/2mh4mzt6/VNBEa/f9v1yTK6pX/FVDQWE2VVYe6
         0E30aQ2KLVvSU581jri0t40lOF7n4ozf82JUfRaZz5QfzKtfxNlpmE4qkgdXRl1LRkM2
         JToFQuMXHBCY82D2kPCaP1yFkeTitLd4Zpamtewg37hCX+0seW87pnfpRoOL8OZlMIwC
         OOQrmqH6H9WMQFAzqYurVGctLZrTeWAwiWRCMcIi445pwvQ293JtrtcXrnY+nLlN6KZF
         WRY+yU8UL76os5f/fl56xB5AMY+X0Kl7C227sUmRTsSHImqStM4ENUfqBgE3lYBA62H8
         EcAw==
X-Gm-Message-State: AGRZ1gJyc/d919X41xSq2WuE3wUTfKwDgxZgWIUB5wrDhcaHTWRBzuPX
        pj+KtHEe2TbCyCC8GAE5xUc=
X-Google-Smtp-Source: AJdET5d1pYi3SNmyoRhI/VFEGNUrCuynAv89DQzO2lnE6XyY7vh4ri0BEYc2YMNPRm9KdI0ZxYS6yQ==
X-Received: by 2002:ac8:6a0b:: with SMTP id t11-v6mr4555894qtr.360.1540581801109;
        Fri, 26 Oct 2018 12:23:21 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id x65-v6sm14647353qkg.72.2018.10.26.12.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:23:20 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:23:16 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 3/6] drm/qxl: Remove exceding whiteline
Message-ID: <5b95e1d4d515d02d01b829ddc5b3ca80af29e2e2.1540579956.git.shayenneluzmoura@gmail.com>
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

Remove extra whiteline to clean the checkpatch.pl check:

CHECK: Please don't use multiple blank lines

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_cmd.c     | 1 -
 drivers/gpu/drm/qxl/qxl_debugfs.c | 1 -
 drivers/gpu/drm/qxl/qxl_dev.h     | 1 -
 drivers/gpu/drm/qxl/qxl_display.c | 1 -
 drivers/gpu/drm/qxl/qxl_draw.c    | 1 -
 drivers/gpu/drm/qxl/qxl_drv.h     | 3 ---
 drivers/gpu/drm/qxl/qxl_kms.c     | 1 -
 drivers/gpu/drm/qxl/qxl_object.c  | 2 --
 drivers/gpu/drm/qxl/qxl_prime.c   | 1 -
 drivers/gpu/drm/qxl/qxl_release.c | 1 -
 drivers/gpu/drm/qxl/qxl_ttm.c     | 2 --
 11 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 25ec8e6544ee..6ec4b84a6bd4 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -369,7 +369,6 @@ void qxl_io_flush_surfaces(struct qxl_device *qdev)
 	wait_for_io_cmd(qdev, 0, QXL_IO_FLUSH_SURFACES_ASYNC);
 }
 
-
 void qxl_io_destroy_primary(struct qxl_device *qdev)
 {
 	wait_for_io_cmd(qdev, 0, QXL_IO_DESTROY_PRIMARY_ASYNC);
diff --git a/drivers/gpu/drm/qxl/qxl_debugfs.c b/drivers/gpu/drm/qxl/qxl_debugfs.c
index 15c84068d3fb..8c35b3433f00 100644
--- a/drivers/gpu/drm/qxl/qxl_debugfs.c
+++ b/drivers/gpu/drm/qxl/qxl_debugfs.c
@@ -34,7 +34,6 @@
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
-
 #if defined(CONFIG_DEBUG_FS)
 static int
 qxl_debugfs_irq_received(struct seq_file *m, void *data)
diff --git a/drivers/gpu/drm/qxl/qxl_dev.h b/drivers/gpu/drm/qxl/qxl_dev.h
index 94c5aec71920..a0ee41632d7e 100644
--- a/drivers/gpu/drm/qxl/qxl_dev.h
+++ b/drivers/gpu/drm/qxl/qxl_dev.h
@@ -28,7 +28,6 @@
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
-
 #ifndef H_QXL_DEV
 #define H_QXL_DEV
 
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index b7421dcdeeb6..f88dbfa4656a 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -960,7 +960,6 @@ static struct drm_encoder *qxl_best_encoder(struct drm_connector *connector)
 	return &qxl_output->enc;
 }
 
-
 static const struct drm_encoder_helper_funcs qxl_enc_helper_funcs = {
 };
 
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index ed08e9ec4827..a41d48eb1374 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -342,7 +342,6 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 	if (ret)
 		goto out_release_backoff;
 
-
 	ret = qxl_image_init(qdev, release, dimage, surface_base,
 			     left, top, width, height, depth, stride);
 	qxl_bo_kunmap(bo);
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 8ff70a7281a7..4b90f9bd7280 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -23,7 +23,6 @@
  *          Alon Levy
  */
 
-
 #ifndef QXL_DRV_H
 #define QXL_DRV_H
 
@@ -133,7 +132,6 @@ struct qxl_mman {
 	struct ttm_bo_device		bdev;
 };
 
-
 struct qxl_memslot {
 	uint8_t		generation;
 	uint64_t	start_phys_addr;
@@ -372,7 +370,6 @@ int qxl_mode_dumb_mmap(struct drm_file *filp,
 		       struct drm_device *dev,
 		       uint32_t handle, uint64_t *offset_p);
 
-
 /* qxl ttm */
 int qxl_ttm_init(struct qxl_device *qdev);
 void qxl_ttm_fini(struct qxl_device *qdev);
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index d1ba0ab1be82..f6975d7c7d10 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -285,7 +285,6 @@ int qxl_device_init(struct qxl_device *qdev,
 		 (unsigned long)qdev->surfaceram_base,
 		 (unsigned long)qdev->surfaceram_size);
 
-
 	INIT_WORK(&qdev->gc_work, qxl_gc_work);
 
 	return 0;
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index e1f2404b8f6f..18e67903b01b 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -74,7 +74,6 @@ void qxl_ttm_placement_from_domain(struct qxl_bo *qbo, u32 domain, bool pinned)
 	}
 }
 
-
 int qxl_bo_create(struct qxl_device *qdev,
 		  unsigned long size, bool kernel, bool pinned, u32 domain,
 		  struct qxl_surface *surf,
@@ -266,7 +265,6 @@ static int __qxl_bo_unpin(struct qxl_bo *bo)
 	return r;
 }
 
-
 /*
  * Reserve the BO before pinning the object.  If the BO was reserved
  * beforehand, use the internal version directly __qxl_bo_pin.
diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
index 9f029dda1f07..a55dece118b2 100644
--- a/drivers/gpu/drm/qxl/qxl_prime.c
+++ b/drivers/gpu/drm/qxl/qxl_prime.c
@@ -38,7 +38,6 @@ void qxl_gem_prime_unpin(struct drm_gem_object *obj)
 	WARN_ONCE(1, "not implemented");
 }
 
-
 struct sg_table *qxl_gem_prime_get_sg_table(struct drm_gem_object *obj)
 {
 	WARN_ONCE(1, "not implemented");
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index a8d5457a1af9..3813ec198900 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -282,7 +282,6 @@ void qxl_release_backoff_reserve_list(struct qxl_release *release)
 	ttm_eu_backoff_reservation(&release->ticket, &release->bos);
 }
 
-
 int qxl_alloc_surface_release_reserved(struct qxl_device *qdev,
 				       enum qxl_surface_cmd_type surface_cmd_type,
 				       struct qxl_release *create_rel,
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 86a1fb32f6db..1824ff3ef2a5 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -331,7 +331,6 @@ static int qxl_bo_move(struct ttm_buffer_object *bo, bool evict,
 	if (ret)
 		return ret;
 
-
 	if (old_mem->mem_type == TTM_PL_SYSTEM && bo->ttm == NULL) {
 		qxl_move_null(bo, new_mem);
 		return 0;
@@ -418,7 +417,6 @@ void qxl_ttm_fini(struct qxl_device *qdev)
 	DRM_INFO("qxl: ttm finalized\n");
 }
 
-
 #define QXL_DEBUGFS_MEM_TYPES 2
 
 #if defined(CONFIG_DEBUG_FS)
-- 
2.19.1

