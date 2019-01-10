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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC02C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F380B20675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiA9h6U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfAJSNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:13:38 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43643 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730834AbfAJSNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:13:37 -0500
Received: by mail-qt1-f194.google.com with SMTP id i7so14405955qtj.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vqxs4CCkse9DFkKtG9oudQesUgVanHsLqrC+W7b4ldw=;
        b=OiA9h6U+f5TtZjrVfDPPt5ub2p5HcDjfqVo12y4XmdMUZNNk97FWRtXI7F7rhlNwMZ
         HiMrlIMr+pvINU1q27X+AHcYpW0g3h4Wf2m4PriIe8ca/GiJ2LVkqrAWQQvfcVE9FjwS
         M4Hr8s5uNSNz0Snj6AAIrZA5+oyHeR7OD3isJnqg9crpX8lZlpcM69+nseNYDRy4fcMP
         WTAsqM0qCbgbS8O/RyH1KwApNC38ftWvv2Ur3jEtyKf6ZbjFNz/ntLFpdudTVuqc3Q4h
         ZuOJhRSEth5Ho5bfBSepcEJrTSu2b+5NkkXPZ3VEm7SM+K765DIKSID2GAnNdRml/0YC
         o64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vqxs4CCkse9DFkKtG9oudQesUgVanHsLqrC+W7b4ldw=;
        b=LzIliLcG/aJQGmvVeNdVnbZ3pEWMSqQ2et8Gn3N6T/05s5hWsNA0bLA8LjiF3a85/F
         P7O3zwXhNxeJixLn/4uAz3Znxva/VxI38R8dEZB7C+o89KYwJc4u3DiYdmS1eUO05EJn
         ku53EDAE0RkNdgZrX9Ju0uE2+hEFEGKOTHr8EEUYT2L2gZxoNQLDoIzy7Phi1K/AJ26s
         N/orAe8a3PrpiiDlLIQToxOEZSIIFwuJp19aq4Ksr8+Lwf4qbe+S0da5myKR/G40SZ57
         trd89dmRG+ey74xmHTVFU1Y+dsVxJ2oEtkpsguS8ez3gE++xQvmMu1cLPfgJvK9909C1
         kRRQ==
X-Gm-Message-State: AJcUukd88jz7CqM38/SgLHSq/6otPDZDXMAXnF1oeUghwIyBAFDG8rFV
        jhzAai4agPbKFM1I+pg7uUM=
X-Google-Smtp-Source: ALg8bN6B4wfNe6znZp1NdU0f76WWa0q4/quBnrqJl68LGfuAw6lnOXiuX9eny5Bv4uQqO7B9ffuHWg==
X-Received: by 2002:a0c:96b5:: with SMTP id a50mr10813225qvd.33.1547144015198;
        Thu, 10 Jan 2019 10:13:35 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id x199sm26363990qkb.39.2019.01.10.10.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:13:34 -0800 (PST)
Date:   Thu, 10 Jan 2019 16:13:28 -0200
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
Subject: [PATCH v4 2/3] drm: Remove use of drm_mode_object
Message-ID: <8736fd1374b94b31354521ef890d06d3c26db799.1547143069.git.shayenneluzmoura@gmail.com>
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

This patch removes the drm_mode_object prints, evaluation and use from
drm_display_mode objects used in drm files. It removes dependency from
drm_mode_object.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

---
Changes in v2, v3, and v4:
  - No changes

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

