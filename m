Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E1420825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nkO+/Rty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E1420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeKHTJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:09:30 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35974 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKHTJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:09:30 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA89YjQw104326;
        Thu, 8 Nov 2018 03:34:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541669685;
        bh=rh3audeCQVmE2bkfPsfjpvKyyaUO8akqIsCB+xCWhvU=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=nkO+/Rty6Zs8MkMVLXZwcQ+iekMCoDqW/YB4RKRLmfzslQg6l5ohENao6ndEDqCGP
         4CY+NGy0ZgTRdXt2MqA1fzIsL34vLA0ljtZ42rJWDGaaJ22LLT4cmEndwPTLcVSEaq
         qhMaMxD1hIiB+8BLF3J0D70WCWBIvY2QfOLEMduY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA89YjLZ041056
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 03:34:45 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 03:34:44 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 03:34:44 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA89YfKl005046;
        Thu, 8 Nov 2018 03:34:42 -0600
Subject: Re: [RFC PATCH v1 13/14] usb:cdns3: Adds debugging function.
To:     Pawel Laszczak <pawell@cadence.com>, <gregkh@linuxfoundation.org>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
 <1541267487-3664-14-git-send-email-pawell@cadence.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BE40331.90107@ti.com>
Date:   Thu, 8 Nov 2018 11:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1541267487-3664-14-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/11/18 19:51, Pawel Laszczak wrote:
> Patch implements some function used for debugging driver.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/Makefile |   2 +-
>  drivers/usb/cdns3/debug.c  | 128 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/cdns3/ep0.c    |   3 +
>  drivers/usb/cdns3/gadget.c |  12 ++++
>  drivers/usb/cdns3/gadget.h |  13 +++-
>  5 files changed, 156 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/usb/cdns3/debug.c
> 
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index f4cfc978626f..34e60d03c4ec 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -2,6 +2,6 @@ obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
>  
>  cdns3-y					:= core.o drd.o
> -cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o
> +cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o debug.o
>  cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
>  cdns3-pci-y		 		:= cdns3-pci-wrap.o
> diff --git a/drivers/usb/cdns3/debug.c b/drivers/usb/cdns3/debug.c
> new file mode 100644
> index 000000000000..bebf22c4d18e
> --- /dev/null
> +++ b/drivers/usb/cdns3/debug.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include "gadget.h"
> +
> +static inline char *cdns3_decode_ep_irq(u32 ep_sts, const char *ep_name)
> +{
> +	static char str[256];
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
> +char *cdns3_decode_epx_irq(struct cdns3_endpoint *priv_ep)
> +{
> +	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +
> +	return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
> +				   priv_ep->name);
> +}
> +
> +char *cdns3_decode_ep0_irq(struct cdns3_device *priv_dev, int dir)
> +{
> +	if (dir)
> +		return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
> +					   "ep0IN");
> +	else
> +		return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
> +					   "ep0OUT");
> +}
> +
> +void cdns3_dbg_setup(struct cdns3_device *priv_dev)
> +{
> +	struct usb_ctrlrequest *setup = priv_dev->setup;
> +
> +	dev_dbg(&priv_dev->dev,
> +		"SETUP BRT: %02x BR: %02x V: %04x I: %04x L: %04x\n",
> +		setup->bRequestType,
> +		setup->bRequest,
> +		le16_to_cpu(setup->wValue),
> +		le16_to_cpu(setup->wIndex),
> +		le16_to_cpu(setup->wLength));
> +}
> +
> +/**
> + * Debug a transfer ring.
> + *
> + * Prints out all TRBs in the endpoint ring, even those after the Link TRB.
> + *.
> + */
> +void cdns3_dbg_ring(struct cdns3_device *priv_dev,
> +		    struct cdns3_endpoint *priv_ep)
> +{
> +	u64 addr = priv_ep->trb_pool_dma;
> +	struct cdns3_trb *trb;
> +	int i;
> +
> +	for (i = 0; i < TRBS_PER_SEGMENT; ++i) {
> +		trb = &priv_ep->trb_pool[i];
> +		dev_dbg(&priv_dev->dev, "@%016llx %08x %08x %08x\n", addr,
> +			le32_to_cpu(trb->buffer),
> +			le32_to_cpu(trb->length),
> +			le32_to_cpu(trb->control));
> +		addr += sizeof(*trb);
> +	}
> +}
> +
> +void cdns3_dbg_ring_ptrs(struct cdns3_device *priv_dev,
> +			 struct cdns3_endpoint *priv_ep)
> +{
> +	struct cdns3_trb *trb;
> +
> +	trb = &priv_ep->trb_pool[priv_ep->dequeue];
> +	dev_dbg(&priv_dev->dev,
> +		"Ring deq index: %d, trb: %p (virt), 0x%llx (dma)\n",
> +		priv_ep->dequeue, trb,
> +		cdns3_trb_virt_to_dma(priv_ep, trb));
> +
> +	trb = &priv_ep->trb_pool[priv_ep->enqueue];
> +	dev_dbg(&priv_dev->dev,
> +		"Ring enq index: %d, trb: %p (virt), 0x%llx (dma)\n",
> +		priv_ep->enqueue, trb,
> +		cdns3_trb_virt_to_dma(priv_ep, trb));
> +}
> +
> +void cdns3_dbg_ep_rings(struct cdns3_device *priv_dev,
> +			struct cdns3_endpoint *priv_ep)
> +{
> +	dev_dbg(&priv_dev->dev, "Endpoint ring %s:\n", priv_ep->name);
> +
> +	cdns3_dbg_ring_ptrs(priv_dev, priv_ep);
> +	cdns3_dbg_ring(priv_dev, priv_ep);
> +}
> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
> index 555ac7f6842e..46c943a74f77 100644
> --- a/drivers/usb/cdns3/ep0.c
> +++ b/drivers/usb/cdns3/ep0.c
> @@ -604,12 +604,15 @@ void cdns3_check_ep0_interrupt_proceed(struct cdns3_device *priv_dev, int dir)
>  	cdns3_select_ep(priv_dev, 0 | (dir ? USB_DIR_IN : USB_DIR_OUT));
>  	ep_sts_reg = readl(&regs->ep_sts);
>  
> +	dev_dbg(&priv_dev->dev, "%s\n", cdns3_decode_ep0_irq(priv_dev, dir));
> +
>  	__pending_setup_status_handler(priv_dev);
>  
>  	if ((ep_sts_reg & EP_STS_SETUP) && dir == 0) {
>  		struct usb_ctrlrequest *setup = priv_dev->setup;
>  
>  		writel(EP_STS_SETUP | EP_STS_IOC | EP_STS_ISP, &regs->ep_sts);
> +		cdns3_dbg_setup(priv_dev);
>  
>  		priv_dev->ep0_data_dir = setup->bRequestType & USB_DIR_IN;
>  		cdns3_ep0_setup_phase(priv_dev);
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 905cad1a8229..ba4a36ce6e9a 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -124,6 +124,14 @@ void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep)
>  	wmb();
>  }
>  
> +dma_addr_t cdns3_trb_virt_to_dma(struct cdns3_endpoint *priv_ep,
> +				 struct cdns3_trb *trb)
> +{
> +	u32 offset = (char *)trb - (char *)priv_ep->trb_pool;
> +
> +	return priv_ep->trb_pool_dma + offset;
> +}
> +
>  /**
>   * cdns3_allocate_trb_pool - Allocates TRB's pool for selected endpoint
>   * @priv_ep:  endpoint object
> @@ -428,6 +436,8 @@ int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
>  		trb->control |= first_pcs;
>  
>  	priv_req->on_ring = 1;
> +
> +	cdns3_dbg_ep_rings(priv_dev, priv_ep);
>  arm:
>  	/* arm transfer on selected endpoint */
>  	cdns3_select_ep(priv_ep->cdns3_dev, address);
> @@ -537,6 +547,8 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
>  	cdns3_select_ep(priv_dev, priv_ep->endpoint.address);
>  	ep_sts_reg = readl(&regs->ep_sts);
>  
> +	dev_dbg(&priv_dev->dev, "%s\n", cdns3_decode_epx_irq(priv_ep));
> +
>  	if (ep_sts_reg & EP_STS_TRBERR)
>  		writel(EP_STS_TRBERR, &regs->ep_sts);
>  
> diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
> index 3f67ef1e5cda..3b2c01ff655b 100644
> --- a/drivers/usb/cdns3/gadget.h
> +++ b/drivers/usb/cdns3/gadget.h
> @@ -1085,5 +1085,16 @@ struct usb_request *cdns3_gadget_ep_alloc_request(struct usb_ep *ep,
>  void cdns3_gadget_ep_free_request(struct usb_ep *ep,
>  				  struct usb_request *request);
>  int cdns3_gadget_ep_dequeue(struct usb_ep *ep, struct usb_request *request);
> -
> +dma_addr_t cdns3_trb_virt_to_dma(struct cdns3_endpoint *priv_ep,
> +				 struct cdns3_trb *trb);
> +
> +char *cdns3_decode_epx_irq(struct cdns3_endpoint *priv_ep);
> +char *cdns3_decode_ep0_irq(struct cdns3_device *priv_dev, int dir);
> +void cdns3_dbg_ring(struct cdns3_device *priv_dev,
> +		    struct cdns3_endpoint *priv_ep);
> +void cdns3_dbg_ring_ptrs(struct cdns3_device *priv_dev,
> +			 struct cdns3_endpoint *priv_ep);
> +void cdns3_dbg_ep_rings(struct cdns3_device *priv_dev,
> +			struct cdns3_endpoint *priv_ep);
> +void cdns3_dbg_setup(struct cdns3_device *priv_dev);
>  #endif /* __LINUX_CDNS3_GADGET */
> 

How often are these invoked?

For I/O intensive cases dev_dbg() will not be useful as it will affect timing adversely
because of which it might prevent the issue from happening when debug is enabled.

How about using tracepoints instead?

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
