Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DFBC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28B6214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsrhlP4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfAJRQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:16:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34387 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbfAJRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:16:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so14108962qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mfG5O/OXnDy9gzTm/iVTb3FlpQ/p9bXyoUYTpACFCLk=;
        b=tsrhlP4hLxE5H0+g3flXGqOSnR8Ygz/EsHMaU4qZXzj/081Y/D6esCTpKniEP7c4M2
         rOsvoYpN81YJolImvU5sKWRwGTEZqPtoudNgqSmHZZz3f7Ltq5pa9M+ySfvbBja025vQ
         d019fPDEisXs9OwblnriFwW8ODtujBJRw244D2EQghfXOq9jhpNMsoN44ZGNgtQkk9Ww
         SGvTCKif74aOAWsTWl4bNJdB75n6tzlfOWprJ53/G+XExZIDuG4lvk5TuixfCYKN6827
         znqimLpOjoR2V33bJxEDpBYFqUGxg0tTDDm48xxdD7LOZgIXk1Sgw5YnHUwjHorK2E3R
         nL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mfG5O/OXnDy9gzTm/iVTb3FlpQ/p9bXyoUYTpACFCLk=;
        b=Tc2vDxFMM+SqPWaBOB47mqA0CMOsocoyW1seaaBaTAzhzrDkHreLt2WhDpySbUQs/A
         KO2gs8CfH6w3iHyTuJyBYhOU6MSp4M6xW5q/xusX24g7BV5XKl76bwOZBZnGA704otDd
         DEtgcWT51GARo6NGiD7UbsdXsQoGK9GhUGnnrQVzM3RA7TeB2OMBEAmHOlIYNbQpZxj9
         1Ed5wu99ufkV1UOb/59f8qlWC1rqzIWmf1Es9yuTXJGife7mBvMq2TLSUpTGe9wm79cB
         rmIjXTK7AtPmvQf+mZbMa4vh1qCU3VhO1k8rJIWRRqIVSDKpkifona4DlPevgW26FoLL
         Oq/g==
X-Gm-Message-State: AJcUukd4VmmQ/QrjPw9oTL8AAkNZwgGe/nPOSk2GfedqFmj0pan7HV5a
        Wb9C8YZytPbpV0I10I/l2OI=
X-Google-Smtp-Source: ALg8bN4Zc4GrmNNYVW1OkuSxAbu4MRj8ezxVaCiG1EhCYfexRN7F2r0ameCQ0FBQksKGCsmULvu5LQ==
X-Received: by 2002:ac8:2487:: with SMTP id s7mr10336146qts.116.1547140618193;
        Thu, 10 Jan 2019 09:16:58 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id b17sm35876941qkj.69.2019.01.10.09.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:16:57 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:16:51 -0200
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
Subject: [PATCH v3 3/7] drm: meson: Cleanup on drm_display_mode print str
Message-ID: <70da9f0c1a6dfa2bd2eb4e12fd3a6f53df05855b.1547137815.git.shayenneluzmoura@gmail.com>
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
to remove drm_mode_object dependency in meson files.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
Changes in v2:
  - Use DRM_MODE_FMT/ARG macros (Daniel)
  - Make the commit message more clear

Changes in v3:
  - No changes

 drivers/gpu/drm/meson/meson_dw_hdmi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index d8c5cc34e22e..0b6c29cdd934 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -365,7 +365,7 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	unsigned int wr_clk =
 		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
 
-	DRM_DEBUG_DRIVER("%d:\"%s\"\n", mode->base.id, mode->name);
+	DRM_DEBUG_DRIVER("\"%s\"\n", mode->name);
 
 	/* Enable clocks */
 	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
@@ -555,12 +555,7 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 	int vic = drm_match_cea_mode(mode);
 	enum drm_mode_status status;
 
-	DRM_DEBUG_DRIVER("Modeline %d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x\n",
-		mode->base.id, mode->name, mode->vrefresh, mode->clock,
-		mode->hdisplay, mode->hsync_start,
-		mode->hsync_end, mode->htotal,
-		mode->vdisplay, mode->vsync_start,
-		mode->vsync_end, mode->vtotal, mode->type, mode->flags);
+	DRM_DEBUG_DRIVER("Modeline " DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
 
 	/* Check against non-VIC supported modes */
 	if (!vic) {
@@ -650,8 +645,7 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 	struct meson_drm *priv = dw_hdmi->priv;
 	int vic = drm_match_cea_mode(mode);
 
-	DRM_DEBUG_DRIVER("%d:\"%s\" vic %d\n",
-			 mode->base.id, mode->name, vic);
+	DRM_DEBUG_DRIVER("\"%s\" vic %d\n", mode->name, vic);
 
 	/* VENC + VENC-DVI Mode setup */
 	meson_venc_hdmi_mode_set(priv, vic, mode);
-- 
2.17.1

