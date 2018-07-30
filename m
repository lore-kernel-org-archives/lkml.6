Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F12C46462
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AF720892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSilinzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AF720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeG3EAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 00:00:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51438 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeG3EAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 00:00:33 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so15220520itf.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 19:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxrODUfCHY8gwZ3lQcckjgac4zgpf3MBpEqTQqjMots=;
        b=mSilinzXNY93k0SJSpI6ztZSCB2X+lQyGbZbQ3qWfK4na9Qigum8qqEL2dD0R2jrJM
         E+y1SRvym7goNL30HcdbTXrEcyeEcj8WdHfUy+vpdohnnqAPCryIYMIKbTHhLRag1P+6
         mUyocOi0qhYDpwx/6kA117Z0tIa6mrJbUbjwWj8oX+RHFC8fzmguuju1+SI1cFcfTdhf
         RyJ+oldvCqg7XUHvjH0oVOdvWRk9zmpLwlFiJvWm+Aeby/iIrq85CAn60LqdoOUxyUHJ
         XJsoJ0ElryrTnagMVU7NH7RykIGOyJj94aGal3YBNfvT3VV2Ig2HBTXK5EaX8Dp5nEvQ
         jIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxrODUfCHY8gwZ3lQcckjgac4zgpf3MBpEqTQqjMots=;
        b=pQR2dcdyyvysOMi/LW5wokG9LIxQJu3ZS1QH1qzeu2BVvcfIra9V4kg/Z9RyjtnCSW
         a0FlaKBknjeVQua9lxZniuedxL1wGTwFsI3S+I1kPPQTqpYC9CT1KNqeoo7bQOfQVyub
         ucmoLSl4eWVKYcD6nLcybYhVyuzfxC8qotsyH7ypCFOlVFQ58qcmdX/KOsSk4pHGtvWc
         L3wgYEIRlVTQE/XqPcuyr1hsFKoA3UsbOSaNCDc3+08qztqTTSMAXIT1bJPP8YRN0F9z
         UFl49bIcaCuP7yeqJtolcWjDi1rFUcQG9+zz1TqXeAkmsLWAY7yJ0RMZUNQAxFn6yJ55
         xylA==
X-Gm-Message-State: AOUpUlFEEnupcXjQBMxNs/m+tp6z5hSYZV5fuMtzxAB0rBlaabxYdS9+
        O+ItDmpKwyKq0cwPzykJ4tm/hdipp0JbMPVkidTaeQ==
X-Google-Smtp-Source: AAOMgpcQfCpxLxYtt2IugbDjaar+pDLdo0uypDDdnRPLAzPaLTAbmAsplpl5azMd3lyHkhzfAPTgpbFhmkPkHX8sdL8=
X-Received: by 2002:a24:6f0e:: with SMTP id x14-v6mr12888363itb.139.1532917670071;
 Sun, 29 Jul 2018 19:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
 <CANn89iJ=Ad7sVWr3zBmXNSyePJJZaxgnMymN8S7x6fCSvG2jTQ@mail.gmail.com>
 <CALOAHbC4Rs7w1RwZRBsw_fjGSDvuHV37=nguzJNZzkreR5f4Dw@mail.gmail.com>
 <CANn89iKXPu=RKkLop4NJWZLixE__qYV2S=PngSj6ienuvWWL8g@mail.gmail.com>
 <CALOAHbAjtNf1LOhWEJMKNEEHSxjfEKiVV22KPUK88CTzt-eW0w@mail.gmail.com>
 <CANn89i+12HvAsvk9crDcqGh=v-DvLjuGQCOzVTPVDTUhHgeDiw@mail.gmail.com> <CALOAHbBFuASgsQK+iiAE+ebPOg5zjtzauYaN_Xtmfc9_wjTFgw@mail.gmail.com>
In-Reply-To: <CALOAHbBFuASgsQK+iiAE+ebPOg5zjtzauYaN_Xtmfc9_wjTFgw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 29 Jul 2018 19:27:38 -0700
Message-ID: <CANn89i+0peAq_BS3Ge-h2_MENHQAHtf8D_M0gzgchK6CxU8D+Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: call tcp_drop() in tcp collapse
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 7:06 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Sun, Jul 29, 2018 at 12:28 AM, Eric Dumazet <edumazet@google.com> wrote:
> > On Sat, Jul 28, 2018 at 12:43 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >>
> >> On Sat, Jul 28, 2018 at 11:38 AM, Eric Dumazet <edumazet@google.com> wrote:
> >> > On Fri, Jul 27, 2018 at 8:35 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >> >
> >> >> So what about LINUX_MIB_TCPOFOMERGE ?
> >> >> Regarding LINUX_MIB_TCPOFOMERGE,  a skb is already covered by another
> >> >> skb, is that dropping the packet or simply lowering the memory
> >> >> overhead ?
> >> >
> >> > What do you think ?
> >> >
> >> > If you receive two times the same payload, don't you have to drop one
> >> > of the duplicate ?
> >> >
> >> > There is a a big difference between the two cases.
> >>
> >> If the drop caused some data lost (which may then cause retransmition
> >> or something), then this is a really DROP.
> >> While if the drop won't cause any data lost, meaning it is a
> >> non-harmful behavior, I think it should not be defined as DROP.
> >> This is my suggestion anyway.
> >
> > Sigh.
> >
> > We count drops, not because they are ' bad or something went wrong'.
> >
> > If TCP stack receives twice the same sequence (same payload), we
> > _drop_ one of the duplicate, so we account for this event.
> >
> > When ' collapsing'  we reorganize our own storage, not because we have
> > to drop a payload,
> > but for some memory pressure reason.
>
> Thanks for you clarification.
> So what about LINUX_MIB_TCPOFODROP ?
>
>         if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
>                 tcp_drop(sk, skb);
>                 return;
>         }
>
>
> It is also because of our own memory pressure, but we call tcp_drop() here.

Yes, we _drop_ a packet.

That is pretty clear that the payload is dropped, and that the sender
will have to _retransmit_.

>
> I am not mean to disagree with you. I am just confused and  want to
> make it clear.


Collapsing is :

For (a bunch of packets)
   Try (to compress them in order to reduce memory overhead)

No drop of payload happens here. Sender wont have to retransmit.
