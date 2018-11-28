Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97265C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E682081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bb4cl1ZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E682081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeK1Wfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:35:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45742 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeK1Wfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:35:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wASBYAg2064624;
        Wed, 28 Nov 2018 05:34:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543404850;
        bh=17Y8UiWEuQkFJE3aNBiS1u5lA1A4pMFg6zjLpNMJtT4=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=bb4cl1ZIj7ZXJzSSdOTV4EXbAvYXSHkfCW7HwR8BhKvwumhZKpCXzgsal+U1Xs1Fw
         YzJLSfoxWXUmqUGWl9Nzu17xvUNVRLzYvsQhSEGk/YRvlcTNn7M6dI96aWdLtc6dP+
         TuKkUKHSsJ4M1ZGT6gGdvMOBI5CCbZvTYnpoeACM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wASBYA6v010881
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 05:34:10 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 28
 Nov 2018 05:34:10 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 28 Nov 2018 05:34:10 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wASBY6IJ018558;
        Wed, 28 Nov 2018 05:34:07 -0600
Subject: Re: [RFC PATCH v2 07/15] usb:cdns3: Adds Device mode support -
 initialization.
To:     Pawel Laszczak <pawell@cadence.com>, <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-8-git-send-email-pawell@cadence.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFE7D2E.7030702@ti.com>
Date:   Wed, 28 Nov 2018 13:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1542535751-16079-8-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Felipe.

Pawel,

Please copy Felipe Balbi as he maintains the USB gadget stack.

On 18/11/18 12:09, Pawel Laszczak wrote:
> Patch implements a set of functions responsible for initialization,
> configuration, starting and stopping device mode.
> This patch also adds new ep0.c that holds all functions related
> to endpoint 0.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/Kconfig         |  10 +
>  drivers/usb/cdns3/Makefile        |   1 +
>  drivers/usb/cdns3/core.c          |   5 +-
>  drivers/usb/cdns3/ep0.c           | 105 ++++++++
>  drivers/usb/cdns3/gadget-export.h |  27 +++
>  drivers/usb/cdns3/gadget.c        | 390 ++++++++++++++++++++++++++++++
>  drivers/usb/cdns3/gadget.h        |   4 +
>  7 files changed, 541 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/cdns3/ep0.c
>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>  create mode 100644 drivers/usb/cdns3/gadget.c
> 
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> index d92bc3d68eb0..b7d71b5c4f60 100644
> --- a/drivers/usb/cdns3/Kconfig
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -10,6 +10,16 @@ config USB_CDNS3
>  
>  if USB_CDNS3
>  
> +config USB_CDNS3_GADGET
> +        bool "Cadence USB3 device controller"
> +        depends on USB_GADGET
> +        help
> +          Say Y here to enable device controller functionality of the
> +          cadence USBSS-DEV driver.
> +
> +          This controller support FF, HS and SS mode. It doeasn't support

s/support/supports
s/doeasn't/doesn't

> +          LS and SSP mode
> +
>  config USB_CDNS3_HOST
>          bool "Cadence USB3 host controller"
>          depends on USB_XHCI_HCD
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index 976117ba67ff..bea6173bf37f 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -2,5 +2,6 @@ obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
>  
>  cdns3-y					:= core.o drd.o
> +cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o
>  cdns3-$(CONFIG_USB_CDNS3_HOST)          += host.o
>  cdns3-pci-y		 		:= cdns3-pci-wrap.o
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 4cb820be9ff3..1fa233415901 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -18,6 +18,7 @@
>  #include "gadget.h"
>  #include "core.h"
>  #include "host-export.h"
> +#include "gadget-export.h"
>  #include "drd.h"
>  
>  static inline struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
> @@ -104,7 +105,8 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>  	}
>  
>  	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
> -		//TODO: implements device initialization
> +		if (cdns3_gadget_init(cdns))
> +			dev_info(dev, "doesn't support gadget\n");

dev_err() and we should should error out with error code returned by cdns3_gadget_init().

