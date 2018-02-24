Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeBXJIe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 04:08:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750844AbeBXJIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 04:08:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B23821741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Sat, 24 Feb 2018 17:08:21 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mx35_3ds: remove unnecessary USB OTG init flag
Message-ID: <20180224090818.GP3217@dragon>
References: <1519251463-12318-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519251463-12318-1-git-send-email-martin@kaiser.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 11:17:43PM +0100, Martin Kaiser wrote:
> The platform-specific init function for the USB OTG port,
> mx35_3ds_otg_init(), sets the MXC_EHCI_INTERNAL_PHY flag.
> 
> This flag is applicable only to the host port, not to the OTG port. It's
> ignored by mx35_initialize_usb_hw() when the OTG port is initialized.
> 
> Remove the flag to make it clear what is actually configured.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

We do not take any patch on legacy board files, unless it fixes some
real problem.

Shawn

> ---
>  arch/arm/mach-imx/mach-mx35_3ds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
> index 1c33a6c..f1963f2 100644
> --- a/arch/arm/mach-imx/mach-mx35_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx35_3ds.c
> @@ -407,7 +407,7 @@ static void __init imx35_3ds_init_mc13892(void)
>  
>  static int mx35_3ds_otg_init(struct platform_device *pdev)
>  {
> -	return mx35_initialize_usb_hw(pdev->id, MXC_EHCI_INTERNAL_PHY);
> +	return mx35_initialize_usb_hw(pdev->id, 0);
>  }
>  
>  /* OTG config */
> -- 
> 2.1.4
> 
