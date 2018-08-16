Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39233C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B3320E20
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="eBrLOZXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B3320E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbeHPH6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 03:58:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37393 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731216AbeHPH6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 03:58:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so2922517wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 22:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EGPf1UZ2hZrT4KQU5HKlLuDiPxjBLB7HBsyG0z8KKTE=;
        b=eBrLOZXHBpQQ00Qwm30ZwOUTG672GWAABTMGAx6FmH/ZKSLlcxgmnUfXRtGtNmsgQG
         CnO7VfKAdB77g8OsFE/pVfLgvVuaC0k7NmHht0adodwzTWBrkNf/0tue03zq347NSmnH
         O+JMLTP1BLSRF7itaiXuJdbi1nFXurX09+27I70VoG3ykNYKA718qoDm0Uc6PCKAyEND
         9eyWGKWML8aa8YjifyE5BraGNbtIqGPXgUsbQiHeGr81qGoCuIcwPKu3Frvm5ZXZ0x+f
         TOG/JbW/Xda7Y5/kj8ceeubbUjQad7RpjdBz1LrtB6+Eb/8eS9KPMpmm+w8/JU0vu5Ek
         Td0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EGPf1UZ2hZrT4KQU5HKlLuDiPxjBLB7HBsyG0z8KKTE=;
        b=HReGyJY7GFvzAPk+uU1mksndIMJNJQS6o1rEgHANCHKviVy3XUvMt++9BNNUQSvBKK
         6RgTCAzmcNwfnat1RuZQhJjPgZwEFNQ3iZ54TNf+L9OiXf67BOl7UzXLtOLXp65TCE54
         gBxQFvnbp4735r7c7gXvfZGzkbFPVpxETFX2gApq7jFLHW/7cZKuaLSRRLmkBpAH1fGP
         kzKQAzdzchA7yHzhTlYCeXHAK1Mcl7xyOqkOAcgCiWj63zXPFa8uQB/7qZ7QOq4aD/m/
         +FZqlRiu2z4ltlsawRYZaL2VHNKtGIczWtouaieNhel5bp9Q0bvBWsElyyNdhe5rDKYO
         EQbg==
X-Gm-Message-State: AOUpUlFj5YcyhjSOwbGE0KBsPc5/BiJQnVv1OWq/5WH0S76OYSZx2/QC
        9pzVrnahod+PorsibH5q/Uoxu3ouDNgVxtKbYOkASA==
X-Google-Smtp-Source: AA+uWPzcW2QSLhkJ1w+AUeQm92U33BpLNEknjdwMP09j6wxgl1GYs4jHwQWBfBMTacEP4f2Y5fVGj86PS0qZLU4GdrE=
X-Received: by 2002:adf:f585:: with SMTP id f5-v6mr17610773wro.59.1534395749278;
 Wed, 15 Aug 2018 22:02:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dd2:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 22:02:28
 -0700 (PDT)
In-Reply-To: <1534377377-70108-4-git-send-email-atish.patra@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com> <1534377377-70108-4-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Aug 2018 10:32:28 +0530
Message-ID: <CAAhSdy2TeNfjdzWPHtCwrorBu8c9v-u9Ro-eGMbzSwzapfwdjw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
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

On Thu, Aug 16, 2018 at 5:26 AM, Atish Patra <atish.patra@wdc.com> wrote:
> Defining cpu_operations now helps adding cpu hotplug
> support in proper manner. Moreover, it provides flexibility
> in supporting other cpu enable/boot methods can be
> supported in future. This patch has been largely inspired from
> ARM64. However, a default boot method is defined for RISC-V unlike
> ARM64.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/smp.h | 10 ++++++++++
>  arch/riscv/kernel/smp.c      |  8 ++++++++
>  arch/riscv/kernel/smpboot.c  | 34 ++++++++++++++++++++++++++++------
>  3 files changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 0763337b..2bb6e6c2 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -28,6 +28,15 @@
>  extern u64 __cpu_logical_map[NR_CPUS];
>  #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
>
> +struct cpu_operations {
> +       const char      *name;
> +       int             (*cpu_init)(unsigned int);
> +       int             (*cpu_prepare)(unsigned int);
> +       int             (*cpu_boot)(unsigned int, struct task_struct *);
> +};
> +extern struct cpu_operations cpu_ops;
> +void smp_set_cpu_ops(const struct cpu_operations *cpu_ops);
> +
>  #ifdef CONFIG_SMP
>
>  /* SMP initialization hook for setup_arch */
> @@ -57,5 +66,6 @@ static inline void cpuid_to_hartid_mask(const struct cpumask *in,
>         cpumask_set_cpu(cpu_logical_map(0), out);
>  }
>
> +
>  #endif /* CONFIG_SMP */
>  #endif /* _ASM_RISCV_SMP_H */
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 4ab70480..5de58ced 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -58,6 +58,14 @@ void cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
>         for_each_cpu(cpu, in)
>                 cpumask_set_cpu(cpu_logical_map(cpu), out);
>  }
> +struct cpu_operations cpu_ops __ro_after_init;
> +
> +void smp_set_cpu_ops(const struct cpu_operations *ops)
> +{
> +       if (ops)
> +               cpu_ops = *ops;
> +}
> +

