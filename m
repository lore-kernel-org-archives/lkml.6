Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD1DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C0F20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fuxg65T0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C0F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeIKDCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 23:02:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41062 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeIKDCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 23:02:04 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8AM5sZQ006240;
        Mon, 10 Sep 2018 17:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536617154;
        bh=HmzuJDxWmCJdrkecPsafQ0HwnqG2PwzFMSUzbIoCkD0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fuxg65T059gvOFHUNDLH/Se08uUgRKPQSg52vvjeJHStnAderVrh1B75ZjvE9lMEL
         5v/skBoSCPU16OTKBHpLIjpU1MKWOYGmucpdlRJBsTe0Zb8C+41VcWjZWUNsj8RF+x
         r9J49l3+0siDlNXISWSy1CrJlKKExGY+7UeT7OsA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8AM5sM3021858;
        Mon, 10 Sep 2018 17:05:54 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 10
 Sep 2018 17:05:54 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 10 Sep 2018 17:05:53 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8AM5r0W027395;
        Mon, 10 Sep 2018 17:05:53 -0500
Subject: Re: [PATCH 2/5] gpio: davinci: Use dev name for label and automatic
 base selection
To:     Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "Andrew F. Davis" <afd@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180831191326.25106-1-afd@ti.com>
 <20180831191326.25106-2-afd@ti.com>
 <2a02c241-ac91-1bac-380d-122858bb03c3@ti.com>
 <CACRpkdYvNeKyfRf5Et5zC4=hcu9cfDubftRFRHtrKLN-5Snd1Q@mail.gmail.com>
 <040ce524-f6e2-81a2-68db-57a645de22ea@ti.com>
 <0e199aa3-2d9d-4e7d-af23-8523722f017a@ti.com>
 <7ffe6694-0bb1-d1ae-3d93-51f11a358cc0@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <fe34f216-b07b-6ccd-eee8-8b571d630017@ti.com>
Date:   Mon, 10 Sep 2018 17:05:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7ffe6694-0bb1-d1ae-3d93-51f11a358cc0@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/2018 09:47 PM, Keerthy wrote:
> 
> 
> On Sunday 09 September 2018 01:11 AM, Grygorii Strashko wrote:
>>
>>
>> On 09/06/2018 09:16 AM, Keerthy wrote:
>>>
>>>
>>> On Wednesday 05 September 2018 04:07 PM, Linus Walleij wrote:
>>>> On Mon, Sep 3, 2018 at 7:40 AM Keerthy <j-keerthy@ti.com> wrote:
>>>>> On Saturday 01 September 2018 12:43 AM, Andrew F. Davis wrote:
>>>>>> Use dev_name to get a unique label and use -1 for a base to get our
>>>>>> selection automatically. We pull in all GPIOs per chip now so this
>>>>>> does not have the effect of out of order labels like before.
>>>>>>
>>>>>> We do these both together so we can drop all the static data in one
>>>>>> patch. This also lets us normalize the return paths as we don't need
>>>>>> any cleanup after this change.
>>>>>
>>>>> echo 28 > /sys/class/gpio/export
>>>>> / # echo 28 > /sys/class/gpi[   12.839205] export_store: invalid GPIO 28
>>>>> o/export
>>>>> echo 2 > /sys/class/gp[   22.165728] export_store: invalid GPIO 2
>>>>> io/export
>>>>> / # echo 1 > /sys/class/gp[   25.961392] export_store: invalid GPIO 1
>>>>> io/export
>>>>> / # echo 3 > /sys/class/gp[   29.981918] export_store: invalid GPIO 3
>>>>> io/export
>>>>>
>>>>> Export fails with this patch. I am testing this on keystone-k2g-evm.
>>>>
>>>> I think the GPIO got a new number didn't it?
>>>>
>>>> Did you check the gpio file in debugfs to see which number
>>>> it got.
>>>
>>> Okay now its numbered differently:
>>>
>>> cat /sys/class/gpio/gpiochip340/ngpio
>>> 144
>>>
>>> cat /sys/class/gpio/gpiochip272/ngpio
>>> 68
>>
>> could you or Andrew provide content of /debug/gpio before/after?
>> And ls /sys/class/gpio/?
> 
> Output on K2G:
> 
> Before
> ======
> 
> cat /debug/gpio
> gpiochip1: GPIOs 0-143, parent: platform/2603000.gpio, davinci_gpio.0:
> 
> gpiochip2: GPIOs 144-211, parent: platform/260a000.gpio, davinci_gpio.1:
>   gpio-156 (                    |cd                  ) in  lo
> 
> gpiochip0: GPIOs 484-511, parent: platform/2620240.keystone_dsp_gpio,
> 2620240.keystone_dsp_gpio:
> 
>   ls /sys/class/gpio/
> export       gpiochip0    gpiochip144  gpiochip484  unexport
> 
> cat /sys/class/gpio/gpiochip0/label
> davinci_gpio.0
> 
> cat /sys/class/gpio/gpiochip144/label
> davinci_gpio.1
> 
> cat /sys/class/gpio/gpiochip144/ngpio
> 68
> / # cat /sys/class/gpio/gpiochip0/ngpio
> 144
> 
> 
> After
> =====
> 
>   cat /debug/gpio
> gpiochip2: GPIOs 272-339, parent: platform/260a000.gpio, 260a000.gpio:
>   gpio-284 (                    |cd                  ) in  lo
> 
> gpiochip1: GPIOs 340-483, parent: platform/2603000.gpio, 2603000.gpio:
> 
> gpiochip0: GPIOs 484-511, parent: platform/2620240.keystone_dsp_gpio,
> 2620240.keystone_dsp_gpio:
> 
> ls /sys/class/gpio/
> export       gpiochip272  gpiochip340  gpiochip484  unexport
> 
> 
> cat /sys/class/gpio/gpiochip340/label
> 2603000.gpio
> / # cat /sys/class/gpio/gpiochip272/label
> 260a000.gpio
> / # cat /sys/class/gpio/gpiochip272/label
> 
> cat /sys/class/gpio/gpiochip272/ngpio
> 68
> / # cat /sys/class/gpio/gpiochip340/ngpio
> 144
> 
> In the case of SoCs that support multiple instances of Davinci GPIO IPs
> it is harder to figure out the right gpio number to export.
> 

Just to clarify above for all:
- for the first registered gpio chip
- if base >= 0 then gpiolib: try allocate gpios [base, base + ngpio]
  else gpiolib: try allocate gpios [ARCH_NR_GPIOS - ngpio, ARCH_NR_GPIOS]

so for the "after" case we can see gpio chip base allocation in hi to low order


-- 
regards,
-grygorii
