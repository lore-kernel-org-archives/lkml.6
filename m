Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57114C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C71220879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sriqZt2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C71220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeLNJzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:55:01 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35742 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNJzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:55:01 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBE9s4rX097667;
        Fri, 14 Dec 2018 03:54:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544781244;
        bh=IvFDD7GsygsbGaYzyr07t7DtGe9IKE7qZ8iSP8jH9vw=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=sriqZt2nAiS1idXpTJLTtrJqURbeSlPGy49btc1zpXBb+EL+vOkHMyJA9JhYxUj8Z
         kADNqc7CN09A8ykRsMFMVmD9DzkIdtpZVZ5pNXz5/3640i8m6s5lmNgkhpJ2lDD8PH
         Fn1Iw3gl25CmjLsWVNFDGdkx3PbUoLkf9Tuflz4Q=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBE9s49V017496
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 03:54:04 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 14
 Dec 2018 03:54:01 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 14 Dec 2018 03:54:01 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBE9rvu9013762;
        Fri, 14 Dec 2018 03:53:57 -0600
Subject: Re: [PATCH 04/16] remoteproc/pru: Add PRU remoteproc driver
To:     Dimitar Dimitrov <dinuxbg@gmail.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-5-git-send-email-rogerq@ti.com> <308735274.C9ZyqtqOL8@tpdeb>
CC:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        David Lechner <david@lechnology.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C137DB4.9070602@ti.com>
Date:   Fri, 14 Dec 2018 11:53:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <308735274.C9ZyqtqOL8@tpdeb>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dimitar,

On 30/11/18 23:39, Dimitar Dimitrov wrote:
> On Monday, 12/26/2018, 9:52:37 EET Roger Quadros wrote:
>> +/*
>> + * Convert PRU device address (instruction space) to kernel virtual address
>> + *
>> + * A PRU does not have an unified address space. Each PRU has its very own
>> + * private Instruction RAM, and its device address is identical to that of
>> + * its primary Data RAM device address.
>> + */
>> +static void *pru_i_da_to_va(struct pru_rproc *pru, u32 da, int len)
>> +{
>> +       u32 offset;
>> +       void *va = NULL;
>> +
>> +       if (len <= 0)
>> +               return NULL;
> 
> Could you please clear the upper 4 bits the of IRAM device address, in order 
> to support binutils ELF images? Here is an example line to add here:
> 
> +       /* GNU binutils do not support multiple address spaces. The 
> +        * default linker script from the official GNU pru-ld places 
> +        * IRAM at an arbitrary high offset, in order to differentiate it 
> +        * from DRAM. Hence we need to strip the artificial offset 
> +        * from the IRAM address. 
> +        */ 
> +       da &= ~0xf0000000u; 
> +
> 

After some more thought I'm not very sure how to proceed.

I'll be using the below 2 patches in the next patch spin in place of
patch 1 in the current series.
https://lore.kernel.org/lkml/20180623210810.21232-2-david@lechnology.com/
https://lore.kernel.org/lkml/20180623210810.21232-3-david@lechnology.com/

They figure out the PAGE (IRAM vs DRAM) by looking at TI specific section
attributes.

e.g.
[18] .TI.phattrs LOPROC+f000004 00000000 000e08 000010 00 0 0 4
[19] .TI.section.flags LOPROC+f000005 00000000 000e68 00002a 00 0 0 0
[20] .TI.section.page LOPROC+f000007 00000000 000e92 00002a 00 0 0 0

AFAIK the ELF by GNU pru-ld won't contain these sections.

We need to support ELF generated by both tools (TI clpru and GNU pru-ld).
Is it safe to assume that if the ELF doesn't have the TI specific sections
then it was generated by gnupru?

Is there a more straight forward way of differentiating the two. e.g. by looking
at something in the ELF header?

> 
>> +
>> +       if (da >= pru->iram_da &&
>> +           da + len <= pru->iram_da + pru->mem_regions[PRU_MEM_IRAM].size { 
>> +               offset = da - pru->iram_da;
>> +               va = (__force void *)(pru->mem_regions[PRU_MEM_IRAM].va +
>> +                                     offset);
>> +       }
>> +
>> +       return va;
>> +}
> 
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
