Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E40C43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDD32087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoL+0tuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfAEQMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:12:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39906 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfAEQL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:11:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so34807521ljh.6;
        Sat, 05 Jan 2019 08:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8FvMS5bQWswz4tZSpc++FLoMWsilhevTs+Ju3/lQurY=;
        b=BoL+0tuKSzBjsILTXoQPndpF8jD0S/8SU5a5AaJ/Twa6rF42vJoloWT6zvSUpfbMQE
         Cp5suP/2rgV4Kg0SuLtKQ5MkJ069QO8D/g4DVUH7wIo03XIvmck6gcZS5HUGMxpCAD77
         b+GvS/vC814Ln5w7uxYjYxBudOMixenAI8cuEJDHUz8a82J0OCrdhuoEp4nu1vDmhNbB
         pn9XV0BkcMqXCVmND0IGkznfQ+vYJeKHWkvJutOxL5UpQeSU1NOsmO3bUdpGa+Bk3lN9
         T/rF1LnQgBy8ixS/MPLArgaLcjMpY0cLJJLcbbHbzGMTs70soFYYPIqWk8RNzR+wbrYt
         O4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8FvMS5bQWswz4tZSpc++FLoMWsilhevTs+Ju3/lQurY=;
        b=JpsQhKkIc1Z0yJhPF08DRHKkQY9vzCfANfukTmbXIFTYCNU2o5hIUuxZTD44GjMVau
         /2UdX44ckWQtRnGDvPFRBpaFvgUw/rye+pkKxTkIxcHw+6We91S8CXrD6zmhKho7uqNc
         VJEBMUsCN6fA/fiuuAVrqhRaZE7ikavT5gW+gL/HgqEmr+AthTk+KFJQFhqSozFRmzgR
         s8PiUahXWgyHPAx6TT3d7gP2N35kC65mJmGwIV0KIGcUmeaieAHd3EEveUDHIRQqH6eT
         9N+M93/LgLxnB0A76X3HJxePXgGcxkdEBn6eBsNOZCwLLCrOXcZNkHaC4WyCDO/5mOll
         HrQQ==
X-Gm-Message-State: AJcUukchNbBKNgPj9GGQwsQu5SfQxDutXz5x85de9in70S7N8x1yQfbe
        HfM49bjSCjtNBKysZjGuQnAfVfPvDEpKug==
X-Google-Smtp-Source: ALg8bN71YjG6sV2IUFPOzJDTnp5psEGLqy96ZzhfGd3ctYpjZVLZwm59mw1vOWtQvjbjCGEvy7eq1w==
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr822164ljh.174.1546704716356;
        Sat, 05 Jan 2019 08:11:56 -0800 (PST)
