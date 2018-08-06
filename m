Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F190C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF2921A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WMgLZprW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF2921A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbeHGAb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:31:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46402 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732106AbeHGAb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:31:28 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DED3857;
        Tue,  7 Aug 2018 00:20:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533594018;
        bh=CTqIyR9knnovC5u0vrMq50+i/mCBc+KsfJYih8y1KCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMgLZprW7kI3dD+A1Fan/mkT9b1FRvz2PvvMz+aUntDpq48ezBXwRwcUyrr0VJ8rz
         ZUm64AAiRhzmIyKmeHOHz2n1jeN1CovErlQ2y018qh6VtXYAtFkavo/h2IrB7rcBo4
         sUAltr8bM4hBt5rSBe8clFYGgkpgN680zHOE9FeQ=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Joe Perches <joe@perches.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Make some structs const
Date:   Tue, 07 Aug 2018 01:21:01 +0300
Message-ID: <5812728.94RVy69Rc3@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <0e85822616b665b20bc5b883d5be4a1265137f87.1509816184.git.joe@perches.com>
References: <0e85822616b665b20bc5b883d5be4a1265137f87.1509816184.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Thank you for the patch.

On Saturday, 4 November 2017 19:23:29 EEST Joe Perches wrote:
> Move some data to text
> 
> $ size drivers/media/usb/uvc/uvc_ctrl.o*
>    text	   data	    bss	    dec	    hex	filename
>   34323	   2364	      0	  36687	   8f4f	drivers/media/usb/uvc/
uvc_ctrl.o.new
> 28659	   8028	      0	  36687	   8f4f	drivers/media/usb/uvc/
uvc_ctrl.o.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and taken in my tree.

> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c
> b/drivers/media/usb/uvc/uvc_ctrl.c index 20397aba6849..44a0554bf62d 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -37,7 +37,7 @@
>   * Controls
>   */
> 
> -static struct uvc_control_info uvc_ctrls[] = {
> +static const struct uvc_control_info uvc_ctrls[] = {
>  	{
>  		.entity		= UVC_GUID_UVC_PROCESSING,
>  		.selector	= UVC_PU_BRIGHTNESS_CONTROL,
> @@ -420,7 +420,7 @@ static void uvc_ctrl_set_rel_speed(struct
> uvc_control_mapping *mapping, data[first+1] = min_t(int, abs(value), 0xff);
>  }
> 
> -static struct uvc_control_mapping uvc_ctrl_mappings[] = {
> +static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>  	{
>  		.id		= V4L2_CID_BRIGHTNESS,
>  		.name		= "Brightness",


-- 
Regards,

Laurent Pinchart



