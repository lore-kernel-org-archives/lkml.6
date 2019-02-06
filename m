Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5C1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05152075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tafc+u63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfBFOwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:52:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60804 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfBFOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:52:02 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16EosYP021591;
        Wed, 6 Feb 2019 08:50:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549464654;
        bh=oy2ChVmX2j5Tfb7NSqZbTsnzgnMLWzokfQv3Mlcq3zs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tafc+u630pEqh3ivbKrNtG/Z5HwX4OZZx7WLLgDeEFYoif+YoVg2cdXjvfUNBOvwk
         PlWf88m08u8I599VasxNLUwZcNnm9yCv9SBOvz7g9GA/0/pT5dQklrm2MzoDG/muQU
         t3kOud2FIZ+Kp8yrBJkGIx7EELQUjjbbpILFPouE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16EosdQ084225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 08:50:54 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 08:50:53 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 08:50:53 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16EooIb025225;
        Wed, 6 Feb 2019 08:50:51 -0600
Subject: Re: [PATCH 05/35] ARM: davinci: drop irq defines from
 default_priorites
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
CC:     David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-6-brgl@bgdev.pl>
 <3038ba79-f411-9aa1-00ec-689060ed13d4@lechnology.com>
 <21c3d8cd-f767-04bc-f4d8-3001405ffd1d@ti.com>
 <CAMpxmJWU6WRK70xNN72Ke2kXi6F-uLWrCpF+K-+qKX3DcRy7uw@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <9fd8f5ec-7d5f-3d05-2141-65c1b4d02c87@ti.com>
