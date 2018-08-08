Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC04FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E5B21723
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hu9ZKZNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E5B21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeHHIu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:50:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47492 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeHHIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:50:28 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w786Vcls097648;
        Wed, 8 Aug 2018 01:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533709898;
        bh=Rut8Fidqam841hTB6FFX2NXpM6IfH47S0Cn5ke2aqRE=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=hu9ZKZNkbNF7ZHD2g4NPLg7lt1i6KNt63KAq2Ze5k9r38gSnIyUL6/nq5SCnPrmGV
         S2nVIwQL8EDLgPxKfEYCGSvJZkFlGZkV4D3zNWNL8uM+g3Q78hMj6Va8bCZD2TLvxO
         e+D074b1OkQAlq/aFMyFxLPeUNDh1cpjLSXEVSgs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w786VcoH023297;
        Wed, 8 Aug 2018 01:31:38 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 8 Aug
 2018 01:31:37 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 8 Aug 2018 01:31:37 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w786VWHC032304;
        Wed, 8 Aug 2018 01:31:33 -0500
Subject: Re: Re: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
To:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <454c277e-8a63-81cb-b341-a50f4e25cbea@ti.com>
Date:   Wed, 8 Aug 2018 12:01:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tuesday 05 June 2018 07:35 PM, Rob Herring wrote:
> On Tue, Jun 5, 2018 at 1:05 AM, Nishanth Menon <nm@ti.com> wrote:
>> The AM654 SoC is a lead device of the K3 Multicore SoC architecture
>> platform, targeted for broad market and industrial control with aim to
>> meet the complex processing needs of modern embedded products.
>>
>> Some highlights of this SoC are:
>> * Quad ARMv8 A53 cores split over two clusters
>> * GICv3 compliant GIC500
>> * Configurable L3 Cache and IO-coherent architecture
>> * Dual lock-step capable R5F uC for safety-critical applications
>> * High data throughput capable distributed DMA architecture under NAVSS
>> * Three Gigabit Industrial Communication Subsystems (ICSSG), each with dual
>>   PRUs and dual RTUs
>> * Hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
>> * Centralized System Controller for Security, Power, and Resource
>>   management.
>> * Dual ADCSS, eQEP/eCAP, eHRPWM, dual CAN-FD
>> * Flash subystem with OSPI and Hyperbus interfaces
>> * Multimedia capability with CAL, DSS7-UL, SGX544, McASP
>> * Peripheral connectivity including USB3, PCIE, MMC/SD, GPMC, I2C, SPI,
>>   GPIO
>>
>> See AM65x Technical Reference Manual (SPRUID7, April 2018)
>> for further details: http://www.ti.com/lit/pdf/spruid7
>>
>> We introduce the Kconfig symbol for the SoC along with this patch since
>> it is logically relevant point, however the usage is in subsequent
>> patches.
>>
>> NOTE: AM654 is the first of the device variants, hence we introduce a
>> generic am6.dtsi.
>>
>> Signed-off-by: Benjamin Fair <b-fair@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  MAINTAINERS                          |   1 +
>>  arch/arm64/boot/dts/ti/k3-am6.dtsi   | 144 +++++++++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am654.dtsi | 117 ++++++++++++++++++++++++++++
>>  drivers/soc/ti/Kconfig               |  14 ++++
>>  4 files changed, 276 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6.dtsi
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654.dtsi
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cfb35b252ac7..5f5c4eddec7a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2092,6 +2092,7 @@ M:        Nishanth Menon <nm@ti.com>
>>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:     Supported
>>  F:     Documentation/devicetree/bindings/arm/ti/k3.txt
>> +F:     arch/arm64/boot/dts/ti/k3-*
>>
>>  ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
>>  M:     Santosh Shilimkar <ssantosh@kernel.org>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am6.dtsi b/arch/arm64/boot/dts/ti/k3-am6.dtsi
>> new file mode 100644
>> index 000000000000..cdfa12173aac
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am6.dtsi
>> @@ -0,0 +1,144 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device Tree Source for AM6 SoC Family
>> + *
>> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +       model = "Texas Instruments K3 AM654 SoC";
>> +       compatible = "ti,am654";
>> +       interrupt-parent = <&gic>;
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>> +       aliases {
>> +               serial0 = &wkup_uart0;
>> +               serial1 = &mcu_uart0;
>> +               serial2 = &main_uart0;
>> +               serial3 = &main_uart1;
>> +               serial4 = &main_uart2;
>> +       };
>> +
>> +       chosen { };
>> +
>> +       firmware {
>> +               optee {
>> +                       compatible = "linaro,optee-tz";
>> +                       method = "smc";
>> +               };
>> +
>> +               psci: psci {
>> +                       compatible = "arm,psci-1.0";
>> +                       method = "smc";
>> +               };
>> +       };
>> +
>> +       soc0: soc0 {
>> +               compatible = "simple-bus";
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
>> +               ranges;
> 
> Really need 64-bit addresses and sizes? Use ranges to limit the
> address space if possible.

We now have address-cells as <1>,
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am65.dtsi#n49

However each PCIe instance has 2 data regions and one of the regions
(PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT1/PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT1 specified
in the "MAIN Domain Memory Map" table of TRM http://www.ti.com/lit/pdf/spruid7)
is above the 32bit region and requires 2 cells to specify the start address.
This region is used to access MEM_SPACE of PCIe endpoint when operating in root
complex mode and access memory of PCI root complex when operating in endpoint mode.

In order to describe this, should we change the address-cells back to <2> or do
you suggest any other alternatives?

Thanks
Kishon
