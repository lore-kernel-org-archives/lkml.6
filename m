Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA91C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD88B2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGX95xnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbeLOQvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:51:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52761 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLOQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:51:13 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so13398592itg.2;
        Sat, 15 Dec 2018 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGxr7A2voH2TkNOB1rGt5Wz6C1v+sybWUaX7/ljIt4c=;
        b=TGX95xnvfVH7/NSUuxpFI0oIS/QL/tM7oYoh9AVfbKEQ5znqSk9uAighXrZKgmUAK+
         5AQDVZ/WJQlXvJOxuyCkwOMMJLKVB57TDxNR80MqpDtpHY7r4BLkhjiqnTXh42NW800N
         Qxr0Y2NREhT9BiUsC7WHW3vO921zikn0xblzhf6NnyArgmaM0GzGcGjg3Xi2HBAwSlVD
         rAFET9BPn52Dvr3fZfpkP7F4Kg80/eMcZvjodFI6lLpCfSM6ONJKsBCvPmvOPSFJUP1p
         Ft9+aCo5Jpaj8nr/2/xn70g/cTXc10ztS4Xg06EEkA5fV/s5dWeOy5qk1d5f4W7/GhTZ
         IgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGxr7A2voH2TkNOB1rGt5Wz6C1v+sybWUaX7/ljIt4c=;
        b=uD6Dfc8+0pjN8oA4wHjUvsTfP7HmMsbkM7nhGzucpShRZ4S35rZIXwxwA07T0ryaVb
         /ad9a+hzen6UtKbtCHb7Z2Pf1E5wAzevLie5vQFIKG+XA4OvSUMaOwABt59bZ1C2Ph8D
         NzZH7q3LGcSfFy6Vas88KzRaHnCIx0ue/0Fq85Qo1R+eELkn+7PVYjMzj6qaJryJZAIX
         RPQFGHTBQyb8MEbW01r+q/puR2ab0VGrYD1DnALBdS44gRg8Np/IBbg+pcrAtr8q7Ffp
         59QHnPMeWyw+l7CCNOEeTVWrk2sKMIgrXhgU8vq9D5iJIb4jrn8UlCDjwZ1geaJ+bqwu
         Z6NQ==
X-Gm-Message-State: AA+aEWYJ7zHogMDiry6LPWjZh1rPCtKAIvBRRE5FSE4SHpj4Kr3+LGJX
        Nmzjc9iFlEQ2tGTjzuXFqeyA6QDA6qF+fWsIr6w=
X-Google-Smtp-Source: AFSGD/WpjpPkHSfPDhuhJ+mnyXqLZ0jWs/45zzqwCTZcCW/Hx3vWWMae2ZD/UrDeBPloJsrhHkflvv8GzrDT7Lf/NvQ=
X-Received: by 2002:a24:1c86:: with SMTP id c128mr7016135itc.58.1544892671400;
 Sat, 15 Dec 2018 08:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
 <20181211202520.16799-7-deepa.kernel@gmail.com> <CAF=yD-LDWrjxK+XFv-KNAoyP7NCOZiL00n5PkzQ-5aEzq+eCLQ@mail.gmail.com>
 <CABeXuvpAZfd6gAdJbKxsOowXnDnwyQQRuYMJ-6LDo9BsRDDj-g@mail.gmail.com> <CAF=yD-L4xTU-KXsQ=uU36fEKv5St=69mmKqT8sD1mAmT_hfuVQ@mail.gmail.com>
In-Reply-To: <CAF=yD-L4xTU-KXsQ=uU36fEKv5St=69mmKqT8sD1mAmT_hfuVQ@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 15 Dec 2018 08:50:58 -0800
Message-ID: <CABeXuvqrZgEDF5RYQEPJ8RyXDg0uvXx_qMq=2ER8Bc9RXFPDGQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     willemdebruijn.kernel@gmail.com
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

On Sat, Dec 15, 2018 at 7:12 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Fri, Dec 14, 2018 at 8:07 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > > > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> > > > index 00e45c80e574..352e3dc0b3d9 100644
> > > > --- a/arch/alpha/include/uapi/asm/socket.h
> > > > +++ b/arch/alpha/include/uapi/asm/socket.h
> > > > @@ -3,6 +3,7 @@
> > > >  #define _UAPI_ASM_SOCKET_H
> > > >
> > > >  #include <asm/sockios.h>
> > > > +#include <asm/bitsperlong.h>
> > > >
> > > >  /* For setsockopt(2) */
> > > >  /*
> > > > @@ -110,12 +111,22 @@
> > > >
> > > >  #define SO_TIMESTAMP_OLD         29
> > > >  #define SO_TIMESTAMPNS_OLD       35
> > > > +
> > > >  #define SO_TIMESTAMPING_OLD      37
> > > >
> > > > +#define SO_TIMESTAMP_NEW         62
> > > > +#define SO_TIMESTAMPNS_NEW       63
> > > > +
> > > >  #if !defined(__KERNEL__)
> > > >
> > > > -#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
> > > > -#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
> > > > +#if __BITS_PER_LONG == 64
> > > > +#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
> > > > +#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
> > > > +#else
> > > > +#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
> > > > +#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
> > > > +#endif
> > > > +
> > >
> > > This is not platform specific. Perhaps it can be deduplicated. The
> > > interface expects callers to include <linux/socket.h>, not
> > > <asm/socket.h> directly. So perhaps it can go there?
> >
> > I'm not following what you are saying here.
> >
> > Are you talking about in kernel users or userspace interface?
> >
> > Userspace should always include sys/socket.h according to the man page.
> > I'm not sure if userspace can even include linux/socket.h directly.
> > On my distribution this includes bits/socket.h which in turn includes
> > asm/socket.h.
>
> I meant include/uapi/linux/socket.h.
>
> But you're right that that is not referenced from sys/socket.h.
>
> I do see a reference to it in my bits/socket.h
>
>     /* Socket level message types.  This must match the definitions in
>        <linux/socket.h>.  */
>
> so perhaps the logic could be both there and in libc bits/socket.h.

bits/socket.h cannot be included directly, and it's just how one of
the libc implementations decided to do it.
It doesn't even have to exist.

> > Which file gets installed as asm/socket.h is defined per architecture
> > in the kbuild file such as
> > arch/ia64/include/uapi/asm/Kbuild (without series applied):
> >
> >  generic-y += poll.h
> >  generic-y += sembuf.h
> >  generic-y += shmbuf.h
> >  generic-y += socket.h
> >
> > Also the new timestamp numbers being added are not the same for all
> > architectures.
> >
> > So I'm not sure how this can be moved to linux/socket.h.
>
> Does that matter, as long as they are defined? This basic block is the
> same between all archs:

3 reasons for not doing this:

1. We do not want to break userspace. If we move this to
linux/socket.h all the userspace programs now have to include
linux/socket.h or get this definition through a new libc.
2. All the socket options are together in the file asm/socket.h. It
doesn't seem good for maintainability to move just a few bits
elsewhere.
3. There are only 4 arches (after the series is applied) that have
their own asm/socket.h. And, this is because there seems to be
significant differences to asm-generic/socket.h that don't seem
logically obvious to group and eliminate some of the defines.

Also for the other comment. The reason the conditionals were not
consistent is because they were not consistent to begin with.
I'm trying to follow your request to keep code churn to minimal.
It's just that I moved to a different function as that seemed logical
to me. Do you prefer me to remove that refactoring?

-Deepa
