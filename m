Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261C2C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5220223E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pg+SCAJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5220223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeHJMf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:35:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42880 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeHJMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:35:58 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7AA6bK3075271;
        Fri, 10 Aug 2018 05:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533895597;
        bh=8qHl82uj/MXSecuLNDbKhCyiyUcXuvViGKsoHE/KlC8=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=pg+SCAJZMqi/7yGMYEM5XAJ/4rqFuaS/SFmhA6vVBR1ZPxBq2ScB03ffi/xSD/T/B
         enkWRiJqhzXkvIQLqzw3Q64mIITyS/A/yR2mnTUpldI3KthOItqjfJhRPTbDK7RL19
         +oQXRFFudJ8fxK+0iIO+RN+Nzv7pxxIJbdg4FeFk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7AA6bnK022550;
        Fri, 10 Aug 2018 05:06:37 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 10
 Aug 2018 05:06:36 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 10 Aug 2018 05:06:37 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7AA6XrN015345;
        Fri, 10 Aug 2018 05:06:34 -0500
From:   Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 0/4] pci-dra7xx: Enable errata i870 workaround for RC
 mode
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tony Lindgren <tony@atomide.com>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180724173150.2701-1-vigneshr@ti.com>
 <20180808165700.GB486@e107981-ln.cambridge.arm.com>
Message-ID: <ba428a15-77bf-e09c-3bd7-b5a0eae7ee13@ti.com>
Date:   Fri, 10 Aug 2018 15:37:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808165700.GB486@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 08 August 2018 10:27 PM, Lorenzo Pieralisi wrote:
> On Tue, Jul 24, 2018 at 11:01:46PM +0530, Vignesh R wrote:
>> Make workaround for errata i870 applicable in Host mode as
>> well(previously it was enabled only for EP mode) as per errata
>> documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf
>>
>> Tested on DRA72 EVM
>>
>> Tony,
>>
>> If you are okay with the series, could you pick this via omap tree?
>> All ACKs are in place and Lorenzo is okay with PCIe bits to go along with
>> rest of DTS changes.
> 
> I think we have missed the v4.19 merge window by now - 

Right. I didn't get any response from Tony.

> please let me know if I can drop this series from the PCI patch queue.
> 

Ok, I will resend the patch after 4.19-rc. Thanks!

Regards
Vignesh


> Thanks,
> Lorenzo
> 
>> Regards
>> Vignesh
>>
>>
>> Changes since v2:
>> Reorder patch 2 to appear at the last.
>> Collect all the ACKs
>>
>> Changes since v1:
>> Drop IRQ handling rework (will be sent out separately)
>>
>> v2: https://patchwork.ozlabs.org/cover/935454/
>> v1: https://lkml.org/lkml/2017/12/1/59
>>
>>
>> Vignesh R (4):
>>   dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
>>     mode
>>   ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode
>>   ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
>>   pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
>>
>>  Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
>>  arch/arm/boot/dts/dra7.dtsi                      |  4 +++-
>>  drivers/pci/controller/dwc/pci-dra7xx.c          | 12 ++++++------
>>  3 files changed, 14 insertions(+), 7 deletions(-)
>>
>> -- 
>> 2.18.0
>>
