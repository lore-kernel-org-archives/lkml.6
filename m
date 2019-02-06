Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ED9C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275F320821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yFCHcuuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfBFNEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:04:48 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41810 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfBFNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:04:48 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16D3d7J112097;
        Wed, 6 Feb 2019 07:03:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549458219;
        bh=JIGM9ID2DDV0KJ+zK5xFsmzzApmhcC24mjb7/4/ZwJA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yFCHcuuRsJ3nlnvT5eP1RUmEIMoXaengSBNAifhmlh+akKleFkYiqDyt0WjAVBJ52
         PqPGybKVnsimBu3RuuWqWAomdWsc5Uh31whxqRKZLLhO+XaDOKlxnr0Mee42sG5EhH
         mjIpwwtDgAlrgLPXeqGwtwpMxsg3pXePTh6FBU8M=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16D3dJ3094652
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 07:03:39 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 07:03:39 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 07:03:39 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16D3aXQ017208;
        Wed, 6 Feb 2019 07:03:36 -0600
Subject: Re: [PATCH 05/35] ARM: davinci: drop irq defines from
 default_priorites
To:     David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-6-brgl@bgdev.pl>
 <3038ba79-f411-9aa1-00ec-689060ed13d4@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <21c3d8cd-f767-04bc-f4d8-3001405ffd1d@ti.com>
Date:   Wed, 6 Feb 2019 18:33:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3038ba79-f411-9aa1-00ec-689060ed13d4@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/19 3:51 AM, David Lechner wrote:
> On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> In order to select SPARSE_IRQ we need to make the interrupt numbers
>> dynamic (at least at build-time for the top-level controller). The
>> interrupt numbers are used as array indexes for irq priorities.
>>
>> Drop the defines and just initialize the arrays in a linear manner.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
> 
> ...
> 
>> -static u8 dm355_default_priorities[DAVINCI_N_AINTC_IRQ] = {
>> -    [IRQ_DM355_CCDC_VDINT0]        = 2,
>> -    [IRQ_DM355_CCDC_VDINT1]        = 6,
>> -    [IRQ_DM355_CCDC_VDINT2]        = 6,
>> -    [IRQ_DM355_IPIPE_HST]        = 6,
>> -    [IRQ_DM355_H3AINT]        = 6,
>> -    [IRQ_DM355_IPIPE_SDR]        = 6,
>> -    [IRQ_DM355_IPIPEIFINT]        = 6,
>> -    [IRQ_DM355_OSDINT]        = 7,
>> -    [IRQ_DM355_VENCINT]        = 6,
>> -    [IRQ_ASQINT]            = 6,
>> -    [IRQ_IMXINT]            = 6,
>> -    [IRQ_USBINT]            = 4,
>> -    [IRQ_DM355_RTOINT]        = 4,
>> -    [IRQ_DM355_UARTINT2]        = 7,
>> -    [IRQ_DM355_TINT6]        = 7,
>> -    [IRQ_CCINT0]            = 5,    /* dma */
>> -    [IRQ_CCERRINT]            = 5,    /* dma */
>> -    [IRQ_TCERRINT0]            = 5,    /* dma */
>> -    [IRQ_TCERRINT]            = 5,    /* dma */
>> -    [IRQ_DM355_SPINT2_1]        = 7,
>> -    [IRQ_DM355_TINT7]        = 4,
>> -    [IRQ_DM355_SDIOINT0]        = 7,
>> -    [IRQ_MBXINT]            = 7,
>> -    [IRQ_MBRINT]            = 7,
>> -    [IRQ_MMCINT]            = 7,
>> -    [IRQ_DM355_MMCINT1]        = 7,
>> -    [IRQ_DM355_PWMINT3]        = 7,
>> -    [IRQ_DDRINT]            = 7,
>> -    [IRQ_AEMIFINT]            = 7,
>> -    [IRQ_DM355_SDIOINT1]        = 4,
>> -    [IRQ_TINT0_TINT12]        = 2,    /* clockevent */
>> -    [IRQ_TINT0_TINT34]        = 2,    /* clocksource */
>> -    [IRQ_TINT1_TINT12]        = 7,    /* DSP timer */
>> -    [IRQ_TINT1_TINT34]        = 7,    /* system tick */
>> -    [IRQ_PWMINT0]            = 7,
>> -    [IRQ_PWMINT1]            = 7,
>> -    [IRQ_PWMINT2]            = 7,
>> -    [IRQ_I2C]            = 3,
>> -    [IRQ_UARTINT0]            = 3,
>> -    [IRQ_UARTINT1]            = 3,
>> -    [IRQ_DM355_SPINT0_0]        = 3,
>> -    [IRQ_DM355_SPINT0_1]        = 3,
>> -    [IRQ_DM355_GPIO0]        = 3,
>> -    [IRQ_DM355_GPIO1]        = 7,
>> -    [IRQ_DM355_GPIO2]        = 4,
>> -    [IRQ_DM355_GPIO3]        = 4,
>> -    [IRQ_DM355_GPIO4]        = 7,
>> -    [IRQ_DM355_GPIO5]        = 7,
>> -    [IRQ_DM355_GPIO6]        = 7,
>> -    [IRQ_DM355_GPIO7]        = 7,
>> -    [IRQ_DM355_GPIO8]        = 7,
>> -    [IRQ_DM355_GPIO9]        = 7,
>> -    [IRQ_DM355_GPIOBNK0]        = 7,
>> -    [IRQ_DM355_GPIOBNK1]        = 7,
>> -    [IRQ_DM355_GPIOBNK2]        = 7,
>> -    [IRQ_DM355_GPIOBNK3]        = 7,
>> -    [IRQ_DM355_GPIOBNK4]        = 7,
>> -    [IRQ_DM355_GPIOBNK5]        = 7,
>> -    [IRQ_DM355_GPIOBNK6]        = 7,
>> -    [IRQ_COMMTX]            = 7,
>> -    [IRQ_COMMRX]            = 7,
>> -    [IRQ_EMUINT]            = 7,
>> +static u8 dm355_aintc_prios[] = {
>> +    2, 6, 6, 6, 6, 6, 6, 7,
>> +    6, 6, 6, 4, 4, 7, 7, 5,
>> +    5, 5, 5, 7, 4, 7, 7, 7,
>> +    7, 7, 7, 7, 7, 4, 2, 2,
>> +    7, 7, 7, 7, 7, 3, 3, 3,
>> +    3, 3, 3, 7, 4, 4, 7, 7,
>> +    7, 7, 7, 7, 7, 7, 7, 7,
>> +    7, 7, 7, 7, 7, 7, 0, 0,
>>   };
> 
> Hmm... this makes it harder to see what is going on here.
> You can no longer see which priority corresponds to which
> IRQ without consulting a manual.

I agree with David here. The interrupt numbers are dynamic, but the
interrupt number offset from hardware point-of-view is fixed. So can
these macros be re-purposed to represent the hardware offset (eventually
you would pass them to DAVINCI_INTC_IRQ())?

Thanks,
Sekhar
