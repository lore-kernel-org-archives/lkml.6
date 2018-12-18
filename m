Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456CEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FB021871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx9Sf8s0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeLRNio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:38:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39093 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeLRNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:38:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id n21so18138665qtl.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tG4R6Sslg/VO1cLMTLOUkzjx4gymESlTDbMrj6gkZRI=;
        b=Cx9Sf8s0bW3PlPpNd2RWgiHJ0RTSoxdFKCowr019gALkDMAUn+ZO89Ua8HL0jri8Mu
         30ARaziBlS+ChEUDJqTXy+giHyj94Y6x2la2MyxwVhxFA2doUjc6FApVtz8Gngld273+
         3vr5K77GoYTSOkMIXj74dqS0XLUyVXKWQNbMLrWr0b89/pv2llgCBCY9KvtirclTm7oe
         nQn1lBqsx2yWc3jBJ5xUpKToszAxgvC+W3PNd2KHUxqobmbMFHM0IgoPpCM4dxXBBq3z
         yvnTjZ8un2Vwri8zXeNGXagaRGLkQXpea7jxvGFnWr6IT8Pdj3AuR9MGhQhZTYvxkWJS
         5elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tG4R6Sslg/VO1cLMTLOUkzjx4gymESlTDbMrj6gkZRI=;
        b=dfOR8qyHaaTRvPEqMpq8KXSRe0LPcWQVRGWUYxnaH3CMzi/SCM7LbTfnpQbJq+h25U
         jCQqgxoCa2HC8hCKBnedvvANIEBRYZYLA7k61rxGeUiQyMcYmWnNw3snk5iTy2zlQEo1
         2MZd9U4AhwnMIX1WPCl9UW+nqlY6eCCVycDZs7kraiBM3nJmSLHK30LuB4bDwEHDKsof
         OqAOoiI0aJWEzp2IknWnhJoxfjBEaLZeT5JP07FRrrcDio5VQ+AcE+7p+ofHufBTZq3D
         jhRvzvCskw4nAkxZhiKlDKryCUHW8deuSG32VDMCYrQFn1hQDsnD4Cfisci+W562ObER
         i9jA==
X-Gm-Message-State: AA+aEWY0SFnPnADIORA4FcPHgQrGXvfXkyNmmaQ6x/esnrB8Ppn4gvZK
        mjVErDM9zz4aEu2FWCT6i3s=
X-Google-Smtp-Source: AFSGD/UFtHk/FUl9jYLA1P34pWU856LJ71rIBhW136fK3+BCJwoTTjbb59F1Q9D+Gk+LzTz0N9QwOw==
X-Received: by 2002:ac8:76c3:: with SMTP id q3mr17360308qtr.48.1545140320954;
        Tue, 18 Dec 2018 05:38:40 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id m79sm10100825qkm.58.2018.12.18.05.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:38:40 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:38:36 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] drm: Complete remove drm_mode_object dependency
Message-ID: <20181218133836.pahcbhb5tlr4fwvf@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch finalizes the KMS cleanup task dependency from drm_display_mode
It removes the use of drm_mode_object from drm_display_mode struct
and it removes the use of base.id and base.type.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 include/drm/drm_modes.h | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index baded6514456..9ecc1e835565 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -136,8 +136,7 @@ enum drm_mode_status {
        .hdisplay = (hd), .hsync_start = (hss), .hsync_end = (hse), \
        .htotal = (ht), .hskew = (hsk), .vdisplay = (vd), \
        .vsync_start = (vss), .vsync_end = (vse), .vtotal = (vt), \
-       .vscan = (vs), .flags = (f), \
-       .base.type = DRM_MODE_OBJECT_MODE
+       .vscan = (vs), .flags = (f)
 
 #define CRTC_INTERLACE_HALVE_V (1 << 0) /* halve V values for interlacing */
 #define CRTC_STEREO_DOUBLE     (1 << 1) /* adjust timings for stereo modes */
@@ -213,20 +212,6 @@ struct drm_display_mode {
         */
        struct list_head head;
 
-       /**
-        * @base:
-        *
-        * A display mode is a normal modeset object, possibly including public
-        * userspace id.
-        *
-        * FIXME:
-        *
-        * This can probably be removed since the entire concept of userspace
-        * managing modes explicitly has never landed in upstream kernel mode
-        * setting support.
-        */
-       struct drm_mode_object base;
-
        /**
         * @name:
         *
@@ -429,14 +414,14 @@ struct drm_display_mode {
 /**
  * DRM_MODE_FMT - printf string for &struct drm_display_mode
  */
-#define DRM_MODE_FMT    "%d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x"
+#define DRM_MODE_FMT    "\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x"
 
 /**
  * DRM_MODE_ARG - printf arguments for &struct drm_display_mode
  * @m: display mode
  */
 #define DRM_MODE_ARG(m) \
-       (m)->base.id, (m)->name, (m)->vrefresh, (m)->clock, \
+       (m)->name, (m)->vrefresh, (m)->clock, \
        (m)->hdisplay, (m)->hsync_start, (m)->hsync_end, (m)->htotal, \
        (m)->vdisplay, (m)->vsync_start, (m)->vsync_end, (m)->vtotal, \
        (m)->type, (m)->flags
-- 
2.17.1

