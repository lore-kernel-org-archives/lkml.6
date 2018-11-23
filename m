Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2878C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675EC20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DAsRN8RM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675EC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409480AbeKWV2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:28:13 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41526 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387625AbeKWV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:28:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wANAiLpA002740;
        Fri, 23 Nov 2018 04:44:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542969861;
        bh=jiDzKVE9g1BKFYaT0Bqcg9AuyVZix/X2w2efE406NNc=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=DAsRN8RMyxoRxD/bTz4VQojkq1lRwzU9SOLuM31PGgQuu0FvczUQZLDuP6zx6T550
         xm50yeZ8HddjckXEAHhjSa3rlASNgu5l3HjAzc6JGx6YaccbUi7zzcSDDE2zh/bk4B
         7NWXDE/hEgRcJ6mAkYOqLi+h2ryxej0J89EPvFSY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wANAiLbU010750
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 04:44:21 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 04:44:19 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 04:44:19 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wANAiGMg010907;
        Fri, 23 Nov 2018 04:44:17 -0600
Subject: Re: [RFC PATCH v2 01/15] usb:cdns3: add pci to platform driver
 wrapper.
To:     Pawel Laszczak <pawell@cadence.com>, <devicetree@vger.kernel.org>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-2-git-send-email-pawell@cadence.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BF7DA00.7070002@ti.com>
Date:   Fri, 23 Nov 2018 12:44:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1542535751-16079-2-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

On 18/11/18 12:08, Pawel Laszczak wrote:
> Patch adds PCI specific glue driver that creates and registers in-system
> cdns-usb3 platform device. Thanks to that we will be able to use
> the cdns-usb3 platform driver for USBSS-DEV controller
> build on PCI board
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/Kconfig                |   2 +
>  drivers/usb/Makefile               |   2 +
>  drivers/usb/cdns3/Kconfig          |  24 +++++
>  drivers/usb/cdns3/Makefile         |   3 +
>  drivers/usb/cdns3/cdns3-pci-wrap.c | 157 +++++++++++++++++++++++++++++
>  5 files changed, 188 insertions(+)
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
> index 000000000000..eb22a8692991
> --- /dev/null
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -0,0 +1,24 @@
> +config USB_CDNS3
> +	tristate "Cadence USB3 Dual-Role Controller"
> +	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
> +	help
> +	  Say Y here if your system has a cadence USB3 dual-role controller.
> +	  It supports: dual-role switch, Host-only, and Peripheral-only.
> +
> +	  If you choose to build this driver is a dynamically linked
> +	  module, the module will be called cdns3.ko.
> +
> +if USB_CDNS3
> +
> +config USB_CDNS3_PCI_WRAP
> +	tristate "PCIe-based Platforms"

"Cadence USB3 support on PCIe-based platforms"?

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
> index 000000000000..d0a15cc0b738
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
> @@ -0,0 +1,157 @@
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

"Failed to allocate memory" ?

Rest of patch looks good to me.

> +		return -ENOMEM;
> +	}
> +
> +	/* function 0: host(BAR_0) + device(BAR_1) + otg(BAR_2)). */
> +	memset(wrap->dev_res, 0x00,
> +	       sizeof(struct resource) * ARRAY_SIZE(wrap->dev_res));
> +	dev_dbg(&pdev->dev, "Initialize Device resources\n");
> +	res = wrap->dev_res;
> +
> +	res[RES_DEV_ID].start = pci_resource_start(pdev, PCI_BAR_DEV);
> +	res[RES_DEV_ID].end =   pci_resource_end(pdev, PCI_BAR_DEV);
> +	res[RES_DEV_ID].name = "cdns3-dev-regs";
> +	res[RES_DEV_ID].flags = IORESOURCE_MEM;
> +	dev_dbg(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
> +		&res[RES_DEV_ID].start);
> +
> +	res[RES_HOST_ID].start = pci_resource_start(pdev, PCI_BAR_HOST);
> +	res[RES_HOST_ID].end = pci_resource_end(pdev, PCI_BAR_HOST);
> +	res[RES_HOST_ID].name = "cdns3-xhci-regs";
> +	res[RES_HOST_ID].flags = IORESOURCE_MEM;
> +	dev_dbg(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
> +		&res[RES_HOST_ID].start);
> +
> +	res[RES_DRD_ID].start = pci_resource_start(pdev, PCI_BAR_OTG);
> +	res[RES_DRD_ID].end =   pci_resource_end(pdev, PCI_BAR_OTG);
> +	res[RES_DRD_ID].name = "cdns3-otg";
> +	res[RES_DRD_ID].flags = IORESOURCE_MEM;
> +	dev_dbg(&pdev->dev, "USBSS-DRD physical base addr: %pa\n",
> +		&res[RES_DRD_ID].start);
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
