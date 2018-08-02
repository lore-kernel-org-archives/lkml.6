Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2809EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7B5214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q+IG4iJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7B5214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbeHBPT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:19:27 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33330 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387421AbeHBPT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:19:26 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w72DS7Nc059531;
        Thu, 2 Aug 2018 08:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533216487;
        bh=463x6UlpPpvwkyw2a+6Un0+KiEp+Qk2r4wW8BIjbO18=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q+IG4iJtakSVPBKDNspg2r0xYBYR6vcwI8yEfMzk9yVUTq2K9aazN492qUC/uzgqz
         9bf5Ui92QgFysI0ataSIqxzfhCXV8QsVgWlO9vAtpEe0nSdGpxWus4c7NIMcDpdGnz
         4nkWqeWjSwu4tjHT59PDeyXWHHmdTtrLXkGpfqh4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w72DS7h5013207;
        Thu, 2 Aug 2018 08:28:07 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 2 Aug
 2018 08:28:06 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 2 Aug 2018 08:28:06 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w72DS4t1015960;
        Thu, 2 Aug 2018 08:28:04 -0500
Subject: Re: [PATCH 04/31] usb: usbssp: Added USBSSP platform driver
To:     Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
 <1532023084-28083-5-git-send-email-pawell@cadence.com>
 <540d372b-700c-c25c-98e0-70e1c24742e8@ti.com>
 <BYAPR07MB47097C3C0562BE7EA761EAF5DD2C0@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <488f7650-94b0-68fb-78c3-363b97947a8c@ti.com>
