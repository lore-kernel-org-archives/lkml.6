Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966141AbeEYKl4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:41:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59298 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965255AbeEYKlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:41:55 -0400
Subject: Re: [PATCH v4 02/26] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
To: Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <1527241772-48007-3-git-send-email-julien.thierry@arm.com>
 <e44df12f-9868-ae94-4623-ec221d72d783@arm.com>
 <b0673d7e-9a1e-7dcb-5322-c05fe0821349@arm.com>
 <c4e5f8ff-ecde-7b88-8a37-39e47ef22917@arm.com>
 <54ff6127-928d-99a3-a6e9-59799628ca87@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <3f0afa54-8e98-798e-68dc-bbbc74bd9e19@arm.com>
Date: Fri, 25 May 2018 11:41:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <54ff6127-928d-99a3-a6e9-59799628ca87@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/18 11:39, Julien Thierry wrote:
> 
> 
> On 25/05/18 11:36, Suzuki K Poulose wrote:
>> On 25/05/18 11:17, Julien Thierry wrote:
>>>
>>>
>>> On 25/05/18 11:04, Suzuki K Poulose wrote:
>>>> On 25/05/18 10:49, Julien Thierry wrote:
>>>>> Add a cpufeature indicating whether a cpu supports masking interrupts
>>>>> by priority.
>>>>
>>>> How is this different from the SYSREG_GIC_CPUIF cap ? Is it just
>>>> the description ?
>>>
>>> More or less.
>>>
>>> It is just to have an easier condition in the rest of the series. Basically the PRIO masking feature is enabled if we have a GICv3 CPUIF working *and* the option was selected at build time. Before this meant that I was checking for the GIC_CPUIF cap inside #ifdefs (and putting alternatives depending on that inside #ifdefs as well).
>>>
>>> Having this as a separate feature feels easier to manage in the code. It also makes it clearer at boot time that the kernel will be using irq priorities (although I admit it was not the initial intention):
>>>
>>> [    0.000000] CPU features: detected: IRQ priority masking
>>>
>>>
>>> But yes that new feature will be detected only if SYSREG_GIC_CPUIF gets detected as well.
>>
>> Well, you could always wrap the check like :
>>
>> static inline bool system_has_irq_priority_masking(void)
>> {
>>      return (IS_ENABLED(CONFIG_YOUR_CONFIG) && cpus_have_const_cap(HWCAP_SYSREG_GIC_CPUIF));
>> }
>>
>> and use it everywhere.
>>
> 
> Yes, but I can't use that in the asm parts that use alternatives and would need to surround them in #ifdef... :\

I thought there is _ALTERNATIVE_CFG() to base the alternative depend on a CONFIG_xxx ?
Doesn't that solve the problem ?

Suzuki
