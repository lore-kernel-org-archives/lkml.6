Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C269AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E40D2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c9lR80rE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QeE4MZw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E40D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966017AbeFSKpA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:45:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56380 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965682AbeFSKo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:44:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2C62560B13; Tue, 19 Jun 2018 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529405098;
        bh=ltLiBfvDKqgAdaSq1G5nCZyyO5SFmsoKqva76M8/720=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c9lR80rEC1HmKDy6GaHcDXN1UbnT96lGnZclKcTV2yThOzhrxE6FfTMwUlVTVXGJx
         rcNs329d4aZzVWE42ZJNsTYhMBP2aB/z09zYGg2pXvJvRlvn6P3Tg6csYeishT+XVz
         884STnGeA2WxDxKDE97E6LOj634qqTgDyq3+ubGo=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7E29604D4;
        Tue, 19 Jun 2018 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529405097;
        bh=ltLiBfvDKqgAdaSq1G5nCZyyO5SFmsoKqva76M8/720=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QeE4MZw4f8hTVX8Kwi+RQSfG8hvmuFoVqYbKX2CERBqFwjNVb/0bYq8hl5T6wfi1t
         vNPnNFYS55sioJugeKagsXDWEnsN/j+nIApKT7FMqnqBI/EPlN77mVZId7RZlnfAyZ
         1J5Sh5b6ZygliHw220CipItsxwFQ7kWoTO+lf16I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7E29604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
 <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
 <fad24065-bb2d-33f9-e877-425db3391e8f@arm.com>
 <514eea88-1f98-7959-2341-3d57cff6f66b@codeaurora.org>
 <f26813f1-f8da-ef92-fd86-6e648fbbf3e9@arm.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <2d37f581-38af-872a-36df-0250b0f7e411@codeaurora.org>
Date:   Tue, 19 Jun 2018 16:14:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f26813f1-f8da-ef92-fd86-6e648fbbf3e9@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2018 3:04 PM, Sudeep Holla wrote:
> 
> 
> On 19/06/18 08:53, Taniya Das wrote:
>>
>>
>> On 6/18/2018 2:51 PM, Sudeep Holla wrote:
>>>
>>>
>>> On 15/06/18 18:40, Taniya Das wrote:
>>>>
>>>>
>>>> On 6/15/2018 5:29 PM, Amit Kucheria wrote:
>>>
>>> [...]
>>>
>>>>> A future version of the HW engine, or more likely, a firmware
>>>>> revision, will make more functionality available. Say, this needs
>>>>> access to another register or two. This will require changing the DT
>>>>> bindings. Instead, if you map the entire address space, you can just
>>>>> add offsets to the new registers.
>>>>>
>>>>> So in this case, I think you should define the following addresses
>>>>> (size 0x1400) for the two frequency domains
>>>>>
>>>>> 0x17d43000, 0x1400 (power cluster)
>>>>> 0x17d45800, 0x1400 (perf cluster)
>>>>>
>>>>> And in the driver simply add offsets as follows:
>>>>>
>>>>> #define ENABLE_OFFSET               0x0
>>>>> #define LUT_OFFSET                      0x110
>>>>> #define PERF_DESIRED_OFFSET 0x920
>>>>>
>>>>
>>>> The offsets could vary across versions of this IP and that is the reason
>>>> to provide them through the DT and not define any such offsets.
>>>>
>>>
>>> Just get compatibles to identify the version of the hardware if it can't
>>> be probed and detected. Please don't use DT to get the addresses of each
>>> register you use in the driver. That's neither scalable nor nice
>>> solution to the problem.
>>> Hello Sudeep and Amit,
>>
>> Thanks for the comments, I am consolidating the understanding from the
>> other emails in a single one.
>>
>> I understand that you are looking for this IP to map the full region and
>> define offsets according to access them.
>>
>> But I still not sure how do you want this common driver to scale in the
>> cases where the offsets could vary across version change.
>>
> 
> There are plenty of drivers that you can look at as example. TBH most of
> the drivers implementing support for multiple versions of IP do
> something on the similar lines.
> 
>>   DT
>> ====
>>    freq-node {
>>      reg = < X x_size>;   Where X is the start of the IP address.
>>    }
>>
>> Driver code (The below representation is just for example).
>> =============
>>
>> V1
>> #define ENABLE    0x0
>> #define LUT_V1    0x110
>> #define PERF_V1    0x920
>>
>> V2
>> #define LUT_V2    0x150
>> #define PERF_V2    0x980
>>
>> V3
>> #define LUT_V3    0x120
>> ....
>>
>> Do you want me to use "compatible" flag to
>>
>> if (compatible == v1)
>>   enable =  readl_relaxed(X + LUT_V1);
>> else if (compatible == v2)
>>   enable = readl_relaxed(X + LUT_V2);
>> else if (compatible == v3)
>>   enable = readl_relaxed(X + LUT_V2);
>>
> 
> These are implementation details. But you should try to use compatibles
> only in probe and just record the version in some variable or update the
> offsets in some device specific structure so that you can use that
> unconditionally for any access you make on that device.
> 
>> With the current design I do not need such compatible checks and unmap
>> the ones which are not required after probe.
> 
> I am not sure what you mean by unmap after probe.
> 
>> Please let me know your comments.
>>
> 
> Please look at some drivers in the Linux tree for examples. Infact there
> may be few drivers on QCOM SoC itself. What I am suggesting is the normal
> practice in the drivers and you should see plenty of examples. Since I
> was looking at some serial port patch, I can say you can have a look at
> drivers/tty/serial/amba-pl011.c which supports multiple versions from
> different vendors. I am sure there are many simpler examples but AMBA PL011
> just stood out.
> 

Thanks Sudeep, let me take a look at the driver to see how I can 
associate data (offsets) based on compatible.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
