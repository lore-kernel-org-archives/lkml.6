Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70730C65BA7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3778E213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="en0Tx24b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3778E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeJCQke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:40:34 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35921 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeJCQkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:40:33 -0400
Received: by mail-it1-f194.google.com with SMTP id c85-v6so7954001itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pYZFWZVRPNy0vp6foMV7AM9BjVP/w+VZBx1zARZrPSc=;
        b=en0Tx24b/cqrcWa5BTJkOdP8M0pqhQwCsUDfZh6ia6AwPicSqp/e7K8Z3pAWshsutw
         9fqSOpgSQB59umWiOsmmEh8KgmyBubf9FX3oZRDyNid9YQ7aCJiQ5qK9Mi3kqj522qGe
         HxiKQ1wtj7LHEOLu0elrJD/TWOFydHLBvES+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pYZFWZVRPNy0vp6foMV7AM9BjVP/w+VZBx1zARZrPSc=;
        b=dhUa9CCFIeKLr/sPWYbfC9TSmHjBqQkY/CnsIPwTsNQ7ZdAWSF1hD0NWCSUQWguP90
         ihf6GRqToYMqWkbLsczetTA5GPnsLd0iQlHAP5/b5vv1f9JDNExtNWoEtX5fNva0TdCD
         CjyMGlV32cGpye/EXlOcTkE78SzT4c6lC48v7KpRCUirhOacYOJC27flgZkddVRS2YAz
         8t8qgXQWPN4Acdw/FAC1RIpl7V45P8Tu1FiYVtKl5ZMPQdbJYez9gDHsnhG9yU3nTIdc
         xn2hAwjF5oAPeCiuDXpyqpfsvnPoCLOqfUEg8rjLFfR7RkMFWxPmMbxEDO/euXM5PmpM
         yWkg==
X-Gm-Message-State: ABuFfoiwBJ/2QvGKAscMDO2SdMkyyZLdEcYfEgnQRkMW+sFaV3OBJFCP
        4+8KUppNNRTBnRzRgN9tVmFkTCGgOt/x3o7PUidWSQ==
X-Google-Smtp-Source: ACcGV6375l1FSVAd8rPqgg9krzvrUTWKe+lz2WpeLfu/TzEpzFOiUoFtbYPgDv7f1coZAGSIc1mEglyA7mX0PjQkvUk=
X-Received: by 2002:a05:660c:243:: with SMTP id t3mr650250itk.146.1538560373885;
 Wed, 03 Oct 2018 02:52:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Wed, 3 Oct 2018 02:52:13 -0700 (PDT)
In-Reply-To: <1538143910-24400-4-git-send-email-jonathanh@nvidia.com>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com> <1538143910-24400-4-git-send-email-jonathanh@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 3 Oct 2018 11:52:13 +0200
Message-ID: <CAPDyKFrfcQX0-QrMKy=E=rif9-SjSfxc+LTMBUn5oqOquRdqRg@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] usb: xhci: tegra: Add genpd support
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>  static int tegra_xusb_probe(struct platform_device *pdev)
>  {
>         struct tegra_xusb_mbox_msg msg;
> @@ -1038,7 +1095,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>                 goto put_padctl;
>         }
>
> -       if (!pdev->dev.pm_domain) {
> +       if (!of_property_read_bool(pdev->dev.of_node, "power-domains")) {

I am assuming the original check was because allowing the two
power-domains to be (wrongly) modeled as one (or as a
master+subdomain)?

I was thinking that, perhaps we should add a new OF helper function,
where one can get the number of specifiers being listed in the
power-domains property. Would that help to easier distinguish what to
do when dealing with backwards compatibility?

>                 tegra->host_rst = devm_reset_control_get(&pdev->dev,
>                                                          "xusb_host");
>                 if (IS_ERR(tegra->host_rst)) {
> @@ -1069,17 +1126,22 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>                                                         tegra->host_clk,
>                                                         tegra->host_rst);
>                 if (err) {
> +                       tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
>                         dev_err(&pdev->dev,
>                                 "failed to enable XUSBC domain: %d\n", err);
> -                       goto disable_xusba;
> +                       goto put_padctl;
>                 }
> +       } else {
> +               err = tegra_xusb_powerdomain_init(&pdev->dev, tegra);
> +               if (err)
> +                       goto put_powerdomains;
>         }
>
>         tegra->supplies = devm_kcalloc(&pdev->dev, tegra->soc->num_supplies,
>                                        sizeof(*tegra->supplies), GFP_KERNEL);
>         if (!tegra->supplies) {
>                 err = -ENOMEM;
> -               goto disable_xusbc;
> +               goto put_powerdomains;
>         }
>
>         for (i = 0; i < tegra->soc->num_supplies; i++)
> @@ -1089,7 +1151,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>                                       tegra->supplies);
>         if (err) {
>                 dev_err(&pdev->dev, "failed to get regulators: %d\n", err);
> -               goto disable_xusbc;
> +               goto put_powerdomains;
>         }
>
>         for (i = 0; i < tegra->soc->num_types; i++)
> @@ -1099,7 +1161,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>                                    sizeof(*tegra->phys), GFP_KERNEL);
>         if (!tegra->phys) {
>                 err = -ENOMEM;
> -               goto disable_xusbc;
> +               goto put_powerdomains;
>         }
>
>         for (i = 0, k = 0; i < tegra->soc->num_types; i++) {
> @@ -1115,7 +1177,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>                                         "failed to get PHY %s: %ld\n", prop,
>                                         PTR_ERR(phy));
>                                 err = PTR_ERR(phy);
> -                               goto disable_xusbc;
> +                               goto put_powerdomains;
>                         }
>
>                         tegra->phys[k++] = phy;
> @@ -1126,7 +1188,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>                                     dev_name(&pdev->dev));
>         if (!tegra->hcd) {
>                 err = -ENOMEM;
> -               goto disable_xusbc;
> +               goto put_powerdomains;
>         }
>
>         /*
> @@ -1222,12 +1284,13 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>  disable_rpm:
>         pm_runtime_disable(&pdev->dev);
>         usb_put_hcd(tegra->hcd);
> -disable_xusbc:
> -       if (!pdev->dev.pm_domain)
> +put_powerdomains:
> +       if (!of_property_read_bool(pdev->dev.of_node, "power-domains")) {
>                 tegra_powergate_power_off(TEGRA_POWERGATE_XUSBC);
> -disable_xusba:
> -       if (!pdev->dev.pm_domain)
>                 tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
> +       } else {
> +               tegra_xusb_powerdomain_remove(&pdev->dev, tegra);
> +       }
>  put_padctl:
>         tegra_xusb_padctl_put(tegra->padctl);
>         return err;

[...]

Kind regards
Uffe
