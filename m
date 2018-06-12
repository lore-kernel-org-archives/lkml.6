Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 31893C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECA7208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fRTfLwi4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ndOAAiMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECA7208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934751AbeFLUlg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:41:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933625AbeFLUle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:41:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 668456089E; Tue, 12 Jun 2018 20:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528836094;
        bh=Jbm7d5GuJu/ZFMZDGSg92LalanTqpko0H8rW2JClnk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fRTfLwi4NqoIwOdim+3Ug3rtHjrmC3gq2OMtbKdpLTSVzIgqHivQ32oAEf/f3vEh6
         WQF/roYOY6wLeAImux7QiwJ5nkOuibPlz5PKk7Tz6QXYJc46BHOUomJzhhoFodW2au
         Vxk5IjVx8BPsAer8k/J9kA7X0U5NwA9woCtm/gj8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7518860850;
        Tue, 12 Jun 2018 20:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528836092;
        bh=Jbm7d5GuJu/ZFMZDGSg92LalanTqpko0H8rW2JClnk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ndOAAiMz5oh4enRfMe2fmy1lqJgg7q3gDzjB7zJa/QQtnTN+PPUXTTZ0qfEkZKjT9
         D7xWt4aVm1JvP00HyR012H/rlhf3swVC0jKQbBRp6LvmqVU3bonZ87Jp0kN3yR6AzP
         XmxbO2s1m/cBewBm90ljjNlNhKbc5nPnrmnWcl04=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 12 Jun 2018 16:41:32 -0400
From:   Agustin Vega-Frias <agustinv@codeaurora.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        timur@codeaurora.org
Subject: Re: [RFC V2 3/3] perf: qcom: Add Falkor CPU PMU IMPLEMENTATION
 DEFINED event support
In-Reply-To: <20180612144055.m2h26n64spfm6k6o@lakrids.cambridge.arm.com>
References: <1528379808-27970-1-git-send-email-agustinv@codeaurora.org>
 <1528379808-27970-4-git-send-email-agustinv@codeaurora.org>
 <20180612144055.m2h26n64spfm6k6o@lakrids.cambridge.arm.com>
Message-ID: <9957219b64252d3b2e19724db04a1179@codeaurora.org>
X-Sender: agustinv@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2018-06-12 10:40, Mark Rutland wrote:
> Hi,
> 
> On Thu, Jun 07, 2018 at 09:56:48AM -0400, Agustin Vega-Frias wrote:
>> Selection of these events can be envisioned as indexing them from
>> a 3D matrix:
>> - the first index selects a Region Event Selection Register 
>> (PMRESRx_EL0)
>> - the second index selects a group from which only one event at a time
>>   can be selected
>> - the third index selects the event
>> 
>> The event is encoded into perf_event_attr.config as 0xPRCCG, where:
>>   P  [config:16   ] = prefix   (flag that indicates a matrix-based 
>> event)
>>   R  [config:12-15] = register (specifies the PMRESRx_EL0 instance)
>>   G  [config:0-3  ] = group    (specifies the event group)
>>   CC [config:4-11 ] = code     (specifies the event)
>> 
>> Events with the P flag set to zero are treated as common PMUv3 events
>> and are directly programmed into PMXEVTYPERx_EL0.
>> 
>> The first two indexes are set combining the RESR and group number with
>> a base number and writing it into the architected PMXEVTYPER_EL0 
>> register.
>> The third index is set by writing the code into the bits corresponding
>> with the group into the appropriate IMPLEMENTATION DEFINED PMRESRx_EL0
>> register.
> 
> When are the IMP DEF registers accessible at EL0? Are those goverend by
> the same controls as the architected registers?

No, there is a separate IMP DEF register to control access.

