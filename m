Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeE2Exx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:53:53 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44325 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeE2Exs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:53:48 -0400
X-Google-Smtp-Source: AB8JxZov3LICY2cOMoHI8zGG+D2/P5IKNDdwTLnXByQp4MlS8fYSZIx6dJ3yO7LVPO2hz1poaZtAHw==
Subject: Re: [PATCH v3 net-next 2/2] tcp: minor optimization around tcp_hdr()
 usage in tcp receive path
To: Yafang Shao <laoar.shao@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: Song Liu <songliubraving@fb.com>, David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <1527521753-17963-1-git-send-email-laoar.shao@gmail.com>
 <1527521753-17963-2-git-send-email-laoar.shao@gmail.com>
 <CANn89iKU49yBRq4x8xHGXiWZ9h0PNAmyWnMoNDFmSm9oKXsbqw@mail.gmail.com>
 <CALOAHbAbw6nXggT4ZF-=L_tQqsm-EQ==Qd9aeLys2mwQizFnkw@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <68b62912-21d5-c238-7536-12928670a08a@gmail.com>
Date: Mon, 28 May 2018 21:53:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALOAHbAbw6nXggT4ZF-=L_tQqsm-EQ==Qd9aeLys2mwQizFnkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/28/2018 05:41 PM, Yafang Shao wrote:

> OK.
> 
> And what about introducing a new helper tcp_hdr_fast() ?
> 
> /* use it when tcp header has not been pulled yet */
> static inline struct tcphdr *tcp_hdr_fast(const struct sk_buff *skb)
> 
> {
> 
>         return (const struct tcphdr *)skb->data;
> 
> }
> 
> 
> That could help us to use this optimized one instead of the original
> one if possilbe.


I would rather not add such macro...

The call site needs to know what is going on, so having a macro like that would not help.
