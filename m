Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66292C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A6B214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsIbBitb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A6B214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJIWKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:10:31 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52646 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIWKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:10:30 -0400
Received: by mail-it1-f194.google.com with SMTP id 134-v6so3034172itz.2;
        Tue, 09 Oct 2018 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7BVTazitQ38nthpwd2UFjerB9MlaBokQUm37HxYkKo=;
        b=VsIbBitbG3phadKclNU7lDq8GfZEufWPfloQj5KJcPIc/xEA3xuMOu7wk8I/OCmkcw
         /fnnSc+mH1/wK41EPAEbidR7wyc6DdrHmIUYNQ5Kj5fw/IviJBNkbn6ZsCh8TMw38cxL
         Wn5ri/hAjHumDXJj/mJdXXxBJVoAX9UvbI/Yd0TikNAR6OXuBsLqZ3VJE6zOQZ9Y7Twu
         BAGmvSC1vbjsl5aP1xF7HFqbSVdYsBwegiHS90GSj5dS88YHeg5R4EEOG+WGkDN16cmI
         j7HStsCAdqwfhrdJ2mZtA6QtIaQhXLyN1JznIYQFnYs/z9R+5EHZ8cDF6qsiEPMMuL9h
         /28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7BVTazitQ38nthpwd2UFjerB9MlaBokQUm37HxYkKo=;
        b=QtISFbofLAAVYUyfm2rAuPnFrMpq6EQK9lcaLo6axNhb7CRCVtD9TfgVo3bzGskft2
         zBwoGwyz7xO7Yv4mFrkdfx1sGk7Lc+hma2Yf03xgo5nsvFpWUouTMQtImupFqsOYGfVF
         N5/aTSkTiaR1oAnWR/4H7JUjg8j+ooH/hwovCzYN1h8kHLh2VitWR/lG9rc8ZNujshM3
         On9gThWRHAnUeeCjvfLe26ZUQAxRJzUVppdGQh5qEnDIs3qLPfmIIPoJYBR0LoO9TlU5
         xphxWwCgRlHbPwtnxh2/D7NLouABLzFqWYuFFEmKBzgHWBoy2kDfQ8kYf4Jhjs4U+niO
         YAtg==
X-Gm-Message-State: ABuFfogHQK6IbSloxJEgn3db2w6rSE6r96bBWs6XGdm75kHlCOF9mY95
        HyYy254vaG4lWYyjtbU+aiKKtII5f7Y7FZPgrRs=
X-Google-Smtp-Source: ACcGV63jCmi25JSlvy8LJJu8KFvpKbOchKTRdGXwPo7Xi5Y+dCa5SSEY4w3Dms1A1xWUKXhCQtTQ5FaZJT1wVQgRwQI=
X-Received: by 2002:a02:5a01:: with SMTP id v1-v6mr5106991jaa.11.1539096792459;
 Tue, 09 Oct 2018 07:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <1539086718-4119-1-git-send-email-laoar.shao@gmail.com>
 <1539086718-4119-2-git-send-email-laoar.shao@gmail.com> <CANn89iL1BMCx3Mbsj3TijR3Srjji95q86px0k98r7JYJbwLzcw@mail.gmail.com>
In-Reply-To: <CANn89iL1BMCx3Mbsj3TijR3Srjji95q86px0k98r7JYJbwLzcw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 9 Oct 2018 22:52:35 +0800
Message-ID: <CALOAHbBwGAqia_2xJSNkaX7TzSPN89bRz71qHRH43FtbwNTP6w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: forbid direct reclaim if MSG_DONTWAIT is
 set in send path
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 10:12 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Oct 9, 2018 at 5:05 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > By default, the sk->sk_allocation is GFP_KERNEL, that means if there's
> > no enough memory it will do both direct reclaim and background reclaim.
> > If the size of system memory is great, the direct reclaim may cause great
> > latency spike.
> >
> > When we set MSG_DONTWAIT in send syscalls, we really don't want it to be
> > blocked, so we'd better clear __GFP_DIRECT_RECLAIM when allocate skb in the
> > send path. Then, it will return immediately if there's no enough memory to
> > be allocated, and then the appliation has a chance to do some other stuffs
> > instead of being blocked here.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  net/ipv4/tcp.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 43ef83b..fe4f5ce 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1182,6 +1182,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
> >         bool process_backlog = false;
> >         bool zc = false;
> >         long timeo;
> > +       gfp_t gfp;
> >
> >         flags = msg->msg_flags;
> >
> > @@ -1255,6 +1256,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
> >         /* Ok commence sending. */
> >         copied = 0;
> >
> > +       gfp = flags & MSG_DONTWAIT ? sk->sk_allocation & ~__GFP_DIRECT_RECLAIM :
> > +             sk->sk_allocation;
> > +
> >  restart:
> >         mss_now = tcp_send_mss(sk, &size_goal, flags);
> >
> > @@ -1283,8 +1287,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
> >                         }
> >                         first_skb = tcp_rtx_and_write_queues_empty(sk);
> >                         linear = select_size(first_skb, zc);
> > -                       skb = sk_stream_alloc_skb(sk, linear, sk->sk_allocation,
> > -                                                 first_skb);
> > +                       skb = sk_stream_alloc_skb(sk, linear, gfp, first_skb);
> >                         if (!skb)
> >                                 goto wait_for_memory;
>
>
> How have you tested this patch exactly ?
>
There was a network latency (hunreds msecs or even one sec ) recently
on our production enviroment.
And finally I diagnosed that this latency was caused by direct reclaim
in tcp_sendmsg.
That issue could be resovled by keeping a reserved memory.
But I think deeply that why not forbid direct reclaim if we set MSG_DONWAIT.
So I did this change and tested it. The application got a errno
returned instead of being blocked in send path.
That's why I sumbit this patch.

> Most of TCP payloads are added in page fragments, and you have not
> changed the page allocation fragments.
>
> Also, I do not see how an application will get future notifications
> that it can retry the failed system call ?
> How are you really going to deal with this in high performance applications ?
>

I think that immdiately return with errno is better than being blocked.
Maybe this solution is not good enough.
At least it could tell the application that something is wrong and it
can't send now.

> I would rather prefer a socket setsockopt() to eventually be able to
> flip __GFP_DIRECT_RECLAIM in sk->sk_allocation,
> to not add all these tests in fast path, but honestly I do not see how
> applications can really make use of this.

Maybe an event is needed to tell the application it can send now.
I don't have better idea neither.

Thanks
Yafang
