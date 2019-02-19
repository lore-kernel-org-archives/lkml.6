Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD57C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B97921736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550582651;
	bh=Gc73FDM+M+CK70ZDOmueVHyU44Jqcc6651BAjrZzDUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c9tkH0nkFPaNSiCTl6vHBn802b3uv8WsUSqII2QEpZiZdP/aVJl3/9hVmi+dz/cYV
	 Y4CYDekjSF9/BaDMlrkjVz5dpEP6j+4eWlHGtnvrsxL1KjKIzve1jQ4ULvTgqgLFEV
	 2owK+WzFV0i4rnztzwLf7XmicUZiwYcQQeqTqvVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfBSNYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:24:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbfBSNYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:24:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D57092146E;
        Tue, 19 Feb 2019 13:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550582646;
        bh=Gc73FDM+M+CK70ZDOmueVHyU44Jqcc6651BAjrZzDUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VcqxhIwlh1Re4X1fHHoTcA+1wdjw7uv2WGRwI2tB+d9usgTkeRZf9xo6el8lZCIax
         Tx46345ENiU6/idv3f5e5803DvSPdvgR+di11at32EuT7qJPlOu7TzA6PGnUdc9Kam
         zmdtsFy5CTlAwLdxQBEJe7rNXhmXWKdoUWASSg0Y=
Date:   Tue, 19 Feb 2019 14:24:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, felipe.balbi@linux.intel.com,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        hdegoede@redhat.com, heikki.krogerus@linux.intel.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, jbergsagel@ti.com, nsekhar@ti.com,
        nm@ti.com, sureshp@cadence.com, peter.chen@nxp.com,
        kurahul@cadence.com
Subject: Re: [PATCH v4 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Message-ID: <20190219132403.GC20719@kroah.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
 <1550173514-23573-6-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550173514-23573-6-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 07:45:13PM +0000, Pawel Laszczak wrote:
> This patch introduce new Cadence USBSS DRD driver to linux kernel.

Nit, "Linux" :)

> The Cadence USBSS DRD Driver is a highly configurable IP Core whichi

"whichi"?

> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.
> 
> The current driver has been validated with FPGA burned. We have support

I can not parse that sentance, sorry.  what does "with FPGA burned"
mean?

> for PCIe bus, which is used on FPGA prototyping.
> 
> The host side of USBSS-DRD controller is compliance with XHCI

"compliant"

> specification, so it works with standard XHCI linux driver.

"Linux"

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

You use tabs here, but not tabs in the other options.  Please be
uniform.


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

PCI_VENDOR_ID_CDNS is already in pci_ids.h, no need to define it again
here.

> +#define CDNS_DEVICE_ID 0x0100

No tabs?

> +
> +/**

kerneldoc is great, but for static functions?  Who is pulling these into
documentation?

If not, then no need for that format at all.

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

No need to print an error again after kzalloc already printed an error.

> +		return -ENOMEM;

Did you forget to disable the pci device?

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

No disabling of the device?

Anyway, why are you creating a platform device when you have a real PCI
device?  That seems odd, and an abuse of the platform code.  What's
wrong with your real PCI device here?


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

What is someone supposed to do with this?

> +	return cdns->roles[cdns->role];
> +}
> +
> +static int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
> +{
> +	int ret;
> +
> +	if (WARN_ON(role >= CDNS3_ROLE_END))

Same here, how can this happen?  What can I do if it does?

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

Again, why?

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

Do you clean up from the host init here properly?   It's hard to tell.

> +		}
> +	}
> +
> +	cdns->desired_dr_mode = dr_mode;
> +	cdns->dr_mode = dr_mode;
> +	/*
> +	 * dr_mode could be change so DRD must update controller
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

thanks,

greg k-h
