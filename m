Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AC1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE7620659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpucYbgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfANLpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:45:33 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34878 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfANLpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:45:30 -0500
Received: by mail-vs1-f65.google.com with SMTP id e7so13408818vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 03:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdREFb/h1cgiJuv6msebW3MKi9PJWb+jT0u3Yjseat0=;
        b=QpucYbgQ4v8Ly5hS3gBEhxxIrX3ye+AE2QIWf18BTxFjA8vv8CNj2PfDM1dhCvVA2D
         NbwhSVPTbNK6/ynLCiaPmbepj2nK6jGqaBh1h7GdccmE3wOBeLYwTsQJb2cP/r0dy0sz
         rFmuhBnMb56AsANVIAaRJv+4XMtJGj2sGEQw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdREFb/h1cgiJuv6msebW3MKi9PJWb+jT0u3Yjseat0=;
        b=so4fvN6cabw/6f5pXB2QlCMJGj+Iw9teJ7zEdi65ttCmLSxM7/iEcWD9gcCA0fZ50r
         aeecCqiDIXM1+LRgTPJ7IJD+P5Osj2uTA7W9wZJLn6Dmv1VQDKyeCqalGPp/zUCyg+qa
         bwGfEVdbQ+ZSZylDGu3hCS7g38ZN33yWzTlL1HI+CyJ9VkLAXunSS2/b42uVeyldM2qS
         vmwHxKp3m63o6xhwUVMWEtbg7u9y00rl8e6Nv5hfnT2RYWWYyoi7AFsue+G1qtLvssLl
         3M4pergu2/wXsdFMZQ50kRWxlQHdkLEjfL4hWzHD0yrJ5zywSSgFVIzGBSTHg3QkzCIk
         4ZpA==
X-Gm-Message-State: AJcUukdvq4zjCN6/DzW3YnYb04xKhqZD4EQPiV3tUClem4CWXT9Q9eWo
        MFLbty2xOvhxuqXAuwUpCAeCxZ9XL8ER9CsSNfVrcVy8qD0=
X-Google-Smtp-Source: ALg8bN4fnF2vm40ubEFDoDv53xBTaSWS7lnoLKZPwfaXVXvf0MwWjZq1uNr9gF2x9fxV4sQPIrS49cCNcmNA5VeYGKQ=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr3842574vsc.34.1547466329532;
 Mon, 14 Jan 2019 03:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20190109124312.10154-1-faiz_abbas@ti.com>
In-Reply-To: <20190109124312.10154-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Jan 2019 12:44:53 +0100
Message-ID: <CAPDyKFr9e2MvhU2HTAEaKydfQ5=0hB-Qmcw5FUw=T7z0XDYKFA@mail.gmail.com>
Subject: Re: [PATCH] mmc: Fix Kconfig warnings on keystone_defconfig
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Keerthy <j-keerthy@ti.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 at 13:40, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Commit 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)") added a select on TI_SOC_THERMAL
> for the driver to get temperature for tuning.
>
> However, this causes the following warning on keystone_defconfig because
> keystone does not support TI_SOC_THERMAL:
>
> "WARNING: unmet direct dependencies detected for TI_SOC_THERMAL"
>
> Fix this by changing the select to imply.
>
> Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)")
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e26b8145efb3..bc61eefcb695 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -978,7 +978,7 @@ config MMC_SDHCI_OMAP
>         tristate "TI SDHCI Controller Support"
>         depends on MMC_SDHCI_PLTFM && OF
>         select THERMAL
> -       select TI_SOC_THERMAL
> +       imply TI_SOC_THERMAL
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           support present in TI's DRA7 SOCs. The controller supports
> --
> 2.19.2
>
