Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA8FC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D0A2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="f8GNKaqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D0A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbeKTWwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:52:11 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5551 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbeKTWwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:52:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf3fcbe0000>; Tue, 20 Nov 2018 04:23:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Nov 2018 04:23:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Nov 2018 04:23:17 -0800
Received: from [10.19.64.176] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 12:23:14 +0000
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
To:     Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com> <20181119171406.GQ53235@atomide.com>
CC:     Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
From:   Laxman Dewangan <ldewangan@nvidia.com>
Message-ID: <3f2dc0f7-8f01-d6a1-bc0d-8c2586f6091b@nvidia.com>
Date:   Tue, 20 Nov 2018 17:52:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20181119171406.GQ53235@atomide.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542716606; bh=ILNDH4X7AMR5fQvIfj24/ek95ctOEnwRHpZvnQSQZUw=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=f8GNKaqNCbFV7v+62NBJx3k+uupGuXJX9Y8ORRu0OWn6kGJtm3PrM5P8gN/ff80UZ
         XsxVmpwW1kAJrkCXRZvTKuMN4wQqFmt4SJudFqyPe808KUfsvwtraQJxRLH8jW9BDn
         hQdTtPMnj5GUX8XILEVveKXmdlf3dP+2sXv/RIKisTy66VH1MWFsrkIS1B3/GmDt0t
         abntFgVmrKqaWSy6J4HJ08pbJ3r3b978otMZ9jEfDw9533i6/ZRxqcX2Q1wJQ5ARaF
         DA5FejBxgfPZa+PgIWdjRhzQDwEe97hZaRj2g3J3KX8ebD/H/+ci/Pkk3KmOdv+N87
         ie/zZxjJ3L2JA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 19 November 2018 10:44 PM, Tony Lindgren wrote:
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
> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
> Tegra114 PMIC interrupt") states that tegra114 inverts the
> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
>
> So it seems that commit df545d1cd01a ("mfd: palmas: Provide
> irq flags through DT/platform data") wrongly sets the
> PALMAS_POLARITY_CTRL_INT_POLARITY on IRQ_TYPE_LEVEL_HIGH
> while it should set it on IRQ_TYPE_LEVEL_LOW.

When I implemented, ARM GIC interrupt driver did not support the 
IRQ_TYPE_LEVEL_LOW. If we set this then it produces warning.
[Commit ID commit df545d1cd01aab3ba3f687d5423e6c3687b069d8
mfd: palmas: Provide irq flags through DT/platform data]

So from DT we can not really set the IRQ_TYPE_LEVEL_LOW as irq flag.



