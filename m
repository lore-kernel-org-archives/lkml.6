Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0365C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CED217B9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fV9mlrsW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="borekg4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CED217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403866AbeHGR1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:27:30 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33597 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403837AbeHGR1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:27:30 -0400
Received: by mail-yw1-f67.google.com with SMTP id c135-v6so5046111ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xlMo8bE/SLpOv6oAIB77N8aTLstlz5TjpORwAzquR2k=;
        b=fV9mlrsWINwtuo12i1/nY6EbqDn+Gg4q3YvbtYQe3DLLic40HptALz8TNyk/lnUdR5
         WUPjqnYFdSdD4oSKKOrUy5ho0oMvPvsmZhxQlynxqDGrpGOpa64n8un9cvcu0rDsuGeD
         cSM38EgmoDFPy/SsHpPmf8rZxeDyEij0vXz3Bm/LNSL1zxuY3TA6SWIhfM5srnKJMioo
         8pWyq4egWIG1d+NNQSEDL+7w+oQRCZQ7Lzq3MLSt3kOpF6rMA/iNSez35e6wWvJQ+k7G
         g+WurNCvL5xqBiGpx6hvg78G0nG5oWMHfZd/DNYGmUG0dDX/8XXMqHXOk7qSXJ0TFWpb
         0ShA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xlMo8bE/SLpOv6oAIB77N8aTLstlz5TjpORwAzquR2k=;
        b=borekg4dS3/YVbsI/6dQonIA5SFXcxinVqgawlZ5vrZrjs8UNRZFe+sKKG1Zb6cdAq
         47482asd5ROZwGRYAi58mokzgAQaI55ksxw5uNC9fpD1EtA/T3HZcs5o2vIy6PdHVt/X
         /vTaG2pfQiBhBEDKr7B5TYAks6U7VAoBva7RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xlMo8bE/SLpOv6oAIB77N8aTLstlz5TjpORwAzquR2k=;
        b=jR/rFN9VA6FfOyXup5I+dypDPppuI3AliSSp67g5Cuotf9FSBNKjwXGlk6qW58bNyL
         AjAlOeBSQbIc3hBKqibH5yHlVZxq6SOShFbb8IlxnA/PDEC+ocbrlHw0B9kRxwGA6T8b
         NHbTC6YGBce2b+TANYTrpMT/s1T0tQ16nZfoW547gmQmPKTLzcZ48crd5ARryMFzmv47
         dIpMqLOQUAWbCWUz2xjImlXmGS6EUjtkPFonmwzqr+2tiJb8I/Jl/r76MAEYYXVwMUt7
         69bDl5LJkbVwZZjEeRw36ALL+1s26Hcr4k3fNeN+0UYSVsgACeO9zbxOTVP9nTAjTWXt
         bNjw==
X-Gm-Message-State: AOUpUlFlSbWO+/tnjPkLvcO8BtNsFZtmVBJPfDbtNHUb0CsbGFDzyCIs
        zf4UiKP/kgsVFtS8zVd1nrcbd73O9F6DIzmpdTER4w==
X-Google-Smtp-Source: AAOMgpfsoTIxhXrKaLrVYdVMc2v6WuJgfT3MaWMBouLTy2Gd8spiu49p1OeBZBzcFXafZcV/gjNm5ELZjM25WF9x25Q=
X-Received: by 2002:a0d:f002:: with SMTP id z2-v6mr10680139ywe.116.1533654763077;
 Tue, 07 Aug 2018 08:12:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7450:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 08:12:42 -0700 (PDT)
In-Reply-To: <20180807141846.bvcw3wnizjh2bg2u@pathway.suse.cz>
References: <e14dedc721b7aed1cf3ff1bdbc09014c0131c276.1532795905.git.joe@perches.com>
 <20180807141846.bvcw3wnizjh2bg2u@pathway.suse.cz>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 7 Aug 2018 08:12:42 -0700
