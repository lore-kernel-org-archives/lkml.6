Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB5AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9560220700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland-com.20150623.gappssmtp.com header.i=@herbertland-com.20150623.gappssmtp.com header.b="1DBlzzsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfBVTZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:25:05 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45226 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVTZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:25:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id v139so1792897qkb.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 11:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lrDkVvg5++r1M/1kNI0sOON0iVzYAFzM1UCHoHAK+ss=;
        b=1DBlzzsq5DvlW8OgEoDiIglolXF8Ii6hovi+ATd2Lj2LElw+T4BPJZAJBVTpKAO0DR
         4XYGvG/tNzsIlMwipLtxCUjfaefKMgAjYyfbyGC/tg0mHPbbndZuTzQWtbnpHBd+VVhX
         ffIuzSb8sOZ+I6W+JvwXpWGE+cwZYEyzrDjl+YRACmvS8g6A8EPY2zLdMmA+FRCPg3Ms
         uhlFAWBeRdHpkf8SsKGEPOmU9nLhKj7itKLysELjxAI0ZlHZOW8l/Uh0aA9xANzJyOxE
         vVLLi7PN9KGOFn8eiSbPes+vQQPSzbyiOFBGW+kdsOPhWkv3rNvSdwI5i5ohnJijdMPD
         UBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrDkVvg5++r1M/1kNI0sOON0iVzYAFzM1UCHoHAK+ss=;
        b=nFBzmNGIwp6gYAV3kjPwvsPfDsXTmTFra+wwZjx3JqEuJHW65h/RPiOm2THuWcyzW+
         R4ke9eAznlIR1if18MJJCKzWCnewsPQsctdFDxd5elTtZRqvDi4jz+X9/jgUk+9y8Mf1
         gYRC5N7h8TT3QnT6yIOq8zPgUCLsIwcoGSNoDe3CmFGUs71AxbWCuOkhrl12O4iz0tLL
         5Z6nlWiNAc5rMdzabeSkSoigGnB6ICtTOT23bIKm2KxasrGzNOweyuvnfhiuUln+e0c8
         6gSMHB3e8/c+t46xgM6KsPTsMPBf/H9GCq3qMZfYbWV3rKYKq0VqOFjRd50uB6ezRA5n
         Q5LA==
X-Gm-Message-State: AHQUAubV8257I4xM7DvKlNSOzenmU9qNPpA+s6sCgS2ji0mRkkNneQY9
        JrfNB7eUOEDYX9CAxzaZRs+UFUc21+IXtS03g2qe7w==
X-Google-Smtp-Source: AHgI3IaQfRsb2trrcNJyCXdVLbLFc7vhs8nSrMpc0LdGIz6ky+HWP71xZ4lwXV5NOLsiLQqvgLJ8yOHEaGLodIlPmIM=
X-Received: by 2002:a37:a147:: with SMTP id k68mr4189377qke.190.1550863503030;
 Fri, 22 Feb 2019 11:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20181031025657.GA17861@nautica> <20190215010029.GA10899@nautica>
 <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
 <20190215015705.GA17974@nautica> <CALx6S37MZadJ=PaAd+SSv9hxSX9kFTmTUtijPGA39JCx3PYq1Q@mail.gmail.com>
 <20190215033102.GA3099@nautica> <CAPDqMeoJ7CCo1eGNBp_-crkxfVt_4f=XQqhEo7kmyCN-hf_EWQ@mail.gmail.com>
 <20190215045214.GA13123@nautica> <20190220041151.GA13520@nautica>
 <CALx6S35jPN+E7-A4JK9ypAETophtKrJzjd9HPmXowU7RMS=bcA@mail.gmail.com> <20190221082209.GA32719@nautica>
