Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0345C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A171C217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550521930;
	bh=3+9PufrjNiGfX1bobbaYxfkKwyEYpNfrhM+XlBCgJhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PfexW39uIdiFVcag9PDG64Fn0kIuPpuGQSUlPBwO8BHfXAn69EZeY4eck8pMrVyG+
	 Y85XevD35rsFGVsiN3hPtuu6YRjE2EktQh+cA7UyOtHv7JuIOm5Xij+9FuxQD0ObP8
	 Nn7lSU4x6JC3IX2631/UFXFxaj2QZC6jqULmnQ0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfBRUcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:32:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37090 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbfBRUcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:32:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id b3so30474192otp.4;
        Mon, 18 Feb 2019 12:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lcazBCro//ekWvrvR7vRxsEB5SzfiQClZ2zm+6sEkZI=;
        b=QLDJl09ECkgQKDNBRAcoYfaQf3uDJTQ3/LopTB9cgZNo8xxUyNDZnxraYfkhOZ11u2
         mlAGhM4/2IPNDD3XViVc5IFZ/guF3MNydfL183yZ2Dw9LZ2pmHuE/Mmlg7PFmaBKjZzL
         gxS1UToVa/fwVYicn0ZUigaT0QAukVfN6D9OvbLnu1oRrbb57zCmfbsUt8IVla4f4HAp
         LPX8or19bLb+p0G4iTATl143aCad6/MzPDH5jjAh33bNJ+tLJs66/eHe0vwbJw6MLa69
         JsseJvWo53sOT8TgE4dLOt3WU/2jr7rzn5fAWNpIWGrIDx6zb9CR70fOXc+SVsvhXpKx
         PozA==
X-Gm-Message-State: AHQUAua6bzssTxUdet94bjpbmkS8nKxs/PlCc55Yw/qWhkWn3R9IGf6C
        0EpeXNNE5KgNxXKebEzq6Q==
X-Google-Smtp-Source: AHgI3IbR0aA8/pHYss+yG0p4PNth+h/5379hBt2U/xlEfKh/8kbXrFzmLWOMWu9ifJes04Evag5D1g==
X-Received: by 2002:a05:6830:1c9:: with SMTP id r9mr11178936ota.273.1550521926034;
        Mon, 18 Feb 2019 12:32:06 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s12sm4285192otk.0.2019.02.18.12.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:32:05 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:32:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wei Ni <wni@nvidia.com>
Cc:     thierry.reding@gmail.com, daniel.lezcano@linaro.org,
        edubezval@gmail.com, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 11/12] of: Add bindings of OC hw throttle for Tegra
 soctherm
Message-ID: <20190218203204.GA12911@bogus>
References: <1545118484-23641-1-git-send-email-wni@nvidia.com>
 <1545118484-23641-13-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545118484-23641-13-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 03:34:43PM +0800, Wei Ni wrote:
> Add OC HW throttle configuration for soctherm in DT.
> It is used to describe the OCx throttle events.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> index cf6d0be56b7a..d112a8e59ec3 100644
> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
> @@ -64,6 +64,21 @@ Required properties :
>        - #cooling-cells: Should be 1. This cooling device only support on/off state.
>          See ./thermal.txt for a description of this property.
>  
> +      Optional properties: The following properties are T210 specific and
> +      valid only for OCx throttle events.
> +      - nvidia,count-threshold: Specifies the number of OC events that are
> +        required for triggering an interrupt. Interrupts are not triggered if
> +        the property is missing. A value of 0 will interrupt on every OC alarm.
> +      - nvidia,polarity-active-low: Configures the polarity of the OC alaram
> +        signal. Accepted values are 1 for assert low and 0 for assert high.
> +        Default value is 0.

Why not boolean?

> +      - nvidia,alarm-filter: Number of clocks to filter event. When the filter
> +        expires (which means the OC event has not occurred for a long time),
> +        the counter is cleared and filter is rearmed. Default value is 0.
> +      - nvidia,throttle-period: Specifies the number of uSec for which
> +        throttling is engaged after the OC event is deasserted. Default value
> +        is 0.

Needs a unit suffix as defined in property-units.txt.

> +
>  Optional properties:
>  - nvidia,thermtrips : When present, this property specifies the temperature at
>    which the soctherm hardware will assert the thermal trigger signal to the
> @@ -134,6 +149,17 @@ Example :
>  			 * arbiter will select the highest priority as the final throttle
>  			 * settings to skip cpu pulse.
>  			 */
> +
> +			throttle_oc1: oc1 {
> +				nvidia,priority = <50>;
> +				nvidia,polarity-active-low = <1>;
> +				nvidia,count-threshold = <100>;
> +				nvidia,alarm-filter = <5100000>;
> +				nvidia,throttle-period = <0>;
> +				nvidia,cpu-throt-percent = <75>;
> +				nvidia,gpu-throt-level =
> +						<TEGRA_SOCTHERM_THROT_LEVEL_MED>;
> +                        };
>  		};
>  	};
>  
> -- 
> 2.7.4
> 
