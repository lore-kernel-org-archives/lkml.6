Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C42C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FE2218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qKd0pOO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfBAPnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:43:24 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36722 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbfBAPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:43:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so5406183lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HCfeblJM295xUwYmq1O4nQM6M/sp8O5EDl8sZwLE19Y=;
        b=qKd0pOO1oF0w8l1IMfWaCR2fawNphvOas8WKCq+ZLZVOaYSkCePChiHs6VGFVjbe1C
         4Vwq28URvc0aMxMYpVmoGCMMcitMw4MyuoWazMfLMuQT99vc4+ABS+0z+tsM8aCgC0uj
         Nhj6ujIu8F/BWtatYLx1nUYXTQwieF0Gp6kjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HCfeblJM295xUwYmq1O4nQM6M/sp8O5EDl8sZwLE19Y=;
        b=kOJvxy7xGxe55kWA90IlwCXSTTdk1hl8M0gIRjgDidn+g1jRhLljsZkFWS2ZksMUek
         tWabrGKZEUyLocE02Gsyy/wXv8LL/pAdHXu0pjtrSmipO5brwybaq78eMqf0UhNdRpd6
         eIgHwfgveL+fq3SyQ9Y3J3S16CpHIUN2cS+21gA6fQwbU6/L406qx/AU3n2Zi8vEKr+d
         b+COqtMc46FWimfnezpIgxs2OItbc+EcpfsXpLziTH7uILCNh4XdcqZ3frJ8RsAkA5sV
         84ygbOrr1nOoYR+5JCJOMaKg8OPIMoxCOsOV1r8341xbAQwiwTzPeAwCODai4LI87qO+
         2ksg==
X-Gm-Message-State: AJcUukdVpZridCpsQqrPvOeA3/BcTezpPQnC+Ut+D2v6BRjPiaa9V3Qh
        vvyegxBFeB9Ong6NNxrJi45rkQ==
X-Google-Smtp-Source: ALg8bN5fouNEgg+ckpry4ROI75OI8fDKR31hyP0zwcZIEdl1kD/XHcwX9BYyTIJK+o0XGbyOAyV1hQ==
X-Received: by 2002:a19:d381:: with SMTP id k123mr30788667lfg.101.1549035800895;
        Fri, 01 Feb 2019 07:43:20 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:43:20 -0800 (PST)
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
Subject: [PATCH v7 21/23] drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
Date:   Fri,  1 Feb 2019 21:12:30 +0530
Message-Id: <20190201154232.10505-22-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
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

So, update the MIPI-DSI hbp value accordingly.

Tested on 2-lane, 4-lane DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 09569938c20d..780b1906c661 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -579,7 +579,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 #define HBP_PACKET_OVERHEAD	6
 	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-		  (mode->hsync_start - mode->hdisplay) * Bpp - HBP_PACKET_OVERHEAD);
+		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
 
 	/*
 	 * The frontporch is set using a blanking packet (4 bytes +
-- 
2.18.0.321.gffc6fa0e3

