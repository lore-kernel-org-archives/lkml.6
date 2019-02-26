Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14DAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00CB217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="pDMJq9rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfBZSQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:16:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40348 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfBZSQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:16:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id w6so11629080ljd.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/UJL3WHB7z/fbFjJ/n643NRlax/UYjmj1twPDxFm7IQ=;
        b=pDMJq9rlTJGNzJbUrAgRadZd1i9JfPUKBkgy/CYT8Btt3EQ4WI3saJGwAnHiA45HB2
         s6QFE9eibnWg3fU07tHAsyDiCbOD3lbu/oZKs0n0QtOFkFcSl2XVlRE8FcG4pZOcb5dU
         edRGBCtUPsGjcW1GiPVP4hfP5+NPdyEubTtOWGxZBnKZOi1Cq18SmN0I1hlokc1Uj1yZ
         6rYRFO7iGaM+Om4otWP/NEW9YB5ovCfY/Y5364Rg+86HvDaA5TYm5XKm4HqaPb/GQpc4
         KujgTF+RhK55SUTgrGvNzdI9T0giWXbM+l89YPxal7/BrJAMfyJy0JWyqZOU6Dd3UWiq
         +ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/UJL3WHB7z/fbFjJ/n643NRlax/UYjmj1twPDxFm7IQ=;
        b=ulW4aF/r7unta/5LAYWwBxOUBhW5nadZ0H6M9gfIAeOuprFvFx9Pen/qnpdK9OCzEX
         0g9yHqzh4o1EwygQf0pa98vcjvDByH5Uu7RUpNrNgPQZmCdeYHjFz8gLhEh5bdKurcvI
         qofRRPjpQOmEbDzY3cYiaXnns1S+KNivSKC9qrdDlWybEYjkjvFZNSnoCsx0TP+3ZtDT
         LLUYLVHcXmTr+FatXcfNUG7INUJjqkJPtJ5u3tLsOVy73Riifh3gIx8d9F6J3vcfGZ6m
         i4EjOkFDrIBc0QP0+PYPCI8vgZU6R+Mo4uO1NxXs7C8GwgUpoSpkjVO9/4YwWuMeDGN7
         Q7xw==
X-Gm-Message-State: AHQUAubfqPR5gVgcxp1ZcOiCrngibsXkaPHmbaA7yKJ8wEIo3yxipqTq
        BpnSXwdWtud83s6nNeVCfvZEfw==
X-Google-Smtp-Source: AHgI3IY9uK5LiCjh9SHSXWq3ui2dEtdmkQ3jUddEDAi8J11Tjlz3dgx8MinroYkkUkeTQCzSZcqZ7A==
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr14481627ljj.30.1551204979431;
        Tue, 26 Feb 2019 10:16:19 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.110])
        by smtp.gmail.com with ESMTPSA id v1sm1025511lfg.13.2019.02.26.10.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:16:18 -0800 (PST)
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
Message-ID: <7e79fff7-2565-28f7-7b2b-bb3098f1a928@cogentembedded.com>
Date:   Tue, 26 Feb 2019 21:16:17 +0300
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

On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:

> Cypress HyperBus is Low Signal Count, High Performance Double Data Rate Bus
> interface between a host system master and one or more slave interfaces.
> HyperBus is used to connect microprocessor, microcontroller, or ASIC
> devices with random access NOR flash memory(called HyperFlash) or
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
> 
> Framework is modelled along the lines of spi-nor framework. HyperBus
> memory controller(HBMC) drivers call hb_register_device() to register a
> single HyperFlash device. HyperFlash core parses MMIO access
> information from DT, sets up the map_info struct, probes CFI flash and
> registers it with MTD framework.
> 
> Some HBMC masters need calibration/training sequence[3] to be carried
> out, in order for DLL inside the controller to lock, by reading a known
> string/pattern. This is done by repeatedly reading CFI Query
> Identification String. Calibration needs to be done before try to detect
> flash as part of CFI flash probe.
> 
> HyperRAM is not supported atm.
> 
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
> +	HYPERFLASH,
> +	HYPERRAM,
> +};
> +
> +/**
> + * struct hb_device - struct representing Hyperbus slave device
> + * @map: map_info struct for accessing MMIO Hyperbus flash memory
> + * @dev: device pointer of Hyperbus Controller

   I think we need a separate structure for the HyperBus controller, not just
for the slave devices...

> + * @np:	pointer to Hyperbus slave device node
> + * @mtd: pointer to MTD struct
> + * @ops: pointer to custom Hyperbus ops
> + * @memtype: type of memory device: Hyperflash or HyperRAM
> + * @needs_calib: flag to indicate whether calibration sequence is needed
> + * @registered: flag to indicate whether device is registered with MTD core
> + */
> +
> +struct hb_device {
> +	struct map_info map;
> +	struct device *dev;
> +	struct device_node *np;
> +	struct mtd_info *mtd;
> +	struct hb_ops *ops;
> +	enum hb_memtype memtype;
> +	bool needs_calib;
> +	bool registered;
> +};
> +
> +/**
> + * struct hb_ops - struct representing custom Hyperbus operations
> + * @read16: read 16 bit of data, usually from register/ID-CFI space
> + * @write16: write 16 bit of data, usually to register/ID-CFI space
> + * copy_from: copy data from flash memory
> + * copy_to: copy data to flash_memory
> + */
> +
> +struct hb_ops {
> +	u16 (*read16)(struct hb_device *hbdev, unsigned long addr);
> +	void (*write16)(struct hb_device *hbdev, unsigned long addr, u16 val);
> +
> +	void (*copy_from)(struct hb_device *hbdev, void *to,
> +			  unsigned long from, ssize_t len);
> +	void (*copy_to)(struct hb_device *dev, unsigned long to,
> +			const void *from, ssize_t len);

   ... else these methods won't fly if you need to "massage" the controller
registers inside them...

> +};
[...]

MBR, Sergei
