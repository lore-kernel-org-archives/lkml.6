Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42342C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B8D2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BIAGKOuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B8D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeK2Bdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:33:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45166 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2Bdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:33:50 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wASEVqeo052317;
        Wed, 28 Nov 2018 08:31:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543415512;
        bh=OFBu3ZozJsMiUk+5vSmf+2YS1IWYVP4nZs7aXBHA6z4=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=BIAGKOuwhdP4m7fsp+3sPeHvmvWy2a7HJjkPChm5AeH5dvUvbUeoKQA2RmNQTDZ4s
         9IQgxMtTpyYTi+tSFNO6WdAgNRYBDgDcEvjD8og9DYrLAm4NXJ+rKGio2JxNzXzqx3
         m+o1tNgjrMHMgfV6ur14LCC7gUutm3RLJKZVXaTk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wASEVqXp068263
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 08:31:52 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 28
 Nov 2018 08:31:50 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 28 Nov 2018 08:31:50 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wASEVl5G027090;
        Wed, 28 Nov 2018 08:31:47 -0600
Subject: Re: [RFC PATCH v2 10/15] usb:cdns3: Ep0 operations part of the API
To:     Pawel Laszczak <pawell@cadence.com>, <devicetree@vger.kernel.org>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-11-git-send-email-pawell@cadence.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFEA6D2.9010906@ti.com>
Date:   Wed, 28 Nov 2018 16:31:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1542535751-16079-11-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/18 12:09, Pawel Laszczak wrote:
> Patch implements related to default endpoint callback functions
> defined in usb_ep_ops object
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/ep0.c    | 191 ++++++++++++++++++++++++++++++++++++-
>  drivers/usb/cdns3/gadget.c |   8 ++
>  drivers/usb/cdns3/gadget.h |  10 ++
>  3 files changed, 207 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
> index ca1795467155..d05169e73631 100644
> --- a/drivers/usb/cdns3/ep0.c
> +++ b/drivers/usb/cdns3/ep0.c
> @@ -18,11 +18,185 @@ static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc = {
>  	.bmAttributes =	USB_ENDPOINT_XFER_CONTROL,
>  };
>  
> +/**
> + * cdns3_ep0_run_transfer - Do transfer on default endpoint hardware
> + * @priv_dev: extended gadget object
> + * @dma_addr: physical address where data is/will be stored
> + * @length: data length
> + * @erdy: set it to 1 when ERDY packet should be sent -
> + *        exit from flow control state
> + */
> +static void cdns3_ep0_run_transfer(struct cdns3_device *priv_dev,
> +				   dma_addr_t dma_addr,
> +				   unsigned int length, int erdy)
> +{
> +	struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
> +
> +	priv_dev->trb_ep0->buffer = TRB_BUFFER(dma_addr);
> +	priv_dev->trb_ep0->length = TRB_LEN(length);
> +	priv_dev->trb_ep0->control = TRB_CYCLE | TRB_IOC | TRB_TYPE(TRB_NORMAL);
> +
> +	cdns3_select_ep(priv_dev,
> +			priv_dev->ep0_data_dir ? USB_DIR_IN : USB_DIR_OUT);
> +
> +	writel(EP_STS_TRBERR, &regs->ep_sts);
> +	writel(EP_TRADDR_TRADDR(priv_dev->trb_ep0_dma), &regs->ep_traddr);
> +
> +	dev_dbg(&priv_dev->dev, "//Ding Dong ep0%s\n",
> +		priv_dev->ep0_data_dir ? "IN" : "OUT");
> +
> +	/* TRB should be prepared before starting transfer */
> +	writel(EP_CMD_DRDY, &regs->ep_cmd);
> +
> +	if (erdy)
> +		writel(EP_CMD_ERDY, &priv_dev->regs->ep_cmd);
> +}
> +
>  static void cdns3_prepare_setup_packet(struct cdns3_device *priv_dev)
>  {
>  	//TODO: Implements this function
>  }
>  
> +static void cdns3_set_hw_configuration(struct cdns3_device *priv_dev)

Is this going to be used only for ep0?
If yes then let's have ep0 in the name.
If not then this function should be in gadget.c

