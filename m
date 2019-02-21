Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6228CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195B52083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oYzZnayj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfBUWqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:46:51 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42658 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUWqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:46:51 -0500
Received: by mail-vk1-f196.google.com with SMTP id j195so64406vkj.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mTnRRjoYWAeIrW4nG0F0qs23GoESzwxGka8JRAoUEdw=;
        b=oYzZnayjUnx6jRYUpYzWU9wO/p9JFyevxUqJIP0KoCDFd5v4M3kbxJZ9O9+9u1ibn3
         VaLR0oHZwb5vnN5DVV3sFi2uJF64YBPNzwwSj1pMkU7W7LNisLK1On6xJmLWn8wmoJIi
         6FEG4GVNukdfk/SL9lXh4FOdb6s8heeDpt/p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTnRRjoYWAeIrW4nG0F0qs23GoESzwxGka8JRAoUEdw=;
        b=UoI/4nbVWKPpl/kIgHAjJZDx+6vK73loZVIXP81JxthDrbDwPwwtdbhBOXa9a+Erbd
         ItcyslLwfRYnthjdNlxWxuf9/UjJQHNq4TgYcmp1pPB6l2VIMZt5v0yAZjTuRzeX28rS
         W5keu99PjPIBfxbWOAC/pZbuAlBvzs35xa2SmfhjXTSWBezNenueqyD7IT2lpz05WYZO
         Mpd1oX7VArv/mEwu6mmDa6BNeAFjLH8z/t3Hde5ov70Cr5ZGios0fhV/np+VFaUoKHpw
         BtqMVA0cAY7kmTr9tOnqYupbs9S56fHcVvOT5rL5i2C+FjtVuoDJVTH1godOzhoV5KtW
         SIJw==
X-Gm-Message-State: AHQUAuaq43BVLaQtEBy2qaWA+7sWSCZH3qRwXVNKE7ffUjF3iuyAFdI9
        m9MfVG4EqXRi7/Ye5qOC+8fG3NICM9o=
X-Google-Smtp-Source: AHgI3IZRHILaAImfiX+iXHGpYjR9ycdZPXl8fl4mmM+p65sdat6Ic/Hy/dLX8GBTkwo3I6OPFCpt9g==
X-Received: by 2002:ac5:c30b:: with SMTP id j11mr637021vkk.46.1550789209161;
        Thu, 21 Feb 2019 14:46:49 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id v197sm40650vkd.28.2019.02.21.14.46.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 14:46:48 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id q17so282467uam.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:46:48 -0800 (PST)
X-Received: by 2002:ab0:74cb:: with SMTP id f11mr567242uaq.14.1550789207533;
 Thu, 21 Feb 2019 14:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20190221203310.20706-1-aaro.koskinen@iki.fi>
In-Reply-To: <20190221203310.20706-1-aaro.koskinen@iki.fi>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 14:46:36 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+AeYKMTxCm7YRwyq7Kd9EXKtKUZRO+g8knxouK7Ce2jg@mail.gmail.com>
Message-ID: <CAGXu5j+AeYKMTxCm7YRwyq7Kd9EXKtKUZRO+g8knxouK7Ce2jg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] panic/reboot: allow specifying reboot_mode for
 panic only
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:33 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> From: Aaro Koskinen <aaro.koskinen@nokia.com>
>
> Allow specifying reboot_mode for panic only. This is needed on systems
> where ramoops is used to store panic logs, and user wants to use warm
> reset to preserve those, while still having cold reset on normal reboots.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>
>         v2: Use REBOOT_UNDEFINED instead of -1
>
>         v1: https://marc.info/?t=154957416600005&r=1&w=2
>
>  .../admin-guide/kernel-parameters.txt         |  4 +++-
>  include/linux/reboot.h                        |  2 ++
>  kernel/panic.c                                |  2 ++
>  kernel/reboot.c                               | 20 ++++++++++++++-----
>  4 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 858b6c0b9a15..5705b4689565 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3949,7 +3949,9 @@
>                                 [[,]s[mp]#### \
>                                 [[,]b[ios] | a[cpi] | k[bd] | t[riple] | e[fi] | p[ci]] \
>                                 [[,]f[orce]
> -                       Where reboot_mode is one of warm (soft) or cold (hard) or gpio,
> +                       Where reboot_mode is one of warm (soft) or cold (hard) or gpio
> +                                       (prefix with 'panic_' to set mode for panic
> +                                       reboot only),
>                               reboot_type is one of bios, acpi, kbd, triple, efi, or pci,
>                               reboot_force is either force or not specified,
>                               reboot_cpu is s[mp]#### with #### being the processor
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index e63799a6e895..1c4c8a47e2de 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -19,8 +19,10 @@ enum reboot_mode {
>         REBOOT_HARD,
>         REBOOT_SOFT,
>         REBOOT_GPIO,
> +       REBOOT_UNDEFINED = -1,

I would expect this before REBOOT_COLD (numerically ordered).

>  };
>  extern enum reboot_mode reboot_mode;
> +extern enum reboot_mode panic_reboot_mode;
>
>  enum reboot_type {
>         BOOT_TRIPLE     = 't',
> diff --git a/kernel/panic.c b/kernel/panic.c
> index f121e6ba7e11..a0d839f883b7 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -306,6 +306,8 @@ void panic(const char *fmt, ...)
>                  * shutting down.  But if there is a chance of
>                  * rebooting the system it will be rebooted.
>                  */
> +               if (panic_reboot_mode != REBOOT_UNDEFINED)
> +                       reboot_mode = panic_reboot_mode;
>                 emergency_restart();
>         }
>  #ifdef __sparc__
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e1b79b6a2735..b9e79e8c7226 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -31,6 +31,7 @@ EXPORT_SYMBOL(cad_pid);
>  #define DEFAULT_REBOOT_MODE
>  #endif
>  enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
> +enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
>
>  /*
>   * This variable is used privately to keep track of whether or not
> @@ -519,6 +520,8 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
>  static int __init reboot_setup(char *str)
>  {
>         for (;;) {
> +               enum reboot_mode *mode;
> +
>                 /*
>                  * Having anything passed on the command line via
>                  * reboot= will cause us to disable DMI checking
> @@ -526,17 +529,24 @@ static int __init reboot_setup(char *str)
>                  */
>                 reboot_default = 0;
>
> +               if (!strncmp(str, "panic_", 6)) {
> +                       mode = &panic_reboot_mode;
> +                       str += 6;
> +               } else {
> +                       mode = &reboot_mode;
> +               }
> +
>                 switch (*str) {
>                 case 'w':
> -                       reboot_mode = REBOOT_WARM;
> +                       *mode = REBOOT_WARM;
>                         break;
>
>                 case 'c':
> -                       reboot_mode = REBOOT_COLD;
> +                       *mode = REBOOT_COLD;
>                         break;
>
>                 case 'h':
> -                       reboot_mode = REBOOT_HARD;
> +                       *mode = REBOOT_HARD;
>                         break;
>
>                 case 's':
> @@ -553,11 +563,11 @@ static int __init reboot_setup(char *str)
>                                 if (rc)
>                                         return rc;
>                         } else
> -                               reboot_mode = REBOOT_SOFT;
> +                               *mode = REBOOT_SOFT;
>                         break;
>                 }
>                 case 'g':
> -                       reboot_mode = REBOOT_GPIO;
> +                       *mode = REBOOT_GPIO;
>                         break;
>
>                 case 'b':
> --
> 2.17.0
>

Everything else looks good, though!

-- 
Kees Cook
