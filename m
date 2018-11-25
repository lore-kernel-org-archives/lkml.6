Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F29C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 05:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D689420865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 05:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEzbHJfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D689420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeKYQSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 11:18:36 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44856 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbeKYQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 11:18:35 -0500
Received: by mail-io1-f67.google.com with SMTP id r200so11435416iod.11;
        Sat, 24 Nov 2018 21:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZDq+TkzUn/G29okEW5qiws/BZ6VkEyzQgI0POq8fhg=;
        b=kEzbHJfwAO3bNFDX5jEerzuVr38CtCa0HNsxzNCCZi3XLJA985hLZfC6LXcmVHkEXY
         JzFGSM1VziqJMg7GWZoL121v60MVGNrhgjCgfcglRfSfBUExpcQYcc+sEfCTXgDnrpql
         EcoGAJt6EVCwE+QYQEHv7i5a2XZMxQPvw9PJBp32rROSAZNvtC+wK5GERi1YdCmHDQ75
         ySy72kl0xaOFzHcDsSNU1fqdMybybIyLI3nbZYvmTD1EWRGnqAGAxKhN4SB1yn1DbIWI
         DI7m7jidGGCcpHk7F2p5l9/JbqdR0VrZV7FQA6P4BUtHHISs1UJyf0TntzzrH2c9X2Hl
         yCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZDq+TkzUn/G29okEW5qiws/BZ6VkEyzQgI0POq8fhg=;
        b=Wi7V/HHKFOcs14Xlo3/W+03UX24nL4H+TjDOLQWvlqPdbLZuCagI8u+IfCOozfz4C1
         2RK2Z5KeS2YUUjKqDh6ino/wY7Y8GDQKggK3tkYfux+wJZU7CR4XMWThxdR8SZcK2C+/
         /FRoO5e7V3VqbOT0G5YUljCSEOQOiSS3B1diUHFbLliovvvcpT5UV0O50Bd6D1TZMPBJ
         djGXyFtzbF3+f4KHOSKzieGatQLhVBYJzBmeSO1mL0e2NUR/zYqJVB8OHNKnvuV464TW
         wV7ZT/24CzMx01Vytl6FhFTZXoWTKlb2dzbC9OZfpxdkoM+Vupc3gYDPZ0/WbLtTN0DM
         NinQ==
X-Gm-Message-State: AA+aEWYMUGlTQeZ6o6dIawpuXPDxQm95mVZDOWmVIT/LjYUNcppERPyc
        3St4yCpkNJkDh8PChWWE1FOe5oVA1wbffHoECCc=
X-Google-Smtp-Source: AFSGD/U1ty8BkP5cpO7vIF/L63LH/hSWCd+dmHYeUvuVs/2kdjL2jXnEzeLz9Aba8BoAkxeLJSkjJVY4IoBl4eEZ+F4=
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr7941350ioa.266.1543123698794;
 Sat, 24 Nov 2018 21:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
In-Reply-To: <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 21:28:07 -0800
Message-ID: <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     willemdebruijn.kernel@gmail.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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

> > > +       if (type == SO_TIMESTAMP_NEW || type == SO_TIMESTAMPNS_NEW)
> > > +               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> > > +       else
> > > +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> > > +
> >
> > if adding a boolean whether the socket uses new or old-style
> > timestamps, perhaps fail hard if a process tries to set a new-style
> > option while an old-style is already set and vice versa. Also include
> > SO_TIMESTAMPING_NEW as it toggles the same option.

I do not think this is a problem.
Consider this example, if there is a user application with updated
socket timestamps is linking into a library that is yet to be updated.

Besides, the old timestamps should work perfectly fine on 64 bit
arches even beyond 2038.
So failing here means adding a bunch of ifdef's to verify it is not
executing on 64 bit arch or something like x32.

> > > diff --git a/net/socket.c b/net/socket.c
> > > index d3defba55547..9abeb6bc9cfe 100644
> > > --- a/net/socket.c
> > > +++ b/net/socket.c
> > > @@ -699,6 +699,38 @@ static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb)
> > >                  sizeof(ts_pktinfo), &ts_pktinfo);
> > >  }
> > >
> > > +static void sock_recv_sw_timestamp(struct msghdr *msg, struct sock *sk,
> > > +                                  struct sk_buff *skb)
> > > +{
> > > +       if (sock_flag(sk, SOCK_TSTAMP_NEW)) {
> > > +               if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > > +                       struct sock_timeval tv;
> > > +
> > > +                       skb_get_new_timestamp(skb, &tv);
> > > +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
> > > +                                sizeof(tv), &tv);
> > > +               } else {
> > > +                       struct __kernel_timespec ts;
> > > +
> > > +                       skb_get_new_timestampns(skb, &ts);
> > > +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
> > > +                                sizeof(ts), &ts);
> > > +               }
> > > +       }
> > > +       if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > > +               struct __kernel_old_timeval tv;
> > > +
> > > +               skb_get_timestamp(skb, &tv);
> > > +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
> > > +                        sizeof(tv), &tv);
> > > +       } else {
> > > +               struct timespec ts;
> > > +
> > > +               skb_get_timestampns(skb, &ts);
> > > +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
> > > +                        sizeof(ts), &ts);
> > > +       }
> > > +}
> > >  /*
> > >   * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
> > >   * or sock_flag(sk, SOCK_RCVTSTAMPNS)
> > > @@ -719,19 +751,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> > >                 false_tstamp = 1;
> > >         }
> > > -       if (need_software_tstamp) {
> >
> > Considerably less code churn if adding __sock_recv_timestamp_2038 and
> > calling that here:
> >
> >                    if (sock_flag(sk, SOCK_TSTAMP_NEW))
> >                            __sock_recv_timestamp_2038(msg, sk, skb);
> >                    else if ...
> >
> > Same for the tcp case above, really, and in the case of the next patch
> > for SO_TIMESTAMPING_NEW
>
> That naming convention, ..._2038, is not the nicest, of course. That
> is not the relevant bit in the above comment.
>
> Come to think of it, and related to my question in patch 2 why the
> need to rename at all, could all new structs, constants and functions
> be named consistently with 64 suffix? __sock_recv_timestamp64,
> SO_TIMESTAMPING64 and timeval64 (instead of sock_timeval,
> it isn't really a sock specific struct)?
>
> I guess that there is a good reason for the renaming exercise and
> conditional mapping of SO_TIMESTAMP onto old or new interface.
> Please elucidate in the commit message.

I think there is some confusion here.

The existing timestamp options: SO_TIMESTAMP* fail to provide proper
timestamps beyond year 2038 on 32 bit ABIs.
But, these work fine on 64 bit native ABIs.
So now we need a way of updating these timestamps so that we do not
break existing userspace: 64 bit ABIs should not have to change
userspace, 32 bit ABIs should work as is until 2038 after which they
have bad timestamps.
So we introduce new y2038 safe timestamp options for 32 bit ABIs. We
assume that 32 bit applications will switch to new ABIs at some point,
but leave the older timestamps as is.
I can update the commit text as per above.

-Deepa
