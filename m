Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910BDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFA120659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfANRFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:05:14 -0500
Received: from foss.arm.com ([217.140.101.70]:37742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfANRFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:05:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6153A78;
        Mon, 14 Jan 2019 09:05:12 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DE4F3F5BD;
        Mon, 14 Jan 2019 09:05:10 -0800 (PST)
Subject: Re: [PATCH v3 6/7] arm64: add sysfs vulnerability show for
 speculative store bypass
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, linux-kernel@vger.kernel.org,
        ykaukab@suse.de, julien.thierry@arm.com, mlangsdo@redhat.com,
        steven.price@arm.com, stefan.wahren@i2se.com
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-7-jeremy.linton@arm.com>
 <ac625845-fd40-ad87-4efd-ea0ed53274ec@arm.com>
 <762faf42-6806-bba9-091c-c21e6955e17d@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <83c6bc05-7809-ebce-4bff-f6763e5d3a70@arm.com>
Date:   Mon, 14 Jan 2019 17:05:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <762faf42-6806-bba9-091c-c21e6955e17d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2019 16:37, Jeremy Linton wrote:
> Hi,
> 
> On 01/14/2019 04:15 AM, Marc Zyngier wrote:
>> On 09/01/2019 23:55, Jeremy Linton wrote:
>>> Return status based on ssbd_state and the arm64 SSBS feature. If
>>> the mitigation is disabled, or the firmware isn't responding then
>>> return the expected machine state based on a new blacklist of known
>>> vulnerable cores.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   arch/arm64/kernel/cpu_errata.c | 48 ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 48 insertions(+)
>>>
>>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>>> index ee286d606d9b..c8ff96158b94 100644
>>> --- a/arch/arm64/kernel/cpu_errata.c
>>> +++ b/arch/arm64/kernel/cpu_errata.c
>>> @@ -288,6 +288,7 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
>>>   DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
>>>   
>>>   int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
>>> +static bool __ssb_safe = true;
>>>   
>>>   static const struct ssbd_options {
>>>   	const char	*str;
>>> @@ -385,10 +386,18 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>>>   {
>>>   	struct arm_smccc_res res;
>>>   	bool required = true;
>>> +	bool is_vul;
>>>   	s32 val;
>>>   
>>>   	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
>>>   
>>> +	is_vul = is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
>>> +
>>> +	if (is_vul)
>>> +		__ssb_safe = false;
>>> +
>>> +	arm64_requested_vuln_attrs |= VULN_SSB;
>>> +
>>>   	if (this_cpu_has_cap(ARM64_SSBS)) {
>>>   		required = false;
>>>   		goto out_printmsg;
>>> @@ -422,6 +431,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>>>   		ssbd_state = ARM64_SSBD_UNKNOWN;
>>>   		return false;
>>>   
>>> +	/* machines with mixed mitigation requirements must not return this */
>>>   	case SMCCC_RET_NOT_REQUIRED:
>>>   		pr_info_once("%s mitigation not required\n", entry->desc);
>>>   		ssbd_state = ARM64_SSBD_MITIGATED;
>>> @@ -476,6 +486,17 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>>>   
>>>   	return required;
>>>   }
>>> +
>>> +/* known vulnerable cores */
>>> +static const struct midr_range arm64_ssb_cpus[] = {
>>> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
>>> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
>>> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
>>> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
>>> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
>>> +	{},
>>> +};
>>> +
>>>   #endif	/* CONFIG_ARM64_SSBD */
>>>   
>>>   static void __maybe_unused
>>> @@ -762,6 +783,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>>>   		.capability = ARM64_SSBD,
>>>   		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
>>>   		.matches = has_ssbd_mitigation,
>>> +		.midr_range_list = arm64_ssb_cpus,
>>>   	},
>>>   #endif
>>>   #ifdef CONFIG_ARM64_ERRATUM_1188873
>>> @@ -809,4 +831,30 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
>>>   	return sprintf(buf, "Vulnerable\n");
>>>   }
>>>   
>>> +ssize_t cpu_show_spec_store_bypass(struct device *dev,
>>> +		struct device_attribute *attr, char *buf)
>>> +{
>>> +	/*
>>> +	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
>>> +	 *  for hetrogenous machines, and that if SSBS is supported its
>>> +	 *  supported by all cores.
>>> +	 */
>>> +	switch (arm64_get_ssbd_state()) {
>>> +	case ARM64_SSBD_MITIGATED:
>>> +		return sprintf(buf, "Not affected\n");
>>> +
>>> +	case ARM64_SSBD_KERNEL:
>>> +	case ARM64_SSBD_FORCE_ENABLE:
>>> +		if (cpus_have_cap(ARM64_SSBS))
>>> +			return sprintf(buf, "Not affected\n");
>>> +		return sprintf(buf,
>>> +			"Mitigation: Speculative Store Bypass disabled\n");
>>> +	}
>>> +
>>> +	if (__ssb_safe)
>>> +		return sprintf(buf, "Not affected\n");
>>
>> The kbuild robot reports that this fails if CONFIG_ARM64_SSBD is not
>> selected. What should we print in this case? "Vulnerable"? Or "Unknown"?
> 
> The immediate fix is that the __ssb_safe variable should be in its own 
> conditional block which is  CONFIG_GENERIC_CPU_VULNERABILITIES || 
> CONFIG_ARM64_SSBD. If the mitigation isn't built in then this code won't 
> be run anyway because the sysfs entry won't be populated.

But in that case, we should probably assume that the system is
vulnerable, and we get a different default value for __ssb_safe.

> But, these CONFIG_ conditionals are less than ideal (and would be even 
> uglier if they were made more efficient). My own opinion at this point 
> is that we should really remove the compile time configs and leave the 
> mitigation built all the time. The raw code is fairly small, and we 
> could add in the nospectre_v2 command line options so that users can 
> choose to runtime disable them. That would also remove the need to 
> modify the core cpu vulnerabilities sysfs code.

That'd work for me. The whole thing is now an intractable mess, and I'd
welcome some level of simplification.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
