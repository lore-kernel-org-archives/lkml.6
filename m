Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27620FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21BE20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUdec97G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21BE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeG3HOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:14:08 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52760 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeG3HOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:14:08 -0400
Received: by mail-it0-f68.google.com with SMTP id d9-v6so15398801itf.2;
        Sun, 29 Jul 2018 22:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=neKSnuwzeNEdwsrSZJGDCj6ofbCwbLiLY7jas/NJWKY=;
        b=kUdec97G0ARS+LZ5PQpwaSY/gIyEws0fQ1gCw8zt8DRGlAk2KzZKod9ZwSCRh/royI
         hidluESWJH5pZTp9mXa+sZemsaj8c8u8Ly1gwjO/iy+upxYtVgihnsxmH0ejDzo4dH6Y
         9mS5C4UnDeknTKsbO7Kl9+qUaKVpOqgJZTDWwOZh9j1YScghTHIE6WRSBCwb+lSfdSFX
         vLXUg6NAthBumK8/+GYTY3Ka4GnVyEhJ7KfAHZtUcq01AOlJayQmwMYmCIzoP/zeM8Ol
         UK50DpbTYMY76VSMalu7WaLFJpoNXTtNteY/KCBI5pINPWWbZEDbnrZpSHp5arm6I0Tw
         YPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=neKSnuwzeNEdwsrSZJGDCj6ofbCwbLiLY7jas/NJWKY=;
        b=uARwwXdrYNugBpJgb/9LFBXPXOLeifeg53quyuhcR6ON5i5qFTW0tvUTSI4r37IMRn
         /HBRi2tkkEfUGL9BtZ2SL/f5C15uz3Ybf0wQaJCmZhFOnjW/Qz3WAgCujUVz1Qh622zC
         x5H3D0eCo0NgP8DyJ+qiTmgp0ZMQ2FTOvdGm3iU6bx7CH8b8H7bBPgq0CE8+gwiCWahk
         2GcdrCIBV0pu+byUuI1QydeBsL5oUI4+BZiPMi4TDXywCKpjIQ1V2DGb2UJiv9QRvjcO
         JTwTJKp7R1JY9PW5KF98tjhJi3NZQRv0OHksZfA8D68F8hcf9E12xOKxFddR8LJOn3wc
         00PA==
X-Gm-Message-State: AOUpUlGYaFXJCX/DPNKlG5WxsMJCF21XvbIlV9+WGYDcuMtuO9G/++DV
        uQIkhmn2dD0K3JiTTRmNQ4jQU693HEsrp7fFf5Y=
X-Google-Smtp-Source: AAOMgpeKHtzLpd36wOIQI6Jb0npL2+MsF6nOXCdw/zVmHK6MiKkNrCKmdyRACE1+8IeeekscH+0ZliYWgtBCsNuVlUQ=
X-Received: by 2002:a24:af5d:: with SMTP id l29-v6mr13113047iti.142.1532929251633;
 Sun, 29 Jul 2018 22:40:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 22:40:11
 -0700 (PDT)
In-Reply-To: <CANn89i+0peAq_BS3Ge-h2_MENHQAHtf8D_M0gzgchK6CxU8D+Q@mail.gmail.com>
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
 <CANn89iJ=Ad7sVWr3zBmXNSyePJJZaxgnMymN8S7x6fCSvG2jTQ@mail.gmail.com>
 <CALOAHbC4Rs7w1RwZRBsw_fjGSDvuHV37=nguzJNZzkreR5f4Dw@mail.gmail.com>
 <CANn89iKXPu=RKkLop4NJWZLixE__qYV2S=PngSj6ienuvWWL8g@mail.gmail.com>
 <CALOAHbAjtNf1LOhWEJMKNEEHSxjfEKiVV22KPUK88CTzt-eW0w@mail.gmail.com>
 <CANn89i+12HvAsvk9crDcqGh=v-DvLjuGQCOzVTPVDTUhHgeDiw@mail.gmail.com>
 <CALOAHbBFuASgsQK+iiAE+ebPOg5zjtzauYaN_Xtmfc9_wjTFgw@mail.gmail.com> <CANn89i+0peAq_BS3Ge-h2_MENHQAHtf8D_M0gzgchK6CxU8D+Q@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 30 Jul 2018 13:40:11 +0800
Message-ID: <CALOAHbBy6wEwDcVaWx9PG35jknwkhM-Y-TVyis3TpVQYr5K-Jw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: call tcp_drop() in tcp collapse
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:27 AM, Eric Dumazet <edumazet@google.com> wrote:
> On Sun, Jul 29, 2018 at 7:06 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> On Sun, Jul 29, 2018 at 12:28 AM, Eric Dumazet <edumazet@google.com> wrote:
>> > On Sat, Jul 28, 2018 at 12:43 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>> >>
>> >> On Sat, Jul 28, 2018 at 11:38 AM, Eric Dumazet <edumazet@google.com> wrote:
>> >> > On Fri, Jul 27, 2018 at 8:35 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>> >> >
>> >> >> So what about LINUX_MIB_TCPOFOMERGE ?
>> >> >> Regarding LINUX_MIB_TCPOFOMERGE,  a skb is already covered by another
>> >> >> skb, is that dropping the packet or simply lowering the memory
>> >> >> overhead ?
>> >> >
>> >> > What do you think ?
>> >> >
>> >> > If you receive two times the same payload, don't you have to drop one
>> >> > of the duplicate ?
>> >> >
>> >> > There is a a big difference between the two cases.
>> >>
>> >> If the drop caused some data lost (which may then cause retransmition
>> >> or something), then this is a really DROP.
>> >> While if the drop won't cause any data lost, meaning it is a
>> >> non-harmful behavior, I think it should not be defined as DROP.
>> >> This is my suggestion anyway.
>> >
>> > Sigh.
>> >
>> > We count drops, not because they are ' bad or something went wrong'.
>> >
>> > If TCP stack receives twice the same sequence (same payload), we
>> > _drop_ one of the duplicate, so we account for this event.
>> >
>> > When ' collapsing'  we reorganize our own storage, not because we have
>> > to drop a payload,
>> > but for some memory pressure reason.
>>
>> Thanks for you clarification.
>> So what about LINUX_MIB_TCPOFODROP ?
>>
>>         if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
>>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
>>                 tcp_drop(sk, skb);
>>                 return;
>>         }
>>
>>
>> It is also because of our own memory pressure, but we call tcp_drop() here.
>
> Yes, we _drop_ a packet.
>
> That is pretty clear that the payload is dropped, and that the sender
> will have to _retransmit_.
>
>>
>> I am not mean to disagree with you. I am just confused and  want to
>> make it clear.
>
>
> Collapsing is :
>
> For (a bunch of packets)
>    Try (to compress them in order to reduce memory overhead)
>
> No drop of payload happens here. Sender wont have to retransmit.

OK.
Thanks for your patient.

Should we put NET_INC_STATS(sock_net(sk),  mib_idx) into the funtion
tcp_drop() ?
Then we could easily relate the sk_drops with the SNMP counters.

Something like that,

    static void tcp_drop(struct sock *sk, struct sk_buff *skb, int mib_idx)
    {
        int segs = max_t(u16, 1, skb_shinfo(skb)->gso_segs);

        atomic_add(segs, &sk->sk_drops);
        NET_ADD_STATS(sock_net(sk), mib_idx, segs);
        __kfree_skb(skb);
    }


Thanks
Yafang
