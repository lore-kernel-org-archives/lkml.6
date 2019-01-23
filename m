Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB112C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879CF21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfAWTRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:17:02 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:50396 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725976AbfAWTRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:17:01 -0500
Received: (qmail 5749 invoked by uid 2102); 23 Jan 2019 14:17:00 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jan 2019 14:17:00 -0500
Date:   Wed, 23 Jan 2019 14:17:00 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
cc:     Xiaobo Xie <xiaobo.xie@nxp.com>, Jerry Huang <jerry.huang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] usb :fsl: Change string format for errata property
In-Reply-To: <20190123070615.14462-5-yinbo.zhu@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1901231416040.1564-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019, Yinbo Zhu wrote:

> From: Nikhil Badola <nikhil.badola@freescale.com>
> 
> Remove USB errata checking code from driver. Applicability of erratum
> is retrieved by reading corresponding property in device tree.
> This property is written during device tree fixup.
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  drivers/usb/host/fsl-mph-dr-of.c |   14 ++++----------
>  1 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
> index bdc8812..ae8f60f 100644
> --- a/drivers/usb/host/fsl-mph-dr-of.c
> +++ b/drivers/usb/host/fsl-mph-dr-of.c
> @@ -224,16 +224,10 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
>  		of_property_read_bool(np, "fsl,usb-erratum-a005275");
>  	pdata->has_fsl_erratum_a005697 =
>  		of_property_read_bool(np, "fsl,usb_erratum-a005697");
> -
> -	if (of_get_property(np, "fsl,usb_erratum_14", NULL))
> -		pdata->has_fsl_erratum_14 = 1;
> -	else
> -		pdata->has_fsl_erratum_14 = 0;
> -
> -	if (of_get_property(np, "fsl,erratum_a006918", NULL))
> -		pdata->has_fsl_erratum_a006918 = 1;
> -	else
> -		pdata->has_fsl_erratum_a006918 = 0;
> +	pdata->has_fsl_erratum_a006918 =
> +		of_property_read_bool(np, "fsl,usb_erratum-a006918");
> +	pdata->has_fsl_erratum_14 =
> +		of_property_read_bool(np, "fsl,usb_erratum-14");

Why go to the trouble of adding bad code for has_fsl_erratum_a006918 in 
patch 4/5 if you're going to change that code here?  Why not just add 
the correct code in the first place?

Alan Stern

>  
>  	/*
>  	 * Determine whether phy_clk_valid needs to be checked
> 

