Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeD3MPE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 08:15:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34140 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeD3MPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 08:15:03 -0400
X-Google-Smtp-Source: AB8JxZr+dWC7fHrLBB9LSN4xStCq1UQ63QHDXKGLJtyTKSvluIf7c+D0yIUqv3jLPWuvCMZUxfGoYg==
Date: Mon, 30 Apr 2018 13:14:59 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH 5/6] backlight: Also nuke BL_CORE_DRIVER1
Message-ID: <20180430121459.GF5147@dell>
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
 <20180425174253.4616-5-daniel.vetter@ffwll.ch>
 <87d0yh9elr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0yh9elr.fsf@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018, Jani Nikula wrote:

> On Wed, 25 Apr 2018, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > Now that the 3 drivers using this are cleaned up we can also remove
> > this final bit of confusion of leaking driver internals into the
> > backlight power interface.
> >
> > The backlight power interface itself is still a massive mess.
> >
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >  include/linux/backlight.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> > index 1db67662bfcb..7fbf0539e14a 100644
> > --- a/include/linux/backlight.h
> > +++ b/include/linux/backlight.h
> > @@ -84,7 +84,6 @@ struct backlight_properties {
> >  
> >  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
> >  #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
> > -#define BL_CORE_DRIVER1		(1 << 31)	/* reserved for driver specific use */
> 
> Please also remove the
> 
> 	/* Upper 4 bits are reserved for driver internal use */
> 
> comment a few lines up to not give anyone ideas.
> 
> With that,
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

I'm merging these patches (with Jani's Acks) now.

Please send this request as a subsequent patch.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
