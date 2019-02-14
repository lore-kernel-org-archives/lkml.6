Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144A7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AD621B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="q6e3FOHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438393AbfBNT0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:26:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40524 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbfBNT0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:26:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so3579222pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2syAOh2G4OGCHhPfMkd8JNfHtkJm8hpP6JpgjrXSNMM=;
        b=q6e3FOHZTmmQzss3505cT/xH5CkXq+WIO7l/C5e1VQ8BuVvDv+MBGZhwRxd77mW2iI
         tCG4T7T7Vj4OpCEdiYID/htrKYOksv4q0FZfxtXuw4DXY4Y/0F8Gl/pXPtEBS7Yw7MCA
         cmdmjziaZOeZxT+g2QsC9oSx7xngknrQLPsWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2syAOh2G4OGCHhPfMkd8JNfHtkJm8hpP6JpgjrXSNMM=;
        b=anXOmbaQprEQ08oCZ7nMUqRDosQDC993vTGRDm62MCXmvaRouMJWuHQv6vND6BBN8D
         m7u/0lJ0JvEIlMK9a38x//nI5OL7Yl+0AAkrM0FFniuEGzpM9VfLitB9l1yombiyQsZ7
         DCn6OQmQw+hk2o0/9i7ffj+4b8r/I31ehrDtoT8eho2LLeXqJKiaKcqRf1pWl2s4ebaS
         pShNXmC11ndezZO2tLARpOtjzms/bFJ0YFojKQrqO6mWND3Sw7d2+OC77y/xWS9AREOb
         90ZQv24/CiaFNsiJyVVyw2hS9zuFb+sFLVH/PhCeE7QlJ/rIJaVXfK28v/JN3PhbOH/v
         7Mkg==
X-Gm-Message-State: AHQUAuY3Bi+tD6xWGhviepM9iP8drirwOHEK2VViMvGTBuKbk0UdNSVg
        7cBOC+L3W3kSbTsXoCwa7kSVFumYv0MZdw==
X-Google-Smtp-Source: AHgI3IaUIaaLaj0DjeiCs9lzTeYUZpLtwK6r4ls8yW9TJXb/UuzR7SBlm25xLXoG5M+AVVSqZSJKJg==
X-Received: by 2002:a62:380a:: with SMTP id f10mr5929791pfa.100.1550172372276;
        Thu, 14 Feb 2019 11:26:12 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:26:11 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 2/8] drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
Date:   Fri, 15 Feb 2019 00:55:38 +0530
Message-Id: <20190214192544.7314-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver is calculating hbp maximum value by subtracting
hsync_start with hdisplay which is front porch value, but the
hbp refers to back porch.

Back porch value is calculating by subtracting htotal with
hsync_end as per drm_mode timings, and BSP code from BPI-M64-bsp
is eventually following the same.

BPI-M64-bsp is computing hbp as
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
dsi_hbp = (hbp-hspw)*dsi_pixel_bits[format]/8 - (4+2);
=> (panel->lcd_hbp - timmings->hor_sync_time)
=> (timmings->hor_back_porch + timmings->hor_sync_time -
    timmings->hor_sync_time)
=> timmings->hor_back_porch
=> mode->htotal - mode->hsync_end

So, update the hbp value accordingly in sun6i_dsi_setup_timings.

Tested on 2-lane, 4-lane DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index d70a8c43a4b8..982ae6b17654 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -472,7 +472,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 #define HBP_PACKET_OVERHEAD	6
 	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-		  (mode->hsync_start - mode->hdisplay) * Bpp - HBP_PACKET_OVERHEAD);
+		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
 
 	/*
 	 * The frontporch is set using a blanking packet (4 bytes +
-- 
2.18.0.321.gffc6fa0e3