>  	}
>  
>  	if (!cdns->roles[CDNS3_ROLE_HOST] && !cdns->roles[CDNS3_ROLE_GADGET]) {
> @@ -144,6 +146,7 @@ static irqreturn_t cdns3_irq(int irq, void *data)
>  
>  static void cdns3_remove_roles(struct cdns3 *cdns)
>  {

if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL)

> +	cdns3_gadget_remove(cdns);
>  	cdns3_host_remove(cdns);
>  }
>  
> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
> new file mode 100644
> index 000000000000..c08d02665f9d
> --- /dev/null
> +++ b/drivers/usb/cdns3/ep0.c
> @@ -0,0 +1,105 @@
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
> +#include "gadget.h"
> +
> +static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc = {
> +	.bLength = USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType = USB_DT_ENDPOINT,
> +	.bmAttributes =	USB_ENDPOINT_XFER_CONTROL,
> +};
> +
> +static void cdns3_prepare_setup_packet(struct cdns3_device *priv_dev)
> +{
> +	//TODO: Implements this function
> +}
> +
> +/**
> + * cdns3_ep0_config - Configures default endpoint
> + * @priv_dev: extended gadget object
> + *
> + * Functions sets parameters: maximal packet size and enables interrupts
> + */
> +void cdns3_ep0_config(struct cdns3_device *priv_dev)
> +{
> +	struct cdns3_usb_regs __iomem *regs;
> +	u32 max_packet_size = 64;
> +
> +	regs = priv_dev->regs;
> +
> +	if (priv_dev->gadget.speed == USB_SPEED_SUPER)
> +		max_packet_size = 512;

is gadget.speed known at this point? I think it will only be known after a connection
is made.

> +
> +	if (priv_dev->ep0_request) {
> +		list_del_init(&priv_dev->ep0_request->list);
> +		priv_dev->ep0_request = NULL;
> +	}
> +
> +	priv_dev->gadget.ep0->maxpacket = max_packet_size;
> +	cdns3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(max_packet_size);
> +
> +	/* init ep out */
> +	cdns3_select_ep(priv_dev, USB_DIR_OUT);
> +
> +	writel(EP_CFG_ENABLE | EP_CFG_MAXPKTSIZE(max_packet_size),
> +	       &regs->ep_cfg);
> +
> +	writel(EP_STS_EN_SETUPEN | EP_STS_EN_DESCMISEN | EP_STS_EN_TRBERREN,
> +	       &regs->ep_sts_en);
> +
> +	/* init ep in */
> +	cdns3_select_ep(priv_dev, USB_DIR_IN);
> +
> +	writel(EP_CFG_ENABLE | EP_CFG_MAXPKTSIZE(max_packet_size),
> +	       &regs->ep_cfg);
> +
> +	writel(EP_STS_EN_SETUPEN | EP_STS_EN_TRBERREN, &regs->ep_sts_en);
> +
> +	cdns3_set_register_bit(&regs->usb_conf, USB_CONF_U1DS | USB_CONF_U2DS);
> +	cdns3_prepare_setup_packet(priv_dev);

What happens if gadget.speed is USB_SPEED_SUPER, but was connected to a high-speed host?
Are you updating the max_packet_size on connection done?

> +}
> +
> +/**
> + * cdns3_init_ep0 Initializes software endpoint 0 of gadget
> + * @cdns3: extended gadget object
> + *
> + * Returns 0 on success, error code elsewhere
> + */
> +int cdns3_init_ep0(struct cdns3_device *priv_dev)
> +{
> +	struct cdns3_endpoint *ep0;
> +
> +	ep0 = devm_kzalloc(&priv_dev->dev, sizeof(struct cdns3_endpoint),
> +			   GFP_KERNEL);
> +
> +	if (!ep0)
> +		return -ENOMEM;
> +
> +	ep0->cdns3_dev = priv_dev;
> +	sprintf(ep0->name, "ep0");
> +
> +	/* fill linux fields */
> +	//TODO: implements cdns3_gadget_ep0_ops object
> +	//ep0->endpoint.ops = &cdns3_gadget_ep0_ops;
> +	ep0->endpoint.maxburst = 1;
> +	usb_ep_set_maxpacket_limit(&ep0->endpoint, ENDPOINT0_MAX_PACKET_LIMIT);
> +	ep0->endpoint.address = 0;
> +	ep0->endpoint.caps.type_control = 1;
> +	ep0->endpoint.caps.dir_in = 1;
> +	ep0->endpoint.caps.dir_out = 1;
> +	ep0->endpoint.name = ep0->name;
> +	ep0->endpoint.desc = &cdns3_gadget_ep0_desc;
> +	priv_dev->gadget.ep0 = &ep0->endpoint;
> +	INIT_LIST_HEAD(&ep0->request_list);
> +
> +	return 0;
> +}
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
> index 000000000000..376b68b13d1b
> --- /dev/null
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -0,0 +1,390 @@
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
> +#include <linux/dma-mapping.h>
> +#include <linux/usb/gadget.h>
> +
> +#include "core.h"
> +#include "gadget-export.h"
> +#include "gadget.h"
> +
> +/**
> + * cdns3_set_register_bit - set bit in given register.
> + * @ptr: address of device controller register to be read and changed
> + * @mask: bits requested to set
> + */
> +void cdns3_set_register_bit(void __iomem *ptr, u32 mask)
> +{
> +	mask = readl(ptr) | mask;
> +	writel(mask, ptr);
> +}

