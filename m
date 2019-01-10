Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F79C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B883206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfAJI34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:29:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfAJI2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:28:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12CAC7AE80;
        Thu, 10 Jan 2019 08:28:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BE0926380;
        Thu, 10 Jan 2019 08:28:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D8CD39D86; Thu, 10 Jan 2019 09:28:45 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 01/15] drm/bochs: encoder cleanup
Date:   Thu, 10 Jan 2019 09:28:31 +0100
Message-Id: <20190110082845.3453-2-kraxel@redhat.com>
In-Reply-To: <20190110082845.3453-1-kraxel@redhat.com>
References: <20190110082845.3453-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 10 Jan 2019 08:28:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most unused callbacks can be NULL pointers these days.
Drop a bunch of empty encoder callbacks.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index f87c284dd9..c8ce54498d 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -170,31 +170,6 @@ static void bochs_crtc_init(struct drm_device *dev)
 	drm_crtc_helper_add(crtc, &bochs_helper_funcs);
 }
 
-static void bochs_encoder_mode_set(struct drm_encoder *encoder,
-				   struct drm_display_mode *mode,
-				   struct drm_display_mode *adjusted_mode)
-{
-}
-
-static void bochs_encoder_dpms(struct drm_encoder *encoder, int state)
-{
-}
-
-static void bochs_encoder_prepare(struct drm_encoder *encoder)
-{
-}
-
-static void bochs_encoder_commit(struct drm_encoder *encoder)
-{
-}
-
-static const struct drm_encoder_helper_funcs bochs_encoder_helper_funcs = {
-	.dpms = bochs_encoder_dpms,
-	.mode_set = bochs_encoder_mode_set,
-	.prepare = bochs_encoder_prepare,
-	.commit = bochs_encoder_commit,
-};
-
 static const struct drm_encoder_funcs bochs_encoder_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
@@ -207,7 +182,6 @@ static void bochs_encoder_init(struct drm_device *dev)
 	encoder->possible_crtcs = 0x1;
 	drm_encoder_init(dev, encoder, &bochs_encoder_encoder_funcs,
 			 DRM_MODE_ENCODER_DAC, NULL);
-	drm_encoder_helper_add(encoder, &bochs_encoder_helper_funcs);
 }
 
 
-- 
2.9.3

