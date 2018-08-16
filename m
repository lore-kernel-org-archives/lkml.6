Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBB8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3523E2147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="DE1q3y9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3523E2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbeHPJRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 05:17:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38403 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeHPJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 05:17:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so482759wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DTwhIc+01HwvTs4nSoIf1CgBlTOLdehZzVAdQ+Vv1P4=;
        b=DE1q3y9V0w/Ij54WzWK42XLn1yAG6WiwF92I89YBVdi1lkHF4xy5dbaZI+rkn7vzIP
         cP58l99HvBKdcQnBveSDieqt+GSLlytADKcKjDf+SRbWX2aC+JS7J0zfZPyAk+RsppmR
         RZ0/AF9fxyfZ79DFkP7zt5Z3Jg7JQiP4NA+brCfPk0mrqFrIrovQYqyVz9ICDnVWYdnd
         1bhEqPyPdiW5VdCD+uQbQ7N/KNij0e1UPb4RtiBfeKsnAVipS1dhJ+vF9nMQ7rkZ8rri
         Xb7zW+LDz55hf+6XolXY3vMibTMIe4eCJWqa94JpJb1vcm7id8vchAp0YVZauZ2B6D+l
         Jm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DTwhIc+01HwvTs4nSoIf1CgBlTOLdehZzVAdQ+Vv1P4=;
        b=kho7Nyd8gG8aa/LZmysElPkLSbXl6SCDyc/BEbY7KY3EYRKBubrTuJQi/XWZfe1HQp
         z2Vpu3TPbDAI+WA35WM+sE4GzCJ3rfKZAdDe9MGZPsWWIxP34fIhvRUkKDh6C0KQpqIt
         /7kVdBErFG86rj5ZnhmDBOxRz+fvNLr6dfw27lTsXhQjOYi7bHIidRZIxEI7ZZt9Qauj
         6Bxb1s+L6FG403sbYYQZKQT2ul5iJPaOaPeLXT472g6gmvNG2MkZ06+aH/SY79VuyxIr
         5S/G91CisUdH3SOFaOItiBkbaor07FdINQX2058Kg0ifOvJT2x5HqBy1cuGKjSgddZga
         Smhw==
X-Gm-Message-State: AOUpUlEAAu3vH3qzXT4B17Fu6Qq9IuTGa8y7EZ1f++u0n0OCwCsLnyOD
        k+770kyoiz7vM+9OYjcBZSO/2p80PlK4CxCbwou8pg==
X-Google-Smtp-Source: AA+uWPwXaRGs7AUDLkp9S7fn9MAjUI5TJ8foHSe03PaE90OHlwLFxksv9mm7xnS2vTiRad1fMRQwta9zMB5/rhlXaJk=
X-Received: by 2002:a5d:6550:: with SMTP id z16-v6mr17458636wrv.194.1534400464356;
 Wed, 15 Aug 2018 23:21:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dd2:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 23:21:03
 -0700 (PDT)
In-Reply-To: <ce39a215-3bb1-d866-0d84-76642acb70bc@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-4-git-send-email-atish.patra@wdc.com> <CAAhSdy2TeNfjdzWPHtCwrorBu8c9v-u9Ro-eGMbzSwzapfwdjw@mail.gmail.com>
 <ce39a215-3bb1-d866-0d84-76642acb70bc@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Aug 2018 11:51:03 +0530
