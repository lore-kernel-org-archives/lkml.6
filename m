Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A588FC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E1A20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bzqONYza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E1A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754524AbeFTRjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:39:25 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42310 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754459AbeFTRjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:39:21 -0400
Received: by mail-qt0-f195.google.com with SMTP id y31-v6so354020qty.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u3amQ0Y6ke8QrUCHqEhj0Q1D6sFxaCgw3tcWvBmCs2Y=;
        b=bzqONYzaQaApTy4s/npa4iZ+A0VyaZtLig0TdYDJydiIA3CIkBFL0P5Vo4GVrzlFzW
         yLTLPVxXZavsmllAH4OcXBQJT9XDVjGhE13sevEnEihmDyM2uYo/qPKpkPWs6uueX11p
         5FLvDD/BY8fIIi1tKEq7ZJ7Qg1Qmu0RA+vaoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u3amQ0Y6ke8QrUCHqEhj0Q1D6sFxaCgw3tcWvBmCs2Y=;
        b=bpfDalr0NLH/tCO7Wx/SEIoT7+zlPc3+FPrXq/f0/6mECOgCB3P58322HX06fLVp6+
         y552WB9zPySS00p9Lgo/Kh8FYtYt5LaSlAqgUNU0hzEAZn0mT8EgLpepDfZj8ecoml2l
         RQ5vFjI1t0G8gQuDvz/7gfvSRa/rpgYeGiaI+J4WIR7+tAkBZXjzpicmjcnubSHSyZYj
         ATVW9Muz98D2SN5tL+4AE9DhMvAQbe2BNfvbh9X8d2HVswWxTzrDREnjyjJ0yXbJvLeB
         7IRButDdqJDIaTU0AZBU1cd39ASY4Dxq+uSUmX9SpON5qvuzgj4D2cLBnHhgT3LcVPVP
         GNDA==
X-Gm-Message-State: APt69E0I4h/0tEapBWNzf966CGlwfsNHHLJZS53Y1C2jj8gP6cwyvXr/
        6X9SyADmSuAHHOOcLBlidZ5CSw==
X-Google-Smtp-Source: ADUXVKLQ9zvy7xAm71roaFB0sd0qUOdSYGv9nwmIRL14HuU4nqB0/B2rmOYJ2fIh034pzMuKMrwUIw==
X-Received: by 2002:ac8:2a07:: with SMTP id k7-v6mr20352893qtk.300.1529516360615;
        Wed, 20 Jun 2018 10:39:20 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id r1-v6sm2126022qke.14.2018.06.20.10.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:39:19 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] Documentation: DT: Consolidate SP805 binding docs
From:   Ray Jui <ray.jui@broadcom.com>
To:     Rob Herring <robh@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
 <20180605194124.GA26885@rob-hp-laptop>
 <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
 <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
 <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
Message-ID: <46ca340f-4347-94ca-6463-d38bece820e2@broadcom.com>
Date:   Wed, 20 Jun 2018 10:39:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter/Rob,

Kindly let me know how you want to proceed with this?

Thanks,

Ray

On 6/6/2018 4:39 PM, Ray Jui wrote:
> 
> 
> On 6/6/2018 9:33 AM, Rob Herring wrote:
>> On Wed, Jun 6, 2018 at 11:19 AM, Guenter Roeck <linux@roeck-us.net> 
>> wrote:
>>> On 06/05/2018 12:41 PM, Rob Herring wrote:
>>>>
>>>> On Mon, May 28, 2018 at 11:01:32AM -0700, Ray Jui wrote:
>>>>>
>>>>> Consolidate two SP805 binding documents "arm,sp805.txt" and
>>>>> "sp805-wdt.txt" into "arm,sp805.txt" that matches the naming of the
>>>>> desired compatible string to be used
>>>>>
>>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>>> ---
>>>>>    .../devicetree/bindings/watchdog/arm,sp805.txt     | 27
>>>>> ++++++++++++++-----
>>>>>    .../devicetree/bindings/watchdog/sp805-wdt.txt     | 31
>>>>> ----------------------
>>>>>    2 files changed, 20 insertions(+), 38 deletions(-)
>>>>>    delete mode 100644
>>>>> Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>>
>>>>
>>>> Would be good to get a ACK from FSL/NXP person on this. It looks to me
>>>> like the driver fetches the wrong clock as it gets the first one and 
>>>> the
>>>> driver really wants 'wdog_clk'. In any case, their dts files should be
>>>> updated.
>>>>
>>>
>>> This is really confusing, since he deleted file lists apb_pclk first.
>>> Does the watchdog driver need apb_pclk or wdog_clk ? That isn't clear 
>>> to me.
>>> arch/arm64/boot/dts/hisilicon/hi3660.dtsi only provides apb_pclk, or at
>>> least
>>> it says so.
>>
>> Note that that clock source is 32KHz. That is obviously a mistake
>> because no one clocks their bus/register interface at 32KHz. Someone
>> just filled in something that happened to work.
>>
>>> The fsl dts files all have apb_pclk first.
>>
>> It's all kind of a mess, but fortunately one we should be able to 
>> clean-up.
>>
> 
> It is indeed a mess. Note the SP805 driver only derive one clock from 
> DT, and that's not done based on name. As a result, the first clock 
> defined in DT will be fetched and the rate calculation will be carried 
> out based on that clock rate.
> 
> I assumed the clock entries and their names defined in the binding 
> document are just placeholders, at least for the 2nd clock.
> 
> Based on how the current driver is, the first clock needs to be the 
> WDOGCLK for things to work properly.
> 
> According to the SP805 TRM, APB clock is the PCLK, that drives the bus 
> for register access.
> 
> The relationship between WDOGCLK and PCLK is defined as:
> 
> - the rising edges of WDOGCLK must be synchronous and
> balanced with a rising edge of PCLK
> 
> - the WDOGCLK frequency cannot be greater than the PCLK
> frequency
> 
>> The compatible string changes too, but AMBA bus devices don't actually
>> use the compatible string as they use the ID registers to match. I
>> suppose some other OS could do things differently. Worth the risk to
>> clean-up IMO.
>>
>>>
>>> Either case, why are two clocks asked for in the first place ? Are there
>>> situations where the second clock is actually used/useful ?
>>
>> For clocks, the bus needs "apb_pclk" and the driver just gets the
>> first clock. The driver is obviously going to want the functional
>> clock that determines the counter rate. That should
>>
>> Primecell peripherals are about the only ones that have clear specs
>> WRT clock inputs. Yet we've still managed to screw them up. There are
>> 2 clocks in the spec, so the DT has (or should have) 2 clocks.
>>
>> Rob
>>
> 
> Let me know how you guys want to proceed with this?
> 
> Thanks,
> 
> Ray
