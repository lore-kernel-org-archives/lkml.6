Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107DFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BC82147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lB8xlvR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BC82147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbeHPIgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 04:36:43 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22912 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbeHPIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 04:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534398047; x=1565934047;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RUIDp4CNrX36kR9Y9ZfiQpg5Vkue60Z8ldzrpnnGC4w=;
  b=lB8xlvR9gyLoCwspKMn3wtSfmZueVISNdqV3aMOR9as9H+Y+HghfKdDy
   2BPxB/lxhapoAsI8xKAG4nctIbpyABzcF1C7yjREp+4ZdTqfYIE4gAcuz
   RkVS2aiItbSI1Y1+BvyHU1k77hN8AS723zIiGAwTLjQp/jy3QHJkTyVqN
   MfZB5IZ6a62J5EQHAwHHF2QBoDT+IpDTnPg0Rx3rkqd78KfA7XbMVWGe5
   wVfv2tNWHUwisLmPd/DV6bHgBDKHy6+OsjUGy69Ne8ZJ9aJf3g5mv899D
   2nUICdebRs2XaQtBCpGG6M9x2hDS72SWTxytQf/Woi2ZJRcl9lieggQqJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,246,1531756800"; 
   d="scan'208";a="89192581"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2018 13:40:47 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 15 Aug 2018 22:28:09 -0700
Received: from 570dpc2.ad.shared (HELO [10.86.59.225]) ([10.86.59.225])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2018 22:40:46 -0700
Subject: Re: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
To:     Anup Patel <anup@brainfault.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
 <1534377377-70108-4-git-send-email-atish.patra@wdc.com>
 <CAAhSdy2TeNfjdzWPHtCwrorBu8c9v-u9Ro-eGMbzSwzapfwdjw@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <ce39a215-3bb1-d866-0d84-76642acb70bc@wdc.com>
Date:   Wed, 15 Aug 2018 22:40:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy2TeNfjdzWPHtCwrorBu8c9v-u9Ro-eGMbzSwzapfwdjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/18 10:02 PM, Anup Patel wrote:
> On Thu, Aug 16, 2018 at 5:26 AM, Atish Patra <atish.patra@wdc.com> wrote:
>> Defining cpu_operations now helps adding cpu hotplug
>> support in proper manner. Moreover, it provides flexibility
>> in supporting other cpu enable/boot methods can be
>> supported in future. This patch has been largely inspired from
>> ARM64. However, a default boot method is defined for RISC-V unlike
>> ARM64.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/include/asm/smp.h | 10 ++++++++++
>>   arch/riscv/kernel/smp.c      |  8 ++++++++
>>   arch/riscv/kernel/smpboot.c  | 34 ++++++++++++++++++++++++++++------
>>   3 files changed, 46 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
>> index 0763337b..2bb6e6c2 100644
>> --- a/arch/riscv/include/asm/smp.h
>> +++ b/arch/riscv/include/asm/smp.h
>> @@ -28,6 +28,15 @@
>>   extern u64 __cpu_logical_map[NR_CPUS];
>>   #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
>>
>> +struct cpu_operations {
>> +       const char      *name;
>> +       int             (*cpu_init)(unsigned int);
>> +       int             (*cpu_prepare)(unsigned int);
>> +       int             (*cpu_boot)(unsigned int, struct task_struct *);
>> +};
>> +extern struct cpu_operations cpu_ops;
>> +void smp_set_cpu_ops(const struct cpu_operations *cpu_ops);
>> +
>>   #ifdef CONFIG_SMP
>>
>>   /* SMP initialization hook for setup_arch */
>> @@ -57,5 +66,6 @@ static inline void cpuid_to_hartid_mask(const struct cpumask *in,
>>          cpumask_set_cpu(cpu_logical_map(0), out);
>>   }
>>
>> +
>>   #endif /* CONFIG_SMP */
>>   #endif /* _ASM_RISCV_SMP_H */
>> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
>> index 4ab70480..5de58ced 100644
>> --- a/arch/riscv/kernel/smp.c
>> +++ b/arch/riscv/kernel/smp.c
>> @@ -58,6 +58,14 @@ void cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
>>          for_each_cpu(cpu, in)
>>                  cpumask_set_cpu(cpu_logical_map(cpu), out);
>>   }
>> +struct cpu_operations cpu_ops __ro_after_init;
>> +
>> +void smp_set_cpu_ops(const struct cpu_operations *ops)
>> +{
>> +       if (ops)
>> +               cpu_ops = *ops;
>> +}
>> +
> 
> Move both cpu_ops and smp_set_cpu_ops() to smpboot.c. This way
> you will not require to make cpu_ops as global.
> 
ok.

