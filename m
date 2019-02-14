Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9E6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC52222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Vyk+rJ8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438434AbfBNT0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:26:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43598 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438384AbfBNT0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:26:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id q17so3570681pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAS7zvIWI8WLdUvyOqbvv5PR0m69rmeaJXwVeXQOXIs=;
        b=Vyk+rJ8HvVAw95K6i0er3o3GNantkwwsjUiLABTAEq6sF0u+4mSOsSfAZ/oI4R7WgP
         /iJ5gbUmN04+hyYNrPzcHSe32um4i+w4XAccxMIUx/wGn+D5SC7j62hQfUdX4aE6ADDS
         ZM9FaE3AAv09SKXRnMRi9uQZsv/g5QHruIiO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAS7zvIWI8WLdUvyOqbvv5PR0m69rmeaJXwVeXQOXIs=;
        b=hIkLpDH1/6+yPCpJRWzE9uQ51T4kedLq6OosKUusA9x1dCT6ZGMdAAvOtWlNJMq+JL
         BJGoOmZ7AO70m+89Fdogif7v4JSp4b8y9OiCXcqg9TovoTLDU6yFXscfmf52xP7ZyqZE
         VwIUV8YXq9qX0eWl/rmommM/Iy7yMGY9LkszT9E/jvZPGq95b6kQHH8gJSEsQmlWvh+K
         N5AHrlF2lMY8PZAXvRF9oqjcd5tP46nT9ECNPO/ZMODGEsgVAKY0Lu2EeWGY86O3U062
         mA/ylJvoiLXOORbpqCNbqyVc5LtI2JuHVSr6JlZc2WEEP92URcY6GDTcewVQLwXqKnCm
         4nHA==
X-Gm-Message-State: AHQUAuYsgudgmDQfBx5uvcy35i8BsCouUv+Z+cpmPHQOp0nuR2b0/lNA
        CdaHpznFdbzDQNq5qXkM/bS87Q==
X-Google-Smtp-Source: AHgI3IZW3Ke01qP/UcsGyJ+t0jFHnf1csxubvY1+0IvrmamyU3fpmC2bQHR9lusbB5SS1SjeFuh2FQ==
X-Received: by 2002:a63:7402:: with SMTP id p2mr1397042pgc.360.1550172375719;
        Thu, 14 Feb 2019 11:26:15 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:26:15 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 3/8] drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
Date:   Fri, 15 Feb 2019 00:55:39 +0530
Message-Id: <20190214192544.7314-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver is calculating hfp maximum value by subtracting
htotal with hsync_end which is back porch value, but the hfp
refers to front porch.

Front porch value is calculating by subtracting hsync_start with
hdisplay as per drm_mode timings, and BSP code from BPI-M64-bsp
is eventually following the same.

BPI-M64-bsp is computing hfp as (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hbp = (hbp-hspw)*dsi_pixel_bits[format]/8 - (4+2);
dsi_hact = x * dsi_pixel_bits[format]/8;
dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
dsi_hfp = dsi_hblk - (4+dsi_hact+2) - (4+dsi_hbp+2);

Example,
u32 fmt = dsi_pixel_bits[format]/8;
=> ((ht-hspw)*fmt - 10) - (6 + x * fmt) - (6 + (hbp-hspw)*fmt - 6)
=> (ht - hspw - x - (hbp - hspw)) * fmt - 16
=> (ht - x - hbp) * fmt - 16
=> (ht - x - (timmings->hor_total_time - timmings->hor_front_porch - x)
* fmt - 16
=> (timmings->hor_total_time - x - timmings->hor_total_time +
timmings->hor_front_porch + x) * fmt - 16
=> timmings->hor_front_porch * fmt - 16

So, update the hfp value accordingly in sun6i_dsi_setup_timings.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 982ae6b17654..21f39f11a8de 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -480,7 +480,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 #define HFP_PACKET_OVERHEAD	6
 	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-		  (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
+		  (mode->hsync_start - mode->hdisplay) * Bpp -
+		  HFP_PACKET_OVERHEAD);
 
 	/*
 	 * hblk seems to be the line + porches length.
-- 
2.18.0.321.gffc6fa0e3

