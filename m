Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5369EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109CB20851
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY56e2Iu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109CB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeK1LWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:22:51 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37227 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeK1LWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:22:51 -0500
Received: by mail-yw1-f68.google.com with SMTP id h193so8745205ywc.4;
        Tue, 27 Nov 2018 16:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zCl0sW2jllUlEa5rDc3pHsBk8khNAPA9X9gxFT+ZwEw=;
        b=gY56e2IuAqh9AY8H8Qnm7EL6Lk/KyjKy0D9FbONcFJPMJHY91yl6odkvFP1xNDnGfH
         pqyUVXI0sDawTCA4Xb7jCE2JVniI+f07v8pQa6/+z6S9eLZUDFfGu+i9Qcg4oHCyMQJE
         5q4ooef7JPivOVw+6evlYJtvMA2F4cbzcWUaMQnPiM09CrpxOwHOGNzX8x9m5zi1jX+a
         F9RW8aMiF9gHXMvtNw6cxn0+7ImDMiQsa+o7MQHkLkpHPB4xBgR4efBVn2E4ivpw10M5
         OnQBzxSmPEkJ05Nog6vy+mDG5JAejDLGQVtrwHsv9x7csjgAsl4GWF8qT/x+/tr7roLn
         fLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zCl0sW2jllUlEa5rDc3pHsBk8khNAPA9X9gxFT+ZwEw=;
        b=LJ7PMq0h9ja0s2aVe7AoOM74beMBYEGEg/716ykuwJ765x+lhx+2qhKkT9iYEn8ffk
         uEsAW/zOh2KRlNcvgKT7D/59+Rknr7RSmBKfmqUsOgxCXWcADQl5bYdKdlAizh+lW/nK
         diIhDwumkq6VRg1DXaR3IwA0mf36EbV/vMUdptAd8jnRTyiPv6Ef7OIJSygE9XpaMgc8
         9LrgBuq5vn84CTBgMu/xW9TZW6FR3KbDzdNupnge4yx9S17UhuKPMp78pYm6+knxefdq
         s+3eHEM+ymCvrIP65ZwMBj07ktVS6IhaYFVsmFUc0wHvKRXdgXNPDIUjEUTQy11fLI9g
         fteA==
X-Gm-Message-State: AGRZ1gKLnIkUmPtb1a44rVDR76apYavAsXnFCLAgaci4hrKGeCGThXHu
        biWLZ7W/rjYqjnXF47AIgxY=
X-Google-Smtp-Source: AJdET5eGsfwbtt9lOfhRRp1qdHw1qAlKNahlX1Dqch07F/Pl316jUHb8YQXJRkKYPYXBdd6hS9hDag==
X-Received: by 2002:a81:4150:: with SMTP id f16-v6mr36591201ywk.287.1543364592705;
        Tue, 27 Nov 2018 16:23:12 -0800 (PST)
Received: from [10.0.2.15] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h75sm3085863ywa.50.2018.11.27.16.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 16:23:11 -0800 (PST)
Subject: Re: Adding a Basic DT for the Linksys ea6500 v2 wireless home router
To:     =?UTF-8?Q?Ren=c3=a9_Kjellerup?= <rk.katana.steel@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <CACE8ZKbUhFyWg5oK1B8+aWAa0tdqKf5Kokj80+8x1X2EUaA_DQ@mail.gmail.com>
 <CACE8ZKZEpQjOW6CSvUuM9xhjtkSCF0bYxcfQ3htSabC=rVJcTA@mail.gmail.com>
 <86f391e5-9e38-c8b0-4753-4646c322c9bc@hauke-m.de>
 <CACE8ZKb5CxEBAdCdGAhwaQHC9_nHBjTTVwxdDOXRayqgz0FK5g@mail.gmail.com>
 <CACE8ZKYCyDx_E+3sLpjQSV6xrFxGyrYwEfhEO=QZPGpm3jsBrQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5a6a30cf-1d93-7232-e607-3919b86bbdff@gmail.com>
Date:   Tue, 27 Nov 2018 16:23:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACE8ZKYCyDx_E+3sLpjQSV6xrFxGyrYwEfhEO=QZPGpm3jsBrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/18 4:49 PM, René Kjellerup wrote:
> To the broadcom kernel maintainers, (for BCM4708 CPUs)
> 
> I just want to add a little attention to this patch again...
> let me know if there's any concerns and I will try to address highlighted issues
> as soon as possible.
> 
> I've been running the development builds of OpenWrt kernels, where
> this patch has
> been included, on my Linksys EA6500v2 router for the past months,
> updating as new
> builds are available. With only the on board BCM4360 chip (5GHz WiFi) is being
> disabled, has so far been stable for my use case.

