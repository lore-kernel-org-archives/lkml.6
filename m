Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2F9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A02218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPUVg7P/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeLRV2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:28:01 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36409 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRV2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:28:00 -0500
Received: by mail-io1-f68.google.com with SMTP id m19so13967917ioh.3;
        Tue, 18 Dec 2018 13:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+4TnHrfI6zYyhZHg0GbGxgjAJe/nrWkO6NadpWyjc4=;
        b=uPUVg7P/W/I/La99y40K+swKIPutRK3MQtD2YDbxV7m6bijJB+KG0oRNGLiobtldI8
         MVRNwA9WeIweEMVoCL9UHXn/2a9/NiHR5vfdMY3WAy59QidK+53AnG8oHhDxNNNudvnS
         f4GM7jFP2wpdw90YpF2Tx1w01+dJrw2FmqmwTG6Vxo/FHrHnocyB1DzcHOAF6c+QtrqB
         IE1hBbwi3PUaHMxpianUOW7A8WTF//yhfet+QczC7ontEVLWlKMfSDHfAO5qIcYSSYbR
         ozL9R6ffhhQqiOd9TuwsM2XMkTE4cS05+aX6Vq4Dx9wR2XjtLt/gXK1EfWbAK6lE+x/Y
         O/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+4TnHrfI6zYyhZHg0GbGxgjAJe/nrWkO6NadpWyjc4=;
        b=QYL7iuO3EJBiMMzx2dbMskyBrvr2xi0U0Ezfm8QO3GFxmQesSEpSY6X0k6Ty1dFIF6
         OVZK98a3BhPQoEQw616XDb2MozTjBTzS8/mU54bP2rS/90tvEfjSs26cVSJsgfuHglFG
         wNU+frwFVRS2h2pVDJa/3qpIl1jI2oLO54/j5q1ScD5bdhczKaQofLqSMxdnKjRZEUiy
         5AxU4yw6V9TXjxPUy1m71SYlVe8tq68SAs4RCwSbbOcs1+psfYfy+h2WHcaIN9Xls1Hx
         Sf6ziHzHDHWIBZ8qeXsH0shikWGJFGzm1ANttZYsjntXD4QEhGg4qIpAJH4L7nGqcHiM
         Msew==
X-Gm-Message-State: AA+aEWYFI7Lo2ffD6oNmZ8wvOOanDi3vVkxzO6Zug0fHZCCnTcsdnmwJ
        XEgmybnA6DdAkQMZbV0/46a4qOJqQBPwTV/TszI=
X-Google-Smtp-Source: AFSGD/Uih6uO/bVCHDY7h7xtvuIXDZPjVCnhy93uTqMdsz1V56wfPe1Vc/Oe04JQE4DrcQ5u7JI/pQUzEFMMj8BLG8Y=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr17146900ioa.34.1545168479368;
 Tue, 18 Dec 2018 13:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
 <20181211202520.16799-7-deepa.kernel@gmail.com> <CAF=yD-LDWrjxK+XFv-KNAoyP7NCOZiL00n5PkzQ-5aEzq+eCLQ@mail.gmail.com>
 <CABeXuvpAZfd6gAdJbKxsOowXnDnwyQQRuYMJ-6LDo9BsRDDj-g@mail.gmail.com>
 <CAF=yD-L4xTU-KXsQ=uU36fEKv5St=69mmKqT8sD1mAmT_hfuVQ@mail.gmail.com>
 <CABeXuvqrZgEDF5RYQEPJ8RyXDg0uvXx_qMq=2ER8Bc9RXFPDGQ@mail.gmail.com>
 <CAF=yD-KFYdXRgL-HpAJLLHuywMcaBGfz7sDL35DBNs0hoq+zxQ@mail.gmail.com> <CAK8P3a0PFQCqo2Ofce7uJeWAgssMbh8u1CNWeAmUk9LzQRn35g@mail.gmail.com>
In-Reply-To: <CAK8P3a0PFQCqo2Ofce7uJeWAgssMbh8u1CNWeAmUk9LzQRn35g@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 18 Dec 2018 13:27:48 -0800
Message-ID: <CABeXuvru4uY01DJW-rOCsG3hs6hLmDRuUCGSSPHrNDcAEm7y5Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 8:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Dec 15, 2018 at 7:52 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > > 3 reasons for not doing this:
> > >
> > > 1. We do not want to break userspace. If we move this to
> > > linux/socket.h all the userspace programs now have to include
> > > linux/socket.h or get this definition through a new libc.
> > > 2. All the socket options are together in the file asm/socket.h. It
> > > doesn't seem good for maintainability to move just a few bits
> > > elsewhere.
> > > 3. There are only 4 arches (after the series is applied) that have
> > > their own asm/socket.h. And, this is because there seems to be
> > > significant differences to asm-generic/socket.h that don't seem
> > > logically obvious to group and eliminate some of the defines.
> >
> > Agreed. All good reasons to leave as is.
> >
> > > Also for the other comment. The reason the conditionals were not
> > > consistent is because they were not consistent to begin with.
> >
> > The only difference I see is an inversion of the test. Nesting order
> > is the same:
> >
> >         int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
> >         ...
> >         if (need_software_tstamp) {
> >                 if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> >                 } else {
> >                 }
> >         }
> >
> > vs
> >
> >                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
> >                         if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> >                         } else {
> >                         }
> >                 }
> >
> > I suggest just adding something like
> >
> >         if (need_software_tstamp) {
> > +              if (sock_uses_new_tstamp(sk) {
> > +                   __sock_recv_timestamp_new(msg, sk,
> > ktime_to_timespec64(skb->tstamp));
> > +              } else if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > -               if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> >                 } else {
> >                 }
> >
> > and
> >
> >                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
> > +                      if (sock_uses_new_tstamp(sk) {
> > +                           __sock_recv_timestamp_new(msg, sk, ts);
> > +                      else if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > -                       if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> >                         } else {
> >                         }
>
> Generally speaking, I think we want the new time handling
> to be written as the default case rather than have it hidden away
> in a separate function. If we didn't have the sparc64 quirk with its
> unusual timeval definition, we'd only need a special flag for the
> old 32-bit format, but that doesn't work as long we have to support
> two different 64-bit formats for 64-bit timeval on sparc64
> (32 or 64 bit microseconds).
>
> > Note also (2) tentative helper function sock_uses_new_tstamp(const
> > struct sock *sk) instead of testing sock_flag(sk, SOCK_TSTAMP_NEW)
> > directly. Since the .._NEW variants are equivalent to .._OLD on 64-bit,
> > I wonder if we can just compile out the branch. Something like
> >
> >     static inline bool sock_uses_new_tstamp(const struct sock *sk) {
> >             return (sizeof(time_t) != sizeof(__kernel_long_t)) &&
> >                        sock_flag(sk, SOCK_TSTAMP_NEW);
> >     }
>
> I think that would break compat handling: when we have a 32-bit
> user space process, the difference between old and new timestamps
> is meaningful even on 64-bit kernels, but the distinction is only made all
> the way down in put_cmsg_compat().

As I mentioned previously, I have refrained from adding these
optimizations for now.
The old timestamps are as is and the new timestamps are not yet being
used anywhere as we have not switched any of the architectures to use
y2038 syscalls and data structures yet.
So even if these optimizations are needed these can be added as
separate patches.
Let me know if this is acceptable for everyone and I can post the update.

-Deepa
