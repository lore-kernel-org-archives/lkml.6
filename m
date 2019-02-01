Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F062C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E258F218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Cl9237Zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfBAPmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:42:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40846 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfBAPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:42:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so6167624lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CvRh+lhKmHHKkuw4aE/avnLB9iVsPqvkmbgt9/tcc0=;
        b=Cl9237ZmhAZM+nDRRTR+SVUVYqvlUfgRSp9sa5t8N1qJ5ZA805AQ4tH+TD7ztwLWST
         8x6nY5+r5Pg0cMmfgZQVhcedaM/NkT/5dX7jnxyrWO+XZyldYrdoqzcVr1Q4rZigE6uF
         af11TT8DYsZHj3gAuQ8EW1bPaTFA1jP5IDPWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CvRh+lhKmHHKkuw4aE/avnLB9iVsPqvkmbgt9/tcc0=;
        b=LqIuP8FVbD1lCkjJT1eK/k++XpEomwsNSyKzSbn2ifC3xIk4jVO99NpygKSoW7e4P6
         WBSqAOAX9z6TfF6BbYIqjR44iJxdN+CWlWBZpAsPZWyOyPe+3XPMI58AXS5bWOlKKhOa
         AK7jZuAPKpDzTc4jJnfVrkgyubeHZt7xGZsiPrFc/DaE/7p7U38sHey7e85Jz8TnkRfM
         +SL4amyj50mm247vMEoiTrv0vti0GjqePyS9yNozUSFASdgZKdBpXy4/+D3JLd+s4J3x
         SxDi39ZzrtXx+xJKTdO0t8ULHnbBABNXF3YInZ3hYt3MNIowET6ru7AMEwxVHsgwEKJQ
         SuTA==
X-Gm-Message-State: AHQUAuYN7ltJoGZ56GrqLp/c3UB05jqHHDHFQJLyxkdtMaiCxQ0fpMzI
        o6XZbisdNvT/btjvWfnpreBmlFCLNuEksLuT
X-Google-Smtp-Source: AHgI3IZSyZEjd/uuBNj8z5Gb1VKqc7/TdJVgFfWgCLRelTrh4xlWzq2odByzPCLT+9+tpu16YiiYYA==
X-Received: by 2002:a2e:9ad0:: with SMTP id p16-v6mr6897329ljj.102.1549035769983;
        Fri, 01 Feb 2019 07:42:49 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:42:49 -0800 (PST)
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
Subject: [PATCH v7 03/23] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
Date:   Fri,  1 Feb 2019 21:12:12 +0530
Message-Id: <20190201154232.10505-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
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
index 813d5523f1c7..0f02bcc997a5 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -477,6 +477,12 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
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
@@ -515,6 +521,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 	vblk = 0;
 
+alloc_buf:
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
 	buffer = kmalloc(bytes, GFP_KERNEL);
-- 
2.18.0.321.gffc6fa0e3

