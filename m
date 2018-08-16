Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8CCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8601C2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="y0iTB48b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8601C2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbeHPIl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 04:41:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35324 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeHPIl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 04:41:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so3173462wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 22:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T+CTIR2/Nce4voMoZIjaH6Gk4PGxGwUtca+SnEHFmcM=;
        b=y0iTB48bERF0rPi4aDVfHcqSypI7FDC1hxh5DwjMl5OS/YLPiviyyJ9r6l2NLg0QAr
         aEx4gKXBe4DV6rXkogfXHEGzClaqmtMAiq0t5lHGwOJksTzY/HxmFqfnrETIqs0WlVyn
         YWDk3D6YK4Cx0zMp3kSq729Yux0BAlnByfcFm0hPD5W+2esh7LQI95U4fSjOlshK8eND
         ytO3DBvIqg0UWHeXei+gUztU4Y/NUNa677w+GtojkEXTthcIcw+kWxa+ERGkKj9uS6YE
         zbAoCr0FPPSdXccv+1LHAjBs2Vdj/Vk0LGU7fwxq8Y/MdOnUts3vbEd5cJSBxrxe+TwT
         YAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T+CTIR2/Nce4voMoZIjaH6Gk4PGxGwUtca+SnEHFmcM=;
        b=X/exzvi2gVh8Q1wIWkUypqPgBaKbACRY3aWvyNcsK3kWpDDKCD+TF45FU3nqs9QsEE
         u0MtdhqQ+o6r4Rrug5yErAWqw+qBH/tez+h3AzxvE8rqzLp0z/YELMpyVjIgTfPz39gP
         OcwEFNOVJHpncxcLvMA9+7NcS7+0VT6xhPFmnis3vo2wFsU9adnpyJu8VTA4VFy1MYs4
         x1mV0UgzkLty5PSptZ3uoyxv/O1D24Yeanjc56Sx4aIfYbPVpSKqa4DlX4CZrYLLKmsH
         UmOc0HmSt+SLF2AADh1/79sThNZ6PG2jKM8EKJ9WCpl58BtP5/GrkFGQkajgI1v4AH7B
         moWg==
X-Gm-Message-State: AOUpUlFB+SkSMhya1vgQqHZ5LDMq3bwOFZW2pVmchT+nTpwKOcWG8VYd
        bnqzYcZJ3+BauOdeg5J1CVWTksEceZIhVKYR6kCm8A==
X-Google-Smtp-Source: AA+uWPzumfY+Sd/WJjq8wKZgenWyKvUqvNyeoY8/N0hcsaAd3u6czErui7YW7HHBgL/irvWJ8Ea0hQyMhKrWlGr+T70=
X-Received: by 2002:a1c:1d2:: with SMTP id 201-v6mr14193753wmb.4.1534398328019;
 Wed, 15 Aug 2018 22:45:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dd2:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 22:45:27
 -0700 (PDT)
In-Reply-To: <adf9579e-62e1-e778-10f0-5e55c5b48406@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-3-git-send-email-atish.patra@wdc.com> <CAAhSdy0O7qid67J2pvyc3sFHsOPA-PFpiSKrHBB1tRDb678bAQ@mail.gmail.com>
 <adf9579e-62e1-e778-10f0-5e55c5b48406@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Aug 2018 11:15:27 +0530
Message-ID: <CAAhSdy2WXSeg7eWM0Jj7bN6KN6KC+WHqetZTSx4ATrfEcRk6Bg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] RISC-V: Use Linux logical cpu number instead of hartid
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

