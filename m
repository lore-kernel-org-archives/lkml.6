Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7851C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C6A2174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZSdaXxKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C6A2174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbeHCMiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:38:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44000 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbeHCMiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:38:15 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w73AgRr5049494;
        Fri, 3 Aug 2018 05:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533292947;
        bh=wGRrBmuD894yylpUIPisP8FyiD5YOTn9Jki1pfM9rmE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZSdaXxKWj3O7opQE1CieAB5+cCewGisCm2Hr9N2IchlXgPzCOYCem5tuTBqeSFi7s
         Ky5K7kxByYSiSU+r+Y4IygpAGfS8knXwNf6SHrK/3idaxtu+D8FWqftT8dQ7iYz9Ve
         5+BkGPPxL0lfnSw8NHftVjrBS0FhyhnWJUMd11lI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w73AgQdc004452;
        Fri, 3 Aug 2018 05:42:26 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 3 Aug
 2018 05:42:26 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 3 Aug 2018 05:42:26 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w73AgObQ032644;
        Fri, 3 Aug 2018 05:42:24 -0500
Subject: Re: [PATCH 06/31] usb: usbssp: added template functions used by upper
 layer.
To:     Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
 <1532023084-28083-7-git-send-email-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <0aad2e70-c630-feac-24a9-35d66360e4b2@ti.com>
