Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6E2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98039214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4zET7NC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfAJRRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:17:50 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34632 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbfAJRRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:17:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id r14so14114471qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QMzIK0mBMgiwms9QG6bHGnhAIOUPelgLkiWXu2a2hRU=;
        b=I4zET7NCTIhsx9M2jtfdCmuRdx9CAP6YYgA+cyhazEJoKM5T4DsQNr+t2kO1G1rzwf
         2n5f4Dk6HK1WvqkgptycdERTtOi9nbnqG1YZxndsLOPhmucEP6Wwm5zlE9RmawsUYAFe
         Lsd4qo8p3TjaPKZ4S5qGHbZPI6PvH8eVHSJZ+pG1z+/LdFQgsY89wj7990SdEMRWvoXc
         UETTonwf+0dFdYKJ4WQxv98K+1xaL0u32FBaEK2GVH/birrG7lN1owVmSRFQevqb1pCM
         fLRRfLfcqQjQNiAQ1lPrWEPPiP6KR47cVL8YOqmjmk1F5rdcn7ABYzaBTrdO7mQ/KjiQ
         9yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QMzIK0mBMgiwms9QG6bHGnhAIOUPelgLkiWXu2a2hRU=;
        b=ai9PInGLvV8eZOUQbC721ftRzwnAdwvm8vTJwflMSZrmIQkHE7lLxJ4SaDAfe5L3bJ
         YKfHAdD6evBXYedzob+eUOJNBCrRSf05VWVReRPxiCBLX95zJnFhGqm+7z3ag8rHOiEi
         lB657LXBO85DTLKIASaWJuDvN2sAQKsGO+f6OCtIPk/gocWlwAFOuupP1oVO9SzVSzAB
         1KyO+acN8eFv6P+xNXWmPuXiMhGkxmcLeE16ZAjzl1WvhS98TcNOHqLcmKdwf5vwcImg
         6jy7ejsfvo2y9FYGgeFeHRau4XD7dU95RIuAVYtck3r/Zf30ywmaKDFkRhOwjsOx+YFi
         XW4Q==
X-Gm-Message-State: AJcUukeSScRC6T8x01Kxvl6T+qyrWovpu0mBYba/6/W5iIdQB1LP7fSs
        SvovIuv+u+lBPykA61jQFD8=
X-Google-Smtp-Source: ALg8bN5jq5wlRC0GYhk8tdScPMH1Foe9P4EwjIyfWEGvZ2hoaaW0ANPIQ4djxwb7OrZfposf24bu+g==
X-Received: by 2002:a0c:8ecc:: with SMTP id y12mr10551394qvb.41.1547140667324;
        Thu, 10 Jan 2019 09:17:47 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 83sm45154817qkz.73.2019.01.10.09.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:17:46 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:17:41 -0200
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
Subject: [PATCH v3 4/7] drm: sti: Cleanup drm_display_mode print str
Message-ID: <37d2776a34e83a56f1867e7727a72194ce1b6b4f.1547137815.git.shayenneluzmoura@gmail.com>
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
to remove drm_mode_object dependency in sti files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Acked-by: Benjamin Gaignard <benjamin;gaignard@linaro.org>
---
Changes in v2:
  - Use DRM_MODE_FMT/ARG macros (Daniel)
  - Make the commit message more clear

Changes in v3:
  - No changes

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

