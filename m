Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41135C10F05
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D47921B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KYg2QwY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439732AbfBNT02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:26:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45498 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439653AbfBNT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:26:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id v21so581166pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PA7omnu5a1QEIw1FJbeZKYVUv3ytW4+L6xraVR/pk8=;
        b=KYg2QwY3pqecw/vKuQF3qTv4P53VS4HpwdC/ZE/zGzuSq9g976SGphyYcygNR8HyXf
         U/GL+Pr8XuW9N+85KQfr2kCXFa+TD1NXUZwwfyDpwvYze0DbmazlcDqdngc98o08pmXo
         HcNjMZrQd4Ep/OOF2pYvDZwm4zJkVKnZBvEho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PA7omnu5a1QEIw1FJbeZKYVUv3ytW4+L6xraVR/pk8=;
        b=t/5t9XuA3Umct9q+zcsMTZmcLjlboQ4L8qojOvlRqcbWkrULKX1fHdo/c5JEJQymMy
         ZQZS57hUeScHDVDh2jwf5s268NDETLfRt37chFPQ2ekFrwr9GhEobxB9zXo7sVbmlOVd
         gTF5egzAJ2SxZ2X2VmMOU2BO58xb3QDZfb4nELfGjEMINJviwensExwMus2m7xKgW+sQ
         WhDUmAlpBR0FfWGgQZfNYppmn8HP65ccRkRHkbjeOd7Uab9jzoIuy4/yS99IuhhNRpDb
         EbHvqdQ1oGSqsqKHtHaEo5SLkyRXEdemUFUo/OA328kLYFw277hTTo18YtBfP3KrKV10
         azsA==
X-Gm-Message-State: AHQUAuapw6Nrs0uC5yhM0+Bng/CrLXg/+0nUlEAPYfCmPQFZQjWoDJI/
        5fxlOJMB64WR7dkVj4iBCqJfAQ==
X-Google-Smtp-Source: AHgI3IbaKLGN1hq/z5LYB5B808XAS18IAysXSaBZfFEbEqN8Uw/C0DjJD1mDDwX+NZEGlxX6a1y7ZQ==
X-Received: by 2002:a63:d347:: with SMTP id u7mr1443184pgi.383.1550172383057;
        Thu, 14 Feb 2019 11:26:23 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:26:22 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 5/8] drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet overhead
Date:   Fri, 15 Feb 2019 00:55:41 +0530
Message-Id: <20190214192544.7314-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other dsi setup timings, hblk would also require to add
packet overhead.

Add 10 bytes packet overhead for hblk, so the blank is set using
a blanking packet like (4 bytes + 4 bytes + payload + 2 bytes)

The value 10 bytes are refereed from Allwinner BSP like how other
dsi setup timings grabs in existing driver.

This is according to BSP code from BPI-M64-bsp (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);

So, add 10 bytes packet overhead for DSI hblk.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 6b26dba883e8..a64e6ec00f22 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -485,8 +485,13 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
 	/*
 	 * hblk seems to be the line + porches length.
+	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
+	 * payload + 2 bytes). So minimal size is 10 bytes
 	 */
-	hblk = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
+#define HBLK_PACKET_OVERHEAD	10
+	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
+		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
+		   Bpp - HBLK_PACKET_OVERHEAD);
 
 	/*
 	 * And I'm not entirely sure what vblk is about. The driver in
-- 
2.18.0.321.gffc6fa0e3

