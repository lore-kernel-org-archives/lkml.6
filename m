Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UPPERCASE_50_75,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C0A4AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807492089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807492089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934277AbeFLOJe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:09:34 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:18860 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934015AbeFLOIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:08:36 -0400
Received: from e110455-lin.cambridge.arm.com (e110455-lin.cambridge.arm.com [10.2.131.61])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id w5CE8DwS031673;
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
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v8 4/5] drm/mali-dp: Add RGB writeback formats for DP500.
Date:   Tue, 12 Jun 2018 15:08:12 +0100
Message-Id: <20180612140813.20419-5-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612140813.20419-1-Liviu.Dudau@arm.com>
References: <20180612140813.20419-1-Liviu.Dudau@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate the pixel format matrix for DP500 with the memory-write flag
for formats that are supported by the SE memwrite engine.

Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 0524b75f85c6e..df3649203e6a9 100644
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
2.17.1

