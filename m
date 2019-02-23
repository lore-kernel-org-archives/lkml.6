Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45A6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C22720675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="fJrQpQTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfBWUTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 15:19:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45247 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBWUTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 15:19:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id h10so4126992lfc.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 12:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=so8S+8x06h6Zr8gUjb8awpqJDd6cT+YXwuKXyySAEiQ=;
        b=fJrQpQTLFIZsHW/1c1u60xD516EODx1gKRsnVMUk9QDHdA3VfgDJ/SWb8ItUvXb6PD
         3cYA3Vxkxe3rpzBxrZqK3wtBqrBafR7wYlGOVO5Oflb8dqVzCmlj76+5N2ldk60bzolx
         yRy4cLbBgvC1YFql+WUsOeywFxWtzFXU091nrxYwNJoiihz0SBur1tuj6mZS+2VcvvXz
         RezhumVnGnUsorLs90xZQh8JUhhn8afpoByAtHgLMxWj+z8qzNnYajfmzkx4MhHcLyH8
         HSGWH6FmCv+YdGwoseu8RI8TQceDvFqwXiWU0bfW8OU8htxHF0d3IkQA0wQrGKMVa7PI
         eXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=so8S+8x06h6Zr8gUjb8awpqJDd6cT+YXwuKXyySAEiQ=;
        b=hk+TjMi0e216JRkbQcXfMecTtJCjaCUmfvYNfjM1JbaJreuNGxUFKtb9t93YvjjXMB
         eTJw24UpuohLc+8BacSpV6v4wdvHrP5T9F+U7SzMWKfT69UGQ/8LZEzK9pIslqwEJs4c
         e9tsuehrSdT/mVbA8KfGJM+bas1felbxqO0b1xqj9DLUygxQeM2ISKEo/uvS9TJCTyAL
         P2AubYROqlv8Lkx2D2gZg5IpxcLbT5d2mwVoNcIkfp7T5QxpfkjS3owR3Q71rpjnc/8H
         FYPdbS/etoF5ZEjnjP+bu+qeJ+M2K9El9qS6jSaqWvcDdHhV8ADYfZrd7dBgk334gtoW
         tOPA==
X-Gm-Message-State: AHQUAuYpF11wYJtx2JCCUlmOCO/ZUOTX+k+YFg+8ou8osq4WnrlcsYJm
        3+9ST1rcipDqAcXUYJNRVcx6Bw==
X-Google-Smtp-Source: AHgI3IauWVHFbjXrqfyY9RnkQHwJtNGWDzJPMocksY6i+4RHJvRwBXB/bnMWQoV6uU50OlxdP7pBAg==
X-Received: by 2002:ac2:5542:: with SMTP id l2mr6574223lfk.108.1550953178019;
        Sat, 23 Feb 2019 12:19:38 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.83.184])
        by smtp.gmail.com with ESMTPSA id h3sm1647428lfj.25.2019.02.23.12.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 12:19:36 -0800 (PST)
Subject: Re: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
To:     "Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>)" 
        <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        tudor.ambarus@microchip.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-4-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <42d0fd7b-42e0-605c-70ee-6e308908fc90@cogentembedded.com>
Date:   Sat, 23 Feb 2019 23:19:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-4-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:

