Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD764C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF9C20862
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="LPd1NthI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="shKMdaVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF9C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeKHL23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:28:29 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45629 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbeKHL23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:28:29 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 85AE721B03;
        Wed,  7 Nov 2018 20:55:23 -0500 (EST)
Received: from web3 ([10.202.2.213])
  by compute4.internal (MEProxy); Wed, 07 Nov 2018 20:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        message-id:from:to:cc:mime-version:content-transfer-encoding
        :content-type:date:in-reply-to:subject:references; s=fm1; bh=6Uw
        riMKMOlyOtDmjSIvL74stkwnnnDEh7MNlRNG/RfA=; b=LPd1NthIm29E9EbFmLQ
        DDu8mKRfgCAmGmmTo0C0gsspOr/voQhK3De79kt4eQKjZ3SLPQ+KhLeywM9pkGQ5
        SEyouH5yTUTYQJkIHTcuhego774hNfJ7odiZp3Q2dKEfN/+4i5VJPesG8VE+oE4t
        JEXSroTfM6ZBdkuMl0m/TGjR/mLngWLWfLYtijK4gRN+/AxIKqAE7UInxDJpaLf+
        gkjOC6Q6lFVmYlP34QJCK+E2ysZGeySvcQPD3lScVaZ3I1GmZ8dlrbkd23XcjMfx
        RlixnbrMFWuHo+SeXNkphcNRKXTgfosEaGVD5WILcR1oC2ZXeYstjfLiNnWqv4RZ
        evg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=6UwriMKMOlyOtDmjSIvL74stkwnnnDEh7MNlRNG/R
        fA=; b=shKMdaVIJmjRMg/opKcSl00ythranQXYPTGTWJ0pMv1ISD2iR5BdKZKeB
        BUAxu9ZupmX+E5kUUys5GYL8C6rSbaRZyoXyen7+ZfLTZ/CiWzW3TMoPObR+W5NS
        sr5kL1QBqjMAukHjliqtHdUJJYvkBbso2ujuMGORmvBUhgirPNikK3Uca634/Meo
        NId13XPtDGpvHwHND//UzNFFtYnEkVhHNbvyBAxwz7yFVM17aTIMZg2QWSBYMdna
        uSRv6tPx8N+nBJAFQfmiwjsF7TKdwJXYTPvK/ke8eDnV0p92bSKG6HdvIf3Cplxi
        42zNv+KRCelxB4y9XVU3c/Pxku/Bw==
X-ME-Sender: <xms:ipfjW2rBLFTnyxf5OLRhbz8v3jNv-8B9sE3d4CWExTFdVDz_esIunQ>
X-ME-Proxy: <xmx:ipfjW-cwjayUN4cF11gu32aefdXd5oXigVwnN2LWYKFLQPjSkALmnQ>
    <xmx:ipfjW-qXgv7j5ertxvyZJtJpGi6AW5WgMeeIkHE4SGBdm7SD4Iovig>
    <xmx:ipfjW4X9aJTyV7H0GfovwQ-u6g3axZJEls_x0tfrQzgBhtk1i34rAQ>
    <xmx:ipfjW-1UgZVUXbLX50HnHucHbcCkqub_OS0ckiMZSAlpYy8sOFpUiQ>
    <xmx:ipfjW6B1PpqJkJIgdazgyXU4nqgE91xeT9EKNZBOc2qqbtXSWu9B8w>
    <xmx:i5fjW9v2wXeog-GlOsc9YbMbCMaFXSgfXSVinv6WmzcVE-yTeddVpw>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 62F389E4F3; Wed,  7 Nov 2018 20:55:22 -0500 (EST)
Message-Id: <1541642122.1498358.1569514624.6EA70C69@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Colin King <colin.king@canonical.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-d469da0c
Date:   Thu, 08 Nov 2018 12:25:22 +1030
In-Reply-To: <20180929114313.10557-1-colin.king@canonical.com>
Subject: Re: [PATCH] usb: gadget: fix spelling mistakeis "[En]queing" ->
 "[En]queuing"
References: <20180929114313.10557-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2018, at 22:13, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistakes in debug warning messages
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c | 2 +-
>  drivers/usb/gadget/udc/udc-xilinx.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/
> gadget/udc/aspeed-vhub/epn.c
> index 5939eb1e97f2..e9ee2b72af19 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> @@ -353,7 +353,7 @@ static int ast_vhub_epn_queue(struct usb_ep* u_ep, 
> struct usb_request *u_req,
>  	/* Endpoint enabled ? */
>  	if (!ep->epn.enabled || !u_ep->desc || !ep->dev || !ep->d_idx ||
>  	    !ep->dev->enabled || ep->dev->suspended) {
> -		EPDBG(ep,"Enqueing request on wrong or disabled EP\n");
> +		EPDBG(ep, "Enqueuing request on wrong or disabled EP\n");
>  		return -ESHUTDOWN;
>  	}
>  
> diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/
> udc/udc-xilinx.c
> index 6407e433bc78..b1f4104d1283 100644
> --- a/drivers/usb/gadget/udc/udc-xilinx.c
> +++ b/drivers/usb/gadget/udc/udc-xilinx.c
> @@ -1078,7 +1078,7 @@ static int xudc_ep_queue(struct usb_ep *_ep, 
> struct usb_request *_req,
>  	unsigned long flags;
>  
>  	if (!ep->desc) {
> -		dev_dbg(udc->dev, "%s:queing request to disabled %s\n",
> +		dev_dbg(udc->dev, "%s: queuing request to disabled %s\n",
>  			__func__, ep->name);
>  		return -ESHUTDOWN;
>  	}
> -- 
> 2.17.1
> 