In-Reply-To: <20190221082209.GA32719@nautica>
From:   Tom Herbert <tom@herbertland.com>
Date:   Fri, 22 Feb 2019 11:24:52 -0800
Message-ID: <CALx6S36o3JVHh3UtOsfXNrosXK0NCZo703gfzfJPgJvZK9brOA@mail.gmail.com>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:22 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Tom Herbert wrote on Wed, Feb 20, 2019:
> > > When the client closes the socket, some messages are obviously still "in
> > > flight", and the server will recv a POLLERR notification on the csock at
> > > some point with many messages left.
> > > The documentation says to unattach the csock when you get POLLER. If I
> > > do that, the kcm socket will no longer give me any message, so all the
> > > messages still in flight at the time are lost.
> >
> > So basically it sounds like you're interested in supporting TCP
> > connections that are half closed. I believe that the error in half
> > closed is EPIPE, so if the TCP socket returns that it can be ignored
> > and the socket can continue being attached and used to send data.
>
> Did you mean 'can continue being attached and used to receive data'?
>
No, I meant shutdown on receive side when FIN is receved. TX is still
allowed to drain an queued bytes. To support shutdown on the TX side
would require additional logic since we need to effectively detach the
transmit path but retain the receive path. I'm not sure this is a
compelling use case to support.

> I can confirm getsockopt with SO_ERROR gets me EPIPE, but I don't see
> how to efficiently ignore EPIPE until POLLIN gets unset -- polling on
> both the csock and kcm socket will do many needless wakeups on only the
> csock from what I can see, so I'd need some holdoff timer or something.
> I guess it's possible though.

We might need to clear the error somehow. May a read of zero bytes?

>
> > Another possibility is to add some linger semantics to an attached
> > socket. For instance, a large message might be sent so that part of
> > the messge is queued in TCP and part is queued in the KCM socket.
> > Unattach would probably break that message. We probably want to linger
> > option similar to SO_LINGER (or maybe just use the option on the TCP
> > socket) that means don't complete the detach until any message being
> > transmitted on the lower socket has been queued.
>
> That would certainly work, even if non-obvious from a user standpoint.
>
>
> > > > I'd like to see some retry on ENOMEM before this is merged though, so
> > > > while I'm there I'll resend this with a second patch doing that
> > > > retry,.. I think just not setting strp->interrupted and not reporting
> > > > the error up might be enough? Will have to try either way.
> > >
> > > I also tried playing with that without much success.
> > > I had assumed just not calling strp_parser_err() (which calls the
> > > abort_parser cb) would be enough, eventually calling strp_start_timer()
> > > like the !len case, but no can do.
> >
> > I think you need to ignore the ENOMEM and have a timer or other
> > callback to retry the operation in the future.
>
> Yes, that's what I had intended to try; basically just break out and
> schedule timer as said above.

You might want to look at some other systems, I don't recall if
there's a hook that can be used for when memory pressure is relieved.

>
> After a bit more debugging, this part works (__strp_recv() is called
> again); but the next packet that is treated properly is rejected because
> by the time __strp_recv() was called again a new skb was read and the
> length isn't large enough to go all the way into the new packet, so this
> test fails:
>                         } else if (len <= (ssize_t)head->len -
>                                           skb->len - stm->strp.offset) {
>                                 /* Length must be into new skb (and also
>                                  * greater than zero)
>                                  */
>                                 STRP_STATS_INCR(strp->stats.bad_hdr_len);
>                                 strp_parser_err(strp, -EPROTO, desc);
>
> So I need to figure a way to say "call this function again without
> reading more data" somehow, or make this check more lax e.g. accept any
> len > 0 after a retry maybe...
> Removing that branch altogether seems to work at least but I'm not sure
> we'd want to?

I like the check since it's conservative and covers the normal case.
Maybe just need some more logic?
> (grmbl at this slow VM and strparser not being possible to enable as a
> module, it takes ages to test)
>
>
> > > With that said, returning 0 from the parse function also raises POLLERR
> > > on the csock and hangs netparser, so things aren't that simple...
> >
> > Can you point to where this is happening. If the parse_msg callback
> > returns 0 that is suppose to indicate that more bytes are needed.
>
> I just blindly returned 0 "from time to time" in the kcm parser
> function, but looking at above it was failing on the same check.
> This somewhat makes sense for this one to fail here if a new packet was
> read, no sane parser function should give a length smaller than what
> they require to determine the length.
>
>
> Thanks,
> --
> Dominique
