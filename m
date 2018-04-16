Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeDPQEQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:04:16 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35627 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDPQEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:04:13 -0400
X-Google-Smtp-Source: AIpwx4/sACulI70ZvU10FQRACuj3nMGHzRqk1DeD9ejB0xZA1pe14J+fOLl2Cp2awR+wD29VMm/Lw0F7Fu9597KgVqM=
MIME-Version: 1.0
In-Reply-To: <d2ab1647-c832-c982-5952-ab7a415f7c76@gmail.com>
References: <1523892818-12820-1-git-send-email-laoar.shao@gmail.com> <d2ab1647-c832-c982-5952-ab7a415f7c76@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 17 Apr 2018 00:03:32 +0800
Message-ID: <CALOAHbB98bXsMAggQi0p0Mgu=Rp4Kot+JzPQ+sRvubFG=Yyt=A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: introduce a new tracepoint for tcp_rcv_space_adjust
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, yoshfuji@linux-ipv6.org,
        Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 11:43 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 04/16/2018 08:33 AM, Yafang Shao wrote:
>> tcp_rcv_space_adjust is called every time data is copied to user space,
>> introducing a tcp tracepoint for which could show us when the packet is
>> copied to user.
>> This could help us figure out whether there's latency in user process.
>>
>> When a tcp packet arrives, tcp_rcv_established() will be called and with
>> the existed tracepoint tcp_probe we could get the time when this packet
>> arrives.
>> Then this packet will be copied to user, and tcp_rcv_space_adjust will
>> be called and with this new introduced tracepoint we could get the time
>> when this packet is copied to user.
>>
>>       arrives time : user process time    => latency caused by user
>>       tcp_probe      tcp_rcv_space_adjust
>>
>> Hence in the prink message, sk is printed as a key to connect these two
>> tracepoints.
>>
>
> socket pointer is not a key.
>
> TCP sockets can be reused pretty fast after free.
>
> I suggest you go for cookie instead, this is an unique 64bit identifier.
> ( sock_gen_cookie() for details )
>
>

Thanks for your explanation.
Will have a try.

Thanks
Yafang
