Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1550BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BAF208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BAF208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeLMLX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:23:28 -0500
Received: from foss.arm.com ([217.140.101.70]:59536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbeLMLX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:23:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38A0BA78;
        Thu, 13 Dec 2018 03:23:27 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBC853F575;
        Thu, 13 Dec 2018 03:23:24 -0800 (PST)
Subject: Re: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@armm.com" <catalin.marinas@armm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-2-kys@linuxonhyperv.com>
 <39e47e32-2738-e39a-4ddb-9d27d2513beb@arm.com>
 <CY4PR21MB0773002BFD385052A830A979D7A70@CY4PR21MB0773.namprd21.prod.outlook.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <e0374a07-809c-cabd-2eb6-e6b5ad84742e@arm.com>
Date:   Thu, 13 Dec 2018 11:23:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CY4PR21MB0773002BFD385052A830A979D7A70@CY4PR21MB0773.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 12/12/2018 05:00, Michael Kelley wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>  Sent: Friday, December 7, 2018 6:43 AM
> 
>>> Add ARM64-specific code to enable Hyper-V. This code includes:
>>> * Detecting Hyper-V and initializing the guest/Hyper-V interface
>>> * Setting up Hyper-V's synthetic clocks
>>> * Making hypercalls using the HVC instruction
>>> * Setting up VMbus and stimer0 interrupts
>>> * Setting up kexec and crash handlers
>>
>> This commit message is a clear indication that this should be split in
>> at least 5 different patches.
> 
> OK, I'll work on separating into multiple layered patches in the next
> version.

Thanks. This will definitely help the review process.

>>> +/*
>>> + * This variant of HVC invocation is for hv_get_vpreg and
>>> + * hv_get_vpreg_128. The input parameters are passed in registers
>>> + * along with a pointer in x4 to where the output result should
>>> + * be stored. The output is returned in x15 and x16.  x18 is used as
>>> + * scratch space to avoid buildng a stack frame, as Hyper-V does
>>> + * not preserve registers x0-x17.
>>> + */
>>> +ENTRY(hv_do_hvc_fast_get)
>>> +	mov x18, x4
>>> +	hvc #1
>>> +	str x15,[x18]
>>> +	str x16,[x18,#8]
>>> +	ret
>>> +ENDPROC(hv_do_hvc_fast_get)
>>
>> As Will said, this isn't a viable option. Please follow SMCCC 1.1.
> 
> I'll have to start a conversation with the Hyper-V team about this.
> I don't know why they chose to use HVC #1 or this register scheme
> for output values.  It may be tough to change at this point because
> there are Windows guests on Hyper-V for ARM64 that are already
> using this approach.

I appreciate you already have stuff in the wild, but there is definitely
a case to be made for supporting architecturally specified mechanisms in
a hypervisor, and SMCCC is definitely part of it (I'm certainly curious
of how you support the Spectre mitigation otherwise).

> 
>>
>>> diff --git a/arch/arm64/hyperv/hv_init.c b/arch/arm64/hyperv/hv_init.c
>>> new file mode 100644
>>> index 000000000000..aa1a8c09d989
>>> --- /dev/null
>>> +++ b/arch/arm64/hyperv/hv_init.c
>>> @@ -0,0 +1,441 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +/*
>>> + * Initialization of the interface with Microsoft's Hyper-V hypervisor,
>>> + * and various low level utility routines for interacting with Hyper-V.
>>> + *
>>> + * Copyright (C) 2018, Microsoft, Inc.
>>> + *
>>> + * Author : Michael Kelley <mikelley@microsoft.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it
>>> + * under the terms of the GNU General Public License version 2 as published
>>> + * by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
>>> + * NON INFRINGEMENT.  See the GNU General Public License for more
>>> + * details.
>>> + */
>>> +
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/version.h>
>>> +#include <linux/export.h>
>>> +#include <linux/vmalloc.h>
>>> +#include <linux/mm.h>
>>> +#include <linux/clocksource.h>
>>> +#include <linux/sched_clock.h>
>>> +#include <linux/acpi.h>
>>> +#include <linux/module.h>
>>> +#include <linux/hyperv.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/cpuhotplug.h>
>>> +#include <linux/psci.h>
>>> +#include <asm-generic/bug.h>
>>> +#include <asm/hypervisor.h>
>>> +#include <asm/hyperv-tlfs.h>
>>> +#include <asm/mshyperv.h>
>>> +#include <asm/sysreg.h>
>>> +#include <clocksource/arm_arch_timer.h>
>>> +
>>> +static bool	hyperv_initialized;
>>> +struct		ms_hyperv_info ms_hyperv;
>>> +EXPORT_SYMBOL_GPL(ms_hyperv);
>>
>> Who are the users of this structure? Should they go via accessors instead?
> 
> The structure is an aggregation of several flags fields that describe a myriad
> of features and hints that may or may not be present on any particular version
> of Hyper-V, plus the max virtual processor ID values.  Everything is read-only
> after initialization.   

nit: please consider using a __ro_after_init annotation in that case.

> Most of the references are to test one of the flags.  It's
> a judgment call, but there are a lot of different flags with long names, and
> writing accessors for each one doesn't seem to me to add any clarity.

Looking at that structure, it doesn't seem so bad, and you could easily
have generic accessors that take a flag as a parameter. Your call.

[...]

>>> +static struct clocksource hyperv_cs_msr = {
>>> +	.name		= "hyperv_clocksource_msr",
>>> +	.rating		= 400,
>>> +	.read		= read_hv_clock_msr,
>>> +	.mask		= CLOCKSOURCE_MASK(64),
>>> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>>> +};
>>> +
>>> +struct clocksource *hyperv_cs;
>>> +EXPORT_SYMBOL_GPL(hyperv_cs);
>>
>> Why? Who needs to poke this?
> 
> It's referenced in the architecture independent driver code
> for the Hyper-V clocksource in drivers/hv/hv.c, and in the
> code to sync the time with the Hyper-V host in
> drivers/hv/hv_util.c.

Fair enough.

>>> +static int hv_cpu_init(unsigned int cpu)
>>> +{
>>> +	u64 msr_vp_index;
>>> +
>>> +	hv_get_vp_index(msr_vp_index);
>>> +
>>> +	hv_vp_index[smp_processor_id()] = msr_vp_index;
>>> +
>>> +	if (msr_vp_index > hv_max_vp_index)
>>> +		hv_max_vp_index = msr_vp_index;
>>> +
>>> +	return 0;
>>> +}
>>
>> Is that some new way to describe a CPU topology? If so, why isn't that
>> exposed via the ACPI tables that the kernel already parses?
> 
> Hyper-V's hypercall interface uses vCPU identifiers that are not
> guaranteed to be consecutive integers or to match what ACPI shows.
> No topology information is implied -- it's just unique identifiers.  The 
> hv_vp_index array provides easy mapping from Linux's consecutive
> integer IDs for CPUs when needed to construct hypercall arguments.

That's extremely odd. The hypervisor obviously knows which vCPU is doing
a hypercall, and if referencing another vCPU, the virtualized MPIDR_EL1
value should be used. I don't think deviating from the architecture is a
good idea (but I appreciate this is none of your doing). Following the
architecture would allow this code to directly use the cpu_logical_map
infrastructure we alreadu have.

> 
>>
>>> +
>>> +/*
>>> + * This function is invoked via the ACPI clocksource probe mechanism. We
>>> + * don't actually use any values from the ACPI GTDT table, but we set up
>>
>> This doesn't feel like a good idea at all. Piggy-backing on an existing
>> mechanism and use it for something completely different is not exactly
>> future-proof.
>>
>> Also, if this is supposed to be a clocksource, why isn't that a
>> clocksource driver on its own right?
> 
> I agree this is not the right long term solution.  Is there a better place to
> hang the initialization code?  Or should I just make an explicit call to
> initialize Hyper-V at the right place?  On the x86 side, there's an
> explicit framework for hypervisor-specific initialization routines to plug
> into.  Maybe it's time for a basic version of such a framework on the
> ARM64 side.  Thoughts on the best approach, both in the short-term and
> the longer-term? If we put a framework in place, does that need to
> happen before adding Hyper-V code, or afterwards as a cleanup?

If we're introducing an infrastructure, doing it before introducing more
stuff seems to be the logical option. But I'm not sure we really need
such an infrastructure in this case, unless we need to enforce some
specific ordering.

You could start by moving all the clocksource stuff to
drivers/clocksource and keep the same init mechanism for the time being.

> 
> And yes, Hyper-V does effectively have its own clocksource.  The
> main code is in drivers/hv/hv.c, but it's not broken out as a separate
> driver in drivers/clocksource, probably due to some history on the
> x86 side that pre-dates me.  I'll have to research.

OK.

> 
>>
>>> + * the Hyper-V synthetic clocksource and do other initialization for
>>> + * interacting with Hyper-V the first time.  Using early_initcall to invoke
>>> + * this function is too late because interrupts are already enabled at that
>>> + * point, and sched_clock_register must run before interrupts are enabled.
>>> + *
>>> + * 1. Setup the guest ID.
>>> + * 2. Get features and hints info from Hyper-V
>>> + * 3. Setup per-cpu VP indices.
>>> + * 4. Register Hyper-V specific clocksource.
>>> + * 5. Register the scheduler clock.
>>> + */
>>> +
>>> +static int __init hyperv_init(struct acpi_table_header *table)
>>> +{
>>> +	struct hv_get_vp_register_output result;
>>> +	u32	a, b, c, d;
>>> +	u64	guest_id;
>>> +	int	i;
>>> +
>>> +	/*
>>> +	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
>>> +	 * have the string "MsHyperV".
>>> +	 */
>>> +	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
>>> +		return 1;
>>> +
>>> +	/* Setup the guest ID */
>>> +	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
>>> +	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
>>> +
>>> +	/* Get the features and hints from Hyper-V */
>>> +	hv_get_vpreg_128(HV_REGISTER_PRIVILEGES_AND_FEATURES, &result);
>>> +	ms_hyperv.features = lower_32_bits(result.registervaluelow);
>>> +	ms_hyperv.misc_features = upper_32_bits(result.registervaluehigh);
>>> +
>>> +	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
>>> +	ms_hyperv.hints = lower_32_bits(result.registervaluelow);
>>> +
>>> +	pr_info("Hyper-V: Features 0x%x, hints 0x%x\n",
>>> +		ms_hyperv.features, ms_hyperv.hints);
>>> +
>>> +	/*
>>> +	 * Direct mode is the only option for STIMERs provided Hyper-V
>>> +	 * on ARM64, so Hyper-V doesn't actually set the flag.  But add the
>>> +	 * flag so the architecture independent code in drivers/hv/hv.c
>>> +	 * will correctly use that mode.
>>> +	 */
>>> +	ms_hyperv.misc_features |= HV_STIMER_DIRECT_MODE_AVAILABLE;
>>> +
>>> +	/*
>>> +	 * Hyper-V on ARM64 doesn't support AutoEOI.  Add the hint
>>> +	 * that tells architecture independent code not to use this
>>> +	 * feature.
>>> +	 */
>>> +	ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
>>> +
>>> +	/* Get information about the Hyper-V host version */
>>> +	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
>>> +	a = lower_32_bits(result.registervaluelow);
>>> +	b = upper_32_bits(result.registervaluelow);
>>> +	c = lower_32_bits(result.registervaluehigh);
>>> +	d = upper_32_bits(result.registervaluehigh);
>>> +	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
>>> +		b >> 16, b & 0xFFFF, a, d & 0xFFFFFF, c, d >> 24);
>>> +
>>> +	/* Allocate percpu VP index */
>>> +	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
>>> +				    GFP_KERNEL);
>>
>> Why isn't this a percpu variable?
> 
> In current code in the architecture independent Hyper-V drivers (as well
> as some future Hyper-V enlightenments that aren't yet implemented
> for ARM64), the running CPU needs to get the VP index values for any CPUs
> in the hv_vp_index array.  Some of the code is performance sensitive, and
> accessing a global array is faster than accessing other CPUs' per-cpu data.

Fair enough. But his seems to tie into the above discussion about the
use of MPIDR_EL1 and the logical CPU mapping.

[...]

>>> +free_vp_index:
>>> +	kfree(hv_vp_index);
>>> +	hv_vp_index = NULL;
>>> +	return 1;
>>
>> ????
> 
> The return value is there because this function is implemented as a timer
> initialization function, and that's what the function signature requires.
> But maybe I'm not understanding your question.

I'm slightly miffed by the "return 1". I'd expect explicit negative
return codes that describe the error.

[...]

>>> +	vmbus_irq = acpi_register_gsi(NULL, HYPERVISOR_CALLBACK_VECTOR,
>>> +				 ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
>>> +	if (vmbus_irq <= 0) {
>>> +		pr_err("Can't register Hyper-V VMBus GSI. Error %d",
>>> +			vmbus_irq);
>>> +		vmbus_irq = 0;
>>> +		return;
>>> +	}
>>> +	vmbus_evt = alloc_percpu(long);
>>> +	result = request_percpu_irq(vmbus_irq, hyperv_vector_handler,
>>> +			"Hyper-V VMbus", vmbus_evt);
>>
>> If this is a per-cpu interrupt, why isn't it signalled as a PPI, in an
>> architecture compliant way?
> 
> Except for the code in this module, the interrupt handler for VMbus
> interrupts is architecture independent.  But there's no support for
> per-process interrupts on the x86, so the hypervisor interrupt vectors
> are hard coded in the same IDT entry across all processors, and the
> normal IRQ allocation mechanism is bypassed.  The above approach
> assigns an ARM64 PPI (HYPERVISOR_CALLBACK_VECTOR is 16) in a
> way that works with the arch independent interrupt handler.
> 
> Or maybe I'm missing your point.  If so, please set me straight.

Sorry, I missed that HYPERVISOR_CALLBACK_VECTOR was a PPI. It looks OK now.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
