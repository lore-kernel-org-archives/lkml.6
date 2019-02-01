Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78715C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F6D218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="L5Yb0b0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfBAPrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:47:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41327 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbfBAPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:43:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so5363621lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84THfXXcgvHcJWr1/uOYg32V3kLlV4Ule+FUJsuojRc=;
        b=L5Yb0b0JI9GGktwopEnSvepURroFbEHVxRtM15IoDKL1JhwJG3ZBwGQgJ2sh3Rw5TA
         iDnws8KdDnCZMRbe+mXF69inQx7rAj9LpRRoXCzEOHZ8qyoDBHVXGo5T0GGAVuQsJbx/
         kCmLrxPE+erOMMqggrGIWCRrZH6tHpGsSk1N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84THfXXcgvHcJWr1/uOYg32V3kLlV4Ule+FUJsuojRc=;
        b=XX48LTQuMfnqFqWnaIlYCt74FCS526cuLKwMH5gTGr61Bv+3ePJMTwqID1lVveoQ3+
         Gd4DlFpMTi9Sods/5saxoalxD+MMBEIyO8WX1ZUMNN6bYWR0o6m5xYI9s16cwlYnYSL0
         +GyyE2btTYRc246jt+wsqPnAX2E0BLLp8WQKglxIvf7A45RmHqa4vI68y+R2XiK40+2a
         ktoLxEcXaFuGI6yzOUpwK9NoryLnFDi7whVCxlt9QnBnGex70cRm4G+snFEq+UNQGb8T
         WzbsrDWUYJDQo5c14t6dEhXyO3r4kIBp+Du/jbL9dJ7yBfO632Z0XDgoJm/Yg3JqVDf8
         LS2Q==
X-Gm-Message-State: AJcUukeDCXhLdLxdOKevR6iNOqVO+i6LhdE4o60SslqOgvchdBbVRa09
        RBTJzu/yh0sLkpLLEy3i3jG1qg==
X-Google-Smtp-Source: ALg8bN7eWAS4XWIfCIU/GKq6nDCT+Mcco6ruQsm5PRsdG39i7pjM42SH4WVYRmLXcxOYg7dqPiZlSw==
X-Received: by 2002:a19:db82:: with SMTP id t2mr30736640lfi.130.1549035779099;
        Fri, 01 Feb 2019 07:42:59 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:42:58 -0800 (PST)
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
Subject: [PATCH v7 08/23] drm/sun4i: sun6i_mipi_dsi: Enable trail_inv and trail_fill controls
Date:   Fri,  1 Feb 2019 21:12:17 +0530
Message-Id: <20190201154232.10505-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The burst mode panels with 4-lane would require to enable trail bits
in DSI basic control register.

So, enable 2byte trail and trail_env for 4-lane burst mode devices.

Allwinner A64 BSP should also relie on same setup for enabling trail
bit in DSI controller.

Reference code avialable in BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

if (panel->lcd_dsi_lane == 4)
{
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_inv = 0xc;
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_fill     = 1;
}

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 46ad142e66e8..a2ad9fa7f8d5 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -33,6 +33,8 @@
 #define SUN6I_DSI_CTL_EN			BIT(0)
 
 #define SUN6I_DSI_BASIC_CTL_REG		0x00c
+#define SUN6I_DSI_BASIC_CTL_TRAIL_INV(n)	(((n) & 0xf) << 4)
+#define SUN6I_DSI_BASIC_CTL_TRAIL_FILL		BIT(3)
 #define SUN6I_DSI_BASIC_CTL_HBP_DIS		BIT(2)
 #define SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS		BIT(1)
 #define SUN6I_DSI_BASIC_CTL_VIDEO_BURST		BIT(0)
@@ -464,6 +466,10 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 	/* enable burst mode */
 	regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
 	val |= SUN6I_DSI_BASIC_CTL_VIDEO_BURST;
+	if (device->lanes == 4) {
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL;
+	}
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 }
 
-- 
2.18.0.321.gffc6fa0e3

