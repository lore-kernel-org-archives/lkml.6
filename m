Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3592C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8374621841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka33nmcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLRNUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:20:08 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40751 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeLRNUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:20:08 -0500
Received: by mail-io1-f65.google.com with SMTP id v12so9112496iop.7;
        Tue, 18 Dec 2018 05:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPUw5zdWdiTVHRhPjPA3si8ucZxdkNC+DEDwcQQbuW0=;
        b=ka33nmcPIHIf0btaBp/njWOE+y3tk5BYbUz1UsMa2xSt7Fo/OQuhxjOWA1B/hHwBwj
         e8Fc38pYhp6PYTUz5yrtKKYY26pYCC0/+Bu8AxDYN+55x5/7NmbzaNpYEt48z23gYiam
         fhEhI8TK2nweYoayBKHGvfBZ8EJyQ+f8TpM8yg3YSHzqHxPrqpAI2Pp2fpqf2okEH3VA
         FXXLhBKAOnFPfEYO0SZnNatXv9YoBJtomY4glk9XpoDeWG0gyoWkFILDdxXpUvxRUiMK
         YZrNk6ZqIVgatNwFW62G+Plk+818xRNWGpiK2fJAojy5zpPzJwIuZFPBW2TSeF07Q4YR
         Zzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPUw5zdWdiTVHRhPjPA3si8ucZxdkNC+DEDwcQQbuW0=;
        b=McWVPwZS4GE6IAUaYJm59ZCLw9lzbUqhX83UJ2k2tiAerXkXDU4Xk30g/TE9Bh//1w
         qWyvrrPxiInbCxtm0prhzrbQNlgOVbcbe4oFse11U6IgNfa0032sAGAO5LV8LOXWifHQ
         jTc5epVpLSWI/WU6C25Pq8Bu4MpUV6gur4K6CH1PxtG0sWFqSFnxrMjQWW/BiU2NVjuJ
         NuRRhlw9id2OhrFA5ZC33swXXhm4JKhNDCbRgZCAPxZxnjDzLyr801uGn8KBZwBQgpUH
         kGp10DBuWxLcm/BQnZVFDg/rsVj3aXGKXByWruXEQfy9F6F2RePws/UgXRbOvaNXjYrg
         STEw==
X-Gm-Message-State: AA+aEWaTZ94kb+4AajTWZJRvh6P4ZzqfvMj6luAHqi3FnRRxPfLeXzaa
        BjwAnYi4aAcABvKQm8hi8JyB+CCVGbiDpEgn1n8=
X-Google-Smtp-Source: AFSGD/UPPEKFgquH6gVPubEtUkQxbnr7I2QqcM91lceLQHRVwvO3lm+unjNZ9atqmJ4/ZKlny8Rvd4bhBe0rYR1fLkY=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr14066183iom.7.1545139206520;
 Tue, 18 Dec 2018 05:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20181026140931.15771-1-robdclark@gmail.com>
In-Reply-To: <20181026140931.15771-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 18 Dec 2018 08:19:54 -0500
Message-ID: <CAF6AEGuUXt-c9Bmi8yfU=d_pUvrsXwDq4CzZ9GfrhZBP+zbe-A@mail.gmail.com>
Subject: Re: [PATCH] fbdev: make FB_BACKLIGHT a tristate
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:09 AM Rob Clark <robdclark@gmail.com> wrote:
>
> BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
> FB_BACKLIGHT prevents it from being built as a module.  There
> doesn't seem to be any particularly good reason for this, so
> switch FB_BACKLIGHT over to tristate.
>
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> Tested-by: Arnd Bergmann <arnd@arndb.de>

bump

maybe we can merge this via drm-misc?

BR,
-R

> ---
> v2: remove IS_ENABLED() from UABI headers.  Userspace doesn't
>     know the kernel config, so just remove the ifdef guard
>
>  drivers/video/fbdev/Kconfig        | 2 +-
>  drivers/video/fbdev/core/fbsysfs.c | 8 ++++----
>  include/linux/fb.h                 | 2 +-
>  include/uapi/linux/fb.h            | 2 --
>  4 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 591a13a59787..146ab2c347f8 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -198,7 +198,7 @@ config FB_MACMODES
>         default n
>
>  config FB_BACKLIGHT
> -       bool
> +       tristate
>         depends on FB
>         select BACKLIGHT_LCD_SUPPORT
>         select BACKLIGHT_CLASS_DEVICE
> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
> index e31a182b42bf..44cca39f2b51 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c
> @@ -60,7 +60,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
>         info->device = dev;
>         info->fbcon_rotate_hint = -1;
>
> -#ifdef CONFIG_FB_BACKLIGHT
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>         mutex_init(&info->bl_curve_mutex);
>  #endif
>
> @@ -429,7 +429,7 @@ static ssize_t show_fbstate(struct device *device,
>         return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->state);
>  }
>
> -#ifdef CONFIG_FB_BACKLIGHT
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>  static ssize_t store_bl_curve(struct device *device,
>                               struct device_attribute *attr,
>                               const char *buf, size_t count)
> @@ -510,7 +510,7 @@ static struct device_attribute device_attrs[] = {
>         __ATTR(stride, S_IRUGO, show_stride, NULL),
>         __ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
>         __ATTR(state, S_IRUGO|S_IWUSR, show_fbstate, store_fbstate),
> -#ifdef CONFIG_FB_BACKLIGHT
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>         __ATTR(bl_curve, S_IRUGO|S_IWUSR, show_bl_curve, store_bl_curve),
>  #endif
>  };
> @@ -551,7 +551,7 @@ void fb_cleanup_device(struct fb_info *fb_info)
>         }
>  }
>
> -#ifdef CONFIG_FB_BACKLIGHT
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>  /* This function generates a linear backlight curve
>   *
>   *     0: off
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index a3cab6dc9b44..7cdd31a69719 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -485,7 +485,7 @@ struct fb_info {
>         struct list_head modelist;      /* mode list */
>         struct fb_videomode *mode;      /* current mode */
>
> -#ifdef CONFIG_FB_BACKLIGHT
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>         /* assigned backlight device */
>         /* set before framebuffer registration,
>            remove after unregister */
> diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
> index 6cd9b198b7c6..b6aac7ee1f67 100644
> --- a/include/uapi/linux/fb.h
> +++ b/include/uapi/linux/fb.h
> @@ -393,11 +393,9 @@ struct fb_cursor {
>         struct fb_image image;  /* Cursor image */
>  };
>
> -#ifdef CONFIG_FB_BACKLIGHT
>  /* Settings for the generic backlight code */
>  #define FB_BACKLIGHT_LEVELS    128
>  #define FB_BACKLIGHT_MAX       0xFF
> -#endif
>
>
>  #endif /* _UAPI_LINUX_FB_H */
> --
> 2.17.2
>
