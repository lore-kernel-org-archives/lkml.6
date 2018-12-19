Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90783C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A16A214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PuATJTrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeLSLjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:39:53 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36209 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbeLSLjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:39:51 -0500
Received: by mail-ua1-f66.google.com with SMTP id j3so6853858uap.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 03:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvN1hVkTzl4TH/auI8JoTvY6tSY1+vyIaE0VKYGGHzo=;
        b=PuATJTrBycy63DV4rXH6tqijcPAj+z4ROBEfd7eddfuicWy8oX2LJOtB9s1dTldxHy
         rFTUCm0B05ieMQo/UYDQ2hJePR0IPDfBrADjQnAXRbLeBuEMx/r/IS2N0bSj8X/Jc+n/
         QVIBfiuCVKQ2N953w2dxkFOHxqZop/XgMRHBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvN1hVkTzl4TH/auI8JoTvY6tSY1+vyIaE0VKYGGHzo=;
        b=mW82JlRjgcfMsQnvurkHVmVTdBfzwShsS5u1/OOazncvkio5DZeehMg4RrTuqD2tPH
         KVb0/GYJcra5SsiT+8tsGC+V9RI3v8Z8TPLB4lskI1xgNOc11NMw8E4sN6QQKk4jEIZ+
         H08e1jrNgU0f8wtmog431vx3UnjVvQOsdLRV6RVGIWFqiSWhC/1EgGvjj85lRljveQeU
         Ew0K9jTQGXuhfUdC6++l1JNw6WWbq88wbWqjI8rjmjDKOqueXpGVVwjUuLeegEaS79Tg
         Mr1z06yMTGNr7gDzA8YkkXimJlEu88Vibe1sm5963mZy3lEMAMif6IkmmzrLvFOawK6X
         q8Kg==
X-Gm-Message-State: AA+aEWY9hobL1jZUxyT7vdz9uhKeq4X9tAcQRPTqWfZKsm7nETYl27Il
        +OLNxDzJpORklKNz2jGYePGXsPfDvYxNgdTnN4pymA==
X-Google-Smtp-Source: AFSGD/XZTKliku5awH2M2GLrVEfc7ehtUTUeOjRdZm8pIMETmxqkWk7o0XqqhnVhEXFxpuIndn02cBBlHjvzA2Qi1S0=
X-Received: by 2002:ab0:526:: with SMTP id 35mr9921388uax.25.1545219589979;
 Wed, 19 Dec 2018 03:39:49 -0800 (PST)
MIME-Version: 1.0
References: <1545160787-3157-1-git-send-email-skomatineni@nvidia.com> <1545160787-3157-2-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1545160787-3157-2-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 12:39:14 +0100
Message-ID: <CAPDyKFoVq4HwdrJ_X3jv41ahXHnp6MbU8fmC83HJ6bhN5MYMhw@mail.gmail.com>
Subject: Re: [PATCH V1 2/2] mmc: tegra: SDMMC pads auto-calibration
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>         if (tegra_host->pad_calib_required)
> @@ -805,8 +854,15 @@ static int tegra_sdhci_init_pinctrl_info(struct device *dev,
>                 return -1;
>         }
>
> -       tegra_host->pinctrl_state_3v3 =
> -               pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
> +       tegra_host->pinctrl_state_1v8_drv = pinctrl_lookup_state(
> +                               tegra_host->pinctrl_sdmmc, "sdmmc-1v8-drv");

This requires and updated DT doc for tegra sdhci. Please make that a
separate patch and put it first in the series. Also don't forget to
include the DT maintainers in the to field for that patch.

> +
> +       tegra_host->pinctrl_state_3v3_drv = pinctrl_lookup_state(
> +                               tegra_host->pinctrl_sdmmc, "sdmmc-3v3-drv");

Ditto.

> +
> +       tegra_host->pinctrl_state_3v3 = pinctrl_lookup_state(
> +                               tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
> +

The above looks like an unnecessary line change. Please just stick to
the existing format and avoid changing code that doesn't need to be
changed.

>         if (IS_ERR(tegra_host->pinctrl_state_3v3)) {
>                 dev_warn(dev, "Missing 3.3V pad state, err: %ld\n",
>                          PTR_ERR(tegra_host->pinctrl_state_3v3));
> --
> 2.7.4
>

Kind regards
Uffe
