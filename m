Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71466C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C12B21479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="pl6GPADu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C12B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbeHPIfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 04:35:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53266 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbeHPIfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 04:35:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so3230907wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E2XnoDSy7cWFCpd7ZCV1aPFZuUhPkkliODkkf4ZHKpU=;
        b=pl6GPADuo7XB8BkusQ/mlS4vC3T0g6npBpZtW36zdM0ZzLOOX9a22wTTOgKNTm3fKa
         JTC2g75uMod6jXT7NfJdRlLYS8/qJBkSmByy9o4I8unPb2+6gUOax6+xzCrIhZuvjofI
         QCrWG2jvacPUAP5oTfAYmSKPjPVlW0nCgb1ArDd5pfEigdX4bWBeSMzfPhCO6x63YV6/
         lMk/BCTqiA0FT0EyJ/jcet5/ck6ZvEt2kSpbCXNCCHeAfZPgu7MYnWv9JgXYEJ1c0Ms+
         fRZYCcqmzw853AyIjMiwUpxNvWX7GpbdEu2os9eq9IM6OPwee29ZPMfaxlhZijSoIIhZ
         TM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E2XnoDSy7cWFCpd7ZCV1aPFZuUhPkkliODkkf4ZHKpU=;
        b=oF4C5h6sVgOhxBCFm3hdQa/pQj6vywYc+izoE1R96THtP890DpAPHcRs3VHa+lBdcB
         BUN/tq4dFsft4DRL7t1JU34WbzVJ8di4jos96ENHiGcxv7xk7Y0B0g1r9dfcE9Qz8ZjN
         9vYwqq4Bv6pxpfwGARA79hEadJgRnLZhdYkkE5livlDTNupsti6sevUasOFq8r1HkL/8
         z3yQlxBOGLCUPDMWmgM7OLszkXBJ+BKCTkSZ6rSkP8rOc6hVU95LdJ4cioBGt+ilefWX
         N3gHQwuaKK7LlFvWAGw6BgNwjVU2gxTGuzYDeSFQEVUX98SZP6SqqF/Q41snuveSTL/s
         X1eg==
X-Gm-Message-State: AOUpUlHKnKIbyCKW0G/ByvGXF+gsAaMitE3P6m7Oh77mJ17PDqXpiHXj
        nIZB8LoKx9KQZmUxna0L8XNx/j0JKcPHB282WHiWKg==
X-Google-Smtp-Source: AA+uWPyQAkWl4xnJXSeO/K5OO7rFj9XPRcVS9KktYM2nQ8MP5uxnmCgeaEy3qBJKlBBXzp39+Qv+1d2CTS0/ujtU4Q0=
X-Received: by 2002:a1c:4c0e:: with SMTP id z14-v6mr16270819wmf.89.1534397988526;
 Wed, 15 Aug 2018 22:39:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dd2:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 22:39:48
 -0700 (PDT)
In-Reply-To: <7bc075fc-7039-62d8-c708-1c36233b7126@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-2-git-send-email-atish.patra@wdc.com> <CAAhSdy1Legi9jzYnkN2am3QKLw7Y8tpbUfmJVA0gBRB4nPnXjA@mail.gmail.com>
 <7bc075fc-7039-62d8-c708-1c36233b7126@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Aug 2018 11:09:48 +0530
Message-ID: <CAAhSdy0wb_dw0UypXQXLtRiQXRc5owxRdbCq=JRXw5gnYq9+JA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] RISC-V: Add logical CPU indexing for RISC-V
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

