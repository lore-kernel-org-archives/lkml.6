Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03737C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A764420855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A764420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeK0FkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:40:22 -0500
Received: from foss.arm.com ([217.140.101.70]:44982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeK0FkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:40:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56C601A25;
        Mon, 26 Nov 2018 10:45:22 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B05043F5AF;
        Mon, 26 Nov 2018 10:45:18 -0800 (PST)
Subject: Re: [PATCH v4 4/4] perf/smmuv3_pmu: Enable HiSilicon Erratum
 162001800 quirk
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20181016124920.24708-1-shameerali.kolothum.thodi@huawei.com>
 <20181016124920.24708-5-shameerali.kolothum.thodi@huawei.com>
 <0d7a984e-5814-a986-cd48-ef0651079e32@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA8387A0342@FRAEML521-MBX.china.huawei.com>
 <5FC3163CFD30C246ABAA99954A238FA8387A0575@FRAEML521-MBX.china.huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8e469c3-7ec9-551e-d5bd-6f14b02a8f3f@arm.com>
Date:   Mon, 26 Nov 2018 18:45:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8387A0575@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

Sorry for the delay...

On 18/10/2018 16:27, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of
>> Shameerali Kolothum Thodi
>> Sent: 18 October 2018 14:34
>> To: Robin Murphy <robin.murphy@arm.com>; lorenzo.pieralisi@arm.com;
>> jean-philippe.brucker@arm.com
>> Cc: mark.rutland@arm.com; vkilari@codeaurora.org;
>> neil.m.leeder@gmail.com; pabba@codeaurora.org; will.deacon@arm.com;
>> rruigrok@codeaurora.org; Linuxarm <linuxarm@huawei.com>; linux-
>> kernel@vger.kernel.org; linux-acpi@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org
>> Subject: RE: [PATCH v4 4/4] perf/smmuv3_pmu: Enable HiSilicon Erratum
>> 162001800 quirk
>>
>> Hi Robin,
>>
>>> -----Original Message-----
>>> From: Robin Murphy [mailto:robin.murphy@arm.com]
>>> Sent: 18 October 2018 12:44
>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>>> lorenzo.pieralisi@arm.com; jean-philippe.brucker@arm.com
>>> Cc: will.deacon@arm.com; mark.rutland@arm.com; Guohanjun (Hanjun Guo)
>>> <guohanjun@huawei.com>; John Garry <john.garry@huawei.com>;
>>> pabba@codeaurora.org; vkilari@codeaurora.org; rruigrok@codeaurora.org;
>>> linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>>> kernel@lists.infradead.org; Linuxarm <linuxarm@huawei.com>;
>>> neil.m.leeder@gmail.com
>>> Subject: Re: [PATCH v4 4/4] perf/smmuv3_pmu: Enable HiSilicon Erratum
>>> 162001800 quirk
> 
> [...]
> 
>>>> +static const struct smmu_pmu_erratum_wa smmu_pmu_wa[] = {
>>>> +	{
>>>> +		.match_type = se_match_acpi_oem,
>>>> +		.id = hisi_162001800_oem_info,
>>>> +		.desc_str = "HiSilicon erratum 162001800",
>>>> +		.enable = hisi_erratum_evcntr_rdonly,
>>>> +	},
>>>> +};
>>>> +
>>>
>>> There's an awful lot of raw ACPI internals splashed about here -
>>> couldn't at least some of it be abstracted behind the IORT code? In
>>> fact, can't IORT just set all this stuff up in advance like it does for
>>> SMMUs?
>>
>> Hmmm.. Sorry, not clear to me. You mean to say associate the IORT node
>> with platform device and retrieve it in driver just like smmu does for
>> "model" checks? Not sure that works here if that’s what the above meant.

I don't think there's much of interest in the actual IORT node itself, 
but I can't see that there would be any particular problem with passing 
either some implementation identifier or just a ready-made set of quirk 
flags to the PMCG driver via platdata.

>>>>    #define to_smmu_pmu(p) (container_of(p, struct smmu_pmu, pmu))
>>>>
>>>>    #define SMMU_PMU_EVENT_ATTR_EXTRACTOR(_name, _config, _start,
>>> _end)        \
>>>> @@ -224,15 +271,20 @@ static void smmu_pmu_set_period(struct
>>> smmu_pmu *smmu_pmu,
>>>>    	u32 idx = hwc->idx;
>>>>    	u64 new;
>>>>
>>>> -	/*
>>>> -	 * We limit the max period to half the max counter value of the
>>> counter
>>>> -	 * size, so that even in the case of extreme interrupt latency the
>>>> -	 * counter will (hopefully) not wrap past its initial value.
>>>> -	 */
>>>> -	new = smmu_pmu->counter_mask >> 1;
>>>> +	if (smmu_pmu->options & SMMU_PMU_OPT_EVCNTR_RDONLY) {
>>>> +		new = smmu_pmu_counter_get_value(smmu_pmu, idx);
>>>
>>> Something's clearly missing, because if this happens to start at 0, the
>>> current overflow handling code cannot possibly give the correct count.
>>> Much as I hate the reset-to-half-period idiom for being impossible to
>>> make sense of, it does make various aspects appear a lot simpler than
>>> they really are. Wait, maybe that's yet another reason to hate it...
>>
>> Yes,  if the counter starts at 0 and overflow happens, it won't possibly give
>> the correct count compared to the reset-to-half-period logic. Since this is a
>> 64 bit counter, just hope that, it won't necessarily happen that often.

OK, if the full 64 counter bits are implemented, then I suppose we're 
probably OK to assume nobody's going to run a single profiling session 
over 4+ years or so. It might be worth a comment just to remind 
ourselves that we're (currently) relying on the counter size to mostly 
mitigate overflow-related issues in this case.

> 
> [...]
> 
>>>> +static void smmu_pmu_enable_errata(struct smmu_pmu *smmu_pmu,
>>>> +				enum smmu_pmu_erratum_match_type type,
>>>> +				se_match_fn_t match_fn,
>>>> +				void *arg)
>>>> +{
>>>> +	const struct smmu_pmu_erratum_wa *wa = smmu_pmu_wa;
>>>> +
>>>> +	for (; wa->desc_str; wa++) {
>>>> +		if (wa->match_type != type)
>>>> +			continue;
>>>> +
>>>> +		if (match_fn(wa, arg)) {
>>>> +			if (wa->enable) {
>>>> +				wa->enable(smmu_pmu);
>>>> +				dev_info(smmu_pmu->dev,
>>>> +					"Enabling workaround for %s\n",
>>>> +					 wa->desc_str);
>>>> +			}
>>>
>>> Just how many kinds of broken are we expecting here? Is this lifted from
>>> the arm64 cpufeature framework, because it seems like absolute overkill
>>> for a simple PMU driver which in all reality is only ever going to
>>> wiggle a few flags in some data structure.
>>
>> Yes, this erratum framework is based on the arm_arch_timer code. Agree that
>> this is an overkill if it is just to support this hardware. I am not sure this can be
>> extended to add the IMPLEMENTATION DEFINED events in future(I haven't
>> looked into that now). If this is not that useful in the near future, I will remove
>> the
>> framework part and use the OEM info directly to set the flag. Please let me
>> know
>> your thoughts..
> 
> Below is another take on this patch. Please let me know if this makes any sense..
> 
> Thanks,
> Shameer
> 
> ----8----
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index ef94b90..6f81b94 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -96,6 +96,8 @@
>   
>   #define SMMU_PA_SHIFT                   12
>   
> +#define SMMU_PMU_OPT_EVCNTR_RDONLY	(1 << 0)
> +
>   static int cpuhp_state_num;
>   
>   struct smmu_pmu {
> @@ -111,10 +113,38 @@ struct smmu_pmu {
>   	struct device *dev;
>   	void __iomem *reg_base;
>   	void __iomem *reloc_base;
> +	u32 options;
>   	u64 counter_present_mask;
>   	u64 counter_mask;
>   };
>   
> +struct erratum_acpi_oem_info {
> +	char oem_id[ACPI_OEM_ID_SIZE + 1];
> +	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> +	u32 oem_revision;
> +	void (*enable)(struct smmu_pmu *smmu_pmu);
> +};
> +
> +void hisi_erratum_evcntr_rdonly(struct smmu_pmu *smmu_pmu)
> +{
> +	smmu_pmu->options |= SMMU_PMU_OPT_EVCNTR_RDONLY;
> +	dev_info(smmu_pmu->dev, "Enabling HiSilicon erratum 162001800\n");
> +}
> +
> +static struct erratum_acpi_oem_info acpi_oem_info[] = {
> +	/*
> +	 * Note that trailing spaces are required to properly match
> +	 * the OEM table information.
> +	 */
> +	{
> +		.oem_id         = "HISI  ",
> +		.oem_table_id   = "HIP08   ",
> +		.oem_revision   = 0,
> +		.enable = hisi_erratum_evcntr_rdonly,
> +	},
> +	{ /* Sentinel indicating the end of the OEM array */ },
> +};
> +
>   #define to_smmu_pmu(p) (container_of(p, struct smmu_pmu, pmu))
>   
>   #define SMMU_PMU_EVENT_ATTR_EXTRACTOR(_name, _config, _start, _end)        \
> @@ -224,15 +254,20 @@ static void smmu_pmu_set_period(struct smmu_pmu *smmu_pmu,
>   	u32 idx = hwc->idx;
>   	u64 new;
>   
> -	/*
> -	 * We limit the max period to half the max counter value of the counter
> -	 * size, so that even in the case of extreme interrupt latency the
> -	 * counter will (hopefully) not wrap past its initial value.
> -	 */
> -	new = smmu_pmu->counter_mask >> 1;
> +	if (smmu_pmu->options & SMMU_PMU_OPT_EVCNTR_RDONLY) {
> +		new = smmu_pmu_counter_get_value(smmu_pmu, idx);
> +	} else {
> +		/*
> +		 * We limit the max period to half the max counter value
> +		 * of the counter size, so that even in the case of extreme
> +		 * interrupt latency the counter will (hopefully) not wrap
> +		 * past its initial value.
> +		 */
> +		new = smmu_pmu->counter_mask >> 1;
> +		smmu_pmu_counter_set_value(smmu_pmu, idx, new);
> +	}
>   
>   	local64_set(&hwc->prev_count, new);
> -	smmu_pmu_counter_set_value(smmu_pmu, idx, new);
>   }
>   
>   static void smmu_pmu_get_event_filter(struct perf_event *event, u32 *span,
> @@ -670,6 +705,28 @@ static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
>   		       smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
>   }
>   
> +static void smmu_pmu_check_acpi_workarounds(struct smmu_pmu *smmu_pmu)
> +{
> +	static const struct erratum_acpi_oem_info empty_oem_info = {};
> +	const struct erratum_acpi_oem_info *info = acpi_oem_info;
> +	struct acpi_table_header *hdr;
> +
> +	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_IORT, 0, &hdr))) {
> +		dev_err(smmu_pmu->dev, "failed to get IORT\n");
> +		return;
> +	}
> +
> +	/* Iterate over the ACPI OEM info array, looking for a match */
> +	while (memcmp(info, &empty_oem_info, sizeof(*info))) {
> +		if (!memcmp(info->oem_id, hdr->oem_id, ACPI_OEM_ID_SIZE) &&
> +		    !memcmp(info->oem_table_id, hdr->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> +			info->oem_revision == hdr->oem_revision)
> +			info->enable(smmu_pmu);
> +
> +		info++;
> +	}
> +}

FWIW, this looks awfully like acpi_match_platform_list()...

However, I still think that any parsing of IORT fields belongs in 
iort.c, not in every driver which might ever need to detect a quirk. For 
starters, that code has iort_table to hand, full knowledge of all the 
other identifiable components, and a already contains a bunch of 
system-specific quirk detection which could potentially be shared.

[ side note: do you know if 1620 still has the same ITS quirk as 161x, 
or is it just the SMMU's MSI output that didn't get updated? ]

Robin.

> +
>   static int smmu_pmu_probe(struct platform_device *pdev)
>   {
>   	struct smmu_pmu *smmu_pmu;
> @@ -749,6 +806,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> +	smmu_pmu_check_acpi_workarounds(smmu_pmu);
> +
>   	/* Pick one CPU to be the preferred one to use */
>   	smmu_pmu->on_cpu = get_cpu();
>   	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
> 
