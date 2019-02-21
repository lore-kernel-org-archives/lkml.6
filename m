Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC4C20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="v2c+28sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfBUPz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:55:28 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:33617 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfBUPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:55:28 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x1LFtNaS018240;
        Fri, 22 Feb 2019 00:55:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x1LFtNaS018240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550764524;
        bh=Lr9NIItQ5zsT9NnlU3NK3LD3til6B4DYK9OuHutbDrM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v2c+28sRH30c2IequE/rN6R2qW8ZBoM5eyzaFNGiOKnpixGZeyyLB5j4ql0Qsi1F9
         7Kg3/dEQ5VVvGG7HlizWMtwZwZ9k+VK8qyCb5g7V27ua5YNbmykoYMtxpytni5FJcG
         0IERh6tsqvoPbtyrfqlWCEGN6QDZFJ2SytukWekdmMSqzCtfNL2hY+vEivA31fHtII
         UEwYp6T45R+K/FAipY+XTzihEWbgF/2cFLyCfAIjWwHiDf6iRA8PrMMem78i+9tE9k
         ozxfkYltMGojiRnbiDKL45hoxJ4yGMbrjjUMSnX3W5IYGUFGIbA3tLcFgXf7ZCUSgn
         Rh0LNvVVESqtQ==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id j8so9659169uae.13;
        Thu, 21 Feb 2019 07:55:24 -0800 (PST)
X-Gm-Message-State: AHQUAuaXDYMHQaY18vv7vJRmJ+ygawemJmEy//cNys/67Yk+4Emzr3Ry
        g+of+xSD2LJbWqN9TgEMhtkI4qeHLXfPv5P6G+Y=
X-Google-Smtp-Source: AHgI3IbtM4zV+1QkPYy0aCjgEtK4fQK7yZB7mCDQ9/ddqpTt6vdi9JSjXF/lT10/bo8ZNgYccCB6hCEncV/82hSmTK4=
X-Received: by 2002:ab0:648c:: with SMTP id p12mr16572302uam.93.1550764523487;
 Thu, 21 Feb 2019 07:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20190221144257.GA12892@roeck-us.net>
In-Reply-To: <20190221144257.GA12892@roeck-us.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 22 Feb 2019 00:54:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfiSrULgdG_tcm+m4wmyOjg4ZHYAB9EUgaGrjv=g-Zbg@mail.gmail.com>
Message-ID: <CAK7LNASfiSrULgdG_tcm+m4wmyOjg4ZHYAB9EUgaGrjv=g-Zbg@mail.gmail.com>
Subject: Re: [PATCH] bpfilter: remove extra header search paths for bpfilter_umh
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Jan 31, 2019 at 12:15:35PM +0900, Masahiro Yamada wrote:
> > Currently, the header search paths -Itools/include and
> > -Itools/include/uapi are not used. Let's drop the unused code.
> >
> > We can remove -I. too by fixing up one C file.
> >
>
> This patch reintroduces the problem last fixed with commit ae40832e53c3
> ("bpfilter: fix a build err"). Seen (at least) with gcc 7.4.0, 8.2.0.
> binutils version is 2.31.1. Reverting this patch fixes the problem.


Hmm. I cannot reproduce the build error with my gcc,
but you are right.


I'd like to get back only
'KBUILD_HOSTCFLAGS += -Itools/include/ -Itools/include/uapi'
instead of the full revert.

If David is fine with it, I can send a patch with filling commit log.



Thanks.



> Guenter
>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > ---
> >  net/bpfilter/Makefile | 1 -
> >  net/bpfilter/main.c   | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> > index 0947ee7f70d5..5d6c7760142d 100644
> > --- a/net/bpfilter/Makefile
> > +++ b/net/bpfilter/Makefile
> > @@ -5,7 +5,6 @@
> >
> >  hostprogs-y := bpfilter_umh
> >  bpfilter_umh-objs := main.o
> > -KBUILD_HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
> >  HOSTCC := $(CC)
> >
> >  ifeq ($(CONFIG_BPFILTER_UMH), y)
> > diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
> > index 1317f108df8a..61ce8454a88e 100644
> > --- a/net/bpfilter/main.c
> > +++ b/net/bpfilter/main.c
> > @@ -6,7 +6,7 @@
> >  #include <sys/socket.h>
> >  #include <fcntl.h>
> >  #include <unistd.h>
> > -#include "include/uapi/linux/bpf.h"
> > +#include "../../include/uapi/linux/bpf.h"
> >  #include <asm/unistd.h>
> >  #include "msgfmt.h"
> >
> > --
> > 2.7.4



--
Best Regards

Masahiro Yamada
