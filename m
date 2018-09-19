Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1582A208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b1LZy+mI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1582A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733198AbeITAVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:21:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60012 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbeITAVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:21:40 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8JIfv0j004278;
        Wed, 19 Sep 2018 13:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537382517;
        bh=cm+4Q7YfahsqStd+dlPsvTIKZW2qTPKEdRq3jKrylFs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=b1LZy+mIGKSm/d/Z3tDwRCG+zpb9KTkKFBVSppFc+jxY/V/usW5oZY6kIBbG5FUqa
         H9aJ9OhrMHqcBDo59vVGSaMEZ8K5h1R+QQiHNbC8/37jmhvWbn7qLpmkFH5NtNbOxV
         9LVD9CYalufleGKJ9lzbDZgZT/89sMAtpnc5N8Fg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8JIfvDT022040;
        Wed, 19 Sep 2018 13:41:57 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 19
 Sep 2018 13:41:57 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 19 Sep 2018 13:41:57 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8JIfq3s004062;
        Wed, 19 Sep 2018 13:41:53 -0500
Subject: Re: [PATCH v3] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
To:     Nishanth Menon <nm@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
CC:     Tony Lindgren <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Vignesh R <vigneshr@ti.com>
References: <20180905111738.8280-1-kishon@ti.com>
 <20180905134037.szkh3wnugrtnrrfh@kahuna>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <ab5fa0c0-8b45-fcaf-baaf-1f948328d9ed@ti.com>
Date:   Wed, 19 Sep 2018 21:41:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905134037.szkh3wnugrtnrrfh@kahuna>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/18 16:40, Nishanth Menon wrote:
> On 11:17-20180905, Kishon Vijay Abraham I wrote:
>> AM65 has two PCIe controllers and each PCIe controller has '2' address
>> spaces one within the 4GB address space of the SoC and the other above
>> the 4GB address space of the SoC (cbass_main) in addition to the
>> register space. The size of the address space above the 4GB SoC address
>> space is 4GB. These address ranges will be used by CPU/DMA to access
>> the PCIe address space. In order to represent the address space above
>> the 4GB SoC address space and to represent the size of this address
>> space as 4GB, change address-cells and size-cells of interconnect to 2.
>>
>> Since OSPI has similar need in MCU Domain Memory Map, change
>> address-cells and size-cells of cbass_mcu interconnect also to 2.
>>
>> Fixes: ea47eed33a3fe3d919 ("arm64: dts: ti: Add Support for AM654 SoC")
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Acked-by: Vignesh R <vigneshr@ti.com>
>> ---
>> Changes from v2:
>> Added Fixes tag.
> 
> Thanks.
> Acked-by: Nishanth Menon <nm@ti.com>
> 
> Tero: Could we take this for v4.20 ? While this is a bug fix, I think
> it might be better in v4.20 window since it will help provide a clean merge
> of follow on nodes.
> 

Yes, queuing up for 4.20, thanks.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
