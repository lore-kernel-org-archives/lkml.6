Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A522C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C0217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKMmkvnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeLTM3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:29:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46689 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732030AbeLTM3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:29:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so1503525qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tUu4F+UJJ5U5hvwjznw2zjBFfosynEIvtD0ad9YuHDw=;
        b=dKMmkvnTN5cE1Ef/52k9JNmTMqKaqXza+/i57hYKfnUJ2CmLT9a+ksrZf6fnNqACR1
         2GOrJ2aQ8YTX7Rg9UwAyRMKUzl02xhoSmUi5tJBL26kE+jCAeT0Pt4hRH3MVHPZAxFOb
         B3EwjaEZFFg1DRyLntTY56mlUmreckOfTpU7M5rQg7CaZPaQAWlQdBu4L9vCdvz5qEfv
         qUf8oSSW3qFz5jWGCeIuKgqA19+VenZKCaoiYVn/QdTl+jWzoisdnEfZCDkfbgx1EekQ
         5/MWZ9LhbOVGJY3JInWuN97vlGsQdbnVuh5XgLadUSD369ZC7tPNe2UgSkxHnBya+ahO
         YuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tUu4F+UJJ5U5hvwjznw2zjBFfosynEIvtD0ad9YuHDw=;
        b=Cibe+E65FBv65PXr3lhVsR7344oJH7Cm75gJUFfRMzV0KvLr5fQwsdq+8h/D81sxXn
         Cx9Wp1TLdLEKjCCn7kt7CW7K+ty7a/sHovYs7cAJCV6RihGP0JdY46JT32xBUDcSYExr
         EVusU6Oq+48ys8GslxJ/uBCcQwh00bZcg695LRosPigt8rlRp2pBlL3Ouor1DDxXdZ7+
         s+kLPld5mtR2kSfWY89K/HBZFdXgSAqT4B378ei1QQsoZ6u3hTNYSdZFLiGGMZ9DKE0O
         RjyymgybCAVlryUc5bLTQpq2juIBjolCsN5048Gf95MsKNShKjuKeuwmlkiKd0BkZzLe
         TTmw==
X-Gm-Message-State: AA+aEWZ6QEqHglliujBYCXZ2QmBTHuUVfVmHNOzd/LbG2PSM43hoilIF
        M1g56pdX+0Yw74VpSNODUdA=
X-Google-Smtp-Source: AFSGD/VZ4kZ7VqZQ+djIgGa3+n96KxeCNQfT0YaoOS84QALm80nwn0BcDdbINfntg8wtAO2MiXrTzA==
X-Received: by 2002:ac8:25d0:: with SMTP id f16mr26206224qtf.129.1545308949507;
        Thu, 20 Dec 2018 04:29:09 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s36sm4933955qth.17.2018.12.20.04.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 04:29:09 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:29:03 -0200
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
Subject: [PATCH v2 7/7] drm: Complete remove drm_mode_object dependency
Message-ID: <24a867ae577158dc597d937ab7628f754ec6c0f9.1545308167.git.shayenneluzmoura@gmail.com>
References: <cover.1545308167.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545308167.git.shayenneluzmoura@gmail.com>
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

