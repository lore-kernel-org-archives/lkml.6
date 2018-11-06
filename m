Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1706DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25FA20685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25FA20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbeKFXo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:44:26 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57182 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbeKFXo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:44:26 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA6EImAP014382;
        Tue, 6 Nov 2018 08:18:48 -0600
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA6EIm65071540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 08:18:48 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 08:18:48 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 08:18:47 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA6EIjlv009441;
        Tue, 6 Nov 2018 08:18:45 -0600
Subject: Re: [RFC PATCH v1 03/14] usb:cdns3: Driver initialization code.
To:     Pawel Laszczak <pawell@cadence.com>, <gregkh@linuxfoundation.org>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
 <1541267487-3664-4-git-send-email-pawell@cadence.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BE1A2C4.7030802@ti.com>
Date:   Tue, 6 Nov 2018 16:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1541267487-3664-4-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/18 19:51, Pawel Laszczak wrote:
> Patch adds core.c and core.h file that implements initialization
> of platform driver and adds function responsible for selecting,
> switching and running appropriate Device/Host mode.
> 
> Patch also adds gadget.c, host.c, gadget-export.h, host-export.h.
> These files contains templates functions used during initialization.
> The implementation will be added in next patches.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/Kconfig         |  20 ++
>  drivers/usb/cdns3/Makefile        |   4 +
>  drivers/usb/cdns3/core.c          | 373 ++++++++++++++++++++++++++++++
>  drivers/usb/cdns3/core.h          |  88 +++++++
>  drivers/usb/cdns3/gadget-export.h |  27 +++
>  drivers/usb/cdns3/gadget.c        |  36 +++
>  drivers/usb/cdns3/host-export.h   |  30 +++
>  drivers/usb/cdns3/host.c          |  28 +++
>  8 files changed, 606 insertions(+)
>  create mode 100644 drivers/usb/cdns3/core.c
>  create mode 100644 drivers/usb/cdns3/core.h
>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>  create mode 100644 drivers/usb/cdns3/gadget.c
>  create mode 100644 drivers/usb/cdns3/host-export.h
>  create mode 100644 drivers/usb/cdns3/host.c
> 
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> index 888458372adb..5f88a4932e58 100644
> --- a/drivers/usb/cdns3/Kconfig
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -10,6 +10,26 @@ config USB_CDNS3
>  
>  if USB_CDNS3
>  
> +config USB_CDNS3_GADGET
> +	bool "Cadence USB3 device controller"
> +	depends on USB_GADGET
> +	help
> +	  Say Y here to enable device controller functionality of the
> +	  cadence USBSS-DEV driver.
> +
> +	  This controller support FF, HS and SS mode. It doeasn't support
> +	  LS and SSP mode
> +
> +config USB_CDNS3_HOST
> +	bool "Cadence USB3 host controller"
> +	depends on USB_XHCI_HCD
> +	help
> +	  Say Y here to enable host controller functionality of the
> +	  cadence driver.
> +
> +	  Host controller is compliance with XHCI so it will use
> +	  standard XHCI driver.
> +

Is it better to split this patch into 3 parts?
1) host support
2) gadget support
3) DRD support (along with patch 4)

>  config USB_CDNS3_PCI_WRAP
>  	tristate "PCIe-based Platforms"
>  	depends on USB_PCI && ACPI
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index dcdd62003c6a..083676c7748f 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -1,3 +1,7 @@
> +obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
>  
> +cdns3-y					:= core.o
> +cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o
> +cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
>  cdns3-pci-y		 		:= cdns3-pci-wrap.o
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> new file mode 100644
> index 000000000000..727136235957
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.c
> @@ -0,0 +1,373 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2018 Cadence.
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
> +
> +#include "gadget.h"
> +#include "core.h"
> +#include "host-export.h"
> +#include "gadget-export.h"
> +
> +static inline struct cdns3_role_driver *cdns3_role(struct cdns3 *cdns)

how about naming this to cnds3_get_current_role_driver() ?

