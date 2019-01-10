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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EB4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E9B20874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rX3aekKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfAJRQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:16:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41654 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbfAJRQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:16:39 -0500
Received: by mail-qt1-f196.google.com with SMTP id l12so14039600qtf.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJ/IYTL7nBwK2EWEMM/wGih63gWPJo1gu5ym8hfvgdg=;
        b=rX3aekKmptLwUP0D9tng1anvIvqnAHopZrqxiQfMYePd4/l0ZSLY3/nooMFFMTNOcH
         6RZHVXceXoi4+x/Cwzgvda/vVgphDe+SLLQsVJASZF7d6qzUyQtD0GEU02Ky1lHX4u7v
         RZQQdW+rZIDDnBC+TtErTVYKlZQlXQYkeGlf51Chv/0S0bO9fhilZwzFeifEgdlGr+Me
         E33PRb+qh7J8wMqk5Dalp21nc5QQAAq1nhpxRLOl4y5cXkVeDZ/jhIlGYcq0IxE7xFgN
         CrEjQdkQYtWzE+hqGrOxgCnqRzCwVgwe/kPskKz+/fGkBFYNaCv+8bDCtcl6e11PPacK
         phUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJ/IYTL7nBwK2EWEMM/wGih63gWPJo1gu5ym8hfvgdg=;
        b=X1viGIIZDfmbJJQ36uG1K99WiXIiRheey9WeSpNUEwAf8bomlSVjNIRM6WFGffq+fK
         6H82LJXjhYq8QIMp6/dk/KnaJpqwP1MyGWuar2t6l6qibc9qhFyV/7GVAlXJOAB3g4Qx
         /0ONuuHDt0BIt1YTnkQWobYId24WXLPOUd8uIXubafmFRsbfxpPJbyiezPokI/lW7YAu
         HXFFpR5XPupU8UifUvL0F6wigw95BT+judVGivYnvY4UCvEazKEeZ2K4cbjHe9HBu3nw
         h3SkPdYQEHeL/B+pwchtBOO2lOC+BU5Bz9iNEvvQ1eyQMMPaXtN2BE1o/92bLkBZTgCu
         frwA==
X-Gm-Message-State: AJcUukciVXrCVwPb3xcgsOld0n8m9Vn8mPpBBBDsLdJ5V9B5kYOz3kXe
        r3SzII0IbLkWR5Vm4Edwgl0=
X-Google-Smtp-Source: ALg8bN5ObYNj24rlldo6ZTo/DUN2fhX0uCuj8yZsdmxkyU/N53kcHJipl2YWrn32ekprvbKG53WLtA==
X-Received: by 2002:a37:dd43:: with SMTP id n64mr10378187qki.7.1547140597021;
        Thu, 10 Jan 2019 09:16:37 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n72sm41914592qki.26.2019.01.10.09.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:16:36 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:16:30 -0200
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
Subject: [PATCH v3 2/7] drm: omapdrm: Cleanup drm_display_mode print str
Message-ID: <3e741fa74da8ff79c54c43377dc2831fbb2cd8d4.1547137815.git.shayenneluzmoura@gmail.com>
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

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in omapdrm files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes in v2:
  - Use DRM_MODE_FMT/ARG macros (Daniel)
  - Make the commit message more clear

Changes in v3:
  - No changes

 drivers/gpu/drm/omapdrm/omap_connector.c | 9 ++-------
 drivers/gpu/drm/omapdrm/omap_crtc.c      | 8 ++------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index b81302c4bf9e..874d8f3cbff6 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -305,14 +305,9 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
 	drm_mode_destroy(dev, new_mode);
 
 done:
-	DBG("connector: mode %s: "
-			"%d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+	DBG("connector: mode %s: " DRM_MODE_FMT,
 			(ret == MODE_OK) ? "valid" : "invalid",
-			mode->base.id, mode->name, mode->vrefresh, mode->clock,
-			mode->hdisplay, mode->hsync_start,
-			mode->hsync_end, mode->htotal,
-			mode->vdisplay, mode->vsync_start,
-			mode->vsync_end, mode->vtotal, mode->type, mode->flags);
+			DRM_MODE_ARG(mode));
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index caffc547ef97..40acf4ce7c9f 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -427,12 +427,8 @@ static void omap_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
 	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
 
-	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-	    omap_crtc->name, mode->base.id, mode->name,
-	    mode->vrefresh, mode->clock,
-	    mode->hdisplay, mode->hsync_start, mode->hsync_end, mode->htotal,
-	    mode->vdisplay, mode->vsync_start, mode->vsync_end, mode->vtotal,
-	    mode->type, mode->flags);
+	DBG("%s: set mode: " DRM_MODE_FMT,
+	    omap_crtc->name, DRM_MODE_ARG(mode));
 
 	drm_display_mode_to_videomode(mode, &omap_crtc->vm);
 }
-- 
2.17.1

