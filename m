Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B950C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1920521726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="o7lyrIkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfAXUBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:01:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34082 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbfAXUBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:01:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so3549788pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8SYjzJk1Ajw/4LSvmuyBM6xgYSP98STN7cje2swaDiQ=;
        b=o7lyrIkTLas5a3xgc3B+h3z+ZF1kayWCYA+DRkIO5xFRgGUGwXFhXy4u65Kg8OdoW7
         PHTG65m5HHlswX7p3b0zjZCTvqG+lf/LxEQHuRQI0F1nHBdA+ywmODr3C9+hePv4d5GZ
         fPcIILMmRq3oflwNoVMKkNL2hnpIRqihybDbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8SYjzJk1Ajw/4LSvmuyBM6xgYSP98STN7cje2swaDiQ=;
        b=RcOJRzuQaa1vtiW5m76Us6txjFiY4MPWDr8XV25VahdOarmw/pP29jsH2EQdYMAfXB
         k8GnQdm4OEravnw4EbrvIj+AzvCJULoz4iMjE/GAFgJRL6Bm+qIH8Gasc5GyUCsr+ASt
         RnR+3Q6wQrMJiWJCvBESvHXs3NNOlQuwrY1+Bkm1Vw0gJGup9NjtXFR1gX5kY64BeKQe
         77Kh+W/qUmPKJORIqCg1CkztKv8Ydv1kgIGhlRkMHogEAYln46k7lKhuUt5jIS1loE+j
         WVBF5E2r2t8fTwmXtvisiHqu1Cx+yRu5sztQ5Cmtkdb+A+jdSc5VwotUHTLjcUFSiAeU
         3SbA==
X-Gm-Message-State: AJcUukcN4YQPjAGyQTdERDy8xE5yOi30eu97EQnlNCpnjVLFz+MNsG55
        HxiLZGfqFb7rE7CdeToW3i8rKQ==
X-Google-Smtp-Source: ALg8bN5cmk131g1Yx+/XYabfpyhyd48ETdfvdb+yZtMMsEbaOYRmvgmU9pzpfNN5bjLaF9GhQ5eJtw==
X-Received: by 2002:a65:590b:: with SMTP id f11mr7269183pgu.60.1548360076442;
        Thu, 24 Jan 2019 12:01:16 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:01:15 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 21/22] drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
Date:   Fri, 25 Jan 2019 01:28:59 +0530
Message-Id: <20190124195900.22620-22-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver is calculating hfp maximum value by subtracting
htotal with hsync_end which is front back value, but the
hpp refers to front porch.

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

So, update the DSI hfp timing accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index e24719cabba2..9f72eb5f54a6 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -586,7 +586,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
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

