Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092A2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3E72184E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XRjhuUbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfA1HG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:06:56 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12676 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfA1HGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:06:55 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4ea9f40000>; Sun, 27 Jan 2019 23:06:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 27 Jan 2019 23:06:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 27 Jan 2019 23:06:54 -0800
Received: from [10.19.108.140] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 07:06:53 +0000
Subject: Re: [PATCH 2/5] phy: tegra: xusb: Skip single function lane
 programming
To:     Thierry Reding <thierry.reding@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190125112525.10697-1-thierry.reding@gmail.com>
 <20190125112525.10697-2-thierry.reding@gmail.com>
From:   jckuo <jckuo@nvidia.com>
Message-ID: <7afb7753-39d2-69b9-3666-e159d3e85ae0@nvidia.com>
Date:   Mon, 28 Jan 2019 15:06:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125112525.10697-2-thierry.reding@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548659188; bh=yPcMza5oiR2ZVuvA2oPLMM45+NWW6Z0V0gb5DeuFucg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=XRjhuUbrwT6yQGF7k2nzfxedzZDbnrh6trwACpMqBkV6oBo+iPUoRUO85J73APWni
         vngtpAj9Y70bQSuzeo6QyTMh+BFz8hFy1KUHrTvuzKoHm/zDa5JDPOCrdZ65Mishaz
         3nLf+tvp8TYs8QD9tphrubIQ1+tqStFvDDeypqPB9uAGAhEoa0QZyER3Si5lrYvggo
         Z+up/HJgbfqHlO0GNtoPRnRLrd4Jv0e3Pnkb/3SbaCgYa++E6uF4VDUgp7IAanMcku
         c6WvpjlAOvgo+219+8zY+N3hvt6jC4IQf3UzZyGj9hWEqohMpP4mfs75IHy4oOTueE
         Piu+CCrEXPqRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: JC Kuo <jckuo@nvidia.com>

On 1/25/19 7:25 PM, Thierry Reding wrote:
> From: JC Kuo <jckuo@nvidia.com>
>
> Tegra186 USB2 pads and USB3 pads do not have hardware mux for changing
> the pad function. For such "lanes", we can skip the lane mux register
> programming.
>
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/phy/tegra/xusb.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 5b3b8863363e..e3bc60cfe6a1 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -1,5 +1,5 @@
>   /*
> - * Copyright (c) 2014-2015, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
>    *
>    * This program is free software; you can redistribute it and/or modify it
>    * under the terms and conditions of the GNU General Public License,
> @@ -313,6 +313,10 @@ static void tegra_xusb_lane_program(struct tegra_xusb_lane *lane)
>   	const struct tegra_xusb_lane_soc *soc = lane->soc;
>   	u32 value;
>   
> +	/* skip single function lanes */
> +	if (soc->num_funcs < 2)
> +		return;
> +
>   	/* choose function */
>   	value = padctl_readl(padctl, soc->offset);
>   	value &= ~(soc->mask << soc->shift);
