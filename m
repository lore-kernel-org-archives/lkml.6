Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BA9C37125
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DB520870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548112861;
	bh=+GY7SaQPZcXmaVLg6TSXyPFb2M+gByJ68YzkNXFJSiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2EdpMpr0ILlrUE5t+Rh2hS988U31lCfPVZnjPCewaphGKo+Lte/FCNaaLtUDnqkKJ
	 P85HqBxKlCZyrduol7sMejW6cZKm7BC+oRNnO712Ik5NBEARDiZ6EoQ2xyUteEaFDf
	 hBjB1tRlrZJotvonE9sImxJYyACuLdR7lJCMb40k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfAUXVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:21:00 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40266 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfAUXVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:21:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id t204so15897102oie.7;
        Mon, 21 Jan 2019 15:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1+CZ9JMCwRZTLZXzfvTLL8swC7DZblkkC7rwxDoO7us=;
        b=TD+YzFm1yFH06B0igMr9VisW7mUrxAJoUUexJekhwZa+yBsx8f+2bwx+joFcAVhStU
         Qscz4DO3Wu6rLy+vQolaetmmASmLwUzl1/DeiWv2lpuKblq0Wtz7Rn+0gWbYS8MpK89g
         G6dhRm0iaD3q/dSe8ms/xhX5lMqmvcNTGtNMRPhH06iFbSxbvQVFdRUCUG3M4vdPTp+F
         G0nulHhdaPZNUqhvarP1YpJMDrhFmUL3WX5AmEHlXxeUjcvIf7G5w9cdwIAytnJxI2Tr
         TuF/kWQ2t5MJsrlKjGZ/ofg2h6nX1J5Ieb2vOhIoxoj6CDlyzu2kbDI+wGzh76E+YurB
         azHQ==
X-Gm-Message-State: AJcUukeYcNtqgL7s+BuNPKdBsHjKxbUf+LbThonop5OzDHC2KUuGhGhr
        0VlGBuw1k0EhdVBueseP3A==
X-Google-Smtp-Source: ALg8bN4vroFhU8fHr6TEYPz3hgazT+fiW07UlCqACNSxaWF2FgyDzbLLgCMVI/lLYqAYYg5oScD5XQ==
X-Received: by 2002:aca:f044:: with SMTP id o65mr6396118oih.145.1548112858865;
        Mon, 21 Jan 2019 15:20:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 14sm7421210otg.68.2019.01.21.15.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 15:20:58 -0800 (PST)
Date:   Mon, 21 Jan 2019 17:20:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, zhang.chunyan@linaro.org, kishon@ti.com,
        adrian.hunter@intel.com, mark.rutland@arm.com,
        ulf.hansson@linaro.org
Subject: Re: [PATCH 3/7] dt-bindings: sdhci-omap: Add example for using
 external dma
Message-ID: <20190121232057.GA30919@bogus>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
 <20190111110851.6805-4-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111110851.6805-4-faiz_abbas@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 04:38:47PM +0530, Faiz Abbas wrote:
> From: Chunyan Zhang <zhang.chunyan@linaro.org>

The subject is misleading. You are adding new properties, not just 
changing an example.

> 
> sdhci-omap can support both external dma controller via dmaengine
> framework as well as ADMA which standard SD host controller
> provides.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> index 72c4dec7e1db..f8914a2a2aec 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> @@ -14,6 +14,11 @@ Required properties:
>  		 "ddr_1_8v-rev11", "ddr_1_8v" or "ddr_3_3v", "hs200_1_8v-rev11",
>  		 "hs200_1_8v",
>  - pinctrl-<n> : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
> +- dmas:		List of DMA specifiers with the controller specific format as described
> +		in the generic DMA client binding. A tx and rx specifier is required.
> +- dma-names:	List of DMA request names. These strings correspond 1:1 with the
> +		DMA specifiers listed in dmas. The string naming is to be "rx"
> +		and "tx" for RX and TX DMA requests, respectively.

The ordering of rx and tx should be defined and you have a mixture.

>  
>  Example:
>  	mmc1: mmc@4809c000 {
> @@ -22,4 +27,6 @@ Example:
>  		ti,hwmods = "mmc1";
>  		bus-width = <4>;
>  		vmmc-supply = <&vmmc>; /* phandle to regulator node */
> +		dmas = <&sdma 61 &sdma 62>;
> +		dma-names = "tx", "rx";
>  	};
> -- 
> 2.19.2
> 
