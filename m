Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C9DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11D12063F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aCML68/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfB0Jwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:52:35 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51400 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfB0Jwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:52:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1R9pNkq052559;
        Wed, 27 Feb 2019 03:51:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551261083;
        bh=yF8gzQ5n86ofp2GeqC5j5kpyXhMZD26e5MxQjR2necQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aCML68/UqBqaLk2IydB84o5oiOJ2ZCkBHAKfLHE3pXdPq7IxoxdkEPsA34IkHlq+H
         Cg+A/Sy4aKqTc3uwzfP0VSpRytgjvE6rlebpTw8mAuGe0We8E8ZMSuj1Eh2rB4GBE4
         vrm8lQBVjTM5tzUsU2Fv1j4Ns/YtFg7bb63hfMDA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1R9pNnP119697
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Feb 2019 03:51:23 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 27
 Feb 2019 03:51:23 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 27 Feb 2019 03:51:23 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1R9pIWV000755;
        Wed, 27 Feb 2019 03:51:19 -0600
Subject: Re: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Nori, Sekhar" <nsekhar@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-4-vigneshr@ti.com>
 <7e79fff7-2565-28f7-7b2b-bb3098f1a928@cogentembedded.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <3952b327-3aff-a32e-4280-6ab24c32cfd9@ti.com>
Date:   Wed, 27 Feb 2019 15:22:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <7e79fff7-2565-28f7-7b2b-bb3098f1a928@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/02/19 11:46 PM, Sergei Shtylyov wrote:
> On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:
> 
>> Cypress HyperBus is Low Signal Count, High Performance Double Data Rate Bus
>> interface between a host system master and one or more slave interfaces.
>> HyperBus is used to connect microprocessor, microcontroller, or ASIC
>> devices with random access NOR flash memory(called HyperFlash) or
>> self refresh DRAM(called HyperRAM).
>>
>> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
>> signal and either Single-ended clock(3.0V parts) or Differential clock
>> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
>> At bus level, it follows a separate protocol described in HyperBus
>> specification[1].
>>
>> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
>> to that of existing parallel NORs. Since Hyperbus is x8 DDR bus,
>> its equivalent to x16 parallel NOR flash wrt bits per clk. But Hyperbus
>> operates at >166MHz frequencies.
>> HyperRAM provides direct random read/write access to flash memory
>> array.
>>
>> But, Hyperbus memory controllers seem to abstract implementation details
>> and expose a simple MMIO interface to access connected flash.
>>
>> Add support for registering HyperFlash devices with MTD framework. MTD
>> maps framework along with CFI chip support framework are used to support
>> communicate with flash.
>>
>> Framework is modelled along the lines of spi-nor framework. HyperBus
>> memory controller(HBMC) drivers call hb_register_device() to register a
>> single HyperFlash device. HyperFlash core parses MMIO access
>> information from DT, sets up the map_info struct, probes CFI flash and
>> registers it with MTD framework.
>>
>> Some HBMC masters need calibration/training sequence[3] to be carried
>> out, in order for DLL inside the controller to lock, by reading a known
>> string/pattern. This is done by repeatedly reading CFI Query
>> Identification String. Calibration needs to be done before try to detect
>> flash as part of CFI flash probe.
>>
>> HyperRAM is not supported atm.
>>
>> HyperBus specification can be found at[1]
>> HyperFlash datasheet can be found at[2]
>>
>> [1] https://www.cypress.com/file/213356/download
>> [2] https://www.cypress.com/file/213346/download
>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>     Table 12-5741. HyperFlash Access Sequence
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> [...]
>> diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
>> new file mode 100644
>> index 000000000000..0aa11458c424
>> --- /dev/null
>> +++ b/include/linux/mtd/hyperbus.h
>> @@ -0,0 +1,73 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +
>> +#ifndef __LINUX_MTD_HYPERBUS_H__
>> +#define __LINUX_MTD_HYPERBUS_H__
>> +
>> +#include <linux/mtd/map.h>
>> +
>> +enum hb_memtype {
>> +	HYPERFLASH,
>> +	HYPERRAM,
>> +};
>> +
>> +/**
>> + * struct hb_device - struct representing Hyperbus slave device
>> + * @map: map_info struct for accessing MMIO Hyperbus flash memory
>> + * @dev: device pointer of Hyperbus Controller
> 
>    I think we need a separate structure for the HyperBus controller, not just
> for the slave devices...
> 
>> + * @np:	pointer to Hyperbus slave device node
>> + * @mtd: pointer to MTD struct
>> + * @ops: pointer to custom Hyperbus ops
>> + * @memtype: type of memory device: Hyperflash or HyperRAM
>> + * @needs_calib: flag to indicate whether calibration sequence is needed
>> + * @registered: flag to indicate whether device is registered with MTD core
>> + */
>> +
>> +struct hb_device {
>> +	struct map_info map;
>> +	struct device *dev;
>> +	struct device_node *np;
>> +	struct mtd_info *mtd;
>> +	struct hb_ops *ops;
>> +	enum hb_memtype memtype;
>> +	bool needs_calib;
>> +	bool registered;
>> +};
>> +
>> +/**
>> + * struct hb_ops - struct representing custom Hyperbus operations
>> + * @read16: read 16 bit of data, usually from register/ID-CFI space
>> + * @write16: write 16 bit of data, usually to register/ID-CFI space
>> + * copy_from: copy data from flash memory
>> + * copy_to: copy data to flash_memory
>> + */
>> +
>> +struct hb_ops {
>> +	u16 (*read16)(struct hb_device *hbdev, unsigned long addr);
>> +	void (*write16)(struct hb_device *hbdev, unsigned long addr, u16 val);
>> +
>> +	void (*copy_from)(struct hb_device *hbdev, void *to,
>> +			  unsigned long from, ssize_t len);
>> +	void (*copy_to)(struct hb_device *dev, unsigned long to,
>> +			const void *from, ssize_t len);
> 
>    ... else these methods won't fly if you need to "massage" the controller
> registers inside them...
> 

If accessing controller register is the only need, wouldn't a private
data pointer within struct hb_device be sufficient to hold pointer to
controller specific struct?

struct hb_device {
	...
	void *priv; /* points to controller's private data */
};


Or do you see a need for separate structure for the HyperBus controller?


>> +};
> [...]
> 
> MBR, Sergei
> 

-- 
Regards
Vignesh
