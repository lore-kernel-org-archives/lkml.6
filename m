Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3766CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16592087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ftWc0IpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16592087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeH1HaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 03:30:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56230 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeH1HaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 03:30:00 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7S3dosS087041;
        Mon, 27 Aug 2018 22:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535427590;
        bh=4aqTMibGrbt8czxO/SgnT/29W1C74hbQcgbjd8UHfyA=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=ftWc0IpXFrIMcdhgu5xsaC3i8Rhd2IlxXk9Egp4Z3Ow0AUqWjvUQG5CHS+VeBmOst
         AOAJ4hqqX2PIqO4nrgOAwcMZYOVCSskZ1QFvs33iAjo/Bx8Ml7lZ8xdSkptB8XKSMF
         EGdeGBat456dVZGRKX812WfZoQ8TW7iLRk8y92T0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S3doPB010184;
        Mon, 27 Aug 2018 22:39:50 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 27
 Aug 2018 22:39:50 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 27 Aug 2018 22:39:49 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S3djGA005868;
        Mon, 27 Aug 2018 22:39:45 -0500
Subject: Re: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
To:     Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
 <454c277e-8a63-81cb-b341-a50f4e25cbea@ti.com>
 <20180820143153.GD7523@atomide.com>
 <40cecb47-bd32-04aa-b7cd-ff16c1eb28f3@ti.com>
 <20180827155535.GJ7523@atomide.com> <20180828012224.fbmcmwfhfuwhcm53@kahuna>
CC:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh R <vigneshr@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f947ea13-9273-e951-c6af-673d1e6a9570@ti.com>
Date:   Tue, 28 Aug 2018 09:09:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180828012224.fbmcmwfhfuwhcm53@kahuna>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 28 August 2018 06:52 AM, Nishanth Menon wrote:
> On 15:55-20180827, Tony Lindgren wrote:
>> * Kishon Vijay Abraham I <kishon@ti.com> [180827 03:06]:
>>> Hi Tony,
>>>
>>> On Monday 20 August 2018 08:01 PM, Tony Lindgren wrote:
>>>> * Kishon Vijay Abraham I <kishon@ti.com> [180808 06:35]:
>>>>> On Tuesday 05 June 2018 07:35 PM, Rob Herring wrote:
>>>>>> Really need 64-bit addresses and sizes? Use ranges to limit the
>>>>>> address space if possible.
>>>>>
>>>>> We now have address-cells as <1>,
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am65.dtsi#n49
>>>>>
>>>>> However each PCIe instance has 2 data regions and one of the regions
>>>>> (PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT1/PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT1 specified
>>>>> in the "MAIN Domain Memory Map" table of TRM http://www.ti.com/lit/pdf/spruid7)
>>>>> is above the 32bit region and requires 2 cells to specify the start address.
>>>>> This region is used to access MEM_SPACE of PCIe endpoint when operating in root
>>>>> complex mode and access memory of PCI root complex when operating in endpoint mode.
>>>>>
>>>>> In order to describe this, should we change the address-cells back to <2> or do
>>>>> you suggest any other alternatives?
>>>>
>>>> It's probably best to have the top level cbass interconnect use
>>>> #size-cells = <2> and then have it's child interconnects have
>>>> #size-cells = <1> if they don't need ranges above 4GB.
>>>
>>> PCIe has a region starting at 0x40_00000000 and size 4GB. We need 2 address
>>> cells and 2 size cells to describe this no?
>>
>> Yes.
>>
>>>> BTW, what's the difference between all these three similar PCIE
>>>> ranges?
>>>>
>>>> PCIE0_CORE_CORE_DAT_SLV_PCIE_CORE 0x0005500000 0x0005600000 1 MB
>>>> PCIE1_CORE_CORE_DAT_SLV_PCIE_CORE 0x0005600000 0x0005700000 1 MB
>>>
>>> This is the register space for the two instances of PCIe controller.
>>>>
>>>> PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT0 0x0010000000 0x0018000000 128 MB
>>>> PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT0 0x0018000000 0x0020000000 128 MB
>>>>
>>>> PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT1 0x4000000000 0x4100000000 4 GB
>>>> PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT1 0x4100000000 0x4200000000 4 GB
>>>
>>> The above are regions which can be used by CPU/DMA to access the PCIe address
>>> space. The mapping from the above regions to the PCIe address space will be
>>> programmed in the PCIe controller.
>>
>> OK so not just somethng for dma-ranges but also accessible by
>> the CPU.
>>
> 
> Kishon, Sekhar:
> 
> Can you guys post patches based on v4.19-rc1 for fixing this? I do have
> a bunch of dts nodes to build as well for v4.20, once Tony / Rob acks the
> changes.

Sure, I'll post that today.

Thanks
Kishon
