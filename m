Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B85C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14F620870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KIlquCrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14F620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbeLMPIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:08:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40788 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeLMPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:08:46 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBDF8UEp019441;
        Thu, 13 Dec 2018 09:08:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544713710;
        bh=wzMrdHvbCJrnm+2/hnMVe6XOvQgONtk9n1EhxmTwBnw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KIlquCrzD6PeiTfzB4zpU5LitxvfWeMpeYzQVNJnRiFeYjYUCEGcamwkgxRTqL5n8
         QXnhf5dlEta+MD5AfC+YdVdzCXvmcMku4VczK03qrIZMB6Fj4b+57vLlB7Wrs5OhJH
         pwVgbztgSDV3Hx4GwW2Oyq21a8MilFScOp/pyaB4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBDF8UNI066008
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Dec 2018 09:08:30 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 13
 Dec 2018 09:08:29 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 13 Dec 2018 09:08:29 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBDF8Rvo017277;
        Thu, 13 Dec 2018 09:08:27 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am654: Add McSPI DT nodes
To:     Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181209102222.7624-1-vigneshr@ti.com>
 <20181209102222.7624-2-vigneshr@ti.com>
 <7b718f70-bb74-0530-9566-d621371c3d13@ti.com>
 <3420b087-673b-b5be-ed5a-bf8d95ecc4dc@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <723772e0-162b-edfb-75ab-0461925a9930@ti.com>
Date:   Thu, 13 Dec 2018 17:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3420b087-673b-b5be-ed5a-bf8d95ecc4dc@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2018 17:03, Vignesh R wrote:
> 
> 
> On 13-Dec-18 8:29 PM, Tero Kristo wrote:
>> On 09/12/2018 12:22, Vignesh R wrote:
>>> There are 3 instances of McSPI in MCU domain and 4 instances in Main
>>> domain.
>>> Add DT nodes for all McSPI instances present on AM654 SoC.
>>>
>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>> ---
>>>    arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 52 ++++++++++++++++++++++++
>>>    arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 30 ++++++++++++++
>>>    2 files changed, 82 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> index 0a0a8fc5df64..6c71e67b8988 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> @@ -138,4 +138,56 @@
>>>            clocks = <&k3_clks 39 0>;
>>>            clock-names = "fck";
>>>        };
>>> +
>>> +    main_spi0: spi@2100000 {
>>> +        compatible = "ti,am654-mcspi","ti,omap4-mcspi";
>>
>> WARNING: DT compatible string "ti,am654-mcspi" appears un-documented --
>> check ../../Documentation/devicetree/bindings/
>> #63: FILE: arch/arm64/boot/dts/ti/k3-am65-main.dtsi:143:
>> +        compatible = "ti,am654-mcspi","ti,omap4-mcspi";
>>
>> Same for the rest of the nodes.
>>
>> Did you forget documentation part?
>>
> 
> Documentation patch as been accepted into SPI tree and part of linux-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=abc61f47a70f7c8331f00eff1ccb6557a9d4c224

Ok thanks for the info.

-Tero

> 
> Regards
> Vignesh
> 
>> -Tero
>>
>>> +        reg = <0x0 0x2100000 0x0 0x400>;
>>> +        interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
>>> +        clocks = <&k3_clks 137 1>;
>>> +        power-domains = <&k3_pds 137>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +    };
>>> +
>>> +    main_spi1: spi@2110000 {
>>> +        compatible = "ti,am654-mcspi","ti,omap4-mcspi";
>>> +        reg = <0x0 0x2110000 0x0 0x400>;
>>> +        interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
>>> +        clocks = <&k3_clks 138 1>;
>>> +        power-domains = <&k3_pds 138>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        assigned-clocks = <&k3_clks 137 1>;
>>> +        assigned-clock-rates = <48000000>;
>>> +    };
>>> +
>>> +    main_spi2: spi@2120000 {
>>> +        compatible = "ti,am654-mcspi","ti,omap4-mcspi";
>>> +        reg = <0x0 0x2120000 0x0 0x400>;
>>> +        interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
>>> +        clocks = <&k3_clks 139 1>;
>>> +        power-domains = <&k3_pds 139>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +    };
>>> +
>>> +    main_spi3: spi@2130000 {
>>> +        compatible = "ti,am654-mcspi","ti,omap4-mcspi";
>>> +        reg = <0x0 0x2130000 0x0 0x400>;
>>> +        interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
>>> +        clocks = <&k3_clks 140 1>;
>>> +        power-domains = <&k3_pds 140>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +    };
>>> +
>>> +    main_spi4: spi@2140000 {
>>> +        compatible = "ti,am654-mcspi","ti,omap4-mcspi";
>>> +        reg = <0x0 0x2140000 0x0 0x400>;
>>> +        interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
>>> +        clocks = <&k3_clks 141 1>;
>>> +        power-domains = <&k3_pds 141>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +    };
>>>    };
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>>> b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>>> index 1fd027748e1f..1aeae52fb239 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>>> @@ -26,4 +26,34 @@
>>>            clocks = <&k3_clks 114 1>;
>>>            power-domains = <&k3_pds 114>;
>>>        };
>>> +
>>> +    mcu_spi0: spi@40300000 {
>>> +        compatible = "ti,am654-mcspi","ti,omap4-mcspi";
>>> +        reg = <0x0 0x40300000 0x0 0x400>;
>>> +        interrupts = <GIC_SPI 560 IRQ_TYPE_LEVEL_HIGH>;
>>> +        clocks = <&k3_clks 142 1>;
>>> +        power-domains = <&k3_pds 142>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +    };
>>> +
>>> +    mcu_spi1: spi@40310000 {
>>> +        compatible = "ti,am654-mcspi","ti,omap4-mcspi";
>>> +        reg = <0x0 0x40310000 0x0 0x400>;
>>> +        interrupts = <GIC_SPI 561 IRQ_TYPE_LEVEL_HIGH>;
>>> +        clocks = <&k3_clks 143 1>;
>>> +        power-domains = <&k3_pds 143>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +    };
>>> +
>>> +    mcu_spi2: spi@40320000 {
>>> +        compatible = "ti,am654-mcspi","ti,omap4-mcspi";
>>> +        reg = <0x0 0x40320000 0x0 0x400>;
>>> +        interrupts = <GIC_SPI 562 IRQ_TYPE_LEVEL_HIGH>;
>>> +        clocks = <&k3_clks 144 1>;
>>> +        power-domains = <&k3_pds 144>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +    };
>>>    };
>>>
>>
>> -- 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
