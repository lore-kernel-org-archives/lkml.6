Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F91C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66006206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfAGIlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:41:01 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46456 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfAGIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:41:00 -0500
Received: by mail-vs1-f65.google.com with SMTP id n10so26235993vso.13;
        Mon, 07 Jan 2019 00:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iY7YCz/7F4DLoYCShEEFBkCdQWil2Lw1bv+CI8i4Rc0=;
        b=A4eYQG6+1lkgkc2NfmQsHEpgT4xWxGbu7ALrH9j6LXOu7VAe73tWD+1Qckgb4nnjqi
         8rFmxAVMKlIskv6OKg94SmwVD3JdBrCyZELv8CMTRAZiSmK9iB3eoT7V2MhUEs1ifoO4
         1eP2gaCPFK9tNYuWpJxM3eied60lLp3WJFNISssoR/m5NGW8O2y9H8x4bdC149g4tmQ6
         hvXnuJkpI9qKgHCbVy3LIeJwMtgKJdiHbmpgWbTfQs1ytVLVNQjp+CO7r2JvzrMwkr2z
         xlJoS4pY8s3qspRtQEeMrJZs3b+F0iW9vTwHKJ0ChQG4t6pqgHof8jZh8MS8+nJC+e2s
         2CFg==
X-Gm-Message-State: AJcUukeGf4GUqdlvqAUSC15oEL9nsrbt8GFECj+CNlrO3xZCgZKpuiAI
        KspWOGFHq25SqQpC8NkwR75gPmB7x6GfYC32DVSB4j/M
X-Google-Smtp-Source: AFSGD/XgpcfGpdNxC0jkUnZL/C/1OlHJ2h+GEsPL77mP3HIlbZZHsbXprAw9Yu0sB7cLdcZoP9TqNLG5XHb+JJ05yR8=
X-Received: by 2002:a67:3885:: with SMTP id n5mr21205489vsi.96.1546850458398;
 Mon, 07 Jan 2019 00:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20181126215725.2548-1-peda@axentia.se> <20181126215725.2548-3-peda@axentia.se>
 <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com> <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
In-Reply-To: <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Jan 2019 09:40:46 +0100
Message-ID: <CAMuHMdXR2iuftV26s-EnKo74vZxcW2w_R1dD_Mk+Ug8MsNwL3Q@mail.gmail.com>
Subject: Re: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd
 line, option
To:     Peter Rosin <peda@axentia.se>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Jan 7, 2019 at 9:26 AM Peter Rosin <peda@axentia.se> wrote:
> On 2019-01-06 10:33, Geert Uytterhoeven wrote:
> > On Mon, Nov 26, 2018 at 10:59 PM Peter Rosin <peda@axentia.se> wrote:
> >> If there are extra logos (CONFIG_FB_LOGO_EXTRA) the heights of these
> >> extra logos are not considered when centering the first logo vertically.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >
> >> --- a/drivers/video/logo/Kconfig
> >> +++ b/drivers/video/logo/Kconfig
> >> @@ -10,6 +10,15 @@ menuconfig LOGO
> >>
> >>  if LOGO
> >>
> >> +config FB_LOGO_CENTER
> >> +       bool "Center the logo"
> >> +       depends on FB=y
> >> +       help
> >> +         When this option is selected, the bootup logo is centered both
> >> +         horizontally and vertically. If more than one logo is displayed
> >> +         due to multiple CPUs, the collected line of logos is centered
> >> +         as a whole.
> >> +
> >
> > Isn't a kernel command line option more suitable to configure the position
> > of the logo?
>
> That didn't occur to me previously, but it does make sense now that you
> mention it. This is on top of v5.0-rc1, and if applied before v5.0 we
> can avoid possible regressions for folks who might start to rely on
> CONFIG_FB_LOGO_CENTER if v5.0 is released w/o this.
>
> Cheers,
> Peter
>
> From de7353ab519ba9b5c9ea3f62d607bb8e94b687cc Mon Sep 17 00:00:00 2001
> From: Peter Rosin <peda@axentia.se>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> Date: Mon, 7 Jan 2019 08:35:26 +0100
> Subject: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd line
>  option
>
> A command line option is much more flexible than a config option and
> the supporting code is small. Gets rid of #ifdefs in the code too...
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Thanks for your patch!

> --- a/Documentation/fb/fbcon.txt
> +++ b/Documentation/fb/fbcon.txt
> @@ -163,6 +163,12 @@ C. Boot options
>         be preserved until there actually is some text is output to the console.
>         This option causes fbcon to bind immediately to the fbdev device.
>
> +7. fbcon=center-logo
> +
> +       When this option is selected, the bootup logo is centered both
> +       horizontally and vertically. If more than one logo is displayed due to
> +       multiple CPUs, the collected line of logos is centered as a whole.
> +

What about making this more generic, than an option specific for centering?
Else people want fbcon=left-logo or fbcon=right-logo soon?

    fbcon=logo-pos:<pos>

With <pos> being "center", "left", "top", "right", "bottom", and combinations
like "top,center"? Or is that complicating stuff too much?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
