Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB6AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581BE2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qljd8hMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581BE2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeH0F65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbeH0F64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:58:56 -0400
Received: from dragon (unknown [45.56.155.152])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429B4216FA;
        Mon, 27 Aug 2018 02:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535336066;
        bh=yuKe3tt3007yCTBwy2RibuvVn2yZ5jtNgqCQsOM6KrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qljd8hMkZi1L9ZjQtuOpEkws0vgBEcNqCymlpNbXanWWDsGoPD4RarUNVjji6K7MZ
         64jB2Prej3jyzMJuL8ypwI+bRzkefcx4aUnp8kaC0xO0HQO71eMefdPQXnFStbGJCf
         svCQTQVv4YFhtRYpEJu23ztk9HNjU9fWoehcWe9w=
Date:   Mon, 27 Aug 2018 10:13:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] soc: imx: gpc: use A_CORE instread of A7 for more
 i.MX platforms
Message-ID: <20180827021326.GA3850@dragon>
References: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey,

Are you fine with these two patches?

Shawn

On Mon, Aug 06, 2018 at 02:39:48PM +0800, Anson Huang wrote:
> gpcv2 driver is NOT just used on i.MX7D which has Cortex-A7
> cores, but also on i.MX8MQ/i.MX8MM platforms which use Cortex-A53
> cores, so let's use A_CORE instread of A7 to avoid confusion.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/soc/imx/gpcv2.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 6ef18cf..0e31465 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -20,14 +20,14 @@
>  #include <linux/regulator/consumer.h>
>  #include <dt-bindings/power/imx7-power.h>
>  
> -#define GPC_LPCR_A7_BSC			0x000
> +#define GPC_LPCR_A_CORE_BSC			0x000
>  
>  #define GPC_PGC_CPU_MAPPING		0x0ec
> -#define USB_HSIC_PHY_A7_DOMAIN		BIT(6)
> -#define USB_OTG2_PHY_A7_DOMAIN		BIT(5)
> -#define USB_OTG1_PHY_A7_DOMAIN		BIT(4)
> -#define PCIE_PHY_A7_DOMAIN		BIT(3)
> -#define MIPI_PHY_A7_DOMAIN		BIT(2)
> +#define USB_HSIC_PHY_A_CORE_DOMAIN		BIT(6)
> +#define USB_OTG2_PHY_A_CORE_DOMAIN		BIT(5)
> +#define USB_OTG1_PHY_A_CORE_DOMAIN		BIT(4)
> +#define PCIE_PHY_A_CORE_DOMAIN		BIT(3)
> +#define MIPI_PHY_A_CORE_DOMAIN		BIT(2)
>  
>  #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
>  #define GPC_PU_PGC_SW_PDN_REQ		0x104
> @@ -167,7 +167,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
>  		},
>  		.bits  = {
>  			.pxx = MIPI_PHY_SW_Pxx_REQ,
> -			.map = MIPI_PHY_A7_DOMAIN,
> +			.map = MIPI_PHY_A_CORE_DOMAIN,
>  		},
>  		.voltage   = 1000000,
>  		.pgc	   = PGC_MIPI,
> @@ -179,7 +179,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
>  		},
>  		.bits  = {
>  			.pxx = PCIE_PHY_SW_Pxx_REQ,
> -			.map = PCIE_PHY_A7_DOMAIN,
> +			.map = PCIE_PHY_A_CORE_DOMAIN,
>  		},
>  		.voltage   = 1000000,
>  		.pgc	   = PGC_PCIE,
> @@ -191,7 +191,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
>  		},
>  		.bits  = {
>  			.pxx = USB_HSIC_PHY_SW_Pxx_REQ,
> -			.map = USB_HSIC_PHY_A7_DOMAIN,
> +			.map = USB_HSIC_PHY_A_CORE_DOMAIN,
>  		},
>  		.voltage   = 1200000,
>  		.pgc	   = PGC_USB_HSIC,
> @@ -261,7 +261,7 @@ builtin_platform_driver(imx7_pgc_domain_driver)
>  static int imx_gpcv2_probe(struct platform_device *pdev)
>  {
>  	static const struct regmap_range yes_ranges[] = {
> -		regmap_reg_range(GPC_LPCR_A7_BSC,
> +		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
>  				 GPC_M4_PU_PDN_FLG),
>  		regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI),
>  				 GPC_PGC_SR(PGC_MIPI)),
> -- 
> 2.7.4
> 
