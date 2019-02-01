Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7DEC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAD0218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TFDss/Rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfBAPr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:47:26 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45727 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfBAPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:42:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so5343345lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TFKtwWbXDyUWT8qfJQdNKmTE4M3/0ezirQXsds5l2UY=;
        b=TFDss/RbpOFlaY0pWWUTNxWwScvM6xjusFKv0iPtef7zFK/kvLYAlgDybWbhac398K
         fSO9j4Q92zuJCwOI0Bf2W4fgV2Ru6//VyG8oEMG+cr3hml2NaPvTD4x/Sbd2YhDxcSQt
         YYqXzbcdn3lxNnXm0Ezdev5F1ZXUBfEZWAQw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TFKtwWbXDyUWT8qfJQdNKmTE4M3/0ezirQXsds5l2UY=;
        b=MJ778b54THy6dKsKwouLEItyosim5hVJO2RPjPm3dmEcJKvk2w9GmOg9pZS/8HkL3w
         AdyK8j7NfWFoE12PgLRdgduFqzHdaetyC4hVN0o10khB6G73jUEZGjvozk46GPb8F307
         8BBaJgzl1X5zNIpEZjZPRijTJ2X1b1gRLmkv6H3Yw8RAbrLbz2O1iYEadZDhT4YSULvO
         CThYA5bjrnTwfL3WHDySIM0XnMX6+HZ7so7ndUYOrmKs4WquFNvjXhiU/3F0GoVyreB+
         DwZwQrl2GHCYYw60m0bC3lj/w7JOwiKdMMFuxVzSTxGD0YH0r9lT4/mpuLGSNO3XYMDc
         Z1lA==
X-Gm-Message-State: AHQUAubiqxWXRYacEx3kxtiJUGIx4AZm588IVGvOu9uJWHvgM9y0EFGD
        4sO6nLyg9mKzbkTiG2wkGL3NOA==
X-Google-Smtp-Source: AHgI3IZ0Z2Ru8GyS56Z09JmdGKrORyR6EsHkGG9PJJ1Tsacbdb7LlqphoL23RjCgnvd1ilES3r1KVA==
X-Received: by 2002:ac2:4254:: with SMTP id m20mr354627lfl.131.1549035772005;
        Fri, 01 Feb 2019 07:42:52 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:42:51 -0800 (PST)
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
Subject: [PATCH v7 04/23] drm/sun4i: sun6i_mipi_dsi: Simplify drq to support all modes
Date:   Fri,  1 Feb 2019 21:12:13 +0530
Message-Id: <20190201154232.10505-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner MIPI DSI drq has enable mode bit and set bits.
1) drq for non-burst, with front porch less than 20 would need to
   set both enable mode bit and set bits.
2) drq for non-burst, with front porch greater or equal to 20 would
   not require to do any drq bit setup.
3) drq for burst mode, would only need to set enable mode bit.

This patch simplifies existing drq code by grouping into
sun6i_dsi_get_drq and support all video modes.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 39 ++++++++++++++++----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 0f02bcc997a5..16a86d35dc5a 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -354,6 +354,28 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static int sun6i_dsi_get_drq(struct sun6i_dsi *dsi,
+			      struct drm_display_mode *mode)
+{
+	struct mipi_dsi_device *device = dsi->device;
+
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		return SUN6I_DSI_TCON_DRQ_ENABLE_MODE;
+
+	if ((mode->hsync_start - mode->hdisplay) > 20) {
+		/* Maaaaaagic */
+		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
+
+		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
+		drq /= 32;
+
+		return (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
+			SUN6I_DSI_TCON_DRQ_SET(drq));
+	}
+
+	return 0;
+}
+
 static u16 sun6i_dsi_setup_inst_delay(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
@@ -381,21 +403,8 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 				  struct drm_display_mode *mode)
 {
-	struct mipi_dsi_device *device = dsi->device;
-	u32 val = 0;
-
-	if ((mode->hsync_end - mode->hdisplay) > 20) {
-		/* Maaaaaagic */
-		u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
-
-		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
-		drq /= 32;
-
-		val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
-		       SUN6I_DSI_TCON_DRQ_SET(drq));
-	}
-
-	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
+	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
+		     sun6i_dsi_get_drq(dsi, mode));
 }
 
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
-- 
2.18.0.321.gffc6fa0e3

