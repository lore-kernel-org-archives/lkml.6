Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E419C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC56020869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AvJwXZw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfBBNlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:41:23 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:32653 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbfBBNlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:41:23 -0500
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x12DfD6B030522;
        Sat, 2 Feb 2019 22:41:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x12DfD6B030522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549114874;
        bh=s3TRDqxD7T5/l6shlEbsSJ2sRb+JoZifP1FmNIyCMeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AvJwXZw2kcCZqbIyddje7XBX0OJkltDGdCbVgxTph/qlMqEJfk/cP0Qys/cdMp/po
         mjQBpHK4zFjLCz/ZJuNpOFapsXdC1YikDpKLk+LcnVHCMtgLw+KneVLumi4uXbrL08
         HhYCmGZjs8xI8S4DirrmarmQa1m3KOksHiENcQgwKRaRRQdcAQ7/nxa5Tol6/NM2x4
         7gzS7N/4XL8ajsOkAcUjItNzfYfvDabR9VgbxilB4lm3idInnCxQ5gwo6/N+dpUnI/
         YNZO0bnRdKfq5k3dKxMCw18q7OQBxYIuxb3aKW2POvj+D89DuGgof/7DHoMEzuAw/D
         2D6ABhZALjE7Q==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id z11so3113456uaa.10;
        Sat, 02 Feb 2019 05:41:14 -0800 (PST)
X-Gm-Message-State: AJcUukcAwtuzebLaWPAwOKB10HR3X+dDWLPB0sn3szSRUOkcpeAOYmjw
        bKoOE2f4VdMjb0rq4aXbedRFert7JJZOjR9hQ34=
X-Google-Smtp-Source: ALg8bN6IB2sqI3V6x7lPATwpS8S66HiDhucSND4ViEsI8gUQuJdDJ3Z14ItwDULRvrrZc5C2TnLphKXgBqx2DQ+2Io0=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr16874554uaj.42.1549114872829;
 Sat, 02 Feb 2019 05:41:12 -0800 (PST)
MIME-Version: 1.0
References: <1548904535-9853-1-git-send-email-yamada.masahiro@socionext.com> <20190201235852.l7tlw5jkcpkwivsd@ast-mbp>
In-Reply-To: <20190201235852.l7tlw5jkcpkwivsd@ast-mbp>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 2 Feb 2019 22:40:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARymYwzcOYrc5=3Ve2h1RgEtV8CnsJZm=55z9bHMCUs=g@mail.gmail.com>
Message-ID: <CAK7LNARymYwzcOYrc5=3Ve2h1RgEtV8CnsJZm=55z9bHMCUs=g@mail.gmail.com>
Subject: Re: [PATCH] bpfilter: remove extra header search paths for bpfilter_umh
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        Matteo Croce <mcroce@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Laura Abbott <labbott@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 2, 2019 at 9:00 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 31, 2019 at 12:15:35PM +0900, Masahiro Yamada wrote:
> > Currently, the header search paths -Itools/include and
> > -Itools/include/uapi are not used. Let's drop the unused code.
> >
> > We can remove -I. too by fixing up one C file.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > Perhaps, are these extra header search paths for
> > more upstreaming in the future?
> >
> > If this patch is rejected, I will send an alternative one.
> >
> > To clean up the Kbuild core,
> > I want to drop as many unused header search paths as possible.
> >
> >
> >  net/bpfilter/Makefile | 1 -
> >  net/bpfilter/main.c   | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> > index 0947ee7..5d6c776 100644
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
> > index 1317f10..61ce845 100644
> > --- a/net/bpfilter/main.c
> > +++ b/net/bpfilter/main.c
> > @@ -6,7 +6,7 @@
> >  #include <sys/socket.h>
> >  #include <fcntl.h>
> >  #include <unistd.h>
> > -#include "include/uapi/linux/bpf.h"
> > +#include "../../include/uapi/linux/bpf.h"
>
> argh. that's not pretty.
> I would prefer to keep -I in a makefile


This hunk is not a question.

The code #include "include/uapi/linux/bpf.h" is wrong
if you understand the meaning of #include "..."

https://gcc.gnu.org/onlinedocs/cpp/Search-Path.html


The directive #include "include/uapi/linux/bpf.h"
means the preprocessor should look for this header first
in the path relative to the directory of net/bpfilter/main.c

That is, the preprocessor will look for
net/bpfilter/include/uapi/linux/bpf.h
which obviously does not exist.


I am fixing this because adding -I.
in kernel Makefile is always wrong.
For example, commit 5cd5548ff439b91


-- 
Best Regards
Masahiro Yamada
