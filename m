Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E284DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90035208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="uIq5pL6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90035208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verdurent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756087AbeFOL7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:59:17 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40159 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755749AbeFOL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:59:14 -0400
Received: by mail-ot0-f195.google.com with SMTP id w9-v6so10673443otj.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qO5tYa+yVX6+/5N8xOHDFUr2WpgqS39u7NioWeqCejE=;
        b=uIq5pL6qs6gOj/mV6cGtp7MnO4xybX44qTw+R6A5S6n9E3jStPcYThlJ6aYDJjesIs
         nmMqYWKdp99xz+cJ0BzsPWdc2gqprLLCF06w5j0Rm91/y6GIxKQf9hCabcmi1mhlSUVk
         fbvWdZ7TW/gsXLM7I4jPGwiEM5wjrdveHK0VTQX3uw91R7OLgWYjnHK7pnLCNR7XbLH6
         HbBW8TxUIgbRUVABIjibbxC6mVKP5T762h6kDmnVLzm7GoT98o1M4QYsAEVA69KmhKO/
         jTXZwQdV5+eUPX4AmwaXG3iFGrienogcU3Xun2/d394J+7FQshwOks4co6n3dWytllzX
         H6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qO5tYa+yVX6+/5N8xOHDFUr2WpgqS39u7NioWeqCejE=;
        b=kBknaTTUB5zgBbZoHqoFRpe8yTO+0dCmgedRViC26Y9n7eJFDe+rwK7w32DNBBxfiF
         Ohys1m++N5w9O/o+bYZLZNmXxZVn7CmLOk2fPbQH5Z/8G/mWOjiKj3ykdi26qvzJImO8
         fjA3CwAXLRQFvqYIobB29cBXvqK4d3+rizTBaMFgBiIgAFUQnXRf9ltDK15jX/Iz8YDZ
         UhKa+33dBmrpLtenTpSLMtDZhdeZ6ABcz/ZOxuCkg+aHbWyVoQuI457vRptKDBsldl25
         1TCkOHqvNvnSWp82G8fXRVi3/WXQof+htkMDygnRYAwwILQU5RgvPnCDwEoScR647Tko
         Yc+Q==
X-Gm-Message-State: APt69E2PrZYZVB8Bhw/Edr7tCo9Ogh2LzhPex4GpGPuLwRWbMPKnT0oN
        GjZdLySc2yKKlXfT2+vdr1jQslSxPObmwgZYvzsAAX29sjk=
X-Google-Smtp-Source: ADUXVKIvrDxVM14zebs/WoFlYWvWiKSj2nx5AuVfrRPraw9/lJApqHpmSAEIlaXFxuKuKZplbwpyZqdf7QRlyR+l84I=
X-Received: by 2002:a9d:577d:: with SMTP id x58-v6mr854721oti.196.1529063953965;
 Fri, 15 Jun 2018 04:59:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:99ab:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 04:59:13
 -0700 (PDT)
In-Reply-To: <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org> <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org> <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 15 Jun 2018 14:59:13 +0300
Message-ID: <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
To:     Taniya Das <tdas@codeaurora.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 9:24 PM, Taniya Das <tdas@codeaurora.org> wrote:

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
>>>> Eg. Suppose you need some information on power curve for EAS energy
>>>> model, I really hate to update DT for that or even do a mix with DT just
>>>> because f/w is no longer modifiable.
>>>>
>>>
>>> For now we are safe.
>>>
>>
>> What do you mean by that ?
>
>
> I meant here was currently there is no such known case where the f/w is no
> longer modifiable and we need to extend device tree bindings.
>
>> It should be easily extensible is what I am
>> trying to say. You can add more info and alter the information in the
>> driver with compatibles if you keep the register info as minimum as
>> possible. For now, you have enable, set and lut registers. What if you
>> want to provide power numbers ?
>>
>
> Yes I do understand the intent of mapping the whole register space, but as
> per the HW specs these 3 registers would be the only ones required for now.
> I do not think this hardware engine has any information on the power
> numbers.

"For now" - I think this is exactly the point that Sudeep is trying to make.

A future version of the HW engine, or more likely, a firmware
revision, will make more functionality available. Say, this needs
access to another register or two. This will require changing the DT
bindings. Instead, if you map the entire address space, you can just
add offsets to the new registers.

So in this case, I think you should define the following addresses
(size 0x1400) for the two frequency domains

0x17d43000, 0x1400 (power cluster)
0x17d45800, 0x1400 (perf cluster)

And in the driver simply add offsets as follows:

#define ENABLE_OFFSET               0x0
#define LUT_OFFSET                      0x110
#define PERF_DESIRED_OFFSET 0x920

This will allow you add any new registers in the future w/o modifying
the DT binding and reduce qcom_cpu_resources_init() to a handful of
lines since you no longer need so many OF string matches, and
devm_ioremap()s.

Regards,
Amit
