Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459B5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F57C2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfAKFjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:39:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbfAKFh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:37:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78EF98E674;
        Fri, 11 Jan 2019 05:37:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21A327F1BB;
        Fri, 11 Jan 2019 05:37:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7421F9AD8; Fri, 11 Jan 2019 06:37:53 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, noralf@tronnes.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 06/16] drm/bochs: atomic: use atomic set_config helper
Date:   Fri, 11 Jan 2019 06:37:42 +0100
Message-Id: <20190111053752.4004-7-kraxel@redhat.com>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 11 Jan 2019 05:37:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion to atomic modesetting, step four.
Use atomic set_config helper for crtc.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index c6993c2d59..646f897cb2 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -150,7 +150,7 @@ static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
 
 /* These provide the minimum set of functions required to handle a CRTC */
 static const struct drm_crtc_funcs bochs_crtc_funcs = {
-	.set_config = drm_crtc_helper_set_config,
+	.set_config = drm_atomic_helper_set_config,
 	.destroy = drm_crtc_cleanup,
 	.page_flip = bochs_crtc_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
-- 
2.9.3

