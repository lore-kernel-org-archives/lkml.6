Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00475C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE661208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRRnwyVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE661208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756724AbeFOW0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:26:04 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40882 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756429AbeFOW0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:26:03 -0400
Received: by mail-qt0-f196.google.com with SMTP id q6-v6so10492629qtn.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AQtI9HCegF1HRxom7L4r4ihjfxjqVJW6f7HX4X+3x08=;
        b=bRRnwyVJUtbYpw3fRV7vmBdhdEXzrWVorp16WNGZ2H33G+6eC0h+Zda+qDaFe3AYya
         X468uTuCX4W4XyoIlK1akgDPlZlggTpklnh2Vdjf0SFTFKuoDBHuw/ZmSGkEeRuGH3/k
         cOc+5OvabLZI1nzenf5yzTe+LtoaWvh3aLdnDGj1kDk789InJuBPdyp19wNd4P0yQCEc
         eGf33Qhkyb8g/C2w3xRc4bYYLlVJwckIYmuoEuXGiI1Se1DiiO47G7Wm382Tzla1YE3t
         xvMgp1ycQFTNwj+58zAifPy8+zhlQW1j6V8db3ulwzqgTQxREPTd893F339T0Wg67OgN
         4z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AQtI9HCegF1HRxom7L4r4ihjfxjqVJW6f7HX4X+3x08=;
        b=YyPbtz0X6D7MuQLoN8MIKB63DhT3vMcEK1DpQcVYF3vGArcTzvW7E0SGD+Jnxm0wz5
         hcc1VKKBWtBxl6ygHc/7QFij5zNbmzBgigl5KC3wWxnAGDFEJu1s7FwYzlpTPF3WxJVL
         GSeVpLlHWYMKyrA91/LSEi6uYEAH+SzOQFb9Lt7diMv8ueyrh0XrEUjuZp/eYlksRaeX
         ypmjVOEhNhAV42ySjqB+GkRnV44/laXoVY4Nxg3IaYIhd1m7D8A6VXnD559rYJbzpJIe
         5iSw+RPUkRejvnWw6LBY0EXdsm6cESvGaIwiZw/wkp4AKNJPZLspgwFXfsLtx3jI6pCj
         k51w==
X-Gm-Message-State: APt69E3zY7zQf94P75TymcC3G0NTO8BLlXoJESgrjKuhwHbp9ywt3w7y
        1GRczu6jUc3z8ISkHVZbZMSDLyGm3v10pEmP5F8=
X-Google-Smtp-Source: ADUXVKJvbahqpmkU7gaCMUtwk1MiJQwRnLRkuNlcOZ1HxGeOw1cLJRj1/f3KljIXkCIboHXMBt3FVdlQt5x8u16afRU=
X-Received: by 2002:aed:3e51:: with SMTP id m17-v6mr3262971qtf.283.1529101562629;
 Fri, 15 Jun 2018 15:26:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7190:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 15:26:01
 -0700 (PDT)
In-Reply-To: <20180615121716.37fb93385825b0b2f59240cc@linux-foundation.org>
References: <20180606194144.16990-1-malat@debian.org> <CA+8MBbKj4A5kh=hE0vcadzD+=cEAFY7OCWFCzvubu6cWULCJ0A@mail.gmail.com>
 <20180615121716.37fb93385825b0b2f59240cc@linux-foundation.org>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Fri, 15 Jun 2018 15:26:01 -0700
Message-ID: <CA+8MBbJyXC7YmnjG-k+mahC0ZiSgZy=EoiO0N5gvw8S4afLqng@mail.gmail.com>
Subject: Re: [PATCH] mm/memblock: add missing include <linux/bootmem.h>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:17 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:

> Huh.  How did that ever work.  I guess it's either this:
>
> --- a/mm/Makefile~a
> +++ a/mm/Makefile
> @@ -45,6 +45,7 @@ obj-y += init-mm.o
>
>  ifdef CONFIG_NO_BOOTMEM
>         obj-y           += nobootmem.o
> +       obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o
>  else
>         obj-y           += bootmem.o
>  endif
> @@ -53,7 +54,6 @@ obj-$(CONFIG_ADVISE_SYSCALLS) += fadvise
>  ifdef CONFIG_MMU
>         obj-$(CONFIG_ADVISE_SYSCALLS)   += madvise.o
>  endif
> -obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o
>
>  obj-$(CONFIG_SWAP)     += page_io.o swap_state.o swapfile.o swap_slots.o
>  obj-$(CONFIG_FRONTSWAP)        += frontswap.o

That option gave me a boatload of undefined symbols.

> or this:
>
> --- a/include/linux/bootmem.h~a
> +++ a/include/linux/bootmem.h
> @@ -154,7 +154,7 @@ extern void *__alloc_bootmem_low_node(pg
>         __alloc_bootmem_low_node(pgdat, x, PAGE_SIZE, 0)
>
>
> -#if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)
> +#if defined(CONFIG_HAVE_MEMBLOCK)
>
>  /* FIXME: use MEMBLOCK_ALLOC_* variants here */
>  #define BOOTMEM_ALLOC_ACCESSIBLE       0

That compiles cleanly, but didn't boot:

 [<a000000100029910>] ia64_fault+0xf0/0xe00
                                sp=e0000004fb37f8a0 bsp=e0000004fb371438
 [<a00000010000c920>] ia64_leave_kernel+0x0/0x270
                                sp=e0000004fb37fba0 bsp=e0000004fb371438
hid-generic 0003:0624:0200.0001: input: USB HID v1.10 Mouse [Avocent
USB_AMIQ] on usb-0000:00:1d.0-2/input1
 [<a00000010020b100>] pcpu_find_block_fit+0x20/0x300
                                sp=e0000004fb37fd70 bsp=e0000004fb3713a8
 [<a00000010020ee70>] pcpu_alloc+0x630/0xc40
                                sp=e0000004fb37fd90 bsp=e0000004fb371308
input: Avocent USB_AMIQ as
/devices/pci0000:00/0000:00:1d.0/usb4/4-2/4-2:1.0/0003:0624:0200.0002/input/input3
 [<a00000010020f520>] __alloc_percpu+0x40/0x60
                                sp=e0000004fb37fda0 bsp=e0000004fb3712e0
 [<a0000001002fb4c0>] alloc_vfsmnt+0x1c0/0x4e0
                                sp=e0000004fb37fda0 bsp=e0000004fb371280
 [<a000000100303d10>] vfs_kern_mount+0x30/0x2a0
                                sp=e0000004fb37fdf0 bsp=e0000004fb371238


> and I'm not sure which.  I think I'll just revert $subject for now.

Reverting is a good short term fix.

-Tony
