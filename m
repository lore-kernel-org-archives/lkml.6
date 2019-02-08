Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5149C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B501D207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP2zqmDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfBHTpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:45:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40572 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfBHTpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:45:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so2172564plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 11:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFueFI5/071Fx4axLAZxH/HE1WMNUNILwffGRVBAAcs=;
        b=bP2zqmDFlGbZFLq7cF0xho2Haq7gG7uYD9PGUkLeQ1fKjp6ZXgoyRi6fjYuMkm1G4U
         k+KwyuQUg+pA7x5FnN5bJRDN5u9WZ7oQMcDhYoZ4m8fmzeNAswsEAYaFyFjcbT/6O8uH
         QIGAs81pPpE1pnjH0Wk72n6KMfC/M0mSCo/8KE8ZF2ygRro2WLLEcqwUeqlVhV2Ci5Jn
         HEy2HNQX3DMru5wa742Yl+FrpclgfcXrVl9EhRWqP1xTGvy5ZwEWt/xr1oK+mMThki9R
         mNW2sIYUSPrAnOwZTEw+Wr0qduJzbqG1skqGkoMt5gDaVSbhCmyVSKfJKudHdGQKw64O
         /T8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFueFI5/071Fx4axLAZxH/HE1WMNUNILwffGRVBAAcs=;
        b=ek0ddd3U90cDQikShFnEgUdEZUmW7x+2fXx/509D1jGL9bEBsIJxdScvYA16Q2T/W8
         or6hrVYABADkD9XFkY/OaBvqmKykxF14Pzq7uOTYBPA+T/b+3DD/ODzBT7ERCcYV72su
         WK4yamKh9Xg1hK2orIvALxiSTGcZOOYOha5cHiXrGB7gaY1z9j4AxA5GvYTp6GRENYE4
         o8QrCciKCA5B4eLisHzLvatgqSq8QqEcwNhVxiEo13wjbHg6Vejnncn670PKbZwlmqCV
         dGDCvXGzjHtiDUxtstDDGxconu3zdLd30L5dHtTyinCEay2Ia1grlLlJ4AYwbhHhI2/6
         SiqQ==
X-Gm-Message-State: AHQUAuYk8pk2GHPjzofmnWiKUTcOZFDDfTlkuCriSe3oTFJamPDpnP6r
        MxEUHYIby09rd0Z4DoTmMgJ0O1z8/wPjqXePWIexLl9w
X-Google-Smtp-Source: AHgI3IZZinpEH4b82daZkNbLvAXNWaAodXRxxRlx1fJyY5k4GNtU1GdFExZuB5PhBctblaA5JNYHa2TkO4sbjtXpmT0=
X-Received: by 2002:a17:902:a50e:: with SMTP id s14mr12599375plq.311.1549655133249;
 Fri, 08 Feb 2019 11:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20181022134048.19693-1-david.engraf@sysgo.com> <20181030151805.5519-1-david.engraf@sysgo.com>
In-Reply-To: <20181030151805.5519-1-david.engraf@sysgo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Feb 2019 21:45:21 +0200
Message-ID: <CAHp75VdOSC8j_1G3z-UO01_JYN20M-YMGOC2JkFDhi8njNZAvA@mail.gmail.com>
Subject: Re: [PATCH RESEND] initramfs: cleanup incomplete rootfs
To:     David Engraf <david.engraf@sysgo.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 5:22 PM David Engraf <david.engraf@sysgo.com> wrote:
>
> Unpacking an external initrd may fail e.g. not enough memory. This leads
> to an incomplete rootfs because some files might be extracted already.
> Fixed by cleaning the rootfs so the kernel is not using an incomplete
> rootfs.

This breaks my setup where I have U-boot provided more size of
initramfs than needed. This allows a bit of flexibility to increase or
decrease initramfs compressed image without taking care of bootloader.
The proper solution is to do this if we sure that we didn't get enough
memory, otherwise I can't consider the error fatal to clean up rootfs.

Andrew, what it be good idea to revert for now?

> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> ---
>  init/initramfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 640557788026..aa3a46cfcb4e 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -548,7 +548,6 @@ static void __init free_initrd(void)
>         initrd_end = 0;
>  }
>
> -#ifdef CONFIG_BLK_DEV_RAM
>  #define BUF_SIZE 1024
>  static void __init clean_rootfs(void)
>  {
> @@ -595,7 +594,6 @@ static void __init clean_rootfs(void)
>         ksys_close(fd);
>         kfree(buf);
>  }
> -#endif
>
>  static int __init populate_rootfs(void)
>  {
> @@ -638,8 +636,10 @@ static int __init populate_rootfs(void)
>                 printk(KERN_INFO "Unpacking initramfs...\n");
>                 err = unpack_to_rootfs((char *)initrd_start,
>                         initrd_end - initrd_start);
> -               if (err)
> +               if (err) {
>                         printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
> +                       clean_rootfs();
> +               }
>                 free_initrd();
>  #endif
>         }
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
