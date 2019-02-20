Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60786C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3782147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IgFHcxNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfBTNFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:05:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54510 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfBTNFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:05:30 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KD4xIb090854;
        Wed, 20 Feb 2019 07:04:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550667899;
        bh=vIQgL1ykm2WAtN8xEkkGVHAISyw9Y2lKwR8Wpn5EDjc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IgFHcxNdMEmE87/XTg4oz9/m363LtDLYrHXz/EzNrxR57yVcI+zzhBgTmxNC+Gx1+
         UMyvnvKcHLuBt4WKJptzc6zIE02EXLe+qWKN8f1uSXNScGRwRu7tQdATx2DQOZfwj+
         5R2DjoSKkVQxUtrQRBs7MahDDm7dPWfkiJnANIXw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KD4xBs004504
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 07:04:59 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 07:04:58 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 07:04:58 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KD4sZC024874;
        Wed, 20 Feb 2019 07:04:54 -0600
Subject: Re: [PATCH v4 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Pawel Laszczak <pawell@cadence.com>, <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <mark.rutland@arm.com>, <linux-usb@vger.kernel.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
 <1550173514-23573-6-git-send-email-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <3af305e0-40bf-28cc-48d5-4afa241e7899@ti.com>
Date:   Wed, 20 Feb 2019 15:04:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550173514-23573-6-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 14/02/2019 21:45, Pawel Laszczak wrote:
> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> 
> The Cadence USBSS DRD Driver is a highly configurable IP Core whichi
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.
> 
> The current driver has been validated with FPGA burned. We have support
> for PCIe bus, which is used on FPGA prototyping.
> 
> The host side of USBSS-DRD controller is compliance with XHCI
> specification, so it works with standard XHCI linux driver.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/Kconfig                |    2 +
>  drivers/usb/Makefile               |    2 +
>  drivers/usb/cdns3/Kconfig          |   44 +
>  drivers/usb/cdns3/Makefile         |   14 +
>  drivers/usb/cdns3/cdns3-pci-wrap.c |  155 +++
>  drivers/usb/cdns3/core.c           |  403 ++++++
>  drivers/usb/cdns3/core.h           |  116 ++
>  drivers/usb/cdns3/debug.h          |  168 +++
>  drivers/usb/cdns3/debugfs.c        |  164 +++
>  drivers/usb/cdns3/drd.c            |  365 +++++
>  drivers/usb/cdns3/drd.h            |  162 +++
>  drivers/usb/cdns3/ep0.c            |  907 +++++++++++++
>  drivers/usb/cdns3/gadget-export.h  |   28 +
>  drivers/usb/cdns3/gadget.c         | 2003 ++++++++++++++++++++++++++++
>  drivers/usb/cdns3/gadget.h         | 1207 +++++++++++++++++
>  drivers/usb/cdns3/host-export.h    |   28 +
>  drivers/usb/cdns3/host.c           |   72 +
>  drivers/usb/cdns3/trace.c          |   23 +
>  drivers/usb/cdns3/trace.h          |  404 ++++++
>  19 files changed, 6267 insertions(+)
>  create mode 100644 drivers/usb/cdns3/Kconfig
>  create mode 100644 drivers/usb/cdns3/Makefile
>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>  create mode 100644 drivers/usb/cdns3/core.c
>  create mode 100644 drivers/usb/cdns3/core.h
>  create mode 100644 drivers/usb/cdns3/debug.h
>  create mode 100644 drivers/usb/cdns3/debugfs.c
>  create mode 100644 drivers/usb/cdns3/drd.c
>  create mode 100644 drivers/usb/cdns3/drd.h
>  create mode 100644 drivers/usb/cdns3/ep0.c
>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>  create mode 100644 drivers/usb/cdns3/gadget.c
>  create mode 100644 drivers/usb/cdns3/gadget.h
>  create mode 100644 drivers/usb/cdns3/host-export.h
>  create mode 100644 drivers/usb/cdns3/host.c
>  create mode 100644 drivers/usb/cdns3/trace.c
>  create mode 100644 drivers/usb/cdns3/trace.h
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
> index 7d1b8c82b208..ab125b966cac 100644
> --- a/drivers/usb/Makefile
> +++ b/drivers/usb/Makefile
> @@ -12,6 +12,8 @@ obj-$(CONFIG_USB_DWC3)		+= dwc3/
>  obj-$(CONFIG_USB_DWC2)		+= dwc2/
>  obj-$(CONFIG_USB_ISP1760)	+= isp1760/
>  
> +obj-$(CONFIG_USB_CDNS3)		+= cdns3/
> +
>  obj-$(CONFIG_USB_MON)		+= mon/
>  obj-$(CONFIG_USB_MTU3)		+= mtu3/
>  
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> new file mode 100644
> index 000000000000..27cb3d8dbe3d
> --- /dev/null
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -0,0 +1,44 @@
> +config USB_CDNS3
> +	tristate "Cadence USB3 Dual-Role Controller"
> +	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
> +	help
> +	  Say Y here if your system has a cadence USB3 dual-role controller.
> +	  It supports: dual-role switch, Host-only, and Peripheral-only.
> +
> +	  If you choose to build this driver is a dynamically linked
> +	  as module, the module will be called cdns3.ko.
> +
> +if USB_CDNS3
> +
> +config USB_CDNS3_GADGET
> +        bool "Cadence USB3 device controller"
> +        depends on USB_GADGET
> +        help
> +          Say Y here to enable device controller functionality of the
> +          cadence USBSS-DEV driver.

"Cadence" ?

> +
> +          This controller supports FF, HS and SS mode. It doesn't support
> +          LS and SSP mode.
> +
> +config USB_CDNS3_HOST
> +        bool "Cadence USB3 host controller"
> +        depends on USB_XHCI_HCD
> +        help
> +          Say Y here to enable host controller functionality of the
> +          cadence driver.
> +
> +          Host controller is compliant with XHCI so it will use
> +          standard XHCI driver.
> +
> +config USB_CDNS3_PCI_WRAP
> +	tristate "Cadence USB3 support on PCIe-based platforms"
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
> index 000000000000..8f9438593375
> --- /dev/null
> +++ b/drivers/usb/cdns3/Makefile
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# define_trace.h needs to know how to find our header
> +CFLAGS_trace.o				:= -I$(src)
> +
> +cdns3-y					:= core.o drd.o trace.o
> +
> +obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
> +ifneq ($(CONFIG_DEBUG_FS),)
> +	cdns3-y				+= debugfs.o
> +endif
> +
> +cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o
> +cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
> +obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci-wrap.o
> diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
> new file mode 100644
> index 000000000000..d0b2d3d9b983
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS PCI Glue driver
> + *
> + * Copyright (C) 2018 Cadence.

2018-2019?

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
> +		dev_err(&pdev->dev, "Failed to allocate memory\n");
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
> +	res[RES_DEV_ID].name = "dev";
> +	res[RES_DEV_ID].flags = IORESOURCE_MEM;
> +	dev_dbg(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
> +		&res[RES_DEV_ID].start);
> +
> +	res[RES_HOST_ID].start = pci_resource_start(pdev, PCI_BAR_HOST);
> +	res[RES_HOST_ID].end = pci_resource_end(pdev, PCI_BAR_HOST);
> +	res[RES_HOST_ID].name = "xhci";
> +	res[RES_HOST_ID].flags = IORESOURCE_MEM;
> +	dev_dbg(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
> +		&res[RES_HOST_ID].start);
> +
> +	res[RES_DRD_ID].start = pci_resource_start(pdev, PCI_BAR_OTG);
> +	res[RES_DRD_ID].end =   pci_resource_end(pdev, PCI_BAR_OTG);
> +	res[RES_DRD_ID].name = "otg";
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
> +	if (IS_ERR(wrap->plat_dev))
> +		return PTR_ERR(wrap->plat_dev);
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
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> new file mode 100644
> index 000000000000..aa2f63241dab
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.c
> @@ -0,0 +1,403 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2018 Cadence.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Author: Peter Chen <peter.chen@nxp.com>
> + *         Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "gadget.h"
> +#include "core.h"
> +#include "host-export.h"
> +#include "gadget-export.h"
> +#include "drd.h"
> +#include "debug.h"
> +
> +static inline
> +struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
> +{
> +	WARN_ON(cdns->role >= CDNS3_ROLE_END || !cdns->roles[cdns->role]);
> +	return cdns->roles[cdns->role];
> +}
> +
> +static int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
> +{
> +	int ret;
> +
> +	if (WARN_ON(role >= CDNS3_ROLE_END))
> +		return 0;
> +
> +	if (!cdns->roles[role])
> +		return -ENXIO;
> +
> +	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_ACTIVE)
> +		return 0;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->role = role;
> +	ret = cdns->roles[role]->start(cdns);
> +	if (!ret)
> +		cdns->roles[role]->state = CDNS3_ROLE_STATE_ACTIVE;
> +	mutex_unlock(&cdns->mutex);
> +	return ret;
> +}
> +
> +void cdns3_role_stop(struct cdns3 *cdns)
> +{
> +	enum cdns3_roles role = cdns->role;
> +
> +	if (role >= CDNS3_ROLE_END) {
> +		WARN_ON(role > CDNS3_ROLE_END);
> +		return;
> +	}
> +
> +	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_INACTIVE)
> +		return;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->roles[role]->stop(cdns);
> +	cdns->roles[role]->state = CDNS3_ROLE_STATE_INACTIVE;
> +	mutex_unlock(&cdns->mutex);
> +}
> +
> +/*
> + * cdns->role gets from cdns3_get_initial_role, and this API tells role at the
> + * runtime.
> + * If both roles are supported, the role is selected based on vbus/id.
> + * It could be read from OTG register or external connector.
> + * If only single role is supported, only one role structure
> + * is allocated, cdns->roles[CDNS3_ROLE_HOST] or cdns->roles[CDNS3_ROLE_GADGET].
> + */
> +static enum cdns3_roles cdns3_get_initial_role(struct cdns3 *cdns)
> +{
> +	if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
> +		if (cdns3_is_host(cdns))
> +			return CDNS3_ROLE_HOST;
> +		if (cdns3_is_device(cdns))
> +			return CDNS3_ROLE_GADGET;
> +	}
> +	return cdns->roles[CDNS3_ROLE_HOST]
> +		? CDNS3_ROLE_HOST
> +		: CDNS3_ROLE_GADGET;
> +}
> +
> +static void cdns3_exit_roles(struct cdns3 *cdns)
> +{
> +	cdns3_role_stop(cdns);
> +	cdns3_drd_exit(cdns);
> +}
> +
> +/**
> + * cdns3_core_init_role - initialize role of operation
> + * @cdns: Pointer to cdns3 structure
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_core_init_role(struct cdns3 *cdns)
> +{
> +	struct device *dev = cdns->dev;
> +	enum usb_dr_mode best_dr_mode;
> +	enum usb_dr_mode dr_mode;
> +	int ret = 0;
> +
> +	dr_mode = usb_get_dr_mode(dev);
> +	cdns->role = CDNS3_ROLE_END;
> +
> +	/*
> +	 * If driver can't read mode by means of usb_get_dr_mdoe function then

s/mdoe/mode

> +	 * chooses mode according with Kernel configuration. This setting
> +	 * can be restricted later depending on strap pin configuration.
> +	 */
> +	if (dr_mode == USB_DR_MODE_UNKNOWN) {
> +		if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
> +		    IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> +			dr_mode = USB_DR_MODE_OTG;
> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> +			dr_mode = USB_DR_MODE_HOST;
> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> +			dr_mode = USB_DR_MODE_PERIPHERAL;
> +	}
> +
> +	best_dr_mode = USB_DR_MODE_OTG;

