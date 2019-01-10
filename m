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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917C0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D25120879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuMhsleV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfAJRTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:19:38 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38366 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbfAJRTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:19:37 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so14093299qtl.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8s2eySBVl2wi5qhv2DmPYesK0RX4jSHzUHp4+w+zpXI=;
        b=DuMhsleVfwzzPl53Yo+oudsjMh0k52QIfGZ3BBgBj5TrHNXZasATFL/F8rwPdhGkpU
         MtpMbECcoThKwOO7gGTsMGmV3CjFZDoydDhuXzhSaq/NTvXRQ5jPovhal3sayPn+5oIb
         gk+7iPJw0LibhWL4jg9K4aCsD6C5dFg5LmIJ1YO8B2fEwJRmz2AlMw5NPmVszYZwH1Hg
         9d/S1RdiHp4Nxc/e5uRf197GJWpGKmR6kZnoD3jITmALYjmvLjEksMofV9I0dhjtykew
         xMeHd9TdF3AMjavKyhWJLAB4hS9YeUj02Ewzkc6c4UDXTJbqX2pEVPqMZyt8CXtQ+X8Z
         geag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8s2eySBVl2wi5qhv2DmPYesK0RX4jSHzUHp4+w+zpXI=;
        b=aE5SP1h6QADbeOUL3aB0rrLShQSnwbIHo0bkzWaZXpy6YtCb2BlFleyW5YJGqT9bD1
         92pEo4En3rzMFDLG2iihJh1DZQ6hNzd7kC1pRNTeNHqu+Gs0qmTTh4Kj0mYd9VnqEKfE
         lOoniabLZq9xHu+IemGcNHstKRbYA3c6jg68uRP0GSGPSxsSvQKbeitPRFhNplXnFQA4
         3t1TRtteZwwqmHpV1GF8uO85JRv1i/1M+J+w7cgIeD86LusyELUqaJ/PNuOGMgi4Yoos
         tl6lIt0/FsLqdPGRumegk6eGHR8MxVJFnlqcjJQ1BvB+JgJOvycy6gbv53q6MV57SNhS
         lNyQ==
X-Gm-Message-State: AJcUukeJ2/HpZraAuJ0wKVQMKsM8wWWqmnHZADgfMFrOjHiSpMKF3L88
        /amnPHjVyZCm39Ox0JtwORc=
X-Google-Smtp-Source: ALg8bN7TqNRIu5dJ/ANGQe1JKiQ6rHyV0wB4JXHNRLXvpZ59VrPBDA41QMDlp3h9LN/F83qnSxA6tQ==
X-Received: by 2002:ac8:2a55:: with SMTP id l21mr10154899qtl.95.1547140775364;
        Thu, 10 Jan 2019 09:19:35 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d85sm7002053qkb.89.2019.01.10.09.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:19:34 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:19:29 -0200
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
Subject: [PATCH v3 7/7] drm: Complete remove drm_mode_object dependency
Message-ID: <c5d15ebf0583fbe0cf1c6b2ecb9a54c227589884.1547137815.git.shayenneluzmoura@gmail.com>
References: <cover.1547137815.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547137815.git.shayenneluzmoura@gmail.com>
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

Changes in v3:
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