On Thu, Aug 16, 2018 at 10:53 AM, Atish Patra <atish.patra@wdc.com> wrote:
> On 8/15/18 9:24 PM, Anup Patel wrote:
>>
>> On Thu, Aug 16, 2018 at 5:26 AM, Atish Patra <atish.patra@wdc.com> wrote:
>>>
>>> Setup the cpu_logical_map during boot. Moreover, every SBI call
>>> and PLIC context are based on the physical hartid. Use the logical
>>> cpu to hartid mapping to pass correct hartid to respective functions.
>>>
>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>> ---
>>>   arch/riscv/include/asm/tlbflush.h | 17 +++++++++++++----
>>>   arch/riscv/kernel/cpu.c           |  4 +++-
>>>   arch/riscv/kernel/setup.c         | 10 ++++++++++
>>>   arch/riscv/kernel/smp.c           | 24 +++++++++++++++---------
>>>   arch/riscv/kernel/smpboot.c       | 30 ++++++++++++++++++------------
>>>   drivers/clocksource/riscv_timer.c | 12 ++++++++----
>>>   drivers/irqchip/irq-sifive-plic.c | 11 +++++++----
>>>   7 files changed, 74 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/tlbflush.h
>>> b/arch/riscv/include/asm/tlbflush.h
>>> index 85c2d8ba..ecfd9b0e 100644
>>> --- a/arch/riscv/include/asm/tlbflush.h
>>> +++ b/arch/riscv/include/asm/tlbflush.h
>>> @@ -16,6 +16,7 @@
>>>   #define _ASM_RISCV_TLBFLUSH_H
>>>
>>>   #include <linux/mm_types.h>
>>> +#include <asm/smp.h>
>>>
>>>   /*
>>>    * Flush entire local TLB.  'sfence.vma' implicitly fences with the
>>> instruction
>>> @@ -49,13 +50,21 @@ static inline void flush_tlb_range(struct
>>> vm_area_struct *vma,
>>>
>>>   #include <asm/sbi.h>
>>>
>>> -#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
>>> +static inline void remote_sfence_vma(struct cpumask *cmask, unsigned
>>> long start,
>>> +                                    unsigned long size)
>>> +{
>>> +       struct cpumask hmask;
>>> +
>>> +       cpuid_to_hartid_mask(cmask, &hmask);
>>> +       sbi_remote_sfence_vma(hmask.bits, start, size);
>>> +}
>>> +
>>> +#define flush_tlb_all() remote_sfence_vma(NULL, 0, -1)
>>>   #define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
>>>   #define flush_tlb_range(vma, start, end) \
>>> -       sbi_remote_sfence_vma(mm_cpumask((vma)->vm_mm)->bits, \
>>> -                             start, (end) - (start))
>>> +       remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) -
>>> (start))
>>>   #define flush_tlb_mm(mm) \
>>> -       sbi_remote_sfence_vma(mm_cpumask(mm)->bits, 0, -1)
>>> +       remote_sfence_vma(mm_cpumask(mm), 0, -1)
>>>
>>>   #endif /* CONFIG_SMP */
>>>
>>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>>> index ca6c81e5..f8a18ace 100644
>>> --- a/arch/riscv/kernel/cpu.c
>>> +++ b/arch/riscv/kernel/cpu.c
>>> @@ -14,6 +14,7 @@
>>>   #include <linux/init.h>
>>>   #include <linux/seq_file.h>
>>>   #include <linux/of.h>
>>> +#include <asm/smp.h>
>>>
>>>   /* Return -1 if not a valid hart */
>>>   int riscv_of_processor_hart(struct device_node *node)
>>> @@ -79,7 +80,8 @@ static void c_stop(struct seq_file *m, void *v)
>>>   static int c_show(struct seq_file *m, void *v)
>>>   {
>>>          unsigned long hart_id = (unsigned long)v - 1;
>>> -       struct device_node *node = of_get_cpu_node(hart_id, NULL);
>>> +       struct device_node *node =
>>> of_get_cpu_node(cpu_logical_map(hart_id),
>>> +                                                  NULL);
>>
>>
>> The hart_id is misleading name here. It should be cpu_id. Please replace
>> all instances of hart_id with cpu_id and where hard ID is to be displayed
>> use cpu_logical_map(cpu_id).
>>
> Correct. Thanks for catching it. I will fix it in v2.
>
>
>>>          const char *compat, *isa, *mmu;
>>>
>>>          seq_printf(m, "hart\t: %lu\n", hart_id);
>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>> index e21ed481..97b586f8 100644
>>> --- a/arch/riscv/kernel/setup.c
>>> +++ b/arch/riscv/kernel/setup.c
>>> @@ -84,6 +84,16 @@ atomic_t hart_lottery;
>>>
>>>   u64 __cpu_logical_map[NR_CPUS];
>>>
>>> +void __init smp_setup_processor_id(void)
>>> +{
>>> +       int cpu = smp_processor_id();
>>> +
>>> +       cpu_logical_map(0) = cpu;
>>
>>
>> I think this should be:
>> cpu_logical_map(cpu) = hart_id;
>>
>> Here hart_id for boot CPU will be value of a0 register passed at
>> boot-time.
>>
> I will change the variable name to hart_id. The assembly code in head.S have
> already stored hart id in thread info structure. So smp_processor_id() and
> hart id would be the same.
>
>

I guess this means that for boot CPU, cpuid == hartid

This is very confusing because other places I see CPU0 is the boot CPU.

I think assembly code in head.S should store 0 in thread info for boot CPU.

Regards,
Anup
