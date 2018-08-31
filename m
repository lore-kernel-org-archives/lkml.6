Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C3CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B302D20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TBVs8Hcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B302D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbeHaTe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:34:57 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47134 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeHaTe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:34:56 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VFQWaX009580;
        Fri, 31 Aug 2018 10:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535729192;
        bh=5Ugnh40c+T5WQpgNEZUEKERHVr5XMam3hDY8ibXoiBg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TBVs8Hcw8UwKh5u7+b9qSJFTDkX38XeEPN+w/l2D00qHEgEVmUUaRh47/mcN15IgV
         OH4iT5OfWMmTrb2IhLgzZN4fW/ndOTEOTmm1niVG9pY1JNNlnftF/qWq0vRw79rQUF
         iWGoMyVosgJKSpkRoySgUIAOmNIJiRPJwH7S4Lrg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VFQWbN032091;
        Fri, 31 Aug 2018 10:26:32 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 10:26:31 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 10:26:31 -0500
Received: from [172.22.216.24] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VFQNkV022033;
        Fri, 31 Aug 2018 10:26:24 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
To:     Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180828102642.26482-1-kishon@ti.com>
 <20180828162556.GQ7523@atomide.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <6f5f8747-46c2-6133-d31a-6c441c24bcd4@ti.com>
Date:   Fri, 31 Aug 2018 20:56:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828162556.GQ7523@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On 28-Aug-18 9:55 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [180828 10:31]:
>> AM65 has two PCIe controllers and each PCIe controller has '2' address
>> spaces one within the 4GB address space of the SoC and the other above
>> the 4GB address space of the SoC in addition to the register space. The
>> size of the address space above the 4GB SoC address space is 4GB. These
>> address ranges will be used by CPU/DMA to access the PCIe address space.
>> In order to represent the address space above the 4GB SoC address space
>> and to represent the size of this address space as 4GB, change
>> address-cells and size-cells of interconnect to 2.
> ...
>>  		cbass_mcu: interconnect@28380000 {
>>  			compatible = "simple-bus";
>>  			#address-cells = <1>;
>>  			#size-cells = <1>;
> 

Looking at Table 2-2. MCU Domain Memory Map in TRM, OSPI has similar
need. There are two address ranges to access OSPI flash in memory mapped
mode:
MCU_FSS0_DAT_REG1 0x0050000000 0x0058000000 128 MB(32bit space)
MCU_FSS0_DAT_REG0 0x0400000000 0x0500000000 4 GB(64bit space with ECC)
MCU_FSS0_DAT_REG3 0x0500000000 0x0600000000 4 GB(64bit space w/o ECC)

Since, there are already OSPI flashes with size > 128MB, we would need
to use 4GB address space in kernel (which is above 32 bit space)

Therefore, could you also change cbass_mcu also to have
#address-cells = <2>?

Regards
Vignesh
