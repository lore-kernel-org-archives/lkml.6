Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30176C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB4320815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB4320815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeKREZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:25:05 -0500
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:48491 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbeKREZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:25:05 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9E38A182CED5B;
        Sat, 17 Nov 2018 18:07:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: train75_805a7e24805b
X-Filterd-Recvd-Size: 6341
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 17 Nov 2018 18:07:34 +0000 (UTC)
Message-ID: <7ed4782b8872b5bf2788d4ce440149112f7e3c4b.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: emxx_udc: Split line and fix eol
 parenthesis
From:   Joe Perches <joe@perches.com>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 17 Nov 2018 10:07:33 -0800
In-Reply-To: <1542411969-26570-2-git-send-email-sicilia.cristian@gmail.com>
References: <1542411969-26570-1-git-send-email-sicilia.cristian@gmail.com>
         <1542411969-26570-2-git-send-email-sicilia.cristian@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-17 at 00:46 +0100, Cristian Sicilia wrote:
> Fix some parenthesis opened at end of line.

It looks like this is all guarded by #ifdef UDC_DEBUG_DUMP
which is not ever set and this probably would not compile
if it was.

It's probably better to remove all the blocks guarded by
that flag and the flag itself.

> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 73 ++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index bf7c5da..26bd77c 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -108,20 +108,20 @@ static void _nbu2ss_dump_register(struct nbu2ss_udc *udc)
>  
>  	dev_dbg(&udc->dev, "\n-USB REG-\n");
>  	for (i = 0x0 ; i < USB_BASE_SIZE ; i += 16) {
> -		reg_data =   _nbu2ss_readl(
> -			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i));
> +		reg_data = _nbu2ss_readl((u32 *)IO_ADDRESS(USB_BASE_ADDRESS +
> +					i));
>  		dev_dbg(&udc->dev, "USB%04x =%08x", i, (int)reg_data);
>  
> -		reg_data =  _nbu2ss_readl(
> -			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 4));
> +		reg_data = _nbu2ss_readl((u32 *)IO_ADDRESS(USB_BASE_ADDRESS +
> +					i + 4));
>  		dev_dbg(&udc->dev, " %08x", (int)reg_data);
>  
> -		reg_data =  _nbu2ss_readl(
> -			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 8));
> +		reg_data = _nbu2ss_readl((u32 *)IO_ADDRESS(USB_BASE_ADDRESS +
> +					i + 8));
>  		dev_dbg(&udc->dev, " %08x", (int)reg_data);
>  
> -		reg_data =  _nbu2ss_readl(
> -			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 12));
> +		reg_data = _nbu2ss_readl((u32 *)IO_ADDRESS(USB_BASE_ADDRESS +
> +					i + 12));
>  		dev_dbg(&udc->dev, " %08x\n", (int)reg_data);
>  	}
>  
> @@ -473,22 +473,23 @@ static void _nbu2ss_dma_map_single(
>  		if (req->unaligned) {
>  			req->req.dma = ep->phys_buf;
>  		} else {
> -			req->req.dma = dma_map_single(
> -				udc->gadget.dev.parent,
> -				req->req.buf,
> -				req->req.length,
> -				(direct == USB_DIR_IN)
> -				? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +			req->req.dma =
> +				dma_map_single(udc->gadget.dev.parent,
> +					       req->req.buf,
> +					       req->req.length,
> +					       (direct == USB_DIR_IN) ?
> +						DMA_TO_DEVICE :
> +						DMA_FROM_DEVICE);
>  		}
>  		req->mapped = 1;
>  	} else {
>  		if (!req->unaligned)
> -			dma_sync_single_for_device(
> -				udc->gadget.dev.parent,
> -				req->req.dma,
> -				req->req.length,
> -				(direct == USB_DIR_IN)
> -				? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +			dma_sync_single_for_device(udc->gadget.dev.parent,
> +						   req->req.dma,
> +						   req->req.length,
> +						   (direct == USB_DIR_IN)
> +						    ? DMA_TO_DEVICE :
> +						    DMA_FROM_DEVICE);
>  
>  		req->mapped = 0;
>  	}
> @@ -975,8 +976,8 @@ static int _nbu2ss_epn_out_transfer(
>  
>  	/*-------------------------------------------------------------*/
>  	/* Receive Length */
> -	i_recv_length
> -		= _nbu2ss_readl(&preg->EP_REGS[num].EP_LEN_DCNT) & EPN_LDATA;
> +	i_recv_length =
> +		_nbu2ss_readl(&preg->EP_REGS[num].EP_LEN_DCNT) & EPN_LDATA;
>  
>  	if (i_recv_length != 0) {
>  		result = _nbu2ss_epn_out_data(udc, ep, req, i_recv_length);
> @@ -1115,10 +1116,9 @@ static int _nbu2ss_epn_in_pio(
>  		i_word_length = length / sizeof(u32);
>  		if (i_word_length > 0) {
>  			for (i = 0; i < i_word_length; i++) {
> -				_nbu2ss_writel(
> -					&preg->EP_REGS[ep->epnum - 1].EP_WRITE
> -					, p_buf_32->dw
> -				);
> +				_nbu2ss_writel(&preg->EP_REGS[ep->epnum -
> +							      1].EP_WRITE,
> +					       p_buf_32->dw);
>  
>  				p_buf_32++;
>  			}
> @@ -1472,13 +1472,11 @@ static inline int _nbu2ss_req_feature(struct nbu2ss_udc *udc, bool bset)
>  		if (0x0000 == (wIndex & 0xFF70)) {
>  			if (selector == USB_ENDPOINT_HALT) {
>  				ep_adrs = wIndex & 0xFF;
> -				if (!bset) {
> -					_nbu2ss_endpoint_toggle_reset(
> -						udc, ep_adrs);
> -				}
> +				if (!bset)
> +					_nbu2ss_endpoint_toggle_reset(udc,
> +								      ep_adrs);
>  
> -				_nbu2ss_set_endpoint_stall(
> -					udc, ep_adrs, bset);
> +				_nbu2ss_set_endpoint_stall(udc, ep_adrs, bset);
>  
>  				result = 0;
>  			}
> @@ -1524,8 +1522,8 @@ static void _nbu2ss_epn_set_stall(
>  		for (limit_cnt = 0
>  			; limit_cnt < IN_DATA_EMPTY_COUNT
>  			; limit_cnt++) {
> -			regdata = _nbu2ss_readl(
> -				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
> +			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum -
> +							       1].EP_STATUS);
>  
>  			if ((regdata & EPN_IN_DATA) == 0)
>  				break;
> @@ -2666,9 +2664,10 @@ static int nbu2ss_ep_queue(
>  
>  	if (req->unaligned) {
>  		if (!ep->virt_buf)
> -			ep->virt_buf = dma_alloc_coherent(
> -				NULL, PAGE_SIZE,
> -				&ep->phys_buf, GFP_ATOMIC | GFP_DMA);
> +			ep->virt_buf = dma_alloc_coherent(NULL,
> +							  PAGE_SIZE,
> +							  &ep->phys_buf,
> +							  GFP_ATOMIC | GFP_DMA);
>  		if (ep->epnum > 0)  {
>  			if (ep->direct == USB_DIR_IN)
>  				memcpy(ep->virt_buf, req->req.buf,

