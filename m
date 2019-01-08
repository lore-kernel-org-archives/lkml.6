Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E52EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF972087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX8kx9pK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfAHHYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:24:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43696 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHHYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:24:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so2148336lff.10;
        Mon, 07 Jan 2019 23:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbItvwxjvupbEvRykK89kKeIS1oBmUTv7NKg0MnTZSk=;
        b=PX8kx9pKNQr4fJDsyqcJs7y2KjsCYtR7lQckDFAGkg60dUP42NxaO1PuyRvI/4VMz/
         POoKbpuyG4E+EJIypCJ2h3oPDCFDUJI9Ua42O4PTBEQ4j+A5UpRzdEdcYdoypa6sHHZ2
         fXmlqylcpnqln3oMEbiFSe3cEdRqqWjAZmgY9fLzlgl9Sh7TpizTYgzQXT4gxbuvzfms
         gfbJIBlvFW4PZzSVye6UtcAXpqmvcJEqQ5uGCMfnMtXG2UGLQcBv2yHk4qyAvetui87p
         kO/FNr+sq3ZalFPysXwB6cnLV0cQ3Zq+Uhf+Of4ZMzT+ePqoPAFXlgQ0Qq4wRaHb5MK6
         zPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbItvwxjvupbEvRykK89kKeIS1oBmUTv7NKg0MnTZSk=;
        b=YDImrx7skxJj65YjILEXje3/6rHzcJSKt0aKGfAxLKxA5YIHode8UiXO+NzwBFVs6k
         75zC03zFQpSklABI1bvcxYVXgBQZ0xAeOkncKcnPknUjpwc4f9L5c6rNoWfYMlrWceQI
         92Ch5E1ILFn5tx54XdyDmN3u3a7vDQpkkH/uI3Vp0+wSxxM/EWrCGF7p4unaKI2uCeP/
         /Zi0OkSu2DnkTDr4rYVHWX+SomP9zMi4DoNOrz5xND6ZvtQV8ntdlBnB4JZb6OXoWXUI
         rW8k1NOW/8VG3kAU5q97Z3SQvvNd4qcUrqPrDw80IqAtUrMnISprqIUKfNfCL3JTlLU7
         ajxA==
X-Gm-Message-State: AJcUukdJdaYyF9N+pv5PiYbbTuRl8FPEISl4JQGJt4xqoy1unu0FesaE
        neK3h331/TjL933iJLQxtll/rNmIeP4=
X-Google-Smtp-Source: ALg8bN5/psra5kKoxpYN3cYQACgx/UhIbLd4st8SL11EO68LDfIVNu3Paif7N6NFSk3O5wiP0+gwhg==
X-Received: by 2002:a19:1bd2:: with SMTP id b201mr350922lfb.136.1546932278989;
        Mon, 07 Jan 2019 23:24:38 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id t144sm12858447lff.53.2019.01.07.23.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 23:24:38 -0800 (PST)
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
Subject: [PATCH v2 2/2] drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock
Date:   Tue,  8 Jan 2019 12:23:53 +0500
Message-Id: <20190108072353.28078-3-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108072353.28078-1-mironov.ivan@gmail.com>
References: <20190108072353.28078-1-mironov.ivan@gmail.com>
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

However, while enabling SDL1 applications to work out of the box when
there is no /etc/fb.modes with valid settings, this change affects the
video mode choosing logic in SDL. Depending on current screen
resolution, contents of /etc/fb.modes and resolution requested by
application, this may lead to user-visible difference (not always):
image will be displayed in a right way, but it will be aligned to the
left instead of center. There is no "right behaviour" here as well, as
emulated fbdev, opposing to old fbdev drivers, simply ignores any
requsts of video mode changes with resolutions smaller than current.

The easiest way to reproduce this problem is to install sdl-sopwith[2],
remove /etc/fb.modes file if it exists, and then try to run sopwith
from console without X. At least in Fedora 29, sopwith may be simply
installed from standard repositories.

[1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c, vesa_timings
[2] http://sdl-sopwith.sourceforge.net/

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 79e539453b34e ("DRM: i915: add mode setting support")
Fixes: 771fe6b912fca ("drm/radeon: introduce kernel modesetting for radeon hardware")
Fixes: 785b93ef8c309 ("drm/kms: move driver specific fb common code to helper functions (v2)")
---
 drivers/gpu/drm/drm_fb_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index ed7e91423258..2d4c2b38508e 100644
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

