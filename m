Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FA3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44776214C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="XS9deY6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44776214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbeHPHBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 03:01:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38991 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387501AbeHPHBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 03:01:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so3026602wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 21:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I7uxka0u1jLTlIWbBxTQjzk5UHp9i68gBytUNKwzkww=;
        b=XS9deY6Ss69c+bGM/stH9ymwbyNLF15GA4wcUMqZECbL2Ylp6y+TS6qQsjAqSUGp+k
         BH4DEVZT1eF4ZxjuOatd3MYaeBa7Q4k8tmkQ4GHPOl6m7K3bWfqQR6c9avj8/X8mNlRA
         VW/OipCCOBx9FbTIsD+XVcVD8QWXwg8mnbtR3vjF1hBOT5NG8nUXm0+QX5XB/xbgNH1L
         3bRtxsWTcFTFF1IRD22NHF983K56t4luAygyi9WQ7pkZVizAq9eQhrzd6Lpn3v0LzBpr
         /ZPrqn1IrogXbFQLhC/Zz2xcUpQqp/RFKPB3KWN2dsLS/vOX0vBfP0q6Q5lRR7J+Glhw
         X+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I7uxka0u1jLTlIWbBxTQjzk5UHp9i68gBytUNKwzkww=;
        b=h319iBH2KJaPev+5v1WHiA9m1qlOjYJGTFMjQoSGV1IdplPZ+2Bmt2hKPgSx1c8oY2
         llYqrGwwWN5lgnQ9WveifkUT/m4IKgqFo5eP2pJLxr81VeKZlyKBH4r4iirn5fMMBPk9
         Uq2mAOYzvkX8NbWHMK/W7/VcmW8eGen0q7Ie4IvclLllIVIIJBXfdHkoJX1I21bKOm7Y
         1Anvhx9Fz/OQVkL5AHyLQJ8ix/5mWHggJUBYpauIWn7ja39R8m10qW+C7xM6bAYSKApX
         1VlA/goI1Y/zeAEJm1pO8QX3STAsG019GDnukuQJIybR2kNZ2c5TPfBRb1n/3VQ4q0ny
         BekA==
X-Gm-Message-State: AOUpUlHvaqrqJJwmGxkAMBvXjZLfEeQ6JU5xoU3WUiLQlsQPu3SgHjCF
        L3LoHUnwtYooT9y6K7NthGv3vXkHIHfcgr+uWu7nYw==
X-Google-Smtp-Source: AA+uWPwc0v2hHzbanI3OiFm9zv/WWYM8p674fZRWzxr9gyfkxLZTq0qx6oP0vT+4v/vWSnvxAy9U+W/AhDhqzuXuNZg=
X-Received: by 2002:a1c:8a04:: with SMTP id m4-v6mr14465873wmd.137.1534392365170;
 Wed, 15 Aug 2018 21:06:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dd2:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 21:06:04
 -0700 (PDT)
In-Reply-To: <1534377377-70108-2-git-send-email-atish.patra@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com> <1534377377-70108-2-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Aug 2018 09:36:04 +0530
Message-ID: <CAAhSdy1Legi9jzYnkN2am3QKLw7Y8tpbUfmJVA0gBRB4nPnXjA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] RISC-V: Add logical CPU indexing for RISC-V
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
> Currently, both linux cpu id and hardware cpu id are same.
> This is not recommended as it will lead to discontinuous cpu
> indexing in Linux. Moreover, kdump kernel will run from CPU0
> which would be absent if we follow existing scheme.
>
> Implement a logical mapping between Linux cpu id and hardware
> cpuid to decouple these two. Always mark the boot processor as
> cpu0 and all other cpus get the logical cpu id based on their
> booting order.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/smp.h | 17 ++++++++++++++++-
>  arch/riscv/kernel/setup.c    |  2 ++
>  arch/riscv/kernel/smp.c      | 19 +++++++++++++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 36016845..0763337b 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -22,6 +22,12 @@
>  #include <linux/cpumask.h>
>  #include <linux/irqreturn.h>
>
> +/*
> + * Mapping between linux logical cpu index and hartid.
> + */
> +extern u64 __cpu_logical_map[NR_CPUS];
> +#define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
> +
>  #ifdef CONFIG_SMP
>
>  /* SMP initialization hook for setup_arch */
> @@ -33,6 +39,8 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
>  /* Hook for the generic smp_call_function_single() routine. */
>  void arch_send_call_function_single_ipi(int cpu);
>
> +int riscv_hartid_to_cpuid(int hartid);
> +void cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>  /*
>   * This is particularly ugly: it appears we can't actually get the definition
>   * of task_struct here, but we need access to the CPU this task is running on.
> @@ -41,6 +49,13 @@ void arch_send_call_function_single_ipi(int cpu);
>   */
>  #define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
>
> -#endif /* CONFIG_SMP */
> +#else
> +
> +static inline int riscv_hartid_to_cpuid(int hartid) { return 0 ; }
> +static inline void cpuid_to_hartid_mask(const struct cpumask *in,
> +                                      struct cpumask *out) {
> +       cpumask_set_cpu(cpu_logical_map(0), out);
> +}
>
> +#endif /* CONFIG_SMP */
>  #endif /* _ASM_RISCV_SMP_H */
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index db20dc63..e21ed481 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -82,6 +82,8 @@ EXPORT_SYMBOL(empty_zero_page);
>  /* The lucky hart to first increment this variable will boot the other cores */
>  atomic_t hart_lottery;
>
> +u64 __cpu_logical_map[NR_CPUS];

If hardware IDs are always machine word size then its better to use
"unsigned long" in-place of u64.

The __cpu_logical_map[] should be zero initially because zero is a
valid hardware ID. Better set all entries to -1 by assigning { -1 } to the
array.

Also, I feel  __cpu_logical_map[] should be part of smp.c instead of
setup.c. Any particular reason for having it in setup.c?

> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  static void __init setup_initrd(void)
>  {
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 906fe21e..d55379ee 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -38,7 +38,26 @@ enum ipi_message_type {
>         IPI_MAX
>  };
>
> +int riscv_hartid_to_cpuid(int hartid)
> +{
> +       int i = -1;
> +
> +       for (i = 0; i < NR_CPUS; i++)
> +               if (cpu_logical_map(i) == hartid)
> +                       return i;
> +
> +       pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
> +       BUG();
> +       return i;
> +}
>
> +void cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)

May be rename cpuid_to_hartid_mask() to riscv_cpuid_to_hartid_mask()
for consistency.

> +{
> +       int cpu;
> +
> +       for_each_cpu(cpu, in)
> +               cpumask_set_cpu(cpu_logical_map(cpu), out);
> +}
>  /* Unsupported */
>  int setup_profiling_timer(unsigned int multiplier)
>  {
> --
> 2.7.4
>
