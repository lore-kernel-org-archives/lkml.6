Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6991C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6D220661
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550521783;
	bh=DvHDuGfz5U1kcmQ/KyetDgQ6dnhMfIpzpt7mGe9M3Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sj7LnhNHWuw/VcItf2MHt4KZMhWbww85CPzyMfgV2S3oHpBI59UHZEuqu/YdriLtb
	 YVndEmafr3OLclo6XWn7xLwm9GlgTCY6YZKxUak5moZYQho+vxa6kRKPUML+OUL8db
	 Kx9IhhcZ6uRN8KDtqEpzyh+xLdREQlouygmLLFpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfBRU3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:29:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44102 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfBRU3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:29:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id g1so30379217otj.11;
        Mon, 18 Feb 2019 12:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HLwAr1KiOR6gPz8z1KdNOOBU1NlxDF2d/eQtn3tZWlc=;
        b=HOJ7BW3U7kHEoCzRDid3LOhDFWLoL5ktMsAAhyNOkySnx5DRs+b6hhB2gCrWgb9bG2
         8Uvgd+X7XHuoGvwYfB64BRp1lpggdoA0JTLVVfKAoQllZrD4yL3X78tCJyNWgglA75Ol
         8ZDz2Eti5amGXjpCZZBHb9hO2xNzFXTfHIfdeBg1bVgt+G4b2rLGG+BiILs4ku5uWeah
         reh7h+HuVi+qjAGtsvpDFzrpqH20WTl6Hc5Q0BLtqaIBIWNrURZUZ47ProayBij9BunW
         YUX7vJKDbMk4D4HuTXceJ4PJ1kr710mVclvFLj3bNktfsLKxoHJnrq42kKoMmAYq9Tjt
         tkcQ==
X-Gm-Message-State: AHQUAuascr4tgfy3UuFPJrqvnIccJjrMvsu9rS4o8sLyL5Ll+Nd6nI+Q
        MqzVPSVwuHM5tEeIkzvflg==
X-Google-Smtp-Source: AHgI3IY7cK6lsX5psdvMxWusJXTlkWAjX9oLUnGA3ABICQEz/74JMHk2Y+6a/54jSd2BFqy/DOy2Vw==
X-Received: by 2002:a9d:6012:: with SMTP id h18mr14619342otj.341.1550521780797;
        Mon, 18 Feb 2019 12:29:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d65sm7014200oih.13.2019.02.18.12.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:29:40 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:29:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wei Ni <wni@nvidia.com>
Cc:     thierry.reding@gmail.com, daniel.lezcano@linaro.org,
        edubezval@gmail.com, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 04/12] of: Add bindings of gpu hw throttle for Tegra
 soctherm
Message-ID: <20190218202939.GA7473@bogus>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
 <1545118484-23641-6-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545118484-23641-6-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 03:34:36PM +0800, Wei Ni wrote:
> Add "nvidia,gpu-throt-level" property to set gpu hw
> throttle level.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 17 +++++++++++++++--
>  include/dt-bindings/thermal/tegra124-soctherm.h    | 22 ++++++++++++++++++----
>  2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> index ab66d6feab4b..cf6d0be56b7a 100644
> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> @@ -52,6 +52,15 @@ Required properties :
>          Must set as following values:
>          TEGRA_SOCTHERM_THROT_LEVEL_LOW, TEGRA_SOCTHERM_THROT_LEVEL_MED
>          TEGRA_SOCTHERM_THROT_LEVEL_HIGH, TEGRA_SOCTHERM_THROT_LEVEL_NONE
> +      - nvidia,gpu-throt-level: This property is for Tegra124 and Tegra210.
> +        It is the level of pulse skippers, which used to throttle clock
> +        frequencies. It indicates gpu clock throttling depth and can be
> +        programmed to any of the following values which represent a throttling
> +        percentage:
> +        TEGRA_SOCTHERM_THROT_LEVEL_NONE (0%)
> +        TEGRA_SOCTHERM_THROT_LEVEL_LOW (50%),
> +        TEGRA_SOCTHERM_THROT_LEVEL_MED (75%),
> +        TEGRA_SOCTHERM_THROT_LEVEL_HIGH (85%).
>        - #cooling-cells: Should be 1. This cooling device only support on/off state.
>          See ./thermal.txt for a description of this property.
>  
> @@ -96,22 +105,26 @@ Example :
>  		throttle-cfgs {
>  			/*
>  			 * When the "heavy" cooling device triggered,
> -			 * the HW will skip cpu clock's pulse in 85% depth
> +			 * the HW will skip cpu clock's pulse in 85% depth,
> +			 * skip gpu clock's pulse in 85% level
>  			 */
>  			throttle_heavy: heavy {
>  				nvidia,priority = <100>;
>  				nvidia,cpu-throt-percent = <85>;
> +				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
>  
>  				#cooling-cells = <1>;
>  			};
>  
>  			/*
>  			 * When the "light" cooling device triggered,
> -			 * the HW will skip cpu clock's pulse in 50% depth
> +			 * the HW will skip cpu clock's pulse in 50% depth,
> +			 * skip gpu clock's pulse in 50% level
>  			 */
>  			throttle_light: light {
>  				nvidia,priority = <80>;
>  				nvidia,cpu-throt-percent = <50>;
> +				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_LOW>;
>  
>  				#cooling-cells = <1>;
>  			};
> diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
> index c15e8b709a0d..75853df1c609 100644
> --- a/include/dt-bindings/thermal/tegra124-soctherm.h
> +++ b/include/dt-bindings/thermal/tegra124-soctherm.h
> @@ -1,5 +1,19 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> + * Copyright (c) 2014 - 2018, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * Author:
> + *      Mikko Perttunen <mperttunen@nvidia.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *

Why are you adding this?

>   * This header provides constants for binding nvidia,tegra124-soctherm.
>   */
>  
> @@ -12,9 +26,9 @@
>  #define TEGRA124_SOCTHERM_SENSOR_PLLX 3
>  #define TEGRA124_SOCTHERM_SENSOR_NUM 4
>  
> -#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  0
> -#define TEGRA_SOCTHERM_THROT_LEVEL_MED  1
> -#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 2
> -#define TEGRA_SOCTHERM_THROT_LEVEL_NONE -1
> +#define TEGRA_SOCTHERM_THROT_LEVEL_NONE 0
> +#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  1
> +#define TEGRA_SOCTHERM_THROT_LEVEL_MED  2
> +#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 3

You are breaking an ABI.

Rob
