Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08365C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9272085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JS69Sqyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBHBGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:06:02 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46600 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfBHBGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:06:01 -0500
Received: by mail-vs1-f67.google.com with SMTP id n10so1140836vso.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 17:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f76DyUqVBGp9LySDrJ1M/kpiRhzEAkMWgDTIlFzEJPQ=;
        b=JS69SqyfSaks6skJw2dTH1BsRFQl58oMcUeUOxbmZs1u7ELNu9oHdKynEsKJkILdWU
         pMsoC3HTojYlMbPOBaGZoOwWa2uNGlC5P0jCiwGTFZrmD5Ol7rklq9SPW5+s8+70mqt3
         CarzzBQw74YcMQQ7L4REkIIaBiNxSpwjuQ7+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f76DyUqVBGp9LySDrJ1M/kpiRhzEAkMWgDTIlFzEJPQ=;
        b=N4wyQ9ITRjkFtZejfA1OnLMGKj83kZHgbKP/ZJI5zfWqLLta+wlzy6/9oFFza68G/d
         48eYgbbMNWQKEq16eUArlPsll15mLoDkatewDEZnIWPnB+TObjFxCBOd58R1O7rPNglF
         lNYjmab2X5A2XCk9Fna/5Bb70syB/WPIEOpw+gWi5uJ2JiQ0MGZ70nDeR687MP5lK8WN
         r7pBrZD4syvTwo5p+vvUfMY401EYbxHNG/YtJvXeQ7tJharemrd/fdMq9WOv0zbHab1u
         7OTSXEzjGwxGL4VsC/2qeC4x3Kc2D8+DiL+Hln3LvJ0ITl/AVB5fizXo4dSTPr65WnZt
         npkQ==
X-Gm-Message-State: AHQUAuYc5I/LxTDp99GRO9VlVWvIoIyzV/VBkRptvBK1mvpi6jGxswKF
        RGm6UoGev33Bx5rT3k8NeQbrj/qP6p+uzw==
X-Google-Smtp-Source: AHgI3IY5n1taY2iwRcWutde61mpnwoOUNIX7faxlgWWjAC3YbZVQEy+31IXw8NtRCvA9XQqXd8tNwQ==
X-Received: by 2002:a67:8202:: with SMTP id e2mr7988922vsd.183.1549587959999;
        Thu, 07 Feb 2019 17:05:59 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id l26sm135098vsi.31.2019.02.07.17.05.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 17:05:59 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id t127so454717vke.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 17:05:59 -0800 (PST)
X-Received: by 2002:ac5:c305:: with SMTP id j5mr3860136vkk.13.1549587958493;
 Thu, 07 Feb 2019 17:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20190207205909.28765-1-aaro.koskinen@iki.fi>
In-Reply-To: <20190207205909.28765-1-aaro.koskinen@iki.fi>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 8 Feb 2019 01:05:46 +0000
X-Gmail-Original-Message-ID: <CAGXu5jJxKhWQOxyOOb2kQHCdmK4XV8GvhgaHeded6vG-82AgVQ@mail.gmail.com>
Message-ID: <CAGXu5jJxKhWQOxyOOb2kQHCdmK4XV8GvhgaHeded6vG-82AgVQ@mail.gmail.com>
Subject: Re: [PATCH] panic/reboot: allow specifying reboot_mode for panic only
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 8:59 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> From: Aaro Koskinen <aaro.koskinen@nokia.com>
>
> Allow specifying reboot_mode for panic only. This is needed on systems
> where ramoops is used to store panic logs, and user wants to use warm
> reset to preserve those, while still having cold reset on normal reboots.

Seems reasonable to me. I'd make the "-1" be a specific #define,
though. Open-coded literals should generally be avoided.

-Kees

>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 +++-
>  include/linux/reboot.h                        |  1 +
>  kernel/panic.c                                |  2 ++
>  kernel/reboot.c                               | 20 ++++++++++++++-----
>  4 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b799bcf67d7b..033c93048a95 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3950,7 +3950,9 @@
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
> index e63799a6e895..61962f9826fa 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -21,6 +21,7 @@ enum reboot_mode {
>         REBOOT_GPIO,
>  };
>  extern enum reboot_mode reboot_mode;
> +extern enum reboot_mode panic_reboot_mode;
>
>  enum reboot_type {
>         BOOT_TRIPLE     = 't',
> diff --git a/kernel/panic.c b/kernel/panic.c
> index f121e6ba7e11..c4285e3a27ef 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -306,6 +306,8 @@ void panic(const char *fmt, ...)
>                  * shutting down.  But if there is a chance of
>                  * rebooting the system it will be rebooted.
>                  */
> +               if (panic_reboot_mode != -1)
> +                       reboot_mode = panic_reboot_mode;
>                 emergency_restart();
>         }
>  #ifdef __sparc__
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e1b79b6a2735..d5627a92508d 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -31,6 +31,7 @@ EXPORT_SYMBOL(cad_pid);
>  #define DEFAULT_REBOOT_MODE
>  #endif
>  enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
> +enum reboot_mode panic_reboot_mode = -1;
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


-- 
Kees Cook
