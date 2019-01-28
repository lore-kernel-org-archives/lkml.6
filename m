Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2974DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1B020882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GdoKETw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfA1H5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:57:46 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3259 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1H5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:57:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4eb5f90000>; Sun, 27 Jan 2019 23:57:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 27 Jan 2019 23:57:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 27 Jan 2019 23:57:44 -0800
Received: from [10.19.108.140] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 07:57:43 +0000
Subject: Re: [PATCH 3/6] usb: host: xhci-tegra: Add Tegra186 XUSB support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190125113013.11447-1-thierry.reding@gmail.com>
 <20190125113013.11447-3-thierry.reding@gmail.com>
From:   jckuo <jckuo@nvidia.com>
Message-ID: <2324b619-5f3a-cb92-2437-d317d0633e62@nvidia.com>
Date:   Mon, 28 Jan 2019 15:57:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125113013.11447-3-thierry.reding@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548662265; bh=/E5VBN52YaBfee0Z2ZtikILIobDPNDbh9QmKzH5K/h4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=GdoKETw+u8YQeBm42c5uVh5mGtNWFyq/AlBaoTcI/GR4rRzcmNHlocCfzvNkzSJUb
         94v6/5kJNXJDIN1EdClraa/nK6V8qzNdLBz7g2JdY8oE/w2ZOAznyxmRdydmzr0opC
         SI8fAnvGTWXOY2X3R26Z7JrqHKp759Xgx7/sjfiQO9shiTiuhVY6wOUI98AGYP2g1B
         JuCYZz124aspf6ECNan574RRggqGXRIG6JGHn09RE7hYi9Pr4YpAn2B/MWxQl5NYDy
         kE/sj7zJfx4LGpMwkSIRmq7jI7bCVXa1dFFu1cxUzF75kZgUgdsfLtLznVCkedYi6K
         /DtrjsHceSDQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: JC Kuo <jckuo@nvidia.com>

On 1/25/19 7:30 PM, Thierry Reding wrote:
> From: JC Kuo <jckuo@nvidia.com>
>
> This commit adds Tegra186 XUSB host mode controller support. This is
> very similar to the existing support for Tegra124 and Tegra210, except
> that the number of ports and PHYs differs and the IPFS wrapper being
> gone.
>
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/usb/host/xhci-tegra.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 49e033f953a2..9a07ea0f9c97 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -1423,9 +1423,34 @@ static const struct tegra_xusb_soc tegra210_soc = {
>   };
>   MODULE_FIRMWARE("nvidia/tegra210/xusb.bin");
>   
> +static const char * const tegra186_supply_names[] = {
> +};
> +
> +static const struct tegra_xusb_phy_type tegra186_phy_types[] = {
> +	{ .name = "usb3", .num = 3, },
> +	{ .name = "usb2", .num = 3, },
> +	{ .name = "hsic", .num = 1, },
> +};
> +
> +static const struct tegra_xusb_soc tegra186_soc = {
> +	.firmware = "nvidia/tegra186/xusb.bin",
> +	.supply_names = tegra186_supply_names,
> +	.num_supplies = ARRAY_SIZE(tegra186_supply_names),
> +	.phy_types = tegra186_phy_types,
> +	.num_types = ARRAY_SIZE(tegra186_phy_types),
> +	.ports = {
> +		.usb3 = { .offset = 0, .count = 3, },
> +		.usb2 = { .offset = 3, .count = 3, },
> +		.hsic = { .offset = 6, .count = 1, },
> +	},
> +	.scale_ss_clock = false,
> +	.has_ipfs = false,
> +};
> +
>   static const struct of_device_id tegra_xusb_of_match[] = {
>   	{ .compatible = "nvidia,tegra124-xusb", .data = &tegra124_soc },
>   	{ .compatible = "nvidia,tegra210-xusb", .data = &tegra210_soc },
> +	{ .compatible = "nvidia,tegra186-xusb", .data = &tegra186_soc },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, tegra_xusb_of_match);
