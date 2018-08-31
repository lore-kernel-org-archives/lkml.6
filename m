Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D23CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FA920837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5L3fhNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FA920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeHaRXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:23:02 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37506 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeHaRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:23:02 -0400
Received: by mail-io0-f196.google.com with SMTP id v14-v6so10370488iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rPH49TPACED217PamH8I4AvEnI8J7d2MsCPRIlGAUHU=;
        b=D5L3fhNQrBbeG01MwgbFzB6t6tqcvWZAQ4dqHvReBPnDiNt7IJbvLQPBJpx/9IapIZ
         efSFI7ltKyZC0lrpq4ZHRVTC3gO8JL5FHPcUPdQHiTS9hlvxlQpjfejZW2E1IzWHlRiQ
         xiQnSp3dlTk8y3P9dt8XObWt54Iiy0RFVtddQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rPH49TPACED217PamH8I4AvEnI8J7d2MsCPRIlGAUHU=;
        b=Ls6M5Mj2wdqrt0Df/h8s4otayOBGV9lXA56sScVMQsiawF/LzMWa95EmOc0JMmThtN
         uDNUBH3TLYflnso2BrhvhwWwa5XJic2d5/OxpYKdCFOU8sX90QqATzlS5RW7tJx3M+hi
         6M0uRvtv/K3xUn7w1lM6IkGhkayJ6DQtgXt+/p+VsPr51gM6w7WT4tXJK5geIBjQVpUz
         /soLKgsgDBRjzUwaaZYuxbEL7k4D2tm25lDq2A5sWxQMJq9aiT2Dca479Try+sSKGMFi
         x9YDz4ZZ8zYxwqNu5AqQGOlSegMkVc1oecnUj2FuUmif9lh4C5d3sELTNC3L5J+BmLxc
         4ITA==
X-Gm-Message-State: APzg51CHac3SgYgtnjAoMT0JI0rMSQOGrRSNv4xMCwOs2/UtwusvDvLO
        vL9UMBmwYDiWzsjLIJFipQzojkfXQYOyPs3D0otaUw==
X-Google-Smtp-Source: ANB0VdbAWXvZtmVqDcsglYWt3hRV6MCyGoAIgA1WgF9enOQOXW/zrT4m9Y0C7nqdbl10oQwWb5bkjskCol7kOTx7VW8=
X-Received: by 2002:a6b:1416:: with SMTP id 22-v6mr11896474iou.218.1535721335631;
 Fri, 31 Aug 2018 06:15:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5805:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 06:15:35
 -0700 (PDT)
In-Reply-To: <20180830150639.21048-3-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com> <20180830150639.21048-3-avienamo@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 31 Aug 2018 15:15:35 +0200
Message-ID: <CAPDyKFouUgYrx_oEJF8WHrtDbtEifSJnk-a0LeJEKw9eQFXX3A@mail.gmail.com>
Subject: Re: [PATCH v3 02/38] dt-bindings: mmc: tegra: Add pad voltage control properties
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
> Document the pinctrl bindings used by the SDHCI driver to reconfigure
> pad voltages on controllers supporting multiple voltage levels.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt     | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 9bce57862ed6..90c214dbfb16 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -38,3 +38,25 @@ sdhci@c8000200 {
>         power-gpios = <&gpio 155 0>; /* gpio PT3 */
>         bus-width = <8>;
>  };
> +
> +Optional properties for Tegra210 and Tegra186:
> +- pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
> +  configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
> +  for controllers supporting multiple voltage levels. The order of names
> +  should correspond to the pin configuration states in pinctrl-0 and
> +  pinctrl-1.
> +
> +Example:
> +sdhci@700b0000 {
> +       compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
> +       reg = <0x0 0x700b0000 0x0 0x200>;
> +       interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&tegra_car TEGRA210_CLK_SDMMC1>;
> +       clock-names = "sdhci";
> +       resets = <&tegra_car 14>;
> +       reset-names = "sdhci";
> +       pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +       pinctrl-0 = <&sdmmc1_3v3>;
> +       pinctrl-1 = <&sdmmc1_1v8>;
> +       status = "disabled";
> +};
> --
> 2.18.0
>
