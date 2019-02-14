Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485E2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F4D222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JTxgTxcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439787AbfBNTdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:33:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34700 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437266AbfBNTdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:33:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so3673129plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VMKk6PGn9i1BoO8FOUUuNIi7jW6XyTdiZlLmf93b6U=;
        b=JTxgTxcwgB81iNX1gtQGeVHqLDQQE8FtOIge1cIWQ2bunLOPZjShyWmZOlOpFEZmc+
         UjQ6nu7sPn3AYX/ZprtwNCfKHWcuQOJxbSZ2X1cYy3ArI6ZuYRKIRPpMY5kvy9GZCDEC
         dmisNUAInbvCt/1Cvuy9seOMYsl/6Oj6bgwE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VMKk6PGn9i1BoO8FOUUuNIi7jW6XyTdiZlLmf93b6U=;
        b=H7m/zi+NB+IHfLDm/eA/MuYl+fmptPaQJiFt+5c08UxPXJnzobH6OiVJsnBWkYlX62
         WxIhx17Q0i0HqGQTwDERfZEM5pEo5qyPvhoxE3PYLpedIc7MUzk1VlcuPaVsUcPb/BtR
         6xOonGOTJo4d0rIn0T4HVJ5yeAkS5TPQBygJPFWKGEletmIQtdO1yN9z1joc2lYKEhsd
         H3GfDyOUcIONH1dZpfHQD/FR5f0y7opCBnPx9rfDcIEQZEXLpm3zAaCtqWDJyxUBgA1E
         pIYTQDa/xv9iMWYECtOySbdudjxklvFfPF/jvCL2+TrzQTl5GJ9HB4eyE6KLSbNxsaWj
         yzlA==
X-Gm-Message-State: AHQUAuau6TPHUR3WJomP78HjQVjLpMbTD2g352uu2gWOBCqQ9qEYgVK3
        Ld0PQCPjLumJ/+JNxWF20iXQhQ==
X-Google-Smtp-Source: AHgI3IaVnH7vqxvpWqtMvQ+l205UdbIhTt83vP7v58ygsEbw0XAdgz53meHQSapcpkoZoDen9txtQQ==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr5933126plb.192.1550172781435;
        Thu, 14 Feb 2019 11:33:01 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:33:00 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 03/10] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
Date:   Fri, 15 Feb 2019 01:02:30 +0530
Message-Id: <20190214193236.7504-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Burst mode display timings are different from conventional video mode.

For burst mode most of the timings hsa, hbp, hfp, vblk are 0 and hblk
is computed as (mode->hdisplay * Bpp)

This patch simply add burst mode timings without touching existing mode
timings.

Reference code taken from BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hsa  = 0;
dsi_hbp  = 0;
dsi_hact = x*dsi_pixel_bits[format]/8;
dsi_hblk = dsi_hact;
dsi_hfp  = 0;
dsi_vblk = 0;

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 1a0707468121..4362d9df1da6 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -516,6 +516,12 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
 	/* Do all timing calculations up front to allocate buffer space */
 
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
+		hbp = hfp = hsa = vblk = 0;
+		hblk = (mode->hdisplay * Bpp);
+		goto alloc_buf;
+	}
+
 	/*
 	 * A sync period is composed of a blanking packet (4 bytes +
 	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
@@ -554,6 +560,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
 	vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
 
+alloc_buf:
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
 	buffer = kmalloc(bytes, GFP_KERNEL);
-- 
2.18.0.321.gffc6fa0e3

