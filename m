Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604BEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0412080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY9W/u1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0412080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391589AbeKVMWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:22:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38715 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388737AbeKVMWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:22:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so8004596plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kvkrNknnnYyDCwzgoDOzZl41ciugn9Tt2keFs4A91m0=;
        b=QY9W/u1pcWReosHAIJ0Mlet99ZY0UtHlAVvl80t1NMMfhHOPTx1hQZvZei6awez8ag
         b+prL3CZUGSmVb1swiDRD0P9CqVG7vTRuYHiqmztckcfjuMNQAmBonoiDUYW5JZQXVWH
         xN0SENdRoC2Fg+DauO37xY+OKZNnUSZ/jxdrTQBQ0arhxRRb0+4uWKdV3uPodfsY9qbN
         lRpg3CQUwJmeezLty+0VwEDImvScy44L5D3O4JGfpfk/1atju4Li2HFwN2yGKerA+kZ1
         ipLTWFgeyP+amgUYUdaBO4cavrej/fBzQg1l5XYD+mZ3vlkFx6LJRX6mQZteb4NbAWX/
         i98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kvkrNknnnYyDCwzgoDOzZl41ciugn9Tt2keFs4A91m0=;
        b=Fz4b52r8bkztBdheUXPR2ZiSrEfkvXOqpMbrrTl85aVOxfmB7ZVISLLOxKNTf/Mjmi
         EbnJ9NumfMg9cUIR7NMt2MOS81/RMPk2Je45wJLR71RHPfmOYllXXe7mrrMw55TyES1E
         ZN34XTzbDo3SFeV96AwhfVbpr7F3D695nD/gOYOx2qMfdMhva3G76i05jPaw9qUA1sKg
         qVPwztrQUvvy9BShrSBSgE+Gg8AdG5+/azDirPSGBYHDk0sFAiBam5lFpzAKZgsTzyJ8
         xa3IceZK+mlVWUy7+2rnXeoLaP87qO3UV6FYy+++pbm9G6JjkTsitkCitRF+T1KirCxd
         pBOA==
X-Gm-Message-State: AA+aEWa7mdmouNXGw6YZUEuyF4yT5kHt521xBCk63RdERMGvFYSn4OH5
        1rTPjL4HgxsbD0Es/fnR678EN+ips4o=
X-Google-Smtp-Source: AFSGD/VeWcDf7UYdqUvvBe0DAaAA3Ga+nNwoL2B9xy3whbF8gxhzgnRDgD6EKiBvSaJRSeFvZP0jzQ==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr6303624plc.57.1542851115675;
        Wed, 21 Nov 2018 17:45:15 -0800 (PST)
Received: from yuq-Aspire-4738G.www.tendawifi.com ([150.109.119.235])
        by smtp.gmail.com with ESMTPSA id i193sm58541500pgc.22.2018.11.21.17.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 17:45:15 -0800 (PST)
From:   Qiang Yu <yuq825@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, Qiang Yu <yuq825@gmail.com>
Subject: [PATCH] drm/sun4i: wait on implicit fence before display
Date:   Thu, 22 Nov 2018 09:44:17 +0800
Message-Id: <20181122014417.23285-1-yuq825@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Render like lima will attach a fence to the framebuffer
dma_buf, display like sun4i should wait it finish before
show the framebuffer. Otherwise tearing will be observed.

Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c    | 2 ++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 2 ++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 750ad24de1d7..d68e663df9a0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -12,6 +12,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drmP.h>
 
 #include "sun4i_backend.h"
@@ -114,6 +115,7 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 }
 
 static const struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
+	.prepare_fb	= drm_gem_fb_prepare_fb,
 	.atomic_disable	= sun4i_backend_layer_atomic_disable,
 	.atomic_update	= sun4i_backend_layer_atomic_update,
 };
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 28c15c6ef1ef..7bc2ca2bd0c3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -19,6 +19,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drmP.h>
 
@@ -287,6 +288,7 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 }
 
 static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs = {
+	.prepare_fb	= drm_gem_fb_prepare_fb,
 	.atomic_check	= sun8i_ui_layer_atomic_check,
 	.atomic_disable	= sun8i_ui_layer_atomic_disable,
 	.atomic_update	= sun8i_ui_layer_atomic_update,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index f4fe97813f94..815895795afd 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -13,6 +13,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drmP.h>
 
@@ -315,6 +316,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 }
 
 static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
+	.prepare_fb	= drm_gem_fb_prepare_fb,
 	.atomic_check	= sun8i_vi_layer_atomic_check,
 	.atomic_disable	= sun8i_vi_layer_atomic_disable,
 	.atomic_update	= sun8i_vi_layer_atomic_update,
-- 
2.17.1

