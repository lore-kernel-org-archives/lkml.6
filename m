Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DE585C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AED208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AED208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965799AbeFONXw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:23:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42352 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933771AbeFONXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:23:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D50B80D;
        Fri, 15 Jun 2018 06:23:50 -0700 (PDT)
Received: from [10.1.210.28] (e107155-lin.cambridge.arm.com [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D88A73F59D;
        Fri, 15 Jun 2018 06:23:46 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To:     Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <a01f2528-f696-3819-73eb-e321d2256b85@arm.com>
Date:   Fri, 15 Jun 2018 14:23:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/06/18 19:24, Taniya Das wrote:
> Hello Sudeep,
> 
> Thanks for your comments.
> 
> On 6/14/2018 4:17 PM, Sudeep Holla wrote:
>>
>>
>> On 13/06/18 19:13, Taniya Das wrote:
>>> Hello Sudeep,
>>>
>>> Thanks for review comments.
>>>
>>> On 6/13/2018 4:56 PM, Sudeep Holla wrote:
>>>>
>>>>
>>
>> [...]
>>
>>>> You are bit inconsistent on the wordings. Some places you refer this as
>>>> hardware engine. If so, please drop all references to firmware/FW. If
>>>> it's firmware then update accordingly.
>>>>
>>>
>>> It is a hardware engine which has a firmware to take care of the
>>> managing the frequency request from OS. That is reason to refer it as a
>>> firmware.
>>>
>>
>> Yes I did guess that initially, but I failed to understand when
>> different bindings were posted to deal with devfreq and cpufreq with the
>> same firmware. Ideally if it's the firmware you are talking to, place
>> all these under /firmware node and align all those with single binding.
>>
> 
> The OS is not aware of the firmware and OS only knows about the hardware
> engine and has to put forward it's request to the hardware engine using
> the "Perf" state register in both devfreq & cpufreq. So would it be
> still required to put under the /firmware node?
> 

Ah ok, then remove any references to firmware other than stating its
presence in the introduction. E.g. you have "Add cpufreq firmware device
bindings ...". So this is definitely not firmware binding. You are just
presenting the h/w as is and you need to deal with change of firmware in
DT and OS agnostic way.

>> Is there anything else that this firmware deals with ? If so all those
>> need to be put in one place.
>>
> 
> We deal only with the CPU frequency and L3 frequency(devfreq).
> 

OK

>>>>> +Properties:
>>>>> +- compatible
>>>>> +    Usage:        required
>>>>> +    Value type:    <string>
>>>>> +    Definition:    must be "qcom,cpufreq-fw".
>>>>> +
>>>>> +* Property qcom,freq-domain
>>>>> +Devices supporting freq-domain must set their "qcom,freq-domain"
>>>>> property with
>>>>> +phandle to a freq_domain_table in their DT node.
>>>>> +
>>>>> +* Frequency Domain Table Node
>>>>> +
>>>>> +This describes the frequency domain belonging to a device.
>>>>> +This node can have following properties:
>>>>> +
>>>>> +- reg
>>>>> +    Usage:        required
>>>>> +    Value type:    <prop-encoded-array>
>>>>> +    Definition:    Addresses and sizes for the memory of the perf
>>>>> +            , lut and enable bases.
>>>>> +            perf - indicates the base address for the desired
>>>>> +            performance state to be set.
>>>>> +            lut - indicates the look up table base address for the
>>>>> +            cpufreq    driver to read frequencies.
>>>>> +            enable - indicates the enable register for firmware.
>>>>
>>>>
>>>> You still didn't answer my earlier question.
>>>>
>>>> OS might touch one or 2 registers in lots of IP blocks. I am not sure
>>>> why those are any different from these. Are you trying to align with
>>>> any
>>>> other bindings or specification. Are you trying to make this binding
>>>> generic here ? I understand if it was trying to generalize the firmware
>>>> interface, but you also state it's a hardware engine. So I fail to see
>>>> the need for such specificity here. Why not define the whole IP block
>>>> and the driver knows where to access these specific ones as they are
>>>> specific to this hardware block. In that way if you decide to add more
>>>> data, it's extensible easily without the need for patching DT.
>>>>
>>>
>>> Sorry Sudeep I missed replying to your earlier query.
>>> The High level OS(HLOS) would require to access only these specific
>>> registers from this IP block and just mapping the whole block(huge
>>> region) is unnecessary from the OS point of View. As of now it is a
>>> generic binding for all using this IP block to manage frequency
>>> requests. The OS would only have to know the frequencies supported i.e
>>> to read the lookup table registers and put across the OS request using
>>> the performance state register.
>>>
>>
>> I am not sure if you need to defining bindings to save OSPM IO mapping.
>> In-fact you may be adding more mapping unnecessarily. The mappings are
>> page aligned and spiting the registers and mapping them individually may
>> result in more mappings.
>>
>> I just need to know the rational for such specific choice of registers.
>> I assume it's aligned to some other standard specifications like CPPC
>> though not identical.
>>
> 
> I am not sure of the query but there is no other register that the OS is
> required to use other than the ones defined here.
> 

The point is ever IP on the SoC may have 100s to 1000s of registers that
may or may not be used by OS. That's about to the OS to decide and you
just need to provide the hardware view to anyone using the device tree.
It *should not* _just_ represent what you think OS(Linux in particular)
"for now"

>>>> Eg. Suppose you need some information on power curve for EAS energy
>>>> model, I really hate to update DT for that or even do a mix with DT
>>>> just
>>>> because f/w is no longer modifiable.
>>>>
>>>
>>> For now we are safe.
>>>
>>
>> What do you mean by that ?
> 
> I meant here was currently there is no such known case where the f/w is
> no longer modifiable and we need to extend device tree bindings.
> 
>> It should be easily extensible is what I am
>> trying to say. You can add more info and alter the information in the
>> driver with compatibles if you keep the register info as minimum as
>> possible. For now, you have enable, set and lut registers. What if you
>> want to provide power numbers ?
>>
> 
> Yes I do understand the intent of mapping the whole register space, but
> as per the HW specs these 3 registers would be the only ones required
> for now. I do not think this hardware engine has any information on the
> power numbers.
> 

That's fine. So on this platform DT, will you list only the registers
touched by the OS for all the IP ? I am sure that will not be the case.

-- 
Regards,
Sudeep
