Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4474CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106B32086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLrr5YRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbeLSV3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:29:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33645 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbeLSV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:29:24 -0500
Received: by mail-qk1-f194.google.com with SMTP id o89so12610372qko.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 13:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vS1IeS7dOGQ6MIiXyflhfVSMqQYYhWFzM6pjaQ9bY0k=;
        b=jLrr5YRteep5OMycqB1YlOGllBB5RndPWSUvQHyQuJKbn+vrD2GTZAvWnk4sTfl91l
         zLR75RbzwjwhhSnd2auf60RtFZaG8Jj+9vjvUobtpTwd4PWFNgknU9tbPHIGpMOHrlSY
         s8mKe14mXYtiVAgfX6EdqZy/YvmJNdHlVy2KVObHYIXa71+oVgcGeEO4jO4FpNqcbzPa
         IKvlUQMR0VOIoUZLwPAoBGi6/nkNIznyuFXDYF47y+uBR0PlIPHZk8JH0zSAyOnxNxCf
         e+iAJ2nlHeKGLpWi5o9dWZVcSRlMu622/w1tr1EiqVSl7NKOVUyWq52SsFyg6IOTMmIJ
         Q9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vS1IeS7dOGQ6MIiXyflhfVSMqQYYhWFzM6pjaQ9bY0k=;
        b=ajmvJvlfpeddgbaIXY03HXegEPGhs8NOCOw3ADGE2wbIjutDX7an2lfoqbK3jqjrDR
         MtpHeFRGI1Xi4yoJ5mlpKDxYUDxQM6qgVGe1SOiYarc8/cFwxP5+bOGDxULnl3pX/pyc
         DWMt78Q19l2du1g1WNJ5IS8W62IvzeI5TI1I6P/PtjOjtzb6BfmE8+qxpk/BSSQZNsiV
         E+13bkTHMUFcj02y/SqwaVPop48j0n6lp3iStSKnTBCMkTxP6x9P9rnRCdmahkVOJURe
         2bAYNqoTBA3b5NYRMzS7LnjX95OzPYxBDGzNfROQDvb3MgTNcC0KOMp6E/PK7aHtWTG8
         8GuQ==
X-Gm-Message-State: AA+aEWb3G5bFLQpdweH6QagLVPT1bY/CutNOCRDnQdKdgMwy5Y5lj2M1
        Nxdbw1e/If/vx4DtnDXa0KY=
X-Google-Smtp-Source: AFSGD/XOAC+liNn5iToywv/UsXLoquFY3X0p0XxssAjUMQkO61ZZiZy4634JGaTyatKfXwwNILRCyA==
X-Received: by 2002:a37:a391:: with SMTP id m139mr21466567qke.11.1545254963131;
        Wed, 19 Dec 2018 13:29:23 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e4sm2660827qka.31.2018.12.19.13.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 13:29:22 -0800 (PST)
Date:   Wed, 19 Dec 2018 19:29:18 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] drm: Complete remove drm_mode_object dependency
Message-ID: <8d3d0dc35c5dc579d36edcebdc9136052bf740b1.1545254191.git.shayenneluzmoura@gmail.com>
References: <cover.1545254191.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545254191.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch finalizes the KMS cleanup task dependency from
drm_display_mode. It removes the use of drm_mode_object
from drm_display_mode struct and it removes the use of
base.id and base.type from drm_display_mode struct
print string.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 include/drm/drm_modes.h | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index baded6514456..be4fed97e727 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -136,8 +136,7 @@ enum drm_mode_status {
 	.hdisplay = (hd), .hsync_start = (hss), .hsync_end = (hse), \
 	.htotal = (ht), .hskew = (hsk), .vdisplay = (vd), \
 	.vsync_start = (vss), .vsync_end = (vse), .vtotal = (vt), \
-	.vscan = (vs), .flags = (f), \
-	.base.type = DRM_MODE_OBJECT_MODE
+	.vscan = (vs), .flags = (f)
 
 #define CRTC_INTERLACE_HALVE_V	(1 << 0) /* halve V values for interlacing */
 #define CRTC_STEREO_DOUBLE	(1 << 1) /* adjust timings for stereo modes */
@@ -213,20 +212,6 @@ struct drm_display_mode {
 	 */
 	struct list_head head;
 
-	/**
-	 * @base:
-	 *
-	 * A display mode is a normal modeset object, possibly including public
-	 * userspace id.
-	 *
-	 * FIXME:
-	 *
-	 * This can probably be removed since the entire concept of userspace
-	 * managing modes explicitly has never landed in upstream kernel mode
-	 * setting support.
-	 */
-	struct drm_mode_object base;
-
 	/**
 	 * @name:
 	 *
@@ -429,14 +414,14 @@ struct drm_display_mode {
 /**
  * DRM_MODE_FMT - printf string for &struct drm_display_mode
  */
-#define DRM_MODE_FMT    "%d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x"
+#define DRM_MODE_FMT    "\"%s\": %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x"
 
 /**
  * DRM_MODE_ARG - printf arguments for &struct drm_display_mode
  * @m: display mode
  */
 #define DRM_MODE_ARG(m) \
-	(m)->base.id, (m)->name, (m)->vrefresh, (m)->clock, \
+	(m)->name, (m)->vrefresh, (m)->clock, \
 	(m)->hdisplay, (m)->hsync_start, (m)->hsync_end, (m)->htotal, \
 	(m)->vdisplay, (m)->vsync_start, (m)->vsync_end, (m)->vtotal, \
 	(m)->type, (m)->flags
-- 
2.17.1

