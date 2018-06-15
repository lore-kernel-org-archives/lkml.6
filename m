Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF41CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7615720896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mwc6W+RM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ADgKZxcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7615720896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936349AbeFORcK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:32:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44282 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936136AbeFORcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:32:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BEA23607BB; Fri, 15 Jun 2018 17:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529083927;
        bh=Evb0c991efGDlMVRMKogeMTi8xATK3dZqK8EqOl+oOA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mwc6W+RMZbSHdvwsgaj6xZ3RMDTLgem7IysXHqBL3xYc6o6pMKJ8dGt1Ou+Jfy3r/
         P7Nb8ULa/ai5SEB2KY3V6q1iGbDPnApZ206UIJ/6JAC5B/sUaQzd1gROHVNQGN97dK
         pt+WAAAv86omLrfGxc99egUCKGQyOvwMMq6sfN50=
Received: from [192.168.225.247] (unknown [49.32.132.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CFD360116;
        Fri, 15 Jun 2018 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529083926;
        bh=Evb0c991efGDlMVRMKogeMTi8xATK3dZqK8EqOl+oOA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ADgKZxccjJKg29yPtJQUGi7IDIRdaSgOX/zDpY6IfeSjCwj4Tv/1xLt3x/8FmrjNN
         89sReqiSVctVz6kX6TpV+f31kQJPH7M2S8yY4d95Ly4k+871KiGfWwLMsnra1F2r3q
         fDx1YPN95NovNsyiTYS5EKIOH1UZ1I/pngLqBU+g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CFD360116
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <a01f2528-f696-3819-73eb-e321d2256b85@arm.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <c456625c-e61c-b07e-b355-478813d9a182@codeaurora.org>
Date:   Fri, 15 Jun 2018 23:01:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a01f2528-f696-3819-73eb-e321d2256b85@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2018 6:53 PM, Sudeep Holla wrote:
> 
> 
> On 14/06/18 19:24, Taniya Das wrote:
>> Hello Sudeep,
>>
>> Thanks for your comments.
>>
>> On 6/14/2018 4:17 PM, Sudeep Holla wrote:
>>>
>>>
>>> On 13/06/18 19:13, Taniya Das wrote:
>>>> Hello Sudeep,
>>>>
>>>> Thanks for review comments.
>>>>
>>>> On 6/13/2018 4:56 PM, Sudeep Holla wrote:
>>>>>
>>>>>
>>>
>>> [...]
>>>
>>>>> You are bit inconsistent on the wordings. Some places you refer this as
>>>>> hardware engine. If so, please drop all references to firmware/FW. If
>>>>> it's firmware then update accordingly.
>>>>>
>>>>
>>>> It is a hardware engine which has a firmware to take care of the
>>>> managing the frequency request from OS. That is reason to refer it as a
>>>> firmware.
>>>>
>>>
>>> Yes I did guess that initially, but I failed to understand when
>>> different bindings were posted to deal with devfreq and cpufreq with the
>>> same firmware. Ideally if it's the firmware you are talking to, place
>>> all these under /firmware node and align all those with single binding.
>>>
>>
>> The OS is not aware of the firmware and OS only knows about the hardware
>> engine and has to put forward it's request to the hardware engine using
>> the "Perf" state register in both devfreq & cpufreq. So would it be
>> still required to put under the /firmware node?
>>
> 
> Ah ok, then remove any references to firmware other than stating its
> presence in the introduction. E.g. you have "Add cpufreq firmware device
> bindings ...". So this is definitely not firmware binding. You are just
> presenting the h/w as is and you need to deal with change of firmware in
> DT and OS agnostic way.
> 

Sure Sudeep, I will update the references of firmware.

>>> Is there anything else that this firmware deals with ? If so all those
>>> need to be put in one place.
>>>
>>
>> We deal only with the CPU frequency and L3 frequency(devfreq).
>>
> 
> OK
> 
>>>>>> +Properties:
>>>>>> +- compatible
>>>>>> +    Usage:        required
>>>>>> +    Value type:    <string>
>>>>>> +    Definition:    must be "qcom,cpufreq-fw".
>>>>>> +
>>>>>> +* Property qcom,freq-domain
>>>>>> +Devices supporting freq-domain must set their "qcom,freq-domain"
>>>>>> property with
>>>>>> +phandle to a freq_domain_table in their DT node.
>>>>>> +
>>>>>> +* Frequency Domain Table Node
>>>>>> +
>>>>>> +This describes the frequency domain belonging to a device.
>>>>>> +This node can have following properties:
>>>>>> +
>>>>>> +- reg
>>>>>> +    Usage:        required
>>>>>> +    Value type:    <prop-encoded-array>
>>>>>> +    Definition:    Addresses and sizes for the memory of the perf
>>>>>> +            , lut and enable bases.
>>>>>> +            perf - indicates the base address for the desired
>>>>>> +            performance state to be set.
>>>>>> +            lut - indicates the look up table base address for the
>>>>>> +            cpufreq    driver to read frequencies.
>>>>>> +            enable - indicates the enable register for firmware.
>>>>>
>>>>>
>>>>> You still didn't answer my earlier question.
>>>>>
>>>>> OS might touch one or 2 registers in lots of IP blocks. I am not sure
>>>>> why those are any different from these. Are you trying to align with
>>>>> any
>>>>> other bindings or specification. Are you trying to make this binding
>>>>> generic here ? I understand if it was trying to generalize the firmware
>>>>> interface, but you also state it's a hardware engine. So I fail to see
>>>>> the need for such specificity here. Why not define the whole IP block
>>>>> and the driver knows where to access these specific ones as they are
>>>>> specific to this hardware block. In that way if you decide to add more
>>>>> data, it's extensible easily without the need for patching DT.
>>>>>
>>>>
>>>> Sorry Sudeep I missed replying to your earlier query.
>>>> The High level OS(HLOS) would require to access only these specific
>>>> registers from this IP block and just mapping the whole block(huge
>>>> region) is unnecessary from the OS point of View. As of now it is a
>>>> generic binding for all using this IP block to manage frequency
>>>> requests. The OS would only have to know the frequencies supported i.e
>>>> to read the lookup table registers and put across the OS request using
>>>> the performance state register.
>>>>
>>>
>>> I am not sure if you need to defining bindings to save OSPM IO mapping.
>>> In-fact you may be adding more mapping unnecessarily. The mappings are
>>> page aligned and spiting the registers and mapping them individually may
>>> result in more mappings.
>>>
>>> I just need to know the rational for such specific choice of registers.
>>> I assume it's aligned to some other standard specifications like CPPC
>>> though not identical.
>>>
>>
>> I am not sure of the query but there is no other register that the OS is
>> required to use other than the ones defined here.
>>
> 
> The point is ever IP on the SoC may have 100s to 1000s of registers that
> may or may not be used by OS. That's about to the OS to decide and you
> just need to provide the hardware view to anyone using the device tree.
> It *should not* _just_ represent what you think OS(Linux in particular)
> "for now"
> 
>>>>> Eg. Suppose you need some information on power curve for EAS energy
>>>>> model, I really hate to update DT for that or even do a mix with DT
>>>>> just
>>>>> because f/w is no longer modifiable.
>>>>>
>>>>
>>>> For now we are safe.
>>>>
>>>
>>> What do you mean by that ?
>>
>> I meant here was currently there is no such known case where the f/w is
>> no longer modifiable and we need to extend device tree bindings.
>>
>>> It should be easily extensible is what I am
>>> trying to say. You can add more info and alter the information in the
>>> driver with compatibles if you keep the register info as minimum as
>>> possible. For now, you have enable, set and lut registers. What if you
>>> want to provide power numbers ?
>>>
>>
>> Yes I do understand the intent of mapping the whole register space, but
>> as per the HW specs these 3 registers would be the only ones required
>> for now. I do not think this hardware engine has any information on the
>> power numbers.
>>
> 
> That's fine. So on this platform DT, will you list only the registers
> touched by the OS for all the IP ? I am sure that will not be the case.
> 

Yes, registers list those would be touched by OS only.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