static inline?
I'd get rid of this function if possible. You are using it only once
and it is easier to read code if setting the bitmask is done plainly
instead of hiding it behind a function.

> +
> +/**
> + * select_ep - selects endpoint
> + * @priv_dev:  extended gadget object
> + * @ep: endpoint address
> + */
> +void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep)
> +{
> +	if (priv_dev->selected_ep == ep)
> +		return;

I didn't understand the purpose of this function. You can only select the EP once?

> +
> +	dev_dbg(&priv_dev->dev, "Ep sel: 0x%02x\n", ep);

You should move to use trace-points instead of dev_dbg.

> +	priv_dev->selected_ep = ep;
> +	writel(ep, &priv_dev->regs->ep_sel);
> +}
> +
> +/**
> + * cdns3_irq_handler - irq line interrupt handler
> + * @cdns: cdns3 instance
> + *
> + * Returns IRQ_HANDLED when interrupt raised by USBSS_DEV,
> + * IRQ_NONE when interrupt raised by other device connected
> + * to the irq line
> + */
> +static irqreturn_t cdns3_irq_handler_thread(struct cdns3 *cdns)
> +{
> +	irqreturn_t ret = IRQ_NONE;
> +	//TODO: implements this function
> +	return ret;
> +}
> +
> +static void cdns3_gadget_config(struct cdns3_device *priv_dev)
> +{
> +	struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
> +
> +	cdns3_ep0_config(priv_dev);
> +
> +	/* enable interrupts for endpoint 0 (in and out) */
> +	writel(EP_IEN_EP_OUT0 | EP_IEN_EP_IN0, &regs->ep_ien);
> +
> +	/* enable generic interrupt*/
> +	writel(USB_IEN_INIT, &regs->usb_ien);
> +	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
> +	writel(USB_CONF_DMULT, &regs->usb_conf);
> +	writel(USB_CONF_DEVEN, &regs->usb_conf);

If you are enabling interrupts in this patch you should handle them in the ISR.

> +}
> +
> +/**
> + * cdns3_init_ep Initializes software endpoints of gadget
> + * @cdns3: extended gadget object
> + *
> + * Returns 0 on success, error code elsewhere
> + */
> +static int cdns3_init_ep(struct cdns3_device *priv_dev)
> +{
> +	u32 ep_enabled_reg, iso_ep_reg;
> +	struct cdns3_endpoint *priv_ep;
> +	int found_endpoints = 0;
> +	int ep_dir, ep_number;
> +	u32 ep_mask;
> +	int i;
> +
> +	/* Read it from USB_CAP3 to USB_CAP5 */
> +	ep_enabled_reg = readl(&priv_dev->regs->usb_cap3);
> +	iso_ep_reg = readl(&priv_dev->regs->usb_cap4);
> +
> +	dev_dbg(&priv_dev->dev, "Initializing non-zero endpoints\n");
> +
> +	for (i = 0; i < USB_SS_ENDPOINTS_MAX_COUNT; i++) {

CDNS3_USB_SS_ENDPOINTS_MAX_COUNT

> +		ep_number = (i / 2) + 1;
> +		ep_dir = i % 2;
> +		ep_mask = BIT((16 * ep_dir) + ep_number);
> +
> +		if (!(ep_enabled_reg & ep_mask))
> +			continue;
> +
> +		priv_ep = devm_kzalloc(&priv_dev->dev, sizeof(*priv_ep),
> +				       GFP_KERNEL);
> +		if (!priv_ep)
> +			return -ENOMEM;
> +
> +		/* set parent of endpoint object */
> +		priv_ep->cdns3_dev = priv_dev;
> +		priv_dev->eps[found_endpoints++] = priv_ep;
> +
> +		snprintf(priv_ep->name, sizeof(priv_ep->name), "ep%d%s",
> +			 ep_number, !!ep_dir ? "in" : "out");
> +		priv_ep->endpoint.name = priv_ep->name;
> +
> +		usb_ep_set_maxpacket_limit(&priv_ep->endpoint,
> +					   ENDPOINT_MAX_PACKET_LIMIT);

CDNS3_ENDPOINT_MAX_PACKET_LIMIT

> +		priv_ep->endpoint.max_streams = ENDPOINT_MAX_STREAMS;

CDNS3_ENDPOINT_MAX_STREAMS

> +		//TODO: Add implementation of cdns3_gadget_ep_ops
> +		//priv_ep->endpoint.ops = &cdns3_gadget_ep_ops;
> +		if (ep_dir)
> +			priv_ep->endpoint.caps.dir_in = 1;
> +		else
> +			priv_ep->endpoint.caps.dir_out = 1;
> +
> +		if (iso_ep_reg & ep_mask)
> +			priv_ep->endpoint.caps.type_iso = 1;
> +
> +		priv_ep->endpoint.caps.type_bulk = 1;
> +		priv_ep->endpoint.caps.type_int = 1;
> +		priv_ep->endpoint.maxburst = CDNS3_EP_BUF_SIZE - 1;
> +
> +		priv_ep->flags = 0;
> +
> +		dev_info(&priv_dev->dev, "Initialized  %s support: %s %s\n",
> +			 priv_ep->name,
> +			 priv_ep->endpoint.caps.type_bulk ? "BULK, INT" : "",
> +			 priv_ep->endpoint.caps.type_iso ? "ISO" : "");
> +
> +		list_add_tail(&priv_ep->endpoint.ep_list,
> +			      &priv_dev->gadget.ep_list);
> +		INIT_LIST_HEAD(&priv_ep->request_list);
> +		INIT_LIST_HEAD(&priv_ep->ep_match_pending_list);
> +	}
> +
> +	priv_dev->ep_nums = found_endpoints;
> +	return 0;
> +}
> +
> +static void cdns3_gadget_release(struct device *dev)
> +{
> +	struct cdns3_device *priv_dev;
> +
> +	priv_dev = container_of(dev, struct cdns3_device, dev);
> +	kfree(priv_dev);
> +}
> +
> +static int __cdns3_gadget_init(struct cdns3 *cdns)
> +{
> +	struct cdns3_device *priv_dev;
> +	struct device *dev;
> +	int ret;
> +
> +	priv_dev = kzalloc(sizeof(*priv_dev), GFP_KERNEL);
> +	if (!priv_dev)
> +		return -ENOMEM;
> +
> +	dev = &priv_dev->dev;
> +	dev->release = cdns3_gadget_release;
> +	dev->parent = cdns->dev;
> +	dev_set_name(dev, "gadget-cdns3");
> +	cdns->gadget_dev = dev;
> +
> +	priv_dev->sysdev = cdns->dev;
> +	ret = device_register(dev);

Why do you need to create this dummy device? you could just use cdns3->dev.

> +	if (ret)
> +		goto err1;
> +
> +	priv_dev->regs = cdns->dev_regs;
> +
> +	/* fill gadget fields */
> +	priv_dev->gadget.max_speed = USB_SPEED_SUPER;
> +	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
> +	//TODO: Add implementation of cdns3_gadget_ops
> +	//priv_dev->gadget.ops = &cdns3_gadget_ops;
> +	priv_dev->gadget.name = "usb-ss-gadget";
> +	priv_dev->gadget.sg_supported = 1;
> +	priv_dev->is_connected = 0;
> +
> +	spin_lock_init(&priv_dev->lock);
> +
> +	priv_dev->in_standby_mode = 1;
> +
> +	/* initialize endpoint container */
> +	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
> +	INIT_LIST_HEAD(&priv_dev->ep_match_list);
> +
> +	ret = cdns3_init_ep0(priv_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to create endpoint 0\n");
> +		ret = -ENOMEM;

why not just use the ret as is.

> +		goto err2;
> +	}
> +
> +	ret = cdns3_init_ep(priv_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to create non zero endpoints\n");
> +		ret = -ENOMEM;

here too

> +		goto err2;
> +	}
> +
> +	/* allocate memory for default endpoint TRB */
> +	priv_dev->trb_ep0 = dma_alloc_coherent(priv_dev->sysdev, 24,

what is 24?
In error path you are using TRB_SIZE * 2. Should we be using that here too?


> +					       &priv_dev->trb_ep0_dma, GFP_DMA);
> +	if (!priv_dev->trb_ep0) {
> +		dev_err(dev, "Failed to allocate memory for ep0 TRB\n");
> +		ret = -ENOMEM;
> +		goto err2;
> +	}
> +
> +	/* allocate memory for setup packet buffer */
> +	priv_dev->setup = dma_alloc_coherent(priv_dev->sysdev, 8,

is 8 enough for all use cases? What about vendor specific setup requests?

> +					     &priv_dev->setup_dma, GFP_DMA);
> +	if (!priv_dev->setup) {
> +		dev_err(dev, "Failed to allocate memory for SETUP buffer\n");
> +		ret = -ENOMEM;
> +		goto err3;
> +	}
> +
> +	dev_dbg(dev, "Device Controller version: %08x\n",
> +		readl(&priv_dev->regs->usb_cap6));
> +	dev_dbg(dev, "USB Capabilities:: %08x\n",
> +		readl(&priv_dev->regs->usb_cap1));
> +	dev_dbg(dev, "On-Chip memory cnfiguration: %08x\n",
> +		readl(&priv_dev->regs->usb_cap2));
> +
> +	/* add USB gadget device */
> +	ret = usb_add_gadget_udc(&priv_dev->dev, &priv_dev->gadget);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register USB device controller\n");
> +		goto err4;
> +	}
> +
> +	priv_dev->zlp_buf = kzalloc(ENDPOINT_ZLP_BUF_SIZE, GFP_KERNEL);
> +	if (!priv_dev->zlp_buf) {
> +		ret = -ENOMEM;
> +		goto err4;
> +	}

