Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5650D2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=quantonium-net.20150623.gappssmtp.com header.i=@quantonium-net.20150623.gappssmtp.com header.b="Zb8HDbeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfBVVCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:02:01 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33234 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:02:00 -0500
Received: by mail-wr1-f46.google.com with SMTP id i12so3821501wrw.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quantonium-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lb/fVcrySkv3EtiT8/Enj2b41YW5wcL7v3RLqGTBTo4=;
        b=Zb8HDbeASuK6qrlfBdrGmuXii5UZgSGw5hE3qCf8TTSj5R+LaEJ0p2hBvT/AqUEgZp
         Mhby0sWMKgeugrLbQjW6jESOJnR1/JlMJzACOQfnnrp/uxiJ/7Jl8gpXZIeCZstP19zL
         PudwUU4XJQ/PpCz3465JF8rqQgX7n+rkgNlcXKUpR88JebTR9eZA/bbWsLgyqZVnDzLO
         OuORL7xc+N2wETtYBeWVFUjtskyY+T7TTT13NAZ4ZO2imJWL0bjX8bc8YL15z9LbZrzn
         wfq6vhG+ZSYA7JbOKAgFfgMDuXvZxk00lcUotZuNkjzyFJlVupYl4L4CCvWXcYR34y55
         AemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lb/fVcrySkv3EtiT8/Enj2b41YW5wcL7v3RLqGTBTo4=;
        b=Jxb8+DMMz1UgUFKAfvC4V4HwCwlNBTffqNOIQaW6ajXvz2MS7kqMXMOIV7M95afxRn
         vDJ8DE9FlUz1jezzCaY3jZtVX2XKYQqjOk32P13B+aJdwIX8tW3u948KeHOGFhCZblK+
         ea07yd7tbaWwQUugl4SqC5TQ0WKEp5D5sYh4yrPgTk8bsJZqM73PD7afU0aEW1vOb1xI
         Q2dE1tHUTjruDPdu+jqjtJRNtV6ME4MZsrgiuUzcd0drxng0D97drMMjRYn4xdCaSWPc
         GUL80pHXYFTgOBos5OzKze7svfYNHJ7xA7xKEFR5tMdAPXjCCHviOTRTgNEuOOKT4Wks
         QCug==
X-Gm-Message-State: AHQUAua7SGsnbk7E7teSP5z09Gh292WmgWIvnw87Tf03cQqvy5u+uO9k
        LBMgjVU7RPjhAZz0vRG/B0O+yWrZMhUqLQsTq4FiHw==
X-Google-Smtp-Source: AHgI3Ibt66j56G1lP0gJujdrumdXTL4MWaoGzDW5IYOiI1rYlHNBpELAcBvMtEsDnI8QHaJKgi1I2jHkMrV1OADL358=
X-Received: by 2002:a5d:4702:: with SMTP id y2mr4675791wrq.149.1550869318331;
 Fri, 22 Feb 2019 13:01:58 -0800 (PST)
MIME-Version: 1.0
References: <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
 <20190215015705.GA17974@nautica> <CALx6S37MZadJ=PaAd+SSv9hxSX9kFTmTUtijPGA39JCx3PYq1Q@mail.gmail.com>
 <20190215033102.GA3099@nautica> <CAPDqMeoJ7CCo1eGNBp_-crkxfVt_4f=XQqhEo7kmyCN-hf_EWQ@mail.gmail.com>
 <20190215045214.GA13123@nautica> <20190220041151.GA13520@nautica>
 <CALx6S35jPN+E7-A4JK9ypAETophtKrJzjd9HPmXowU7RMS=bcA@mail.gmail.com>
 <20190221082209.GA32719@nautica> <CALx6S36o3JVHh3UtOsfXNrosXK0NCZo703gfzfJPgJvZK9brOA@mail.gmail.com>
 <20190222202754.GA20806@nautica>
In-Reply-To: <20190222202754.GA20806@nautica>
From:   Tom Herbert <tom@quantonium.net>
Date:   Fri, 22 Feb 2019 13:01:47 -0800
Message-ID: <CAPDqMeoH9aLqk=j=fU=xHmpa=U2N-Tzu8pspiH4wqef=YzPOdw@mail.gmail.com>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Tom Herbert <tom@herbertland.com>,
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

