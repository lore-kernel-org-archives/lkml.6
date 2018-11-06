Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753D1C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B14F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B14F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbeKFXOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:14:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50310 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbeKFXOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:14:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA6Dmf1W044122;
        Tue, 6 Nov 2018 07:48:41 -0600
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA6DmeHa130563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 07:48:41 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 07:48:40 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 07:48:40 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA6Dmbcb014993;
        Tue, 6 Nov 2018 07:48:38 -0600
Subject: Re: [RFC PATCH v1 01/14] usb:cdns3: add pci to platform driver
 wrapper.
To:     Pawel Laszczak <pawell@cadence.com>, <gregkh@linuxfoundation.org>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
 <1541267487-3664-2-git-send-email-pawell@cadence.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BE19BB5.3030006@ti.com>
Date:   Tue, 6 Nov 2018 15:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1541267487-3664-2-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

On 03/11/18 19:51, Pawel Laszczak wrote:
> Patch adds PCI specific glue drivier that creaties and registers in

s/drivier/driver
s/creaties/creates
s/in system/in-system

> system cdns-usb3 platform device. Thanks to that we will be able to use
> the cdns-usb3 platform driver for USBSS-DEV controller
> build on PCI board
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/Kconfig                |   2 +
>  drivers/usb/Makefile               |   2 +
>  drivers/usb/cdns3/Kconfig          |  24 +++++
>  drivers/usb/cdns3/Makefile         |   3 +
>  drivers/usb/cdns3/cdns3-pci-wrap.c | 162 +++++++++++++++++++++++++++++
>  5 files changed, 193 insertions(+)
>  create mode 100644 drivers/usb/cdns3/Kconfig
>  create mode 100644 drivers/usb/cdns3/Makefile
>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
> 
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 987fc5ba6321..5f9334019d04 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -112,6 +112,8 @@ source "drivers/usb/usbip/Kconfig"
>  
>  endif
>  
> +source "drivers/usb/cdns3/Kconfig"
> +
>  source "drivers/usb/mtu3/Kconfig"
>  
>  source "drivers/usb/musb/Kconfig"
> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
> index 7d1b8c82b208..82093a60ea2c 100644
> --- a/drivers/usb/Makefile
> +++ b/drivers/usb/Makefile
> @@ -8,6 +8,8 @@
>  obj-$(CONFIG_USB)		+= core/
>  obj-$(CONFIG_USB_SUPPORT)	+= phy/
>  
> +obj-$(CONFIG_USB_CDNS3)		+= cdns3/
> +
>  obj-$(CONFIG_USB_DWC3)		+= dwc3/
>  obj-$(CONFIG_USB_DWC2)		+= dwc2/
>  obj-$(CONFIG_USB_ISP1760)	+= isp1760/
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> new file mode 100644
> index 000000000000..888458372adb
> --- /dev/null
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -0,0 +1,24 @@
> +config USB_CDNS3
> +	tristate "Cadence USB3 Dual-Role Controller"
> +	depends on ((USB_XHCI_HCD && USB_GADGET) || (USB_XHCI_HCD && !USB_GADGET) || (!USB_XHCI_HCD && USB_GADGET)) && HAS_DMA

Why not depend on USB instead of USB_XHCI_HCD?

> +	help
> +	  Say Y here if your system has a cadence USB3 dual-role controller.
> +	  It supports: dual-role switch Host-only, and Peripheral-only.

Need a coma between switch and Host-only.

