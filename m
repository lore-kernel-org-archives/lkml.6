Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC25C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C502145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C502145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeIYOT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:19:26 -0400
Received: from foss.arm.com ([217.140.101.70]:46526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbeIYOT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:19:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87EC580D;
        Tue, 25 Sep 2018 01:13:04 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85F5E3F5B7;
        Tue, 25 Sep 2018 01:13:02 -0700 (PDT)
Subject: Re: [PATCH v5 01/27] arm64: cpufeature: Set SYSREG_GIC_CPUIF as a
 boot system feature
To:     Yao Lihua <ylhuajnu@outlook.com>,
        Julien Thierry <julien.thierry@arm.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-2-git-send-email-julien.thierry@arm.com>
 <86h8iix2rk.wl-marc.zyngier@arm.com>
 <MWHPR0601MB3707D7CF3B55BF40EEEA0D52C4160@MWHPR0601MB3707.namprd06.prod.outlook.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <33e98d70-a689-e1d9-ab73-a6650a34213f@arm.com>
Date:   Tue, 25 Sep 2018 09:13:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <MWHPR0601MB3707D7CF3B55BF40EEEA0D52C4160@MWHPR0601MB3707.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/18 04:10, Yao Lihua wrote:
> Hi Marc, Julien，
> 
> 
> On 09/21/2018 11:56 PM, Marc Zyngier wrote:
>> On Tue, 28 Aug 2018 16:51:11 +0100,
>> Julien Thierry <julien.thierry@arm.com> wrote:
>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>   arch/arm64/kernel/cpufeature.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index e238b79..1e433ac 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -1039,7 +1039,7 @@ static void cpu_has_fwb(const struct arm64_cpu_capabilities *__unused)
>>>   	{
>>>   		.desc = "GIC system register CPU interface",
>>>   		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
>>> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
>>>   		.matches = has_useable_gicv3_cpuif,
>>>   		.sys_reg = SYS_ID_AA64PFR0_EL1,
>>>   		.field_pos = ID_AA64PFR0_GIC_SHIFT,
>>> -- 
>>> 1.9.1
>>>
>> This definitely deserves a commit message, such as:
>>
>> "We do not support systems where some CPUs have an operational GICv3
>>   CPU interface, and some don't. Let's make this requirement obvious by
>>   flagging the GICv3 capability as being strict."
> May I ask if it is possible to implement psedue-NMI on a arm64 SoC with GIC-400?

In theory, yes. In practice, this is likely to be both hard to implement 
(you need to discover the GIC CPU interface address very early so that 
you can patch the the PMR flipping code at the right time), and pretty 
bad from a performance point of view (MMIO accesses are likely to be slow).

Given the above, the incentive to support such a configuration is close 
to zero.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
