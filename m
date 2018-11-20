Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE3DC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7B3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KOY8Px6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7B3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbeKTSCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:02:41 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50582 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeKTSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:02:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK7Yrj4057550;
        Tue, 20 Nov 2018 01:34:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542699293;
        bh=n9s90HNwWqsxsckbL5NFIB9zmTZd4NhpuevGTNwBj/k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KOY8Px6YqddEY8I2KLhX6QLvWJyItncjQkrqXD2vX+YOtTJl8ERQRA5m1yq9+rUdB
         3AnEqymkqevd3kYlpQdI0vU72HKJ04rPsjv9UQsz8xcgsQ5vrClH/IcAB6nVqCDdW+
         1zVwxPw+KFMHuidRh3lqVwqOTSGSRY99k/Ww7nvw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK7Yri6011627
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 01:34:53 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 20
 Nov 2018 01:34:53 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 20 Nov 2018 01:34:53 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK7YpLM014764;
        Tue, 20 Nov 2018 01:34:52 -0600
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
To:     Tony Lindgren <tony@atomide.com>
CC:     Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a0a6b3d1-30f1-0726-4277-684e8ab11752@ti.com>
Date:   Tue, 20 Nov 2018 09:36:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181119161906.GP53235@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/2018 18.19, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [181119 10:16]:
>> On 2018-11-13 20:06, Tony Lindgren wrote:
>>> Looks like the IRQ_TYPE_NONE issue still is there for omap5 and
>>> should be fixed with IRQ_TYPE_HIGH.
>>>
>>> No idea about why palmas interrupts would stop working though,
>>> Peter, do you have any ideas on this one?
>>
>> No, I don't.
>> The INT polarity can be changed in Palmas.
>> based on the pdata->irq_flags (queried via irqd_get_trigger_type())
>> the code  configures it:
>>
>> if (pdata->irq_flags & IRQ_TYPE_LEVEL_HIGH)
>> 	reg = PALMAS_POLARITY_CTRL_INT_POLARITY;
>> else
>> 	reg = 0;
>>
>> and we pass the same irq_flags to the regmap_add_irq_chip()
>> IRQ_TYPE_LEVEL_HIGH == IRQF_TRIGGER_HIGH == 0x00000004
>>
>> A change in DT should be enough, no need to patch palmas.c, imho.
> 
> But it's not. I'm now wondering if wakeupgen is inverting the
> polarity for this interrupt?
> 
> GIC docs say this about SPI interrupts:
> 
> "SPI is triggered on a rising edge or is active-HIGH level-sensitive."
> 
> So when setting IRQ_TYPE_LEVEL_HIGH in dts, we still must not
> invert the polarity in palmas while tegra needs to. So either
> tegra114 hardware is inverting the polarity, or omap5 wakeupgen
> is.
> 
> Does the palmas trm say which way PALMAS_POLARITY_CTRL
> triggers if PALMAS_POLARITY_CTRL_INT_POLARITY is set?

bit7 INT_POLARITY Select the polarity of the INT output line
0: Interrupt line (INT) is low when interrupt is pending (default) RW
1: Interrupt line (INT) is high when interrupt is pending

> Also note that dra7 is using a gpio for palmas interrupt.
> 
> Regards,
> 
> Tony
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
