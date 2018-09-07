Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025ABC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920C32077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="AicLtXEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920C32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeIGK7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:59:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41211 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIGK7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:59:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17-v6so11317420ljy.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 23:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jYByNgF3zqi2EFRNT1ofdcx5HbePs2BpzvOyEMD6zPg=;
        b=AicLtXEJUQ4DyRUnciKQ7JRQi0osTqS53cY/iwRRpU8KK17kHxZHsDbGmSBEAQ8sj1
         rvZH7jVhidg5JikWude/dzZk/kL/eHGr3i/MkklnaEZJfR6hgYbfFWxsoJjqmjGqqyBb
         nTENR5nzjkWYuX3+YPcNH+xOFrYaS4Tny5LQA43NsmmFVBYevcyhb3TLIcpSymaPM3Hu
         buGa7tuk+PUuI02qivwpsmClBKA7Imycm+w+PhkGBauOmpaclCWhlLKehPWP5Tqcuv+0
         QDatIVfvAkatxvvONGB2u8Ym7St1sv+IoJAxOW9puoJbhtUJ5j1KZnTT+xIzII4Tu9gB
         tEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jYByNgF3zqi2EFRNT1ofdcx5HbePs2BpzvOyEMD6zPg=;
        b=tmMo1vPI+KE2nkbv3AHyWTz6qjYz5o6X15oOrsgQvohfG/CaFAQRow2WA1Pcdg6zJF
         5RLF2/DhoXLzlt9faFchA/ImGHh26TA0ne/xpm1PeffTdXfPM8T5Go8T1Vy7+IHAKLgY
         GOXxcW8nu7OXltrB8FaaNkQ6VJLmKyoUFZ6tL/FJThdetXvCmVwnfQyYN07Myl9d75em
         2Btep33WkGvdV+Fq23M5YnC6TGKdiqVdIOeloodS0fJtXzuzSES0XSazcQonk7PncmJJ
         Fx06KpohzFjVHrCyvZI7mMijM6wlZ058qmSGftowgOUFDF5QBIuhqfSq9yVYiYoI5yVi
         ooDA==
X-Gm-Message-State: APzg51D263ZkFuHwWrXZNUnZN73CQfDjyBVgwp1Phpm5eSKyPuNNQFBf
        PC0q8WCASrG8Wga4xF2oqvjDxphzcyVFlFCVNWWCRg==
X-Google-Smtp-Source: ANB0VdZzRbhqd96ncYMtk1K7Q/pRxNgUaG4GXeHjgP5RFME2TXOh2OGAF95+hwFtgqhgBLNsa7ssvTfkwunmaM6NYOc=
X-Received: by 2002:a2e:8188:: with SMTP id e8-v6mr3739401ljg.138.1536301216923;
 Thu, 06 Sep 2018 23:20:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d984:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 23:20:15 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:180::1:f544]
In-Reply-To: <20180907033257.2nlgiqm2t4jiwhzc@gondor.apana.org.au>
References: <20180906192034.8467-1-olof@lixom.net> <CANn89i+akEWrHELBkZJQOxok-ZfYy+FNPUWdPEfB6c4YyWLqJA@mail.gmail.com>
 <20180907033257.2nlgiqm2t4jiwhzc@gondor.apana.org.au>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 6 Sep 2018 23:20:15 -0700
Message-ID: <CAOesGMgRrb4D2S_qWwgo00iNxbCL9EEGfhD5Ji-2HMWuZeq0Yw@mail.gmail.com>
Subject: Re: [PATCH] net/sock: move memory_allocated over to percpu_counter variables
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Vladislav Yasevich <vyasevich@gmail.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        linux-decnet-user@lists.sourceforge.net,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 6, 2018 at 8:32 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Sep 06, 2018 at 12:33:58PM -0700, Eric Dumazet wrote:
>> On Thu, Sep 6, 2018 at 12:21 PM Olof Johansson <olof@lixom.net> wrote:
>> >
>> > Today these are all global shared variables per protocol, and in
>> > particular tcp_memory_allocated can get hot on a system with
>> > large number of CPUs and a substantial number of connections.
>> >
>> > Moving it over to a per-cpu variable makes it significantly cheaper,
>> > and the added overhead when summing up the percpu copies is still smaller
>> > than the cost of having a hot cacheline bouncing around.
>>
>> I am curious. We never noticed contention on this variable, at least for TCP.
>
> Yes these variables are heavily amortised so I'm surprised that
> they would cause much contention.
>
>> Please share some numbers with us.
>
> Indeed.

Certainly, just had to collect them again.

This is on a dual xeon box, with ~150-200k TCP connections. I see
about .7% CPU spent in __sk_mem_{reduce,raise}_allocated in the
inlined atomic ops, most of those in reduce.

Call path for reduce is practically all from tcp_write_timer on softirq:

                __sk_mem_reduce_allocated
                tcp_write_timer
                call_timer_fn
                run_timer_softirq
                __do_softirq
                irq_exit
                smp_apic_timer_interrupt
                apic_timer_interrupt
                cpuidle_enter_state

With this patch, I see about .18+.11+.07 = .36% in percpu-related
functions called from the same __sk_mem functions.

Now, that's a halving of cycles samples on that specific setup. The
real difference though, is on another platform where atomics are more
expensive. There, this makes a significant difference. Unfortunately,
I can't share specifics but I think this change stands on its own on
the dual xeon setup as well, maybe with slightly less strong wording
on just how hot the variable/line happens to be.


-Olof
