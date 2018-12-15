Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29D0C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636C32086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8n6DnWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbeLOPME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:12:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33520 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeLOPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:12:03 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so7321177eds.0;
        Sat, 15 Dec 2018 07:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0rnw73UaXdNzttsDaAG6QqR/lhfSpIOwVTtyGMrH4A=;
        b=N8n6DnWpps5OwUl+jj3CseJfOy6KyTylwa57aK65GoZ0J2meflKvU++9cUvpvg5uPV
         J1Ac9ij0RbK9KxN855i1cm4mqwGrXl+y1Y5PI1iniqsu8s6QSHW7fYxXFHnP4upGX8iN
         DV07grDA6JKqmjakSyxYBjLwD9ehB+KHTggpA+ORnImKeX8T7u2X2Zv6eh048PedJPy1
         0/sj1Gzwh3NR5GD+/ZEWHInTld/6Vu8M+mnwRs6xrs8A2zGlAW94pUK3/PFEzZlYkytC
         xZWTo5rCUdqIht9ML8bOpRIPNiS5rsS8i61vyM8bn5L8hTchBshxewnpZ2FTCbYOLSZk
         uPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0rnw73UaXdNzttsDaAG6QqR/lhfSpIOwVTtyGMrH4A=;
        b=Vu81nEVEvnIw7aWGZNph/zfLdZsRfrKfKkSyPS6y7v7oUj78LXXIxQ0lLTMRoie3c1
         hA/sylw9lq7LLaj+mQtMyRtg7hn6muvet5T5WMpjFaq5kzNuuNTf3ecAv076ISWwb913
         dXNdvG8Y2swr7vbNGyCD60vukBO+tbMtRS7zmoiYAbNqsTPl4/TvetMHgd7MoWT0yw3M
         gdBZHb/0u/8Dw8Be/JxjBW8wAwNRSs30hyvmRSZT0M8gxpyeHB2wqQl6Dk+CA8mp2BWP
         RFxxi+wI/WU97kf0wWvOLaZ0yT1UENVsnsYFfOxD389bLAUCiilu7InHvi1e1S9eHm3i
         FzGg==
X-Gm-Message-State: AA+aEWZ8SrK1XW4EPWPgvm4Qyoo6LKBJ+e9cJH0v4+tFh+TWw7e4qah3
        WsMhFSFmVjv406mzQVWgIHGqnz2r67oRw5HO8A3ub0wk
X-Google-Smtp-Source: AFSGD/V6TNyqwJyVlDqAC6jqdMeGdSsnFCtIispOB40zLS8ha9uaW7HrlFfUSXGSMx+esu81vOmkvjUlDNv++61mLTc=
X-Received: by 2002:a50:bdc8:: with SMTP id z8mr6704530edh.46.1544886720966;
 Sat, 15 Dec 2018 07:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
 <20181211202520.16799-7-deepa.kernel@gmail.com> <CAF=yD-LDWrjxK+XFv-KNAoyP7NCOZiL00n5PkzQ-5aEzq+eCLQ@mail.gmail.com>
 <CABeXuvpAZfd6gAdJbKxsOowXnDnwyQQRuYMJ-6LDo9BsRDDj-g@mail.gmail.com>
In-Reply-To: <CABeXuvpAZfd6gAdJbKxsOowXnDnwyQQRuYMJ-6LDo9BsRDDj-g@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 15 Dec 2018 10:11:24 -0500
Message-ID: <CAF=yD-L4xTU-KXsQ=uU36fEKv5St=69mmKqT8sD1mAmT_hfuVQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ralf Baechle <ralf@linux-mips.org>, rth@twiddle.net,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-rdma@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 8:07 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> > > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> > > index 00e45c80e574..352e3dc0b3d9 100644
> > > --- a/arch/alpha/include/uapi/asm/socket.h
> > > +++ b/arch/alpha/include/uapi/asm/socket.h
> > > @@ -3,6 +3,7 @@
> > >  #define _UAPI_ASM_SOCKET_H
> > >
> > >  #include <asm/sockios.h>
> > > +#include <asm/bitsperlong.h>
> > >
> > >  /* For setsockopt(2) */
> > >  /*
> > > @@ -110,12 +111,22 @@
> > >
> > >  #define SO_TIMESTAMP_OLD         29
> > >  #define SO_TIMESTAMPNS_OLD       35
> > > +
> > >  #define SO_TIMESTAMPING_OLD      37
> > >
> > > +#define SO_TIMESTAMP_NEW         62
> > > +#define SO_TIMESTAMPNS_NEW       63
> > > +
> > >  #if !defined(__KERNEL__)
> > >
> > > -#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
> > > -#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
> > > +#if __BITS_PER_LONG == 64
> > > +#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
> > > +#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
> > > +#else
> > > +#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
> > > +#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
> > > +#endif
> > > +
> >
> > This is not platform specific. Perhaps it can be deduplicated. The
> > interface expects callers to include <linux/socket.h>, not
> > <asm/socket.h> directly. So perhaps it can go there?
>
> I'm not following what you are saying here.
>
> Are you talking about in kernel users or userspace interface?
>
> Userspace should always include sys/socket.h according to the man page.
> I'm not sure if userspace can even include linux/socket.h directly.
> On my distribution this includes bits/socket.h which in turn includes
> asm/socket.h.

I meant include/uapi/linux/socket.h.

But you're right that that is not referenced from sys/socket.h.

I do see a reference to it in my bits/socket.h

    /* Socket level message types.  This must match the definitions in
       <linux/socket.h>.  */

so perhaps the logic could be both there and in libc bits/socket.h.

> Which file gets installed as asm/socket.h is defined per architecture
> in the kbuild file such as
> arch/ia64/include/uapi/asm/Kbuild (without series applied):
>
>  generic-y += poll.h
>  generic-y += sembuf.h
>  generic-y += shmbuf.h
>  generic-y += socket.h
>
> Also the new timestamp numbers being added are not the same for all
> architectures.
>
> So I'm not sure how this can be moved to linux/socket.h.

Does that matter, as long as they are defined? This basic block is the
same between all archs:

    -#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
    -#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
    +#if __BITS_PER_LONG == 64
    +#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
    +#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
    +#else
    +#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ?
SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
    +#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t)
? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
    +#endif

It might be too complex to coordinate changes between kernel and libc
headers, in which case you're right that this just has to live in
(each arch's) asm/socket.h directly.
