Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2F4ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4AC2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sTjucxrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4AC2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeINUDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:03:32 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36868 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeINUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:03:30 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3406DB91;
        Fri, 14 Sep 2018 16:48:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536936518;
        bh=UI1pAg4pQGk6Owf4KVN5N4RrAsV1XW0I3QIg2nOTPhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTjucxrROInYUty//Twu/xS7DO3geHkwDjICCcGVUlGXLwvZzIX7eieG3yfyGHXbB
         bu4MrC0F8Z8hLECXRiMxdF94ViqGqzRByPMPMMoQriWc4qDkJqvDd1QhWCcnC086Kk
         Di4FtBicv0J7o5dvuBbk4wCGuB+He5t/zrN9g4og=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v2 1/2] media: vsp1: Document max_width restriction on SRU
Date:   Fri, 14 Sep 2018 17:48:51 +0300
Message-ID: <3654115.xQLpRLqA9F@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180914142652.30484-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180914142652.30484-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Friday, 14 September 2018 17:26:51 EEST Kieran Bingham wrote:
> The SRU is currently restricted to 256 pixels as part of the current
> partition algorithm. Document that the actual capability of this
> component is 288 pixels, but don't increase the implementation.
> 
> The extended partition algorithm may later choose to utilise a larger
> input to support overlapping partitions which will improve the quality
> of the output images.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/vsp1/vsp1_sru.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_sru.c
> b/drivers/media/platform/vsp1/vsp1_sru.c index d216707f64c9..19f91eb81134
> 100644
> --- a/drivers/media/platform/vsp1/vsp1_sru.c
> +++ b/drivers/media/platform/vsp1/vsp1_sru.c
> @@ -314,6 +314,11 @@ static unsigned int sru_max_width(struct vsp1_entity
> *entity, output = vsp1_entity_get_pad_format(&sru->entity,
> sru->entity.config, SRU_PAD_SOURCE);
> 
> +	/*
> +	 * The maximum input width of the SRU is 288 input pixels, but 32
> +	 * pixels are reserved to support overlapping partition windows when
> +	 * scaling.
> +	 */
>  	if (input->width != output->width)
>  		return 512;
>  	else


-- 
Regards,

Laurent Pinchart



