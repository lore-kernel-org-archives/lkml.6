Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753887AbeERIYl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:24:41 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:31370 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753843AbeERIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:24:38 -0400
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Mali DP Maintainers <malidp@foss.arm.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v7 4/5] drm/mali-dp: Add RGB writeback formats for DP500.
Date: Fri, 18 May 2018 09:24:22 +0100
Message-Id: <20180518082423.15500-5-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518082423.15500-1-Liviu.Dudau@arm.com>
References: <20180518082423.15500-1-Liviu.Dudau@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate the pixel format matrix for DP500 with the memory-write flag
for formats that are supported by the SE memwrite engine.

Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index d9a7f19c9f219..ea8b23aefe961 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -31,12 +31,12 @@ enum {
 
 static const struct malidp_format_id malidp500_de_formats[] = {
 	/*    fourcc,   layers supporting the format,     internal id  */
-	{ DRM_FORMAT_ARGB2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2,  0 },
-	{ DRM_FORMAT_ABGR2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2,  1 },
+	{ DRM_FORMAT_ARGB2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2 | SE_MEMWRITE,  0 },
+	{ DRM_FORMAT_ABGR2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2 | SE_MEMWRITE,  1 },
 	{ DRM_FORMAT_ARGB8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2,  2 },
 	{ DRM_FORMAT_ABGR8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2,  3 },
-	{ DRM_FORMAT_XRGB8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2,  4 },
-	{ DRM_FORMAT_XBGR8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2,  5 },
+	{ DRM_FORMAT_XRGB8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2 | SE_MEMWRITE,  4 },
+	{ DRM_FORMAT_XBGR8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2 | SE_MEMWRITE,  5 },
 	{ DRM_FORMAT_RGB888, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2,  6 },
 	{ DRM_FORMAT_BGR888, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2,  7 },
 	{ DRM_FORMAT_RGBA5551, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2,  8 },
@@ -45,7 +45,7 @@ static const struct malidp_format_id malidp500_de_formats[] = {
 	{ DRM_FORMAT_BGR565, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2, 11 },
 	{ DRM_FORMAT_UYVY, DE_VIDEO1, 12 },
 	{ DRM_FORMAT_YUYV, DE_VIDEO1, 13 },
-	{ DRM_FORMAT_NV12, DE_VIDEO1, 14 },
+	{ DRM_FORMAT_NV12, DE_VIDEO1 | SE_MEMWRITE, 14 },
 	{ DRM_FORMAT_YUV420, DE_VIDEO1, 15 },
 };
 
-- 
2.17.0
