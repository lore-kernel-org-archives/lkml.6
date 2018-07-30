Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB3AC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A977020873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoIXXZgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A977020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeG3DjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 23:39:23 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52732 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeG3DjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 23:39:23 -0400
Received: by mail-it0-f67.google.com with SMTP id d9-v6so14946555itf.2;
        Sun, 29 Jul 2018 19:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RdIZnJNxUFIp4cJXGJTSt338HopkOCj8ZUXoPAf5I1k=;
        b=RoIXXZgjPnyYlvsyGatlQEd0gXDdmPlEj1Vnflthh2PaK4TDtN224mKiZFTXU1dHdx
         8CQXJ0uHpHGusYvjeFX3S7/mRacAcLRUMW1A6P5uYz1AVlxjdn4KK5Ud8LxrA1Ae+D1k
         ArW0IoL4VylEmSL7IJ/UDe65p2RAdrkHg0mgxEyCerFwYBW7FOX4h60MpVapO40EQnv3
         MM8sd7D5LoPD4S3C4PxaBL/wHv5ym9SXno5wllFJW7qZXPHMwvYVmdMB5JHB3pYR7q4A
         fFS2IcQY8aHNHcX647Oq52nE8SjGS3evV48VYhYuu5o+wxZa6qpju7uXsOReCuds891O
         Ou+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RdIZnJNxUFIp4cJXGJTSt338HopkOCj8ZUXoPAf5I1k=;
        b=sAfo4fKkLQK4JtVx2odrLvT6sp/OuOyToI280lN5bK2dV+0O0URZk8WfDh/Ae+hr3h
         IN8GF5SterZVXVhTdWMpoYanlRbOW6rm8x4auIHV+drCG4jox3H1IzXi4it5o2dik/i3
         fUPjzsLEx47DTkxL1lKwinWO32hZ3j5EgMHQu4e8nEZAuqrMuIm/e0VJlajTAgHz6IMi
         IumDzW99ys+PgZLcPQDNh/HbvAabNXu8RLa7RMCC7GkqnX1wl75lzsRT84IjlIDKGaTk
         2hxCqsV6cCTemERJ+4p9PICCPgNNM4G9iE7/zfUC/Hqv6qq/3Grzx79AEBkzbZJO0miU
         vSoA==
X-Gm-Message-State: AOUpUlHPpMkKVm3vVfdTAzcliRX8nlmIwbgr7NN7/QMUvVtqYALzLiXI
        WqSMQKlCbDGqj3jb2qN31ecxe/lfEA5ZufOu0fI=
X-Google-Smtp-Source: AAOMgpeyIELpCDvAdo16rSXF/nH8BL27pzdHHf7bYsA5kXc2JqJidhwngiz+scvHqZ7cVm7swketLI/7n91p5MNhZRY=
X-Received: by 2002:a24:9cc7:: with SMTP id b190-v6mr13293466ite.118.1532916403097;
 Sun, 29 Jul 2018 19:06:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 19:06:02
 -0700 (PDT)
In-Reply-To: <CANn89i+12HvAsvk9crDcqGh=v-DvLjuGQCOzVTPVDTUhHgeDiw@mail.gmail.com>
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
 <CANn89iJ=Ad7sVWr3zBmXNSyePJJZaxgnMymN8S7x6fCSvG2jTQ@mail.gmail.com>
 <CALOAHbC4Rs7w1RwZRBsw_fjGSDvuHV37=nguzJNZzkreR5f4Dw@mail.gmail.com>
 <CANn89iKXPu=RKkLop4NJWZLixE__qYV2S=PngSj6ienuvWWL8g@mail.gmail.com>
 <CALOAHbAjtNf1LOhWEJMKNEEHSxjfEKiVV22KPUK88CTzt-eW0w@mail.gmail.com> <CANn89i+12HvAsvk9crDcqGh=v-DvLjuGQCOzVTPVDTUhHgeDiw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 30 Jul 2018 10:06:02 +0800
Message-ID: <CALOAHbBFuASgsQK+iiAE+ebPOg5zjtzauYaN_Xtmfc9_wjTFgw@mail.gmail.com>
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

On Sun, Jul 29, 2018 at 12:28 AM, Eric Dumazet <edumazet@google.com> wrote:
> On Sat, Jul 28, 2018 at 12:43 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> On Sat, Jul 28, 2018 at 11:38 AM, Eric Dumazet <edumazet@google.com> wrote:
>> > On Fri, Jul 27, 2018 at 8:35 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>> >
>> >> So what about LINUX_MIB_TCPOFOMERGE ?
>> >> Regarding LINUX_MIB_TCPOFOMERGE,  a skb is already covered by another
>> >> skb, is that dropping the packet or simply lowering the memory
>> >> overhead ?
>> >
>> > What do you think ?
>> >
>> > If you receive two times the same payload, don't you have to drop one
>> > of the duplicate ?
>> >
>> > There is a a big difference between the two cases.
>>
>> If the drop caused some data lost (which may then cause retransmition
>> or something), then this is a really DROP.
>> While if the drop won't cause any data lost, meaning it is a
>> non-harmful behavior, I think it should not be defined as DROP.
>> This is my suggestion anyway.
>
> Sigh.
>
> We count drops, not because they are ' bad or something went wrong'.
>
> If TCP stack receives twice the same sequence (same payload), we
> _drop_ one of the duplicate, so we account for this event.
>
> When ' collapsing'  we reorganize our own storage, not because we have
> to drop a payload,
> but for some memory pressure reason.

Thanks for you clarification.
So what about LINUX_MIB_TCPOFODROP ?

        if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
                NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
                tcp_drop(sk, skb);
                return;
        }


It is also because of our own memory pressure, but we call tcp_drop() here.

I am not mean to disagree with you. I am just confused and  want to
make it clear.

> We have specific SNMP counters to account for these, we do not want to
> pretend a packet was ' dropped' since it was not.
>
> If we have to _drop_ some packets, it is called Pruning, and we do
> properly account for these drops.

Agreed.


Thanks
Yafang