Move both cpu_ops and smp_set_cpu_ops() to smpboot.c. This way
you will not require to make cpu_ops as global.

Further, I think cpu_ops should be a pointer and initial value should
be &default_ops.

Something like this:
struct cpu_operations *cpu_ops __ro_after_init = &default_ops;

>  /* Unsupported */
>  int setup_profiling_timer(unsigned int multiplier)
>  {
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 6ab2bb1b..045a1a45 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -30,6 +30,7 @@
>  #include <linux/irq.h>
>  #include <linux/of.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/smp.h>
>  #include <asm/irq.h>
>  #include <asm/mmu_context.h>
>  #include <asm/tlbflush.h>
> @@ -38,6 +39,7 @@
>
>  void *__cpu_up_stack_pointer[NR_CPUS];
>  void *__cpu_up_task_pointer[NR_CPUS];
> +struct cpu_operations default_ops;
>
>  void __init smp_prepare_boot_cpu(void)
>  {
> @@ -53,6 +55,7 @@ void __init setup_smp(void)
>         int hart, found_boot_cpu = 0;
>         int cpuid = 1;
>
> +       smp_set_cpu_ops(&default_ops);
>         while ((dn = of_find_node_by_type(dn, "cpu"))) {
>                 hart = riscv_of_processor_hart(dn);
>
> @@ -73,10 +76,8 @@ void __init setup_smp(void)
>         BUG_ON(!found_boot_cpu);
>  }
>
> -int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> +int default_cpu_boot(unsigned int hartid, struct task_struct *tidle)
>  {
> -       int hartid = cpu_logical_map(cpu);
> -       tidle->thread_info.cpu = cpu;
>         /*
>          * On RISC-V systems, all harts boot on their own accord.  Our _start
>          * selects the first hart to boot the kernel and causes the remainder
> @@ -84,13 +85,28 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>          * setup by that main hart.  Writing __cpu_up_stack_pointer signals to
>          * the spinning harts that they can continue the boot process.
>          */
> -       smp_mb();
> +
>         __cpu_up_stack_pointer[hartid] = task_stack_page(tidle) + THREAD_SIZE;
>         __cpu_up_task_pointer[hartid] = tidle;
> +       return 0;
> +}
> +
> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> +{
> +       int err = -1;
> +       int hartid = cpu_logical_map(cpu);
>
> -       while (!cpu_online(cpu))
> -               cpu_relax();
> +       tidle->thread_info.cpu = cpu;
> +       smp_mb();
>
> +       if (cpu_ops.cpu_boot)
> +               err = cpu_ops.cpu_boot(hartid, tidle);
> +       if (!err) {
> +               while (!cpu_online(cpu))
> +                       cpu_relax();
> +       } else {
> +               pr_err("CPU %d [hartid %d]failed to boot\n", cpu, hartid);
> +       }
>         return 0;
>  }
>
> @@ -117,3 +133,9 @@ asmlinkage void __init smp_callin(void)
>         preempt_disable();
>         cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
>  }
> +
> +
> +struct cpu_operations default_ops = {
> +       .name           = "default",
> +       .cpu_boot       = default_cpu_boot,
> +};

I think having dedicated source file for default_ops makes more sense
so that we have a clear/simple reference implementation of cpu_operations.

Eventually, we might have one source file for each type of SMP enable
method.

Try to keep smpboot.c generic and independent of any cpu_operations.
What say?

Regards,
Anup