> Further, I think cpu_ops should be a pointer and initial value should
> be &default_ops.
> 
> Something like this:
> struct cpu_operations *cpu_ops __ro_after_init = &default_ops;
> 

That will work too. However, setting it through smp_set_cpu_ops provides 
a sample implementation for any future SMP enable methods. That's why I 
used the API. I can change it if you think otherwise.


>>   /* Unsupported */
>>   int setup_profiling_timer(unsigned int multiplier)
>>   {
>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>> index 6ab2bb1b..045a1a45 100644
>> --- a/arch/riscv/kernel/smpboot.c
>> +++ b/arch/riscv/kernel/smpboot.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/irq.h>
>>   #include <linux/of.h>
>>   #include <linux/sched/task_stack.h>
>> +#include <linux/smp.h>
>>   #include <asm/irq.h>
>>   #include <asm/mmu_context.h>
>>   #include <asm/tlbflush.h>
>> @@ -38,6 +39,7 @@
>>
>>   void *__cpu_up_stack_pointer[NR_CPUS];
>>   void *__cpu_up_task_pointer[NR_CPUS];
>> +struct cpu_operations default_ops;
>>
>>   void __init smp_prepare_boot_cpu(void)
>>   {
>> @@ -53,6 +55,7 @@ void __init setup_smp(void)
>>          int hart, found_boot_cpu = 0;
>>          int cpuid = 1;
>>
>> +       smp_set_cpu_ops(&default_ops);
>>          while ((dn = of_find_node_by_type(dn, "cpu"))) {
>>                  hart = riscv_of_processor_hart(dn);
>>
>> @@ -73,10 +76,8 @@ void __init setup_smp(void)
>>          BUG_ON(!found_boot_cpu);
>>   }
>>
>> -int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>> +int default_cpu_boot(unsigned int hartid, struct task_struct *tidle)
>>   {
>> -       int hartid = cpu_logical_map(cpu);
>> -       tidle->thread_info.cpu = cpu;
>>          /*
>>           * On RISC-V systems, all harts boot on their own accord.  Our _start
>>           * selects the first hart to boot the kernel and causes the remainder
>> @@ -84,13 +85,28 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>>           * setup by that main hart.  Writing __cpu_up_stack_pointer signals to
>>           * the spinning harts that they can continue the boot process.
>>           */
>> -       smp_mb();
>> +
>>          __cpu_up_stack_pointer[hartid] = task_stack_page(tidle) + THREAD_SIZE;
>>          __cpu_up_task_pointer[hartid] = tidle;
>> +       return 0;
>> +}
>> +
>> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>> +{
>> +       int err = -1;
>> +       int hartid = cpu_logical_map(cpu);
>>
>> -       while (!cpu_online(cpu))
>> -               cpu_relax();
>> +       tidle->thread_info.cpu = cpu;
>> +       smp_mb();
>>
>> +       if (cpu_ops.cpu_boot)
>> +               err = cpu_ops.cpu_boot(hartid, tidle);
>> +       if (!err) {
>> +               while (!cpu_online(cpu))
>> +                       cpu_relax();
>> +       } else {
>> +               pr_err("CPU %d [hartid %d]failed to boot\n", cpu, hartid);
>> +       }
>>          return 0;
>>   }
>>
>> @@ -117,3 +133,9 @@ asmlinkage void __init smp_callin(void)
>>          preempt_disable();
>>          cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
>>   }
>> +
>> +
>> +struct cpu_operations default_ops = {
>> +       .name           = "default",
>> +       .cpu_boot       = default_cpu_boot,
>> +};
> 
> I think having dedicated source file for default_ops makes more sense
> so that we have a clear/simple reference implementation of cpu_operations.
> 
> Eventually, we might have one source file for each type of SMP enable
> method.
> 
> Try to keep smpboot.c generic and independent of any cpu_operations.
> What say?
> 

Any other SMP enable method should definitely get its own file. I am not 
sure about the default one though. As default_ops is truly the default 
booting method which will always be present in absence of anything else, 
I thought keeping it smpboot.c emphasizes that point. Moreover, it's not 
that big even. But I am open to moving to it's own source file if you 
strongly think we should do that.


Regards,
Atish
> Regards,
> Anup
> 

