Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F80CC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C77421B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l45VmOgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439718AbfBNT0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:26:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37499 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438440AbfBNT0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:26:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so3588316pfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bEG0NxK/TkiBajUPiod9cKRuA/aBM9IwOWB4PGFOrI=;
        b=l45VmOgAS7gmdmqj0kwq0CNxr3FjdmxmX5VCKjF0O1zGcSdzvmPJ4KZtP3D8MQKS5Q
         Bju+FpfWNcC9MkgAMtOQzfu+0SwUtNwa/522Egshy9HFToZIwme2xASYf4GWBNvLetdW
         rgRtQ29xehVznd7besQEhuVZQF0zo06VBDY2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bEG0NxK/TkiBajUPiod9cKRuA/aBM9IwOWB4PGFOrI=;
        b=LBo4f6T8zQ+HeX4cBUi9NIBqznc936v1WA7DCnqdK/+8WyLw4W4pWXGm3B84gHY1xX
         /Cjcz1tyEJRxj/mDD4oK0+nQpBnSEhSmR7zyKdY+DfUbp8OJCl80duKRTqzjWbkjvSR3
         dCLQgNQbeIqxja2ny7b+yoQpTjNwv8kuVM9zwdxD4T60wpSgPcWxqHmNixoe3gzJyjdF
         qciBZgh52UyUuRhstf7OxmMexoxyVDAwU5rn2+/diDwrJcLOGrzGrxYw857HurD9P9OY
         ZlzDAb9OKhBDrCl1WJvy7qe4vYunibsxKJXJZhKl0J6hdj9w3BlgE/zQigGH/HSW7aky
         1hRw==
X-Gm-Message-State: AHQUAuZRgZrnvYlhgLMSXv1hlK4OsOSha7zD3SGC23Q7cVZwSfXKbhCs
        CI0mm7PRM72Bx4pvgqd719rGXg==
X-Google-Smtp-Source: AHgI3Ia0CDs3p5oMKUDDJam7CZ/l0xCiETZ3cSv8nrroWNdU6m6h7kQy+w24xsl0DYun6uSOM0FAIA==
X-Received: by 2002:a62:442:: with SMTP id 63mr5632258pfe.156.1550172379131;
        Thu, 14 Feb 2019 11:26:19 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:26:18 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 4/8] drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing calculation
Date:   Fri, 15 Feb 2019 00:55:40 +0530
Message-Id: <20190214192544.7314-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

horizontal blank is computed by adding all porch timing values,
or htotal total timing value without sync time.

Based on "DRM kernel-internal display mode structure" from
include/drm/drm_modes.h

hblk = htotal - (hsync value);
hblk = htotal - (hsync_end - hsync_start);

Current driver is subtracting htotal with hsa, but the hsa is
bounded with packet overhead. So subtract htotal with hsync
value(hsync_end - hsync_start) proper hblk computation.

BPI-M64-bsp is computing hbp as (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
=> (timmings->hor_total_time - timmings->hor_sync_time)
=> (mode->htotal - (mode->hsync_end - mode->hsync_start))

So, update the hblk value accordingly in sun6i_dsi_setup_timings.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 21f39f11a8de..6b26dba883e8 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -486,7 +486,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	/*
 	 * hblk seems to be the line + porches length.
 	 */
-	hblk = mode->htotal * Bpp - hsa;
+	hblk = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
 
 	/*
 	 * And I'm not entirely sure what vblk is about. The driver in
-- 
2.18.0.321.gffc6fa0e3

