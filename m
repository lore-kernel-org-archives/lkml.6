Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDC7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A87020989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X2VkAwSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A87020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeK2Ubx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:31:53 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60534 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeK2Ubw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:31:52 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAT9QJG6116951;
        Thu, 29 Nov 2018 03:26:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543483579;
        bh=5b3kQiwWpF2G5Cv//AODzu9l4bNfEwRRwsKpJgE0BGs=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=X2VkAwSUYfxwoddhunpM+33VRiE8Y/48Xsiz7WshX0OjCoMiVQ3VbrVsQQhM+/y/6
         /L9C2fD8U+j0R8Az1wsv2hNPH5NXPO/RgAJ3aFIooG1NpzBZ00gCvFgNXvhuymau0r
         AaXW+31eZjGeunvaXkZjK7b6EYxVW+wOX8aLbcF4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAT9QJtJ126415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 03:26:19 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 29
 Nov 2018 03:26:19 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 29 Nov 2018 03:26:19 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAT9QEO6005908;
        Thu, 29 Nov 2018 03:26:14 -0600
Subject: Re: [PATCH 04/16] remoteproc/pru: Add PRU remoteproc driver
To:     David Lechner <david@lechnology.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-5-git-send-email-rogerq@ti.com>
 <e63ac3f9-8daf-af84-a200-4c5f40a1a3ed@lechnology.com>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFFB0B5.6070109@ti.com>
Date:   Thu, 29 Nov 2018 11:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <e63ac3f9-8daf-af84-a200-4c5f40a1a3ed@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/18 00:32, David Lechner wrote:
> On 11/26/18 1:52 AM, Roger Quadros wrote:
> 
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index ce5d061..88a86cc 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -26,3 +26,4 @@ qcom_wcnss_pil-y            += qcom_wcnss.o
>>   qcom_wcnss_pil-y            += qcom_wcnss_iris.o
>>   obj-$(CONFIG_ST_REMOTEPROC)        += st_remoteproc.o
>>   obj-$(CONFIG_ST_SLIM_REMOTEPROC)    += st_slim_rproc.o
>> +obj-$(CONFIG_PRUSS_REMOTEPROC)        += pru_rproc.o
>> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
>> new file mode 100644
>> index 0000000..c35f432
>> --- /dev/null
>> +++ b/drivers/remoteproc/pru_rproc.c
>> @@ -0,0 +1,392 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PRU-ICSS remoteproc driver for various TI SoCs
>> + *
>> + * Copyright (C) 2014-2018 Texas Instruments Incorporated - http://www.ti.com/
>> + *    Suman Anna <s-anna@ti.com>
>> + *    Andrew F. Davis <afd@ti.com>
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/remoteproc.h>
> 
> alphabetical order?
> 
>> +#include <linux/pruss.h>
>> +
>> +#include "remoteproc_internal.h"
> 
> alphabetical order?

ok for both.

> 
>> +#include "pru_rproc.h"
>> +
>> +/* PRU_ICSS_PRU_CTRL registers */
>> +#define PRU_CTRL_CTRL        0x0000
>> +#define PRU_CTRL_STS        0x0004
>> +#define PRU_CTRL_WAKEUP_EN    0x0008
>> +#define PRU_CTRL_CYCLE        0x000C
>> +#define PRU_CTRL_STALL        0x0010
>> +#define PRU_CTRL_CTBIR0        0x0020
>> +#define PRU_CTRL_CTBIR1        0x0024
>> +#define PRU_CTRL_CTPPR0        0x0028
>> +#define PRU_CTRL_CTPPR1        0x002C
>> +
>> +/* CTRL register bit-fields */
>> +#define CTRL_CTRL_SOFT_RST_N    BIT(0)
>> +#define CTRL_CTRL_EN        BIT(1)
>> +#define CTRL_CTRL_SLEEPING    BIT(2)
>> +#define CTRL_CTRL_CTR_EN    BIT(3)
>> +#define CTRL_CTRL_SINGLE_STEP    BIT(8)
>> +#define CTRL_CTRL_RUNSTATE    BIT(15)
>> +
>> +/**
>> + * enum pru_mem - PRU core memory range identifiers
>> + */
>> +enum pru_mem {
>> +    PRU_MEM_IRAM = 0,
>> +    PRU_MEM_CTRL,
>> +    PRU_MEM_DEBUG,
>> +    PRU_MEM_MAX,
>> +};
> 
> I am finding the name "mem" here to be confusing. I keep thinking
> these are just RAM regions instead of memory mapped I/O. Maybe call
> it "iomem" instead of "mem"?
> 

ok.

> ...
> 
>> +static int pru_rproc_set_id(struct pru_rproc *pru)
>> +{
>> +    int ret = 0;
>> +    u32 mask1 = 0x34000;
>> +    u32 mask2 = 0x38000;
> 
> These values are non-obvious and could use some comments. Also,
> they could be made into constants or macros.
> 

ok.

>> +
>> +    if ((pru->mem_regions[0].pa & mask1) == mask1)
> 
> how about this instead:
> 
>     if ((pru->mem_regions[PRU_MEM_IRAM].pa & 0xfffff) == mask1)
> 
> The 0xfffff mask will be important on AM18xx where INTC is at 0x34000,
> PRU0 IRAM is at 0x38000 and PRU1 IRAM is at 0x3C000.
> 

I think this approach of figuring out id based on IRAM address is not scalable.

At the moment ID is used for these operations

pruss_cfg_gpimode()
pruss_cfg_get_gpmux()
pruss_cfg_set_gpmux()

All of which affect the GPCFG register of the respective PRU.

I think a better approach is to get rid of this ID logic and provide the
GPCFG syscon address to the PRU node and let the pru driver directly affect the register.

e.g. on am335x

				pru0: pru@4a334000 {
					compatible = "ti,am3356-pru";
					...
					gpcfg = <&pruss_cfg 8>;
				};

So the API changes from

int pruss_cfg_get_gpmux(struct pruss *pruss, enum pruss_pru_id id, u8 *mux)

to

int pru_rproc_cfg_get_gpmux(struct pru_rproc *pru, u8 *mux)


>> +        pru->id = 0;
>> +    else if ((pru->mem_regions[0].pa & mask2) == mask2)
>> +        pru->id = 1;
>> +    else
>> +        ret = -EINVAL;
>> +
>> +    return ret;
>> +}
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
