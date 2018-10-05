Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5F2C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7922054F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7922054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeJEO1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:27:49 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45728 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbeJEO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:27:49 -0400
Received: by mail-vk1-f196.google.com with SMTP id l123-v6so2766320vkl.12;
        Fri, 05 Oct 2018 00:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6PSMvFJzZ0PvRtqT8MCqgBT61iBAdJxRU5HrfurwqU=;
        b=k6ioemKBZaCoykTZuCjCCZQlU4aaisVRU7BQRH4vD+RxOwGMR2XZErtkD4K0dVMEbO
         FO/nurLaRbNgtQ2kply1Je+f4PPY5Xq09+SGXUjswmSCacSkprJpOgrUW99Wxd8w9d87
         fKkcJF0ioqXHgRb6W6UWNlObBWHdcmz1bl5+Tzmd4lw7RFsEVxkAAAc1qW7uv6TrkGnw
         8ND4HDtTSuMIXaVb6LbBT7xOrPhIrY8AAOW2yqhDvaVTQnR/yixDqYRvvbmWEBeS+YwA
         r/oxksVICjXEq0YtsPyQiDllEMNH8xbH8v97lpj9EO7LL4DCBUQPwn1IgO1JIefzaZwW
         GSag==
X-Gm-Message-State: ABuFfohFZFmqnY31fDjdb3f4c/A7HsP5S6I4lzObQk0an4mp6T7OzxWB
        Xb+hOZ5zuV2Zy8sMB+uGf4gurYMF4t0Mg+QxDqE=
X-Google-Smtp-Source: ACcGV62Kn8qa7h1Kr+RCC8ilOnw6EHUUgztODJdQeXE32hnMSho9PJcpFOpdop87KywUoNqprc4mmmEdJ5ahH/wtH6E=
X-Received: by 2002:a1f:cd3:: with SMTP id 202-v6mr4015498vkm.74.1538724622576;
 Fri, 05 Oct 2018 00:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181004222953.2229-1-hpa@zytor.com> <20181004222953.2229-2-hpa@zytor.com>
In-Reply-To: <20181004222953.2229-2-hpa@zytor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 5 Oct 2018 09:30:10 +0200
Message-ID: <CAMuHMdWQnT=VBh1=zXTASfR+Z_8913BB4YeFXwz6ShpkSTycBA@mail.gmail.com>
Subject: Re: [PATCH 1/5] asm-generic, termios: add alias constants from MIPS
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for your patch!

On Fri, Oct 5, 2018 at 12:30 AM H. Peter Anvin (Intel) <hpa@zytor.com> wrote:
> Some architectures, in this case MIPS, need a couple of legacy alias
> constants for bits. There really is no reason why we can't define them
> generically for all architectures.

To avoid polluting namespace?
To avoid people using them in a context not specific to MIPS?

> --- a/include/uapi/asm-generic/termbits.h
> +++ b/include/uapi/asm-generic/termbits.h
> @@ -8,7 +8,10 @@ typedef unsigned char  cc_t;
>  typedef unsigned int   speed_t;
>  typedef unsigned int   tcflag_t;
>
> -#define NCCS 19
> +#ifndef NCCS
> +# define NCCS 19
> +#endif
> +
>  struct termios {
>         tcflag_t c_iflag;               /* input mode flags */
>         tcflag_t c_oflag;               /* output mode flags */
> @@ -49,6 +52,7 @@ struct ktermios {
>  #define VTIME 5
>  #define VMIN 6
>  #define VSWTC 7
> +#define VSWTCH VSWTC

I'd at least add a comment /* legacy MIPS */ here.

>  #define VSTART 8
>  #define VSTOP 9
>  #define VSUSP 10
> @@ -173,6 +177,7 @@ struct ktermios {
>  #define ECHONL 0000100
>  #define NOFLSH 0000200
>  #define TOSTOP 0000400
> +#define ITOSTOP TOSTOP

Likewise.

>  #define ECHOCTL        0001000
>  #define ECHOPRT        0002000
>  #define ECHOKE 0004000

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