> 
> [...]
> 
>> +/*
>> + * Qualcomm Technologies CPU PMU IMPLEMENTATION DEFINED extensions 
>> support
>> + *
>> + * Current extensions supported:
>> + *
>> + * - Matrix-based microarchitectural events support
>> + *
>> + *   Selection of these events can be envisioned as indexing them 
>> from
>> + *   a 3D matrix:
>> + *   - the first index selects a Region Event Selection Register 
>> (PMRESRx_EL0)
>> + *   - the second index selects a group from which only one event at 
>> a time
>> + *     can be selected
>> + *   - the third index selects the event
>> + *
>> + *   The event is encoded into perf_event_attr.config as 0xPRCCG, 
>> where:
>> + *     P  [config:16   ] = prefix   (flag that indicates a 
>> matrix-based event)
>> + *     R  [config:12-15] = register (specifies the PMRESRx_EL0 
>> instance)
>> + *     G  [config:0-3  ] = group    (specifies the event group)
>> + *     CC [config:4-11 ] = code     (specifies the event)
>> + *
>> + *   Events with the P flag set to zero are treated as common PMUv3 
>> events
>> + *   and are directly programmed into PMXEVTYPERx_EL0.
> 
> When PMUv3 is given a raw event code, the config fields should be the
> PMU event number, and this conflicts with RESERVED encodings.
> 
> I'd rather we used a separate field for the QC extension events. e.g.
> turn config1 into a flags field, and move the P flag there.
> 
> We *should* add code to sanity check those fields are zero in the PMUv3
> driver, even though it's a potential ABI break to start now.

I should have stated clearly that in this case the event code is 
directly
programmed into PMXEVTYPERx_EL0.evtCount, not by this code, but by the 
PMUv3
code, which will do the masking and ensure reserved bits are not 
touched.
IOW, that case is no different from the raw event or a common event 
case.

I would prefer to keep the flag in config because it allows the use of
raw code encodings to access these events more easily, and given that
the flag is never propagated to any register I believe it is safe.

> 
>> + *
>> + *   The first two indexes are set combining the RESR and group 
>> number with
>> + *   a base number and writing it into the architected PMXEVTYPER_EL0 
>> register.
>> + *   The third index is set by writing the code into the bits 
>> corresponding
>> + *   with the group into the appropriate IMPLEMENTATION DEFINED 
>> PMRESRx_EL0
>> + *   register.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/perf/arm_pmu.h>
> 
> You'll also need:
> 
> #include <linux/bitops.h>
> #include <linux/device.h>
> #include <linux/perf_event.h>
> #include <linux/printk.h>
> #include <linux/types.h>
> 
> #include <asm/barrier.h>
> #include <asm/sysreg.h>
> 

Will do.

>> +
>> +#define pmresr0_el0         sys_reg(3, 5, 11, 3, 0)
>> +#define pmresr1_el0         sys_reg(3, 5, 11, 3, 2)
>> +#define pmresr2_el0         sys_reg(3, 5, 11, 3, 4)
>> +#define pmxevcntcr_el0      sys_reg(3, 5, 11, 0, 3)
>> +
>> +#define QC_EVT_PFX_SHIFT    16
>> +#define QC_EVT_REG_SHIFT    12
>> +#define QC_EVT_CODE_SHIFT   4
>> +#define QC_EVT_GRP_SHIFT    0
>> +#define QC_EVT_PFX_MASK     GENMASK(QC_EVT_PFX_SHIFT,  
>> QC_EVT_PFX_SHIFT)
>> +#define QC_EVT_REG_MASK     GENMASK(QC_EVT_REG_SHIFT + 3,  
>> QC_EVT_REG_SHIFT)
>> +#define QC_EVT_CODE_MASK    GENMASK(QC_EVT_CODE_SHIFT + 7, 
>> QC_EVT_CODE_SHIFT)
>> +#define QC_EVT_GRP_MASK     GENMASK(QC_EVT_GRP_SHIFT + 3,  
>> QC_EVT_GRP_SHIFT)
>> +#define QC_EVT_PRG_MASK     (QC_EVT_PFX_MASK | QC_EVT_REG_MASK | 
>> QC_EVT_GRP_MASK)
>> +#define QC_EVT_PRG(event)   ((event) & QC_EVT_PRG_MASK)
>> +#define QC_EVT_REG(event)   (((event) & QC_EVT_REG_MASK)  >> 
>> QC_EVT_REG_SHIFT)
>> +#define QC_EVT_CODE(event)  (((event) & QC_EVT_CODE_MASK) >> 
>> QC_EVT_CODE_SHIFT)
>> +#define QC_EVT_GROUP(event) (((event) & QC_EVT_GRP_MASK)  >> 
>> QC_EVT_GRP_SHIFT)
>> +
>> +#define QC_MAX_GROUP        7
>> +#define QC_MAX_RESR         2
>> +#define QC_BITS_PER_GROUP   8
>> +#define QC_RESR_ENABLE      BIT_ULL(63)
>> +#define QC_RESR_EVT_BASE    0xd8
>> +
>> +static struct arm_pmu *def_ops;
>> +
>> +static inline void falkor_write_pmresr(u64 reg, u64 val)
>> +{
>> +	if (reg == 0)
>> +		write_sysreg_s(val, pmresr0_el0);
>> +	else if (reg == 1)
>> +		write_sysreg_s(val, pmresr1_el0);
>> +	else
>> +		write_sysreg_s(val, pmresr2_el0);
>> +}
>> +
>> +static inline u64 falkor_read_pmresr(u64 reg)
>> +{
>> +	return (reg == 0 ? read_sysreg_s(pmresr0_el0) :
>> +		reg == 1 ? read_sysreg_s(pmresr1_el0) :
>> +			   read_sysreg_s(pmresr2_el0));
>> +}
> 
> Please use switch statements for both of these.

Will do.

> 
>> +
>> +static void falkor_set_resr(u64 reg, u64 group, u64 code)
>> +{
>> +	u64 shift = group * QC_BITS_PER_GROUP;
>> +	u64 mask = GENMASK(shift + QC_BITS_PER_GROUP - 1, shift);
>> +	u64 val;
>> +
>> +	val = falkor_read_pmresr(reg) & ~mask;
>> +	val |= (code << shift);
>> +	val |= QC_RESR_ENABLE;
>> +	falkor_write_pmresr(reg, val);
>> +}
>> +
>> +static void falkor_clear_resr(u64 reg, u64 group)
>> +{
>> +	u32 shift = group * QC_BITS_PER_GROUP;
>> +	u64 mask = GENMASK(shift + QC_BITS_PER_GROUP - 1, shift);
>> +	u64 val = falkor_read_pmresr(reg) & ~mask;
>> +
>> +	falkor_write_pmresr(reg, val == QC_RESR_ENABLE ? 0 : val);
>> +}
>> +
>> +/*
>> + * Check if e1 and e2 conflict with each other
>> + *
>> + * e1 is a matrix-based microarchitectural event we are checking 
>> against e2.
>> + * A conflict exists if the events use the same reg, group, and a 
>> different
>> + * code. Events with the same code are allowed because they could be 
>> using
>> + * different filters (e.g. one to count user space and the other to 
>> count
>> + * kernel space events).
>> + */
> 
> What problem occurs when there's a conflict?

