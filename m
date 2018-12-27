Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C353C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DC821907
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545946439;
	bh=VArCU8YHUjNx4x02t1kC9UFcYty97zm+2Yfk5zZDlUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iMCqt6sOyGE/qwng7T1/4+G2N9p+j04xJqNxA6KoDJLUJkWAm9cdGUCMy1GkimnX0
	 mmFJD+LuPcvbq/5AQpqVFAiQfLj2rNRZiysPqBdbkhacFVw9gqTbQ1VZ24rPKwKRow
	 Yu1X+9xgF2xhMKUbqksZe03D25uVE5LW7N8PiBkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbeL0Vd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:33:58 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54038 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbeL0Vd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:33:57 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so26117047ita.3;
        Thu, 27 Dec 2018 13:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i2GYTzdJp5jIdoRXInSjNEX58t7HZ7fjWQ3Q5CB9SoA=;
        b=Oxu3q9M8H66/eXYOtM7GWJJ/F5q2ERPdfeRWiXMPKZiVvhi/Vp225h0KTe94kV4CdA
         n6QUWNoV07QfW56HjfZkBJGnZN/rqU5f5Pe3/PVvjxVzNrOh/+cikphtbpbCNswcokqx
         gnbV/9fkZGzS10rEyydZrlOWFx7ELsap+N7ELKRIlv0HyLuEHxEkJQdrSkpKI6pTF4Qz
         1NpE8tn0ODNDZLZwb/8vAd9BWVE+Lu/Q55uB/bhl/MyAWs6uHjDnUrt+cvVByt6M6aSD
         ruqMo59ZyxFzc9zlgaaA+vlD+greX9oHkJVkLmnJ9Ua/oXGllULx73GbE9JE+g++ai5O
         S0Rw==
X-Gm-Message-State: AA+aEWYd+4FpN1TDY/GiQLgvJ0NyAgkxQ2dWKNvaJ4Ybvd1D0O/5rZG+
        prMy/zfRh4hw4jwmlz5FRg==
X-Google-Smtp-Source: AFSGD/UVl1W4v8RP6lv1gMPRyJVogzzURktmVYo69/OrtGRewN8Y7qazAawVwgKK1qHS+/mt6teF1w==
X-Received: by 2002:a05:660c:54d:: with SMTP id w13mr15501728itk.50.1545946435611;
        Thu, 27 Dec 2018 13:33:55 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id d192sm18874521iog.81.2018.12.27.13.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:33:54 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:33:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     mark.rutland@arm.com, mperttunen@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        pchandru@nvidia.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH V2 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad
 drive strength config
Message-ID: <20181227213353.GA8110@bogus>
References: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:55:51PM -0800, Sowjanya Komatineni wrote:
> Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
> Tegra210 sdmmc which has pad configuration registers in the pinmux
> reigster domain.

typo

> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 32b4b4e41923..2cecdc71d94c 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -39,12 +39,16 @@ sdhci@c8000200 {
>  	bus-width = <8>;
>  };
>  
> -Optional properties for Tegra210 and Tegra186:
> +Optional properties for Tegra210, Tegra186 and Tegra194:

Adding Tegra194, but this patch concerns Tegra210...

>  - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
>    configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
>    for controllers supporting multiple voltage levels. The order of names
>    should correspond to the pin configuration states in pinctrl-0 and
>    pinctrl-1.
> +- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable for

These are in addition to the previous values?

> +  Tegra210 where pad config registers are in the pinmux register domain
> +  for pull-up-strength and pull-down-strength values configuration when
> +  using pads at 3V3 and 1V8 levels.
>  - nvidia,only-1-8-v : The presence of this property indicates that the
>    controller operates at a 1.8 V fixed I/O voltage.
>  - nvidia,pad-autocal-pull-up-offset-3v3,
> -- 
> 2.7.4
> 
