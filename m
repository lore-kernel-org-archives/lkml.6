Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC0120855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="tsfB+2DN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E+mSePgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfARE6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:58:25 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50535 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726902AbfARE6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:58:25 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 287D927513;
        Thu, 17 Jan 2019 23:58:24 -0500 (EST)
Received: from web6 ([10.202.2.216])
  by compute4.internal (MEProxy); Thu, 17 Jan 2019 23:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        message-id:from:to:cc:mime-version:content-transfer-encoding
        :content-type:references:in-reply-to:date:subject; s=fm1; bh=FSs
        3M3hmz3f0DGGFuPlnrdj30ljpMXiUZSOaJ/70si8=; b=tsfB+2DNiJUhsONOA5k
        Lq2WAYQ81tta40/X7feIMpU0jY3mFYeWk4eg6zJ21qBJIbvp7fpxie7vx65RE1mc
        bGm5aP2BUSEzOebzg7swKML6z482AZkJtaIPY+puoZkX2yrcgf7y5c+saX4DqANU
        OfFlJ4ektpX7rciaWpvgAgOdn5letzCdeg+6N8h/DqULT81VaZioqDTmc9dws6H/
        gUD0d5WqP1hWUcnYFHcMdNAzEmHpYXeTIezqrO/QZ4CVh+h6CLINh22CfO0BhYZS
        d9DFYVhjvZuAchjSo5ZLYsi3LuHfwgLEn42Je+oynHw65zC3uhhx0acerwLlAO5x
        FVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=FSs3M3hmz3f0DGGFuPlnrdj30ljpMXiUZSOaJ/70s
        i8=; b=E+mSePgbwggEbElvu9zkYYi8CabJykXFIc5sRqfaMDf7WjPUmf4FPVh1T
        oQmvL1NYkB/UhGzHWgHHC7iSyOq5GELiH1nQ+ad0La4OqYkpOStLeyWQapi3t1or
        sy0CqEG6OjH7/TbyK0MnMlebYVmekyWOghUb58CEgE7ZYlGo7oeD+qY5yL0+3r/1
        494h1RScxktWDtXci0IYiN7PbhAc6KhzWLYS5vvguUAdd6dmI9Es04JknGIrfx+X
        XSRX/eJbrykeV/T5i4vd46tnZyX6aJlx5WCa48uqlpOe6jy6Bso3GK8GJQ3vpiWJ
        tEqd0e85+IrAKiPpHL/6dfsSbKqQg==
X-ME-Sender: <xms:71xBXEoXaK88eNxR389u3H6Ko2686eXJeDmPquI01UHRJk9ZutrD3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrgeelgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffhvfgggfgtof
    hfjgffufesthejredtredtjeenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceo
    rghnughrvgifsegrjhdrihgurdgruheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnh
    gurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:71xBXG8w-IWp-H8VCDYbOLgDTcQc2AdiixFpb3cZNuW3xUXeWtAHlQ>
    <xmx:71xBXK37eah2EqEuD7P6OdcKQhCIscvsPNTYg4ZZLN5d5a2h4kYC9g>
    <xmx:71xBXJBVzqZiJvLbHiQLhFUPJK9GIDlAEeXZx41IgU5DkeXmsjB_xQ>
    <xmx:8FxBXModPjVQdNOkpjnCcbQLXGcK93tC65ZlyUxhjM2LmVDk9G81hw>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id D2606429B; Thu, 17 Jan 2019 23:58:22 -0500 (EST)
Message-Id: <1547787502.2061444.1637712576.1F1E21B4@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Vijay Khemka <vijaykhemka@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-36e4bfd3
References: <20190116220154.1026171-1-vijaykhemka@fb.com>
In-Reply-To: <20190116220154.1026171-1-vijaykhemka@fb.com>
Date:   Fri, 18 Jan 2019 15:28:22 +1030
Subject: Re: [PATCH v2] misc: aspeed-lpc-ctrl: make parameter optional
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

Thanks for doing the work to fix the driver. Some minor queries/points
below.

