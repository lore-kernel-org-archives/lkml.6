Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B08208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B08208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966471AbeFORpU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:45:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45426 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966215AbeFORpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:45:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A30251529;
        Fri, 15 Jun 2018 10:45:18 -0700 (PDT)
Received: from [10.1.210.28] (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76A403F25D;
        Fri, 15 Jun 2018 10:45:16 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To:     Taniya Das <tdas@codeaurora.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
 <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <a5a2f9d3-204c-7f21-d5f8-1042af24ecce@arm.com>
Date:   Fri, 15 Jun 2018 18:45:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/18 18:40, Taniya Das wrote:
> 
> 
> On 6/15/2018 5:29 PM, Amit Kucheria wrote:
>> On Thu, Jun 14, 2018 at 9:24 PM, Taniya Das <tdas@codeaurora.org> wrote:
>>
>>>>> Sorry Sudeep I missed replying to your earlier query.
>>>>> The High level OS(HLOS) would require to access only these specific
>>>>> registers from this IP block and just mapping the whole block(huge
>>>>> region) is unnecessary from the OS point of View. As of now it is a
>>>>> generic binding for all using this IP block to manage frequency
>>>>> requests. The OS would only have to know the frequencies supported i.e
>>>>> to read the lookup table registers and put across the OS request using
>>>>> the performance state register.
>>>>>
>>>>
>>>> I am not sure if you need to defining bindings to save OSPM IO mapping.
>>>> In-fact you may be adding more mapping unnecessarily. The mappings are
>>>> page aligned and spiting the registers and mapping them individually
>>>> may
>>>> result in more mappings.
>>>>
>>>> I just need to know the rational for such specific choice of registers.
>>>> I assume it's aligned to some other standard specifications like CPPC
>>>> though not identical.
>>>>
>>>
>>> I am not sure of the query but there is no other register that the OS is
>>> required to use other than the ones defined here.
>>>
>>>>>> Eg. Suppose you need some information on power curve for EAS energy
>>>>>> model, I really hate to update DT for that or even do a mix with
>>>>>> DT just
>>>>>> because f/w is no longer modifiable.
>>>>>>
>>>>>
>>>>> For now we are safe.
>>>>>
>>>>
>>>> What do you mean by that ?
>>>
>>>
>>> I meant here was currently there is no such known case where the f/w
>>> is no
>>> longer modifiable and we need to extend device tree bindings.
>>>
>>>> It should be easily extensible is what I am
>>>> trying to say. You can add more info and alter the information in the
>>>> driver with compatibles if you keep the register info as minimum as
>>>> possible. For now, you have enable, set and lut registers. What if you
>>>> want to provide power numbers ?
>>>>
>>>
>>> Yes I do understand the intent of mapping the whole register space,
>>> but as
>>> per the HW specs these 3 registers would be the only ones required
>>> for now.
>>> I do not think this hardware engine has any information on the power
>>> numbers.
>>
>> "For now" - I think this is exactly the point that Sudeep is trying to
>> make.
>>
>> A future version of the HW engine, or more likely, a firmware
>> revision, will make more functionality available. Say, this needs
>> access to another register or two. This will require changing the DT
>> bindings. Instead, if you map the entire address space, you can just
>> add offsets to the new registers.
>>
>> So in this case, I think you should define the following addresses
>> (size 0x1400) for the two frequency domains
>>
>> 0x17d43000, 0x1400 (power cluster)
>> 0x17d45800, 0x1400 (perf cluster)
>>
>> And in the driver simply add offsets as follows:
>>
>> #define ENABLE_OFFSET               0x0
>> #define LUT_OFFSET                      0x110
>> #define PERF_DESIRED_OFFSET 0x920
>>
> 
> The offsets could vary across versions of this IP and that is the reason
> to provide them through the DT and not define any such offsets.
> 

How many versions do you have and how much has it varied already ?
I am now getting a sense that it's mostly decided and fixed my the
firmware rather than at the time of hardware design.

-- 
Regards,
Sudeep
