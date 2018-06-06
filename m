Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0c7VHaRwGFuWJAAAmS7hNA
	; Wed, 06 Jun 2018 23:39:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4CDDD608BA; Wed,  6 Jun 2018 23:39:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HjLLcqN1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B1BD0601D9;
	Wed,  6 Jun 2018 23:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1BD0601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFFXjN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:39:13 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36075 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752093AbeFFXjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:39:11 -0400
Received: by mail-qt0-f193.google.com with SMTP id o9-v6so8309385qtp.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 16:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p9uxZV2ri+UmZnxfCVXVdB+PFqy+VhAFhTcsJB69GAs=;
        b=HjLLcqN1JGnW53zUC3CMBnUSaqUAszsvWQec/GdsUBZG9IDkNnIYB22FcqXVoo21nq
         ae8nO1302mVRoGwdbyHGlNe3+jF5dkfmC9/168zRR3GtvXvpQYAvLXcR+tsbqFVpcdmW
         +xHqePGnIwmiEz6Gr4UQ4J2Qs0QOJjIq3T3rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p9uxZV2ri+UmZnxfCVXVdB+PFqy+VhAFhTcsJB69GAs=;
        b=IEQqeajB9S+LyHLW2m0gR+78Lst/smeLXrpYQY1IuqT8UJVwav2VDollG1S8JalWqN
         yP875oy/bdeVU9mWD76rMCVM66ss7SnSpqJ2xzJ3l0++0eqQluAgBIrsdiPMd/qqgnQQ
         xAuqsJOTGOHyNN0XYWOqY6+onilEnHppQV/qyxG2N3Q/k6YOFZxl8JETNP9+U1pa4R4A
         KGcONtq1Qa3zUq8BNeKKuHSxShoalXOVypiJADxAOryFCjA3OptR8akyOM9DzxdOOuQ7
         ptQBN1DUW77LqbRID8cFHFNJm0sh56iHtRxM8wlQZ6Dgk+N3l8YbfOXohruWujOCLnKP
         d7Tg==
X-Gm-Message-State: APt69E1rWuJ5n2/sr0b0/0hROftQW5Hgxgmm2XReNF7IEElgtk51Q4hw
        seshS4a5g3h6RCWiwOXz2YQqow==
X-Google-Smtp-Source: ADUXVKKq/xNV4yopMXcwQ74JDEVolqS62cGSM5p9pdBR39rcrMNDWKo6d02/j/Z7iqwiY0qln08n8w==
X-Received: by 2002:aed:35dc:: with SMTP id d28-v6mr4901246qte.294.1528328350337;
        Wed, 06 Jun 2018 16:39:10 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m63-v6sm13541633qke.9.2018.06.06.16.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 16:39:09 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] Documentation: DT: Consolidate SP805 binding docs
To: Rob Herring <robh@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
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
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
Date: Wed, 6 Jun 2018 16:39:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/2018 9:33 AM, Rob Herring wrote:
> On Wed, Jun 6, 2018 at 11:19 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 06/05/2018 12:41 PM, Rob Herring wrote:
>>>
>>> On Mon, May 28, 2018 at 11:01:32AM -0700, Ray Jui wrote:
>>>>
>>>> Consolidate two SP805 binding documents "arm,sp805.txt" and
>>>> "sp805-wdt.txt" into "arm,sp805.txt" that matches the naming of the
>>>> desired compatible string to be used
>>>>
>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>> ---
>>>>    .../devicetree/bindings/watchdog/arm,sp805.txt     | 27
>>>> ++++++++++++++-----
>>>>    .../devicetree/bindings/watchdog/sp805-wdt.txt     | 31
>>>> ----------------------
>>>>    2 files changed, 20 insertions(+), 38 deletions(-)
>>>>    delete mode 100644
>>>> Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>
>>>
>>> Would be good to get a ACK from FSL/NXP person on this. It looks to me
>>> like the driver fetches the wrong clock as it gets the first one and the
>>> driver really wants 'wdog_clk'. In any case, their dts files should be
>>> updated.
>>>
>>
>> This is really confusing, since he deleted file lists apb_pclk first.
>> Does the watchdog driver need apb_pclk or wdog_clk ? That isn't clear to me.
>> arch/arm64/boot/dts/hisilicon/hi3660.dtsi only provides apb_pclk, or at
>> least
>> it says so.
> 
> Note that that clock source is 32KHz. That is obviously a mistake
> because no one clocks their bus/register interface at 32KHz. Someone
> just filled in something that happened to work.
> 
>> The fsl dts files all have apb_pclk first.
> 
> It's all kind of a mess, but fortunately one we should be able to clean-up.
> 

It is indeed a mess. Note the SP805 driver only derive one clock from 
DT, and that's not done based on name. As a result, the first clock 
defined in DT will be fetched and the rate calculation will be carried 
out based on that clock rate.

I assumed the clock entries and their names defined in the binding 
document are just placeholders, at least for the 2nd clock.

Based on how the current driver is, the first clock needs to be the 
WDOGCLK for things to work properly.

According to the SP805 TRM, APB clock is the PCLK, that drives the bus 
for register access.

The relationship between WDOGCLK and PCLK is defined as:

- the rising edges of WDOGCLK must be synchronous and
balanced with a rising edge of PCLK

- the WDOGCLK frequency cannot be greater than the PCLK
frequency

> The compatible string changes too, but AMBA bus devices don't actually
> use the compatible string as they use the ID registers to match. I
> suppose some other OS could do things differently. Worth the risk to
> clean-up IMO.
> 
>>
>> Either case, why are two clocks asked for in the first place ? Are there
>> situations where the second clock is actually used/useful ?
> 
> For clocks, the bus needs "apb_pclk" and the driver just gets the
> first clock. The driver is obviously going to want the functional
> clock that determines the counter rate. That should
> 
> Primecell peripherals are about the only ones that have clear specs
> WRT clock inputs. Yet we've still managed to screw them up. There are
> 2 clocks in the spec, so the DT has (or should have) 2 clocks.
> 
> Rob
> 

Let me know how you guys want to proceed with this?

Thanks,

Ray
