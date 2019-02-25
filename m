Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418F8C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DB02087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qs9bG0AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfBYSWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:22:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58464 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbfBYSWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:22:18 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1PILloQ092092;
        Mon, 25 Feb 2019 12:21:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551118907;
        bh=VqRY4kTAcfrcqYD9bOmv6dPMbs9v2Ubxw35ViTsI4rQ=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=Qs9bG0AL75TNrQ1PFCH8P8mYDPSbVIQwYrJpLmsvwU+hqw2MrX6XqOoqn6KnfLkUZ
         EB1de2rytH7geO8t7EOpSNl91Jtp1Q5Xu+elhAq7LB1HnBp/iNCywn7HEqqHutHgkg
         GFjrSYmnyQxSufFwRK2ATKlLOEZkV9s/jL83dQDA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1PILlLU076792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Feb 2019 12:21:47 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 25
 Feb 2019 12:21:46 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 25 Feb 2019 12:21:46 -0600
Received: from [172.22.216.156] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1PILe9J026012;
        Mon, 25 Feb 2019 12:21:41 -0600
From:   Vignesh R <vigneshr@ti.com>
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
 <42d0fd7b-42e0-605c-70ee-6e308908fc90@cogentembedded.com>
Message-ID: <4910fda5-133d-7ebb-6ab3-49e0839ea920@ti.com>
Date:   Mon, 25 Feb 2019 23:51:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <42d0fd7b-42e0-605c-70ee-6e308908fc90@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

