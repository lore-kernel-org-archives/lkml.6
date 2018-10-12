Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D34C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B962087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B962087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeJLSlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:41:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49912 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbeJLSlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:41:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7098EED1;
        Fri, 12 Oct 2018 04:09:56 -0700 (PDT)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0AA63F5B7;
        Fri, 12 Oct 2018 04:09:53 -0700 (PDT)
Subject: Re: [PATCH V8 16/21] csky: SMP support
To:     Guo Ren <ren_guo@c-sky.com>, akpm@linux-foundation.org,
        arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, hch@infradead.org,
        mark.rutland@arm.com, peterz@infradead.org, robh@kernel.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        c-sky_gcc_upstream@c-sky.com
References: <cover.1539315390.git.ren_guo@c-sky.com>
 <608ece7942caa7c4b677b3cedd699e1a85b39d0f.1539315391.git.ren_guo@c-sky.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <50781e74-e19b-e0e0-8ce5-d906878e249d@arm.com>
Date:   Fri, 12 Oct 2018 12:09:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <608ece7942caa7c4b677b3cedd699e1a85b39d0f.1539315391.git.ren_guo@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 05:42, Guo Ren wrote:
> This patch adds boot, ipi, hotplug code for SMP.
> 
> Changelog:
>  - remove set_ipi_irq_mapping callback.
>  - Convert the cpumask to an interrupt-controller specific representation
>    in driver's code, and not the SMP code's.
>  - csky: remove irq_mapping from smp.c
>    There are some feedbacks from irqchip, and we need to adjust
>    "smp.c & smp.h" to match the csky_mp_intc modification.
>  - Move IPI_IRQ define into drivers/irqchip/csky_mpintc.c, because it's a
>    interrupt controller specific.
>  - Bugfix request_irq with IPI_IRQ, we must use irq_mapping return value
>    not directly use IPI_IRQ. The modification also involves csky_mp_intc.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/csky/include/asm/smp.h |  28 ++++++
>  arch/csky/kernel/smp.c      | 237 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 265 insertions(+)
>  create mode 100644 arch/csky/include/asm/smp.h
>  create mode 100644 arch/csky/kernel/smp.c
> 
> diff --git a/arch/csky/include/asm/smp.h b/arch/csky/include/asm/smp.h
> new file mode 100644
> index 0000000..31f7b94
> --- /dev/null
> +++ b/arch/csky/include/asm/smp.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_CSKY_SMP_H
> +#define __ASM_CSKY_SMP_H
> +
> +#include <linux/cpumask.h>
> +#include <linux/irqreturn.h>
> +#include <linux/threads.h>
> +
> +#ifdef CONFIG_SMP
> +
> +void __init setup_smp(void);
> +
> +void __init setup_smp_ipi(void);
> +
> +void __init enable_smp_ipi(void);
> +
> +void arch_send_call_function_ipi_mask(struct cpumask *mask);
> +
> +void arch_send_call_function_single_ipi(int cpu);
> +
> +void __init set_send_ipi(void (*func)(const struct cpumask *mask), int irq);
> +
> +#define raw_smp_processor_id()	(current_thread_info()->cpu)
> +
> +#endif /* CONFIG_SMP */
> +
> +#endif /* __ASM_CSKY_SMP_H */
> diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
> new file mode 100644
> index 0000000..5ea9516
> --- /dev/null
> +++ b/arch/csky/kernel/smp.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/notifier.h>
> +#include <linux/cpu.h>
> +#include <linux/percpu.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of.h>
> +#include <linux/sched/task_stack.h>
> +#include <linux/sched/mm.h>
> +#include <asm/irq.h>
> +#include <asm/traps.h>
> +#include <asm/sections.h>
> +#include <asm/mmu_context.h>
> +#include <asm/pgalloc.h>
> +
> +static struct {
> +	unsigned long bits ____cacheline_aligned;
> +} ipi_data[NR_CPUS] __cacheline_aligned;

Why isn't this a per-cpu variable?

