Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A4FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E2721720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 12:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PonPAo27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeLZMLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 07:11:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34831 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLZMLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 07:11:42 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so10769521lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 04:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F030EOuJKkwrgutE+wPfUksI1/S5UnGcRtqdbQasBk0=;
        b=PonPAo27QLY2CFNijRJuwqFNNZLVJOt1U82xFviGTfC96sUu+ZYCHNRdocATkrEDwk
         bgK8bm7reg5RTFuz8wzNHM4mzUH2pFW0bkparJN3gcs/2/CpnDeSVIBMcG76XiRUmxu4
         kHPkdR63hBdp/RVIJg39zTizRLLzbd03GKMQPtOHvhLPU/tNuJdmUkeRFSyQpm7eueQS
         IVp+jKUZXuAOwl94pNal5BQi62w5HaD6MEM8Sbx5RhRjnYHihM6xe/8cicVqUcWiAkOd
         B2cM2VpKgohBtCeO2yNW39nrQu3Lg5NYbKnolY595OvQXUMajlx4KgsZKkIzusqG8ItR
         5Qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F030EOuJKkwrgutE+wPfUksI1/S5UnGcRtqdbQasBk0=;
        b=b/aCgkFnNTbzf40UglJxydu8qeD0A4rrlD+h82Zs4uA0TfcUZsh+OikAiApPTO+xHM
         AyYAuadW76ZjrEBoDRN3ZehjB2Kh4u7mFCN8IFHXKSu5u5p7IJ+k49a01U9kkylAFV2G
         9ZovXy6YQ0XURSW5CNN/bzm+Nuaz2MVyKu4Jr5GSV1ln+q02utCAjwiR0nzopxFKr0uY
         dg0tv8msBA520G9qdsXmdOInZk35FxhnFni+XP7ForCPzYm9DubFdMp2AzTvFnDlo82R
         33WxqDFt6AxjpbiQs3IwfOPbttO6UVMT77mUPT99aqq/KcOkhMZ9fhoIKyunVg6qRF3Z
         XMNw==
X-Gm-Message-State: AA+aEWZDBYf74VOQPMd02BGbmdVawUBG5vSv3lO41iGEnHf3TT6JuGcU
        AFVqqWZy/6+cq/bUWM7ggb4=
X-Google-Smtp-Source: AFSGD/XvTebHyi2v8UJiDzaOR+h7D0A4RJcLpyihBVWwn/cOuszcNTF+JivRrtaFKmft8TsUP3i2Aw==
X-Received: by 2002:a19:7111:: with SMTP id m17mr9487949lfc.64.1545826300397;
        Wed, 26 Dec 2018 04:11:40 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id q6sm7037684lfh.52.2018.12.26.04.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 04:11:39 -0800 (PST)
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
Subject: [RFC PATCH 1/2] drm/fb-helper: Bring back workaround for bugs of SDL 1.2
Date:   Wed, 26 Dec 2018 17:11:23 +0500
Message-Id: <20181226121124.1632-2-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181226121124.1632-1-mironov.ivan@gmail.com>
References: <20181226121124.1632-1-mironov.ivan@gmail.com>
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

[1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c,
    FB_SetVideoMode()

Reported-by: saahriktu <mail@saahriktu.org>
Suggested-by: saahriktu <mail@saahriktu.org>
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

