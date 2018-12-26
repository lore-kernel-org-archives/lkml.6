Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C10C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4546E21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPVp8VBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeLZMLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 07:11:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44940 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLZMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 07:11:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so13705634lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 04:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+X0w/THYbT3kbTpjSVwr2WN+4tEBcCin8XCOgT3iv2w=;
        b=rPVp8VBtmMIMBtT8jATY75owFpc5NiNuVhYUlldMQZd2IvDYUarP21JlfJUXKfR3D+
         RhAqQuIz89MGwrz187kqf8E9HrL6pJWqd1RTxkEMMMtjoCy/BpaZytpd4xKNoqgcjKdD
         KiN8dLeKvRogtpyC8cyUkAhkdKcXCEexgdiNKF4ps4xKagx3xw6mVGG5Fm/aqom+BdLK
         6BUAfoLAQzAR1TldgZ4QbDoduhiqCzFX1R5xkMWBTlOGWrHETFfp2EaskyZIYhvdLCf8
         Ft2cUAiJszzH3MgOg8V2k9Hq/srYa8VqT3cspIF5AypLpCLN8SxtlAaZqXkTc+n0bQ/v
         76vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+X0w/THYbT3kbTpjSVwr2WN+4tEBcCin8XCOgT3iv2w=;
        b=ssNBOQm6K+1uSqiwXBIMT7VwatcpsqGq22Wpi0QiIaHnWyJch96jrvL2YHayOTlNHx
         VSDABIq5GHQcs4A1jip+qmWfbAgnMv0Yyswmt3n3pMpzHxFGJyzyct2X+d7KzUGrwvAl
         mU82eqgTuHYwnWN4cinHKMfcgETi3RHVn9+P0VqXClWc7yMxwwHetFZY6M/B3juPpGtZ
         cyjG346HK8evk9N2sa8lGoEYCyOm7FV3UgZdaxgPskpU5ykQYQuABZj93S3EceTysOrJ
         TXjJ+GjUy85uiNAdfPQ3Kn2SsCYQRzu7Qme8LFGbHgJohvbj4koqBLtzAWncw/Zck+nz
         Ud6Q==
X-Gm-Message-State: AJcUukeJexaWtfxHNZwz4PA76GFaUb5GtmhFARlK/EMbO9qbwATqHUK/
        dZH2QhZqGGMeSHfS4R1JnZvWfpRZfIGb5Q==
X-Google-Smtp-Source: ALg8bN6mrzHWIaX1o1ulGrIteBPFQzA+28Qv7LNUjtdRBBi2HJcNEWYI8lP49Nqk3NYZacs2nCGVlw==
X-Received: by 2002:a2e:9556:: with SMTP id t22-v6mr12374903ljh.36.1545826305892;
        Wed, 26 Dec 2018 04:11:45 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id q6sm7037684lfh.52.2018.12.26.04.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 04:11:45 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Ivan Mironov <mironov.ivan@gmail.com>
Subject: [RFC PATCH 2/2] drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock
Date:   Wed, 26 Dec 2018 17:11:24 +0500
Message-Id: <20181226121124.1632-3-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181226121124.1632-1-mironov.ivan@gmail.com>
References: <20181226121124.1632-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strict requirement of pixclock to be zero breaks support of SDL 1.2
which contains hardcoded table of supported video modes with non-zero
pixclock values[1].

To better understand which pixclock values are considered valid and how
driver should handle these values, I briefly examined few existing fbdev
drivers and documentation in Documentation/fb/. And it looks like there
are no strict rules on that and actual behaviour varies:

	* some drivers treat (pixclock == 0) as "use defaults" (uvesafb.c);
	* some treat (pixclock == 0) as invalid value which leads to
	  -EINVAL (clps711x-fb.c);
	* some pass converted pixclock value to hardware (uvesafb.c);
	* some are trying to find nearest value from predefined table
          (vga16fb.c, video_gx.c).

Given this, I believe that it should be safe to just ignore this value if
changing is not supported. It seems that any portable fbdev application
which was not written only for one specific device working under one
specific kernel version should not rely on any particular behaviour of
pixclock anyway.

[1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c, vesa_timings

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index aff576c3c4fb..b95a0c23c7c8 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1690,9 +1690,14 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 	struct drm_fb_helper *fb_helper = info->par;
 	struct drm_framebuffer *fb = fb_helper->fb;
 
-	if (var->pixclock != 0 || in_dbg_master())
+	if (in_dbg_master())
 		return -EINVAL;
 
+	if (var->pixclock != 0) {
+		DRM_DEBUG("fbdev emulation doesn't support changing the pixel clock, value of pixclock is ignored\n");
+		var->pixclock = 0;
+	}
+
 	if ((drm_format_info_block_width(fb->format, 0) > 1) ||
 	    (drm_format_info_block_height(fb->format, 0) > 1))
 		return -EINVAL;
-- 
2.20.1

