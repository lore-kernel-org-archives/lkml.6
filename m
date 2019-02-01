Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F87C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3EC21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j4cFZzHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfBAIUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:20:38 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36596 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfBAIUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:20:38 -0500
Received: by mail-ua1-f68.google.com with SMTP id j3so1957724uap.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 00:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgB+ne7YaDqvuaI0shIQeHIQYQ8Rfap5CVwqUaZPmXI=;
        b=j4cFZzHAhlDpDSdtZLIQ2K99O06woPbCnnwWy1iR+veXkNZSzOcNjpGM615b2kmqeq
         9CZyRl+usxEXTWDe6voi3EDnqIwcW8EqPUE+Dcd1RPH1FiPjJ/9nH/z1OTG7WJKUvdmu
         6Kye1f1KqzThiHASg7+zY2u7H1bRvcw6jJpV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgB+ne7YaDqvuaI0shIQeHIQYQ8Rfap5CVwqUaZPmXI=;
        b=C/Jg+/9MDmDyI3hWmtcQqs4cj5H9wmqM+m1iOGMkmOUr81Q3a5sutk5RnRb5XhFOR9
         RpvNvG6Z5nh40Hpz2Yt+lz9ip6UmiHNV7aKXaJPts66J3/tvzu6tgR6R3zrZHFtG8Spo
         bFXwId18Fgsnfwkf72H1QQ46oPGwT2txThObkGQmXu4PBh2D4zIKqp09C3djNPPjeG1P
         GOBj0j2TWzJS++zL7YLg9SZVeooyuRnDBVKObovS562u2BGI4P//kAffAsvwtak2TOtd
         B+uU0UiPW03viGU2OsjGAn1+UBlvNm1lnpx/fO4MwvUMQwtNXlHfwIQEjTgK9JjoRxaw
         +Bkg==
X-Gm-Message-State: AJcUukeojjoWqJJXxDYLpYEVnbpbKiely9BtzI6dUM07TC1A9wtXEWY0
        LSu+J/hh3krB4qwNgpygn6f1/WHQxYI=
X-Google-Smtp-Source: ALg8bN5ZQ6f5e1BEGQnAJysECTWdlElg+SABVvmCE/6GTJZceqEzZjkp0POgKQq5/j+qatNwYd4Ftg==
X-Received: by 2002:ab0:1601:: with SMTP id k1mr15954096uae.74.1549009236292;
        Fri, 01 Feb 2019 00:20:36 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id r130sm2619488vka.55.2019.02.01.00.20.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 00:20:34 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id t8so1967550uap.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 00:20:34 -0800 (PST)
X-Received: by 2002:ab0:740a:: with SMTP id r10mr14757503uap.14.1549009233563;
 Fri, 01 Feb 2019 00:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20190201054853.28541-1-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <20190201054853.28541-1-caoj.fnst@cn.fujitsu.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 1 Feb 2019 21:20:21 +1300
X-Gmail-Original-Message-ID: <CAGXu5jJ+1==nCOCOwL=-UPfZ8rBA_u_Y82dpD75gxzdBOTK+Gw@mail.gmail.com>
Message-ID: <CAGXu5jJ+1==nCOCOwL=-UPfZ8rBA_u_Y82dpD75gxzdBOTK+Gw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: minor improvement in kaslr
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 6:51 PM Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>
> comments fix: input_size is ZO image size which just don't count .bss
> in, but has .text, .data, etc;
> drop unecessary alignment: minimum is either 512M or output, both are
> CONFIG_PHYSICAL_ALIGN aligned(output is aligned in head_32/64.S). But
> mention it in earlier comments.
>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 9ed9709d9947..a947c5aba34e 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -360,7 +360,7 @@ static void handle_mem_options(void)
>   * (i.e. it does not include its run size). This range must be avoided
>   * because it contains the data used for decompression.
>   *
> - * [input+input_size, output+init_size) is [_text, _end) for ZO. This
> + * [input+input_size, output+init_size) is [_bss, _end) for ZO. This

This isn't right. The comment was correct before. See
arch/x86/boot/compressed/vmlinux.lds.S for the layout of the ZO image:
after the compressed image is _text, _rodata, _got, _data, _bss,
_pgtable, and _end. "[_text, _end)" correctly identifies the span
used.

>   * range includes ZO's heap and stack, and must be avoided since it
>   * performs the decompression.
>   *
> @@ -763,9 +763,6 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
>                 return 0;
>         }
>
> -       /* Make sure minimum is aligned. */
> -       minimum = ALIGN(minimum, CONFIG_PHYSICAL_ALIGN);
> -

I would prefer to keep this runtime calculation since it enforces the
requirement instead of making leaving it in a comment. When this goes
wrong, you get an unbootable kernel, which is very frustrating to
debug.

>         if (process_efi_entries(minimum, image_size))
>                 return slots_fetch_random();
>
> @@ -831,8 +828,8 @@ void choose_random_location(unsigned long input,
>
>         /*
>          * Low end of the randomization range should be the
> -        * smaller of 512M or the initial kernel image
> -        * location:
> +        * smaller of 512M or the initial kernel image location.
> +        * Should be aligned to CONFIG_PHYSICAL_ALIGN.

This is fine to mention, sure.

-Kees

>          */
>         min_addr = min(*output, 512UL << 20);
>
> --
> 2.17.0
>
>
>


-- 
Kees Cook