(Please no top posting). Your submission did make it through patchwork
and looks okay, I will run build tests and queue it up for 4.21 if
everything looks good. Thanks.

> 
> thank you for the consideration
> Rene (aka Katana_Steel)
> 
> On Mon, Oct 8, 2018 at 9:34 AM René Kjellerup <rk.katana.steel@gmail.com> wrote:
>>
>> Hi Hauke,
>>
>> Updated the file header per your suggestion.
>>
>> From e97c15ef78d2535c23f32ebbec43bced72b5eaf7 Mon Sep 17 00:00:00 2001
>> From: Rene Kjellerup <rk.katana.steel@gmail.com>
>> Date: Mon, 1 Oct 2018 14:11:56 -0700
>> Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Linksys EA6500 V2
>>
>> It's wireless home router based on BCM4708A0 with BCM4360 + BCM4331
>> wireless chipsets. The 5GHz chip currently isn't supported only due
>> to missing compatible firmware.
>>
>> the DTS here was based on the Linksys EA6300 V1 DTS, only changing
>> the model strings
>>
>> Signed-off-by: Rene Kjellerup <rk.katana.steel@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile                      |  1 +
>>  arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts | 47 +++++++++++++++++++++++++
>>  2 files changed, 48 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index b5bd3de87c33..adf8f28f5e44 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -88,6 +88,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
>>      bcm4708-asus-rt-ac68u.dtb \
>>      bcm4708-buffalo-wzr-1750dhp.dtb \
>>      bcm4708-linksys-ea6300-v1.dtb \
>> +    bcm4708-linksys-ea6500-v2.dtb \
>>      bcm4708-luxul-xap-1510.dtb \
>>      bcm4708-luxul-xwc-1000.dtb \
>>      bcm4708-netgear-r6250.dtb \
>> diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
>> b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
>> new file mode 100644
>> index 000000000000..8a434d2a4b72
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>> +/*
>> + * Copyright (C) 2017 Rafał Miłecki <rafal@milecki.pl>
>> + * Copyright (C) 2018 Rene Kjellerup <rk.katana.steel@gmail.com>
>> + *
>> + * this DTS was originally based on bcm4708-linksys-ea6300-v1.dts
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "bcm4708.dtsi"
>> +#include "bcm5301x-nand-cs0-bch8.dtsi"
>> +
>> +/ {
>> +    compatible = "linksys,ea6500-v2", "brcm,bcm4708";
>> +    model = "Linksys EA6500 V2";
>> +
>> +    chosen {
>> +        bootargs = "console=ttyS0,115200";
>> +    };
>> +
>> +    memory {
>> +        reg = <0x00000000 0x08000000>;
>> +    };
>> +
>> +    gpio-keys {
>> +        compatible = "gpio-keys";
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        wps {
>> +            label = "WPS";
>> +            linux,code = <KEY_WPS_BUTTON>;
>> +            gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
>> +        };
>> +
>> +        restart {
>> +            label = "Reset";
>> +            linux,code = <KEY_RESTART>;
>> +            gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
>> +        };
>> +    };
>> +};
>> +
>> +&usb3_phy {
>> +    status = "okay";
>> +};
>> --
>> 2.16.4
>>
>> On Sun, Oct 7, 2018 at 2:08 PM Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>>
>>> On 10/04/2018 11:08 PM, René Kjellerup wrote:
>>>> Hi Hauke,
>>>>
>>>> thank you for suggesting adding the dts patch to mainline kernel,
>>>> so here it is.
>>>> I feel Rafal technically still have the copyrights, this is pretty
>>>> much just a few string updates for the ea6500v2. However with this
>>>> dts in latest OpenWrt 18.06 loads and installs on my device.
>>>>
>>>> I will be available to do more testing should it be required.
>>>>
>>>> Regrads
>>>> Rene Kjellerup
>>>> --
>>>> -- as life grows older, I gain experience.
>>>> -- http://www.alchemiestick.net/
>>>>
>>>
>>> Hi Rene,
>>>
>>> Please send you patch inline in the mail and not as an attachment, I
>>> would suggest to use "git send-email" for sending the patch.
>>>
>>> Adding Rafal as copyright owner is ok, like you did it now. You could
>>> mention in the file header on which dts file this is based.
>>>
>>> Hauke
>>>
>>
>>
>> --
>> -- as life grows older, I gain experience.
>> -- http://www.alchemiestick.net/apps/

-- 
Florian
