Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C12AAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C105208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C105208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754979AbeFNKri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:47:38 -0400
Received: from foss.arm.com ([217.140.101.70]:57936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754794AbeFNKrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:47:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 802DF1529;
        Thu, 14 Jun 2018 03:47:35 -0700 (PDT)
Received: from [10.1.210.28] (e107155-lin.cambridge.arm.com [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D8FB3F59D;
        Thu, 14 Jun 2018 03:47:33 -0700 (PDT)
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
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
Date:   Thu, 14 Jun 2018 11:47:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/06/18 19:13, Taniya Das wrote:
> Hello Sudeep,
> 
> Thanks for review comments.
> 
> On 6/13/2018 4:56 PM, Sudeep Holla wrote:
>>
>>

[...]

>> You are bit inconsistent on the wordings. Some places you refer this as
>> hardware engine. If so, please drop all references to firmware/FW. If
>> it's firmware then update accordingly.
>>
> 
> It is a hardware engine which has a firmware to take care of the
> managing the frequency request from OS. That is reason to refer it as a
> firmware.
> 

Yes I did guess that initially, but I failed to understand when
different bindings were posted to deal with devfreq and cpufreq with the
same firmware. Ideally if it's the firmware you are talking to, place
all these under /firmware node and align all those with single binding.

Is there anything else that this firmware deals with ? If so all those
need to be put in one place.

>>> +Properties:
>>> +- compatible
>>> +    Usage:        required
>>> +    Value type:    <string>
>>> +    Definition:    must be "qcom,cpufreq-fw".
>>> +
>>> +* Property qcom,freq-domain
>>> +Devices supporting freq-domain must set their "qcom,freq-domain"
>>> property with
>>> +phandle to a freq_domain_table in their DT node.
>>> +
>>> +* Frequency Domain Table Node
>>> +
>>> +This describes the frequency domain belonging to a device.
>>> +This node can have following properties:
>>> +
>>> +- reg
>>> +    Usage:        required
>>> +    Value type:    <prop-encoded-array>
>>> +    Definition:    Addresses and sizes for the memory of the perf
>>> +            , lut and enable bases.
>>> +            perf - indicates the base address for the desired
>>> +            performance state to be set.
>>> +            lut - indicates the look up table base address for the
>>> +            cpufreq    driver to read frequencies.
>>> +            enable - indicates the enable register for firmware.
>>
>>
>> You still didn't answer my earlier question.
>>
>> OS might touch one or 2 registers in lots of IP blocks. I am not sure
>> why those are any different from these. Are you trying to align with any
>> other bindings or specification. Are you trying to make this binding
>> generic here ? I understand if it was trying to generalize the firmware
>> interface, but you also state it's a hardware engine. So I fail to see
>> the need for such specificity here. Why not define the whole IP block
>> and the driver knows where to access these specific ones as they are
>> specific to this hardware block. In that way if you decide to add more
>> data, it's extensible easily without the need for patching DT.
>>
> 
> Sorry Sudeep I missed replying to your earlier query.
> The High level OS(HLOS) would require to access only these specific
> registers from this IP block and just mapping the whole block(huge
> region) is unnecessary from the OS point of View. As of now it is a
> generic binding for all using this IP block to manage frequency
> requests. The OS would only have to know the frequencies supported i.e
> to read the lookup table registers and put across the OS request using
> the performance state register.
> 

I am not sure if you need to defining bindings to save OSPM IO mapping.
In-fact you may be adding more mapping unnecessarily. The mappings are
page aligned and spiting the registers and mapping them individually may
result in more mappings.

I just need to know the rational for such specific choice of registers.
I assume it's aligned to some other standard specifications like CPPC
though not identical.

>> Eg. Suppose you need some information on power curve for EAS energy
>> model, I really hate to update DT for that or even do a mix with DT just
>> because f/w is no longer modifiable.
>>
> 
> For now we are safe.
> 

What do you mean by that ? It should be easily extensible is what I am
trying to say. You can add more info and alter the information in the
driver with compatibles if you keep the register info as minimum as
possible. For now, you have enable, set and lut registers. What if you
want to provide power numbers ?

-- 
Regards,
Sudeep
