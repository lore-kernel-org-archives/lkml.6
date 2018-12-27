Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DADC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8190121902
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMt8f0NV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbeL0XNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:13:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33963 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbeL0XNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 18:13:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so17417861lje.1;
        Thu, 27 Dec 2018 15:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s7NluHPH0KcudBVBenM3kd5Mjfyz5yq92O7AFC6neZw=;
        b=FMt8f0NVrjIvbOvrkZ3dWpmETZP26Zksy5EWKZhLowbGBjDObq/rbC5CnFs0bQ4jaH
         W9bgpZ/G1cUrdKXNIjEytaDSNOC0e2W+VvPn1d79s9u+rYxcCvFrqCGk/FGIMrg+uSJc
         YcPDDL6Zl1AWGAYpmJWYwKxsvquvv5K/+AJwp5/giqMS27NWqUe1WvdrWrR3bvkRNfbj
         LyVw15mA/0viv3nPgWMBbPJKA0doiSvSOKH9N3UraWgBE8m5ihOrQs9lCEsqr8MmN4SU
         IIDvPCvaQZLDSy3o/za9eyk8b9hb6JiCH4UXClbWuV5wAcTBSh7csruREozI+4yutejM
         o+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s7NluHPH0KcudBVBenM3kd5Mjfyz5yq92O7AFC6neZw=;
        b=m5gzoekcbt6qbTUMhvih0UYvf3V8500uVpcZYdEA7Hdee+Ab0+YghA2A0uTDq8CXFT
         CB/ctyaFiiXGK+6+isPWPIdAMkIRj57l3OBE0KNm4MzOUNm+nURwnX6Vfo81OBATFbmB
         aGQNFHwyzM5hW5U2JXGGHm0EJ7D6R99J1dJVrl7KHQywjQxJzKGVLYuFd8tCHJLK+Hg7
         dHJZ0sigxM0BmyfrwzChqFjMIrdu37pSJA4cVff3S25O6//+fFE2jiDl2OICI0KbrIYm
         VxGXJzDd5+0U5VVHUMGDHP9rHY5NDtSVRbjIPVOCtBJntuOyoJ0DovsWrhWVkrywx4Rn
         xWTw==
X-Gm-Message-State: AJcUukcJtH0GfILra9noqadW/jtyrkZjfTYnGMQrIMncRAbY6Wgc+jch
        AVfvBDgWQS1/sdfluLNR+mWPKK71hCsOrw==
X-Google-Smtp-Source: ALg8bN7oV1Jk6I7029fMXxa7Jak1w76EzTXBkhceBD9iH8Q3cnW/cjQXUYCjJ7RY6C9/Xz05c36fOg==
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr16190758ljk.80.1545952424279;
        Thu, 27 Dec 2018 15:13:44 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id r4sm7834626lfe.60.2018.12.27.15.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 15:13:43 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Ivan Mironov <mironov.ivan@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v1 1/2] drm/fb-helper: Bring back workaround for bugs of SDL 1.2
Date:   Fri, 28 Dec 2018 04:13:07 +0500
Message-Id: <20181227231308.16904-2-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181227231308.16904-1-mironov.ivan@gmail.com>
References: <20181227231308.16904-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDL 1.2 sets all fields related to the pixel format to zero in some
cases[1]. Prior to commit db05c48197759 ("drm: fb-helper: Reject all
pixel format changing requests"), there was an unintentional workaround
for this that existed for more than a decade. First in device-specific DRM
drivers, then here in drm_fb_helper.c.

Previous code containing this workaround just ignores pixel format fields
from userspace code. Not a good thing either, as this way, driver may
silently use pixel format different from what client actually requested,
and this in turn will lead to displaying garbage on the screen. I think
that returning EINVAL to userspace in this particular case is the right
option, so I decided to left code from problematic commit untouched
instead of just reverting it entirely.

Here is the steps required to reproduce this problem exactly:
	1) Compile fceux[2] with SDL 1.2.15 and without GTK or OpenGL
	   support. SDL should be compiled with fbdev support (which is
	   on by default).
	2) Create /etc/fb.modes with following contents (values seems
	   not used, and just required to trigger problematic code in
	   SDL):

		mode "test"
		    geometry 1 1 1 1 1
		    timings 1 1 1 1 1 1 1
		endmode

	3) Create ~/.fceux/fceux.cfg with following contents:

		SDL.Hotkeys.Quit = 27
		SDL.DoubleBuffering = 1

	4) Ensure that screen resolution is at least 1280x960 (e.g.
	   append "video=Virtual-1:1280x960-32" to the kernel cmdline
	   for qemu/QXL).

	5) Try to run fceux on VT with some ROM file[3]:

		# ./fceux color_test.nes

