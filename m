Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A63AECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81EE20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fP3VG+zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81EE20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbeGSLgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:36:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39336 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeGSLgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:36:24 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6JArdjg081251;
        Thu, 19 Jul 2018 05:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531997619;
        bh=spoir6AF+heVpcM9wftUZcCN9UZRXMJgzVgdnvQx5lo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fP3VG+znUajAW4ZKBldipg5gAQ5Bm4RLbbqQ+AmephZ9I/cuQGS4ocCRI2/HCf718
         I2RBqnz0Lkru7wElzOTcPOt/YCYYHmMgHmi37HBsbBavBDF1q7rHa8v755437oNHoN
         xELP+LT0z6b0p/i/ZSL9jV/TX2Kz/oWwwtn3ANw8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6JArdwE005862;
        Thu, 19 Jul 2018 05:53:39 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 19
 Jul 2018 05:53:39 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 19 Jul 2018 05:53:39 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6JArZli007468;
        Thu, 19 Jul 2018 05:53:36 -0500
Subject: Re: [PATCH v2 4/4] ARM: dts: dra7: Fix up unaligned access setting
 for PCIe EP
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <20180627122919.23926-1-vigneshr@ti.com>
 <20180627122919.23926-5-vigneshr@ti.com>
 <92691b59-1952-b00f-da5b-f308f94aa2b7@ti.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <9bdf39d4-d9db-b80f-e3f4-88c3e068c306@ti.com>
Date:   Thu, 19 Jul 2018 16:24:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <92691b59-1952-b00f-da5b-f308f94aa2b7@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Tuesday 17 July 2018 03:25 PM, Kishon Vijay Abraham I wrote:
> 
> 
> On Wednesday 27 June 2018 05:59 PM, Vignesh R wrote:
>> Bit positions of PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE and
>> PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE in CTRL_CORE_SMA_SW_7 are
>> incorrectly documented in the TRM. In fact, the bit positions are
>> swapped. Update the DT bindings for PCIe EP to reflect the same.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> Shouldn't this be sent to stable fixes?

This patch fixes:

Fixes: d23f3839fe97 ("ARM: dts: DRA7: Add pcie1 dt node for EP mode")
Cc: stable@vger.kernel.org

let me know if this needs to be resent with Fixes tag.

Regards
Vignesh

> 
> Thanks
> Kishon
>> ---
>>  arch/arm/boot/dts/dra7.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 7bfe7f28e3bd..27ad193e1a87 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -355,7 +355,7 @@
>>  				ti,hwmods = "pcie1";
>>  				phys = <&pcie1_phy>;
>>  				phy-names = "pcie-phy0";
>> -				ti,syscon-unaligned-access = <&scm_conf1 0x14 2>;
>> +				ti,syscon-unaligned-access = <&scm_conf1 0x14 1>;
>>  				status = "disabled";
>>  			};
>>  		};
>>
