Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E50C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C894F2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 17:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTFpZIXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeLOR26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 12:28:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44765 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLOR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 12:28:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so4334337pfh.11;
        Sat, 15 Dec 2018 09:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bF++uRQA5kU4/BlWhZKLiaBULhPE1leWfx7jNHVq2Pk=;
        b=dTFpZIXRp9p4VpcgccB+NC9H8uCK8YFhKX/h6CDiNBB1d9TsLMITBG35rfm+yiOP+i
         14vx5KwhOp9wkWbPF4ivXU1IwVAofwl/fFYj5KC2agtAcH+iz1OWNr3T301Ux+1+NC+f
         sMHhlVyYyePp/0hpRdRZLlAB0s8qbs1eRqk65cC7++tWlTmOhQJjyigzU6ofTu6+Rm22
         Iif9+S6gb8v4/K8xo4MYxT3IRtjbVNy5FmaHa7QdbR9swcLgc1HQcU/lYR9fVZwvOAfW
         7QQLi+a6xLrHox/L/IWrg7VlDJfq557MZvq9Fg5/p/ZV9PK+giFxvCRJH7AhFlLfnXYK
         Rt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bF++uRQA5kU4/BlWhZKLiaBULhPE1leWfx7jNHVq2Pk=;
        b=lGyx5dDxhP6qQnSoRCdWcLiIFbyvjp5gEayk2IgQohu6wm7dVoz85XaE01nD/QTNPB
         Turkg8BFESiQxg+5hp60L6ZE8JkMJmxdd/9vm31JexYUKFdOa63VGx57WawT+e1vW2kM
         iIr/NYK3Go+BxLz/BpZRWPT2SgLI8VpgKVdpWS3K1iSC9uYekAUYnEQ0yXpoA564+JfG
         nnzOIznWQaqp17o8gBlowp+DgJ8DyzwIVZPo3Aiafw0C7duP9+n+t3PHk7nwJL72iLtS
         qb0DB4RnDgn+1r/yaqnzIqCZMNvC+XegZSykd5hiCRXKdFDd4YqKj4kY8vM2Q3XMSAOk
         tPuA==
X-Gm-Message-State: AA+aEWb1ZUYyHyC9/kN7uPu0zciarRm/LMV0RL2+ATR8MltqA21nQ+nR
        QTxfqT/8APXdtrtnCuykMLGBzhzW0BY=
X-Google-Smtp-Source: AFSGD/WaqdWIfK0YeGs8oRPOxEAPaFVB0cTq7ErUdtUtCSLLSUOLr1FUMDOk2mOEIyGhiIMgbt4Tog==
X-Received: by 2002:a63:ea15:: with SMTP id c21mr6327961pgi.361.1544894936925;
        Sat, 15 Dec 2018 09:28:56 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id l64sm9329003pge.73.2018.12.15.09.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 09:28:56 -0800 (PST)
Date:   Sat, 15 Dec 2018 09:28:54 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: tegra: p2972: Enable the CPU, GPU and AUX
 thermal zones
Message-ID: <20181215172853.GA10838@localhost.localdomain>
References: <20181123121839.18573-1-thierry.reding@gmail.com>
 <20181123121839.18573-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123121839.18573-3-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 01:18:39PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Enable these thermal zones to be able to monitor their temperatures and
> control the fan to cool down the system if necessary.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

As mentioned, I already added patch 1.

> ---
>  .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 91 ++++++++++++++++++-
>  1 file changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index cbae8e8b1281..e29f8f6117c8 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -43,8 +43,97 @@
>  		};
>  	};
>  
> -	fan {
> +	fan: fan {
>  		compatible = "pwm-fan";
>  		pwms = <&pwm4 0 45334>;
> +
> +		cooling-levels = <0 64 128 255>;
> +		cooling-min-state = <0>;
> +		cooling-max-state = <3>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	thermal-zones {
> +		cpu {
> +			polling-delay = <0>;
> +			polling-delay-passive = <500>;
> +			status = "okay";
> +
> +			trips {
> +				cpu_trip_critical: critical {
> +					temperature = <96500>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +
> +				cpu_trip_hot: hot {
> +					temperature = <70000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				cpu_trip_active: active {
> +					temperature = <50000>;
> +					hysteresis = <2000>;
> +					type = "active";
> +				};
> +
> +				cpu_trip_passive: passive {
> +					temperature = <30000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +			};
> +
> +			cooling-maps {
> +				cpu-critical {
> +					cooling-device = <&fan 3 3>;
> +					trip = <&cpu_trip_critical>;
> +				};
> +
> +				cpu-hot {
> +					cooling-device = <&fan 2 2>;
> +					trip = <&cpu_trip_hot>;
> +				};
> +
> +				cpu-active {
> +					cooling-device = <&fan 1 1>;
> +					trip = <&cpu_trip_active>;
> +				};
> +
> +				cpu-passive {
> +					cooling-device = <&fan 0 0>;
> +					trip = <&cpu_trip_passive>;
> +				};
> +			};
> +		};
> +
> +		gpu {
> +			polling-delay = <0>;
> +			polling-delay-passive = <500>;
> +			status = "okay";
> +
> +			trips {
> +				gpu_alert0: critical {
> +					temperature = <99000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		aux {
> +			polling-delay = <0>;
> +			polling-delay-passive = <500>;
> +			status = "okay";
> +
> +			trips {
> +				aux_alert0: critical {
> +					temperature = <90000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
>  	};
>  };
