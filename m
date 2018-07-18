Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C1FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C09C2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrrw/ojG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C09C2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbeGRPqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:46:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39774 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbeGRPqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:46:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id w14-v6so4523843eds.6;
        Wed, 18 Jul 2018 08:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=veLrMEoK/5NJzcAkc33Jdq6MZG69jqMDTZJSRuZk4JA=;
        b=Vrrw/ojGxOgi1VmcHY4l034MlbefGOmaCvTbonl634V9Fc0fkgw7TKVvDlbMjHM+AD
         QZ3wppIpsjlCPM+kmFIz/JVZy2qxlAhHCVDbxL29ZW53Mg/76urYjgI1LPWZx8oRKokq
         Ut35dqyRz650aDcbq6mBCByNyPvjoJAXkpBdorgzzNfhouC3S88Y977W3RudYo1eEa69
         gzeafIp1cM7wgMCsAgd5r2tg9/qlg7V8MZrRBbtIfKvL+Wezs2wUaTTIf7sILG/l0edu
         rAXrOKxNIcizptk4CfKZEyUx+KOYjXfQz21ZiZ6sbdG0PlZHPoC0GuQDSQEZ455wFt2K
         Wm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=veLrMEoK/5NJzcAkc33Jdq6MZG69jqMDTZJSRuZk4JA=;
        b=m1H8To5LMpLHvQNn1JqiqfEabBtgFtbA45jcC2czfvGl1DOaQqyKqNxijGFShD8M7W
         Ow/5ZIQTA7LS4PuCOCTC1PD2IATqDIrOV9rtZ2xaGLKYaXw2yQXyAsroNxcN+S3K3vqW
         ryfsqUPtYL2HQl16p0wqJV+EJAqWgwUyiI2wsHbmPXPUz05JzkXluDI3bMppOcaSd8zl
         mKXb4V35p6cjKxXXR1x1fP9yIwD2N6K/4S1kfg0brbHKwtN9bhw7bBUaTxp2DBmgETin
         xMsEinEjvs4Jb5Ru7pYwhnt7Lge5uA9gpzIOI574XAfAY3ne4gRxK9+Imu3DlowY9JKX
         iQog==
X-Gm-Message-State: AOUpUlHQB1m4WDnfNolKLff/ly5COGfIoKoM/qYLquO7iRLJIblpd4j9
        kLrEg0MurUCtRFdeGGpQBDI=
X-Google-Smtp-Source: AAOMgpf0zLs1OXwDFk5OH8JVAzi2Jeqd8HoNadynBftiA6DJCvivS0KVjFUXt2K5jJx6FXRIRyL9zg==
X-Received: by 2002:a50:8f66:: with SMTP id 93-v6mr7176283edy.248.1531926460106;
        Wed, 18 Jul 2018 08:07:40 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id p20-v6sm1685029edr.12.2018.07.18.08.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:07:39 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] arm64: dts: Add Mediatek X20 Development Board
 support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com
References: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
 <20180605163442.4812-3-manivannan.sadhasivam@linaro.org>
 <d88504b4-409c-c42b-f816-bedefce2a819@gmail.com>
 <20180717140453.GA19076@mani>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <a48b0735-ff75-6228-22ba-c8e868240f0c@gmail.com>
Date:   Wed, 18 Jul 2018 17:07:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180717140453.GA19076@mani>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/07/18 16:04, Manivannan Sadhasivam wrote:
> Hi Matthias,
> 
> On Mon, Jul 16, 2018 at 03:24:44PM +0200, Matthias Brugger wrote:
>> Hi Manivanna,
>>
>> On 05/06/18 18:34, Manivannan Sadhasivam wrote:
>>> Add initial device tree support for Mediatek X20 Development Board
>>> based on MT6797 Deca core SoC. This board is one of the 96Boards
>>> Consumer Edition platform.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>>>  .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
>>>  2 files changed, 34 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>>> index ac17f60f998c..5b7fd6ad96e4 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
>>> new file mode 100644
>>> index 000000000000..2c09ca95d9e2
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
>>> @@ -0,0 +1,33 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Device Tree Source for MediaTek X20 Development Board
>>> + *
>>> + * Copyright (C) 2018, Linaro Ltd.
>>> + *
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "mt6797.dtsi"
>>> +
>>> +/ {
>>> +	model = "Mediatek X20 Development Board";
>>> +	compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
>>> +
>>> +	aliases {
>>> +		serial0 = &uart1;
>>> +	};
>>
>> Sorry for the late answer.
>> Why did you use uart1 instead of uart0?
>> I know that uart0 is used by the bootloader, but because of their exotic flash
>> procedure I find it quite useful to see this messages in my serial connection.
>> Of course you can only use 921600 baudrate then.
>>
> 
> The reason is, most of the Mezzanine boards use USB to UART bridge on the
> UART1 port available on the Low Speed Expansion header. Additionally, the
> convention followed by most of the Consumer Edition 96Boards is to use UART1
> as the debug serial port. That's why eventhough the bootloader is using UART0,
> I forced the kernel to use UART1.
> 

Sounds reasonable, I don't have this 96 boards adapter and I forgot about it.

>>> +
>>> +	memory@40000000 {
>>> +		device_type = "memory";
>>> +		reg = <0 0x40000000 0 0x1e605000>;
>>
>> How comes this strange number for the memory size?
>>
> 
> Actually, the memory size is extracted from the downstream kernel [1].
> 

Hm, Archermind "Helio X20 Development Board Hardware Manual" talks about 2GB
LPDDR3-SDRAM. Would you mind to check if that is actually true?

>> BTW do you know the differences between the EVB board and the x20 one?
>> I used the evb dts for booting up to now.
>>
> 
> Sorry, I don't know the difference between both boards!

Sure, no problem :)

Regards,
Matthias

> 
> Thanks,
> Mani
> 
> [1] https://github.com/helio-x20/linux/blob/helio-x20/arch/arm64/boot/dts/amt6797_64_open.dts#L8
> 
>> Best regards,
>> Matthias
>>
>>> +	};
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial0:115200n8";
>>> +	};
>>> +};
>>> +
>>> +&uart1 {
>>> +	status = "okay";
>>> +};
>>>
