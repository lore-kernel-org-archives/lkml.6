Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54397C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A8520855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AmbqN2sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfAXMJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:09:54 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40680 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfAXMJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:09:53 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0OC9NPW064915;
        Thu, 24 Jan 2019 06:09:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548331763;
        bh=f5PVU+IUWZvcFkA+hQt3TkhQObXkhBmktE8Yz1JgR7g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AmbqN2sdyRBrS5POmU2Bp67Xv6appsIujc+6806lEU398TjZnVQFJ4lWn6dK28Jkt
         iSAaDid1J4nmM4tBBbP8m4Tz0rNczgn9RQ2qBTIgHcnyE3rOxNJfSQ5QNLzmvWFomS
         uDq7bAuAqwFpEcv5E1QGBHY3qBONRz8AAdWp2Jg0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0OC9NcE089009
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 06:09:23 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 06:09:23 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 06:09:23 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0OC9Jm9022276;
        Thu, 24 Jan 2019 06:09:20 -0600
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-3-brgl@bgdev.pl>
 <08200de1-fde5-c525-c874-c7872259067b@ti.com>
 <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
 <a7d4994d-7740-c845-da67-9d06e6d874cc@ti.com>
 <d9bc1153-3b65-19a8-67ef-e131296cd8b1@ti.com>
 <CAMRc=McPCJxd7i7Ei+xOKOXYhYZgC=MYYFwyn2zAjStQov91fw@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <06da1719-26d6-19b0-97f5-ef4bb976e444@ti.com>
Date:   Thu, 24 Jan 2019 17:39:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=McPCJxd7i7Ei+xOKOXYhYZgC=MYYFwyn2zAjStQov91fw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/19 7:31 PM, Bartosz Golaszewski wrote:
> czw., 17 sty 2019 o 13:42 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>
>> On 16/01/19 2:48 PM, Sekhar Nori wrote:
>>> On 14/01/19 10:09 PM, Bartosz Golaszewski wrote:
>>>> pon., 14 sty 2019 o 13:20 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>>>>
>>>>> Hi Bartosz,
>>>>>
>>>>> On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
>>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>>
>>>>>> Currently the clocksource and clockevent support for davinci platforms
>>>>>> lives in mach-davinci. It hard-codes many things, used global variables,
>>>>>> implements functionalities unused by any platform and has code fragments
>>>>>> scattered across many (often unrelated) files.
>>>>>>
>>>>>> Implement a new, modern and simplified timer driver and put it into
>>>>>> drivers/clocksource. We still need to support legacy board files so
>>>>>> export a config structure and a function that allows machine code to
>>>>>> register the timer.
>>>>>>
>>>>>> We don't check the return values of regmap reads and writes since with
>>>>>> mmio it's only likely to fail due to programmer's errors.
>>>>>>
>>>>>> We also don't bother freeing resources on errors in
>>>>>> davinci_timer_register() as the system won't boot without a timer anyway.
>>>>>>
>>>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>
>>>>> With this series, DA830 fails to boot. Rest of the devices are okay from
>>>>> boot perspective.
>>>>>
>>>>> DA830 is pretty unique because it uses the same timer-half for both
>>>>> clocksource and clockevent. May be you can set the same configuration on
>>>>> your DA850 to see the same issue? Else, I will enable low-level debug
>>>>> and try to provide more debug data.
>>>>>
>>>>
>>>> I can't boot da850 with the same config as da830 (0x60 compare
>>>> register, compare irq 74) even with the old timer code. Just to make
>>>> sure: does da830 boot fine with mainline v5.0-rc2?
>>>
>>> Yeah, I did check that without the patch DA830 does boot.
>>
>> You are right that DA850 lacks compare interrupts for timers 0 and 1.
>> So, yes, it seems like we will have to shift to timer2 to test
>> compare interrupts on DA850.
>>
> 
> Timers 2 and 3 are a bit different on da850 - for instance they don't
> have separate interrupts for bottom and top halfs.

We should only be using the compare feature which has a a separate
interrupt (distinct from top and bottom half interrupts). Only timer 2
and 3 of DA850 have the compare interrupts though. So you will have to
use those timers to be able to test compare feature on DA850.

> 
> I configured the old code to use timer 2 - bottom half only with
> compare register 0x60 and compare intterupt 74. It boots although very
> slowly and something's broken with timekeeping as the clock goes
> backwards and forward (seemingly) randomly.

Ah, okay. Timer 2/3 use ASYNC3 as clock input instead of PLL0_AUXCLK.
Did you make adjustment for this too?

> 
> Kevin has an OMAP-L137 starter kit - is this the same as da830-evm? If

Yes.

> so, then I can get remote access to it and work on this problem.
> Otherwise, I can prepare something that works on da850 with broken
> timekeeping and let you see if it works correctly on da830.

Alright, happy to test.

Thanks,
Sekhar
