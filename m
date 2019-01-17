Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF30CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9670020855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfAQWRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:17:40 -0500
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:38690 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727819AbfAQWRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:17:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E706B181D340F;
        Thu, 17 Jan 2019 22:17:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: air43_4292f517a4b08
X-Filterd-Recvd-Size: 2351
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Jan 2019 22:17:37 +0000 (UTC)
Message-ID: <c827c37349687e2421c9ad1614ca13078449eec2.camel@perches.com>
Subject: [PATCH] drm/msm: Add __printf verification
From:   Joe Perches <joe@perches.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 17 Jan 2019 14:17:36 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few __printf attribute specifiers to routines that
could use them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/msm/msm_drv.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 9f51be5a637c..927e5d86f7c1 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -334,6 +334,7 @@ void msm_gem_kernel_put(struct drm_gem_object *bo,
 struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 		struct dma_buf *dmabuf, struct sg_table *sgt);
 
+__printf(2, 3)
 void msm_gem_object_set_name(struct drm_gem_object *bo, const char *fmt, ...);
 
 int msm_framebuffer_prepare(struct drm_framebuffer *fb,
@@ -397,12 +398,14 @@ void msm_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m);
 int msm_debugfs_late_init(struct drm_device *dev);
 int msm_rd_debugfs_init(struct drm_minor *minor);
 void msm_rd_debugfs_cleanup(struct msm_drm_private *priv);
+__printf(3, 4)
 void msm_rd_dump_submit(struct msm_rd_state *rd, struct msm_gem_submit *submit,
 		const char *fmt, ...);
 int msm_perf_debugfs_init(struct drm_minor *minor);
 void msm_perf_debugfs_cleanup(struct msm_drm_private *priv);
 #else
 static inline int msm_debugfs_late_init(struct drm_device *dev) { return 0; }
+__printf(3, 4)
 static inline void msm_rd_dump_submit(struct msm_rd_state *rd, struct msm_gem_submit *submit,
 		const char *fmt, ...) {}
 static inline void msm_rd_debugfs_cleanup(struct msm_drm_private *priv) {}

