Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCCCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375632147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfA1Pdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:33:54 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:57014 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726694AbfA1Pdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:33:54 -0500
Received: (qmail 3364 invoked by uid 2102); 28 Jan 2019 10:33:53 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jan 2019 10:33:53 -0500
Date:   Mon, 28 Jan 2019 10:33:53 -0500 (EST)
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
Subject: Re: [PATCH v4 1/5] usb: fsl: Set USB_EN bit to select ULPI phy
In-Reply-To: <20190125060356.14294-1-yinbo.zhu@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1901281033270.1450-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019, Yinbo Zhu wrote:

> From: Nikhil Badola <nikhil.badola@freescale.com>
> 
> Set USB_EN bit to select ULPI phy for USB controller version 2.5
> 
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> Change in v4:
> 		Incorrect indentation of the continuation line
> 
>  drivers/usb/host/ehci-fsl.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index e3d0c1c..38674b7 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -122,6 +122,12 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
>  		tmp |= 0x4;
>  		iowrite32be(tmp, hcd->regs + FSL_SOC_USB_CTRL);
>  	}
> +
> +	/* Set USB_EN bit to select ULPI phy for USB controller version 2.5 */
> +	if (pdata->controller_ver == FSL_USB_VER_2_5 &&
> +	    pdata->phy_mode == FSL_USB2_PHY_ULPI)
> +		iowrite32be(USB_CTRL_USB_EN, hcd->regs + FSL_SOC_USB_CTRL);
> +
>  	/*
>  	 * Enable UTMI phy and program PTS field in UTMI mode before asserting
>  	 * controller reset for USB Controller version 2.5
> 