[1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c,
    FB_SetVideoMode()
[2] http://www.fceux.com
[3] Example ROM: https://github.com/bokuweb/rustynes/blob/master/roms/color_test.nes

Reported-by: saahriktu <mail@saahriktu.org>
Suggested-by: saahriktu <mail@saahriktu.org>
Cc: stable@vger.kernel.org
Fixes: db05c48197759 ("drm: fb-helper: Reject all pixel format changing requests")
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 146 ++++++++++++++++++++------------
 1 file changed, 93 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d3af098b0922..aff576c3c4fb 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1621,6 +1621,64 @@ static bool drm_fb_pixel_format_equal(const struct fb_var_screeninfo *var_1,
 	       var_1->transp.msb_right == var_2->transp.msb_right;
 }
 
+static void drm_fb_helper_fill_pixel_fmt(struct fb_var_screeninfo *var,
+					 u8 depth)
+{
+	switch (depth) {
+	case 8:
+		var->red.offset = 0;
+		var->green.offset = 0;
+		var->blue.offset = 0;
+		var->red.length = 8; /* 8bit DAC */
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.offset = 0;
+		var->transp.length = 0;
+		break;
+	case 15:
+		var->red.offset = 10;
+		var->green.offset = 5;
+		var->blue.offset = 0;
+		var->red.length = 5;
+		var->green.length = 5;
+		var->blue.length = 5;
+		var->transp.offset = 15;
+		var->transp.length = 1;
+		break;
+	case 16:
+		var->red.offset = 11;
+		var->green.offset = 5;
+		var->blue.offset = 0;
+		var->red.length = 5;
+		var->green.length = 6;
+		var->blue.length = 5;
+		var->transp.offset = 0;
+		break;
+	case 24:
+		var->red.offset = 16;
+		var->green.offset = 8;
+		var->blue.offset = 0;
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.offset = 0;
+		var->transp.length = 0;
+		break;
+	case 32:
+		var->red.offset = 16;
+		var->green.offset = 8;
+		var->blue.offset = 0;
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.offset = 24;
+		var->transp.length = 8;
+		break;
+	default:
+		break;
+	}
+}
+
 /**
  * drm_fb_helper_check_var - implementation for &fb_ops.fb_check_var
  * @var: screeninfo to check
@@ -1654,6 +1712,40 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
+	/*
+	 * Workaround for SDL 1.2, which is known to be setting all pixel format
+	 * fields values to zero in some cases. We treat this situation as a
+	 * kind of "use some reasonable autodetected values".
+	 */
+	if (!var->red.offset     && !var->green.offset    &&
+	    !var->blue.offset    && !var->transp.offset   &&
+	    !var->red.length     && !var->green.length    &&
+	    !var->blue.length    && !var->transp.length   &&
+	    !var->red.msb_right  && !var->green.msb_right &&
+	    !var->blue.msb_right && !var->transp.msb_right) {
+		u8 depth;
+
+		/*
+		 * There is no way to guess the right value for depth when
+		 * bpp is 16 or 32. So we just restore the behaviour previously
+		 * introduced here by commit 785b93ef8c309. In fact, this was
+		 * implemented even earlier in various device drivers.
+		 */
+		switch (var->bits_per_pixel) {
+		case 16:
+			depth = 15;
+			break;
+		case 32:
+			depth = 24;
+			break;
+		default:
+			depth = var->bits_per_pixel;
+			break;
+		}
+
+		drm_fb_helper_fill_pixel_fmt(var, depth);
+	}
+
 	/*
 	 * drm fbdev emulation doesn't support changing the pixel format at all,
 	 * so reject all pixel format changing requests.
@@ -1967,59 +2059,7 @@ void drm_fb_helper_fill_var(struct fb_info *info, struct drm_fb_helper *fb_helpe
 	info->var.yoffset = 0;
 	info->var.activate = FB_ACTIVATE_NOW;
 
-	switch (fb->format->depth) {
-	case 8:
-		info->var.red.offset = 0;
-		info->var.green.offset = 0;
-		info->var.blue.offset = 0;
-		info->var.red.length = 8; /* 8bit DAC */
-		info->var.green.length = 8;
-		info->var.blue.length = 8;
-		info->var.transp.offset = 0;
-		info->var.transp.length = 0;
-		break;
-	case 15:
-		info->var.red.offset = 10;
-		info->var.green.offset = 5;
-		info->var.blue.offset = 0;
-		info->var.red.length = 5;
-		info->var.green.length = 5;
-		info->var.blue.length = 5;
-		info->var.transp.offset = 15;
-		info->var.transp.length = 1;
-		break;
-	case 16:
-		info->var.red.offset = 11;
-		info->var.green.offset = 5;
-		info->var.blue.offset = 0;
-		info->var.red.length = 5;
-		info->var.green.length = 6;
-		info->var.blue.length = 5;
-		info->var.transp.offset = 0;
-		break;
-	case 24:
-		info->var.red.offset = 16;
-		info->var.green.offset = 8;
-		info->var.blue.offset = 0;
-		info->var.red.length = 8;
-		info->var.green.length = 8;
-		info->var.blue.length = 8;
-		info->var.transp.offset = 0;
-		info->var.transp.length = 0;
-		break;
-	case 32:
-		info->var.red.offset = 16;
-		info->var.green.offset = 8;
-		info->var.blue.offset = 0;
-		info->var.red.length = 8;
-		info->var.green.length = 8;
-		info->var.blue.length = 8;
-		info->var.transp.offset = 24;
-		info->var.transp.length = 8;
-		break;
-	default:
-		break;
-	}
+	drm_fb_helper_fill_pixel_fmt(&info->var, fb->format->depth);
 
 	info->var.xres = fb_width;
 	info->var.yres = fb_height;
-- 
2.20.1

