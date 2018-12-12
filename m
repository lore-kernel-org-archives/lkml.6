Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30C3C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8546920849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tsgrNi21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8546920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeLLKom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:44:42 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46448 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLLKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:44:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBCAiOas092605;
        Wed, 12 Dec 2018 04:44:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544611464;
        bh=29+ey1wP6Gczj2n17144V2b4PvDztLDKpNT/a84XmDw=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=tsgrNi21dl2dLGPp5aokRen4ua/deiG7yT0UQkxTIhfVQMHrF4FjV7K1y+80niLeE
         6NfCk3ue0SFg+JeLh7tKKpragJypJNtVEgDQ0pc+1G+rPiWox1b+JZCeQyEqF/5I00
         B4YrgAFvLGTcmBTMVECXgvBvMo9Hj+ILLzSokCTU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBCAiOTS006444
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 04:44:24 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 12
 Dec 2018 04:44:24 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 12 Dec 2018 04:44:24 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBCAiLFE002383;
        Wed, 12 Dec 2018 04:44:21 -0600
Subject: Re: [PATCH] ARM: dts: omap5: Add l4 interconnect hierarchy and
 ti-sysc data
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>
CC:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20181115224546.61475-1-tony@atomide.com>
 <9b7e07ae-66f9-cedf-937d-b1c5c510e018@ti.com>
Message-ID: <ebc7e271-8717-fe9d-d24f-ae406860b913@ti.com>
Date:   Wed, 12 Dec 2018 12:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <9b7e07ae-66f9-cedf-937d-b1c5c510e018@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2018 12.12, Peter Ujfalusi wrote:
> Tony,
> 
> On 16/11/2018 0.45, Tony Lindgren wrote:
>> Similar to commit 8f42cb7f64c7 ("ARM: dts: omap4: Add l4 interconnect
>> hierarchy and ti-sysc data"), let's add proper interconnect hierarchy
>> for l4 interconnect instances with the related ti-sysc interconnect
>> module data as in Documentation/devicetree/bindings/bus/ti-sysc.txt.
>>
>> Using ti-sysc driver binding allows us to start dropping legacy platform
>> data in arch/arm/mach-omap2/omap*hwmod*data.c files later on in favor of
>> ti-sysc dts data.
>>
>> This data is generated based on platform data from a booted system
>> and the interconnect acces protection registers for ranges. To avoid
>> regressions, we initially validate the device tree provided data
>> against the existing platform data on boot.
> 
> Reverting this patch in linux-next-20181210 will make the ethernet
> working again.
> 
> bootlog w/ revert: https://pastebin.com/dpRk1xWv
> bootlog w/o revert: https://pastebin.com/PWrBttxd

on omap5-uevm.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
