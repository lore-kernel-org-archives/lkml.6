Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FC4ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8804121526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/vb7AnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8804121526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeJQW6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbeJQW6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:58:42 -0400
Received: from [192.168.1.16] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE04D2150F;
        Wed, 17 Oct 2018 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539788556;
        bh=mk/EnutWj9y5GAoMaGwwnbaCM37ULNsNU2wSg49Fjfw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d/vb7AnUGoX1dPtoxTC4acZFI1TVFSpinIJJOl1HO1ranqh7asIoXxcQfLe7+ajI8
         hZ7eBKv2X7TV4H7U/0KmoDXobytYm/QoYDim6vny1NkFw7RqV6CdvGQrIjZhvl2eoy
         vTG3vB0Vx1cWsJCWtL0j2Vfw6G/umH24mtr936LA=
Subject: Re: [PATCHv2] reset: socfpga: add an early reset driver for SoCFPGA
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, marex@denx.de
References: <20181011135241.13614-1-dinguyen@kernel.org>
 <1539787061.4729.11.camel@pengutronix.de>
From:   Dinh Nguyen <dinguyen@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5944ac0a-ba43-43fa-9985-c84644023ae8@kernel.org>
Date:   Wed, 17 Oct 2018 10:02:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539787061.4729.11.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp

On 10/17/2018 09:37 AM, Philipp Zabel wrote:
> Hi Dinh,
> 
> On Thu, 2018-10-11 at 08:52 -0500, Dinh Nguyen wrote:
>> Create a separate reset driver that uses the reset operations in
>> reset-simple. The reset driver for the SoCFPGA platform needs to
>> register early in order to be able bring online timers that needed
>> early in the kernel bootup.
>>
>> We do not need this early reset driver for Stratix10, because on
>> arm64, Linux does not need the timers are that in reset. Linux is
>> able to run just fine with the internal armv8 timer.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>> v2: Do not build separate reset driver for STRATIX10
>>     fix warning: symbol 'socfpga_reset_init' was not declared. Should
>>     it be static?
>> ---
>>  arch/arm/mach-socfpga/socfpga.c |  4 ++
>>  drivers/reset/Kconfig           |  9 +++-
>>  drivers/reset/Makefile          |  1 +
>>  drivers/reset/reset-socfpga.c   | 88 +++++++++++++++++++++++++++++++++
>>  4 files changed, 101 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/reset/reset-socfpga.c
>>
>> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
>> index dde14f7bf2c3..cc64576c102b 100644
>> --- a/arch/arm/mach-socfpga/socfpga.c
>> +++ b/arch/arm/mach-socfpga/socfpga.c
>> @@ -32,6 +32,8 @@ void __iomem *rst_manager_base_addr;
>>  void __iomem *sdr_ctl_base_addr;
>>  unsigned long socfpga_cpu1start_addr;
>>  
>> +extern void __init socfpga_reset_init(void);
>> +
>>  void __init socfpga_sysmgr_init(void)
>>  {
>>  	struct device_node *np;
>> @@ -64,6 +66,7 @@ static void __init socfpga_init_irq(void)
>>  
>>  	if (IS_ENABLED(CONFIG_EDAC_ALTERA_OCRAM))
>>  		socfpga_init_ocram_ecc();
>> +	socfpga_reset_init();
>>  }
>>  
>>  static void __init socfpga_arria10_init_irq(void)
>> @@ -74,6 +77,7 @@ static void __init socfpga_arria10_init_irq(void)
>>  		socfpga_init_arria10_l2_ecc();
>>  	if (IS_ENABLED(CONFIG_EDAC_ALTERA_OCRAM))
>>  		socfpga_init_arria10_ocram_ecc();
>> +	socfpga_reset_init();
>>  }
>>  
>>  static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 13d28fdbdbb5..f10de5ce4753 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -100,7 +100,7 @@ config RESET_QCOM_AOSS
>>  
>>  config RESET_SIMPLE
>>  	bool "Simple Reset Controller Driver" if COMPILE_TEST
>> -	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
>> +	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
>>  	help
>>  	  This enables a simple reset controller driver for reset lines that
>>  	  that can be asserted and deasserted by toggling bits in a contiguous,
>> @@ -119,6 +119,13 @@ config RESET_STM32MP157
>>  	help
>>  	  This enables the RCC reset controller driver for STM32 MPUs.
>>  
>> +config RESET_SOCFPGA
>> +	bool "SoCFPGA Reset Driver" if COMPILE_TEST && !ARCH_SOCFPGA
>> +	default ARCH_SOCFPGA && !ARCH_STRATIX10
>> +	select RESET_SIMPLE
>> +	help
>> +	  This enables the reset driver for SoCFPGA.
>> +
>>  config RESET_SUNXI
>>  	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
>>  	default ARCH_SUNXI
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 4243c38228e2..d09bb41273f6 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
>>  obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
>>  obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
>>  obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
>> +obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
>>  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>>  obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>>  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
>> diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
>> new file mode 100644
>> index 000000000000..b92769861d2b
>> --- /dev/null
>> +++ b/drivers/reset/reset-socfpga.c
>> @@ -0,0 +1,88 @@
>> +// SPDX-License-Identifier:	GPL-2.0
>> +/*
>> + * Copyright (C) 2018, Intel Corporation
>> + * Copied from reset-sunxi.c
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/init.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/types.h>
>> +
>> +#include "reset-simple.h"
>> +
>> +#define SOCFPGA_NR_BANKS	8
>> +void __init socfpga_reset_init(void);
>> +
>> +static int a10_reset_init(struct device_node *np)
>> +{
>> +	struct reset_simple_data *data;
>> +	struct resource res;
>> +	resource_size_t size;
>> +	int ret;
>> +	u32 reg_offset = 0x10;
>> +
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	ret = of_address_to_resource(np, 0, &res);
>> +	if (ret)
>> +		goto err_alloc;
>> +
>> +	size = resource_size(&res);
>> +	if (!request_mem_region(res.start, size, np->name)) {
>> +		ret = -EBUSY;
>> +		goto err_alloc;
>> +	}
>> +
>> +	data->membase = ioremap(res.start, size);
>> +	if (!data->membase) {
>> +		ret = -ENOMEM;
>> +		goto err_alloc;
>> +	}
>> +
>> +	if (of_property_read_u32(np, "altr,modrst-offset", &reg_offset))
>> +		pr_warn("missing altr,modrst-offset property, assuming 0x10\n");
>> +	data->membase += reg_offset;
>> +
>> +	spin_lock_init(&data->lock);
>> +
>> +	data->rcdev.owner = THIS_MODULE;
>> +	data->rcdev.nr_resets = SOCFPGA_NR_BANKS * 32;
>> +	data->rcdev.ops = &reset_simple_ops;
>> +	data->rcdev.of_node = np;
>> +	data->status_active_low = true;
>> +
>> +	return reset_controller_register(&data->rcdev);
>> +
>> +err_alloc:
>> +	kfree(data);
>> +	return ret;
>> +};
>> +
>> +/*
>> + * These are the reset controller we need to initialize early on in
>> + * our system, before we can even think of using a regular device
>> + * driver for it.
>> + * The controllers that we can register through the regular device
>> + * model are handled by the simple reset driver directly.
>> + */
>> +static const struct of_device_id socfpga_early_reset_dt_ids[] __initconst = {
>> +	{ .compatible = "altr,rst-mgr", },
> 
> That doesn't seem right. If you don't remove the altr,rst-mgr compatible
> from reset-simple.c anymore, we suddenly have two device drivers for the
> same compatible.

You're right, and that's why I am not building reset-simple for
ARCH_SOCFPGA anymore. I am only building reset-simple for ARCH_STRATIX10.

> 
> (Also I liked removing altr,modrst-offset from reset-simple.c)

I can remove it since it's just 0x20 of ARCH_STRATIX10.

> 
> Would there be any issue with calling socfpga_reset_init() on Stratix10
> as well?
> 

I don't see any place in the arm64 common code where I can do this.

Dinh
