Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D836DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C212089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwO9VbXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C212089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeGJE0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 00:26:43 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39627 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbeGJE0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 00:26:35 -0400
Received: by mail-it0-f67.google.com with SMTP id p185-v6so29488539itp.4;
        Mon, 09 Jul 2018 21:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XhD9eiHNeRL8E0pzbWEs43rDPTbjybVbhpbGnbaVICc=;
        b=dwO9VbXcERMzlC2SUsHGBRvGwnnbCTwoh6JqZlZS42i8ZOeUuX4o/oT2zgukGaV1X5
         jGwmN54LZx1yGXCgsfjc6cRvM8ZmiRqY2pyh430abBgnv0sDjYuC7m9o8Voti96ZfUuA
         Gh4LfHC31VSlp8+QiQ/Ogo7wXKkbovG7118nketZKLPIfEdxCx0tynHr0uchzl1HQ6Qd
         ksWzQUKPKsmP2Pw/95BvyjcnE+PrWrZxwkbWjZHXAGaZowFPCDvppT/0uqX3ty+JExAI
         i811YUiTN1UmzVIm3tPxX/0F/D0pjVzqCxNQU5yPAI3FTg+5M4oe21RUQCelKrKNB1hB
         92DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XhD9eiHNeRL8E0pzbWEs43rDPTbjybVbhpbGnbaVICc=;
        b=EpCNYxf7UKQOigosSTNCmnB/7MafEiEuvuVsGyhlsL8H/01yBCh6PJkXgGJdoRGP2Z
         UW671afQHJyJ8yjDAT7jX1LCgXco6KJFUwXn3sOhbOEPRAW67ChNWhGOjRcwTa0PpS5N
         HfHa5qUixrdi/oL2POtlcZ2ZYjEDZ5iUISs8apEt+oiSc7X91bBB+ZiKO3g5Xm4OmCUN
         qoqG581v5o2iB2i43HWXTnp9C268G1gRxdUUqEakWC7KvVq3SZ442FAL0GlUmya8c6Hx
         98wB5lH8/k2ZKTOyLRJmmejnkQiAwfzv8t0Vl26T8ruNHkb68QNf0RxRWRRzL1cgdKf6
         m0UA==
X-Gm-Message-State: AOUpUlFmzzbH6+n985MLYP7Ng0ALAly4L0hYb5zWY2txMM48yM9+rMbY
        gtoSzbfVN1nz7Y+//AOgEgwOjyVpxy28PSbMPtM=
X-Google-Smtp-Source: AAOMgpcqRsbHPHVGbfJJPlFkADcC4ObMbbUJoC8meBbp/ZjVdLW4dIHTqxVMubRpM9g1jBiZO5ufEUNaa4hv2OersV8=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr2893457iti.135.1531196795136;
 Mon, 09 Jul 2018 21:26:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:3757:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 21:26:34 -0700 (PDT)
In-Reply-To: <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com> <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Tue, 10 Jul 2018 12:26:34 +0800
X-Google-Sender-Auth: flr9zZnDnypc24E2yy1xGpxkGrI
Message-ID: <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul and Peter,

I think we find the real root cause, READ_ONCE() doesn't need any
barriers, the problematic code is queued_spin_lock_slowpath() in
kernel/locking/qspinlock.c:

        if (old & _Q_TAIL_MASK) {
                prev = decode_tail(old);

                /* Link @node into the waitqueue. */
                WRITE_ONCE(prev->next, node);

                pv_wait_node(node, prev);
                arch_mcs_spin_lock_contended(&node->locked);

                /*
                 * While waiting for the MCS lock, the next pointer may have
                 * been set by another lock waiter. We optimistically load
                 * the next pointer & prefetch the cacheline for writing
                 * to reduce latency in the upcoming MCS unlock operation.
                 */
                next = READ_ONCE(node->next);
                if (next)
                        prefetchw(next);
        }

After WRITE_ONCE(prev->next, node); arch_mcs_spin_lock_contended()
enter a READ_ONCE() loop, so the effect of WRITE_ONCE() is invisible
by other cores because of the write buffer. As a result,
arch_mcs_spin_lock_contended() will wait for ever because the waiters
of prev->next will wait for ever. I think the right way to fix this is
flush SFB after this WRITE_ONCE(), but I don't have a good solution:
1, MIPS has wbflush() which can be used to flush SFB, but other archs
don't have;
2, Every arch has mb(), and add mb() after WRITE_ONCE() can actually
solve Loongson's problem, but in syntax, mb() is different from
wbflush();
3, Maybe we can define a Loongson-specific WRITE_ONCE(), but not every
WRITE_ONCE() need wbflush(), we only need wbflush() between
WRITE_ONCE() and a READ_ONCE() loop.

Any ideas?

Huacai


On Tue, Jul 10, 2018 at 12:49 AM, Paul Burton <paul.burton@mips.com> wrote:
> Hi Huacai,
>
> On Mon, Jul 09, 2018 at 10:26:38AM +0800, Huacai Chen wrote:
>> After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
>> in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
>> has SFB (Store Fill Buffer) and the weak-ordering may cause READ_ONCE()
>> to get an old value in a tight loop. So in smp_cond_load_acquire() we
>> need a __smp_rmb() before the READ_ONCE() loop.
>>
>> This patch introduce a Loongson-specific smp_cond_load_acquire(). And
>> it should be backported to as early as linux-4.5, in which release the
>> smp_cond_acquire() is introduced.
>>
>> There may be other cases where memory barriers is needed, we will fix
>> them one by one.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/include/asm/barrier.h | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
>> index a5eb1bb..e8c4c63 100644
>> --- a/arch/mips/include/asm/barrier.h
>> +++ b/arch/mips/include/asm/barrier.h
>> @@ -222,6 +222,24 @@
>>  #define __smp_mb__before_atomic()    __smp_mb__before_llsc()
>>  #define __smp_mb__after_atomic()     smp_llsc_mb()
>>
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +/* Loongson-3 need a __smp_rmb() before READ_ONCE() loop */
>> +#define smp_cond_load_acquire(ptr, cond_expr)                        \
>> +({                                                           \
>> +     typeof(ptr) __PTR = (ptr);                              \
>> +     typeof(*ptr) VAL;                                       \
>> +     __smp_rmb();                                            \
>> +     for (;;) {                                              \
>> +             VAL = READ_ONCE(*__PTR);                        \
>> +             if (cond_expr)                                  \
>> +                     break;                                  \
>> +             cpu_relax();                                    \
>> +     }                                                       \
>> +     __smp_rmb();                                            \
>> +     VAL;                                                    \
>> +})
>> +#endif       /* CONFIG_CPU_LOONGSON3 */
>
> The discussion on v1 of this patch [1] seemed to converge on the view
> that Loongson suffers from the same problem as ARM platforms which
> enable the CONFIG_ARM_ERRATA_754327 workaround, and that we might
> require a similar workaround.
>
> Is there a reason you've not done that, and instead tweaked your patch
> that's specific to the smp_cond_load_acquire() case? I'm not comfortable
> with fixing just this one case when there could be many similar
> problematic pieces of code you just haven't hit yet.
>
> Please also keep the LKMM maintainers on copy for this - their feedback
> will be valuable & I'll be much more comfortable applying a workaround
> for Loongson's behavior here if it's one that they're OK with.
>
> Thanks,
>     Paul
>
> [1] https://www.linux-mips.org/archives/linux-mips/2018-06/msg00139.html
