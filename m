Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42589C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0717B2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0ek0Kaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfAHHYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:24:39 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38525 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHHYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:24:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so2526103lja.5;
        Mon, 07 Jan 2019 23:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSk+FSxPxS6iMisbvB7H/rsju0PE7UdrYs5P4efdO58=;
        b=T0ek0KawjaJqyQm3qvMVk4a0QL78wVitE9x6v+Foyv5eEBn34mk9DUcT4XmgQB6Lyp
         IEvaQObeNNoO5sI+aBHOQpLjQkSuGbZ0Vpn1h29HxdrbnobOGjfYVtp2AprjlnlrsNFd
         mty5T2s2G1Z48p+s3xsE9y9aTC4tLLyRHUUunaRg2CUfeVrg2u4tudVzNZLd73tNUfJa
         aBApxo1ioorwxr1R1aUl/U1b5HYNoFuARVmAeQonm2zLmrzY7RxZSM33iPVhE8ZhgiEE
         TlleZtXva5AEhl2DEM4xOpNz+o+7scqn83wNBvbLQ8vudCyHoCbexcFVv2WmvomQ360M
         XxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSk+FSxPxS6iMisbvB7H/rsju0PE7UdrYs5P4efdO58=;
        b=W6g1jeWiFHK7obaI4Ei6ZSf0cvGpDVlRO1TsrvRGHSjJ9l7zeThezxVz+pJ5YbotUf
         Co973a/uW6e4T22q6NDFIuD636zNgQz9eU3z++p5efk1EdWx93k/5EK4W2XUsVi/REhJ
         dcSj6UX7Zma4Xzy26efuXfmkf1A7L+3wp++ag/9N/fY7SJCAhBVo2ezMI6IpAv456bNI
         EnWCTJPvGVPl+bW4sK7dm2r3jbR91+EHgl3swekmjvtwS+ii1fWMSPBFnwTqXdThQOw5
         XYA046PeQFZ0BHpXvt9kaUTGKhPntuHmmdW8nbuIjaOO77L/M5ZVREU7rmaPVKphMqcQ
         laUg==
X-Gm-Message-State: AJcUukdIcGdbjMUqurB/ippRPXVWkgRN0vr8nXPl9LFtVjm1wHevwGKR
        YdwFaF6K7wJ9komYkcOrivk=
X-Google-Smtp-Source: ALg8bN5v+GX5sIkW1uExP18aQn04rX90OMIuYAuJP+Q3fFdx1g5MInlvkqdX1HQxtJScv2t1MA/BWA==
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr398448ljp.12.1546932274768;
        Mon, 07 Jan 2019 23:24:34 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id t144sm12858447lff.53.2019.01.07.23.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 23:24:34 -0800 (PST)
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
Subject: [PATCH v2 1/2] drm/fb-helper: Partially bring back workaround for bugs of SDL 1.2
Date:   Tue,  8 Jan 2019 12:23:52 +0500
Message-Id: <20190108072353.28078-2-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108072353.28078-1-mironov.ivan@gmail.com>
References: <20190108072353.28078-1-mironov.ivan@gmail.com>
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
 drivers/gpu/drm/drm_fb_helper.c | 142 ++++++++++++++++++++------------
 1 file changed, 89 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d3af098b0922..ed7e91423258 100644
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
@@ -1654,6 +1712,36 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
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
+		/*
+		 * There is no way to guess the right value for depth when
+		 * bits_per_pixel is 16 or 32. Instead of restoring the
+		 * behaviour previously introduced here by commit 785b93ef8c309,
+		 * we decided to just use the current depth and do not perform
+		 * any guessing.
+		 *
+		 * Also, if requested bits_per_pixel differs from current,
+		 * the next call to drm_fb_pixel_format_equal() will fail
+		 * resulting in EINVAL error from ioctl().
+		 *
+		 * However, this still leaves the theoretical possibility of
+		 * situation when userspace app requests different pixel format
+		 * and ioctl() call silently succeeds. Garbage will be displayed
+		 * in this case.
+		 */
+		drm_fb_helper_fill_pixel_fmt(var, fb->format->depth);
+	}
+
 	/*
 	 * drm fbdev emulation doesn't support changing the pixel format at all,
 	 * so reject all pixel format changing requests.
@@ -1967,59 +2055,7 @@ void drm_fb_helper_fill_var(struct fb_info *info, struct drm_fb_helper *fb_helpe
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