> +{
> +	WARN_ON(cdns->role >= CDNS3_ROLE_END || !cdns->roles[cdns->role]);
> +	return cdns->roles[cdns->role];
> +}
> +
> +static inline int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
> +{
> +	int ret;
> +
> +	if (role >= CDNS3_ROLE_END)
> +		return 0;
> +
> +	if (!cdns->roles[role])
> +		return -ENXIO;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->role = role;

You are changing the role here. Shouldn't it just start whatever role is already in cdns->role?
And you have a cnds3_set_role() function to set role.

> +	ret = cdns->roles[role]->start(cdns);
> +	mutex_unlock(&cdns->mutex);
> +	return ret;
> +}
> +
> +static inline void cdns3_role_stop(struct cdns3 *cdns)
> +{
> +	enum cdns3_roles role = cdns->role;
> +
> +	if (role == CDNS3_ROLE_END)
> +		return;
> +
> +	mutex_lock(&cdns->mutex);
> +	cdns->roles[role]->stop(cdns);
> +	cdns->role = CDNS3_ROLE_END;
> +	mutex_unlock(&cdns->mutex);
> +}
> +
> +static void cdns3_set_role(struct cdns3 *cdns, enum cdns3_roles role)
> +{
> +	if (role == CDNS3_ROLE_END)
> +		return;
> +
> +	if (role == CDNS3_ROLE_HOST) {
> +		//TODO: set host role
> +	} else { /* gadget mode */
> +		//TODO: set device role
> +	}
> +}
> +
> +static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
> +{
> +	if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
> +		//TODO: implements selecting device/host mode
> +		return CDNS3_ROLE_HOST;
> +	}
> +	return cdns->roles[CDNS3_ROLE_HOST]
> +		? CDNS3_ROLE_HOST
> +		: CDNS3_ROLE_GADGET;
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
> +	enum usb_dr_mode dr_mode;
> +
> +	dr_mode = usb_get_dr_mode(dev);
> +	cdns->role = CDNS3_ROLE_END;
> +
> +	if (dr_mode == USB_DR_MODE_UNKNOWN) {
> +		if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
> +		    IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> +			dr_mode = USB_DR_MODE_OTG;
> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> +			dr_mode = USB_DR_MODE_HOST;
> +		else if (IS_ENABLED(CONFIG_USB_CDNS3_DEVICE))
> +			dr_mode = USB_DR_MODE_PERIPHERAL;
> +	}
> +
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
> +		if (cdns3_host_init(cdns))
> +			dev_info(dev, "doesn't support host\n");
> +	}
> +
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
> +		if (cdns3_gadget_init(cdns))
> +			dev_info(dev, "doesn't support gadget\n");
> +	}
> +
> +	if (!cdns->roles[CDNS3_ROLE_HOST] && !cdns->roles[CDNS3_ROLE_GADGET]) {
> +		dev_err(dev, "no supported roles\n");
> +		return -ENODEV;
> +	}
> +
> +	cdns->dr_mode = dr_mode;
> +	return 0;
> +}
> +
> +/**
> + * cdns3_irq - interrupt handler for cdns3 core device
> + *
> + * @irq: irq number for cdns3 core device
> + * @data: structure of cdns3
> + *
> + * Returns IRQ_HANDLED or IRQ_NONE
> + */
> +static irqreturn_t cdns3_irq(int irq, void *data)
> +{
> +	struct cdns3 *cdns = data;
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	if (cdns->in_lpm) {
> +		disable_irq_nosync(cdns->irq);
> +		cdns->wakeup_int = true;
> +		pm_runtime_get(cdns->dev);

where is the balancing pm_runtime_put() for this?

> +		return IRQ_HANDLED;
> +	}
> +
> +	/* Handle device/host interrupt */
> +	if (cdns->role != CDNS3_ROLE_END)
> +		ret = cdns3_role(cdns)->irq(cdns);
> +
> +	return ret;
> +}
> +
> +static void cdns3_remove_roles(struct cdns3 *cdns)
> +{
> +	cdns3_gadget_remove(cdns);
> +	cdns3_host_remove(cdns);
> +}
> +
> +static int cdns3_do_role_switch(struct cdns3 *cdns, enum cdns3_roles role)
> +{
> +	enum cdns3_roles current_role;
> +	int ret = 0;
> +
> +	if (cdns->role == role)
> +		return 0;
> +
> +	pm_runtime_get_sync(cdns->dev);
> +	current_role = cdns->role;
> +	cdns3_role_stop(cdns);
> +
> +	if (role == CDNS3_ROLE_END) {
> +		pm_runtime_put_sync(cdns->dev);
> +		return 0;
> +	}
> +
> +	dev_dbg(cdns->dev, "Switching role");
> +
> +	cdns3_set_role(cdns, role);
> +	ret = cdns3_role_start(cdns, role);
> +	if (ret) {
> +		/* Back to current role */
> +		dev_err(cdns->dev, "set %d has failed, back to %d\n",
> +			role, current_role);
> +		cdns3_set_role(cdns, current_role);
> +		ret = cdns3_role_start(cdns, current_role);
> +	}
> +
> +	pm_runtime_put_sync(cdns->dev);
> +	return ret;
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
> +	struct cdns3 *cdns;
> +	bool device, host;
> +
> +	cdns = container_of(work, struct cdns3, role_switch_wq);
> +
> +	//TODO: implements this functions.
> +	//host = cdns3_is_host(cdns);
> +	//device = cdns3_is_device(cdns);
> +	host = 1;
> +	device = 0;
> +
> +	if (host) {
> +		if (cdns->roles[CDNS3_ROLE_HOST])
> +			cdns3_do_role_switch(cdns, CDNS3_ROLE_HOST);
> +		return;
> +	}
> +
> +	if (device)
> +		cdns3_do_role_switch(cdns, CDNS3_ROLE_GADGET);
> +	else
> +		cdns3_do_role_switch(cdns, CDNS3_ROLE_END);
> +}