Message-ID: <CAAhSdy30Fz0Ki5zMws6hspgn=xwcFLj3VVixH88UWGU+oehBQg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 11:10 AM, Atish Patra <atish.patra@wdc.com> wrote:
> On 8/15/18 10:02 PM, Anup Patel wrote:
>>
>> On Thu, Aug 16, 2018 at 5:26 AM, Atish Patra <atish.patra@wdc.com> wrote:
>>>
>>> Defining cpu_operations now helps adding cpu hotplug
>>> support in proper manner. Moreover, it provides flexibility
>>> in supporting other cpu enable/boot methods can be
>>> supported in future. This patch has been largely inspired from
>>> ARM64. However, a default boot method is defined for RISC-V unlike
>>> ARM64.
>>>
>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>> ---
>>>   arch/riscv/include/asm/smp.h | 10 ++++++++++
>>>   arch/riscv/kernel/smp.c      |  8 ++++++++
>>>   arch/riscv/kernel/smpboot.c  | 34 ++++++++++++++++++++++++++++------
>>>   3 files changed, 46 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
>>> index 0763337b..2bb6e6c2 100644
>>> --- a/arch/riscv/include/asm/smp.h
>>> +++ b/arch/riscv/include/asm/smp.h
>>> @@ -28,6 +28,15 @@
>>>   extern u64 __cpu_logical_map[NR_CPUS];
>>>   #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
>>>
>>> +struct cpu_operations {
>>> +       const char      *name;
>>> +       int             (*cpu_init)(unsigned int);
>>> +       int             (*cpu_prepare)(unsigned int);
>>> +       int             (*cpu_boot)(unsigned int, struct task_struct *);
>>> +};
>>> +extern struct cpu_operations cpu_ops;
>>> +void smp_set_cpu_ops(const struct cpu_operations *cpu_ops);
>>> +
>>>   #ifdef CONFIG_SMP
>>>
>>>   /* SMP initialization hook for setup_arch */
>>> @@ -57,5 +66,6 @@ static inline void cpuid_to_hartid_mask(const struct
>>> cpumask *in,
>>>          cpumask_set_cpu(cpu_logical_map(0), out);
>>>   }
>>>
>>> +
>>>   #endif /* CONFIG_SMP */
>>>   #endif /* _ASM_RISCV_SMP_H */
>>> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
>>> index 4ab70480..5de58ced 100644
>>> --- a/arch/riscv/kernel/smp.c
>>> +++ b/arch/riscv/kernel/smp.c
>>> @@ -58,6 +58,14 @@ void cpuid_to_hartid_mask(const struct cpumask *in,
>>> struct cpumask *out)
>>>          for_each_cpu(cpu, in)
>>>                  cpumask_set_cpu(cpu_logical_map(cpu), out);
>>>   }
>>> +struct cpu_operations cpu_ops __ro_after_init;
>>> +
>>> +void smp_set_cpu_ops(const struct cpu_operations *ops)
>>> +{
>>> +       if (ops)
>>> +               cpu_ops = *ops;
>>> +}
>>> +
>>
>>
>> Move both cpu_ops and smp_set_cpu_ops() to smpboot.c. This way
>> you will not require to make cpu_ops as global.
>>
> ok.
>
>> Further, I think cpu_ops should be a pointer and initial value should
>> be &default_ops.
>>
>> Something like this:
>> struct cpu_operations *cpu_ops __ro_after_init = &default_ops;
>>
>
> That will work too. However, setting it through smp_set_cpu_ops provides a
> sample implementation for any future SMP enable methods. That's why I used
> the API. I can change it if you think otherwise.

Having thought about this more, I think cpu_ops should be an pointer array
of NR_CPUS size. This means its not necessary to have have same ops for
all CPUs. The ARM64 implementation of CPU operations also allows separate
CPU operations for each CPU.

For example, let's us assume that we have an SOC where we 2 cores
per-cluster and N clusters. All CPUs of cluster0 comes up at the same time
whereas cluster1 onwards we have to bring-up CPUs using special HW
mechanism.

