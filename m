Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86521C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E8820897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gsDMn9nJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E8820897
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeH1FMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:12:06 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44266 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeH1FMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:12:06 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7S1MOWV061842;
        Mon, 27 Aug 2018 20:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535419344;
        bh=uV0tq9E2dkvt29IrRBbmjjgxW7tRmaF1Ow/e1FFMGJU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gsDMn9nJxI8M4t+OZ6OlQ9qFA+DNcG7z5L7H+ORI5JgaH55NoPNfQiwFqREUkkl5J
         pmORXZPqENADgFr+zEvxpKLQTQg5RzgfXj10l776kS2M+CLsSIxcvUcmMG2+OLT53M
         qsBoSdKvH3ek38g4EzlllThW7m+KQc3h9PQDRGpM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S1MOdl017060;
        Mon, 27 Aug 2018 20:22:24 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 27
 Aug 2018 20:22:24 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 27 Aug 2018 20:22:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S1MOFo006259;
        Mon, 27 Aug 2018 20:22:24 -0500
Date:   Mon, 27 Aug 2018 20:22:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
Message-ID: <20180828012224.fbmcmwfhfuwhcm53@kahuna>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
 <454c277e-8a63-81cb-b341-a50f4e25cbea@ti.com>
 <20180820143153.GD7523@atomide.com>
 <40cecb47-bd32-04aa-b7cd-ff16c1eb28f3@ti.com>
 <20180827155535.GJ7523@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180827155535.GJ7523@atomide.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:55-20180827, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [180827 03:06]:
> > Hi Tony,
> > 
> > On Monday 20 August 2018 08:01 PM, Tony Lindgren wrote:
> > > * Kishon Vijay Abraham I <kishon@ti.com> [180808 06:35]:
> > >> On Tuesday 05 June 2018 07:35 PM, Rob Herring wrote:
> > >>> Really need 64-bit addresses and sizes? Use ranges to limit the
> > >>> address space if possible.
> > >>
> > >> We now have address-cells as <1>,
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am65.dtsi#n49
> > >>
> > >> However each PCIe instance has 2 data regions and one of the regions
> > >> (PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT1/PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT1 specified
> > >> in the "MAIN Domain Memory Map" table of TRM http://www.ti.com/lit/pdf/spruid7)
> > >> is above the 32bit region and requires 2 cells to specify the start address.
> > >> This region is used to access MEM_SPACE of PCIe endpoint when operating in root
> > >> complex mode and access memory of PCI root complex when operating in endpoint mode.
> > >>
> > >> In order to describe this, should we change the address-cells back to <2> or do
> > >> you suggest any other alternatives?
> > > 
> > > It's probably best to have the top level cbass interconnect use
> > > #size-cells = <2> and then have it's child interconnects have
> > > #size-cells = <1> if they don't need ranges above 4GB.
> > 
> > PCIe has a region starting at 0x40_00000000 and size 4GB. We need 2 address
> > cells and 2 size cells to describe this no?
> 
> Yes.
> 
> > > BTW, what's the difference between all these three similar PCIE
> > > ranges?
> > > 
> > > PCIE0_CORE_CORE_DAT_SLV_PCIE_CORE 0x0005500000 0x0005600000 1 MB
> > > PCIE1_CORE_CORE_DAT_SLV_PCIE_CORE 0x0005600000 0x0005700000 1 MB
> > 
> > This is the register space for the two instances of PCIe controller.
> > > 
> > > PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT0 0x0010000000 0x0018000000 128 MB
> > > PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT0 0x0018000000 0x0020000000 128 MB
> > > 
> > > PCIE0_CORE_CORE_DAT_SLV_PCIE_DAT1 0x4000000000 0x4100000000 4 GB
> > > PCIE1_CORE_CORE_DAT_SLV_PCIE_DAT1 0x4100000000 0x4200000000 4 GB
> > 
> > The above are regions which can be used by CPU/DMA to access the PCIe address
> > space. The mapping from the above regions to the PCIe address space will be
> > programmed in the PCIe controller.
> 
> OK so not just somethng for dma-ranges but also accessible by
> the CPU.
> 

Kishon, Sekhar:

Can you guys post patches based on v4.19-rc1 for fixing this? I do have
a bunch of dts nodes to build as well for v4.20, once Tony / Rob acks the
changes.

-- 
Regards,
Nishanth Menon
