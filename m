Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5026BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA4C21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNyOpiFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbeLTM0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:26:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40638 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbeLTM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:26:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so1519094qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+cQLVpHvi6mh/2zA45HG6fzTw2UhrAx/fSVerSzkfDc=;
        b=pNyOpiFmCko+gUEsS4DnM81Npo4vCE4HFR/lYPbWW/3saFx0e4nz97e/hJeKc/GBhi
         42f4uUrS3liYfZ/htkkcx1HU7ZhHsL8ujnkyAYAPSqWEEQxue9/J9lwNIuL3TymcR8z1
         KQu28WNXNvGEh5u6TVBJrftwhlo2itOMPdVMxngBAeaA00TodX9SUvVrVxvS/O2fYr7D
         6XTO/yHD/Aoe9InDabvnZE7xZvsoPUM0Ovkayj7weVZuhjtoa0RP+LeOOE2hSzMf4PJD
         FLJJIZ9sfj9v4DdPf/8shqalX2pz4UeU12moVkyZwSGXW1KknpOKJ52QWai/eAcPU7mG
         ckOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+cQLVpHvi6mh/2zA45HG6fzTw2UhrAx/fSVerSzkfDc=;
        b=ANn1+qi/mDsfl/8AfsNvnKg5V1erEbS9qfXAX9eSpWMO0k+qAbuUAyn4HVgmwC8acF
         KCkggMN1olfOsJyH5313d+qlArhCzEa6JsXmuLCQ3ulax3/M6S/fujdvSCJ3Q8nsOFGL
         If/25lq/vso/LZ13wjUvBdVXbJDXi0xv4MnE8MsQ27ME75BoBz913nf80HZrwg7iYyTV
         2bYacl9bMjx5nITMNEVMdkwubrXL15eDv7rcBljqrs51HTsXdiRRAdo8XxhgOTIQ3+De
         u6+iobEV3924Uy3BFXrLddvCUqw/mxHf+sCAtAdTmgmWy1LIdZ76xBVJfZnNmrgADcXW
         DPqg==
X-Gm-Message-State: AA+aEWZijpoLaFU/xFKFj9PFWk4sfDLIPO5tnOphcOsAGVP9Piosxujc
        6ZGcdPf19RUihGMEAMumwXc=
X-Google-Smtp-Source: AFSGD/WXiZjMlVYu45e9VyFauwkrVT7JxaH0TuTTyviFXE6fRpS/GG24pARQ4P6vo/taNv7XR4zqrw==
X-Received: by 2002:ac8:7201:: with SMTP id a1mr25802622qtp.291.1545308776867;
        Thu, 20 Dec 2018 04:26:16 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id w81sm5679407qkg.43.2018.12.20.04.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 04:26:16 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:26:10 -0200
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
Subject: [PATCH v2 2/7] drm: omapdrm: Cleanup drm_display_mode print str
Message-ID: <cb6079fa6de6fda8d865a1d2a61d7cf10019ae88.1545308167.git.shayenneluzmoura@gmail.com>
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

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in omapdrm files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes in v2:
  - Use DRM_MODE_FMT/ARG macros (Daniel)
  - Make the commit message more clear

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