Received: from im-mac (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id e14-v6sm13003423ljl.43.2019.01.05.08.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 08:11:55 -0800 (PST)
Message-ID: <e4754c8dab11b1f8b61a7fb2aae690b979cc7209.camel@gmail.com>
Subject: Re: [PATCH v1 1/2] drm/fb-helper: Bring back workaround for bugs of
 SDL 1.2
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        stable@vger.kernel.org
Date:   Sat, 05 Jan 2019 21:11:53 +0500
In-Reply-To: <20181228121549.GU9058@dvetter-linux.ger.corp.intel.com>
References: <20181227231308.16904-1-mironov.ivan@gmail.com>
         <20181227231308.16904-2-mironov.ivan@gmail.com>
         <20181228121549.GU9058@dvetter-linux.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-28 at 13:15 +0100, Daniel Vetter wrote:
> On Fri, Dec 28, 2018 at 04:13:07AM +0500, Ivan Mironov wrote:
> > SDL 1.2 sets all fields related to the pixel format to zero in some
> > cases[1]. Prior to commit db05c48197759 ("drm: fb-helper: Reject all
> > pixel format changing requests"), there was an unintentional workaround
> > for this that existed for more than a decade. First in device-specific DRM
> > drivers, then here in drm_fb_helper.c.
> > 
> > Previous code containing this workaround just ignores pixel format fields
> > from userspace code. Not a good thing either, as this way, driver may
> > silently use pixel format different from what client actually requested,
> > and this in turn will lead to displaying garbage on the screen. I think
> > that returning EINVAL to userspace in this particular case is the right
> > option, so I decided to left code from problematic commit untouched
> > instead of just reverting it entirely.
> > 
> > Here is the steps required to reproduce this problem exactly:
> > 	1) Compile fceux[2] with SDL 1.2.15 and without GTK or OpenGL
> > 	   support. SDL should be compiled with fbdev support (which is
> > 	   on by default).
> > 	2) Create /etc/fb.modes with following contents (values seems
> > 	   not used, and just required to trigger problematic code in
> > 	   SDL):
> > 
> > 		mode "test"
> > 		    geometry 1 1 1 1 1
> > 		    timings 1 1 1 1 1 1 1
> > 		endmode
> > 
> > 	3) Create ~/.fceux/fceux.cfg with following contents:
> > 
> > 		SDL.Hotkeys.Quit = 27
> > 		SDL.DoubleBuffering = 1
> > 
> > 	4) Ensure that screen resolution is at least 1280x960 (e.g.
> > 	   append "video=Virtual-1:1280x960-32" to the kernel cmdline
> > 	   for qemu/QXL).
> > 
> > 	5) Try to run fceux on VT with some ROM file[3]:
> > 
> > 		# ./fceux color_test.nes
> > 
> > [1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c,
> >     FB_SetVideoMode()
> > [2] http://www.fceux.com
> > [3] Example ROM: https://github.com/bokuweb/rustynes/blob/master/roms/color_test.nes
> > 
> > Reported-by: saahriktu <mail@saahriktu.org>
> > Suggested-by: saahriktu <mail@saahriktu.org>
> > Cc: stable@vger.kernel.org
> > Fixes: db05c48197759 ("drm: fb-helper: Reject all pixel format changing requests")
> > Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_fb_helper.c | 146 ++++++++++++++++++++------------
> >  1 file changed, 93 insertions(+), 53 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index d3af098b0922..aff576c3c4fb 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -1621,6 +1621,64 @@ static bool drm_fb_pixel_format_equal(const struct fb_var_screeninfo *var_1,
> >  	       var_1->transp.msb_right == var_2->transp.msb_right;
> >  }
> >  
> > +static void drm_fb_helper_fill_pixel_fmt(struct fb_var_screeninfo *var,
> > +					 u8 depth)
> > +{
> > +	switch (depth) {
> > +	case 8:
> > +		var->red.offset = 0;
> > +		var->green.offset = 0;
> > +		var->blue.offset = 0;
> > +		var->red.length = 8; /* 8bit DAC */
> > +		var->green.length = 8;
> > +		var->blue.length = 8;
> > +		var->transp.offset = 0;
> > +		var->transp.length = 0;
> > +		break;
> > +	case 15:
> > +		var->red.offset = 10;
> > +		var->green.offset = 5;
> > +		var->blue.offset = 0;
> > +		var->red.length = 5;
> > +		var->green.length = 5;
> > +		var->blue.length = 5;
> > +		var->transp.offset = 15;
> > +		var->transp.length = 1;
> > +		break;
> > +	case 16:
> > +		var->red.offset = 11;
> > +		var->green.offset = 5;
> > +		var->blue.offset = 0;
> > +		var->red.length = 5;
> > +		var->green.length = 6;
> > +		var->blue.length = 5;
> > +		var->transp.offset = 0;
> > +		break;
> > +	case 24:
> > +		var->red.offset = 16;
> > +		var->green.offset = 8;
> > +		var->blue.offset = 0;
> > +		var->red.length = 8;
> > +		var->green.length = 8;
> > +		var->blue.length = 8;
> > +		var->transp.offset = 0;
> > +		var->transp.length = 0;
> > +		break;
> > +	case 32:
> > +		var->red.offset = 16;
> > +		var->green.offset = 8;
> > +		var->blue.offset = 0;
> > +		var->red.length = 8;
> > +		var->green.length = 8;
> > +		var->blue.length = 8;
> > +		var->transp.offset = 24;
> > +		var->transp.length = 8;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> >  /**
> >   * drm_fb_helper_check_var - implementation for &fb_ops.fb_check_var
> >   * @var: screeninfo to check
> > @@ -1654,6 +1712,40 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> >  		return -EINVAL;
> >  	}
> >  
> > +	/*
> > +	 * Workaround for SDL 1.2, which is known to be setting all pixel format
> > +	 * fields values to zero in some cases. We treat this situation as a
> > +	 * kind of "use some reasonable autodetected values".
> > +	 */
> > +	if (!var->red.offset     && !var->green.offset    &&
> > +	    !var->blue.offset    && !var->transp.offset   &&
> > +	    !var->red.length     && !var->green.length    &&
> > +	    !var->blue.length    && !var->transp.length   &&
> > +	    !var->red.msb_right  && !var->green.msb_right &&
> > +	    !var->blue.msb_right && !var->transp.msb_right) {
> > +		u8 depth;
> > +
> > +		/*
> > +		 * There is no way to guess the right value for depth when
> > +		 * bpp is 16 or 32. So we just restore the behaviour previously
> > +		 * introduced here by commit . In fact, this was
> > +		 * implemented even earlier in various device drivers.
> > +		 */
> > +		switch (var->bits_per_pixel) {
> > +		case 16:
> > +			depth = 15;
> > +			break;
> > +		case 32:
> > +			depth = 24;
> > +			break;
> > +		default:
> > +			depth = var->bits_per_pixel;
> > +			break;
> > +		}
> > +
> > +		drm_fb_helper_fill_pixel_fmt(var, depth);
> 
> Please use fb->format->depth here instead of guessing.
> -Daniel

I do not think that this is the right way.

Without guessing, if SDL1 makes a request with bits_per_pixel == 16
(for example) and current fb->format->depth == 24, ioctl() will succeed
while actual pixel format will remain the same. As a result, SDL1 will
display garbage because of invalid pixel format.

Or am I missing something here?

> > +	}
> > +
> >  	/*
> >  	 * drm fbdev emulation doesn't support changing the pixel format at all,
> >  	 * so reject all pixel format changing requests.oid drm_fb_helper_fill_var(struct fb_info *info, struct drm_fb_helper *fb_helpe 	info->var.yoffset = 0; 	info->var.activate = FB_ACTIVATE_NOW; 
> > -	switch (fb->format->depth) {
> > -	case 8:
> > -		info->var.red.offset = 0;
> > -		info->var.green.offset = 0;
> > -		info->var.blue.offset = 0;
> > -		info->var.red.length = 8; /* 8bit DAC */
> > -		info->var.green.length = 8;
> > -		info->var.blue.length = 8;
> > -		info->var.transp.offset = 0;
> > -		info->var.transp.length = 0;
> > -		break;
> > -	case 15:
> > -		info->var.red.offset = 10;
> > -		info->var.green.offset = 5;
> > -		info->var.blue.offset = 0;
> > -		info->var.red.length = 5;
> > -		info->var.green.length = 5;
> > -		info->var.blue.length = 5;
> > -		info->var.transp.offset = 15;
> > -		info->var.transp.length = 1;
> > -		break;
> > -	case 16:
> > -		info->var.red.offset = 11;
> > -		info->var.green.offset = 5;
> > -		info->var.blue.offset = 0;
> > -		info->var.red.length = 5;
> > -		info->var.green.length = 6;
> > -		info->var.blue.length = 5;
> > -		info->var.transp.offset = 0;
> > -		break;
> > -	case 24:
> > -		info->var.red.offset = 16;
> > -		info->var.green.offset = 8;
> > -		info->var.blue.offset = 0;
> > -		info->var.red.length = 8;
> > -		info->var.green.length = 8;
> > -		info->var.blue.length = 8;
> > -		info->var.transp.offset = 0;
> > -		info->var.transp.length = 0;
> > -		break;
> > -	case 32:
> > -		info->var.red.offset = 16;
> > -		info->var.green.offset = 8;
> > -		info->var.blue.offset = 0;
> > -		info->var.red.length = 8;
> > -		info->var.green.length = 8;
> > -		info->var.blue.length = 8;
> > -		info->var.transp.offset = 24;
> > -		info->var.transp.length = 8;
> > -		break;
> > -	default:
> > -		break;
> > -	}
> > +	drm_fb_helper_fill_pixel_fmt(&info->var, fb->format->depth);
> >  
> >  	info->var.xres = fb_width;
> >  	info->var.yres = fb_height;
> > -- 
> > 2.20.1
> > 



