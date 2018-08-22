Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3C1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB25214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYwdixg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB25214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeHVNMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:12:18 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40428 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeHVNMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:12:18 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so2131313ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZthPFS20I/imVDawOw9yS5KRc4yvAExQvNkU3rAZFvo=;
        b=eYwdixg2odRIgEOlYRkc1BsX9dUG+OXtpf1YUpgeASyU8OLYTsn50a/yAKTnGpXBCK
         HZTS/3gJDvReNfYC9Z1Z5xNjHguC86W4k143rnO0Dz+pbwmtBCk4lNmYYj/FOsLQjwVg
         ZLHLWvai0EQPAZe8WwXTp4xRwR929lq3lk4VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZthPFS20I/imVDawOw9yS5KRc4yvAExQvNkU3rAZFvo=;
        b=a8F9qhF0mp1c1f55xxk9SXaz4k6JVKFInxIWE5ZC0/ZE/SA8+1nKu/vIqSY2XIuN6q
         HDyHE2/cM9fS2eIbqoBAU2XoxS/Xk/rdj1iK5zRByyPNPOUbzAtXxq+RPwVMeECoYkxx
         A+kT7puo6FjctScbhQfyY2usvzjg/wGS30h4VeuAAK1IrexjJmAi7XWnaLndM0lpXbc1
         4ueIwcIUIKxFMeKcGiYCUuXVlfj/p3trkEam0cWEfvk6F7SY1IJ/YwZlWQUesbxhbY5m
         IMc0S+DEsmL5JO8IFi9EULICn4pjFTj2CmPbFajDfA4vaCLMXoPBkjQFru8NM123fJUW
         2NuA==
X-Gm-Message-State: APzg51ASpZpKrYYpCyzWO6sI/pR3WFh7Hq8qlMo6BREqyYlEVJPPq8Fv
        L7rWwDhmceuKwjFRi6jy85D0GPzNfdpOD4MlAq8nMw==
X-Google-Smtp-Source: ANB0VdbmO7UVN4D7WQqIHJI9ZLIZ/CYo+O7DWCDXhkBIRyYl5VS8Q3r/lD7GNSy2OMBbLuDooRPQIty4dq11FkG7TQI=
X-Received: by 2002:a24:3fc6:: with SMTP id d189-v6mr2493119ita.64.1534931289103;
 Wed, 22 Aug 2018 02:48:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 02:48:08
 -0700 (PDT)
In-Reply-To: <c9688c600633ce9f4d7b6319366116e6e7c4b97d.1533544988.git.michal.simek@xilinx.com>
References: <c9688c600633ce9f4d7b6319366116e6e7c4b97d.1533544988.git.michal.simek@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Aug 2018 11:48:08 +0200
Message-ID: <CAPDyKFqS8k53TvQ8ON_+uQ3ynZ0JGGWxv1k9K5pDPMZ4hYkOpg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Do now show error message in case
 of deffered probe
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 August 2018 at 10:43, Michal Simek <michal.simek@xilinx.com> wrote:
> When mmc-pwrseq property is passed mmc_pwrseq_alloc() can return
> -EPROBE_DEFER because driver for power sequence provider is not probed
> yet. Do not show error message when this situation happens.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Thanks, queued for v4.20!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index e3332a522a5d..e65f3bce3643 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -772,7 +772,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret) {
> -               dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
>                 goto unreg_clk;
>         }
>
> --
> 1.9.1
>
