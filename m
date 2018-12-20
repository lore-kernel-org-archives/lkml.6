Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F466C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B474217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acv4BUQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbeLTM2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:28:40 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45821 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeLTM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:28:39 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so817880qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=62KEInXrjRaB/3jWw4KmGBRgyYPeGURKb6+SwrUGB8Y=;
        b=acv4BUQfrFHb3tsBd+xUZeXqo8ypOF14sPVCqAOOH6ozqKqSaVeAs0140yFETb+2xx
         YC6klCbh5DzEGQGg6fqA1TAFgBbi3v11OmTUkxVdKunBdKg8YxvLMgBuRi4lOLFP/+yw
         7aj+fh5tfWi5MiN/sJuNfgrCQS1pr/fDHQIbq9N6g8GwU8zBERL5wV2BUvx3IEcrW0qH
         HPwXrm3piEQRU0EvIJMXWdWRwHGu5xD94Z4s8b7dXTL6ZFNGncLyEhwrbMWypzaAs8d2
         v3LAz4gPHF0jmp9KSTTEMCDmUXs2F+VH4dpdwQsfuMuySaeR7IRkFfLXOw9E/S+qLkJS
         qR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62KEInXrjRaB/3jWw4KmGBRgyYPeGURKb6+SwrUGB8Y=;
        b=o1RBazOUhzaTKLEpvSkUrQZ1KDQvyze6ygsBnB520gcI5mtSuGhmYcF5fAYqx7Mvwk
         9W5yo3f0/lA9Tbyu+e92hLPwwLY5kPKRtGO94J2In1rOcC6VNxl1uF3/i+/C2vJCNcgc
         76cjYmjfJoPpRSABXCWpXw18SVbz+VuNEDfQMNNZCClDq8//vxl86MZC37mu6y8jiv4D
         Yy/yDVJGOynLZmjvZUNGFIatFw7gfPHvh+YTm7WnTp/nEnCpok0FatcaJxQAzuIn1x3a
         n+fayO2uWKWY56cqWuZcj/S7uSCjL0p408wAIn0oqGfsy+zDVitkCDNoaJCYJ2coYl11
         SDBg==
X-Gm-Message-State: AA+aEWa0E80+wSplYajrIlnhP2119Q6pJd3LmYlgIS+6MMYp/YTzf9SU
        uzZtjJhkuHk5WtIv9VFNI5Q=
X-Google-Smtp-Source: AFSGD/UkUXy8HJMNDJENY1efDyUeJwZ4sF91Mo0E5muuECexN+wfxneve2+0K9kjOl474PizEHN13w==
X-Received: by 2002:a37:9604:: with SMTP id y4mr24987338qkd.279.1545308918366;
        Thu, 20 Dec 2018 04:28:38 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c49sm3980226qtc.94.2018.12.20.04.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 04:28:37 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:28:32 -0200
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
Subject: [PATCH v2 6/7] drm: Remove use of drm_mode_object
Message-ID: <c595c8b733c08d7c26c69c3af3a150ccad7e441d.1545308167.git.shayenneluzmoura@gmail.com>
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

This patch removes the drm_mode_object prints, evaluation and use from
drm_display_mode objects used in drm files. It removes dependency from
drm_mode_object.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

---
Changes in v2:
  - No change

 drivers/gpu/drm/drm_crtc_helper.c | 5 ++---
 drivers/gpu/drm/drm_modes.c       | 9 ---------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index a3c81850e755..cc5cc8d109a2 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -386,9 +386,8 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
 		if (!encoder_funcs)
 			continue;
 
-		DRM_DEBUG_KMS("[ENCODER:%d:%s] set [MODE:%d:%s]\n",
-			encoder->base.id, encoder->name,
-			mode->base.id, mode->name);
+		DRM_DEBUG_KMS("[ENCODER:%d:%s] set [MODE:%s]\n",
+			encoder->base.id, encoder->name, mode->name);
 		if (encoder_funcs->mode_set)
 			encoder_funcs->mode_set(encoder, mode, adjusted_mode);
 
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 24a750436559..adce9a26bac9 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -71,11 +71,6 @@ struct drm_display_mode *drm_mode_create(struct drm_device *dev)
 	if (!nmode)
 		return NULL;
 
-	if (drm_mode_object_add(dev, &nmode->base, DRM_MODE_OBJECT_MODE)) {
-		kfree(nmode);
-		return NULL;
-	}
-
 	return nmode;
 }
 EXPORT_SYMBOL(drm_mode_create);
@@ -92,8 +87,6 @@ void drm_mode_destroy(struct drm_device *dev, struct drm_display_mode *mode)
 	if (!mode)
 		return;
 
-	drm_mode_object_unregister(dev, &mode->base);
-
 	kfree(mode);
 }
 EXPORT_SYMBOL(drm_mode_destroy);
@@ -911,11 +904,9 @@ EXPORT_SYMBOL(drm_mode_set_crtcinfo);
  */
 void drm_mode_copy(struct drm_display_mode *dst, const struct drm_display_mode *src)
 {
-	int id = dst->base.id;
 	struct list_head head = dst->head;
 
 	*dst = *src;
-	dst->base.id = id;
 	dst->head = head;
 }
 EXPORT_SYMBOL(drm_mode_copy);
-- 
2.17.1

