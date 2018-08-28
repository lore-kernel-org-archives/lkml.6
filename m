Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93CFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E30F2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVlvQzd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E30F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeH1Pc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:32:59 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40656 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeH1Pc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:32:59 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so1140759iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XB03VDt7FV6YZAWdKEBeZjAo7NTupFiUj/I6QdtrieE=;
        b=EVlvQzd2W8XFrn/2UfFJz7pP1fRTtKwhNEa+Sli15pnk0J85rMZfyDE7zYWIIV+3RN
         3Zl5eJSpPhpbX/h81lVRoAxS1d/n0PYDW0vHmgpaiRsQdbutknPgSoUN0MWvmGq2tGVz
         ZBeYnq4zXiw0Yl/V9UFFFlIjRfCbRtXxbpziw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XB03VDt7FV6YZAWdKEBeZjAo7NTupFiUj/I6QdtrieE=;
        b=e/MJEjTDZxHRBK066N2L1rfPnUeyZl15wRv5jy035lQJU3fa5sDhlTJSsv/osjsE2P
         ksajm7N1ba3RADJaUjUVoOe5I/egDi2W5DYFCrcnWvLwFln8FzOvYY3wKRMXcR+QQZe+
         dDh+60EVW8lHdFa8kNBor0xnp8TOuTFVXi26JHBgfMa/X6/6apiHew2KyaefAnqAk32s
         c/7/aeC94SeveS5qvGYygMSMB/YmO7Ve6vch21OwZzz7/BfZt9TUKDVfkyFeTQh3U7vb
         WdgyuHVqCxlRHJ88E0Su3GGn/cEbknqUeSIdy/r8Eru147RAKzeT3vo1C5Ytsq695DUU
         PJMw==
X-Gm-Message-State: APzg51Bze/95sfmDle6HxVplviwLeUnAgp0sKnB/WzBhvaUarlToUvx/
        uLx8RCJrCcBRx7p6Pu+G9hAwAAod9K50LyVcIxVHHoFz
X-Google-Smtp-Source: ANB0Vda9AqB9Z7zccMlmzFlaYM3+qjln1lNj5BPkKOk6g/IipEIXW9BXO1YR0dJEMUyG2/p2RTppxspuH/BkS2iLr4E=
X-Received: by 2002:a6b:e317:: with SMTP id u23-v6mr853037ioc.131.1535456503708;
 Tue, 28 Aug 2018 04:41:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 04:41:43
 -0700 (PDT)
In-Reply-To: <20180828015252.28511-32-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-32-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Aug 2018 13:41:43 +0200
Message-ID: <CAPDyKFqojsx5Dp1McG+9i=RThCGwoyzjU0zSYB0dybbQ9H-5JQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hu Ziji <huziji@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 August 2018 at 03:52, Rob Herring <robh@kernel.org> wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Hu Ziji <huziji@marvell.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index c335052d0c02..5956e90380e8 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -660,8 +660,8 @@ static int get_dt_pad_ctrl_data(struct sdhci_host *host,
>                 return 0;
>
>         if (of_address_to_resource(np, 1, &iomem)) {
> -               dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %s\n",
> -                       np->name);
> +               dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %pOFn\n",
> +                       np);
>                 return -EINVAL;
>         }
>
> --
> 2.17.1
>