> +
> +enum ipi_message_type {
> +	IPI_EMPTY,
> +	IPI_RESCHEDULE,
> +	IPI_CALL_FUNC,
> +	IPI_MAX
> +};
> +
> +static irqreturn_t handle_ipi(int irq, void *dev)
> +{
> +	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
> +
> +	while (true) {
> +		unsigned long ops;
> +
> +		ops = xchg(pending_ipis, 0);
> +		if (ops == 0)
> +			return IRQ_HANDLED;
> +
> +		if (ops & (1 << IPI_RESCHEDULE))
> +			scheduler_ipi();
> +
> +		if (ops & (1 << IPI_CALL_FUNC))
> +			generic_smp_call_function_interrupt();
> +
> +		BUG_ON((ops >> IPI_MAX) != 0);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void (*send_arch_ipi)(const struct cpumask *mask);
> +
> +static int ipi_irq;
> +void __init set_send_ipi(void (*func)(const struct cpumask *mask), int irq)
> +{
> +	if (send_arch_ipi)
> +		return;
> +
> +	send_arch_ipi = func;
> +	ipi_irq = irq;
> +}
> +
> +static void
> +send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
> +{
> +	int i;
> +
> +	for_each_cpu(i, to_whom)
> +		set_bit(operation, &ipi_data[i].bits);
> +
> +	smp_mb();
> +	send_arch_ipi(to_whom);
> +}
> +
> +void arch_send_call_function_ipi_mask(struct cpumask *mask)
> +{
> +	send_ipi_message(mask, IPI_CALL_FUNC);
> +}
> +
> +void arch_send_call_function_single_ipi(int cpu)
> +{
> +	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
> +}
> +
> +static void ipi_stop(void *unused)
> +{
> +	while (1);
> +}
> +
> +void smp_send_stop(void)
> +{
> +	on_each_cpu(ipi_stop, NULL, 1);
> +}
> +
> +void smp_send_reschedule(int cpu)
> +{
> +	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
> +}
> +
> +void *__cpu_up_stack_pointer[NR_CPUS];
> +void *__cpu_up_task_pointer[NR_CPUS];

Why aren't these per-cpu variables? More importantly, what are they used
for? None of the patches in this series are using them.

> +
> +void __init smp_prepare_boot_cpu(void)
> +{
> +}
> +
> +void __init smp_prepare_cpus(unsigned int max_cpus)
> +{
> +}
> +
> +void __init enable_smp_ipi(void)
> +{
> +	enable_percpu_irq(ipi_irq, 0);
> +}

Why isn't this function static?

> +
> +static int ipi_dummy_dev;
> +void __init setup_smp_ipi(void)
> +{
> +	int rc;
> +
> +	if (ipi_irq == 0)
> +		panic("%s IRQ mapping failed\n", __func__);
> +
> +	rc = request_percpu_irq(ipi_irq, handle_ipi, "IPI Interrupt",
> +				&ipi_dummy_dev);
> +	if (rc)
> +		panic("%s IRQ request failed\n", __func__);
> +
> +	enable_smp_ipi();
> +}
> +
> +void __init setup_smp(void)
> +{
> +	struct device_node *node = NULL;
> +	int cpu;
> +
> +	while ((node = of_find_node_by_type(node, "cpu"))) {
> +		if (!of_device_is_available(node))
> +			continue;
> +
> +		if (of_property_read_u32(node, "reg", &cpu))
> +			continue;
> +
> +		if (cpu >= NR_CPUS)
> +			continue;
> +
> +		set_cpu_possible(cpu, true);
> +		set_cpu_present(cpu, true);
> +	}
> +}
> +
> +extern void _start_smp_secondary(void);
> +
> +volatile unsigned int secondary_hint;
> +volatile unsigned int secondary_ccr;
> +volatile unsigned int secondary_stack;

This looks pretty dodgy. Shouldn't you be using READ_ONCE/WRITE_ONCE
instead?

> +
> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> +{
> +	unsigned int tmp;
> +
> +	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE;
> +
> +	secondary_hint = mfcr("cr31");
> +
> +	secondary_ccr  = mfcr("cr18");> +
> +	/* Flush dcache */
> +	mtcr("cr17", 0x22);
> +
> +	/* Enable cpu in SMP reset ctrl reg */
> +	tmp = mfcr("cr<29, 0>");
> +	tmp |= 1 << cpu;
> +	mtcr("cr<29, 0>", tmp);
> +
> +	/* Wait for the cpu online */
> +	while (!cpu_online(cpu));
> +
> +	secondary_stack = 0;
> +
> +	return 0;
> +}
> +
> +void __init smp_cpus_done(unsigned int max_cpus)
> +{
> +}
> +
> +int setup_profiling_timer(unsigned int multiplier)
> +{
> +	return -EINVAL;
> +}
> +
> +void csky_start_secondary(void)
> +{
> +	struct mm_struct *mm = &init_mm;
> +	unsigned int cpu = smp_processor_id();
> +
> +	mtcr("cr31", secondary_hint);
> +	mtcr("cr18", secondary_ccr);
> +
> +	mtcr("vbr", vec_base);
> +
> +	flush_tlb_all();
> +	write_mmu_pagemask(0);
> +	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);
> +	TLBMISS_HANDLER_SETUP_PGD_KERNEL(swapper_pg_dir);
> +
> +	asid_cache(smp_processor_id()) = ASID_FIRST_VERSION;
> +
> +#ifdef CONFIG_CPU_HAS_FPU
> +	init_fpu();
> +#endif
> +
> +	enable_smp_ipi();
> +
> +	mmget(mm);
> +	mmgrab(mm);
> +	current->active_mm = mm;
> +	cpumask_set_cpu(cpu, mm_cpumask(mm));
> +
> +	notify_cpu_starting(cpu);
> +	set_cpu_online(cpu, true);
> +
> +	pr_info("CPU%u Online: %s...\n", cpu, __func__);
> +
> +	local_irq_enable();
> +	preempt_disable();
> +	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
> +}
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
