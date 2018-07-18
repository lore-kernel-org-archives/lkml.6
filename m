Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F640ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3A02075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qK6jb0ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3A02075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbeGRBvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:51:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33952 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbeGRBvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:51:04 -0400
Received: by mail-it0-f66.google.com with SMTP id d191-v6so16115098ite.1;
        Tue, 17 Jul 2018 18:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KkCPA4iVjt5oodRnLb1cD13F+gfTwx1/KZRAmRFN1Ws=;
        b=qK6jb0epDhhUhdAnA/fZB3f9Z3VCep3x0DyBFictItsYOLPhxvcUt9VvUHGyYwMcV5
         1X7d8SxG+Z6P6N8uvkFzOjQtBkLHXGh2Xl3PaqHepRnCHyopLv5MgjwdDVjPuu+xxTal
         l1zEnOqte7oev42P0GLo4UZgkxdAnpLeUQxIRdAC7RUPUARwg1S00SYXp4yqL6kycI8F
         +kJUo/K1J+cHvHaAFHxQC1kKuZgK3RoqcqWH68TD1HZihZg4LhGoK/82T2tcnm5D+t8m
         IEWaktDYbg95Y8CnXXok6oI9dwg7m7zWUoE2lUpgPTOCwFs5lSWDe0tnARjImKsG469r
         BWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KkCPA4iVjt5oodRnLb1cD13F+gfTwx1/KZRAmRFN1Ws=;
        b=KGngTsXay0X8sU4gyPfg5WHS6sSXBXtEn8Nr2/8/AKYeWsWXaC87fZcgbXyOJoJxgD
         iJgUPvZzccJndMs3l5uhW4d9JzeDQGnZ2jy/XoRyTuYOEMcVLeKZRKzPcYwUWX4YZBws
         Jdl6jdQrE78+5+JrlZmpfv7NX2fjKEuTvzeWcqo7olTNYJaikCTkIyhJHoA5EkpskPb1
         xlHPneTc7S7m6yMCiAcz+SOyE1A/HPdsztzmNRI7G2tylK3+SDntqSGx5y5jEoGeRFyQ
         +YFkfdPEqc8QHkNWbhHCSfxjeggWe/OyBzJWXoZb5eL5dQz5IfghvAGvdcnukRJoHcVO
         lBJQ==
X-Gm-Message-State: AOUpUlH8ca95wxKuYPD/RYYEBJQijgiPn4Ne8fnaCkxQdlTQ/sQIq9Qr
        ZUY3uJKOQwwqgUELyaEPkHZLsMqUXTDQo16IFsE=
X-Google-Smtp-Source: AAOMgpf0VOFwWm/Zs+9fyLuVTeTKB5dkQKa91gWhKWy83huHSnIvYKshtsS2zR03P9W6y2b4QqArtMbiqu652cI0uZk=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr363968itb.16.1531876546766;
 Tue, 17 Jul 2018 18:15:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:3757:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 18:15:46
 -0700 (PDT)
In-Reply-To: <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
References: <1531467477-9952-1-git-send-email-chenhc@lemote.com> <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Wed, 18 Jul 2018 09:15:46 +0800
X-Google-Sender-Auth: UqQjVUCJ3GfsGIrQVJeJ2SvMIwA
Message-ID: <CAAhV-H5_==ZdKTOJTNXkRBTqmr5cxFvcaVabfNarEiQt_LvHZQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Change definition of cpu_relax() for Loongson-3
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
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

On Wed, Jul 18, 2018 at 1:52 AM, Paul Burton <paul.burton@mips.com> wrote:
> Hi Huacai,
>
> On Fri, Jul 13, 2018 at 03:37:57PM +0800, Huacai Chen wrote:
>> Linux expects that if a CPU modifies a memory location, then that
>> modification will eventually become visible to other CPUs in the system.
>>
>> On Loongson-3 processor with SFB (Store Fill Buffer), loads may be
>> prioritised over stores so it is possible for a store operation to be
>> postponed if a polling loop immediately follows it. If the variable
>> being polled indirectly depends on the outstanding store [for example,
>> another CPU may be polling the variable that is pending modification]
>> then there is the potential for deadlock if interrupts are disabled.
>> This deadlock occurs in qspinlock code.
>>
>> This patch changes the definition of cpu_relax() to smp_mb() for
>> Loongson-3, forcing a flushing of the SFB on SMP systems before the
>> next load takes place. If the Kernel is not compiled for SMP support,
>> this will expand to a barrier() as before.
>>
>> References: 534be1d5a2da940 (ARM: 6194/1: change definition of cpu_relax() for ARM11MPCore)
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/include/asm/processor.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
>> index af34afb..a8c4a3a 100644
>> --- a/arch/mips/include/asm/processor.h
>> +++ b/arch/mips/include/asm/processor.h
>> @@ -386,7 +386,17 @@ unsigned long get_wchan(struct task_struct *p);
>>  #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
>>  #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
>>
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +/*
>> + * Loongson-3's SFB (Store-Fill-Buffer) may get starved when stuck in a read
>> + * loop. Since spin loops of any kind should have a cpu_relax() in them, force
>> + * a Store-Fill-Buffer flush from cpu_relax() such that any pending writes will
>> + * become available as expected.
>> + */
>
> I think "may starve writes" or "may queue writes indefinitely" would be
> clearer than "may get starved".
Need I change the comment and resend? Or you change the comment and get merged?

Huacai

>
>> +#define cpu_relax()  smp_mb()
>> +#else
>>  #define cpu_relax()  barrier()
>> +#endif
>>
>>  /*
>>   * Return_address is a replacement for __builtin_return_address(count)
>> --
>> 2.7.0
>
> Apart from the comment above though this looks better to me.
>
> Re-copying the LKMM maintainers - are you happy(ish) with this?
>
> Thanks,
>     Paul