> +{
> +	struct cdns3_endpoint *priv_ep;
> +	struct usb_request *request;
> +	struct usb_ep *ep;
> +	int result = 0;
> +
> +	if (priv_dev->hw_configured_flag)
> +		return;
> +
> +	writel(USB_CONF_CFGSET, &priv_dev->regs->usb_conf);
> +	writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
> +
> +	cdns3_set_register_bit(&priv_dev->regs->usb_conf,
> +			       USB_CONF_U1EN | USB_CONF_U2EN);

Shouldn't U1/U2 be enabled only if the USB_DEVICE_U1_ENABLE/USB_DEVICE_U2_ENABLE
device request was received?

> +
> +	/* wait until configuration set */
> +	result = cdns3_handshake(&priv_dev->regs->usb_sts,
> +				 USB_STS_CFGSTS_MASK, 1, 100);
> +
> +	priv_dev->hw_configured_flag = 1;
> +	cdns3_enable_l1(priv_dev, 1);
> +
> +	list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
> +		if (ep->enabled) {
> +			priv_ep = ep_to_cdns3_ep(ep);
> +			request = cdns3_next_request(&priv_ep->request_list);
> +			if (request)
> +				cdns3_ep_run_transfer(priv_ep, request);

why are you starting transfers in a function that is supposed to set hw configuration only.

> +		}
> +	}
> +}
> +
> +/**
> + * cdns3_gadget_ep0_enable
> + * Function shouldn't be called by gadget driver,
> + * endpoint 0 is allways active
> + */
> +static int cdns3_gadget_ep0_enable(struct usb_ep *ep,
> +				   const struct usb_endpoint_descriptor *desc)
> +{
> +	return -EINVAL;
> +}
> +
> +/**
> + * cdns3_gadget_ep0_disable
> + * Function shouldn't be called by gadget driver,
> + * endpoint 0 is allways active
> + */
> +static int cdns3_gadget_ep0_disable(struct usb_ep *ep)
> +{
> +	return -EINVAL;
> +}
> +
> +/**
> + * cdns3_gadget_ep0_set_halt
> + * @ep: pointer to endpoint zero object
> + * @value: 1 for set stall, 0 for clear stall
> + *
> + * Returns 0
> + */
> +static int cdns3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
> +{
> +	/* TODO */
> +	return 0;
> +}
> +
> +/**
> + * cdns3_gadget_ep0_queue Transfer data on endpoint zero
> + * @ep: pointer to endpoint zero object
> + * @request: pointer to request object
> + * @gfp_flags: gfp flags
> + *
> + * Returns 0 on success, error code elsewhere
> + */
> +static int cdns3_gadget_ep0_queue(struct usb_ep *ep,
> +				  struct usb_request *request,
> +				  gfp_t gfp_flags)
> +{
> +	struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
> +	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +	unsigned long flags;
> +	int erdy_sent = 0;
> +	int ret = 0;
> +
> +	dev_dbg(&priv_dev->dev, "Queue to Ep0%s L: %d\n",
> +		priv_dev->ep0_data_dir ? "IN" : "OUT",
> +		request->length);
> +
> +	/* send STATUS stage */
> +	if (request->length == 0 && request->zero == 0) {

Is this check sufficient to know STATUS stage?
It might be normal for vendor specific control request to have
request->length = 0 and request->zero = 0.


> +		spin_lock_irqsave(&priv_dev->lock, flags);
> +		cdns3_select_ep(priv_dev, 0x00);
> +
> +		erdy_sent = !priv_dev->hw_configured_flag;
> +		cdns3_set_hw_configuration(priv_dev);

What if we're still busy with DATA stage of previous ep0_queue?

if (!list_empty(&priv_ep->request_list)) should be done as the first thing in this function.

> +
> +		if (!erdy_sent)
> +			writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL,
> +			       &priv_dev->regs->ep_cmd);
> +
> +		cdns3_prepare_setup_packet(priv_dev);
> +		request->actual = 0;
> +		priv_dev->status_completion_no_call = true;
> +		priv_dev->pending_status_request = request;
> +		spin_unlock_irqrestore(&priv_dev->lock, flags);
> +
> +		/*
> +		 * Since there is no completion interrupt for status stage,
> +		 * it needs to call ->completion in software after
> +		 * ep0_queue is back.
> +		 */
> +		queue_work(system_freezable_wq, &priv_dev->pending_status_wq);
> +		return 0;
> +	}
> +
> +	spin_lock_irqsave(&priv_dev->lock, flags);
> +	if (!list_empty(&priv_ep->request_list)) {
> +		dev_err(&priv_dev->dev,
> +			"can't handle multiple requests for ep0\n");
> +		spin_unlock_irqrestore(&priv_dev->lock, flags);
> +		return -EOPNOTSUPP;

-EBUSY?

> +	}
> +
> +	ret = usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
> +					    priv_dev->ep0_data_dir);
> +	if (ret) {
> +		spin_unlock_irqrestore(&priv_dev->lock, flags);
> +		dev_err(&priv_dev->dev, "failed to map request\n");
> +		return -EINVAL;
> +	}
> +
> +	priv_dev->ep0_request = request;
> +	list_add_tail(&request->list, &priv_ep->request_list);
> +	cdns3_ep0_run_transfer(priv_dev, request->dma, request->length, 1);
> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
> +
> +	return ret;
> +}
> +
>  /**
>   * cdns3_gadget_ep_set_wedge Set wedge on selected endpoint
>   * @ep: endpoint object
> @@ -41,6 +215,17 @@ int cdns3_gadget_ep_set_wedge(struct usb_ep *ep)
>  	return 0;
>  }
>  
> +const struct usb_ep_ops cdns3_gadget_ep0_ops = {
> +	.enable = cdns3_gadget_ep0_enable,
> +	.disable = cdns3_gadget_ep0_disable,
> +	.alloc_request = cdns3_gadget_ep_alloc_request,
> +	.free_request = cdns3_gadget_ep_free_request,
> +	.queue = cdns3_gadget_ep0_queue,
> +	.dequeue = cdns3_gadget_ep_dequeue,
> +	.set_halt = cdns3_gadget_ep0_set_halt,
> +	.set_wedge = cdns3_gadget_ep_set_wedge,
> +};
> +
>  /**
>   * cdns3_ep0_config - Configures default endpoint
>   * @priv_dev: extended gadget object
> @@ -62,6 +247,9 @@ void cdns3_ep0_config(struct cdns3_device *priv_dev)
>  		priv_dev->ep0_request = NULL;
>  	}
>  
> +	priv_dev->u1_allowed = 0;
> +	priv_dev->u2_allowed = 0;
> +

where do you set these?

>  	priv_dev->gadget.ep0->maxpacket = max_packet_size;
>  	cdns3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(max_packet_size);
>  
> @@ -106,8 +294,7 @@ int cdns3_init_ep0(struct cdns3_device *priv_dev)
>  	sprintf(ep0->name, "ep0");
>  
>  	/* fill linux fields */
> -	//TODO: implements cdns3_gadget_ep0_ops object
> -	//ep0->endpoint.ops = &cdns3_gadget_ep0_ops;
> +	ep0->endpoint.ops = &cdns3_gadget_ep0_ops;
>  	ep0->endpoint.maxburst = 1;
>  	usb_ep_set_maxpacket_limit(&ep0->endpoint, ENDPOINT0_MAX_PACKET_LIMIT);
>  	ep0->endpoint.address = 0;
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 1f2a434486dc..c965da16c0c8 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -188,6 +188,14 @@ static void cdns3_ep_stall_flush(struct cdns3_endpoint *priv_ep)
>  	priv_ep->flags |= EP_STALL;
>  }
>  

