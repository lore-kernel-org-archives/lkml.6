Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UPPERCASE_50_75,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7587DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F222089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F222089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934254AbeFLOJd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:09:33 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:18861 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933584AbeFLOIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:08:36 -0400
Received: from e110455-lin.cambridge.arm.com (e110455-lin.cambridge.arm.com [10.2.131.61])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id w5CE8DwQ031673;
        Tue, 12 Jun 2018 15:08:18 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Mali DP Maintainers <malidp@foss.arm.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v8 2/5] drm: mali-dp: Add RGB writeback formats for DP550/DP650
Date:   Tue, 12 Jun 2018 15:08:10 +0100
Message-Id: <20180612140813.20419-3-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612140813.20419-1-Liviu.Dudau@arm.com>
References: <20180612140813.20419-1-Liviu.Dudau@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Starkey <brian.starkey@arm.com>

Add a layer bit for the SE memory-write, and add it to the pixel format
matrix for DP550/DP650.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
[rebased and fixed conflicts]
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c | 22 +++++++++++-----------
 drivers/gpu/drm/arm/malidp_hw.h |  1 +
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 7a48a0defd90a..dd3a15964c588 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -47,27 +47,27 @@ static const struct malidp_format_id malidp500_de_formats[] = {
 
 #define MALIDP_COMMON_FORMATS \
 	/*    fourcc,   layers supporting the format,      internal id   */ \
-	{ DRM_FORMAT_ARGB2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(0, 0) }, \
-	{ DRM_FORMAT_ABGR2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(0, 1) }, \
-	{ DRM_FORMAT_RGBA1010102, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(0, 2) }, \
-	{ DRM_FORMAT_BGRA1010102, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(0, 3) }, \
+	{ DRM_FORMAT_ARGB2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(0, 0) }, \
+	{ DRM_FORMAT_ABGR2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(0, 1) }, \
+	{ DRM_FORMAT_RGBA1010102, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(0, 2) }, \
+	{ DRM_FORMAT_BGRA1010102, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(0, 3) }, \
 	{ DRM_FORMAT_ARGB8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART, MALIDP_ID(1, 0) }, \
 	{ DRM_FORMAT_ABGR8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART, MALIDP_ID(1, 1) }, \
 	{ DRM_FORMAT_RGBA8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART, MALIDP_ID(1, 2) }, \
 	{ DRM_FORMAT_BGRA8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART, MALIDP_ID(1, 3) }, \
-	{ DRM_FORMAT_XRGB8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART, MALIDP_ID(2, 0) }, \
-	{ DRM_FORMAT_XBGR8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART, MALIDP_ID(2, 1) }, \
-	{ DRM_FORMAT_RGBX8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART, MALIDP_ID(2, 2) }, \
-	{ DRM_FORMAT_BGRX8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART, MALIDP_ID(2, 3) }, \
-	{ DRM_FORMAT_RGB888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(3, 0) }, \
-	{ DRM_FORMAT_BGR888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(3, 1) }, \
+	{ DRM_FORMAT_XRGB8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART | SE_MEMWRITE, MALIDP_ID(2, 0) }, \
+	{ DRM_FORMAT_XBGR8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART | SE_MEMWRITE, MALIDP_ID(2, 1) }, \
+	{ DRM_FORMAT_RGBX8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART | SE_MEMWRITE, MALIDP_ID(2, 2) }, \
+	{ DRM_FORMAT_BGRX8888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | DE_SMART | SE_MEMWRITE, MALIDP_ID(2, 3) }, \
+	{ DRM_FORMAT_RGB888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(3, 0) }, \
+	{ DRM_FORMAT_BGR888, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(3, 1) }, \
 	{ DRM_FORMAT_RGBA5551, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4, 0) }, \
 	{ DRM_FORMAT_ABGR1555, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4, 1) }, \
 	{ DRM_FORMAT_RGB565, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4, 2) }, \
 	{ DRM_FORMAT_BGR565, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4, 3) }, \
 	{ DRM_FORMAT_YUYV, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 2) },	\
 	{ DRM_FORMAT_UYVY, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 3) },	\
-	{ DRM_FORMAT_NV12, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 6) },	\
+	{ DRM_FORMAT_NV12, DE_VIDEO1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(5, 6) },	\
 	{ DRM_FORMAT_YUV420, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 7) }
 
 static const struct malidp_format_id malidp550_de_formats[] = {
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 72cc22f828360..a242e97cf6428 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -33,6 +33,7 @@ enum {
 	DE_GRAPHICS2 = BIT(2), /* used only in DP500 */
 	DE_VIDEO2 = BIT(3),
 	DE_SMART = BIT(4),
+	SE_MEMWRITE = BIT(5),
 };
 
 struct malidp_format_id {
-- 
2.17.1

