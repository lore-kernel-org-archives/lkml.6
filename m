Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09973C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C600A217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1y62VZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbeLTM1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:27:37 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33900 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbeLTM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:27:37 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so1553844qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGtj/SONva/PmM9W+CcU2onlFboOV+X9j11P4Nt27Rg=;
        b=b1y62VZlBQwU5Y9P2kzUszGZH1SICj64YIYLUi5rpZy3uGFaiGNZN+jkmK/sZK7QbF
         5qD4alSZhhex6bEr2BZowwh+PddjBwEAVh39KDBwM2Z65hW5aG4armQz7LTmnQFnx0wR
         eh/uwAgI/eoUpNpQfSPMRc4fUOH8J79lPAMiaZquj5ni/zeMLtqWPp/MGgWyoaUxhkwW
         pr7gccceBjhGSmTAi/YVk95bj6smeGoWAMi8Rr78Pgyb7bbnQE7rB8MoefTw0VYoISbk
         Duo2Dc2Ikay/aFJ/pt+9IS06ptEjaUANQii2qay6/098z7na4npo+xnpd8CypkAzRsxt
         NrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGtj/SONva/PmM9W+CcU2onlFboOV+X9j11P4Nt27Rg=;
        b=D0YJEpWLkG0gpjoWjAtNs+uUZ5NRfDGGKFwXRh3EDO/u4QzSEWZtEFtLs/sp1b6ZIF
         B4OkE4RWzob+pfcJSV0fsReHsELpZjgbQSnG4tK/C5iIJpCZ5d5X6UoDbwnDnO6nrG1P
         dMkKrMmklNoaL1D2pD/UoOtTwWVcWF3So0aUZn3UtnNr61PoPFJqe3hp9s6IVZpPX+io
         1z+OGXspa2wvWeIiBzXqSLplk85DZwngtz5p9fScaoKJ98/fTc+kALPg1XlKJz0rjs5E
         XSg6WY2YpuLrPWwxacmVMpvLmjHJPeL7u6opdiIMg+rWwjzExm8brPkigNy3XzDo+q67
         f9YQ==
X-Gm-Message-State: AA+aEWZzMouhTfwyfZy9VXsJ2rtZoV2u3sBqbTkGrZftaRuvJFRCSNn4
        3P+mtSkc3t7BwYJXW/Bc4Fg=
X-Google-Smtp-Source: AFSGD/W8KcABFL94g6sDmKRJmz1I9Nt46uKU9x9sWmbUToKXFwsyM4N92gasXKvK8Hj8A0OEqzHJ4g==
X-Received: by 2002:a0c:b044:: with SMTP id l4mr25886120qvc.80.1545308855932;
        Thu, 20 Dec 2018 04:27:35 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c11sm2837223qtn.95.2018.12.20.04.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 04:27:35 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:27:30 -0200
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
Subject: [PATCH v2 4/7] drm: sti: Cleanup drm_display_mode print str
Message-ID: <c079f461575aece9d598784da25aaadc711a2729.1545308167.git.shayenneluzmoura@gmail.com>
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
to remove drm_mode_object dependency in sti files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

---
Changes in v2:
  - Use DRM_MODE_FMT/ARG macros (Daniel)
  - Make the commit message more clear

 drivers/gpu/drm/sti/sti_crtc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crtc.c
index ed76e52eb213..ec9f87483e39 100644
--- a/drivers/gpu/drm/sti/sti_crtc.c
+++ b/drivers/gpu/drm/sti/sti_crtc.c
@@ -53,18 +53,10 @@ sti_crtc_mode_set(struct drm_crtc *crtc, struct drm_display_mode *mode)
 	struct clk *compo_clk, *pix_clk;
 	int rate = mode->clock * 1000;
 
-	DRM_DEBUG_KMS("CRTC:%d (%s) mode:%d (%s)\n",
-		      crtc->base.id, sti_mixer_to_str(mixer),
-		      mode->base.id, mode->name);
-
-	DRM_DEBUG_KMS("%d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",
-		      mode->vrefresh, mode->clock,
-		      mode->hdisplay,
-		      mode->hsync_start, mode->hsync_end,
-		      mode->htotal,
-		      mode->vdisplay,
-		      mode->vsync_start, mode->vsync_end,
-		      mode->vtotal, mode->type, mode->flags);
+	DRM_DEBUG_KMS("CRTC:%d (%s) mode: (%s)\n",
+		      crtc->base.id, sti_mixer_to_str(mixer), mode->name);
+
+	DRM_DEBUG_KMS(DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
 
 	if (mixer->id == STI_MIXER_MAIN) {
 		compo_clk = compo->clk_compo_main;
-- 
2.17.1

