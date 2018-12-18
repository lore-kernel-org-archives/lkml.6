Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545CFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2232321871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqliO/lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeLRNiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:38:23 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35389 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeLRNiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:38:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so18184062qtc.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=h02Jf6d+TErFOX768BZ+Evkx/xmGfF/TiDgra91akHU=;
        b=mqliO/lx2oZ0maWWPk/35YC8FaGurzi/LdrCyyYeasSvsPtBkvTmiDvXwUm3JCXs93
         wJiYSD+bDAU5Wj8eMiI5ECvRJ7kq2rWINOIVKb1m7Dv/9nZn8JNNdnWj5E2M+09WU2+i
         FPhgbJrzaYcNyePB+Hpvpow1jNNcQjZirxm8U8snmA+vnlpCpT5U0jp32QIulUcjIrR8
         rGmzBN4sY3bflzMmvXjHZKXdcESvkdToQSh5KGvjzSJnpUmvd9m5CytmuxwaTugaQVtr
         X2G63Tzx1dOI4z+8RA6k4wUZ07rp8F7TpbzDcmSeyECjiloznhWDiAx8xWOE1xWxYPET
         nepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=h02Jf6d+TErFOX768BZ+Evkx/xmGfF/TiDgra91akHU=;
        b=gvI1i3w4y2jfbJyUPoJxOLiNAbX5YGSVRTWZ7UHeREBn4r1wWrtRgEQMZ5HN6f0q+K
         /WXdpa2w4iNpBEQjgXYR6hJaJPxYt+uX8oIXeKyJl3FYQmC7qREcteeuRCfd7oGvegF5
         Y5zqzdUTxJITMycXlzWYIvUy6GUmFAm7K1q3cocfq3SYTNbx7Ts12dScawNRCvXpgsFh
         4Z1nY67q/LqR5RmKJ4vdEJrC6CbCNrPgQTkdc+MCO+bBrvtb9dlPIJQuMQjn92ZLPWqB
         BFKRvQdzYJA+hoSIw4RmwPojhPJFEjj6snvxN681J+EAXaH4voKFVHAynk43RZspRDLe
         YssA==
X-Gm-Message-State: AA+aEWZ8BlDaNDDFQIQI9zSyx8aDft/Gze9AXFXMMB4l07kRaNeBZF3B
        k8A5B8EewV7AWQTCOWdwPZI=
X-Google-Smtp-Source: AFSGD/VED/5Qq5RC43Ae6dOwdNbZvZ4fMvwObZO0Sqoy69cQCjpRfTXD0f8b5j/db93TsKYVxZIzRw==
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr17304265qvr.115.1545140300482;
        Tue, 18 Dec 2018 05:38:20 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id u45sm10250092qtk.33.2018.12.18.05.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:38:20 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:38:15 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] drm: omapdrm: Delete base.id prints
Message-ID: <20181218133815.vr3hi5dpq6g7kgh4@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes base.id prints from drm_display_mode                         
objects in omapdrm files. It removes dependency from drm_mode_object.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 4 ++--
 drivers/gpu/drm/omapdrm/omap_crtc.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index b81302c4bf9e..e02986e0b2c6 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -306,9 +306,9 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
 
 done:
 	DBG("connector: mode %s: "
-			"%d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+			"\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
 			(ret == MODE_OK) ? "valid" : "invalid",
-			mode->base.id, mode->name, mode->vrefresh, mode->clock,
+			mode->name, mode->vrefresh, mode->clock,
 			mode->hdisplay, mode->hsync_start,
 			mode->hsync_end, mode->htotal,
 			mode->vdisplay, mode->vsync_start,
diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index caffc547ef97..3d6febb2e9c4 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -427,8 +427,8 @@ static void omap_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
 	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
 
-	DBG("%s: set mode: %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
-	    omap_crtc->name, mode->base.id, mode->name,
+	DBG("%s: set mode: \"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x",
+	    omap_crtc->name, mode->name,
 	    mode->vrefresh, mode->clock,
 	    mode->hdisplay, mode->hsync_start, mode->hsync_end, mode->htotal,
 	    mode->vdisplay, mode->vsync_start, mode->vsync_end, mode->vtotal,
-- 
2.17.1

