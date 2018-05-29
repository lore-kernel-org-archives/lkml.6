Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeE2LJm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:09:42 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38408 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbeE2LJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:09:39 -0400
X-Google-Smtp-Source: ADUXVKK8ChoTEH0H3q8sMZFbijERcLswolwNnNFDn9BqUh07YeqFdfwgLXDPr+pqS7OUEVQ5FkjzSxjQTgJXIPMWu7E=
MIME-Version: 1.0
In-Reply-To: <68b62912-21d5-c238-7536-12928670a08a@gmail.com>
References: <1527521753-17963-1-git-send-email-laoar.shao@gmail.com>
 <1527521753-17963-2-git-send-email-laoar.shao@gmail.com> <CANn89iKU49yBRq4x8xHGXiWZ9h0PNAmyWnMoNDFmSm9oKXsbqw@mail.gmail.com>
 <CALOAHbAbw6nXggT4ZF-=L_tQqsm-EQ==Qd9aeLys2mwQizFnkw@mail.gmail.com> <68b62912-21d5-c238-7536-12928670a08a@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 May 2018 19:08:58 +0800
Message-ID: <CALOAHbBJs_8iTX+JbcG3bbqnH+xY6F16ii7N22y2cwmDzb8HFQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/2] tcp: minor optimization around tcp_hdr()
 usage in tcp receive path
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Song Liu <songliubraving@fb.com>,
        David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 12:53 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 05/28/2018 05:41 PM, Yafang Shao wrote:
>
>> OK.
>>
>> And what about introducing a new helper tcp_hdr_fast() ?
>>
>> /* use it when tcp header has not been pulled yet */
>> static inline struct tcphdr *tcp_hdr_fast(const struct sk_buff *skb)
>>
>> {
>>
>>         return (const struct tcphdr *)skb->data;
>>
>> }
>>
>>
>> That could help us to use this optimized one instead of the original
>> one if possilbe.
>
>
> I would rather not add such macro...
>
> The call site needs to know what is going on, so having a macro like that would not help.

OK
