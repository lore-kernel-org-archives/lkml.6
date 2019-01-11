Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA610C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA259206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+Y4OnK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391400AbfAKOow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:44:52 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44168 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403916AbfAKOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:44:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so18983060qte.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QYdNq3VVMhYtpBQWaTK6+mRwBnuC2BB4henCpDet2gk=;
        b=V+Y4OnK96+ISTRETunjhQYKKT18Pz9g1aca9PLwWMj7HSs++QQJPaU21omZmFtUh19
         UaEbPCu4TJ1lokejMKjai09MNR6ypeexYz/63EO8qajTZ2TiDFPEpoBqIusaLcIC5N20
         t4TUJRMHtfNLUk+p+hWKzgkjAREr8V5gtl4Bp8aAsM8U6n6dDv1QA7rR5eV3RTSfXq62
         PVqRevFJrhA2Tkd00nN3BfjCQ5Nf3ZIzrDIsKxuteUVrk+xDFPvurBoAtTt22Cv9Xfij
         86cbUAiaKkFAmg1omrlYxMBDwlYgwfaEcCHtrLrs8jVUEkCblzNL+zOLKYa0SU9fOWm2
         0tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QYdNq3VVMhYtpBQWaTK6+mRwBnuC2BB4henCpDet2gk=;
        b=oK7APSqZ+j1oo/Xa1EpejzzbCx3R/3hXU89/raonHwfZzmXPoqNtEbmTsL9zwHoJ5w
         FSnjBMc+Agv+ZDQJ68c3GMTllYlI3Ut0j7kE6Vfisp2YEl7JiJudOJxRnXjKFVqPKW62
         wdJU1XYQaX6TsZF3jv3xpu2NVt99XwMIHFKWcPDzgQKvgvmxawuJ3vPyYW9GrhjHx6RQ
         NSrJ/044ALx2yWbpM40g7EyGyii8yqrGS6V/+aPik/Ha1EcxRB0Ur4HOrz14Dkix0OUX
         +dErJwSRiex1OUjrCL/A9dMmLwCzsVt45zvUob5f9qFOMGJH+jKbVILR4FW8qmKYfI2n
         w29w==
X-Gm-Message-State: AJcUukeJKBnPd4hASRZQESPRwEZjPCVSlMd1CrZVG2QbvuMUdX9Y6vOn
        GdgJ42ILN5x+z+a0pgAqnRg=
X-Google-Smtp-Source: ALg8bN6PJJmt8fqbRiEL5rG4yKvRJexd63EVBQyKLJY7wbZ5VZWuU78fl7pLXF1lNx/h57ZtS4YEfg==
X-Received: by 2002:ac8:2c79:: with SMTP id e54mr14168428qta.17.1547217888784;
        Fri, 11 Jan 2019 06:44:48 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id g19sm12253259qke.2.2019.01.11.06.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:44:48 -0800 (PST)
Date:   Fri, 11 Jan 2019 12:44:41 -0200
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
Subject: [PATCH v5 1/3] drm: armada: Cleanup drm_display_mode print str
Message-ID: <dddd98f1a6687a37444d315adc4cbd8a692a8131.1547214023.git.shayenneluzmoura@gmail.com>
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

This patch adjust the print string of drm_display_mode object
to remove drm_mode_object dependency in armada files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/armada/armada_crtc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index da9360688b55..20dfb29561c2 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -270,13 +270,7 @@ static void armada_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	tm = adj->crtc_vtotal - adj->crtc_vsync_end;
 
 	DRM_DEBUG_KMS("[CRTC:%d:%s] mode " DRM_MODE_FMT "\n",
-		      crtc->base.id, crtc->name,
-		      adj->base.id, adj->name, adj->vrefresh, adj->clock,
-		      adj->crtc_hdisplay, adj->crtc_hsync_start,
-		      adj->crtc_hsync_end, adj->crtc_htotal,
-		      adj->crtc_vdisplay, adj->crtc_vsync_start,
-		      adj->crtc_vsync_end, adj->crtc_vtotal,
-		      adj->type, adj->flags);
+		      crtc->base.id, crtc->name, DRM_MODE_ARG(adj));
 	DRM_DEBUG_KMS("lm %d rm %d tm %d bm %d\n", lm, rm, tm, bm);
 
 	/* Now compute the divider for real */
-- 
2.17.1