>
>
>
>>>   /* Unsupported */
>>>   int setup_profiling_timer(unsigned int multiplier)
>>>   {
>>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>>> index 6ab2bb1b..045a1a45 100644
>>> --- a/arch/riscv/kernel/smpboot.c
>>> +++ b/arch/riscv/kernel/smpboot.c
>>> @@ -30,6 +30,7 @@
>>>   #include <linux/irq.h>
>>>   #include <linux/of.h>
>>>   #include <linux/sched/task_stack.h>
>>> +#include <linux/smp.h>
>>>   #include <asm/irq.h>
>>>   #include <asm/mmu_context.h>
>>>   #include <asm/tlbflush.h>
>>> @@ -38,6 +39,7 @@
>>>
>>>   void *__cpu_up_stack_pointer[NR_CPUS];
>>>   void *__cpu_up_task_pointer[NR_CPUS];
>>> +struct cpu_operations default_ops;
>>>
>>>   void __init smp_prepare_boot_cpu(void)
>>>   {
>>> @@ -53,6 +55,7 @@ void __init setup_smp(void)
>>>          int hart, found_boot_cpu = 0;
>>>          int cpuid = 1;
>>>
>>> +       smp_set_cpu_ops(&default_ops);
>>>          while ((dn = of_find_node_by_type(dn, "cpu"))) {
>>>                  hart = riscv_of_processor_hart(dn);
>>>
>>> @@ -73,10 +76,8 @@ void __init setup_smp(void)
>>>          BUG_ON(!found_boot_cpu);
>>>   }
>>>
>>> -int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>>> +int default_cpu_boot(unsigned int hartid, struct task_struct *tidle)
>>>   {
>>> -       int hartid = cpu_logical_map(cpu);
>>> -       tidle->thread_info.cpu = cpu;
>>>          /*
>>>           * On RISC-V systems, all harts boot on their own accord.  Our
>>> _start
>>>           * selects the first hart to boot the kernel and causes the
>>> remainder
>>> @@ -84,13 +85,28 @@ int __cpu_up(unsigned int cpu, struct task_struct
>>> *tidle)
>>>           * setup by that main hart.  Writing __cpu_up_stack_pointer
>>> signals to
>>>           * the spinning harts that they can continue the boot process.
>>>           */
>>> -       smp_mb();
>>> +
>>>          __cpu_up_stack_pointer[hartid] = task_stack_page(tidle) +
>>> THREAD_SIZE;
>>>          __cpu_up_task_pointer[hartid] = tidle;
>>> +       return 0;
>>> +}
>>> +
>>> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>>> +{
>>> +       int err = -1;
>>> +       int hartid = cpu_logical_map(cpu);
>>>
>>> -       while (!cpu_online(cpu))
>>> -               cpu_relax();
>>> +       tidle->thread_info.cpu = cpu;
>>> +       smp_mb();
>>>
>>> +       if (cpu_ops.cpu_boot)
>>> +               err = cpu_ops.cpu_boot(hartid, tidle);
>>> +       if (!err) {
>>> +               while (!cpu_online(cpu))
>>> +                       cpu_relax();
>>> +       } else {
>>> +               pr_err("CPU %d [hartid %d]failed to boot\n", cpu,
>>> hartid);
>>> +       }
>>>          return 0;
>>>   }
>>>
>>> @@ -117,3 +133,9 @@ asmlinkage void __init smp_callin(void)
>>>          preempt_disable();
>>>          cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
>>>   }
>>> +
>>> +
>>> +struct cpu_operations default_ops = {
>>> +       .name           = "default",
>>> +       .cpu_boot       = default_cpu_boot,
>>> +};
>>
>>
>> I think having dedicated source file for default_ops makes more sense
>> so that we have a clear/simple reference implementation of cpu_operations.
>>
>> Eventually, we might have one source file for each type of SMP enable
>> method.
>>
>> Try to keep smpboot.c generic and independent of any cpu_operations.
>> What say?
>>
>
> Any other SMP enable method should definitely get its own file. I am not
> sure about the default one though. As default_ops is truly the default
> booting method which will always be present in absence of anything else, I
> thought keeping it smpboot.c emphasizes that point. Moreover, it's not that
> big even. But I am open to moving to it's own source file if you strongly
> think we should do that.
>

I am more inclined towards keeping default_ops in separate source but it's
not a big deal. Let's wait for more comments.

Regards,
Anup
