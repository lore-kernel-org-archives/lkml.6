Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872F5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE2D20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LHEtVRLo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KqU+Wqsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE2D20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966267AbeFORkX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:40:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966130AbeFORkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:40:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3174D60861; Fri, 15 Jun 2018 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529084419;
        bh=bkohI7Ti60axuK6tKD7cGnj4xNtxediiBSIUSe+a0o0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LHEtVRLopdVr+oT4XByJhDroz6Iv19WeC0Qz6LzXuRl8z1Ur61lIdc3cgOXJrOcgv
         fYEdSAFF2uIvo3VqUVXxCZbZzwXJebKfkvEfGQXoe6Itaf/uBYJlwotMRcjXIjqeWA
         SDBXqfOA4XQaLXgvHMTGBfamhgKQprzuTn1mF2u8=
Received: from [192.168.225.247] (unknown [49.32.132.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D7AA60116;
        Fri, 15 Jun 2018 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529084416;
        bh=bkohI7Ti60axuK6tKD7cGnj4xNtxediiBSIUSe+a0o0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KqU+Wqsy+ygTP/yzUWw/O7635tazLNu/bAAFbmOqfMeuS5xtphbHqpLgmPupoKfjU
         Cbd2CORPisgMw48E+aGy9eKlL8froKH2IAAXL3NIRJtePXEm6lByC6heCuyER5Tc5c
         R53dZtI/TWa/F0v4sc2Te+BvfEBHOCMAAM/19nTU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D7AA60116
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To:     Amit Kucheria <amit.kucheria@verdurent.com>
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
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
Date:   Fri, 15 Jun 2018 23:10:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2018 5:29 PM, Amit Kucheria wrote:
> On Thu, Jun 14, 2018 at 9:24 PM, Taniya Das <tdas@codeaurora.org> wrote:
> 
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
>>>>> Eg. Suppose you need some information on power curve for EAS energy
>>>>> model, I really hate to update DT for that or even do a mix with DT just
>>>>> because f/w is no longer modifiable.
>>>>>
>>>>
>>>> For now we are safe.
>>>>
>>>
>>> What do you mean by that ?
>>
>>
>> I meant here was currently there is no such known case where the f/w is no
>> longer modifiable and we need to extend device tree bindings.
>>
>>> It should be easily extensible is what I am
>>> trying to say. You can add more info and alter the information in the
>>> driver with compatibles if you keep the register info as minimum as
>>> possible. For now, you have enable, set and lut registers. What if you
>>> want to provide power numbers ?
>>>
>>
>> Yes I do understand the intent of mapping the whole register space, but as
>> per the HW specs these 3 registers would be the only ones required for now.
>> I do not think this hardware engine has any information on the power
>> numbers.
> 
> "For now" - I think this is exactly the point that Sudeep is trying to make.
> 
> A future version of the HW engine, or more likely, a firmware
> revision, will make more functionality available. Say, this needs
> access to another register or two. This will require changing the DT
> bindings. Instead, if you map the entire address space, you can just
> add offsets to the new registers.
> 
> So in this case, I think you should define the following addresses
> (size 0x1400) for the two frequency domains
> 
> 0x17d43000, 0x1400 (power cluster)
> 0x17d45800, 0x1400 (perf cluster)
> 
> And in the driver simply add offsets as follows:
> 
> #define ENABLE_OFFSET               0x0
> #define LUT_OFFSET                      0x110
> #define PERF_DESIRED_OFFSET 0x920
> 

The offsets could vary across versions of this IP and that is the reason 
to provide them through the DT and not define any such offsets.

> This will allow you add any new registers in the future w/o modifying
> the DT binding and reduce qcom_cpu_resources_init() to a handful of
> lines since you no longer need so many OF string matches, and
> devm_ioremap()s.
> 
> Regards,
> Amit
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
