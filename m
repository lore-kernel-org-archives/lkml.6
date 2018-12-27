Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC6FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9D02148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVc7p2vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbeL0XNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:13:53 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37465 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbeL0XNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 18:13:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id t18-v6so17388205ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 15:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URbOQWmYlI+0we5iK6KytIpNXXKBn6Nr5IN7n0Yz/s8=;
        b=JVc7p2vg47jpzOp1VljS0TkPW59iHI/nLLd2aFl1zYJPD0ElkCthJDPXWi2kODYSZ+
         uvgswzmwjELV6Aoph7uZWMQIU7f1J0Sf8jaCkX5M+y7WhKKctgqGikyn/RfTZ3JKeoJE
         OPjgzPF/crqisdav7/kIDwtbh3OxgH2eOjpjXI3NrRqZlPvMtEPN8yxZc0LXHDXi0T7N
         LRMfEokWRKuZnfz0WrS/1yO7+N6C/ZNRRFvOHTZP618eF7vaHh3wKWQM+th5fdVhrsYz
         UrCRxCXUjMhn5XHcu4otUZEvBQZpM3lIhZnrvNTXLgS9M7H/ex3cXlJlBR+FcK4k2oSz
         PTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URbOQWmYlI+0we5iK6KytIpNXXKBn6Nr5IN7n0Yz/s8=;
        b=OcyuqbeA0/QP7gE6KzZihmjc8pqihugHacYzNO9wNlyof4ZZD/ads7CV5PunKCOSl/
         w5hBx3HnUiw0ajpzYDeaCTADykbHW6lMyAnuib2Cmpzsj28B20t4OpAQq0jPLUYIU9ad
         hoWUzuNqktp07himKSTiJJ01Nzc+241rpjq35u/RV7UIXbryQ0vkKOQxdB7tARt02Tvf
         04yk1k4pIydA+YxyyoGgNJJ27XGeCw8y10zmpMw+PTXP8jL1qkSUZMnqMhfODmEgyUlm
         tBN6PAETRLI7ct4BpeyAbzGui4ydKJ1wisxLJJq5fOXnW7GT4Zjc6LjYjybNLnb2KZMW
         c8qA==
X-Gm-Message-State: AJcUukfGfsImUnlW620Bq+Crx2tg2SRYLMfkQQdszDk4nfmi2DP55+qu
        QmcpRMZwd1T4pZz3N9tOwH0=
X-Google-Smtp-Source: ALg8bN425asUwxJURL3RFwjtd60gsg3y1CT8MwPh/xLAe8+ZO502A5TRBIp6zTuULKxUqGusZ1ZmpQ==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr14038206ljd.137.1545952429555;
        Thu, 27 Dec 2018 15:13:49 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id r4sm7834626lfe.60.2018.12.27.15.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 15:13:49 -0800 (PST)
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
Subject: [PATCH v1 2/2] drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock
Date:   Fri, 28 Dec 2018 04:13:08 +0500
Message-Id: <20181227231308.16904-3-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181227231308.16904-1-mironov.ivan@gmail.com>
References: <20181227231308.16904-1-mironov.ivan@gmail.com>
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

Feel free to NAK this patch if you think that it causes breakage of
user-space =).

The easiest way to reproduce this problem is to install sdl-sopwith[2],
remove /etc/fb.modes file if it exists, and then try to run sopwith
from console without X. At least in Fedora 29, sopwith may be simply
installed from standard repositories.

[1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c, vesa_timings
[2] http://sdl-sopwith.sourceforge.net/

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

