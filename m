Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeBWAAj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:00:39 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41594 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBWAAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:00:37 -0500
X-Google-Smtp-Source: AH8x227X9JQUfkRKkCwSpoYuPmo/+bsg2M74d4dB9LDBbZcgE1ivahaybshAP60W3ZcW5RyhZf3q/A==
Date: Thu, 22 Feb 2018 21:00:33 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 4/7] drm/virtio: Remove return from void function
Message-ID: <fd8dc6599c81c7aec6753c8552c1cabb7baa7577.1519343668.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

virtgpu_ttm.c:181: WARNING: void function return statements are not
generally useful
...

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_ttm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index 36655b709eb2..cd4a17a1409a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -177,7 +177,6 @@ static void ttm_bo_man_put_node(struct ttm_mem_type_manager *man,
 				struct ttm_mem_reg *mem)
 {
 	mem->mm_node = (void *)NULL;
-	return;
 }
 
 static int ttm_bo_man_init(struct ttm_mem_type_manager *man,
@@ -244,7 +243,6 @@ static void virtio_gpu_evict_flags(struct ttm_buffer_object *bo,
 	placement->busy_placement = &placements;
 	placement->num_placement = 1;
 	placement->num_busy_placement = 1;
-	return;
 }
 
 static int virtio_gpu_verify_access(struct ttm_buffer_object *bo,
-- 
2.16.2
