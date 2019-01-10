Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399D820675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAVjR8o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfAJSOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:14:07 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40178 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbfAJSOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:14:07 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so14422265qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5lLbsWnNDTYpb119UDn75Dnr1dQGBkgcM7j54MsCeUo=;
        b=jAVjR8o7W95pDbP8nuqpdtes1CDloyu+dzUSN/lDKXMa2bT72YgONgj2I8xfmaW1Bh
         JokYpKJWbOIKWOGrpodjlBZASyz5LD6ey9z8kCASdCWTOr+0Y1SsM/MhPEVlCsIEOK9L
         bR4ggSW0DPP/XdqugepOrIH6zR8ax6Mc05Jw1j2OS5nBhXNW0o06zWtgOIqiBirVUjwm
         GZ8i1iqrqB9CafLIpBGghtGzcJELJpDAUhhHxM34Z4lcEaQcaC6Sp4zqtvFxpdVgIv5v
         nRqmCzBDKku8C0AQxLRE83rqHPAaHWzwk7wi25VrmkKZHZxUIewKIyUqUEjsYznjCLFa
         LDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5lLbsWnNDTYpb119UDn75Dnr1dQGBkgcM7j54MsCeUo=;
        b=oCHgKuHUM679q1F+xnGDzhMYsPodExTVjO+qbcpjJPdm7KiWNtEXanSsejmI7JjgIi
         oI4C/1joTinCoImfTPmp4166to2CyIYKsjXKvqeBB0Xgxf+0x+DDdBUNfYg3YOmfd2eT
         BTG+I8BusiAFocEs/oLKo9iQF0RjG//7Og0xHn8/ANZouH5AV3MetQ9HlmKkaE7wBmgR
         Dh4qrTGuo8RZivojrsgldIaoh1KapFZSxMOplnzGKpZjnyAoQyvuYWcDBcsm53cHsfVY
         xZqc+18swjT9S3ii+ZLGIQJzcV00ZKKFw/M2FmkBVOvcOloDPauAJvUQsQeaLlzTJQMX
         M1jQ==
X-Gm-Message-State: AJcUukdzUEXlwFaWrlDUAoDpC/hvoPVtyQDDwhHC4AHpyPaNcmpnsgXc
        t2A0EB8lCWQbj35Mv44a0rA=
X-Google-Smtp-Source: ALg8bN4C8w2GYBg7ADBGAovp0DfN/sgNeq1kJWMWnQUsgRu2wn67KitR3K3mOQRiBHBXLmi3EoMhEw==
X-Received: by 2002:a37:81c4:: with SMTP id c187mr10225631qkd.114.1547144045525;
        Thu, 10 Jan 2019 10:14:05 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id q38sm37825588qtj.65.2019.01.10.10.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:14:05 -0800 (PST)
Date:   Thu, 10 Jan 2019 16:13:59 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] drm: Complete remove drm_mode_object dependency
Message-ID: <67f98b31051a4f21edf80dc8cbefabc524f5348a.1547143069.git.shayenneluzmoura@gmail.com>
References: <cover.1547143069.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547143069.git.shayenneluzmoura@gmail.com>
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
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

---
Changes in v2:
  - Make the commit message more clear

Changes in v3 and v4:
  - No changes

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