On 24/02/19 1:49 AM, Sergei Shtylyov wrote:
> Hello!
> 
> On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:
> 
>> Cypress HyperBus is Low Signal Count, High Performance Double Data Rate Bus
>> interface between a host system master and one or more slave interfaces.
>> HyperBus is used to connect microprocessor, microcontroller, or ASIC
>> devices with random access NOR flash memory(called HyperFlash) or
> 
>   Need space before (.
> 
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
> 
>    Communicating.
> 
>> Framework is modelled along the lines of spi-nor framework. HyperBus
>> memory controller(HBMC) drivers call hb_register_device() to register a
> 
>    Again, space needed before (.
> 
>> single HyperFlash device. HyperFlash core parses MMIO access
>> information from DT, sets up the map_info struct, probes CFI flash and
>> registers it with MTD framework.
>>
>> Some HBMC masters need calibration/training sequence[3] to be carried
>> out, in order for DLL inside the controller to lock, by reading a known
>> string/pattern. This is done by repeatedly reading CFI Query
>> Identification String. Calibration needs to be done before try to detect
> 
>    Trying.
> 
>> flash as part of CFI flash probe.
>>
>> HyperRAM is not supported atm.
> 
>    ATM?
> 
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
>> diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
>> new file mode 100644
>> index 000000000000..02c38afc5c50
>> --- /dev/null
>> +++ b/drivers/mtd/hyperbus/Kconfig
>> @@ -0,0 +1,23 @@
>> +menuconfig MTD_HYPERBUS
>> +	tristate "Hyperbus support"
>> +	select MTD_CFI
>> +	select MTD_MAP_BANK_WIDTH_2
>> +	select MTD_CFI_AMDSTD
>> +	select MTD_COMPLEX_MAPPINGS
>> +	help
>> +	  This is the framework for the Hyperbus which can be used by
>> +	  the Hyperbus Controller driver to commmunicate with
>                                               ^^^
>   Too many m's. :-)
> 
>> +	  Hyperflash. See Cypress Hyperbus specification for more
>> +	  details
>> +
>> +
>> +if MTD_HYPERBUS
>> +
>> +config HBMC_AM654
>> +	tristate "Hyperbus controller driver for AM65x SoC"
>> +	help
>> +	 This is the driver for Hyperbus controller on TI's AM65x and
>> +	 other SoCs
>> +
>> +endif # MTD_HYPERBUS
> 
>   The above clearly belongs to patch #5.
> 
>> +
> 
>    No empty lines at end of file, please...
> 
>> diff --git a/drivers/mtd/hyperbus/Makefile b/drivers/mtd/hyperbus/Makefile
>> new file mode 100644
>> index 000000000000..64e377d7f636
>> --- /dev/null
>> +++ b/drivers/mtd/hyperbus/Makefile
>> @@ -0,0 +1,4 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_MTD_HYPERBUS)	+= core.o
>> +obj-$(CONFIG_HBMC_AM654)	+= hbmc_am654.o
> 
>    The above line clearly belongs to patch #5 as well...

Right, will fix this and all the above comments.

> 
>> diff --git a/drivers/mtd/hyperbus/core.c b/drivers/mtd/hyperbus/core.c
>> new file mode 100644
>> index 000000000000..d3d44aab7503
>> --- /dev/null
>> +++ b/drivers/mtd/hyperbus/core.c
>> @@ -0,0 +1,167 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> +// Author: Vignesh R <vigneshr@ti.com>
>> +
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mtd/hyperbus.h>
>> +#include <linux/mtd/map.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/cfi.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/types.h>
>> +
>> +#define HB_CALIB_COUNT 25
> 
>    Isn't this controller specific?
> 
> [...]
>> +/* Calibrate HBMC by repeatedly reading "QRY" string from CFI space */
>> +static int hb_calibrate(struct hb_device *hbdev)
> 
>    s/int/bool/, perhaps?
> 
> [...]
>> +int hb_register_device(struct hb_device *hbdev)
>> +{
>> +	struct resource res;
>> +	struct device *dev;
>> +	struct device_node *np;
>> +	struct map_info *map;
>> +	struct hb_ops *ops;
>> +	int err;
>> +
>> +	if (!hbdev || !hbdev->dev || !hbdev->np) {
>> +		pr_err("hyperbus: please fill all the necessary fields!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	np = hbdev->np;
>> +	if (!of_device_is_compatible(np, "cypress,hyperflash"))
>> +		return -ENODEV;
>> +
>> +	hbdev->memtype = HYPERFLASH;
>> +
>> +	if (of_address_to_resource(np, 0, &res))
> 
>     Isn't the direct mapping property of the HF controller, not of HyperFlash
> itself?
> 

As I said in the cover letter, I could not find many examples of HF
controllers, but couple of them that I studied provide MMIO access to
flash. So, reg property of flash node would represent local address on
the HyperBus and controller node would set up ranges properly to provide
translation from CS to SoC address space.
For example see patch 4/5 where reg property would indicate CS and Size
of flash. This scheme is similar to whats described here [1]
HBMC controllers usually have different MMIO regions to access flashes
connected to different CS. So using ranges for address translation along
with flash node describing local address works pretty well.

My understanding is that this part of code will be common for most MMIO
based HB controllers and hence made part of core layer. But, if
controllers uses different IO space for read vs write, then this needs a
bit of thinking. In that case, mapping needs to be moved to controller
drivers.

[1]https://elinux.org/Device_Tree_Usage#Ranges_.28Address_Translation.29

>> +		return -EINVAL;
>> +
>> +	dev = hbdev->dev;
>> +	map = &hbdev->map;
>> +	map->size = resource_size(&res);
>> +	map->virt = devm_ioremap_resource(dev, &res);
>> +	if (IS_ERR(map->virt))
>> +		return PTR_ERR(map->virt);
>> +
>> +	map->name = dev_name(dev);
>> +	map->bankwidth = 2;
>> +
>> +	simple_map_init(map);
> 
>    It's not that simple, I'm afraid -- e.g. Renesas RPC-IF has read and write
> mappings in the separate memory resources.
> 

Hmm, could you point me to public datasheet of the controller?
simple_map_init() provides default implementation for map operations
which is overridden, if hb_ops is populated.
I think, Renesas RPC-IF can populate custom hb_ops struct and use
appropriate MMIO base for read vs write, while still reusing the map
framework. Wouldnt that work?

> [...]
>> +	if (hbdev->needs_calib) {
>> +		err = hb_calibrate(hbdev);
>> +		if (!err) {
> 
>    Why call this variable 'err' when it indicates successful calibration?
> 
>> +			dev_err(hbdev->dev, "Calibration failed\n");
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>> +	hbdev->mtd = do_map_probe("cfi_probe", map);
>> +	if (!hbdev->mtd) {
>> +		dev_err(hbdev->dev, "probing failed\n");
> 
>    "map probe", perhaps?
> 
>> +		return -ENXIO;
>> +	}
>> +
>> +	hbdev->mtd->dev.parent = hbdev->dev;
>> +	mtd_set_of_node(hbdev->mtd, np);
>> +
>> +	err = mtd_device_register(hbdev->mtd, NULL, 0);
>> +	if (err) {
>> +		dev_err(hbdev->dev, "failed to register mtd device\n");
>> +		goto err_destroy;
>> +	}
>> +	hbdev->registered = true;
>> +
>> +	return 0;
>> +
>> +err_destroy:
> 
>    The label and the code below doesn't seem necessary. Just do it above
> instead of *goto*.
> 
>> +	map_destroy(hbdev->mtd);
>> +	return err;
>> +}
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
> 
>    I'm for the full hyperbus_ prefixes, it's not that long and seems clearer.
> 
> [...]

Will address remaining comments on this patch in the next round. Thanks
for the review!

> 
> MBR, Sergei
> 

-- 
Regards
Vignesh
