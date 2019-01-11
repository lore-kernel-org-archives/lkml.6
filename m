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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58869C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2491E20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVj2DO0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391451AbfAKOp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:45:59 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33346 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbfAKOp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:45:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so19074132qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=48P+RP16tFEIA6bSr0bb8eryDsPui0KedQTYifR7568=;
        b=DVj2DO0eKGipgTFHjY9o9b7OD6XgHMM0WOyiEAZAtJUqHOVKARmo4ud9riQa6vgmQu
         vNFOuBySo7dXuV4ml8Da0CD0mcX/c26yibfOaqAXStpU7SonviGTgOUoYtP5riZcxCoe
         DNdJtg4wiIXehecNmptzbDn4n7UwoEsrWf35XReks+6urboWCiEYgc4c04YahUhN9WZz
         xzyfE8NI9z76D1bC+6HPpKxX6Duub9t7uJA8Fp5s9uQPnA3Ax5s1zE+FhpEhcl/wncR5
         1MOC462JlrBuA24TY/aPUf72+ORaHOnr5PHrvfELD5esza0M3Ai1DwfN40kVAIAe2CA4
         s+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=48P+RP16tFEIA6bSr0bb8eryDsPui0KedQTYifR7568=;
        b=Bcf9Vb6eGutq6TT5vxo8ieDfQjQnIvZZDOyCF8OPT+4fZ5mzCmCp2iqzaTULbZFzaZ
         6t1EXjhZk48Juok7ws4mxmX/a9vWDdv2F9JIrcflJS491/PGftz8hzV0ORINm2jL/o3r
         btplH5AfMXoHgdl5ZWiXHHXENkbtijwy7KKSYdX80UJSbzM4htjKGdXLvNSp8klQFXtV
         /QG/nh+urdMaadXkeQ24kzEO/YPD9L1dFyviOxb+o8HXC66BQhaQSyxM+7oxp/7RwOX9
         NVEPuhkZ+wwv4dUjBQwLv3XMK4pif1bI/1y8ecwHiGiPO+k3EyM/LRxgLcVdHntZlvKG
         wY1A==
X-Gm-Message-State: AJcUukc8joG8F7a+pB9qKAji5Qm7HvavFHy0b5CQMmSpkqfPG4yVPWSy
        x8zco0AUBt3wXoQNHQzKgV4=
X-Google-Smtp-Source: ALg8bN7Skdoz/u/uwafCyDmvTWpefH1738i+fOzZAZFN7vsWyB1pyiuUAqgg2p0RWPw2o1W5GCdtmA==
X-Received: by 2002:ac8:266c:: with SMTP id v41mr13739659qtv.159.1547217955215;
        Fri, 11 Jan 2019 06:45:55 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c71sm11192723qke.84.2019.01.11.06.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:45:54 -0800 (PST)
Date:   Fri, 11 Jan 2019 12:45:48 -0200
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
Subject: [PATCH v5 2/3] drm: Remove use of drm_mode_object
Message-ID: <785896b0a551464d0b780a55411707300802d6b6.1547214023.git.shayenneluzmoura@gmail.com>
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

This patch removes the drm_mode_object prints, evaluation and use from
drm_display_mode objects used in drm files. It removes dependency from
drm_mode_object.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_crtc_helper.c | 5 ++---
 drivers/gpu/drm/drm_modes.c       | 9 ---------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 3b5cf93233c1..fe7f7e9147b8 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -391,9 +391,8 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
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

