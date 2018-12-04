Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9FFC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0271720851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T3Pk6gBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0271720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeLDIr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:47:57 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58556 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:47:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB48lr8O121458;
        Tue, 4 Dec 2018 02:47:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543913273;
        bh=YZs9idrP8fmXsbxJG74bl8SVmfgSrX4h4P96pIetbUA=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=T3Pk6gBp+Vg+3B3UBMzd7y1fg5pkZNr5/RUcHITaeiUBndh5BvbSSqVo6e/Q+DxUv
         Xk3O/LX7fg4BkUunclrIW653L1v5UvhuN+Z2kDqWluT9Zm05kzJfRJyoWcwHTX/JcU
         kR9Y3LuTpI8QgIjmmne2F6DBVPZh0CQ5SWkHrBNA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB48lr7U129331
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 02:47:53 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 4
 Dec 2018 02:47:52 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 4 Dec 2018 02:47:52 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB48lmR8025222;
        Tue, 4 Dec 2018 02:47:49 -0600
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
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C063F34.5080301@ti.com>
Date:   Tue, 4 Dec 2018 10:47:48 +0200
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

OK. Thanks.
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