X-Google-Sender-Auth: Fgb6JM7KehhB8w2woncEL3vNRyQ
Message-ID: <CAGXu5j+ihHthBbxZRXr2C+L1G66cESqUW3XprC6PO+TrJ6HpKg@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: Convert uses of REG_FMT to %p
To:     Petr Mladek <pmladek@suse.com>
Cc:     Joe Perches <joe@perches.com>, Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 7:18 AM, Petr Mladek <pmladek@suse.com> wrote:
> On Sat 2018-07-28 09:39:57, Joe Perches wrote:
>> Use %p pointer output instead of REG_FMT and cast the unsigned longs to
>> (void *) to avoid exposing kernel addresses.
>>
>> Miscellanea:
>>
>> o Convert pr_cont to printk(KERN_DEFAULT as these uses are
>>   new logging lines and not previous line continuations
>> o Remove the now unused REG_FMT defines
>>
>> Signed-off-by: Joe Perches <joe@perches.com>
>> ---
>>
>> v2: sigh: Add missing fault.c
>>
>>  arch/riscv/include/asm/ptrace.h |  6 -----
>>  arch/riscv/kernel/process.c     | 52 +++++++++++++++++++++--------------------
>>  arch/riscv/kernel/traps.c       |  4 ++--
>>  arch/riscv/mm/fault.c           |  6 ++---
>>  4 files changed, 32 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
>> index 2c5df945d43c..b123e723f8fa 100644
>> --- a/arch/riscv/include/asm/ptrace.h
>> +++ b/arch/riscv/include/asm/ptrace.h
>> @@ -60,12 +60,6 @@ struct pt_regs {
>>          unsigned long orig_a0;
>>  };
>>
>> -#ifdef CONFIG_64BIT
>> -#define REG_FMT "%016lx"
>> -#else
>> -#define REG_FMT "%08lx"
>> -#endif
>> -
>>  #define user_mode(regs) (((regs)->sstatus & SR_SPP) == 0)
>>
>>
>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>> index d7c6ca7c95ae..7223f6715ff3 100644
>> --- a/arch/riscv/kernel/process.c
>> +++ b/arch/riscv/kernel/process.c
>> @@ -36,7 +36,7 @@
>>  extern asmlinkage void ret_from_fork(void);
>>  extern asmlinkage void ret_from_kernel_thread(void);
>>
>> -void arch_cpu_idle(void)
>> +void arch_yycpu_idle(void)
>>  {
>>       wait_for_interrupt();
>>       local_irq_enable();
>> @@ -46,31 +46,33 @@ void show_regs(struct pt_regs *regs)
>>  {
>>       show_regs_print_info(KERN_DEFAULT);
>>
>> -     pr_cont("sepc: " REG_FMT " ra : " REG_FMT " sp : " REG_FMT "\n",
>> -             regs->sepc, regs->ra, regs->sp);
>> -     pr_cont(" gp : " REG_FMT " tp : " REG_FMT " t0 : " REG_FMT "\n",
>> -             regs->gp, regs->tp, regs->t0);
>> -     pr_cont(" t1 : " REG_FMT " t2 : " REG_FMT " s0 : " REG_FMT "\n",
>> -             regs->t1, regs->t2, regs->s0);
>> -     pr_cont(" s1 : " REG_FMT " a0 : " REG_FMT " a1 : " REG_FMT "\n",
>> -             regs->s1, regs->a0, regs->a1);
>> -     pr_cont(" a2 : " REG_FMT " a3 : " REG_FMT " a4 : " REG_FMT "\n",
>> -             regs->a2, regs->a3, regs->a4);
>> -     pr_cont(" a5 : " REG_FMT " a6 : " REG_FMT " a7 : " REG_FMT "\n",
>> -             regs->a5, regs->a6, regs->a7);
>> -     pr_cont(" s2 : " REG_FMT " s3 : " REG_FMT " s4 : " REG_FMT "\n",
>> -             regs->s2, regs->s3, regs->s4);
>> -     pr_cont(" s5 : " REG_FMT " s6 : " REG_FMT " s7 : " REG_FMT "\n",
>> -             regs->s5, regs->s6, regs->s7);
>> -     pr_cont(" s8 : " REG_FMT " s9 : " REG_FMT " s10: " REG_FMT "\n",
>> -             regs->s8, regs->s9, regs->s10);
>> -     pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
>> -             regs->s11, regs->t3, regs->t4);
>> -     pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
>> -             regs->t5, regs->t6);
>> +     printk(KERN_DEFAULT "sepc: %p ra : %p sp : %p\n",
>> +            (void *)regs->sepc, (void *)regs->ra, (void *)regs->sp);
>> +     printk(KERN_DEFAULT " gp : %p tp : %p t0 : %p\n",
>> +            (void *)regs->gp, (void *)regs->tp, (void *)regs->t0);
>> +     printk(KERN_DEFAULT " t1 : %p t2 : %p s0 : %p\n",
>> +            (void *)regs->t1, (void *)regs->t2, (void *)regs->s0);
>> +     printk(KERN_DEFAULT " s1 : %p a0 : %p a1 : %p\n",
>> +            (void *)regs->s1, (void *)regs->a0, (void *)regs->a1);
>> +     printk(KERN_DEFAULT " a2 : %p a3 : %p a4 : %p\n",
>> +            (void *)regs->a2, (void *)regs->a3, (void *)regs->a4);
>> +     printk(KERN_DEFAULT " a5 : %p a6 : %p a7 : %p\n",
>> +            (void *)regs->a5, (void *)regs->a6, (void *)regs->a7);
>> +     printk(KERN_DEFAULT " s2 : %p s3 : %p s4 : %p\n",
>> +            (void *)regs->s2, (void *)regs->s3, (void *)regs->s4);
>> +     printk(KERN_DEFAULT " s5 : %p s6 : %p s7 : %p\n",
>> +            (void *)regs->s5, (void *)regs->s6, (void *)regs->s7);
>> +     printk(KERN_DEFAULT " s8 : %p s9 : %p s10: %p\n",
>> +            (void *)regs->s8, (void *)regs->s9, (void *)regs->s10);
>> +     printk(KERN_DEFAULT " s11: %p t3 : %p t4 : %p\n",
>> +            (void *)regs->s11, (void *)regs->t3, (void *)regs->t4);
>> +     printk(KERN_DEFAULT " t5 : %p t6 : %p\n",
>> +            (void *)regs->t5, (void *)regs->t6);
>>
>> -     pr_cont("sstatus: " REG_FMT " sbadaddr: " REG_FMT " scause: " REG_FMT "\n",
>> -             regs->sstatus, regs->sbadaddr, regs->scause);
>> +     printk(KERN_DEFAULT "sstatus: %p sbadaddr: %p scause: %p\n",
>> +            (void *)regs->sstatus,
>> +            (void *)regs->sbadaddr,
>> +            (void *)regs->scause);
>>  }
>
> This change makes the dump almost unusable. Note that registers contain any
> kind of information, not only pointers.
>
> My understanding is that %px was introduced because printing the
> pointer directly is sometimes worth the security risk. IMHO, this
> is one place where we want to risk printing the real value.
>
> Anyway, it needs to be decided by security gurus. Adding some more
> people into CC.

If these are trap or fault dumps, I think %px (or %llx) is correct.
Before riscv existed, I went through the fault handlers and fixed this
already:

10a7e9d84915 ("Do not hash userspace addresses in fault handlers")

and dump_stack() is calling show_regs(), so I think that should be
left readable as well. (If not, we have a lot more than riscv to fix.)

-Kees

-- 
Kees Cook
Pixel Security
