Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8235C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7936218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfAWTP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:15:26 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:50372 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725976AbfAWTPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:15:25 -0500
Received: (qmail 5728 invoked by uid 2102); 23 Jan 2019 14:15:24 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jan 2019 14:15:24 -0500
Date:   Wed, 23 Jan 2019 14:15:24 -0500 (EST)
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
Subject: Re: [PATCH v3 4/5] usb: linux/fsl_device: Add platform member
 has_fsl_erratum_a006918
In-Reply-To: <20190123070615.14462-4-yinbo.zhu@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1901231413120.1564-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019, Yinbo Zhu wrote:

> From: Yinbo Zhu <yinbo.zhu@nxp.com>
> 
> This patch is to add member has_fsl_erratum_a006918 in platform data

This should come before patch 3/5.  Otherwise that patch will get a 
compile error when it tries to reference the has_fsl_erratum_a006918 
field and the field hasn't been created yet.

Alan Stern

> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  include/linux/fsl_devices.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
> index 5da56a6..4c613da 100644
> --- a/include/linux/fsl_devices.h
> +++ b/include/linux/fsl_devices.h
> @@ -102,6 +102,7 @@ struct fsl_usb2_platform_data {
>  	unsigned	has_fsl_erratum_14:1;
>  	unsigned	has_fsl_erratum_a005275:1;
>  	unsigned	has_fsl_erratum_a005697:1;
> +	unsigned        has_fsl_erratum_a006918:1;
>  	unsigned	check_phy_clk_valid:1;
>  
>  	/* register save area for suspend/resume */
> 