how about allocating zlp_buf before usb_add_gadget_udc()?

> +
> +	return 0;
> +err4:
> +	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup,
> +			  priv_dev->setup_dma);
> +err3:
> +	dma_free_coherent(priv_dev->sysdev, TRB_SIZE * 2, priv_dev->trb_ep0,
> +			  priv_dev->trb_ep0_dma);
> +err2:
> +	device_del(dev);
> +err1:
> +	put_device(dev);
> +	cdns->gadget_dev = NULL;
> +	return ret;
> +}
> +
> +/**
> + * cdns3_gadget_remove: parent must call this to remove UDC
> + *
> + * cdns: cdns3 instance
> + */
> +void cdns3_gadget_remove(struct cdns3 *cdns)

how about calling this cdns3_gadget_exit() to complememnt cdns3_gadget_init()

> +{
> +	struct cdns3_device *priv_dev;
> +
> +	if (!cdns->roles[CDNS3_ROLE_GADGET])
> +		return;

why this check? It will lead to an unbalanced exit() and future init().

> +
> +	priv_dev = container_of(cdns->gadget_dev, struct cdns3_device, dev);
> +	usb_del_gadget_udc(&priv_dev->gadget);
> +	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup,
> +			  priv_dev->setup_dma);
> +	dma_free_coherent(priv_dev->sysdev, TRB_SIZE * 2, priv_dev->trb_ep0,
> +			  priv_dev->trb_ep0_dma);

