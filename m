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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29A4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA4920879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/bCKzm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfAJRTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:19:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36358 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbfAJRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:19:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so14090818qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4wzNd9DeG8t/wPBLcT852h6gcuKHG7AuIZJhFevKVHc=;
        b=e/bCKzm9Pac2mOEn8vqmIewvqabaCBKHNtG9OIHed/0KYIggEUXlJSplJ+D5BLxOYp
         G1qD0UziP6fx4kVYJKec4TYqPoTxsChm7p4vwjfsEYckBt/GGP9zksUbJTjtGVkZUIZC
         hesuxHRhxJW5d0tyPV0I3tnb+rB6OwAW+icYYAvur/p8mDAdQFkqGjDxJITQySIF0cqE
         SC4gmXnOrqgxplCai5GEWAkPXzLkwUUiR0pAVkd5J6ii23MTHUaQYZxqJUvtNKEh+YfA
         NCy7s5TTAZXvOQ/OaZC8E8rCL4cfhV3RJKwu41ZCQ/FJjqBd1Sy/Z8hKiTgCGSRcI1A6
         fbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4wzNd9DeG8t/wPBLcT852h6gcuKHG7AuIZJhFevKVHc=;
        b=Yy7MFuvcGrQ7v10iIfTl+Zy0ZNOnIzt8QTkiGY2/farEXBKHC2fJhQwv0OMvlQUY59
         qgxbaOOikFB8imDblUhHObSfXvtCxgyZkwPEHx7VczZQsBO6CWagwVvg2doJmex3SYjz
         noAd2NmxNmW1COw4J6as/PFjTrl+uuh+cukGI5JZ0l78i+7h6VbqjoT2G+1hb/Ijpgj1
         71K89dUf7JgjyZumn78P3W+VBPPxgJH1XvH/IpgbFS0be13M/vM/f9oUfjaq4bLuvJE5
         dk+1HOiNTOU2628u8pQQgzIVrS9kvJmVtAzOJftyoGd2rZ6FOoXpaYbr9x3YFrXCfPLV
         tj0w==
X-Gm-Message-State: AJcUukci0gugSZiU+RhtFWQ4hI5lE0PYAqMXKN++PI4gQN0nz6kf1KGP
        3zS3zyCkfJXih6kwImJbvyk=
X-Google-Smtp-Source: ALg8bN5lddHwkN4xjqbgE60pIIInwgNR4/oYJZlr0iU/tR6M3nDX9tKML8LeBJ2LRHxPSqto/FnGLw==
X-Received: by 2002:aed:2d66:: with SMTP id h93mr10315213qtd.130.1547140750695;
        Thu, 10 Jan 2019 09:19:10 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id x5sm42481591qtc.43.2019.01.10.09.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:19:10 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:19:04 -0200
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
Subject: [PATCH v3 6/7] drm: Remove use of drm_mode_object
Message-ID: <7ca1476341d7261cbb7b67a6c0097323614967d9.1547137815.git.shayenneluzmoura@gmail.com>
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

This patch removes the drm_mode_object prints, evaluation and use from
drm_display_mode objects used in drm files. It removes dependency from
drm_mode_object.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

---
Changes in v2 and v3:
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

