Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B595ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ED520877
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="upnasmhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38ED520877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbeIUCH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:07:57 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36292 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeIUCH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:07:57 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1041B1C86;
        Thu, 20 Sep 2018 22:22:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537474962;
        bh=iCGwgCLg1cdX84Rj5gIIXxVpATBoPydFA8eeXDZkFjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upnasmhJar19k+VWZHc5JuKfqwdEq/sK5HhMHoxdlNbEV/4hyxKIrmtw7+FpIRwCo
         iJpjIiTnXYhZZdYuJv2s0NHvURyAnfrONpHiHGgg2JNTC9hKUw9e9JAfEclVwHAYAC
         L3xk2jsfg8vfFlVMD0BqyJJuGoFaWiI0y1g876H8=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [PATCH 1/4] [media] ad5820: Define entity function
Date:   Thu, 20 Sep 2018 23:22:55 +0300
Message-ID: <512495074.bF91m146Of@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
References: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Thursday, 20 September 2018 19:19:09 EEST Ricardo Ribalda Delgado wrote:
> Without this patch, media_device_register_entity throws a warning:
> 
> dev_warn(mdev->dev,
> 	 "Entity type for entity %s was not initialized!\n",
> 	 entity->name);
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/ad5820.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
> index 907323f0ca3b..22759aaa2dba 100644
> --- a/drivers/media/i2c/ad5820.c
> +++ b/drivers/media/i2c/ad5820.c
> @@ -317,6 +317,7 @@ static int ad5820_probe(struct i2c_client *client,
>  	v4l2_i2c_subdev_init(&coil->subdev, client, &ad5820_ops);
>  	coil->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>  	coil->subdev.internal_ops = &ad5820_internal_ops;
> +	coil->subdev.entity.function = MEDIA_ENT_F_LENS;
>  	strscpy(coil->subdev.name, "ad5820 focus", sizeof(coil->subdev.name));
> 
>  	ret = media_entity_pads_init(&coil->subdev.entity, 0, NULL);


-- 
Regards,

Laurent Pinchart