Date:   Thu, 2 Aug 2018 16:28:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB47097C3C0562BE7EA761EAF5DD2C0@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/18 09:25, Pawel Laszczak wrote:
>>> This patch adds platform driver that is entry point for loading and
>>> unloading usbssp.ko modules.
>>> It also adds information about this driver to drivers/usb/Kconfig and
>>> drivers/usb/Makefile files and create Kconfig and Makefile files in
>>> drivers/usb/usbssp directory.
>>>
>>> Patch also adds template for some function ivokked from
>>
>> s/ivokked/invoked
>>
>>> usbssp_plat.c file. These function will be implemented in next patches.
>>>
>>> This patch also introduce usbssp_trb_virt_to_dma that converts virtual
>>> address of TRB's to DMA address. In this moment this function is used
>>> only in gadget-trace.h.
>>
>> s/"In this moment"/"At the moment"
>>
>>>
>>> From this moment the driver can be compiled.
>>>
>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>> ---
>>>  drivers/usb/Kconfig              |   2 +
>>>  drivers/usb/Makefile             |   2 +
>>>  drivers/usb/usbssp/Kconfig       |  21 ++++
>>>  drivers/usb/usbssp/Makefile      |  11 ++
>>>  drivers/usb/usbssp/gadget-ring.c |  48 ++++++++
>>>  drivers/usb/usbssp/gadget.c      |  64 +++++++++++
>>>  drivers/usb/usbssp/gadget.h      |  16 ++-
>>>  drivers/usb/usbssp/usbssp-plat.c | 186
>>> +++++++++++++++++++++++++++++++
>>>  8 files changed, 349 insertions(+), 1 deletion(-)  create mode 100644
>>> drivers/usb/usbssp/Kconfig  create mode 100644
>>> drivers/usb/usbssp/Makefile  create mode 100644
>>> drivers/usb/usbssp/gadget-ring.c  create mode 100644
>>> drivers/usb/usbssp/gadget.c  create mode 100644
>>> drivers/usb/usbssp/usbssp-plat.c
>>>
>>
>> Build fails at this patch with error [1]. Building should never fail at any patch
>> in the series.
>>
> Yes it's true. There is a lack of #include <linux/irq.h> in drivers/usb/usbssp/gadget.h.
> 
> The compilation works correct starting from "0007-usb-usbssp-Initialization-added-usbssp_mem_init.patch"
> Between 0004 and 0007 there is a problem in drivers/usb/usbssp/Makefile  (lack of "\").
> 
> Should I prepare a new series or I should wait for other comments ? 

I think you should wait. I haven't reviewed the other patches yet.

> 
>>
>>> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig index
>>> f699abab1787..dc05f384c34c 100644
>>> --- a/drivers/usb/Kconfig
>>> +++ b/drivers/usb/Kconfig
>>> @@ -110,6 +110,8 @@ source "drivers/usb/mtu3/Kconfig"
>>>
>>>  source "drivers/usb/musb/Kconfig"
>>>
>>> +source "drivers/usb/usbssp/Kconfig"
>>> +
>>>  source "drivers/usb/dwc3/Kconfig"
>>>
>>>  source "drivers/usb/dwc2/Kconfig"
>>> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile index
>>> 060643a1b5c8..b1cd5f83d440 100644
>>> --- a/drivers/usb/Makefile
>>> +++ b/drivers/usb/Makefile
>>> @@ -8,6 +8,8 @@
>>>  obj-$(CONFIG_USB)		+= core/
>>>  obj-$(CONFIG_USB_SUPPORT)	+= phy/
>>>
>>> +obj-$(CONFIG_USB_USBSSP)	+= usbssp/
>>> +
>>>  obj-$(CONFIG_USB_DWC3)		+= dwc3/
>>>  obj-$(CONFIG_USB_DWC2)		+= dwc2/
>>>  obj-$(CONFIG_USB_ISP1760)	+= isp1760/
>>> diff --git a/drivers/usb/usbssp/Kconfig b/drivers/usb/usbssp/Kconfig
>>> new file mode 100644 index 000000000000..ee20b01753dc
>>> --- /dev/null
>>> +++ b/drivers/usb/usbssp/Kconfig
>>> @@ -0,0 +1,21 @@
>>> +config USB_USBSSP
>>
>> Do you want to choose a better Kconfig symbol name? USB is repeated twice
>> in USB_USBSSP.
>>
>> I'd recommend to add something signifying Cadence in the symbol
>>
>> some examples
>>
>> USB_CADSSP, USB_CSSP
> 
> Ok, I will change this to USB_CSSP
> 
>>> +	tristate "Cadence USBSSP DRD Controller"
>>> +	depends on (USB || USB_GADGET) && HAS_DMA
>>> +	select USB_USBSSP_GADGET
>>
>> Not good to select a symbol that has dependencies.
>>
>>> +	help
>>> +	  Say Y here if your system has a cadence USBSSP dual-role
>> controller.
>>> +	  It supports: dual-role switch Host-only, and Peripheral-only.
>>> +
>>> +	  If you choose to build this driver is a dynamically linked
>>> +	  module, the module will be called usbssp.ko.
>>> +
>>> +if USB_USBSSP
>>> +
>>> +config USB_USBSSP_GADGET
>>> +	tristate "Gadget only mode"
>>> +	default USB_USBSSP
>>> +	depends on USB_GADGET=y || USB_GADGET=USB_USBSSP
>>> +	help
>>> +	  Select this when you want to use USBSSP in gadget mode only,
>>
>> s/,/.
>>
>>> +endif
>>> +
>>> diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
>>> new file mode 100644 index 000000000000..d85f15afb51c
>>> --- /dev/null
>>> +++ b/drivers/usb/usbssp/Makefile
>>> @@ -0,0 +1,11 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# define_trace.h needs to know how to find our header
>>> +CFLAGS_gadget-trace.o := -I$(src)
>>> +
>>> +obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
>>> +usbssp-y 			:= usbssp-plat.o gadget-ring.o \
>>> +				   gadget.o
>>> +
>>> +ifneq ($(CONFIG_TRACING),)
>>> +	usbssp-y		+= gadget-trace.o
>>> +endif
>>> diff --git a/drivers/usb/usbssp/gadget-ring.c
>>> b/drivers/usb/usbssp/gadget-ring.c
>>> new file mode 100644
>>> index 000000000000..d1da59306d02
>>> --- /dev/null
>>> +++ b/drivers/usb/usbssp/gadget-ring.c
>>> @@ -0,0 +1,48 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * USBSSP device controller driver
>>> + *
>>> + * Copyright (C) 2018 Cadence.
>>> + *
>>> + * Author: Pawel Laszczak
>>> + *
>>> + * A lot of code based on Linux XHCI driver.
>>> + * Origin: Copyright (C) 2008 Intel Corp  */
>>> +
>>> +#include <linux/scatterlist.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/dma-mapping.h>
>>> +#include <linux/irq.h>
>>> +#include "gadget-trace.h"
>>> +#include "gadget.h"
>>> +
>>> +/*
>>> + * Returns zero if the TRB isn't in this segment, otherwise it
>>> +returns the DMA
>>> + * address of the TRB.
>>> + */
>>> +dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
>>> +				  union usbssp_trb *trb)
>>> +{
>>> +	unsigned long segment_offset;
>>> +
>>> +	if (!seg || !trb || trb < seg->trbs)
>>> +		return 0;
>>> +	/* offset in TRBs */
>>> +	segment_offset = trb - seg->trbs;
>>> +	if (segment_offset >= TRBS_PER_SEGMENT)
>>> +		return 0;
>>> +	return seg->dma + (segment_offset * sizeof(*trb)); }
>>> +
>>> +irqreturn_t usbssp_irq(int irq, void *priv) {
>>> +	struct usbssp_udc *usbssp_data = (struct usbssp_udc *)priv;
>>> +	irqreturn_t ret = IRQ_NONE;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&usbssp_data->lock, flags);
>>> +
>>> +	spin_unlock_irqrestore(&usbssp_data->lock, flags);
>>> +	return ret;
>>> +}
>>> diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
>>> new file mode 100644 index 000000000000..2f60d7dd1fe4
>>> --- /dev/null
>>> +++ b/drivers/usb/usbssp/gadget.c
>>> @@ -0,0 +1,64 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * USBSSP device controller driver
>>> + *
>>> + * Copyright (C) 2018 Cadence.
>>> + *
>>> + * Author: Pawel Laszczak
>>> + *
>>> + * A lot of code based on Linux XHCI driver.
>>> + * Origin: Copyright (C) 2008 Intel Corp  */
>>> +
>>> +#include <linux/pci.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/log2.h>
>>> +#include <linux/module.h>
>>> +#include <linux/moduleparam.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/dmi.h>
>>> +#include <linux/dma-mapping.h>
>>> +#include <linux/delay.h>
>>> +
>>> +#include "gadget-trace.h"
>>> +#include "gadget.h"
>>> +
>>> +#ifdef CONFIG_PM
>>> +/*
>>> + * Stop DC (not bus-specific)
>>> + *
>>> + * This is called when the machine transition into S3/S4 mode.
>>> + *
>>> + */
>>> +int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup) {
>>> +	/*TODO*/
>>> +	return -ENOSYS;
>>> +}
>>> +
>>> +/*
>>> + * start DC (not bus-specific)
>>> + *
>>> + * This is called when the machine transition from S3/S4 mode.
>>> + *
>>> + */
>>> +int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated) {
>>> +	/*TODO*/
>>> +	return -ENOSYS;
>>> +}
>>> +
>>> +#endif	/* CONFIG_PM */
>>> +
>>> +int usbssp_gadget_init(struct usbssp_udc *usbssp_data) {
>>> +	int ret;
>>> +	return ret;
>> ret is not initialized before returning.
>> Maybe just
>> return 0;
> I left this compiler warning because the next patches will add implementation of this function and then warning disappear. 
> I trayed to prepare this series of patches in a way to avoid deletion line in next patches in series. 
> 

It is perfectly fine to delete things in a patch. But compiler warnings shouldn't be there.

>>> +}
>>> +
>>> +int usbssp_gadget_exit(struct usbssp_udc *usbssp_data) {
>>> +	int ret = 0;
>>> +
>>> +	return ret;
>>
>> return 0;
>>
>>> +}
>>> diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
>>> index b5c17603af78..55e20795d900 100644
>>> --- a/drivers/usb/usbssp/gadget.h
>>> +++ b/drivers/usb/usbssp/gadget.h
>>> @@ -9,7 +9,6 @@
>>>   * A lot of code based on Linux XHCI driver.
>>>   * Origin: Copyright (C) 2008 Intel Corp.
>>>   */
>>> -
>>
>> unnecessary blank line removal
>>
>>>  #ifndef __LINUX_USBSSP_GADGET_H
>>>  #define __LINUX_USBSSP_GADGET_H
>>>
>>> @@ -1676,6 +1675,21 @@ static inline void usbssp_write_64(struct
>>> usbssp_udc *usbssp_data,  {
>>>  	lo_hi_writeq(val, regs);
>>>  }
>>> +
>>> +/* USBSSP Device controller glue */
>>> +int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
>>> +int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated);
>>> +
>>> +irqreturn_t usbssp_irq(int irq, void *priv);
>>> +
>>> +/* USBSSP ring, segment, TRB, and TD functions */ dma_addr_t
>>> +usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
>>> +				union usbssp_trb *trb);
>>> +
>>> +/* USBSSP gadget interface*/
>>> +int usbssp_gadget_init(struct usbssp_udc *usbssp_data); int
>>> +usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
>>> +
>>>  static inline char *usbssp_slot_state_string(u32 state)  {
>>>  	switch (state) {
>>> diff --git a/drivers/usb/usbssp/usbssp-plat.c
>>> b/drivers/usb/usbssp/usbssp-plat.c
>>
>> Is this file meant only for gadget controller or later even for host controller?
>> If only for gadget then this could be just called gadget-plat.c
> 
> I'm not sure at this moment. I have not wondered  at now how this driver will 
> be integrated with XHCI driver and DRD driver.
>  

OK.
> 
>>> new file mode 100644
>>> index 000000000000..c048044148aa
>>> --- /dev/null
>>> +++ b/drivers/usb/usbssp/usbssp-plat.c
>>> @@ -0,0 +1,186 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * USBSSP device controller driver
>>> + *
>>> + * Copyright (C) 2018 Cadence.
>>> + *
>>> + * Author: Pawel Laszczak
>>> + *
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/dma-mapping.h>
>>> +#include <linux/module.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/usb/phy.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/acpi.h>
>>> +
>>> +#include "gadget.h"
>>> +
>>> +#define DRIVER_AUTHOR "Pawel Laszczak"
>>> +#define DRIVER_DESC "USBSSP Device Controller (USBSSP) Driver"
>>> +
>>> +#ifdef CONFIG_OF
>>> +
>>> +static const struct of_device_id usbssp_dev_of_match[] = {
>>> +	{
>>> +		.compatible = "Cadence, usbssp-dev",
>>
>> Avoid upper-case in compatible strings.
>>
>>> +	},
>>> +	{},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, usbssp_dev_of_match); #endif
>>> +
>>> +int usbssp_is_platform(void)
>>> +{
>>> +	return 1;
>>> +}
>>> +
>>> +static int usbssp_plat_probe(struct platform_device *pdev) {
>>> +	struct device *dev = &pdev->dev;
>>> +	struct resource *res;
>>> +	struct usbssp_udc *usbssp_data;
>>> +	int ret = 0;
>>> +	int irq;
>>> +	struct device *sysdev;
>>> +
>>> +	irq = platform_get_irq(pdev, 0);
>>> +	if (irq < 0) {
>>> +		dev_err(&pdev->dev, "Incorrect IRQ number\n");
>>
>> IRQ number might be correct but might be some other issue.
>> You could just say "couldn't get IRQ"
>>
>>> +		return -ENODEV;
>>
>> Also, we don't want to print any error message if we got a -EPROBE_DEFER.
>> And we need to return that instead of -ENODEV for deferred probing to
>> work.
>>
>>> +	}
>>
>> So how about
>> 	if (irq < 0) {
>> 		if (irq != -EPROBE_DEFER)
>> 			dev_err(&pdev->dev, "couldn't get IRQ\n")
>>
>> 		return irq;
>> 	}
>>
>>> +
>>> +	usbssp_data = devm_kzalloc(dev, sizeof(*usbssp_data),
>> GFP_KERNEL);
>>> +	if (!usbssp_data)
>>> +		return -ENOMEM;
>>> +
>>> +	for (sysdev = &pdev->dev; sysdev; sysdev = sysdev->parent) {
>>> +		if (is_of_node(sysdev->fwnode) ||
>>> +		    is_acpi_device_node(sysdev->fwnode))
>>> +			break;
>>> +#ifdef CONFIG_PCI
>>> +		else if (sysdev->bus == &pci_bus_type)
>>> +			break;
>>> +#endif
>>> +	}
>>
>> It is hard to understand what is this for loop doing exactly.
>>
>> xhci-plat.c seems to have this comment. You should add it above as well.
>>         /*
>>          * sysdev must point to a device that is known to the system firmware
>>          * or PCI hardware. We handle these three cases here:
>>          * 1. xhci_plat comes from firmware
>>          * 2. xhci_plat is child of a device from firmware (dwc3-plat)
>>          * 3. xhci_plat is grandchild of a pci device (dwc3-pci)
>>          */
>>
>>
>>> +
>>> +	if (!sysdev)
>>> +		sysdev = &pdev->dev;
>>> +
>>> +	/* Try to set 64-bit DMA first */
>>> +	if (WARN_ON(!dev->dma_mask))
>>> +		/* Platform did not initialize dma_mask */
>>> +		ret = dma_coerce_mask_and_coherent(dev,
>>> +				DMA_BIT_MASK(64));
>>> +	else
>>> +		ret = dma_set_mask_and_coherent(dev,
>> DMA_BIT_MASK(64));
>>> +
>>> +	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
>>> +	if (ret) {
>>> +		ret = dma_set_mask_and_coherent(dev,
>> DMA_BIT_MASK(32));
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	usbssp_data->regs = devm_ioremap_resource(dev, res);
>>> +
>>> +	if (IS_ERR(usbssp_data->regs)) {
>> dev_err() ?
>>
>>> +		ret = PTR_ERR(usbssp_data->regs);
>>> +		return ret;
>>> +	}
>>> +
>>> +	usbssp_data->rsrc_start = res->start;
>>> +	usbssp_data->rsrc_len = resource_size(res);
>>> +
>>> +	ret = devm_request_irq(dev, irq, usbssp_irq, IRQF_SHARED,
>>> +			dev_name(dev), usbssp_data);
>>
>> devm_request_threaded_irq() ?
> Currently for deferred interrupts I use workqueue thread. Some time ago I tried use this function
> but I have some problem with it. I have plan to replace devm_request_irq with devm_request_threaded_irq. 
> 
> In USBSSP controller for device side I have big problem with handling commands.  Handling command works like 
> in XHCI controller. After invoking command driver has to wait for completion so it should sleep for some time. 
> During waiting (e.g wait_for_completion) we need to enable the interrupts because we need to detect the completion event. Additionally some API  function from USBSSP gadget driver are invoked by upper layer with disabled interrupts. 
> In this situation we can't enable interrupt before invoking command and driver has to detect completion in other way.
> The concept taken from the host is not a perfect for device driver where most driver should works in interrupt context, 
> 

Felipe? any ideas here?

>>> +
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	usbssp_data->irq = irq;
>>> +	usbssp_data->dev = dev;
>>> +	platform_set_drvdata(pdev, usbssp_data);
>>> +	ret = usbssp_gadget_init(usbssp_data);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int usbssp_plat_remove(struct platform_device *pdev) {
>>> +	int ret = 0;
>>> +	struct usbssp_udc *usbssp_data;
>>> +
>>> +	usbssp_data = (struct usbssp_udc *)platform_get_drvdata(pdev);
>>> +	ret = usbssp_gadget_exit(usbssp_data);
>>> +	return ret;
>>> +
>>
>> move this blank line above return ret;
>>> +}
>>> +
>>> +static int __maybe_unused usbssp_plat_suspend(struct device *dev) {
>>> +	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
>>> +
>>> +	return usbssp_suspend(usbssp_data, device_may_wakeup(dev)); }
>>> +
>>> +static int __maybe_unused usbssp_plat_resume(struct device *dev) {
>>> +	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
>>> +
>>> +	return usbssp_resume(usbssp_data, 0); }
>>> +
>>> +static int __maybe_unused usbssp_plat_runtime_suspend(struct device
>>> +*dev) {
>>> +	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
>>> +
>>> +	return usbssp_suspend(usbssp_data, true); }
>>> +
>>> +static int __maybe_unused usbssp_plat_runtime_resume(struct device
>>> +*dev) {
>>> +	struct usbssp_udc *usbssp_data = dev_get_drvdata(dev);
>>> +
>>> +	return usbssp_resume(usbssp_data, 0); }
>>> +
>>> +static const struct dev_pm_ops usbssp_plat_pm_ops = {
>>> +	SET_SYSTEM_SLEEP_PM_OPS(usbssp_plat_suspend,
>> usbssp_plat_resume)
>>> +
>>> +	SET_RUNTIME_PM_OPS(usbssp_plat_runtime_suspend,
>>> +			usbssp_plat_runtime_resume,
>>> +			NULL)
>>> +};
>>> +
>>> +static struct platform_driver usbssp_driver = {
>>> +	.probe	= usbssp_plat_probe,
>>> +	.remove	= usbssp_plat_remove,
>>> +	.driver	= {
>>> +		.name = "usbssp-dev",
>>> +		.pm = &usbssp_plat_pm_ops,
>>> +		.of_match_table = of_match_ptr(usbssp_dev_of_match),
>>> +	},
>>> +};
>>> +
>>> +static int __init usbssp_plat_init(void) {
>>> +	return platform_driver_register(&usbssp_driver);
>>> +}
>>> +module_init(usbssp_plat_init);
>>> +
>>> +static void __exit usbssp_plat_exit(void) {
>>> +	platform_driver_unregister(&usbssp_driver);
>>> +}
>>> +module_exit(usbssp_plat_exit);
>>> +
>>> +MODULE_ALIAS("platform:usbss-gadget");
>> usbssp-gadget?
>>
>> Why did you choose a different name for compatible? "usbssp-dev"
>> Would be nice to have it consistent.
>>
>>> +MODULE_DESCRIPTION("USBSSP' Device Controller (USBSSP) Driver");
>>
>> USBSSP, 2 times?
>>
>>> +MODULE_LICENSE("GPL v2");
>>>
> I will correct this. 
>>
>> [1] build error
>>
>>   CC [M]  drivers/usb/usbssp/gadget-trace.o In file included from
>> drivers/usb/usbssp/gadget-trace.h:27:0,
>>                  from drivers/usb/usbssp/gadget-trace.c:13:
>> drivers/usb/usbssp/gadget.h:1683:1: error: unknown type name
>> ‘irqreturn_t’
>>  irqreturn_t usbssp_irq(int irq, void *priv);  ^~~~~~~~~~~ In file included from
>> ./include/trace/trace_events.h:394:0,
>>                  from ./include/trace/define_trace.h:96,
>>                  from drivers/usb/usbssp/gadget-trace.h:482,
>>                  from drivers/usb/usbssp/gadget-trace.c:13:
>> drivers/usb/usbssp/./gadget-trace.h: In function
>> ‘trace_raw_output_usbssp_log_request’:
>> drivers/usb/usbssp/./gadget-trace.h:201:477: warning: format ‘%llx’ expects
>> argument of type ‘long long unsigned int’, but argument 6 has type
>> ‘dma_addr_t {aka unsigned int}’ [-Wformat=]
>> DECLARE_EVENT_CLASS(usbssp_log_request,
>>
>> ^
>> scripts/Makefile.build:317: recipe for target 'drivers/usb/usbssp/gadget-
>> trace.o' failed
>> make[3]: *** [drivers/usb/usbssp/gadget-trace.o] Error 1
>> scripts/Makefile.build:558: recipe for target 'drivers/usb/usbssp' failed
>> make[2]: *** [drivers/usb/usbssp] Error 2
>> scripts/Makefile.build:558: recipe for target 'drivers/usb' failed
>> make[1]: *** [drivers/usb] Error 2
>> Makefile:1029: recipe for target 'drivers' failed
>> make: *** [drivers] Error 2
>>
>> --
> cheers,
> Pawel
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