On Thu, 17 Jan 2019, at 08:31, Vijay Khemka wrote:
> Makiing memory-region and flash as optional parameter in device
> tree if user needs to use these parameter through ioctl then
> need to define in devicetree.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 58 +++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-
> ctrl.c
> index a024f8042259..332210e06e98 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -68,6 +68,7 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, 
> unsigned int cmd,
>  		unsigned long param)
>  {
>  	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
> +	struct device *dev = file->private_data;
>  	void __user *p = (void __user *)param;
>  	struct aspeed_lpc_ctrl_mapping map;
>  	u32 addr;
> @@ -90,6 +91,12 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, 
> unsigned int cmd,
>  		if (map.window_id != 0)
>  			return -EINVAL;
>  
> +		/* If memory-region is not described in device tree */
> +		if (!lpc_ctrl->mem_size) {
> +			dev_err(dev, "Didn't find reserved memory\n");
> +			return -EINVAL;

I feel like EINVAL isn't quite right - it's pretty generic, and the parameter
value changes its validity with the devicetree context. My gut instinct
would be to use EINVAL for parameter values that violate assumptions
of the driver rather than violate configuration of the driver. Maybe ENXIO
("No such device or address") is an improvement: "I can't map that device
because there's no such device or address"?

> +		}
> +
>  		map.size = lpc_ctrl->mem_size;
>  
>  		return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
> @@ -126,9 +133,18 @@ static long aspeed_lpc_ctrl_ioctl(struct file 
> *file, unsigned int cmd,
>  			return -EINVAL;
>  
>  		if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
> +			if (!lpc_ctrl->pnor_size) {
> +				dev_err(dev, "Didn't find host pnor flash\n");
> +				return -EINVAL;

See the error code discussion above. Also, this is userspace's error not 
the kernel's, so I think dev_err() is a bit harsh. Probably best to just let
userspace log the error if it thinks the it is concerning.

> +			}
>  			addr = lpc_ctrl->pnor_base;
>  			size = lpc_ctrl->pnor_size;
>  		} else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
> +			/* If memory-region is not described in device tree */
> +			if (!lpc_ctrl->mem_size) {
> +				dev_err(dev, "Didn't find reserved memory\n");
> +				return -EINVAL;

as above.

> +			}
>  			addr = lpc_ctrl->mem_base;
>  			size = lpc_ctrl->mem_size;
>  		} else {
> @@ -196,17 +212,17 @@ static int aspeed_lpc_ctrl_probe(struct 
> platform_device *pdev)
>  	if (!lpc_ctrl)
>  		return -ENOMEM;
>  
> +	/* If flash is described in device tree then store */
>  	node = of_parse_phandle(dev->of_node, "flash", 0);
>  	if (!node) {
> -		dev_err(dev, "Didn't find host pnor flash node\n");
> -		return -ENODEV;
> -	}
> -
> -	rc = of_address_to_resource(node, 1, &resm);
> -	of_node_put(node);
> -	if (rc) {
> -		dev_err(dev, "Couldn't address to resource for flash\n");
> -		return rc;
> +		dev_dbg(dev, "Didn't find host pnor flash node\n");
> +	} else {
> +		rc = of_address_to_resource(node, 1, &resm);
> +		of_node_put(node);
> +		if (rc) {
> +			dev_err(dev, "Couldn't address to resource for flash\n");
> +			return rc;
> +		}
>  	}
>  
>  	lpc_ctrl->pnor_size = resource_size(&resm);
> @@ -214,22 +230,22 @@ static int aspeed_lpc_ctrl_probe(struct 
> platform_device *pdev)
>  
>  	dev_set_drvdata(&pdev->dev, lpc_ctrl);
>  
> +	/* If memory-region is described in device tree then store */
>  	node = of_parse_phandle(dev->of_node, "memory-region", 0);
>  	if (!node) {
> -		dev_err(dev, "Didn't find reserved memory\n");
> -		return -EINVAL;
> -	}
> +		dev_dbg(dev, "Didn't find reserved memory\n");
> +	} else {
> +		rc = of_address_to_resource(node, 0, &resm);
> +		of_node_put(node);
> +		if (rc) {
> +			dev_err(dev, "Couldn't address to resource for reserved memory\n");
> +			return -ENOMEM;

Wow, I think this is an abuse of ENOMEM. Its description is "Out of memory"
which doesn't really reflect the problem here.

Not really your fault though, maybe we'll fix that with some follow-up patches.

Cheers,

Andrew

> +		}
>  
> -	rc = of_address_to_resource(node, 0, &resm);
> -	of_node_put(node);
> -	if (rc) {
> -		dev_err(dev, "Couldn't address to resource for reserved memory\n");
> -		return -ENOMEM;
> +		lpc_ctrl->mem_size = resource_size(&resm);
> +		lpc_ctrl->mem_base = resm.start;
>  	}
>  
> -	lpc_ctrl->mem_size = resource_size(&resm);
> -	lpc_ctrl->mem_base = resm.start;
> -
>  	lpc_ctrl->regmap = syscon_node_to_regmap(
>  			pdev->dev.parent->of_node);
>  	if (IS_ERR(lpc_ctrl->regmap)) {
> @@ -258,8 +274,6 @@ static int aspeed_lpc_ctrl_probe(struct 
> platform_device *pdev)
>  		goto err;
>  	}
>  
> -	dev_info(dev, "Loaded at %pr\n", &resm);
> -
>  	return 0;
>  
>  err:
> -- 
> 2.17.1
> 