Date:   Fri, 3 Aug 2018 13:42:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532023084-28083-7-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/18 20:57, Pawel Laszczak wrote:
> Patch adds some functionality for initialization process.
> It adds to driver usbssp_reset and usbssp_start function.
> 
> Next elements added are objects usbssp_gadget_ep0_ops,
> usbssp_gadget_ep_ops and usbssp_gadget_ops. These objects
> constitute the interface used by gadget subsystem.
> At this moment functions related to these objects are empty
> and do nothing.
> 
> This patch also implements usbssp_gadget_init_endpoint and
> usbssp_gadget_free_endpoint used during initialization.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/usbssp/gadget-ext-caps.h |   3 +
>  drivers/usb/usbssp/gadget-if.c       | 269 ++++++++++++++++++++++++++-
>  drivers/usb/usbssp/gadget.c          |  84 ++++++++-
>  3 files changed, 350 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/usbssp/gadget-ext-caps.h b/drivers/usb/usbssp/gadget-ext-caps.h
> index 2bf327046376..86c0ce331037 100644
> --- a/drivers/usb/usbssp/gadget-ext-caps.h
> +++ b/drivers/usb/usbssp/gadget-ext-caps.h
> @@ -51,3 +51,6 @@
>  #define USBSSP_CMD_EWE			BIT(10)
>  
>  #define USBSSP_IRQS	(USBSSP_CMD_EIE | USBSSP_CMD_HSEIE | USBSSP_CMD_EWE)
> +
> +/* true: Controller Not Ready to accept doorbell or op reg writes after reset */
> +#define USBSSP_STS_CNR			BIT(11)
> diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
> index d53e0fb65299..70def978b085 100644
> --- a/drivers/usb/usbssp/gadget-if.c
> +++ b/drivers/usb/usbssp/gadget-if.c
> @@ -12,13 +12,278 @@
>  #include <linux/usb/composite.h>
>  #include "gadget.h"
>  
> +static int usbssp_gadget_ep_enable(struct usb_ep *ep,
> +				   const struct usb_endpoint_descriptor *desc)
> +{
> +	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
> +	int ret = 0;
> +
> +	if (!ep_priv)
> +		return -EINVAL;
> +
> +	/*TODO: implements this function*/
> +	return ret;
> +}
> +
> +int usbssp_gadget_ep_disable(struct usb_ep *ep)
> +{
> +	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
> +	int ret = 0;
> +
> +	if (!ep_priv)
> +		return -EINVAL;
> +
> +	/*TODO: implements this function*/
> +	return ret;
> +}
> +
> +static struct usb_request *usbssp_gadget_ep_alloc_request(struct usb_ep *ep,
> +							  gfp_t gfp_flags)
> +{
> +	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
> +
> +	if (!ep_priv)
> +		return NULL;
> +
> +	/*TODO: implements this function*/
> +	return NULL;
> +}
> +
> +static void usbssp_gadget_ep_free_request(struct usb_ep *ep,
> +					  struct usb_request *request)
> +{
> +	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
> +
> +	if (!ep_priv)
> +		return;
> +
> +	/*TODO: implements this function*/
> +}
> +
> +static int usbssp_gadget_ep_queue(struct usb_ep *ep,
> +				  struct usb_request *request,
> +				  gfp_t gfp_flags)
> +{
> +	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
> +	int ret = 0;
> +
> +	if (!ep_priv)
> +		return -EINVAL;
> +
> +	/*TODO: implements this function*/
> +	return ret;
> +}
> +
> +static int usbssp_gadget_ep_dequeue(struct usb_ep *ep,
> +				    struct usb_request *request)
> +{
> +	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
> +	int ret = 0;
> +
> +	if (!ep_priv)
> +		return -EINVAL;
> +
> +	/*TODO: implements this function*/
> +	return ret;
> +}
> +
> +static int usbssp_gadget_ep_set_halt(struct usb_ep *ep, int value)
> +{
> +	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
> +	int ret = 0;
> +
> +	if (!ep_priv)
> +		return -EINVAL;
> +
> +	/*TODO: implements this function*/
> +	return ret;
> +}
> +
> +static int usbssp_gadget_ep_set_wedge(struct usb_ep *ep)
> +{
> +	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
> +	int ret = 0;
> +
> +	if (!ep_priv)
> +		return -EINVAL;
> +
> +	/*TODO: implements this function*/
> +	return ret;
> +}
> +
> +static const struct usb_ep_ops usbssp_gadget_ep0_ops = {
> +	.enable		= usbssp_gadget_ep_enable,
> +	.disable	= usbssp_gadget_ep_disable,
> +	.alloc_request	= usbssp_gadget_ep_alloc_request,
> +	.free_request	= usbssp_gadget_ep_free_request,
> +	.queue		= usbssp_gadget_ep_queue,
> +	.dequeue	= usbssp_gadget_ep_dequeue,
> +	.set_halt	= usbssp_gadget_ep_set_halt,
> +	.set_wedge	= usbssp_gadget_ep_set_wedge,
> +};
> +
> +static const struct usb_ep_ops usbssp_gadget_ep_ops = {
> +	.enable		= usbssp_gadget_ep_enable,
> +	.disable	= usbssp_gadget_ep_disable,
> +	.alloc_request	= usbssp_gadget_ep_alloc_request,
> +	.free_request	= usbssp_gadget_ep_free_request,
> +	.queue		= usbssp_gadget_ep_queue,
> +	.dequeue	= usbssp_gadget_ep_dequeue,
> +	.set_halt	= usbssp_gadget_ep_set_halt,
> +	.set_wedge	= usbssp_gadget_ep_set_wedge,
> +};
> +
> +static struct usb_endpoint_descriptor usbssp_gadget_ep0_desc = {
> +	.bLength =		USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType =	USB_DT_ENDPOINT,
> +	.bmAttributes =		USB_ENDPOINT_XFER_CONTROL,
> +};
> +
> +static int usbssp_gadget_start(struct usb_gadget *g,
> +			       struct usb_gadget_driver *driver)
> +{
> +	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
> +	int ret = 0;
> +
> +	if (usbssp_data->gadget_driver) {
> +		dev_err(usbssp_data->dev, "%s is already bound to %s\n",
> +				usbssp_data->gadget.name,
> +				usbssp_data->gadget_driver->driver.name);
> +		ret = -EBUSY;
> +	}
> +
> +	/*TODO: add implementation*/
> +	return ret;
> +}
> +
> +static int usbssp_gadget_stop(struct usb_gadget *g)
> +{
> +	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
> +
> +	if (!usbssp_data)
> +		return -EINVAL;
> +	/*TODO: add implementation*/
> +	return 0;
> +}
> +
> +static int usbssp_gadget_get_frame(struct usb_gadget *g)
> +{
> +	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
> +
> +	if (!usbssp_data)
> +		return -EINVAL;
> +
> +	/*TODO: add implementation*/
> +	return 0;
> +}
> +
> +static int usbssp_gadget_wakeup(struct usb_gadget *g)
> +{
> +	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
> +
> +	if (!usbssp_data)
> +		return -EINVAL;
> +
> +	/*TODO: add implementation*/
> +	return 0;
> +}
> +
> +static int usbssp_gadget_set_selfpowered(struct usb_gadget *g,
> +					 int is_selfpowered)
> +{
> +	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
> +
> +	if (!usbssp_data)
> +		return -EINVAL;
> +
> +	/*TODO: add implementation*/
> +	return 0;
> +}
> +
> +static const struct usb_gadget_ops usbssp_gadget_ops = {
> +	.get_frame		= usbssp_gadget_get_frame,
> +	.wakeup			= usbssp_gadget_wakeup,
> +	.set_selfpowered	= usbssp_gadget_set_selfpowered,
> +	.udc_start		= usbssp_gadget_start,
> +	.udc_stop		= usbssp_gadget_stop,
> +};
> +
>  int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data)