Might be worth mentioning that cdns->dr_mode is strap configuration
at this point.

What exactly are we trying to do here?
My guess is that choosen dr_mode can be equal to or subset of strap configuration?

Does this work?

	if (cdns->dr_mode != USB_DR_MODE_OTG) {
		if (cdns->dr_mode != dr_mode) {
			dev_err(dev, "Incorrect dr_mode configuration: strap %d: requested %d\n",
				cdns->dr_mode, dr_mode);
		}
	}

At this point, dr_mode contains the mode we need to use.

> +
> +	if (dr_mode == USB_DR_MODE_OTG) {
> +		best_dr_mode = cdns->dr_mode;
> +	} else if (cdns->dr_mode == USB_DR_MODE_OTG) {
> +		best_dr_mode = dr_mode;
> +	} else if (cdns->dr_mode != dr_mode) {
> +		dev_err(dev, "Incorrect DRD configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	dr_mode = best_dr_mode;
> +
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
> +		ret = cdns3_host_init(cdns);
> +		if (ret) {
> +			dev_err(dev, "Host initialization failed with %d\n",
> +				ret);
> +			goto err;
> +		}
> +	}
> +
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
> +		ret = cdns3_gadget_init(cdns);
> +		if (ret) {
> +			dev_err(dev, "Device initialization failed with %d\n",
> +				ret);
> +			goto err;
> +		}
> +	}> +
> +	cdns->desired_dr_mode = dr_mode;
> +	cdns->dr_mode = dr_mode;
> +	/*
> +	 * dr_mode could be change so DRD must update controller

"desired_dr_mode might have changed so we need to update the controller configuration"?

> +	 * configuration
> +	 */
> +	ret = cdns3_drd_update_mode(cdns);
> +	if (ret)
> +		goto err;
> +
> +	cdns->role = cdns3_get_initial_role(cdns);
> +
> +	ret = cdns3_role_start(cdns, cdns->role);
> +	if (ret) {
> +		dev_err(dev, "can't start %s role\n",
> +			cdns3_get_current_role_driver(cdns)->name);
> +		goto err;
> +	}
> +
> +	return ret;
> +err:
> +	cdns3_exit_roles(cdns);
> +	return ret;
> +}
> +
> +/**
> + * cdsn3_get_real_role - get real role of controller based on hardware settings.
> + * @cdns: Pointer to cdns3 structure
> + *
> + * Returns role
> + */
> +enum cdns3_roles cdsn3_get_real_role(struct cdns3 *cdns)
> +{
> +	enum cdns3_roles role = CDNS3_ROLE_END;
> +
> +	if (cdns->current_dr_mode == USB_DR_MODE_OTG) {
> +		if (cdns3_get_id(cdns))
> +			role = CDNS3_ROLE_GADGET;
> +		else
> +			role = CDNS3_ROLE_HOST;
> +	} else {
> +		if (cdns3_is_host(cdns))
> +			role = CDNS3_ROLE_HOST;
> +		if (cdns3_is_device(cdns))
> +			role = CDNS3_ROLE_GADGET;
> +	}
> +
> +	return role;
> +}
> +
> +/**
> + * cdns3_role_switch - work queue handler for role switch
> + *
> + * @work: work queue item structure
> + *
> + * Handles below events:
> + * - Role switch for dual-role devices
> + * - CDNS3_ROLE_GADGET <--> CDNS3_ROLE_END for peripheral-only devices
> + */
> +static void cdns3_role_switch(struct work_struct *work)
> +{
> +	enum cdns3_roles role = CDNS3_ROLE_END;
> +	struct cdns3_role_driver *role_drv;
> +	enum cdns3_roles current_role;
> +	struct cdns3 *cdns;
> +	int ret = 0;
> +
> +	cdns = container_of(work, struct cdns3, role_switch_wq);
> +
> +	/* During switching cdns->role can be different then role */
s/then/than

The comment is a bit misleading. The purpose of this switch function
is to do a switch if the role needs to be changed.

> +	role = cdsn3_get_real_role(cdns);
> +
> +	role_drv = cdns3_get_current_role_driver(cdns);
> +
> +	pm_runtime_get_sync(cdns->dev);

pm_runtime_get_sync() must be moved to before cdsn3_get_real_role() as that function
accesses a device register.

> +
> +	/* Disable current role. This state can be forced from user space. */
/* Disable current role if requrested from debugfs */?

> +	if (cdns->debug_disable && role_drv->state == CDNS3_ROLE_STATE_ACTIVE) {
> +		cdns3_role_stop(cdns);
> +		goto exit;
> +	}
> +
> +	/* Do nothing if nothing changed */
> +	if (cdns->role == role && role_drv->state == CDNS3_ROLE_STATE_ACTIVE)
> +		goto exit;
> +
> +	cdns3_role_stop(cdns);
> +
> +	role = cdsn3_get_real_role(cdns);

You already did cdns3_get_real_role before. This is redundant.
> +
> +	current_role = cdns->role;
> +	dev_dbg(cdns->dev, "Switching role");
> +
> +	ret = cdns3_role_start(cdns, role);
> +	if (ret) {
> +		/* Back to current role */
> +		dev_err(cdns->dev, "set %d has failed, back to %d\n",
> +			role, current_role);
> +		cdns3_role_start(cdns, current_role);

Need to check return value here as well? And complain loud if that fails too.

> +	}
> +exit:
> +	pm_runtime_put_sync(cdns->dev);
> +}
> +
> +/**
> + * cdns3_probe - probe for cdns3 core device
> + * @pdev: Pointer to cdns3 core platform device
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource	*res;
> +	struct cdns3 *cdns;
> +	void __iomem *regs;
> +	int ret;
> +
> +	cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
> +	if (!cdns)
> +		return -ENOMEM;
> +
> +	cdns->dev = dev;
> +
> +	platform_set_drvdata(pdev, cdns);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!res) {
> +		dev_err(dev, "missing IRQ\n");
> +		return -ENODEV;
> +	}
> +	cdns->irq = res->start;
> +
> +	cdns->xhci_res[0] = *res;
> +
> +	/*
> +	 * Request memory region
> +	 * region-0: xHCI
> +	 * region-1: Peripheral
> +	 * region-2: OTG registers
> +	 */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
> +	if (!res)
> +		return -ENXIO;
> +
> +	cdns->xhci_res[1] = *res;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dev");
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +	cdns->dev_regs	= regs;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
> +	if (!res)
> +		return -ENXIO;
> +
> +	cdns->otg_res = *res;
> +
> +	mutex_init(&cdns->mutex);
> +
> +	cdns->phy = devm_phy_optional_get(dev, "cdns3,usbphy");
> +	if (IS_ERR(cdns->phy))
> +		return PTR_ERR(cdns->phy);
> +
> +	phy_init(cdns->phy);
> +
> +	INIT_WORK(&cdns->role_switch_wq, cdns3_role_switch);
> +
> +	ret = cdns3_drd_init(cdns);
> +	if (ret)
> +		goto err;
> +
> +	ret = cdns3_core_init_role(cdns);
> +	if (ret)
> +		goto err;
> +
> +	cdns3_debugfs_init(cdns);
> +	device_set_wakeup_capable(dev, true);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	/*
> +	 * The controller needs less time between bus and controller suspend,
> +	 * and we also needs a small delay to avoid frequently entering low
> +	 * power mode.
> +	 */
> +	pm_runtime_set_autosuspend_delay(dev, 20);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_use_autosuspend(dev);
> +	dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
> +
> +	return 0;
> +
> +err:
> +	phy_exit(cdns->phy);
> +	return ret;
> +}
> +
> +/**
> + * cdns3_remove - unbind drd driver and clean up
> + * @pdev: Pointer to Linux platform device
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_remove(struct platform_device *pdev)
> +{
> +	struct cdns3 *cdns = platform_get_drvdata(pdev);
> +
> +	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);

I'm not sure if this is handled right.
You are still accessing the device in below cnds3_*() calls.

> +	cdns3_debugfs_exit(cdns);
> +	cdns3_exit_roles(cdns);> +	phy_exit(cdns->phy);

Is the device is in runtime suspended state at this point?

> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_cdns3_match[] = {
> +	{ .compatible = "cdns,usb3-1.0.0" },
> +	{ .compatible = "cdns,usb3-1.0.1" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_cdns3_match);
> +#endif
> +
> +static struct platform_driver cdns3_driver = {
> +	.probe		= cdns3_probe,
> +	.remove		= cdns3_remove,
> +	.driver		= {
> +		.name	= "cdns-usb3",
> +		.of_match_table	= of_match_ptr(of_cdns3_match),
> +	},
> +};
> +
> +module_platform_driver(cdns3_driver);
> +
> +MODULE_ALIAS("platform:cdns3");
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> new file mode 100644
> index 000000000000..fb4b39206158
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.h
> @@ -0,0 +1,116 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Header File.
> + *
> + * Copyright (C) 2017-2018 NXP
> + * Copyright (C) 2018 Cadence.
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + *          Pawel Laszczak <pawell@cadence.com>
> + */
> +#include <linux/usb/otg.h>
> +
> +#ifndef __LINUX_CDNS3_CORE_H
> +#define __LINUX_CDNS3_CORE_H
> +
> +struct cdns3;
> +enum cdns3_roles {
> +	CDNS3_ROLE_HOST = 0,
> +	CDNS3_ROLE_GADGET,
> +	CDNS3_ROLE_END,
> +};
> +
> +/**
> + * struct cdns3_role_driver - host/gadget role driver
> + * @start: start this role
> + * @stop: stop this role
> + * @suspend: suspend callback for this role
> + * @resume: resume callback for this role
> + * @irq: irq handler for this role
> + * @name: role name string (host/gadget)
> + * @state: current state
> + */
> +struct cdns3_role_driver {
> +	int (*start)(struct cdns3 *cdns);
> +	void (*stop)(struct cdns3 *cdns);
> +	int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
> +	int (*resume)(struct cdns3 *cdns, bool hibernated);
> +	const char *name;
> +#define CDNS3_ROLE_STATE_INACTIVE	0
> +#define CDNS3_ROLE_STATE_ACTIVE		1
> +	int state;
> +};
> +
> +#define CDNS3_XHCI_RESOURCES_NUM	2
> +/**
> + * struct cdns3 - Representation of Cadence USB3 DRD controller.
> + * @dev: pointer to Cadence device struct
> + * @xhci_regs: pointer to base of xhci registers
> + * @xhci_res: the resource for xhci
> + * @dev_regs: pointer to base of dev registers
> + * @otg_regs: pointer to base of otg registers
> + * @irq: irq number for controller
> + * @roles: array of supported roles for this controller
> + * @role: current role
> + * @host_dev: the child host device pointer for cdns3 core
> + * @gadget_dev: the child gadget device pointer for cdns3 core
> + * @usb: phy for this controller
> + * @role_switch_wq: work queue item for role switch
> + * @in_lpm: the controller in low power mode
> + * @wakeup_int: the wakeup interrupt
> + * @mutex: the mutex for concurrent code at driver
> + * @dr_mode: supported mode of operation it can be only Host, only Device
> + *           or OTG mode that allow to switch between Device and Host mode.
> + *           This field based on firmware setting, kernel configuration
> + *           and hardware configuration.
> + * @current_dr_mode: current mode of operation when in dual-role mode
> + * @desired_dr_mode: desired mode of operation when in dual-role mode.
> + *           This value can be changed during runtime.
> + *           Available options depends on  dr_mode:
> + *           dr_mode                 |  desired_dr_mode and current_dr_mode
> + *           ----------------------------------------------------------------
> + *           USB_DR_MODE_HOST        | only USB_DR_MODE_HOST
> + *           USB_DR_MODE_PERIPHERAL  | only USB_DR_MODE_PERIPHERAL
> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_HOST
> + *           USB_DR_MODE_OTG         | only USB_DR_MODE_PERIPHERAL
> + *           USB_DR_MODE_OTG         | USB_DR_MODE_OTG

Last 3 lines should be reduced to

		USB_DR_MODE_OTG         | USB_DR_MODE_OTG, USB_DR_MODE_HOST or
					| USB_DR_MODE_PERIPHERAL

> + *
> + *           Desired_dr_role can be changed by means of debugfs.
> + * @root: debugfs root folder pointer
> + * @debug_disable:
> + */
> +struct cdns3 {
> +	struct device			*dev;
> +	void __iomem			*xhci_regs;
> +	struct resource			xhci_res[CDNS3_XHCI_RESOURCES_NUM];
> +	struct cdns3_usb_regs __iomem	*dev_regs;
> +
> +	struct resource			otg_res;
> +	struct cdns3_otg_legacy_regs	*otg_v0_regs;
> +	struct cdns3_otg_regs		*otg_v1_regs;
> +	struct cdns3_otg_common_regs	*otg_regs;
> +#define CDNS3_CONTROLLER_V0	0
> +#define CDNS3_CONTROLLER_V1	1
> +	u32				version;
> +
> +	int				irq;
> +	struct cdns3_role_driver	*roles[CDNS3_ROLE_END];
> +	enum cdns3_roles		role;
> +	struct platform_device		*host_dev;
> +	struct cdns3_device		*gadget_dev;
> +	struct phy			*phy;
> +	struct work_struct		role_switch_wq;
> +	int				in_lpm:1;
> +	int				wakeup_int:1;
> +	/* mutext used in workqueue*/
> +	struct mutex			mutex;
> +	enum usb_dr_mode		dr_mode;
> +	enum usb_dr_mode		current_dr_mode;
> +	enum usb_dr_mode		desired_dr_mode;
> +	struct dentry			*root;
> +	int				debug_disable:1;
> +};
> +
> +void cdns3_role_stop(struct cdns3 *cdns);
> +
> +#endif /* __LINUX_CDNS3_CORE_H */
> diff --git a/drivers/usb/cdns3/debug.h b/drivers/usb/cdns3/debug.h
> new file mode 100644
> index 000000000000..1929edb3a521
> --- /dev/null
> +++ b/drivers/usb/cdns3/debug.h
> @@ -0,0 +1,168 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Driver.
> + * Debug header file.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +#ifndef __LINUX_CDNS3_DEBUG
> +#define __LINUX_CDNS3_DEBUG
> +
> +#include "core.h"
> +
> +static inline char *cdns3_decode_usb_irq(char *str,
> +					 enum usb_device_speed speed,
> +					 u32 usb_ists)
> +{
> +	int ret;
> +
> +	ret = sprintf(str, "IRQ %08x = ", usb_ists);
> +
> +	if (usb_ists & (USB_ISTS_CON2I | USB_ISTS_CONI)) {
> +		ret += sprintf(str + ret, "Connection %s\n",
> +			       usb_speed_string(speed));
> +	}
> +	if (usb_ists & USB_ISTS_CON2I || usb_ists & USB_ISTS_CONI)
> +		ret += sprintf(str + ret, "Disconnection ");
> +	if (usb_ists & USB_ISTS_L2ENTI)
> +		ret += sprintf(str + ret, "suspended ");
> +
> +	if (usb_ists & USB_ISTS_L2EXTI)
> +		ret += sprintf(str + ret, "L2 exit ");
> +	if (usb_ists & USB_ISTS_U3EXTI)
> +		ret += sprintf(str + ret, "U3 exit ");
> +	if (usb_ists & USB_ISTS_UWRESI)
> +		ret += sprintf(str + ret, "Warm Reset ");
> +	if (usb_ists & USB_ISTS_UHRESI)
> +		ret += sprintf(str + ret, "Hot Reset ");
> +	if (usb_ists & USB_ISTS_U2RESI)
> +		ret += sprintf(str + ret, "Reset");
> +
> +	return str;
> +}
> +
> +static inline  char *cdns3_decode_ep_irq(char *str,
> +					 u32 ep_sts,
> +					 const char *ep_name)
> +{
> +	int ret;
> +
> +	ret = sprintf(str, "IRQ for %s: %08x ", ep_name, ep_sts);
> +
> +	if (ep_sts & EP_STS_SETUP)
> +		ret += sprintf(str + ret, "SETUP ");
> +	if (ep_sts & EP_STS_IOC)
> +		ret += sprintf(str + ret, "IOC ");
> +	if (ep_sts & EP_STS_ISP)
> +		ret += sprintf(str + ret, "ISP ");
> +	if (ep_sts & EP_STS_DESCMIS)
> +		ret += sprintf(str + ret, "DESCMIS ");
> +	if (ep_sts & EP_STS_STREAMR)
> +		ret += sprintf(str + ret, "STREAMR ");
> +	if (ep_sts & EP_STS_MD_EXIT)
> +		ret += sprintf(str + ret, "MD_EXIT ");
> +	if (ep_sts & EP_STS_TRBERR)
> +		ret += sprintf(str + ret, "TRBERR ");
> +	if (ep_sts & EP_STS_NRDY)
> +		ret += sprintf(str + ret, "NRDY ");
> +	if (ep_sts & EP_STS_PRIME)
> +		ret += sprintf(str + ret, "PRIME ");
> +	if (ep_sts & EP_STS_SIDERR)
> +		ret += sprintf(str + ret, "SIDERRT ");
> +	if (ep_sts & EP_STS_OUTSMM)
> +		ret += sprintf(str + ret, "OUTSMM ");
> +	if (ep_sts & EP_STS_ISOERR)
> +		ret += sprintf(str + ret, "ISOERR ");
> +	if (ep_sts & EP_STS_IOT)
> +		ret += sprintf(str + ret, "IOT ");
> +
> +	return str;
> +}
> +
> +static inline char *cdns3_decode_epx_irq(char *str,
> +					 char *ep_name,
> +					 u32 ep_sts)
> +{
> +	return cdns3_decode_ep_irq(str, ep_sts, ep_name);
> +}
> +
> +static inline char *cdns3_decode_ep0_irq(char *str,
> +					 int dir,
> +					 u32 ep_sts)
> +{
> +	return cdns3_decode_ep_irq(str, ep_sts,
> +				   dir ? "ep0IN" : "ep0OUT");
> +}
> +
> +/**
> + * Debug a transfer ring.
> + *
> + * Prints out all TRBs in the endpoint ring, even those after the Link TRB.
> + *.
> + */
> +static inline char *cdns3_dbg_ring(struct cdns3_endpoint *priv_ep,
> +				   struct cdns3_trb *ring, char *str)
> +{
> +	dma_addr_t addr = priv_ep->trb_pool_dma;
> +	struct cdns3_trb *trb;
> +	int trb_per_sector;
> +	int ret = 0;
> +	int i;
> +
> +	trb_per_sector = GET_TRBS_PER_SEGMENT(priv_ep->type);
> +
> +	trb = &priv_ep->trb_pool[priv_ep->dequeue];
> +	ret += sprintf(str + ret, "\n\t\tRing contents for %s:", priv_ep->name);
> +
> +	ret += sprintf(str + ret,
> +		       "\n\t\tRing deq index: %d, trb: %p (virt), 0x%llx (dma)\n",
> +		       priv_ep->dequeue, trb,
> +		       (unsigned long long)cdns3_trb_virt_to_dma(priv_ep, trb));
> +
> +	trb = &priv_ep->trb_pool[priv_ep->enqueue];
> +	ret += sprintf(str + ret,
> +		       "\t\tRing enq index: %d, trb: %p (virt), 0x%llx (dma)\n",
> +		       priv_ep->enqueue, trb,
> +		       (unsigned long long)cdns3_trb_virt_to_dma(priv_ep, trb));
> +
> +	ret += sprintf(str + ret,
> +		       "\t\tfree trbs: %d, CCS=%d, PCS=%d\n",
> +		       priv_ep->free_trbs, priv_ep->ccs, priv_ep->pcs);
> +
> +	if (trb_per_sector > TRBS_PER_SEGMENT)
> +		trb_per_sector = TRBS_PER_SEGMENT;
> +
> +	if (trb_per_sector > TRBS_PER_SEGMENT) {
> +		sprintf(str + ret, "\t\tTo big transfer ring %d\n",
> +			trb_per_sector);
> +		return str;
> +	}
> +
> +	for (i = 0; i < trb_per_sector; ++i) {
> +		trb = &ring[i];
> +		ret += sprintf(str + ret,
> +			"\t\t@%pad %08x %08x %08x\n", &addr,
> +			le32_to_cpu(trb->buffer),
> +			le32_to_cpu(trb->length),
> +			le32_to_cpu(trb->control));
> +		addr += sizeof(*trb);
> +	}
> +
> +	return str;
> +}
> +
> +void cdns3_dbg(struct cdns3_device *priv_dev, const char *fmt, ...);
> +
> +#ifdef CONFIG_DEBUG_FS
> +void cdns3_debugfs_init(struct cdns3 *cdns);
> +void cdns3_debugfs_exit(struct cdns3 *cdns);
> +#else
> +void cdns3_debugfs_init(struct cdns3 *cdns);
> +{  }
> +void cdns3_debugfs_exit(struct cdns3 *cdns);
> +{  }
> +#endif
> +
> +#endif /*__LINUX_CDNS3_DEBUG*/
> diff --git a/drivers/usb/cdns3/debugfs.c b/drivers/usb/cdns3/debugfs.c
> new file mode 100644
> index 000000000000..d8fcd90d05b3
> --- /dev/null
> +++ b/drivers/usb/cdns3/debugfs.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Controller DebugFS filer.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/uaccess.h>
> +
> +#include "core.h"
> +#include "gadget.h"
> +#include "drd.h"
> +
> +static int cdns3_mode_show(struct seq_file *s, void *unused)
> +{
> +	struct cdns3 *cdns = s->private;
> +
> +	switch (cdns->current_dr_mode) {
> +	case USB_DR_MODE_HOST:
> +		seq_puts(s, "host\n");
> +		break;
> +	case USB_DR_MODE_PERIPHERAL:
> +		seq_puts(s, "device\n");
> +		break;
> +	case USB_DR_MODE_OTG:
> +		seq_puts(s, "otg\n");
> +		break;
> +	default:
> +		seq_puts(s, "UNKNOWN mode\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns3_mode_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, cdns3_mode_show, inode->i_private);
> +}
> +
> +static ssize_t cdns3_mode_write(struct file *file,
> +				const char __user *ubuf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct seq_file	 *s = file->private_data;
> +	struct cdns3 *cdns = s->private;
> +	u32 mode = USB_DR_MODE_UNKNOWN;
> +	char buf[32];
> +
> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +		return -EFAULT;
> +
> +	if (!strncmp(buf, "host", 4)) {
> +		if (cdns->dr_mode == USB_DR_MODE_HOST ||
> +		    cdns->dr_mode == USB_DR_MODE_OTG) {
> +			mode = USB_DR_MODE_HOST;
> +		}
> +	}
> +
> +	if (!strncmp(buf, "device", 6))
> +		if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL ||
> +		    cdns->dr_mode == USB_DR_MODE_OTG)
> +			mode = USB_DR_MODE_PERIPHERAL;
> +
> +	if (!strncmp(buf, "otg", 3) && cdns->dr_mode == USB_DR_MODE_OTG)
> +		mode = USB_DR_MODE_OTG;
> +
> +	if (mode == USB_DR_MODE_UNKNOWN) {
> +		dev_err(cdns->dev, "Failed: incorrect mode setting\n");
> +		return -EFAULT;
> +	}
> +
> +	if (cdns->current_dr_mode != mode) {
> +		cdns->desired_dr_mode = mode;
> +		cdns->debug_disable = 0;
Instead of forcing debug_disable here maybe you hould check if it is set
and complain that mode can't be changed when debug_disable is set?

> +		cdns3_role_stop(cdns);
> +		cdns3_drd_update_mode(cdns);

Need to check return value.

> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations cdns3_mode_fops = {
> +	.open			= cdns3_mode_open,
> +	.write			= cdns3_mode_write,
> +	.read			= seq_read,
> +	.llseek			= seq_lseek,
> +	.release		= single_release,
> +};
> +
> +static int cdns3_disable_show(struct seq_file *s, void *unused)
> +{
> +	struct cdns3 *cdns = s->private;
> +
> +	if (!cdns->debug_disable)
> +		seq_puts(s, "0\n");
> +	else
> +		seq_puts(s, "1\n");
> +
> +	return 0;
> +}
> +
> +static ssize_t cdns3_disable_write(struct file *file,
> +				   const char __user *ubuf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct seq_file	 *s = file->private_data;
> +	struct cdns3 *cdns = s->private;
> +	bool disable;
> +	char buf[16];
> +
> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +		return -EFAULT;
> +
> +	if (kstrtobool(buf, &disable)) {
> +		dev_err(cdns->dev, "wrong setting\n");
> +		return -EINVAL;
> +	}
> +
> +	if (disable != cdns->debug_disable) {
> +		cdns->debug_disable = disable;
> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);

What is the purpose of this disable debugfs file?
To stop the currently active role?

> +	}
> +
> +	return count;
> +}
> +
> +static int cdns3_disable_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, cdns3_disable_show, inode->i_private);
> +}
> +
> +static const struct file_operations cdns3_disable_fops = {
> +	.open			= cdns3_disable_open,
> +	.write			= cdns3_disable_write,
> +	.read			= seq_read,
> +	.llseek			= seq_lseek,
> +	.release		= single_release,
> +};
> +
> +void cdns3_debugfs_init(struct cdns3 *cdns)
> +{
> +	struct dentry *root;
> +
> +	root = debugfs_create_dir(dev_name(cdns->dev), NULL);
> +	cdns->root = root;
> +	if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET) &&
> +	    IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> +		debugfs_create_file("mode", 0644, root, cdns,
> +				    &cdns3_mode_fops);
> +
> +	debugfs_create_file("disable", 0644, root, cdns,
> +			    &cdns3_disable_fops);
> +}
> +
> +void cdns3_debugfs_exit(struct cdns3 *cdns)
> +{
> +	debugfs_remove_recursive(cdns->root);
> +}
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> new file mode 100644
> index 000000000000..3e56338cd7b9
> --- /dev/null
> +++ b/drivers/usb/cdns3/drd.c
> @@ -0,0 +1,365 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/usb/otg.h>
> +
> +#include "gadget.h"
> +#include "drd.h"
> +#include "core.h"
> +
> +static int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on);
> +static int cdns3_drd_switch_host(struct cdns3 *cdns, int on);
> +
> +/**
> + * cdns3_set_mode - change mode of OTG Core
> + * @cdns: pointer to context structure
> + * @mode: selected mode from cdns_role
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
> +{
> +	int ret = 0;
> +	u32 reg;
> +
> +	cdns->current_dr_mode = mode;
> +
> +	switch (mode) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		dev_info(cdns->dev, "Set controller to Gadget mode\n");

dev_dbg()?

> +		ret = cdns3_drd_switch_gadget(cdns, 1);
> +		break;
> +	case USB_DR_MODE_HOST:
> +		dev_info(cdns->dev, "Set controller to Host mode\n");

dev_dbg()

> +		ret = cdns3_drd_switch_host(cdns, 1);
> +		break;
> +	case USB_DR_MODE_OTG:
> +		dev_info(cdns->dev, "Set controller to OTG mode\n");

dev_dbg()

> +		if (cdns->version == CDNS3_CONTROLLER_V1) {
> +			reg = readl(&cdns->otg_v1_regs->override);
> +			reg |= OVERRIDE_IDPULLUP;
> +			writel(reg, &cdns->otg_v1_regs->override);
> +		} else {
> +			reg = readl(&cdns->otg_v0_regs->ctrl1);
> +			reg |= OVERRIDE_IDPULLUP_V0;
> +			writel(reg, &cdns->otg_v0_regs->ctrl1);
> +		}
> +

Don't you have to clear IDPULLUP when you switch to PERIPHERAL or HOST mode?

> +		/*
> +		 * Hardware specification says: "ID_VALUE must be valid within
> +		 * 50ms after idpullup is set to '1" so driver must wait
> +		 * 50ms before reading this pin.
> +		 */
> +		usleep_range(50000, 60000);
> +		break;
> +	default:
> +		cdns->current_dr_mode = USB_DR_MODE_UNKNOWN;
> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n", mode);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +int cdns3_get_id(struct cdns3 *cdns)
> +{
> +	int id;
> +
> +	id = readl(&cdns->otg_regs->sts) & OTGSTS_ID_VALUE;
> +	dev_dbg(cdns->dev, "OTG ID: %d", id);
> +	return id;
> +}
> +
> +int cdns3_is_host(struct cdns3 *cdns)
> +{
> +	if (cdns->current_dr_mode == USB_DR_MODE_HOST)
> +		return 1;

don't you have to return 0 if current_dr_mode == USB_DR_MODE_PERIPHERAL?

> +	else if (!cdns3_get_id(cdns))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +int cdns3_is_device(struct cdns3 *cdns)
> +{
> +	if (cdns->current_dr_mode == USB_DR_MODE_PERIPHERAL)
> +		return 1;

don't you have to return 0 if current_dr_mode == USB_DR_MODE_HOST?

> +	else if (cdns->current_dr_mode == USB_DR_MODE_OTG)
> +		if (cdns3_get_id(cdns))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +/**
> + * cdns3_otg_disable_irq - Disable all OTG interrupts
> + * @cdns: Pointer to controller context structure
> + */
> +static void cdns3_otg_disable_irq(struct cdns3 *cdns)
> +{
> +	writel(0, &cdns->otg_regs->ien);
> +}
> +
> +/**
> + * cdns3_otg_enable_irq - enable id and sess_valid interrupts
> + * @cdns: Pointer to controller context structure
> + */
> +static void cdns3_otg_enable_irq(struct cdns3 *cdns)
> +{
> +	writel(OTGIEN_ID_CHANGE_INT | OTGIEN_VBUSVALID_RISE_INT |
> +	       OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_regs->ien);
> +}
> +
> +/**
> + * cdns3_drd_switch_host - start/stop host
> + * @cdns: Pointer to controller context structure
> + * @on: 1 for start, 0 for stop
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_drd_switch_host(struct cdns3 *cdns, int on)
> +{
> +	int ret;
> +	u32 reg = OTGCMD_OTG_DIS;
> +
> +	/* switch OTG core */
> +	if (on) {
> +		writel(OTGCMD_HOST_BUS_REQ | reg, &cdns->otg_regs->cmd);
> +
> +		dev_dbg(cdns->dev, "Waiting for Host mode is turned on\n");
s/for/till

> +		ret = cdns3_handshake(&cdns->otg_regs->sts, OTGSTS_XHCI_READY,
> +				      OTGSTS_XHCI_READY, 100000);
> +
> +		if (ret)
> +			return ret;
> +	} else {
> +		usleep_range(30, 40);
> +		writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
> +		       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
> +		       &cdns->otg_regs->cmd);
> +		usleep_range(3000, 4000);

why do you need delays before and after the write?
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cdns3_drd_switch_gadget - start/stop gadget
> + * @cdns: Pointer to controller context structure
> + * @on: 1 for start, 0 for stop
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on)
> +{
> +	int ret;
> +	u32 reg = OTGCMD_OTG_DIS;
> +
> +	/* switch OTG core */
> +	if (on) {
> +		writel(OTGCMD_DEV_BUS_REQ | reg, &cdns->otg_regs->cmd);
> +
> +		dev_dbg(cdns->dev, "Waiting for Device mode is turned on\n");

s/for/till

> +
> +		ret = cdns3_handshake(&cdns->otg_regs->sts, OTGSTS_DEV_READY,
> +				      OTGSTS_DEV_READY, 100000);
> +
> +		if (ret)
> +			return ret;
> +	} else {
> +		/*
> +		 * driver should wait at least 10us after disabling Device
> +		 * before turning-off Device (DEV_BUS_DROP)
> +		 */
> +		usleep_range(20, 30);
> +		writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
> +		       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
> +		       &cdns->otg_regs->cmd);
> +		usleep_range(3000, 4000);

why do you need a delay after the write?

> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cdns3_init_otg_mode - initialize drd controller
> + * @cdns: Pointer to controller context structure
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_init_otg_mode(struct cdns3 *cdns)
> +{
> +	int ret = 0;
> +
> +	cdns3_otg_disable_irq(cdns);
> +	/* clear all interrupts */
> +	writel(~0, &cdns->otg_regs->ivect);
> +
> +	ret = cdns3_set_mode(cdns, USB_DR_MODE_OTG);
> +	if (ret)
> +		return ret;
> +
> +	if (cdns3_is_host(cdns))
> +		ret = cdns3_drd_switch_host(cdns, 1);
> +	else
> +		ret = cdns3_drd_switch_gadget(cdns, 1);
> +
> +	if (ret)
> +		return ret;
> +
> +	cdns3_otg_enable_irq(cdns);

Schedule switch workqueue to deal with updated ID state?

> +	return ret;
> +}
> +
> +/**
> + * cdns3_drd_update_mode - initialize mode of operation
> + * @cdns: Pointer to controller context structure
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +int cdns3_drd_update_mode(struct cdns3 *cdns)
> +{
> +	int ret = 0;
> +
> +	if (cdns->desired_dr_mode == cdns->current_dr_mode)
> +		return ret;
> +
> +	cdns3_drd_switch_gadget(cdns, 0);
> +	cdns3_drd_switch_host(cdns, 0);

Why are you stopping gadget/host here?
One or both of might not have been started.

> +
> +	switch (cdns->desired_dr_mode) {
> +	case USB_DR_MODE_PERIPHERAL:
> +		ret = cdns3_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
> +		break;
> +	case USB_DR_MODE_HOST:
> +		ret = cdns3_set_mode(cdns, USB_DR_MODE_HOST);
> +		break;
> +	case USB_DR_MODE_OTG:
> +		ret = cdns3_init_otg_mode(cdns);
> +		break;
> +	default:
> +		dev_err(cdns->dev, "Unsupported mode of operation %d\n",
> +			cdns->dr_mode);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * cdns3_drd_irq - interrupt handler for OTG events
> + *
> + * @irq: irq number for cdns3 core device
> + * @data: structure of cdns3
> + *
> + * Returns IRQ_HANDLED or IRQ_NONE
> + */
> +static irqreturn_t cdns3_drd_irq(int irq, void *data)
> +{
> +	irqreturn_t ret = IRQ_NONE;
> +	struct cdns3 *cdns = data;
> +	u32 reg;
> +
> +	if (cdns->dr_mode != USB_DR_MODE_OTG)
> +		return ret;
> +
> +	reg = readl(&cdns->otg_regs->ivect);
> +
> +	if (!reg)
> +		return ret;
> +
> +	if (reg & OTGIEN_ID_CHANGE_INT) {
> +		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
> +			cdns3_get_id(cdns));
> +
> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
> +
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	writel(~0, &cdns->otg_regs->ivect);
> +	return ret;
> +}
> +
> +int cdns3_drd_init(struct cdns3 *cdns)
> +{
> +	void __iomem *regs;
> +	int ret = 0;
> +	u32 state;
> +
> +	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	/* Detection of DRD version. Controller has been released
> +	 * in two versions. Both are similar, but they have same changes
> +	 * in register maps.
> +	 * The first register in old version is command register and it's read
> +	 * only, so driver should read 0 from it. On the other hand, in v1
> +	 * the first register contains device ID number which is not set to 0.
> +	 * Driver uses this fact to detect the proper version of
> +	 * controller.
> +	 */
> +	cdns->otg_v0_regs = regs;
> +	if (!readl(&cdns->otg_v0_regs->cmd)) {
> +		cdns->version  = CDNS3_CONTROLLER_V0;
> +		cdns->otg_v1_regs = NULL;
> +		cdns->otg_regs = regs;
> +		dev_info(cdns->dev, "DRD version v0 (%08x)\n",
> +			 readl(&cdns->otg_v0_regs->version));
> +	} else {
> +		cdns->otg_v0_regs = NULL;
> +		cdns->otg_v1_regs = regs;
> +		cdns->otg_regs = (void *)&cdns->otg_v1_regs->cmd;
> +		cdns->version  = CDNS3_CONTROLLER_V1;
> +		dev_info(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
> +			 readl(&cdns->otg_v1_regs->did),
> +			 readl(&cdns->otg_v1_regs->rid));
> +	}
> +
> +	state = OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
> +
> +	/* Update dr_mode according to STRAP configuration. */
> +	cdns->dr_mode = USB_DR_MODE_OTG;
> +	if (state == OTGSTS_STRAP_HOST) {
> +		dev_info(cdns->dev, "Controller strapped to HOST\n");
> +		cdns->dr_mode = USB_DR_MODE_HOST;
> +	} else if (state == OTGSTS_STRAP_GADGET) {
> +		dev_info(cdns->dev, "Controller strapped to PERIPHERAL\n");
> +		cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
> +	}
> +
> +	cdns->desired_dr_mode = cdns->dr_mode;
> +	cdns->current_dr_mode = USB_DR_MODE_UNKNOWN;
> +
> +	ret = devm_request_threaded_irq(cdns->dev, cdns->irq, cdns3_drd_irq,
> +					NULL, IRQF_SHARED,
> +					dev_name(cdns->dev), cdns);
> +
> +	if (ret)
> +		return ret;
> +
> +	state = readl(&cdns->otg_regs->sts);
> +	if (OTGSTS_OTG_NRDY(state) != 0) {
> +		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = cdns3_drd_update_mode(cdns);
> +
> +	return ret;
> +}
> +
> +int cdns3_drd_exit(struct cdns3 *cdns)
> +{
> +	return cdns3_drd_switch_host(cdns, 0);

Why only stopping host?

I think we need to stop active role, disable IRQ generation and free irq?

> +}

<snip>

> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> new file mode 100644
> index 000000000000..7f7f24ee3c4b
> --- /dev/null
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -0,0 +1,2003 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver - gadget side.
> + *
> + * Copyright (C) 2018 Cadence Design Systems.
> + * Copyright (C) 2017-2018 NXP
> + *
> + * Authors: Pawel Jez <pjez@cadence.com>,
> + *          Pawel Laszczak <pawell@cadence.com>
> + *	    Peter Chen <peter.chen@nxp.com>
> + */
> +

<snip>

> +
> +static void cdns3_gadget_disable(struct cdns3 *cdns)
> +{
> +	struct cdns3_device *priv_dev;
> +
> +	priv_dev = cdns->gadget_dev;
> +
> +	if (priv_dev->gadget_driver)
> +		priv_dev->gadget_driver->disconnect(&priv_dev->gadget);> +
> +	usb_gadget_disconnect(&priv_dev->gadget);
> +	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
> +}
> +
> +void cdns3_gadget_exit(struct cdns3 *cdns)
> +{
> +	struct cdns3_device *priv_dev;
> +
> +	priv_dev = cdns->gadget_dev;
> +
> +	cdns3_gadget_disable(cdns);
> +
> +	devm_free_irq(cdns->dev, cdns->irq, cdns);
> +
> +	pm_runtime_mark_last_busy(cdns->dev);
> +	pm_runtime_put_autosuspend(cdns->dev);
> +
> +	usb_del_gadget_udc(&priv_dev->gadget);
> +
> +	cdns3_free_all_eps(priv_dev);
> +
> +	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
> +			  priv_dev->setup_dma);
> +
> +	kfree(priv_dev->zlp_buf);
> +	kfree(priv_dev);
> +	cdns->gadget_dev = NULL;
> +}
> +
> +static int cdns3_gadget_start(struct cdns3 *cdns)
> +{
> +	struct cdns3_device *priv_dev;
> +	u32 max_speed;
> +	int ret;
> +
> +	priv_dev = kzalloc(sizeof(*priv_dev), GFP_KERNEL);
> +	if (!priv_dev)
> +		return -ENOMEM;
> +
> +	cdns->gadget_dev = priv_dev;
> +	priv_dev->sysdev = cdns->dev;
> +	priv_dev->dev = cdns->dev;
> +	priv_dev->regs = cdns->dev_regs;
> +
> +	max_speed = usb_get_maximum_speed(cdns->dev);
> +
> +	/* Check the maximum_speed parameter */
> +	switch (max_speed) {
> +	case USB_SPEED_FULL:
> +	case USB_SPEED_HIGH:
> +	case USB_SPEED_SUPER:
> +		break;
> +	default:
> +		dev_err(cdns->dev, "invalid maximum_speed parameter %d\n",
> +			max_speed);
> +		/* fall through */
> +	case USB_SPEED_UNKNOWN:
> +		/* default to superspeed */
> +		max_speed = USB_SPEED_SUPER;
> +		break;
> +	}
> +
> +	/* fill gadget fields */
> +	priv_dev->gadget.max_speed = max_speed;
> +	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
> +	priv_dev->gadget.ops = &cdns3_gadget_ops;
> +	priv_dev->gadget.name = "usb-ss-gadget";
> +	priv_dev->gadget.sg_supported = 1;
> +
> +	spin_lock_init(&priv_dev->lock);
> +	INIT_WORK(&priv_dev->pending_status_wq,
> +		  cdns3_pending_setup_status_handler);
> +
> +	/* initialize endpoint container */
> +	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
> +
> +	ret = cdns3_init_eps(priv_dev);
> +	if (ret) {
> +		dev_err(priv_dev->dev, "Failed to create endpoints\n");
> +		goto err1;
> +	}
> +
> +	/* allocate memory for setup packet buffer */
> +	priv_dev->setup_buf = dma_alloc_coherent(priv_dev->sysdev, 8,
> +						 &priv_dev->setup_dma, GFP_DMA);
> +	if (!priv_dev->setup_buf) {
> +		dev_err(priv_dev->dev, "Failed to allocate memory for SETUP buffer\n");
> +		ret = -ENOMEM;
> +		goto err2;
> +	}
> +
> +	priv_dev->dev_ver = readl(&priv_dev->regs->usb_cap6);
> +	dev_dbg(priv_dev->dev, "Device Controller version: %08x\n",
> +		readl(&priv_dev->regs->usb_cap6));
> +	dev_dbg(priv_dev->dev, "USB Capabilities:: %08x\n",
> +		readl(&priv_dev->regs->usb_cap1));
> +	dev_dbg(priv_dev->dev, "On-Chip memory cnfiguration: %08x\n",
> +		readl(&priv_dev->regs->usb_cap2));
> +
> +	priv_dev->zlp_buf = kzalloc(CDNS3_EP_ZLP_BUF_SIZE, GFP_KERNEL);
> +	if (!priv_dev->zlp_buf) {
> +		ret = -ENOMEM;
> +		goto err3;
> +	}
> +
> +	/* add USB gadget device */
> +	ret = usb_add_gadget_udc(priv_dev->dev, &priv_dev->gadget);
> +	if (ret < 0) {
> +		dev_err(priv_dev->dev,
> +			"Failed to register USB device controller\n");
> +		goto err4;
> +	}
> +
> +	return 0;
> +err4:
> +	kfree(priv_dev->zlp_buf);
> +err3:
> +	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup_buf,
> +			  priv_dev->setup_dma);
> +err2:
> +	cdns3_free_all_eps(priv_dev);
> +err1:
> +	cdns->gadget_dev = NULL;
> +	return ret;
> +}
> +
> +static int __cdns3_gadget_init(struct cdns3 *cdns)
> +{
> +	struct cdns3_device *priv_dev;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	ret = cdns3_gadget_start(cdns);
> +	if (ret)
> +		return ret;
> +
> +	priv_dev = cdns->gadget_dev;
> +	ret = devm_request_threaded_irq(cdns->dev, cdns->irq,
> +					cdns3_device_irq_handler,
> +					cdns3_device_thread_irq_handler,
> +					IRQF_SHARED, dev_name(cdns->dev), cdns);
> +	if (ret)
> +		goto err0;
> +
> +	pm_runtime_get_sync(cdns->dev);
pm_runtime_get_sync() should be done before cdns3_gadget_start()

> +	spin_lock_irqsave(&priv_dev->lock, flags);
> +	spin_unlock_irqrestore(&priv_dev->lock, flags);

Redundant spinlock usage?

> +	return 0;
> +err0:
> +	cdns3_gadget_exit(cdns);
> +	return ret;
> +}
> +
> +static int cdns3_gadget_suspend(struct cdns3 *cdns, bool do_wakeup)
> +{
> +	cdns3_gadget_disable(cdns);

Does this ensure gadget controller is stopped?

> +	return 0;
> +}
> +
> +static int cdns3_gadget_resume(struct cdns3 *cdns, bool hibernated)
> +{
> +	struct cdns3_device *priv_dev;
> +	unsigned long flags;
> +
> +	priv_dev = cdns->gadget_dev;
> +	spin_lock_irqsave(&priv_dev->lock, flags);
> +
> +	if (!priv_dev->gadget_driver) {
> +		spin_unlock_irqrestore(&priv_dev->lock, flags);
> +		return 0;
> +	}
> +
> +	cdns3_gadget_config(priv_dev);
> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
> +	return 0;
> +}
> +
> +/**
> + * cdns3_gadget_init - initialize device structure
> + *
> + * cdns: cdns3 instance
> + *
> + * This function initializes the gadget.
> + */
> +int cdns3_gadget_init(struct cdns3 *cdns)
> +{
> +	struct cdns3_role_driver *rdrv;
> +
> +	rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
> +	if (!rdrv)
> +		return -ENOMEM;
> +
> +	rdrv->start	= __cdns3_gadget_init;
> +	rdrv->stop	= cdns3_gadget_exit;
> +	rdrv->suspend	= cdns3_gadget_suspend;
> +	rdrv->resume	= cdns3_gadget_resume;
> +	rdrv->state	= CDNS3_ROLE_STATE_INACTIVE;
> +	rdrv->name	= "gadget";
> +	cdns->roles[CDNS3_ROLE_GADGET] = rdrv;
> +
> +	return 0;
> +}

<snip>

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