On Fri, Feb 22, 2019 at 12:28 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Tom Herbert wrote on Fri, Feb 22, 2019:
> > > > So basically it sounds like you're interested in supporting TCP
> > > > connections that are half closed. I believe that the error in half
> > > > closed is EPIPE, so if the TCP socket returns that it can be ignored
> > > > and the socket can continue being attached and used to send data.
> > >
> > > Did you mean 'can continue being attached and used to receive data'?
> >
> > No, I meant shutdown on receive side when FIN is receved. TX is still
> > allowed to drain an queued bytes. To support shutdown on the TX side
> > would require additional logic since we need to effectively detach the
> > transmit path but retain the receive path. I'm not sure this is a
> > compelling use case to support.
>
Dominque,

> Hm, it must be a matter of how we see thing but from what I understand
> it's exactly the other way around. The remote closed the connection, so
> trying to send anything would just yield a RST, so TX doesn't make
> sense.
> On the other hand, anything that had been sent by the remote before the
> FIN and is on the local side's memory should still be receivable.

That's right, any data sent before the FIN can be received. After the
FIN, there is not more data to received. But, the FIN doesn't say
anything about the reverse path. For instance, if the peer did
shutdown(SHUT_WR), then it sent the FIN so it no longer transmits on
the connection, but still can receive data.

>
> When you think about it as a TCP stream it's really weird: data coming,
> data coming, data coming, FIN received.
> But in the networking stack that received FIN short-circuits all the
> data that was left around and immediately raises an EPIPE error.
>
Right, it doesn't help that most people automatically assume a
received FIN means the connection is closed! (although in practice
that assumption works pretty well for most applications).

> I don't see what makes this FIN packet so great that it should be
> processed before the data; we should only see that EPIPE when we're
> done reading the data before it or trying to send something.

It's not supposed to be. If your seeing a problem, it might because
state_change is processed before the received data is drained. If
plain recvmsg were being used, zero bytes is on returned after all
outstanding received data on the socket has been read. We might need
some additional logic in KCM to handle this.

>
> I'll check tomorrow/next week but I'm pretty sure the packets before
> that have been ack'd at a tcp level as well, so losing them in the
> application level is really unexpected.
>
> > > I can confirm getsockopt with SO_ERROR gets me EPIPE, but I don't see
> > > how to efficiently ignore EPIPE until POLLIN gets unset -- polling on
> > > both the csock and kcm socket will do many needless wakeups on only the
> > > csock from what I can see, so I'd need some holdoff timer or something.
> > > I guess it's possible though.
> >
> > We might need to clear the error somehow. May a read of zero bytes?
>
> Can try.
>
> > > After a bit more debugging, this part works (__strp_recv() is called
> > > again); but the next packet that is treated properly is rejected because
> > > by the time __strp_recv() was called again a new skb was read and the
> > > length isn't large enough to go all the way into the new packet, so this
> > > test fails:
> > >                         } else if (len <= (ssize_t)head->len -
> > >                                           skb->len - stm->strp.offset) {
> > >                                 /* Length must be into new skb (and also
> > >                                  * greater than zero)
> > >                                  */
> > >                                 STRP_STATS_INCR(strp->stats.bad_hdr_len);
> > >                                 strp_parser_err(strp, -EPROTO, desc);
> > >
> > > So I need to figure a way to say "call this function again without
> > > reading more data" somehow, or make this check more lax e.g. accept any
> > > len > 0 after a retry maybe...
> > > Removing that branch altogether seems to work at least but I'm not sure
> > > we'd want to?
> >
> > I like the check since it's conservative and covers the normal case.
> > Maybe just need some more logic?
>
> I can add a "retrying" state and not fail here if we ewre retrying for
> whatever reason perhaps...
> But I'm starting to wonder how this would work if my client didn't keep
> on sending data, I'll try to fail on the last client's packet and see
> how __strp_recv is called again through the timer, with the same skb
> perhaps?

Right, a timer or some sort of aynchronous callbask is needed. Like I
said, I don't think dealing with memory failure like this is unique to
KCM.

Thanks again for looking into this, I think this is good progress!

Tom

>
> --
> Dominique
