Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A7DC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAA32087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjvWd2M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfAEQV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:21:26 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42280 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfAEQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:21:26 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so27383677lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 08:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fawmcFl8ByXhQD2zN+qxz4Z8JIPYUs1NLfZVpDWi9R4=;
        b=hjvWd2M9EUoLAMZTThSpzCkYGUKMejq8RCPUMTChuuaVPpUTGZDnwlH9PsRd3pIXHw
         6LQ9HP5Mzlv/Jlh1yqDdbT8tfLMlTMt9tZadKOR+U/nMgkr/R5tgpg8mWBSidZTwu1qM
         cNu2khccfH6YJj5f6nnDA7lobS4fY4j5j2sOIcL6MT7m1uCipxdSpcHxCwMfDsKdQ6Aw
         GkzTWvA4/1J8QJJcG7xlXOQgCM7Y+IZZ3ND5n1AM4i0xT2rhohDUzQVOphOfc4jDGTw9
         /dwoPrIfw+clzYmN3A9iuYqo+KXmUvsNY6zvBxz6zCVKw4t3xrKfDUV4dgNzygcuW/pw
         6WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fawmcFl8ByXhQD2zN+qxz4Z8JIPYUs1NLfZVpDWi9R4=;
        b=V7P2dqMgU0kFUzPW4M5OOQZyymkG4qrFSWV+ps2jYPjasL9a2BvEn4P+RN7mC/ywMD
         O4te+x57vX7XZ8k+tPpFuxa0G/Lpji11rcmydSoxuBQyyhqyEegHf4Urh8/2Mqo64Sil
         7GB/PUUjGlkBWSmVLqGg0WNF9bak84/FjK8BQH0QbFTJkvUcJTBRrFFcYon381EtzK9U
         sGW9CJYgG4GUvegVbiK96HD98PXy3Ia7j/4OIS0rRKs0YRMPTCR3guguRP2X8UJ8Xdy3
         qMSNqDK0q84REn3FTTW46Ntp0i7AbzBMrCKKeDmwGoy4XFO70sUQQUCDEvAfa0qI1Fg9
         6SYg==
X-Gm-Message-State: AA+aEWboJd0BALKbtmPQMYSfV3FJMQornAMvrVyGGy93nTHx3q33YBYz
        /w2VHTWq5+C/JvQ3f/OdTKA=
X-Google-Smtp-Source: AFSGD/VojdDpRCteWDoDZcRYaxIWiAwtXyc+lPligpT/yVe43NKt4o3VwFQm8N0ZPZcv0ObA0qsNSg==
X-Received: by 2002:a19:280f:: with SMTP id o15mr26732298lfo.0.1546705283449;
        Sat, 05 Jan 2019 08:21:23 -0800 (PST)
Received: from im-mac (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id 15-v6sm14220634lje.18.2019.01.05.08.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 08:21:22 -0800 (PST)
Message-ID: <b9f21efe2fe2d0a71ad6672fbe9155df52ac5e02.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] drm/fb-helper: Ignore the value of
 fb_var_screeninfo.pixclock
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Date:   Sat, 05 Jan 2019 21:21:21 +0500
In-Reply-To: <20181228120652.GR9058@dvetter-linux.ger.corp.intel.com>
References: <20181227231308.16904-1-mironov.ivan@gmail.com>
         <20181227231308.16904-3-mironov.ivan@gmail.com>
         <20181228120652.GR9058@dvetter-linux.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-28 at 13:06 +0100, Daniel Vetter wrote:
> On Fri, Dec 28, 2018 at 04:13:08AM +0500, Ivan Mironov wrote:
> > Strict requirement of pixclock to be zero breaks support of SDL 1.2
> > which contains hardcoded table of supported video modes with non-zero
> > pixclock values[1].
> > 
> > To better understand which pixclock values are considered valid and how
> > driver should handle these values, I briefly examined few existing fbdev
> > drivers and documentation in Documentation/fb/. And it looks like there
> > are no strict rules on that and actual behaviour varies:
> > 
> > 	* some drivers treat (pixclock == 0) as "use defaults" (uvesafb.c);
> > 	* some treat (pixclock == 0) as invalid value which leads to
> > 	  -EINVAL (clps711x-fb.c);
> > 	* some pass converted pixclock value to hardware (uvesafb.c);
> > 	* some are trying to find nearest value from predefined table
> >           (vga16fb.c, video_gx.c).
> > 
> > Given this, I believe that it should be safe to just ignore this value if
> > changing is not supported. It seems that any portable fbdev application
> > which was not written only for one specific device working under one
> > specific kernel version should not rely on any particular behaviour of
> > pixclock anyway.
> > 
> > However, while enabling SDL1 applications to work out of the box when
> > there is no /etc/fb.modes with valid settings, this change affects the
> > video mode choosing logic in SDL. Depending on current screen
> > resolution, contents of /etc/fb.modes and resolution requested by
> > application, this may lead to user-visible difference (not always):
> > image will be displayed in a right way, but it will be aligned to the
> > left instead of center. There is no "right behaviour" here as well, as
> > emulated fbdev, opposing to old fbdev drivers, simply ignores any
> > requsts of video mode changes with resolutions smaller than current.
> > 
> > Feel free to NAK this patch if you think that it causes breakage of
> > user-space =).
> 
> It's a regression, we don't nack regression fixes :-)
> 
> > The easiest way to reproduce this problem is to install sdl-sopwith[2],
> > remove /etc/fb.modes file if it exists, and then try to run sopwith
> > from console without X. At least in Fedora 29, sopwith may be simply
> > installed from standard repositories.
> > 
> > [1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c, vesa_timings
> > [2] http://sdl-sopwith.sourceforge.net/
> > 
> > Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> 
> I thought this is also a regression fix, so also needs Fixes: and cc:
> stable?
> -Daniel

This particular patch fixes a bug that existed for 10 years unnoticed.
Are "Fixes:" and "Cc: stable" really required?

"pixclock != 0" check was introduced in this file by 785b93ef8c309
("drm/kms: move driver specific fb common code to helper functions
(v2)"). But actually similar code existed in the device-specific
drivers even earlier.

> 
> > ---
> >  drivers/gpu/drm/drm_fb_helper.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index aff576c3c4fb..b95a0c23c7c8 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -1690,9 +1690,14 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> >  	struct drm_fb_helper *fb_helper = info->par;
> >  	struct drm_framebuffer *fb = fb_helper->fb;
> >  
> > -	if (var->pixclock != 0 || in_dbg_master())
> > +	if (in_dbg_master())
> >  		return -EINVAL;
> >  
> > +	if (var->pixclock != 0) {
> > +		DRM_DEBUG("fbdev emulation doesn't support changing the pixel clock, value of pixclock is ignored\n");
> > +		var->pixclock = 0;
> > +	}
> > +
> >  	if ((drm_format_info_block_width(fb->format, 0) > 1) ||
> >  	    (drm_format_info_block_height(fb->format, 0) > 1))
> >  		return -EINVAL;
> > -- 
> > 2.20.1
> > 

