Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1CBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA5A2177B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547262551;
	bh=V947eUaYNWpz7sWjMJJYpsFrc80edJpxpAix5tILRGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IB9w/D0aCelyRRzkkLySRNWw2/EbctqzS6tbjRpNQl4XbgghvxZkoPahM6CUX8hdQ
	 Yvymt/IrlS+B53RTh9yR13whIDFDlU/0fDEDUUg9TAi+CtrWdrRBZjFERHBxAdXOKl
	 o5bftiCZoiEBluuWnjHhT+BoKBNaXvGvkPcyhKFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfALDJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 22:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfALDJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 22:09:10 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A92DD20870;
        Sat, 12 Jan 2019 03:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547262549;
        bh=V947eUaYNWpz7sWjMJJYpsFrc80edJpxpAix5tILRGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9ff5xGGnX9pi9P2SAimEl+7WRJCfBVda3YuXHywpC1nN8rGLlh1gyopvAzEbnKg5
         jgb5Waa0cR6u3qApkvC1Rq1HPKJUSBmO+EN9KiPvy+qOnLHiVeYD9QPyCW0bP9A25N
         VOAU3HoBjMFyjR8ZT+kjjWIY9SawVWdKmQydLdSA=
Date:   Sat, 12 Jan 2019 11:08:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] soc: imx: Break dependency on SOC_IMX8MQ for GPCv2
Message-ID: <20190112030854.GS32649@dragon>
References: <1545571216-655-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545571216-655-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 01:20:34PM +0000, Abel Vesa wrote:
> Since this is going to be used on more SoCs than just i.MX8MQ,
> make the dependency here more generic.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> Changes since v1:
>  * removed the SOC_IMX7D since it's included by ARCH_MXC

This should really be mentioned in the commit log.

Shawn

>    as suggested by Dong Aisheng.
> 
>  drivers/soc/imx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
> index 2112d18..d80f899 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
>  
>  config IMX_GPCV2_PM_DOMAINS
>  	bool "i.MX GPCv2 PM domains"
> -	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
> +	depends on ARCH_MXC || (COMPILE_TEST && OF)
>  	depends on PM
>  	select PM_GENERIC_DOMAINS
>  	default y if SOC_IMX7D
> -- 
> 2.7.4
> 