No real problem at the hardware level since only one event can be 
selected
at a time from a group, but if this is not detected and dealt with the 
user
will receive incorrect information.

Selection is done through the PMRESRx_EL0 registers, these are 64bit 
registers
with an enable bit (63) one 7-bit field for group 7 (62-56) event 
selection, and
seven 8-bit fields for group 6 to group 0 event selection. So it is 
physically
impossible to select two events.

> 
> Does the filter matter at all? When happens if I open two identical
> events, both counting the same reg, group, and code, with the same
> filter?

That is possible and allowed, similar to counting the same common event
in two configurable counters. Only problem is wasting a counter 
resource.

> 
>> +static inline int events_conflict(struct perf_event *e1, struct 
>> perf_event *e2)
>> +{
>> +	if ((e1 != e2) &&
>> +	    (e1->pmu == e2->pmu) &&
>> +	    (QC_EVT_PRG(e1->attr.config) == QC_EVT_PRG(e2->attr.config)) &&
>> +	    (QC_EVT_CODE(e1->attr.config) != QC_EVT_CODE(e2->attr.config))) 
>> {
>> +		pr_debug_ratelimited(
>> +			"Group exclusion: conflicting events %llx %llx\n",
>> +			e1->attr.config,
>> +			e2->attr.config);
>> +		return 1;
>> +	}
>> +	return 0;
>> +}
> 
> This would be easier to read as a series of tests:
> 
> static inline bool events_conflict(struct perf_event *new,
> 				   struct perf_event *other)
> {
> 	/* own group leader */
> 	if (new == other)
> 		return false;
> 
> 	/* software events can't conflict */
> 	if (is_sw_event(other))
> 		return false;
> 
> 	/* No conflict if using different reg or group */
> 	if (QC_EVT_PRG(new->attr.config) != QC_EVT_PRG(other->attr.config))
> 		return false;
> 
> 	/* Same reg and group is fine so long as code matches */
> 	if (QC_EVT_CODE(new->attr.config) == QC_EVT_PRG(other->attr.config)
> 		return false;
> 
> 
> 	pr_debug_ratelimited("Group exclusion: conflicting events %llx 
> %llx\n",
> 		new->attr.config, other->attr.config);
> 
> 	return true;
> 
> }

Will rework.

> 
>> +
>> +/*
>> + * Check if the given event is valid for the PMU and if so return the 
>> value
>> + * that can be used in PMXEVTYPER_EL0 to select the event
>> + */
>> +static int falkor_map_event(struct perf_event *event)
>> +{
>> +	u64 reg = QC_EVT_REG(event->attr.config);
>> +	u64 group = QC_EVT_GROUP(event->attr.config);
>> +	struct perf_event *leader;
>> +	struct perf_event *sibling;
>> +
>> +	if (!(event->attr.config & QC_EVT_PFX_MASK))
>> +		/* Common PMUv3 event, forward to the original op */
>> +		return def_ops->map_event(event);
> 
> The QC event codes should only be used when either:
> 
> * event->attr.type is PERF_TYPE_RAW, or:
> 
> * event->pmu.type is this PMU's dynamic type
> 
> ... otherwise this will accept events meant for other PMUs, and/or
> override conflicting events in other type namespaces (e.g.
> PERF_EVENT_TYPE_HW, PERF_EVENT_TYPE_CACHE).
> 

Will add a check.

>> +
>> +	/* Is it a valid matrix event? */
>> +	if ((group > QC_MAX_GROUP) || (reg > QC_MAX_RESR))
>> +		return -ENOENT;
>> +
>> +	/* If part of an event group, check if the event can be put in it */
>> +
>> +	leader = event->group_leader;
>> +	if (events_conflict(event, leader))
>> +		return -ENOENT;
>> +
>> +	for_each_sibling_event(sibling, leader)
>> +		if (events_conflict(event, sibling))
>> +			return -ENOENT;
>> +
>> +	return QC_RESR_EVT_BASE + reg*8 + group;
> 
> Nit: spacing around binary operators please.
> 
>> +}
>> +
>> +/*
>> + * Find a slot for the event on the current CPU
>> + */
>> +static int falkor_get_event_idx(struct pmu_hw_events *cpuc, struct 
>> perf_event *event)
>> +{
>> +	int idx;
>> +
>> +	if (!!(event->attr.config & QC_EVT_PFX_MASK))
> 
> The '!!' isn't required.
> 
>> +		/* Matrix event, check for conflicts with existing events */
>> +		for_each_set_bit(idx, cpuc->used_mask, ARMPMU_MAX_HWEVENTS)
>> +			if (cpuc->events[idx] &&
>> +			    events_conflict(event, cpuc->events[idx]))
>> +				return -ENOENT;
>> +
>> +	/* Let the original op handle the rest */
>> +	idx = def_ops->get_event_idx(cpuc, event);
> 
> Same comments as for falkor_map_event().
> 
>> +
>> +	/*
>> +	 * This is called for actually allocating the events, but also with
>> +	 * a dummy pmu_hw_events when validating groups, for that case we
>> +	 * need to ensure that cpuc->events[idx] is NULL so we don't use
>> +	 * an uninitialized pointer. Conflicts for matrix events in groups
>> +	 * are checked during event mapping anyway (see falkor_event_map).
>> +	 */
>> +	cpuc->events[idx] = NULL;
>> +
>> +	return idx;
>> +}
>> +
>> +/*
>> + * Reset the PMU
>> + */
>> +static void falkor_reset(void *info)
>> +{
>> +	struct arm_pmu *pmu = (struct arm_pmu *)info;
>> +	u32 i, ctrs = pmu->num_events;
>> +
>> +	/* PMRESRx_EL0 regs are unknown at reset, except for the EN field */
>> +	for (i = 0; i <= QC_MAX_RESR; i++)
>> +		falkor_write_pmresr(i, 0);
>> +
>> +	/* PMXEVCNTCRx_EL0 regs are unknown at reset */
>> +	for (i = 0; i <= ctrs; i++) {
>> +		write_sysreg(i, pmselr_el0);
>> +		isb();
>> +		write_sysreg_s(0, pmxevcntcr_el0);
>> +	}
>> +
>> +	/* Let the original op handle the rest */
>> +	def_ops->reset(info);
>> +}
>> +
>> +/*
>> + * Enable the given event
>> + */
>> +static void falkor_enable(struct perf_event *event)
>> +{
>> +	if (!!(event->attr.config & QC_EVT_PFX_MASK)) {
> 
> The '!!' isn't required.
> 
>> +		/* Matrix event, program the appropriate PMRESRx_EL0 */
>> +		struct arm_pmu *pmu = to_arm_pmu(event->pmu);
>> +		struct pmu_hw_events *events = this_cpu_ptr(pmu->hw_events);
>> +		u64 reg = QC_EVT_REG(event->attr.config);
>> +		u64 code = QC_EVT_CODE(event->attr.config);
>> +		u64 group = QC_EVT_GROUP(event->attr.config);
>> +		unsigned long flags;
>> +
>> +		raw_spin_lock_irqsave(&events->pmu_lock, flags);
>> +		falkor_set_resr(reg, group, code);
>> +		raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> 
> Why is the spinlock required?
> 
> AFACIT this should only ever be called in contexts where IRQs are
> disabled already.
> 

falkor_set_resr is a read-modify-write operation. The PMUv3 code uses
the spinlock to protect the counter selection too 
(armv8pmu_enable_event).
I believe this is to deal with event rotation which can potentially
be active when we are creating new events.

>> +	}
>> +
>> +	/* Let the original op handle the rest */
>> +	def_ops->enable(event);
>> +}
>> +
>> +/*
>> + * Disable the given event
>> + */
>> +static void falkor_disable(struct perf_event *event)
>> +{
>> +	/* Use the original op to disable the counter and interrupt  */
>> +	def_ops->enable(event);
>> +
>> +	if (!!(event->attr.config & QC_EVT_PFX_MASK)) {
>> +		/* Matrix event, de-program the appropriate PMRESRx_EL0 */
>> +		struct arm_pmu *pmu = to_arm_pmu(event->pmu);
>> +		struct pmu_hw_events *events = this_cpu_ptr(pmu->hw_events);
>> +		u64 reg = QC_EVT_REG(event->attr.config);
>> +		u64 group = QC_EVT_GROUP(event->attr.config);
>> +		unsigned long flags;
>> +
>> +		raw_spin_lock_irqsave(&events->pmu_lock, flags);
>> +		falkor_clear_resr(reg, group);
>> +		raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>> +	}
>> +}
> 
> Same comments as with falkor_enable().
> 
>> +
>> +PMU_FORMAT_ATTR(event,  "config:0-15");
>> +PMU_FORMAT_ATTR(prefix, "config:16");
>> +PMU_FORMAT_ATTR(reg,    "config:12-15");
>> +PMU_FORMAT_ATTR(code,   "config:4-11");
>> +PMU_FORMAT_ATTR(group,  "config:0-3");
> 
> What sort of events are available? Do you plan to add anything to the
> userspace event database in tools/perf/pmu-events/ ?
> 

Yes, we are still doing some internal work to see what we can put in
the driver or as JSON events.

>> +
>> +static struct attribute *falkor_pmu_formats[] = {
>> +	&format_attr_event.attr,
>> +	&format_attr_prefix.attr,
>> +	&format_attr_reg.attr,
>> +	&format_attr_code.attr,
>> +	&format_attr_group.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group falkor_pmu_format_attr_group = {
>> +	.name = "format",
>> +	.attrs = falkor_pmu_formats,
>> +};
>> +
>> +static int qcom_falkor_pmu_init(struct arm_pmu *pmu, struct device 
>> *dev)
>> +{
>> +	/* Save base arm_pmu so we can invoke its ops when appropriate */
>> +	def_ops = devm_kmemdup(dev, pmu, sizeof(*def_ops), GFP_KERNEL);
>> +	if (!def_ops) {
>> +		pr_warn("Failed to allocate arm_pmu for QCOM extensions");
>> +		return -ENODEV;
>> +	}
>> +
>> +	pmu->name = "qcom_pmuv3";
> 
> All the other CPU PMUs on an ARM ACPI system will have an index suffix,
> e.g. "armv8_pmuv3_0". I can see why we might want to change the name to
> indicate the QC extensions, but I think we should keep the existing
> pattern, with a '_0' suffix here.

This overrides the name before the suffix is added, so the PMU name will 
be
qcom_pmuv3_0 for Centriq 2400 which has only Falkor CPUs.

> 
>> +
>> +	/* Override the necessary ops */
>> +	pmu->map_event     = falkor_map_event;
>> +	pmu->get_event_idx = falkor_get_event_idx;
>> +	pmu->reset         = falkor_reset;
>> +	pmu->enable        = falkor_enable;
>> +	pmu->disable       = falkor_disable;
> 
> I'm somewhat concerned by hooking into the existing PMU code at this
> level, but I don't currently have a better suggestion.
> 

IMO this is no different from other PMUs implemented on top of the 
arm_pmu
framework. The difference is of course that I'm calling back into the 
base
PMUv3 ops, but the alternative would be to duplicate, which is what we 
want
to avoid.

Thanks for the detailed feedback, I'll try to submit V3 before week's 
end.
Let me know if you have any concerns about my replies above.

Thanks,
Agustín

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