> Cypress HyperBus is Low Signal Count, High Performance Double Data Rate Bus
> interface between a host system master and one or more slave interfaces.
> HyperBus is used to connect microprocessor, microcontroller, or ASIC
> devices with random access NOR flash memory(called HyperFlash) or

  Need space before (.

> self refresh DRAM(called HyperRAM).
> 
> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
> signal and either Single-ended clock(3.0V parts) or Differential clock
> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
> At bus level, it follows a separate protocol described in HyperBus
> specification[1].
> 
> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
> to that of existing parallel NORs. Since Hyperbus is x8 DDR bus,
> its equivalent to x16 parallel NOR flash wrt bits per clk. But Hyperbus
> operates at >166MHz frequencies.
> HyperRAM provides direct random read/write access to flash memory
> array.
> 
> But, Hyperbus memory controllers seem to abstract implementation details
> and expose a simple MMIO interface to access connected flash.
> 
> Add support for registering HyperFlash devices with MTD framework. MTD
> maps framework along with CFI chip support framework are used to support
> communicate with flash.

   Communicating.

> Framework is modelled along the lines of spi-nor framework. HyperBus
> memory controller(HBMC) drivers call hb_register_device() to register a

   Again, space needed before (.

> single HyperFlash device. HyperFlash core parses MMIO access
> information from DT, sets up the map_info struct, probes CFI flash and
> registers it with MTD framework.
> 
> Some HBMC masters need calibration/training sequence[3] to be carried
> out, in order for DLL inside the controller to lock, by reading a known
> string/pattern. This is done by repeatedly reading CFI Query
> Identification String. Calibration needs to be done before try to detect

   Trying.

> flash as part of CFI flash probe.
> 
> HyperRAM is not supported atm.

   ATM?

> HyperBus specification can be found at[1]
> HyperFlash datasheet can be found at[2]
> 
> [1] https://www.cypress.com/file/213356/download
> [2] https://www.cypress.com/file/213346/download
> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>     Table 12-5741. HyperFlash Access Sequence
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
[...]
> diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
> new file mode 100644
> index 000000000000..02c38afc5c50
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/Kconfig
> @@ -0,0 +1,23 @@
> +menuconfig MTD_HYPERBUS
> +	tristate "Hyperbus support"
> +	select MTD_CFI
> +	select MTD_MAP_BANK_WIDTH_2
> +	select MTD_CFI_AMDSTD
> +	select MTD_COMPLEX_MAPPINGS
> +	help
> +	  This is the framework for the Hyperbus which can be used by
> +	  the Hyperbus Controller driver to commmunicate with
                                              ^^^
  Too many m's. :-)

> +	  Hyperflash. See Cypress Hyperbus specification for more
> +	  details
> +
> +
> +if MTD_HYPERBUS
> +
> +config HBMC_AM654
> +	tristate "Hyperbus controller driver for AM65x SoC"
> +	help
> +	 This is the driver for Hyperbus controller on TI's AM65x and
> +	 other SoCs
> +
> +endif # MTD_HYPERBUS

  The above clearly belongs to patch #5.

> +

   No empty lines at end of file, please...

> diff --git a/drivers/mtd/hyperbus/Makefile b/drivers/mtd/hyperbus/Makefile
> new file mode 100644
> index 000000000000..64e377d7f636
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_MTD_HYPERBUS)	+= core.o
> +obj-$(CONFIG_HBMC_AM654)	+= hbmc_am654.o

   The above line clearly belongs to patch #5 as well...

> diff --git a/drivers/mtd/hyperbus/core.c b/drivers/mtd/hyperbus/core.c
> new file mode 100644
> index 000000000000..d3d44aab7503
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/core.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +// Author: Vignesh R <vigneshr@ti.com>
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/hyperbus.h>
> +#include <linux/mtd/map.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/cfi.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/types.h>
> +
> +#define HB_CALIB_COUNT 25

   Isn't this controller specific?

[...]
> +/* Calibrate HBMC by repeatedly reading "QRY" string from CFI space */
> +static int hb_calibrate(struct hb_device *hbdev)

   s/int/bool/, perhaps?

[...]
> +int hb_register_device(struct hb_device *hbdev)
> +{
> +	struct resource res;
> +	struct device *dev;
> +	struct device_node *np;
> +	struct map_info *map;
> +	struct hb_ops *ops;
> +	int err;
> +
> +	if (!hbdev || !hbdev->dev || !hbdev->np) {
> +		pr_err("hyperbus: please fill all the necessary fields!\n");
> +		return -EINVAL;
> +	}
> +
> +	np = hbdev->np;
> +	if (!of_device_is_compatible(np, "cypress,hyperflash"))
> +		return -ENODEV;
> +
> +	hbdev->memtype = HYPERFLASH;
> +
> +	if (of_address_to_resource(np, 0, &res))

    Isn't the direct mapping property of the HF controller, not of HyperFlash
itself?

> +		return -EINVAL;
> +
> +	dev = hbdev->dev;
> +	map = &hbdev->map;
> +	map->size = resource_size(&res);
> +	map->virt = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(map->virt))
> +		return PTR_ERR(map->virt);
> +
> +	map->name = dev_name(dev);
> +	map->bankwidth = 2;
> +
> +	simple_map_init(map);

   It's not that simple, I'm afraid -- e.g. Renesas RPC-IF has read and write
mappings in the separate memory resources.

[...]
> +	if (hbdev->needs_calib) {
> +		err = hb_calibrate(hbdev);
> +		if (!err) {

   Why call this variable 'err' when it indicates successful calibration?

> +			dev_err(hbdev->dev, "Calibration failed\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	hbdev->mtd = do_map_probe("cfi_probe", map);
> +	if (!hbdev->mtd) {
> +		dev_err(hbdev->dev, "probing failed\n");

   "map probe", perhaps?

> +		return -ENXIO;
> +	}
> +
> +	hbdev->mtd->dev.parent = hbdev->dev;
> +	mtd_set_of_node(hbdev->mtd, np);
> +
> +	err = mtd_device_register(hbdev->mtd, NULL, 0);
> +	if (err) {
> +		dev_err(hbdev->dev, "failed to register mtd device\n");
> +		goto err_destroy;
> +	}
> +	hbdev->registered = true;
> +
> +	return 0;
> +
> +err_destroy:

   The label and the code below doesn't seem necessary. Just do it above
instead of *goto*.

> +	map_destroy(hbdev->mtd);
> +	return err;
> +}
[...]
> diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
> new file mode 100644
> index 000000000000..0aa11458c424
> --- /dev/null
> +++ b/include/linux/mtd/hyperbus.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#ifndef __LINUX_MTD_HYPERBUS_H__
> +#define __LINUX_MTD_HYPERBUS_H__
> +
> +#include <linux/mtd/map.h>
> +
> +enum hb_memtype {

   I'm for the full hyperbus_ prefixes, it's not that long and seems clearer.

[...]

MBR, Sergei

