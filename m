Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCB2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13D9206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9v5DdL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbfAKOrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:47:39 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41129 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbfAKOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:47:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id l12so19024072qtf.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MbpoJ6OpXQyoQx34wiNH+p+XHyxcncuEe22FvnF+Rwg=;
        b=b9v5DdL3PaVqmoTqIK7hkcs1aT5zHPTTtkom3ve+YT8974qVr7oF5ZT9/WibZS/NBO
         8RPyb60PPOaJc91jZmjGe0BiW64GSk8rtbWFqYnpz71Geqvc6gm24DYPwb6bIOgRpfjF
         rcd3gqGO4Yfd+tNAkjuTVVDCBXxESOiZc7PE+8S6uBcYEsMXobeNGL9IJGhus6PMR0Ys
         sNRamecwq1kwgV7MR4iC/lIOVwBk1ut+kS0rSDvdijWChFu+UUsIMQnkGbh/jyLJJJ/P
         CoGvEez/qfaa9aKGQoNAcc1MO0GmhwbL/IErV9T8aOCd5sPHDbWD3Y9WiBoYfqkPHbTz
         RzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MbpoJ6OpXQyoQx34wiNH+p+XHyxcncuEe22FvnF+Rwg=;
        b=DgZwwoTFRKSp8YpaI5w7LzVcBFzCQGltxvYyc6XOsKl55GE9hSwEGMNyMK+U19vbxL
         siAPKEbhX6ko3HiyGhJl6wC8/dXOCRGH5IpG6s0DSi/ak8F9fBZIfjbjnBM6gqtTYneO
         T43JyXo7AGnH5SleelpvltxRsMBvd5zt5b1o31APfEj3X9BmPnWQzVsNskf/8gPZPJCh
         x//DIl9GueQmWfnCaQwJRsPiiTRCmMXSAg60Sog14H8Hy77DTY3KayDfF8J63Ui9aAHu
         szrAU8Sxn9NeReyRWKxLzw5lp4sdnRNZhoha/Igk0WMsfi71QK52VTwzpYgs53JiwzoY
         6oHw==
X-Gm-Message-State: AJcUukcXAxXvyUFEv6LNJH5CbWARxo1IW97EcivQsjYk1HkJG8VNXRPz
        s9zyTvsRyuUpLuUHf+mqHRw=
X-Google-Smtp-Source: ALg8bN6wLz11XwJNQmMfVHAVL+I3VSme8UFz0D6kWXu2GQnJyhcOWsVgfc1HhkNXYo0KnOf0PL42mQ==
X-Received: by 2002:a0c:d4a7:: with SMTP id u36mr13793902qvh.38.1547218055218;
        Fri, 11 Jan 2019 06:47:35 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id x7sm13422266qkl.50.2019.01.11.06.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:47:34 -0800 (PST)
Date:   Fri, 11 Jan 2019 12:47:29 -0200
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
Subject: [PATCH v5 3/3] drm: Complete remove drm_mode_object dependency
Message-ID: <f40e904e665fe3e3ae3ae86e837024bee3b8ca6d.1547214023.git.shayenneluzmoura@gmail.com>
References: <cover.1547214023.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547214023.git.shayenneluzmoura@gmail.com>
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

