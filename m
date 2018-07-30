Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA35DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D29C20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D29C20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbeGaBIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:08:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36764 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbeGaBIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:08:43 -0400
Received: by mail-it0-f65.google.com with SMTP id p81-v6so1769590itp.1;
        Mon, 30 Jul 2018 16:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1IyIAOezTVfUfddF0x8fR5pEtn7TI307eDxseeQq4/0=;
        b=jeIz1qohYKjQYhJg65ZWSGztl/CzBqQ4Rk/Fop4EYCqXEoW1t4dyvqww5y1cg+TElq
         qVrqLb/0BQTJE4ahHMuNf0yvofIpTNvKFRpdJpyVIycrUAO2PkGge+gW38nkaf/L3x2h
         rFbVZm8TJxTjgIjvORzLDcNo/dHh3ly4FDPz/49iEzxpNY00gshFEkgMdNbMQeaDSZE9
         Px2eeffFJl/E/KoaDN7Q+3YKaNF5JxnkNan0o2MjTz+eRO81J3lPiv7li8EbiEkPofzq
         TaZ+AKT6bl/leH9w15sybakSaPsXidu840MP3UJv7Q5dYoCjqOMkQqY+lWejPMLOdDYp
         KI4Q==
X-Gm-Message-State: AOUpUlHhtZCOSOligwsMofCMidaUwnhvicZhN4LM1PfhRm4670uQ4YTF
        9kQ2gOa+MyTEMmk/rJOHDQ==
X-Google-Smtp-Source: AAOMgpfFLMxTmqvS5tBbZWkrT/TC+dulRniARezsMXMfp9KfWGTeRqAGXpA91cEFsegQFkHGnJR10A==
X-Received: by 2002:a24:d2:: with SMTP id 201-v6mr1164949ita.60.1532993482321;
        Mon, 30 Jul 2018 16:31:22 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id e11-v6sm3833345iog.56.2018.07.30.16.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:31:21 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:31:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] dt-bindings: Add Tegra SDHCI pad pdpu offset
 bindings
Message-ID: <20180730233121.GA21962@rob-hp-laptop>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
 <1532608016-14319-6-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532608016-14319-6-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 03:26:51PM +0300, Aapo Vienamo wrote:
> Add bindings documentation for pad pull up and pull down offset values to be
> programmed before executing automatic pad drive strength calibration.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 95010cf..c3d8a15 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -24,6 +24,7 @@ Required properties:
>  Optional properties:
>  - power-gpios : Specify GPIOs for power control
>  
> +Optional properties for Tegra210 and Tegra186:
>  Example:
>  
>  sdhci@c8000200 {
> @@ -47,6 +48,35 @@ Optional properties for Tegra210 and Tegra186:
>    pinctrl-1.
>  - nvidia,only-1-8-v : The presence of this property indicates that the
>    controller operates at a 1.8 V fixed I/O voltage.

> +- nvidia,pad-autocal-pull-up-offset-3v3,
> +  nvidia,pad-autocal-pull-down-offset-3v3 : Specify drive strength
> +  calibration offsets for 3.3 V signaling modes.

Perhaps a single property with 2 values?

> +- nvidia,pad-autocal-pull-up-offset-1v8,
> +  nvidia,pad-autocal-pull-down-offset-1v8 : Specify drive strength
> +  calibration offsets for 1.8 V signaling modes.
> +- nvidia,pad-autocal-pull-up-offset-3v3-timeout,
> +  nvidia,pad-autocal-pull-down-offset-3v3-timeout : Specify drive
> +  strength used as a fallback in case the automatic calibration times
> +  out on a 3.3 V signaling mode.
> +- nvidia,pad-autocal-pull-up-offset-1v8-timeout,
> +  nvidia,pad-autocal-pull-down-offset-1v8-timeout : Specify drive
> +  strength used as a fallback in case the automatic calibration times
> +  out on a 1.8 V signaling mode.
> +- nvidia,pad-autocal-pull-up-offset-sdr104,
> +  nvidia,pad-autocal-pull-down-offset-sdr104 : Specify drive strength
> +  calibration offsets for SDR104 mode.
> +- nvidia,pad-autocal-pull-up-offset-hs400,
> +  nvidia,pad-autocal-pull-down-offset-hs400 : Specify drive strength
> +  calibration offsets for HS400 mode.
> +
> +  Notes on the pad calibration pull up and pulldown offset values:
> +    - The property values are drive codes which are programmed into the
> +      PD_OFFSET and PU_OFFSET sections of the
> +      SDHCI_TEGRA_AUTO_CAL_CONFIG register.
> +    - A higher value corresponds to higher drive strength. Please refer
> +      to the reference manual of the SoC for correct values.
> +    - The SDR104 and HS400 timing specific values are used in
> +      corresponding modes if specified.
>  
>  Example:
>  sdhci@700b0000 {
> @@ -60,5 +90,9 @@ sdhci@700b0000 {
>  	pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
>  	pinctrl-0 = <&sdmmc1_3v3>;
>  	pinctrl-1 = <&sdmmc1_1v8>;
> +	pad-autocal-pull-up-offset-3v3 = <0x00>;
> +	pad-autocal-pull-down-offset-3v3 = <0x7d>;
> +	pad-autocal-pull-up-offset-1v8 = <0x7b>;
> +	pad-autocal-pull-down-offset-1v8 = <0x7b>;

Doesn't match the doc.

>  	status = "disabled";
>  };
> -- 
> 2.7.4
> 