Date:   Wed, 6 Feb 2019 20:20:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJWU6WRK70xNN72Ke2kXi6F-uLWrCpF+K-+qKX3DcRy7uw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/19 7:02 PM, Bartosz Golaszewski wrote:
> śr., 6 lut 2019 o 14:03 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>
>> On 05/02/19 3:51 AM, David Lechner wrote:
>>> On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> In order to select SPARSE_IRQ we need to make the interrupt numbers
>>>> dynamic (at least at build-time for the top-level controller). The
>>>> interrupt numbers are used as array indexes for irq priorities.
>>>>
>>>> Drop the defines and just initialize the arrays in a linear manner.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>> ---
>>>
>>> ...
>>>
>>>> -static u8 dm355_default_priorities[DAVINCI_N_AINTC_IRQ] = {
>>>> -    [IRQ_DM355_CCDC_VDINT0]        = 2,
>>>> -    [IRQ_DM355_CCDC_VDINT1]        = 6,
>>>> -    [IRQ_DM355_CCDC_VDINT2]        = 6,
>>>> -    [IRQ_DM355_IPIPE_HST]        = 6,
>>>> -    [IRQ_DM355_H3AINT]        = 6,
>>>> -    [IRQ_DM355_IPIPE_SDR]        = 6,
>>>> -    [IRQ_DM355_IPIPEIFINT]        = 6,
>>>> -    [IRQ_DM355_OSDINT]        = 7,
>>>> -    [IRQ_DM355_VENCINT]        = 6,
>>>> -    [IRQ_ASQINT]            = 6,
>>>> -    [IRQ_IMXINT]            = 6,
>>>> -    [IRQ_USBINT]            = 4,
>>>> -    [IRQ_DM355_RTOINT]        = 4,
>>>> -    [IRQ_DM355_UARTINT2]        = 7,
>>>> -    [IRQ_DM355_TINT6]        = 7,
>>>> -    [IRQ_CCINT0]            = 5,    /* dma */
>>>> -    [IRQ_CCERRINT]            = 5,    /* dma */
>>>> -    [IRQ_TCERRINT0]            = 5,    /* dma */
>>>> -    [IRQ_TCERRINT]            = 5,    /* dma */
>>>> -    [IRQ_DM355_SPINT2_1]        = 7,
>>>> -    [IRQ_DM355_TINT7]        = 4,
>>>> -    [IRQ_DM355_SDIOINT0]        = 7,
>>>> -    [IRQ_MBXINT]            = 7,
>>>> -    [IRQ_MBRINT]            = 7,
>>>> -    [IRQ_MMCINT]            = 7,
>>>> -    [IRQ_DM355_MMCINT1]        = 7,
>>>> -    [IRQ_DM355_PWMINT3]        = 7,
>>>> -    [IRQ_DDRINT]            = 7,
>>>> -    [IRQ_AEMIFINT]            = 7,
>>>> -    [IRQ_DM355_SDIOINT1]        = 4,
>>>> -    [IRQ_TINT0_TINT12]        = 2,    /* clockevent */
>>>> -    [IRQ_TINT0_TINT34]        = 2,    /* clocksource */
>>>> -    [IRQ_TINT1_TINT12]        = 7,    /* DSP timer */
>>>> -    [IRQ_TINT1_TINT34]        = 7,    /* system tick */
>>>> -    [IRQ_PWMINT0]            = 7,
>>>> -    [IRQ_PWMINT1]            = 7,
>>>> -    [IRQ_PWMINT2]            = 7,
>>>> -    [IRQ_I2C]            = 3,
>>>> -    [IRQ_UARTINT0]            = 3,
>>>> -    [IRQ_UARTINT1]            = 3,
>>>> -    [IRQ_DM355_SPINT0_0]        = 3,
>>>> -    [IRQ_DM355_SPINT0_1]        = 3,
>>>> -    [IRQ_DM355_GPIO0]        = 3,
>>>> -    [IRQ_DM355_GPIO1]        = 7,
>>>> -    [IRQ_DM355_GPIO2]        = 4,
>>>> -    [IRQ_DM355_GPIO3]        = 4,
>>>> -    [IRQ_DM355_GPIO4]        = 7,
>>>> -    [IRQ_DM355_GPIO5]        = 7,
>>>> -    [IRQ_DM355_GPIO6]        = 7,
>>>> -    [IRQ_DM355_GPIO7]        = 7,
>>>> -    [IRQ_DM355_GPIO8]        = 7,
>>>> -    [IRQ_DM355_GPIO9]        = 7,
>>>> -    [IRQ_DM355_GPIOBNK0]        = 7,
>>>> -    [IRQ_DM355_GPIOBNK1]        = 7,
>>>> -    [IRQ_DM355_GPIOBNK2]        = 7,
>>>> -    [IRQ_DM355_GPIOBNK3]        = 7,
>>>> -    [IRQ_DM355_GPIOBNK4]        = 7,
>>>> -    [IRQ_DM355_GPIOBNK5]        = 7,
>>>> -    [IRQ_DM355_GPIOBNK6]        = 7,
>>>> -    [IRQ_COMMTX]            = 7,
>>>> -    [IRQ_COMMRX]            = 7,
>>>> -    [IRQ_EMUINT]            = 7,
>>>> +static u8 dm355_aintc_prios[] = {
>>>> +    2, 6, 6, 6, 6, 6, 6, 7,
>>>> +    6, 6, 6, 4, 4, 7, 7, 5,
>>>> +    5, 5, 5, 7, 4, 7, 7, 7,
>>>> +    7, 7, 7, 7, 7, 4, 2, 2,
>>>> +    7, 7, 7, 7, 7, 3, 3, 3,
>>>> +    3, 3, 3, 7, 4, 4, 7, 7,
>>>> +    7, 7, 7, 7, 7, 7, 7, 7,
>>>> +    7, 7, 7, 7, 7, 7, 0, 0,
>>>>   };
>>>
>>> Hmm... this makes it harder to see what is going on here.
>>> You can no longer see which priority corresponds to which
>>> IRQ without consulting a manual.
>>
>> I agree with David here. The interrupt numbers are dynamic, but the
>> interrupt number offset from hardware point-of-view is fixed. So can
>> these macros be re-purposed to represent the hardware offset (eventually
>> you would pass them to DAVINCI_INTC_IRQ())?
>>
>> Thanks,
>> Sekhar
> 
> Should we keep the mach/irqs.h header then? While working on patches
> for supporting the multi_v5_defconfig build I noticed the mach/*
> headers tend to cause build problems in certain drivers that use them.
> Most machines have gotten rid of them. Should we maybe create a local
> header in mach-davinci/?

Yes, we should have a local header in mach-davinci. It should not be in
include/mach/ so it should not be exposed to drivers.

Thanks,
Sekhar