> +void cdns3_enable_l1(struct cdns3_device *priv_dev, int enable)

Some comment might help as to what L1 is.

> +{
> +	if (enable)
> +		writel(USB_CONF_L1EN, &priv_dev->regs->usb_conf);
> +	else
> +		writel(USB_CONF_L1DS, &priv_dev->regs->usb_conf);
> +}
> +
>  /**
>   * cdns3_gadget_giveback - call struct usb_request's ->complete callback
>   * @priv_ep: The endpoint to whom the request belongs to
> diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
> index a4be288b34cb..224f6b830bc9 100644
> --- a/drivers/usb/cdns3/gadget.h
> +++ b/drivers/usb/cdns3/gadget.h
> @@ -1068,11 +1068,21 @@ struct cdns3_device {
>  	struct usb_request		*pending_status_request;
>  };
>  
> +int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
>  void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
>  int cdns3_init_ep0(struct cdns3_device *priv_dev);
>  void cdns3_ep0_config(struct cdns3_device *priv_dev);
>  void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep);
> +void cdns3_enable_l1(struct cdns3_device *priv_dev, int enable);
> +struct usb_request *cdns3_next_request(struct list_head *list);
> +int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
> +			  struct usb_request *request);
>  int cdns3_gadget_ep_set_wedge(struct usb_ep *ep);
>  int cdns3_gadget_ep_set_halt(struct usb_ep *ep, int value);
> +struct usb_request *cdns3_gadget_ep_alloc_request(struct usb_ep *ep,
> +						  gfp_t gfp_flags);
> +void cdns3_gadget_ep_free_request(struct usb_ep *ep,
> +				  struct usb_request *request);
> +int cdns3_gadget_ep_dequeue(struct usb_ep *ep, struct usb_request *request);
>  
>  #endif /* __LINUX_CDNS3_GADGET */
> 

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