All role switching code can come as part of DRD driver.

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
> +	/*
> +	 * Request memory region
> +	 * region-0: xHCI
> +	 * region-1: Peripheral
> +	 * region-2: OTG registers
> +	 */

Here you are not checking for Kconfig options before getting resources which is the right thing.
However this will be broken if you don't get rid of the Kconfig checks when you populate the
resources in patch 1.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	regs = devm_ioremap_resource(dev, res);
> +
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +	cdns->xhci_regs = regs;
> +	cdns->xhci_res = res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +	cdns->dev_regs	= regs;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +	cdns->otg_regs = regs;
> +
> +	mutex_init(&cdns->mutex);
> +
> +	ret = cdns3_core_init_role(cdns);
> +	if (ret)
> +		goto err2;
> +
> +	INIT_WORK(&cdns->role_switch_wq, cdns3_role_switch);
> +	if (ret)
> +		goto err3;
> +
> +	if (ret)
> +		goto err3;
> +
> +	cdns->role = cdns3_get_role(cdns);
> +	cdns3_set_role(cdns, cdns->role);
> +	ret = cdns3_role_start(cdns, cdns->role);
> +	if (ret) {
> +		dev_err(dev, "can't start %s role\n", cdns3_role(cdns)->name);
> +		goto err3;
> +	}

What exactly does role_start have to do?

Can you start the role before requesting irq?

> +
> +	ret = devm_request_irq(dev, cdns->irq, cdns3_irq, IRQF_SHARED,
> +			       dev_name(dev), cdns);
> +
> +	if (ret)
> +		goto err4;
> +
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
> +err4:
> +	cdns3_role_stop(cdns);
> +err3:
> +	cdns3_remove_roles(cdns);
> +err2:
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
> +	cdns3_remove_roles(cdns);

Shouldn't the order be

pm_runtime_get_sync();
cdns3_remove_roles();
pm_runtime_put_noidle();
pm_runtime_disable();

> +	usb_phy_shutdown(cdns->usbphy);

you didn't call usb_phy_init() anywhere.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver cdns3_driver = {
> +	.probe		= cdns3_probe,
> +	.remove		= cdns3_remove,
> +	.driver		= {
> +		.name	= "cdns-usb3",
> +	},
> +};
> +
> +static int __init cdns3_driver_platform_register(void)
> +{
> +	cdns3_host_driver_init();

Why is a call to host_driver_init() required?

> +	return platform_driver_register(&cdns3_driver);
> +}
> +module_init(cdns3_driver_platform_register);
> +
> +static void __exit cdns3_driver_platform_unregister(void)
> +{
> +	platform_driver_unregister(&cdns3_driver);
> +}
> +module_exit(cdns3_driver_platform_unregister);
> +
> +MODULE_ALIAS("platform:cdns3");
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> new file mode 100644
> index 000000000000..e7159c474308
> --- /dev/null
> +++ b/drivers/usb/cdns3/core.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2017 NXP
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
> +	CDNS3_ROLE_OTG,