> +
> +	  If you choose to build this driver is a dynamically linked
> +	  module, the module will be called cdns3.ko.
> +
> +if USB_CDNS3
> +
> +config USB_CDNS3_PCI_WRAP
> +	tristate "PCIe-based Platforms"
> +	depends on USB_PCI && ACPI
> +	default USB_CDNS3
> +	help
> +	  If you're using the USBSS Core IP with a PCIe, please say
> +	  'Y' or 'M' here.
> +
> +	  If you choose to build this driver as module it will
> +	  be dynamically linked and module will be called cdns3-pci.ko
> +
> +endif
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> new file mode 100644
> index 000000000000..dcdd62003c6a
> --- /dev/null
> +++ b/drivers/usb/cdns3/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
> +
> +cdns3-pci-y		 		:= cdns3-pci-wrap.o
> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
> new file mode 100644
> index 000000000000..6c229ab6dffb
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS PCI Glue driver
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +
> +struct cdns3_wrap {
> +	struct platform_device *plat_dev;
> +	struct pci_dev *hg_dev;
> +	struct resource dev_res[4];
> +};
> +
> +struct cdns3_wrap wrap;
> +
> +#define RES_IRQ_ID		0
> +#define RES_HOST_ID		1
> +#define RES_DEV_ID		2
> +#define RES_DRD_ID		3
> +
> +#define PCI_BAR_HOST		0
> +#define PCI_BAR_DEV		2
> +#define PCI_BAR_OTG		4
> +
> +#define PCI_DEV_FN_HOST_DEVICE	0
> +#define PCI_DEV_FN_OTG		1
> +
> +#define PCI_DRIVER_NAME		"cdns3-pci-usbss"
> +#define PLAT_DRIVER_NAME	"cdns-usb3"
> +
> +#define CDNS_VENDOR_ID 0x17cd
> +#define CDNS_DEVICE_ID 0x0100
> +
> +/**
> + * cdns3_pci_probe - Probe function for Cadence USB wrapper driver
> + * @pdev: platform device object
> + * @id: pci device id
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_pci_probe(struct pci_dev *pdev,
> +			   const struct pci_device_id *id)
> +{
> +	struct platform_device_info plat_info;
> +	struct cdns3_wrap *wrap;
> +	struct resource *res;
> +	int err;
> +
> +	/*
> +	 * for GADGET/HOST PCI (devfn) function number is 0,
> +	 * for OTG PCI (devfn) function number is 1
> +	 */
> +	if (!id || pdev->devfn != PCI_DEV_FN_HOST_DEVICE)
> +		return -EINVAL;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
> +		return err;
> +	}
> +
> +	pci_set_master(pdev);
> +	wrap = devm_kzalloc(&pdev->dev, sizeof(*wrap), GFP_KERNEL);
> +	if (!wrap) {
> +		dev_err(&pdev->dev, "Failed to load PCI module\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* function 0: host(BAR_0) + device(BAR_1) + otg(BAR_2)). */
> +	memset(wrap->dev_res, 0x00,
> +	       sizeof(struct resource) * ARRAY_SIZE(wrap->dev_res));
> +	dev_info(&pdev->dev, "Initialize Device resources\n");
> +	res = wrap->dev_res;
> +
> +#if IS_ENABLED(CONFIG_USB_CDNS3_GADGET)

Why depend on Config options to populate resources? The resources should be there regardless.
It is a lot simpler that way as it reflects the hardware as-is.

> +	res[RES_DEV_ID].start = pci_resource_start(pdev, PCI_BAR_DEV);
> +	res[RES_DEV_ID].end =   pci_resource_end(pdev, PCI_BAR_DEV);
> +	res[RES_DEV_ID].name = "cdns3-dev-regs";
> +	res[RES_DEV_ID].flags = IORESOURCE_MEM;
> +	dev_info(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
> +		 &res[RES_DEV_ID].start);
> +

dev_dbg() for this and all occurrences below?

> +#endif
> +
> +#if IS_ENABLED(CONFIG_USB_CDNS3_HOST)
> +	res[RES_HOST_ID].start = pci_resource_start(pdev, PCI_BAR_HOST);
> +	res[RES_HOST_ID].end = pci_resource_end(pdev, PCI_BAR_HOST);
> +	res[RES_HOST_ID].name = "cdns3-xhci-regs";
> +	res[RES_HOST_ID].flags = IORESOURCE_MEM;
> +	dev_info(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
> +		 &res[RES_HOST_ID].start);
> +#endif
> +
> +	res[RES_DRD_ID].start = pci_resource_start(pdev, PCI_BAR_OTG);
> +	res[RES_DRD_ID].end =   pci_resource_end(pdev, PCI_BAR_OTG);
> +	res[RES_DRD_ID].name = "cdns3-otg";
> +	res[RES_DRD_ID].flags = IORESOURCE_MEM;
> +	dev_info(&pdev->dev, "USBSS-DRD physical base addr: %pa\n",
> +		 &res[RES_DRD_ID].start);
> +
> +	/* Interrupt common for both device and XHCI */
> +	wrap->dev_res[RES_IRQ_ID].start = pdev->irq;
> +	wrap->dev_res[RES_IRQ_ID].name = "cdns3-irq";
> +	wrap->dev_res[RES_IRQ_ID].flags = IORESOURCE_IRQ;
> +
> +	/* set up platform device info */
> +	memset(&plat_info, 0, sizeof(plat_info));
> +	plat_info.parent = &pdev->dev;
> +	plat_info.fwnode = pdev->dev.fwnode;
> +	plat_info.name = PLAT_DRIVER_NAME;
> +	plat_info.id = pdev->devfn;
> +	plat_info.res = wrap->dev_res;
> +	plat_info.num_res = ARRAY_SIZE(wrap->dev_res);
> +	plat_info.dma_mask = pdev->dma_mask;
> +
> +	/* register platform device */
> +	wrap->plat_dev = platform_device_register_full(&plat_info);
> +	if (IS_ERR(wrap->plat_dev)) {
> +		err = PTR_ERR(wrap->plat_dev);
> +		return err;
> +	}
> +
> +	pci_set_drvdata(pdev, wrap);
> +
> +	return err;
> +}
> +
> +void cdns3_pci_remove(struct pci_dev *pdev)
> +{
> +	struct cdns3_wrap *wrap = (struct cdns3_wrap *)pci_get_drvdata(pdev);
> +
> +	platform_device_unregister(wrap->plat_dev);
> +}
> +
> +static const struct pci_device_id cdns3_pci_ids[] = {
> +	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
> +	{ 0, }
> +};
> +
> +static struct pci_driver cdns3_pci_driver = {
> +	.name = PCI_DRIVER_NAME,
> +	.id_table = cdns3_pci_ids,
> +	.probe = cdns3_pci_probe,
> +	.remove = cdns3_pci_remove,
> +};
> +
> +module_pci_driver(cdns3_pci_driver);
> +MODULE_DEVICE_TABLE(pci, cdns3_pci_ids);
> +
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence USBSS PCI wrapperr");
> +
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