On Thu, Aug 16, 2018 at 10:47 AM, Atish Patra <atish.patra@wdc.com> wrote:
> On 8/15/18 9:06 PM, Anup Patel wrote:
>>
>> On Thu, Aug 16, 2018 at 5:26 AM, Atish Patra <atish.patra@wdc.com> wrote:
>>>
>>> Currently, both linux cpu id and hardware cpu id are same.
>>> This is not recommended as it will lead to discontinuous cpu
>>> indexing in Linux. Moreover, kdump kernel will run from CPU0
>>> which would be absent if we follow existing scheme.
>>>
>>> Implement a logical mapping between Linux cpu id and hardware
>>> cpuid to decouple these two. Always mark the boot processor as
>>> cpu0 and all other cpus get the logical cpu id based on their
>>> booting order.
>>>
>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>> ---
>>>   arch/riscv/include/asm/smp.h | 17 ++++++++++++++++-
>>>   arch/riscv/kernel/setup.c    |  2 ++
>>>   arch/riscv/kernel/smp.c      | 19 +++++++++++++++++++
>>>   3 files changed, 37 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
>>> index 36016845..0763337b 100644
>>> --- a/arch/riscv/include/asm/smp.h
>>> +++ b/arch/riscv/include/asm/smp.h
>>> @@ -22,6 +22,12 @@
>>>   #include <linux/cpumask.h>
>>>   #include <linux/irqreturn.h>
>>>
>>> +/*
>>> + * Mapping between linux logical cpu index and hartid.
>>> + */
>>> +extern u64 __cpu_logical_map[NR_CPUS];
>>> +#define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
>>> +
>>>   #ifdef CONFIG_SMP
>>>
>>>   /* SMP initialization hook for setup_arch */
>>> @@ -33,6 +39,8 @@ void arch_send_call_function_ipi_mask(struct cpumask
>>> *mask);
>>>   /* Hook for the generic smp_call_function_single() routine. */
>>>   void arch_send_call_function_single_ipi(int cpu);
>>>
>>> +int riscv_hartid_to_cpuid(int hartid);
>>> +void cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask
>>> *out);
>>>   /*
>>>    * This is particularly ugly: it appears we can't actually get the
>>> definition
>>>    * of task_struct here, but we need access to the CPU this task is
>>> running on.
>>> @@ -41,6 +49,13 @@ void arch_send_call_function_single_ipi(int cpu);
>>>    */
>>>   #define raw_smp_processor_id() (*((int*)((char*)get_current() +
>>> TASK_TI_CPU)))
>>>
>>> -#endif /* CONFIG_SMP */
>>> +#else
>>> +
>>> +static inline int riscv_hartid_to_cpuid(int hartid) { return 0 ; }
>>> +static inline void cpuid_to_hartid_mask(const struct cpumask *in,
>>> +                                      struct cpumask *out) {
>>> +       cpumask_set_cpu(cpu_logical_map(0), out);
>>> +}
>>>
>>> +#endif /* CONFIG_SMP */
>>>   #endif /* _ASM_RISCV_SMP_H */
>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>> index db20dc63..e21ed481 100644
>>> --- a/arch/riscv/kernel/setup.c
>>> +++ b/arch/riscv/kernel/setup.c
>>> @@ -82,6 +82,8 @@ EXPORT_SYMBOL(empty_zero_page);
>>>   /* The lucky hart to first increment this variable will boot the other
>>> cores */
>>>   atomic_t hart_lottery;
>>>
>>> +u64 __cpu_logical_map[NR_CPUS];
>>
>>
>> If hardware IDs are always machine word size then its better to use
>> "unsigned long" in-place of u64.
>>
>
> Good point. Thanks.
>
>> The __cpu_logical_map[] should be zero initially because zero is a
>> valid hardware ID. Better set all entries to -1 by assigning { -1 } to the
>> array.
>>
>
> ok. I will introduce INVALID_HART_ID (=-1) and initialize with that.
>
>> Also, I feel  __cpu_logical_map[] should be part of smp.c instead of
>> setup.c. Any particular reason for having it in setup.c?
>>
>
> currently smp.c is only compiled in if CONFIG_SMP. That's why I kept it in
> setup.c

Ahh, got it. For now let it be here till we figure better place for it.

Regards,
Anup
