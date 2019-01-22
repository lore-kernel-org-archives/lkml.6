Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4763C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD2E20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6Rgma1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfAVHsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:48:15 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35391 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfAVHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:48:15 -0500
Received: by mail-ua1-f67.google.com with SMTP id d2so7768685ual.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwyyxkK4gwZQKHoOaCakVlmr8Hf7JNkT5CdDI+U9+RI=;
        b=B6Rgma1lj27laPlgH8iAWVHqNMyv4rvl3sX05ZGsMSkfeUS4E9+HlHN/IeduGBiOUA
         K6w5ryisl6ZvsuwKqw/9pa6KSqb8IvSnPJW3llc+Zp3WExNqJs0G5xLuz+uh9BP+T7Ut
         AJz2l78WlwWW4o/7bPcKplMHA6jYXT4m+buJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwyyxkK4gwZQKHoOaCakVlmr8Hf7JNkT5CdDI+U9+RI=;
        b=TJTLkg8UC8iCoMrvUt7YierEkVvby9EJiHKVQruwlrK7A+YQnTwTw7ncLTUbUmEZ2a
         ithZT2BMo2Nndis29EWSz4P9nf4TzgwmhYo0OzRROcQdOvowOitl1vLXQu3IVPr1CEqK
         4Mj0HhJSrxTYh4dp+o1qM1fOHCpQL6mZMx3MqVvehpUgiNmevCs0SWDt2dF4oI7gHFto
         171TTQdVXDd5Nyf3qz4PzjszPz1Pi88UGbTHbou709vLN/HkdAK/S/kBsW786toOKA1P
         RY8+SWXpqZvIiuGSHaZf8myhHVFun4YdNhGNBS4f9Znfl91t8Qy11V+vEOOVqxK/cNJk
         wHaA==
X-Gm-Message-State: AJcUukccJf+D8qa9d09YE8FWfHb1l98dTbIxstQUATeCZAeHNge8XE0Q
        9zVPopQdM5YOBwWj2DsLXMuQBERWBCStih7j1CPOsQ==
X-Google-Smtp-Source: ALg8bN7rQRTAoRlwAeaXJOkeLosO3JaMN0ZbqRxfl4H/3azBCnZUYW4Pyp2U+k/Yrciu+H3ul3VKkr/+MIcSb94/g3c=
X-Received: by 2002:ab0:b83:: with SMTP id c3mr12265353uak.77.1548143293753;
 Mon, 21 Jan 2019 23:48:13 -0800 (PST)
MIME-Version: 1.0
References: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Jan 2019 08:47:37 +0100
Message-ID: <CAPDyKFqHtg2TuUKNrg8Xue9jrni+8iw_KxDx5W0+4+FHsqsNZg@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: mmc: tegra: Add pinctrl for SDMMC
 drive strengths
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>, anrao@nvidia.com,
        DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 23:46, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Add pinctrls for 3V3 and 1V8 pad drive strength configuration for
> Tegra210 sdmmc.
>
> Tegra210 sdmmc has pad configuration registers in pinmux register
> domain and handled thru pinctrl to pinmux device node.
>
> Tegra186 and Tegra194 has pad configuration register with in the
> SDMMC register domain itself and are handles thru drive strength
> properties in sdmmc device node.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 32b4b4e41923..2cecdc71d94c 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -39,12 +39,16 @@ sdhci@c8000200 {
>         bus-width = <8>;
>  };
>
> -Optional properties for Tegra210 and Tegra186:
> +Optional properties for Tegra210, Tegra186 and Tegra194:
>  - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
>    configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
>    for controllers supporting multiple voltage levels. The order of names
>    should correspond to the pin configuration states in pinctrl-0 and
>    pinctrl-1.
> +- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable for
> +  Tegra210 where pad config registers are in the pinmux register domain
> +  for pull-up-strength and pull-down-strength values configuration when
> +  using pads at 3V3 and 1V8 levels.
>  - nvidia,only-1-8-v : The presence of this property indicates that the
>    controller operates at a 1.8 V fixed I/O voltage.
>  - nvidia,pad-autocal-pull-up-offset-3v3,
> --
> 2.7.4
>