Since we're initializing all endpoints this function should be named usbssp_gadget_init_endpoints().

>  {
> -	/*TODO: it has to be implemented*/
> +	int i = 0;
> +	struct usbssp_ep *ep_priv;
> +
> +	usbssp_data->num_endpoints = USBSSP_ENDPOINTS_NUM;
> +	INIT_LIST_HEAD(&usbssp_data->gadget.ep_list);
> +
> +	for (i = 1; i < usbssp_data->num_endpoints; i++) {
> +		bool direction = i & 1; /*start from OUT endpoint*/
> +		u8 epnum = (i >> 1);
> +
> +		ep_priv = &usbssp_data->devs.eps[i-1];
> +		ep_priv->usbssp_data = usbssp_data;
> +		ep_priv->number = epnum;
> +		ep_priv->direction = direction; /*0 for OUT, 1 for IN*/
> +
> +		snprintf(ep_priv->name, sizeof(ep_priv->name), "ep%d%s", epnum,
> +				(ep_priv->direction) ? "in" : "out");
> +
> +		ep_priv->endpoint.name = ep_priv->name;
> +
> +		if (ep_priv->number < 2) {
> +			ep_priv->endpoint.desc = &usbssp_gadget_ep0_desc;
> +			ep_priv->endpoint.comp_desc = NULL;
> +		}
> +
> +		if (epnum == 0) {
> +			/*EP0 is bidirectional endpoint*/
> +			usb_ep_set_maxpacket_limit(&ep_priv->endpoint, 512);
> +			dev_dbg(usbssp_data->dev,
> +				"Initializing %s, MaxPack: %04x Type: Ctrl\n",
> +				ep_priv->name, 512);
> +			ep_priv->endpoint.maxburst = 1;
> +			ep_priv->endpoint.ops = &usbssp_gadget_ep0_ops;
> +			ep_priv->endpoint.caps.type_control = true;
> +
> +			usbssp_data->usb_req_ep0_in.epnum = ep_priv->number;
> +			usbssp_data->usb_req_ep0_in.dep = ep_priv;
> +
> +			if (!epnum)
> +				usbssp_data->gadget.ep0 = &ep_priv->endpoint;
> +		} else {
> +			usb_ep_set_maxpacket_limit(&ep_priv->endpoint, 1024);
> +			ep_priv->endpoint.maxburst = 15;
> +			ep_priv->endpoint.ops = &usbssp_gadget_ep_ops;
> +			list_add_tail(&ep_priv->endpoint.ep_list,
> +					&usbssp_data->gadget.ep_list);
> +			ep_priv->endpoint.caps.type_iso = true;
> +			ep_priv->endpoint.caps.type_bulk = true;
> +			ep_priv->endpoint.caps.type_int = true;
> +
> +		}
> +
> +		ep_priv->endpoint.caps.dir_in = direction;
> +		ep_priv->endpoint.caps.dir_out = !direction;

Since you start from 1, ep0 will only be initialized as dir_in.
Is it better to represent EP0in and EP0out separately?
If so you can start i from 0 and use
	ep_priv = &usbssp_data->devs.eps[i];

This should fix the direction. eps[0] will be ep0out and eps[1] will be ep0in.

> +
> +		dev_dbg(usbssp_data->dev, "Init %s, MaxPack: %04x SupType:"
> +				" INT/BULK/ISOC , SupDir %s\n",
> +				ep_priv->name, 1024,
> +				(ep_priv->endpoint.caps.dir_in) ? "IN" : "OUT");
> +
> +		INIT_LIST_HEAD(&ep_priv->pending_list);
> +	}
>  	return 0;
>  }
>  
>  void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data)
>  {
> -	/*TODO: it has to be implemented*/
> +	int i;
> +	struct usbssp_ep *ep_priv;
> +
> +	for (i = 0; i < usbssp_data->num_endpoints; i++) {
> +		ep_priv = &usbssp_data->devs.eps[i];
> +

if you start i from 1 then you can skip the if().

> +		if (ep_priv->number != 0)
> +			list_del(&ep_priv->endpoint.ep_list);
> +	}
>  }
> diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
> index 338ec2ec18b1..195f5777cf8a 100644
> --- a/drivers/usb/usbssp/gadget.c
> +++ b/drivers/usb/usbssp/gadget.c
> @@ -103,6 +103,83 @@ int usbssp_halt(struct usbssp_udc *usbssp_data)
>  	return ret;
>  }
>  
> +/*
> + * Set the run bit and wait for the device to be running.
> + */
> +int usbssp_start(struct usbssp_udc *usbssp_data)
> +{
> +	u32 temp;
> +	int ret;
> +
> +	temp = readl(&usbssp_data->op_regs->command);
> +	temp |= (CMD_RUN | CMD_DEVEN);
> +	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
> +			"// Turn on USBSSP, cmd = 0x%x.", temp);
> +	writel(temp, &usbssp_data->op_regs->command);
> +
> +	/*
> +	 * Wait for the HCHalted Staus bit to be 0 to indicate the device is
> +	 * running.
> +	 */
> +	ret = usbssp_handshake(&usbssp_data->op_regs->status,
> +			STS_HALT, 0, USBSSP_MAX_HALT_USEC);
> +
> +	if (ret == -ETIMEDOUT)
> +		dev_err(usbssp_data->dev, "Device took too long to start, waited %u microseconds.\n",
> +			USBSSP_MAX_HALT_USEC);
> +	if (!ret)
> +		/* clear state flags. Including dying, halted or removing */
> +		usbssp_data->usbssp_state = 0;
> +
> +	return ret;
> +}
> +
> +/*
> + * Reset a halted DC.
> + *
> + * This resets pipelines, timers, counters, state machines, etc.
> + * Transactions will be terminated immediately, and operational registers
> + * will be set to their defaults.
> + */
> +int usbssp_reset(struct usbssp_udc *usbssp_data)
> +{
> +	u32 command;
> +	u32 state;
> +	int ret;
> +
> +	state = readl(&usbssp_data->op_regs->status);
> +
> +	if (state == ~(u32)0) {
> +		dev_warn(usbssp_data->dev, "Device not accessible, reset failed.\n");
> +		return -ENODEV;
> +	}
> +
> +	if ((state & STS_HALT) == 0) {
> +		dev_warn(usbssp_data->dev, "DC not halted, aborting reset.\n");

DC is not a familiar abbreviation. Mabe just use Controller? or Device controller.

> +		return 0;
> +	}
> +
> +	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init, "// Reset the DC");
> +	command = readl(&usbssp_data->op_regs->command);
> +	command |= CMD_RESET;
> +	writel(command, &usbssp_data->op_regs->command);
> +
> +	ret = usbssp_handshake(&usbssp_data->op_regs->command,
> +			CMD_RESET, 0, 10 * 1000 * 1000);
> +
> +	if (ret)
> +		return ret;
> +	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
> +		"Wait for controller to be ready for doorbell rings");
> +	/*
> +	 * USBSSP cannot write to any doorbells or operational registers other
> +	 * than status until the "Controller Not Ready" flag is cleared.
> +	 */
> +	ret = usbssp_handshake(&usbssp_data->op_regs->status,
> +			STS_CNR, 0, 10 * 1000 * 1000);
> +
> +	return ret;
> +}
>  
>  /*
>   * Initialize memory for gadget driver and USBSSP (one-time init).
> @@ -179,8 +256,7 @@ int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
>  
>  	dev_dbg(usbssp_data->dev, "Resetting Device Controller\n");
>  	/* Reset the internal DC memory state and registers. */
> -	/*TODO: add implementation of usbssp_reset function*/
> -	//retval = usbssp_reset(usbssp_data);
> +	retval = usbssp_reset(usbssp_data);
>  	if (retval)
>  		return retval;
>  	dev_dbg(usbssp_data->dev, "Reset complete\n");
> @@ -244,8 +320,7 @@ int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
>  	BUILD_BUG_ON(sizeof(struct usbssp_run_regs) != (8+8*128)*32/8);
>  
>  	/* fill gadget fields */
> -	/*TODO: implements usbssp_gadget_ops object*/
> -	//usbssp_data->gadget.ops = &usbssp_gadget_ops;
> +	usbssp_data->gadget.ops = &usbssp_gadget_ops;
>  	usbssp_data->gadget.name = "usbssp-gadget";
>  	usbssp_data->gadget.max_speed = USB_SPEED_SUPER_PLUS;
>  	usbssp_data->gadget.speed = USB_SPEED_UNKNOWN;
> @@ -288,6 +363,7 @@ int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
>  	usbssp_halt(usbssp_data);
>  	/*TODO add implementation of usbssp_reset function*/
>  	//usbssp_reset(usbssp_data);
> +	usbssp_reset(usbssp_data);
>  	/*TODO add implementation of freeing memory*/
>  	//usbssp_mem_cleanup(usbssp_data);
>  err3:
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