You need to free all memory allocation done in cdns3_init_ep0() and cdns3_init_ep()
else we eat memory on every role switch if we plan on getting rid of the dummy gadget_dev.

> +	device_unregister(cdns->gadget_dev);
> +	cdns->gadget_dev = NULL;
> +	kfree(priv_dev->zlp_buf);
> +}
> +
> +static int cdns3_gadget_start(struct cdns3 *cdns)
> +{
> +	struct cdns3_device *priv_dev = container_of(cdns->gadget_dev,
> +			struct cdns3_device, dev);
> +	unsigned long flags;
> +
> +	pm_runtime_get_sync(cdns->dev);

This is another reason why we shouldn't be creating a dummy gadget_dev.
PM is tied to cdns->dev.

> +	spin_lock_irqsave(&priv_dev->lock, flags);
> +	priv_dev->start_gadget = 1;
> +
> +	if (!priv_dev->gadget_driver) {
> +		spin_unlock_irqrestore(&priv_dev->lock, flags);
> +		return 0;
> +	}
> +
> +	cdns3_gadget_config(priv_dev);
> +	priv_dev->in_standby_mode = 0;
> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
> +	return 0;
> +}
> +
> +static void __cdns3_gadget_stop(struct cdns3 *cdns)
> +{
> +	struct cdns3_device *priv_dev;
> +	unsigned long flags;
> +
> +	priv_dev = container_of(cdns->gadget_dev, struct cdns3_device, dev);
> +
> +	if (priv_dev->gadget_driver)
> +		priv_dev->gadget_driver->disconnect(&priv_dev->gadget);
> +
> +	usb_gadget_disconnect(&priv_dev->gadget);
> +	spin_lock_irqsave(&priv_dev->lock, flags);
> +	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
> +
> +	/* disable interrupt for device */
> +	writel(0, &priv_dev->regs->usb_ien);
> +	writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
> +	priv_dev->start_gadget = 0;
> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
> +}
> +
> +static void cdns3_gadget_stop(struct cdns3 *cdns)
> +{
> +	if (cdns->role == CDNS3_ROLE_GADGET)
> +		__cdns3_gadget_stop(cdns);

Why worry about role here? That should be job of core/drd driver.

> +
> +	pm_runtime_mark_last_busy(cdns->dev);
> +	pm_runtime_put_autosuspend(cdns->dev);
> +}
> +
> +static int cdns3_gadget_suspend(struct cdns3 *cdns, bool do_wakeup)
> +{
> +	__cdns3_gadget_stop(cdns);
> +	return 0;
> +}
> +
> +static int cdns3_gadget_resume(struct cdns3 *cdns, bool hibernated)
> +{
> +	struct cdns3_device *priv_dev;
> +	unsigned long flags;
> +
> +	priv_dev = container_of(cdns->gadget_dev, struct cdns3_device, dev);
> +	spin_lock_irqsave(&priv_dev->lock, flags);
> +	priv_dev->start_gadget = 1;

who is using this start_gadget flag?

> +	if (!priv_dev->gadget_driver) {
> +		spin_unlock_irqrestore(&priv_dev->lock, flags);
> +		return 0;
> +	}
> +
> +	cdns3_gadget_config(priv_dev);
> +	priv_dev->in_standby_mode = 0;
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
> +	rdrv->start	= cdns3_gadget_start;
> +	rdrv->stop	= cdns3_gadget_stop;

Why not use gadget_init()/gadget_exit() here? That sounds much cleaner
as you won't have ISR's active after a role stop.

> +	rdrv->suspend	= cdns3_gadget_suspend;
> +	rdrv->resume	= cdns3_gadget_resume;
> +	rdrv->irq	= cdns3_irq_handler_thread;
> +	rdrv->name	= "gadget";
> +	cdns->roles[CDNS3_ROLE_GADGET] = rdrv;
> +	return __cdns3_gadget_init(cdns);
> +}
> diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
> index 75ca6214e79a..3b0d4d2e4831 100644
> --- a/drivers/usb/cdns3/gadget.h
> +++ b/drivers/usb/cdns3/gadget.h
> @@ -1068,4 +1068,8 @@ struct cdns3_device {
>  	struct usb_request		*pending_status_request;
>  };
>  
> +void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
> +int cdns3_init_ep0(struct cdns3_device *priv_dev);
> +void cdns3_ep0_config(struct cdns3_device *priv_dev);
> +void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep);
>  #endif /* __LINUX_CDNS3_GADGET */
> 

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
