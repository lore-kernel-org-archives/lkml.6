Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149E8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B366C20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFqrUj/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B366C20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeHaRXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:23:13 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33667 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeHaRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:23:13 -0400
Received: by mail-io0-f196.google.com with SMTP id r196-v6so10395010iod.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1hRE1NCdKzhqsDgrW7ju+gE9kSCpU3hD3AplaZK6xtM=;
        b=JFqrUj/88RgeUupN8wNELG+wE5Pm4cmBrarXIqew8eiHVAiJvL+LvaEJbcgRzLoVpN
         8Q3nw+tCJyTIVxQeA8wPqhIRDppGTgfsgj7yxIlOpmHlVX8gLyjfaKIG6onYdCgEzmks
         eFZhAFR5Yzp7V4J60quZy6Y1gOIwphgfkapuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1hRE1NCdKzhqsDgrW7ju+gE9kSCpU3hD3AplaZK6xtM=;
        b=tb+G2E4R4ioRdwiwB4f/s9tgu5RKAzlou4OL9baxOFHyqWf/VpC/AJ3qIZSwOHoQvJ
         D0jJbqrT7Msk+leqf2fNZqbMaOOunu8HG9xbrkx6DZz/1uOcWy5fMYReh1yRoxZ6QQYj
         XhzkOknkhQUyRVU9QNz8ON3GNeyXXtIc+inZAnuKiPpL42lYgEm2tbLNO/GJvqJkIRri
         AMbGxuS6bh8dQLyvN5aKOjpDuD52syjGkSoftWTr6TqgTpMDq+kzRDTwkOO9xh/b0D9P
         KGAjF2f8gYsUncK07Kzva1/bcy3x+uG03TeKB2tplGLXp2wg6v2ZB3JOAvmWakqG6k+j
         HplQ==
X-Gm-Message-State: APzg51C2H9bAL7IjAu6GXKdREMp7X8M13pBgeSmUUlRD92RhumYL4wj1
        lOdaZlgDOosNNp4MFSaO8/jsgE0AEdWjUtIDqO1888Uh
X-Google-Smtp-Source: ANB0Vdb93O9MAjMvrdJ16TeZO+fKOW9/pMQ2D6/UgdrQ6DgflvFGXmz2inLMCt1fIcLFsMcYruIYMxpwfx2WnuBeF+4=
X-Received: by 2002:a6b:e317:: with SMTP id u23-v6mr11714490ioc.131.1535721346126;
 Fri, 31 Aug 2018 06:15:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5805:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 06:15:45
 -0700 (PDT)
In-Reply-To: <20180830150639.21048-4-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com> <20180830150639.21048-4-avienamo@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 31 Aug 2018 15:15:45 +0200
Message-ID: <CAPDyKFo0U7f5W=kuEtFMVzn_+e_xe-fNaX1591LmQjOG=33n8g@mail.gmail.com>
Subject: Re: [PATCH v3 03/38] dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>,
        DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 August 2018 at 17:06, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Add bindings documentation for pad pull up and pull down offset values to be
> programmed before executing automatic pad drive strength calibration.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

I noted that Rob added his tag for the earlier version, so I am
re-adding when applying.

Kind regards
Uffe

> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt     | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 90c214dbfb16..9713e052f736 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -45,6 +45,37 @@ Optional properties for Tegra210 and Tegra186:
>    for controllers supporting multiple voltage levels. The order of names
>    should correspond to the pin configuration states in pinctrl-0 and
>    pinctrl-1.
> +- nvidia,only-1-8-v : The presence of this property indicates that the
> +  controller operates at a 1.8 V fixed I/O voltage.
> +- nvidia,pad-autocal-pull-up-offset-3v3,
> +  nvidia,pad-autocal-pull-down-offset-3v3 : Specify drive strength
> +  calibration offsets for 3.3 V signaling modes.
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
> @@ -58,5 +89,9 @@ sdhci@700b0000 {
>         pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
>         pinctrl-0 = <&sdmmc1_3v3>;
>         pinctrl-1 = <&sdmmc1_1v8>;
> +       nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
> +       nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
> +       nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
> +       nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
>         status = "disabled";
>  };
> --
> 2.18.0
>
