Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EDBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5182148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545951994;
	bh=oYW+Kl9VqKeBE13T1FblbZ2iqncuyX80rLUj6Wvbgc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QGsKgHqOPvhyMB7umQFrdqLoyNP1u4bKoppwXoX01cvrWpJjwmoe0SnH91c962DGb
	 oB+w4mY8l/2b3gpxOf02JgwP01MlHBkReU84gEPSRQfwVcrlKrGQh3joqW8isJdcZV
	 hgd16WBMfOcfoDoZ8GpGIcUPA5oXTiMlutTAXRW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733172AbeL0XGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:06:34 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51941 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbeL0XGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 18:06:33 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so26379409ite.1;
        Thu, 27 Dec 2018 15:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V5RA6P2tf+WDctJjZgcq2sZXdKwr8ipG35lTjMUE2/Q=;
        b=RdHsWshuphqo9RY+k/11rn9u4qajiAGEI92XI6B5bhjj4UqAiH+wLhOofmAU36Joqv
         lYFxd1Eu6Vw+PmE4GmglNDkLawPLv1wmpRRjGvtWJfFwGSRsfm0GADmXopDl+HsN4DzU
         XqiQ4IoAAuBK/xbamXU6p7D30mPZxZ7yig6vEnI5aaxq26XzdjwQfe94BdROBD55gUxj
         DEQZe3VQ1cYmspF8o4jyqH5F8dDzIK7FXYMDltlhHTobb9lJET15a5Vg4CUPpmqKzp7f
         uNmDGjUm+WIc7TiKwVBal6FddGSw6/dwUk5gHKOQm5gWaFB+VISjBci2anUj1lVW8w76
         Aeiw==
X-Gm-Message-State: AJcUukdz2FkCoFXwbsxQYntr485TRcdm0T3gTtqxxEtNEWTceXgOjhMT
        Tw3oYsyy3osyxPV3nTXo0xPERaY=
X-Google-Smtp-Source: AFSGD/Wx7ji7EPzbN/pTCw/ElZWNnyQ7/1q93wUflhsAsoX+o5yXGRKH++hoUTSyZYYaCn5KHnd55A==
X-Received: by 2002:a24:750f:: with SMTP id y15mr14754079itc.177.1545951992585;
        Thu, 27 Dec 2018 15:06:32 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id w26sm17683101iol.60.2018.12.27.15.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 15:06:31 -0800 (PST)
Date:   Thu, 27 Dec 2018 17:06:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wei Ni <wni@nvidia.com>
Cc:     thierry.reding@gmail.com, daniel.lezcano@linaro.org,
        edubezval@gmail.com, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 01/12] of: Add bindings of thermtrip for Tegra soctherm
Message-ID: <20181227230630.GA3659@bogus>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
 <1545118484-23641-3-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545118484-23641-3-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 03:34:33PM +0800, Wei Ni wrote:
> Add optional property "nvidia,thermtrips".
> If present, these trips will be used as HW shutdown trips,
> and critical trips will be used as SW shutdown trips.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  .../bindings/thermal/nvidia,tegra124-soctherm.txt    | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> index b6c0ae53d4dc..ab66d6feab4b 100644
> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> @@ -55,10 +55,21 @@ Required properties :
>        - #cooling-cells: Should be 1. This cooling device only support on/off state.
>          See ./thermal.txt for a description of this property.
>  
> +Optional properties:
> +- nvidia,thermtrips : When present, this property specifies the temperature at
> +  which the soctherm hardware will assert the thermal trigger signal to the
> +  Power Management IC, which can be configured to reset or shutdown the device.
> +  It is an array of pairs where each pair represents a tsensor id followed by a
> +  temperature in milli Celcius. In the absence of this property the critical
> +  trip point will be used for thermtrip temperature.
> +
>  Note:
> -- the "critical" type trip points will be set to SOC_THERM hardware as the
> -shut down temperature. Once the temperature of this thermal zone is higher
> -than it, the system will be shutdown or reset by hardware.
> +- the "critical" type trip points will be used to set the temperature at which
> +the SOC_THERM hardware will assert a thermal trigger if the "nvidia,thermtrips"
> +property is missing. When the thermtrips property is present, the breach of a
> +critical trip point is reported back to the thermal framework to implement
> +software shutdown.

This hardly seems like a NVidia specific concept. A h/w shutdown 
temperature... Come up with something common.

Also, we already have a temperature table. Why do we need temperatures 
in 2 places.

> +
>  - the "hot" type trip points will be set to SOC_THERM hardware as the throttle
>  temperature. Once the the temperature of this thermal zone is higher
>  than it, it will trigger the HW throttle event.
> @@ -79,6 +90,9 @@ Example :
>  
>  		#thermal-sensor-cells = <1>;
>  
> +		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
> +				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
> +
>  		throttle-cfgs {
>  			/*
>  			 * When the "heavy" cooling device triggered,
> -- 
> 2.7.4
> 
