Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66186C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203E220831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rMoJPx9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203E220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeKTVnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:43:01 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3282 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbeKTVm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:42:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf3ec970000>; Tue, 20 Nov 2018 03:14:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Nov 2018 03:14:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Nov 2018 03:14:22 -0800
Received: from [10.26.11.164] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 11:14:19 +0000
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
To:     Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com> <20181119171406.GQ53235@atomide.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
Date:   Tue, 20 Nov 2018 11:14:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119171406.GQ53235@atomide.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542712471; bh=paBaZD/hdUpVreNEhq7MCPMxKPDZUaiDaFrGMXddyJU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rMoJPx9HdHVMeGauON0ZpSQ6QdvCJmF7Ba5DNF4dWvXvCtiei9xVY/ZfzuaqLLbFD
         cmtZr3Fn9XtHeVthKYD8P5IZlD7+pNE7szyGC80M/r33i1rSE35oWGybfnc8Uc3FAr
         GzAQ6GzDrcjMZmnRCpWYB2cMGHquCDkqIF12IgYH3xGFp7A+FYBmV/rjBMGkoeoKFk
         7V6gArhDH2snKrTG4Z92sf3PaYRCA4DcobyZfBafSJxb1RvhhUZ625/9Jk8rxFngFF
         JoSUC2DAYH4lrXJPw/wMGNB/1kzeFl6BThVaYuH1iNSuN3zYfrgjNBUdvcydRu4DCv
         KnrqfHCCqmgqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/11/2018 17:14, Tony Lindgren wrote:
> Hi,
> 
> * Tony Lindgren <tony@atomide.com> [181119 16:19]:
>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [181119 10:16]:
>>> On 2018-11-13 20:06, Tony Lindgren wrote:
>>>> Looks like the IRQ_TYPE_NONE issue still is there for omap5 and
>>>> should be fixed with IRQ_TYPE_HIGH.
>>>>
>>>> No idea about why palmas interrupts would stop working though,
>>>> Peter, do you have any ideas on this one?
>>>
>>> No, I don't.
>>> The INT polarity can be changed in Palmas.
>>> based on the pdata->irq_flags (queried via irqd_get_trigger_type())
>>> the code  configures it:
>>>
>>> if (pdata->irq_flags & IRQ_TYPE_LEVEL_HIGH)
>>> 	reg = PALMAS_POLARITY_CTRL_INT_POLARITY;
>>> else
>>> 	reg = 0;
>>>
>>> and we pass the same irq_flags to the regmap_add_irq_chip()
>>> IRQ_TYPE_LEVEL_HIGH == IRQF_TRIGGER_HIGH == 0x00000004
>>>
>>> A change in DT should be enough, no need to patch palmas.c, imho.
>>
>> But it's not. I'm now wondering if wakeupgen is inverting the
>> polarity for this interrupt?
>>
>> GIC docs say this about SPI interrupts:
>>
>> "SPI is triggered on a rising edge or is active-HIGH level-sensitive."
>>
>> So when setting IRQ_TYPE_LEVEL_HIGH in dts, we still must not
>> invert the polarity in palmas while tegra needs to. So either
>> tegra114 hardware is inverting the polarity, or omap5 wakeupgen
>> is.
>>
>> Does the palmas trm say which way PALMAS_POLARITY_CTRL
>> triggers if PALMAS_POLARITY_CTRL_INT_POLARITY is set?
>>
>> Also note that dra7 is using a gpio for palmas interrupt.
> 
> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
> Tegra114 PMIC interrupt") states that tegra114 inverts the
> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.

Yes Tegra can invert the polarity of the PMIC interrupt.

> So it seems that commit df545d1cd01a ("mfd: palmas: Provide
> irq flags through DT/platform data") wrongly sets the
> PALMAS_POLARITY_CTRL_INT_POLARITY on IRQ_TYPE_LEVEL_HIGH
> while it should set it on IRQ_TYPE_LEVEL_LOW.
> 
> I think the fix needs to set the polarity using
> of_machine_is_compatible() and probably also add a new
> compatible to palmas.c for "ti,palmas-tegra114" to properly
> deal with the inverted interrupt. Or add a property for
> "interrupt-inverted". In any case, it seems that the
> of_machine_is_compatible() is also needed too to avoid
> breaking use with dtb files.
> 
> Jon & Thierry, can you guys please check and confirm this?
I don't fully understand what is being discussed here, but my
understanding is that the palmas interrupt is active low.

Let me know if this helps.

Cheers
Jon

-- 
nvpublic
