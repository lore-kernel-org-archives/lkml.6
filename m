Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE62DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 09:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B222086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 09:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="OVc3FLqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B222086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verdurent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933012AbeFQJDg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 05:03:36 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38477 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932584AbeFQJDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 05:03:33 -0400
Received: by mail-oi0-f65.google.com with SMTP id d5-v6so12360751oib.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J9blaTeay4HHlQLAMF6gGgGi+/0gngDH6zC5wS9qw9I=;
        b=OVc3FLqx+hl7U0egNU+Z1nKg1U37xFbXtsVujy030J9tRi6dGkLrn3i88sKjZxH6QI
         0etqEkt7sH2WUxCh3I04rkQ/2XIEQi35wzsbgOP9jbkK4iee00nq4vhlKYnMsKmsQ7RP
         yoC2ZP/z3xmudJ3lpF67FGrZZLHQE+iOLQGSjiLFXgJfpPc2GHNjeeqDZFeKMdIsVp/2
         oDzgn42fE+lY++ClYUOVpEt5g0jcTp1TF40xooSXwq7zBuck3raaKB5UAQFwwfquG1pW
         rWkpD1ex9v1xE3By5HKgcZjvfpCms7jNdhjnDQKgt7MQPOq/LlExbNx2/sfYb7qaUAAH
         Hnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J9blaTeay4HHlQLAMF6gGgGi+/0gngDH6zC5wS9qw9I=;
        b=shs6xlswzlidg9l7dAQ7PUmKoY8G/4v4pQdwRaWE0chD/5ZU7yiEQGIqrlK4hSWk9v
         Bdi2UhWuJ6fwxcnOiSqhqr/UANmo1l1W2trjDndL9nSynMiNN1sN1nZE5DmHKmA8YgK3
         Z3NdwSnmxJpDuSn8fcb3uF2eXH4Nwtpel5HPuiKRhuTNyVbttp/cQILBh3ZOkIYJUCqh
         lT9RuRz1gc1SFcp5QV/Ze+pjywJF0EBEkrd/tQwfq376RRSsVozcPz5Fv5deLPuyLxHp
         ACkU2f65aYAOvplepxvPlaiF1H5FCdpJH6kDvWQWBWBgVUs0TlnFDO597qupZelRK9eD
         23Yw==
X-Gm-Message-State: APt69E1wh6Eoz4pmMsl2pT+Ny+QkFo5rwC6BZww6crihe0Nn0LL9Y2aA
        t0EZwY/e8OpFh6H5MS9aiXWJ1cToZzFyb2XZbW6N1Q==
X-Google-Smtp-Source: ADUXVKLq+sgiYWEr9J/vUKQkeGh02Vb6Ta7vXBvngStJ2SQhlvDo9tCC7/rH7d6EdracC1mRmu6gHx8pSL73tnfP4fo=
X-Received: by 2002:aca:654d:: with SMTP id j13-v6mr4876307oiw.0.1529226212333;
 Sun, 17 Jun 2018 02:03:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:99ab:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 02:03:31
 -0700 (PDT)
In-Reply-To: <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org> <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org> <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org> <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
 <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sun, 17 Jun 2018 12:03:31 +0300
Message-ID: <CAHLCerNQ8Zy8xTbn3h6t7FvuB6Nvq1F14M8=UfnmChUBLKOvSw@mail.gmail.com>
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

On Fri, Jun 15, 2018 at 8:40 PM, Taniya Das <tdas@codeaurora.org> wrote:
>
>
> On 6/15/2018 5:29 PM, Amit Kucheria wrote:
>>
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
>>>> page aligned and spiting the registers and mapping them individually may
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
>>>>>> model, I really hate to update DT for that or even do a mix with DT
>>>>>> just
>>>>>> because f/w is no longer modifiable.
>>>>>>
>>>>>
>>>>> For now we are safe.
>>>>>
>>>>
>>>> What do you mean by that ?
>>>
>>>
>>>
>>> I meant here was currently there is no such known case where the f/w is
>>> no
>>> longer modifiable and we need to extend device tree bindings.
>>>
>>>> It should be easily extensible is what I am
>>>> trying to say. You can add more info and alter the information in the
>>>> driver with compatibles if you keep the register info as minimum as
>>>> possible. For now, you have enable, set and lut registers. What if you
>>>> want to provide power numbers ?
>>>>
>>>
>>> Yes I do understand the intent of mapping the whole register space, but
>>> as
>>> per the HW specs these 3 registers would be the only ones required for
>>> now.
>>> I do not think this hardware engine has any information on the power
>>> numbers.
>>
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
>> #define ENABLE_OFFSET               0x0
>> #define LUT_OFFSET                      0x110
>> #define PERF_DESIRED_OFFSET 0x920
>>
>
> The offsets could vary across versions of this IP and that is the reason to
> provide them through the DT and not define any such offsets.

If that is a known fact internally, you should already introduce
versioning information in the DT. e.g qcom,cpufreq-fw-v1. This will
give you the ability to deal with IP versions across SoC families.

We're currently trying to do the same thing for the TSENS IP.

Regards,
Amit