Why is OTG after END?
Does OTG have a role driver as well? If not it must not come here. It is a mode, not a role.

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
> + */
> +struct cdns3_role_driver {
> +	int (*start)(struct cdns3 *cdns);
> +	void (*stop)(struct cdns3 *cdns);
> +	int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
> +	int (*resume)(struct cdns3 *cdns, bool hibernated);
> +	irqreturn_t (*irq)(struct cdns3 *cdns);
> +	const char *name;
> +};
> +
> +#define CDNS3_NUM_OF_CLKS	5
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
> + * @usbphy: usbphy for this controller
> + * @role_switch_wq: work queue item for role switch
> + * @in_lpm: the controller in low power mode
> + * @wakeup_int: the wakeup interrupt
> + * @mutex: the mutex for concurrent code at driver
> + * @dr_mode: requested mode of operation
> + * @current_dr_role: current role of operation when in dual-role mode
> + * @desired_dr_role: desired role of operation when in dual-role mode
> + * @root: debugfs root folder pointer
> + */
> +struct cdns3 {
> +	struct device			*dev;
> +	void __iomem			*xhci_regs;
> +	struct resource			*xhci_res;
> +	struct cdns3_usb_regs __iomem	*dev_regs;
> +	struct cdns3_otg_regs		*otg_regs;
> +	int irq;
> +	struct cdns3_role_driver	*roles[CDNS3_ROLE_END];
> +	enum cdns3_roles		role;
> +	struct device			*host_dev;
> +	struct device			*gadget_dev;
> +	struct usb_phy			*usbphy;
> +	struct work_struct		role_switch_wq;
> +	int				in_lpm:1;
> +	int				wakeup_int:1;
> +	/* mutext used in workqueue*/
> +	struct mutex			mutex;
> +	enum usb_dr_mode		dr_mode;
> +	enum usb_dr_mode		current_dr_mode;
> +	enum usb_dr_mode		desired_role;
> +	struct dentry			*root;
> +};
> +
> +#endif /* __LINUX_CDNS3_CORE_H */
> diff --git a/drivers/usb/cdns3/gadget-export.h b/drivers/usb/cdns3/gadget-export.h
> new file mode 100644
> index 000000000000..257e5e0eef31
> --- /dev/null
> +++ b/drivers/usb/cdns3/gadget-export.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Driver -Gadget Export APIs
> + *
> + * Copyright (C) 2017 NXP
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + */
> +#ifndef __LINUX_CDNS3_GADGET_EXPORT
> +#define __LINUX_CDNS3_GADGET_EXPORT
> +
> +#ifdef CONFIG_USB_CDNS3_GADGET
> +
> +int cdns3_gadget_init(struct cdns3 *cdns);
> +void cdns3_gadget_remove(struct cdns3 *cdns);
> +#else
> +
> +static inline int cdns3_gadget_init(struct cdns3 *cdns)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline void cdns3_gadget_remove(struct cdns3 *cdns) { }
> +
> +#endif
> +
> +#endif /* __LINUX_CDNS3_GADGET_EXPORT */
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> new file mode 100644
> index 000000000000..41ce696719d7
> --- /dev/null
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver - gadget side.
> + *
> + * Copyright (C) 2018 Cadence Design Systems.
> + * Copyright (C) 2017 NXP
> + *
> + * Authors: Pawel Jez <pjez@cadence.com>,
> + *          Pawel Laszczak <pawell@cadence.com>
> + *	    Peter Chen <peter.chen@nxp.com>
> + */
> +
> +#include "core.h"
> +
> +/**
> + * cdns3_gadget_remove: parent must call this to remove UDC
> + *
> + * cdns: cdns3 instance
> + */
> +void cdns3_gadget_remove(struct cdns3 *cdns)
> +{
> +	//TODO: implements this function
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
> +	//TODO: implements this function
> +	return 0;
> +}
> diff --git a/drivers/usb/cdns3/host-export.h b/drivers/usb/cdns3/host-export.h
> new file mode 100644
> index 000000000000..f8f3b230b472
> --- /dev/null
> +++ b/drivers/usb/cdns3/host-export.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBSS DRD Driver -Host Export APIs
> + *
> + * Copyright (C) 2017 NXP
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + */
> +#ifndef __LINUX_CDNS3_HOST_EXPORT
> +#define __LINUX_CDNS3_HOST_EXPORT
> +
> +#ifdef CONFIG_USB_CDNS3_HOST
> +
> +int cdns3_host_init(struct cdns3 *cdns);
> +void cdns3_host_remove(struct cdns3 *cdns);
> +void cdns3_host_driver_init(void);

why is cdns3_host_driver_init() required?

> +
> +#else
> +
> +static inline int cdns3_host_init(struct cdns3 *cdns)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline void cdns3_host_remove(struct cdns3 *cdns) { }
> +static inline void cdns3_host_driver_init(void) {}
> +
> +#endif /* CONFIG_USB_CDNS3_HOST */
> +
> +#endif /* __LINUX_CDNS3_HOST_EXPORT */
> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> new file mode 100644
> index 000000000000..37300985e2d6
> --- /dev/null
> +++ b/drivers/usb/cdns3/host.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver - host side
> + *
> + * Copyright (C) 2018 Cadence Design Systems.
> + * Copyright (C) 2018 NXP
> + *
> + * Authors: Peter Chen <peter.chen@nxp.com>
> + *	    Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include "core.h"
> +
> +int cdns3_host_init(struct cdns3 *cdns)
> +{
> +	//TODO: implements this function
> +	return 0;
> +}
> +
> +void cdns3_host_remove(struct cdns3 *cdns)
> +{
> +  //TODO: implements this function
> +}
> +
> +void __init cdns3_host_driver_init(void)
> +{
> +	//TODO: implements this function
> +}
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
