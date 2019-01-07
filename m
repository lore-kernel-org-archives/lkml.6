Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC4EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8421121855
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p4tVf4gP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfAGTrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:47:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39118 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfAGTrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:47:35 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x07JlQXR027689;
        Mon, 7 Jan 2019 13:47:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546890446;
        bh=OAFsEGX65HZt0ksZDgtSE5/pDgQZSHK+rmU6cGkmFUg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=p4tVf4gPsAz1DJKY56Grn/SahFlqKoeU5SLaQsk8NcI4SePXmXJwLtVapkJSAs1Ef
         lYF0aa5k/aUJlsiGhVAMnYxVJO9M39CL+pLa78eWnnmaGb8QQRNwFvNPhd0ULkM9Xf
         ZVVtolReFFhlNR7iWAIiD4x2tePODxN1yFrtEB7s=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x07JlQ8p047721
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 13:47:26 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 13:47:26 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 13:47:25 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x07JlPZ2028921;
        Mon, 7 Jan 2019 13:47:25 -0600
Date:   Mon, 7 Jan 2019 13:47:25 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <od@zcrc.me>
Subject: Re: [PATCH 2/4] usb: musb: jz4740: Add support for devicetree
Message-ID: <20190107194725.GB25910@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me
References: <20181213144555.24031-1-paul@crapouillou.net>
 <20181213144555.24031-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181213144555.24031-2-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 13, 2018 at 03:45:53PM +0100, Paul Cercueil wrote:
> Add support for probing the driver from devicetree.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/usb/musb/jz4740.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
> index 04d8b2bc205a..9a2cebcac260 100644
> --- a/drivers/usb/musb/jz4740.c
> +++ b/drivers/usb/musb/jz4740.c
> @@ -10,6 +10,7 @@
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/usb/usb_phy_generic.h>
>  
> @@ -188,11 +189,17 @@ static int jz4740_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id jz4740_musb_of_match[] = {
> +	{ .compatible = "ingenic,jz4740-musb" },
> +	{},
> +};

should be wrapped by '#ifdef CONFIG_OF'?

miss MODULE_DEVICE_TABLE()

> +
>  static struct platform_driver jz4740_driver = {
>  	.probe		= jz4740_probe,
>  	.remove		= jz4740_remove,
>  	.driver		= {
>  		.name	= "musb-jz4740",
> +		.of_match_table = of_match_ptr(jz4740_musb_of_match),
>  	},
>  };
>  

Regards,
-Bin.
