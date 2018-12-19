Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE71C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671BA20869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRVOWy3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeLSVXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:23:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44860 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeLSVXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:23:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so23885916qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 13:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XzkhwghGCVn1vgSNbw7tDXcqZFIiE7WflmoMoTt9yJ8=;
        b=TRVOWy3MBWCBTII/M7S58VW1KUM7S113rdj2b2ckPGRxlx1U6YPZgNlDdoQNOgDnFj
         kuDYz0plCcafPTevUE9OQTnW7QVwyyjp88rN0Xh1MVLuINq9aArchEIwDTBQ93tqBPrG
         ER4cSq6rmRTDE6Fbe824K4i66oz2+uJU/5SArL1OKUEbjgnjpzQIebWN/jyxKPF6YQS0
         odSqBE4yeLRymzhWPu019qm7LOcxd5GYUmWqYJkvPfv5Gs4UNBNGzwZocL8UGL5+b3T8
         0DtPQ65c6ouHBoP0scvBllKskg72gz2vtxprgdXl3G+tQpXecb1LwjWT9Of1qgRZlvcN
         NTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XzkhwghGCVn1vgSNbw7tDXcqZFIiE7WflmoMoTt9yJ8=;
        b=LevNTT9VpVdptfo4WyNRyZ54mj+w3E6X5lkakA/BV4BCsrSSQZV6OYgF9XKxcPunNl
         MjkxwbqoFDAAqL8WlGMHD6nF/4+zyi6Di+hcFRaqtRSXl2QLovdd5ZlwvcnsBITHocQl
         0kveaNwswthSiJUVWoGHbGatt1n6/spEkxQ+wf5c4jpbYjJs/z+QoZH3qnu//fPya7nu
         sIskOw2vsAcbpIvrd89/0IRwrIYwXmNdPHJ+ltniqHw46a5hfq0IZQsQNfmBGZ5Q4O2B
         x8ej7LUCPL9sS7G8cU4GEthinxqfiJZVSNan+Te1w6+TDQqke6Dw5JeNsdGBKrKkX3m9
         7A4A==
X-Gm-Message-State: AA+aEWaa5SwJRSKC+fnXMMkmh4OrOZrz9X3+bDYM9cb1QDhfp5OpjdB9
        tzE9jN1lciNCu3mJiGcM8QVBZVjbSGM=
X-Google-Smtp-Source: AFSGD/VRI/TpsaeG/P7KyxTvNqxbv4MyhY8nmEuAEfWj9dQEgwxrr80YpUe9rGtaxeW2Y8IjyIBu8g==
X-Received: by 2002:ac8:270d:: with SMTP id g13mr24014624qtg.168.1545254599825;
        Wed, 19 Dec 2018 13:23:19 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id b75sm4037990qkh.4.2018.12.19.13.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 13:23:19 -0800 (PST)
Date:   Wed, 19 Dec 2018 19:23:15 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] drm: sti: Cleanup drm_display_mode print str
Message-ID: <76df09eb0af7aeb4deb48ba425f8a6f8635435e2.1545254191.git.shayenneluzmoura@gmail.com>
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
to remove drm_mode_object dependency in sti files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
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

