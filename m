Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8F6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B227B20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Kf+al8nJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B227B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJaDst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:48:49 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:32846 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeJaDss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:48:48 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5200B992;
        Tue, 30 Oct 2018 19:54:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1540925646;
        bh=ZDssyjrsU5gG9Pi4XJoXvEYmbC9GhmQp2mbvK23mU+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kf+al8nJtJ/C9Apl9RHr56dNCn2bEh5S7Jf5C2ogQezkiaSPRNSrW4vKw6Z4yYOc2
         AotISJ80pog7321VVxmo3S/jyo3jNtqk8T8bjt9iIQUBqilj+paXWsdQVd2Nzsvril
         6oK92c4gmNg/5HBtJqBLwLUk8D9yGf2mFpaNeBJg=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: uvc: constify vb2_ops structure
Date:   Tue, 30 Oct 2018 20:54:10 +0200
Message-ID: <1946389.baEqsO8ef2@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1540913482-22130-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1540913482-22130-1-git-send-email-Julia.Lawall@lip6.fr> <1540913482-22130-2-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Julia,

Thank you for the patch.

On Tuesday, 30 October 2018 17:31:21 EET Julia Lawall wrote:
> The vb2_ops structure can be const as it is only stored in the ops
> field of a vb2_queue structure and this field is const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  drivers/usb/gadget/function/uvc_queue.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_queue.c
> b/drivers/usb/gadget/function/uvc_queue.c index 9e33d5206d54..526a10a33094
> 100644
> --- a/drivers/usb/gadget/function/uvc_queue.c
> +++ b/drivers/usb/gadget/function/uvc_queue.c
> @@ -102,7 +102,7 @@ static void uvc_buffer_queue(struct vb2_buffer *vb)
>  	spin_unlock_irqrestore(&queue->irqlock, flags);
>  }
> 
> -static struct vb2_ops uvc_queue_qops = {
> +static const struct vb2_ops uvc_queue_qops = {
>  	.queue_setup = uvc_queue_setup,
>  	.buf_prepare = uvc_buffer_prepare,
>  	.buf_queue = uvc_buffer_queue,

-- 
Regards,

Laurent Pinchart



