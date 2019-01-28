Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D38C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591E020881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XKfvAJLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfA1HJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:09:05 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19713 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfA1HJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:09:03 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4eaa8f0001>; Sun, 27 Jan 2019 23:09:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 27 Jan 2019 23:09:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 27 Jan 2019 23:09:02 -0800
Received: from [10.19.108.140] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 07:09:01 +0000
Subject: Re: [PATCH 3/5] phy: tegra: xusb: Parse dual-role mode property
To:     Thierry Reding <thierry.reding@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190125112525.10697-1-thierry.reding@gmail.com>
 <20190125112525.10697-3-thierry.reding@gmail.com>
From:   jckuo <jckuo@nvidia.com>
Message-ID: <339edd93-6e6f-d30b-ea6e-aa1af7a1409e@nvidia.com>
Date:   Mon, 28 Jan 2019 15:08:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125112525.10697-3-thierry.reding@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548659343; bh=oLlDkaf0jkpsg90pgkR33TOVaJ9283te9bt5/TS43cM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=XKfvAJLoHvTrkvbuizFO67VCNBkfTFu5zVO7xdv8WW7rQ5KbROUBqVH7nMSP8spCM
         HtF8yRgH1eVI7PkgfzOG/yBz+TcS8XvkMQx96Sc6AnhiexONVDfjyb96nGksvxQOaL
         voVqXIHUlSwNgmCYWFT6Ee6dI0WWT2L7aelbhsfVgyJ4ljli4qvOFfHDbWpKaJdHZh
         07BdYAVXv9aTe6vrdN5xv/OLgVSltiK7NygpsUZo4hMyoSrQfw1DrbXCuVPduIV3bd
         gdZFsmuAwGWKpZLW97xEI6Ye+gMKuy+6CXPn1+IgN5BTukdCFw+bqRl/nGAS64ItWj
         8ShPqTconndgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: JC Kuo <jckuo@nvidia.com>

On 1/25/19 7:25 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The device tree bindings document the "mode" property of "ports"
> subnodes, but the driver was not parsing the property. In preparation
> for adding role switching, parse the property at probe time.
>
> Based on work by JC Kuo <jckuo@nvidia.com>.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/phy/tegra/xusb.c | 21 +++++++++++++++++++++
>   drivers/phy/tegra/xusb.h |  3 +++
>   2 files changed, 24 insertions(+)
>
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index e3bc60cfe6a1..57a2d08ef6da 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -546,13 +546,34 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
>   	device_unregister(&port->dev);
>   }
>   
> +static const char *const modes[] = {
> +	[USB_DR_MODE_UNKNOWN] = "",
> +	[USB_DR_MODE_HOST] = "host",
> +	[USB_DR_MODE_PERIPHERAL] = "peripheral",
> +	[USB_DR_MODE_OTG] = "otg",
> +};
> +
>   static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
>   {
>   	struct tegra_xusb_port *port = &usb2->base;
>   	struct device_node *np = port->dev.of_node;
> +	const char *mode;
>   
>   	usb2->internal = of_property_read_bool(np, "nvidia,internal");
>   
> +	if (!of_property_read_string(np, "mode", &mode)) {
> +		int err = match_string(modes, ARRAY_SIZE(modes), mode);
> +		if (err < 0) {
> +			dev_err(&port->dev, "invalid value %s for \"mode\"\n",
> +				mode);
> +			usb2->mode = USB_DR_MODE_UNKNOWN;
> +		} else {
> +			usb2->mode = err;
> +		}
> +	} else {
> +		usb2->mode = USB_DR_MODE_HOST;
> +	}
> +
>   	usb2->supply = devm_regulator_get(&port->dev, "vbus");
>   	return PTR_ERR_OR_ZERO(usb2->supply);
>   }
> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
> index b49dbc36efa3..bb60fc09c752 100644
> --- a/drivers/phy/tegra/xusb.h
> +++ b/drivers/phy/tegra/xusb.h
> @@ -19,6 +19,8 @@
>   #include <linux/mutex.h>
>   #include <linux/workqueue.h>
>   
> +#include <linux/usb/otg.h>
> +
>   /* legacy entry points for backwards-compatibility */
>   int tegra_xusb_padctl_legacy_probe(struct platform_device *pdev);
>   int tegra_xusb_padctl_legacy_remove(struct platform_device *pdev);
> @@ -271,6 +273,7 @@ struct tegra_xusb_usb2_port {
>   	struct tegra_xusb_port base;
>   
>   	struct regulator *supply;
> +	enum usb_dr_mode mode;
>   	bool internal;
>   };
>   
