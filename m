Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5A5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8775520643
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdGglJoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbeLSVWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:22:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43796 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbeLSVWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:22:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so12560965qkr.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wJn5KSM13jvGmAjP9VZkUWcjC8UPY4IxphlBNkihAcE=;
        b=GdGglJoeHEZvj04Y4zwhxO9sdeZgDuOUNCGEfX2oPZ1hJCasWTQSMTYAnZmysv/nxM
         cYLYz0htaVd9PPH8dD9sXsxmKkQcvMOJGvQJzek2UwHc6h/eXam9brXYHB2FJyhmpo7H
         14PgUduVrvKeF+vkNbyxuIqG5rFQJc/1VU6dfxZ3ito5dHQgnzwSbohF5BKwdhR9MLI4
         zbIepbT8BpDZFrWmaGzw/kwuZz0e60e+ysEwT3iyHDd5kMuIEDJqRlYSLMYUtzxS071r
         DSWf5q6z/mHrjbOpgpIc/imtTbG2QW9aHPqL6TPx+Vai+nF4aEaTQnmAnr7l90AAxQeW
         YbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wJn5KSM13jvGmAjP9VZkUWcjC8UPY4IxphlBNkihAcE=;
        b=g/Zr/BD5n/d9urX/I/QIXopujk8l7ofS44SVg+Cq1yO9tgInm1LuvWF6/y7cyswGlF
         OXN4ltLP9mXW/7dwVvMOT2Cy4SJ7lnWfmDJ1rCz14dbIXgXSNDrphOGrbqHsbfUgdTip
         SOe8ZpONFR7FMIvDMt1+ZFr6pOzdQCwACafGkjs9YFcd+C0JUcL5rLuQxUU3Ok7ltIYh
         UNVf401h7Ag6YEBTnoYRaCYN8keJFyJRGiAHpqCgded5Z0uJYPJ9PHu8KkOVgM7NYc0h
         jsIgZIJsjuwKqQl3MMjMHQsIFz62g2bI+x1/qo+5DY2/uUKQxYfAbAEBi8wuB+Jdd4io
         Odyw==
X-Gm-Message-State: AA+aEWaBLAz5lRL0+ZOLPBRj5XaHRLGQRIUZhglHxk3l0957kKDGl25f
        s4K4qWaxeG5yDGE3yfDnnVo=
X-Google-Smtp-Source: AFSGD/Vlu4mlrOkeHJ42sEEAcJyXREltawiIJqX1Rl1+R9vg6h59W6qTBhp9RHBE/bEejfSFTn5m2A==
X-Received: by 2002:a37:bb05:: with SMTP id l5mr21631794qkf.305.1545254529958;
        Wed, 19 Dec 2018 13:22:09 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id m14sm1855501qka.21.2018.12.19.13.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 13:22:09 -0800 (PST)
Date:   Wed, 19 Dec 2018 19:22:04 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] drm: omapdrm: Cleanup drm_display_mode print str
Message-ID: <fcf15d6f35c9e8e3fcc1136e55a0fa3d4fccdf57.1545254191.git.shayenneluzmoura@gmail.com>
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

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in omapdrm files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
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

