Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D512ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD34208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gx1hp6WX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD34208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbeGPKiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:02 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34965 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbeGPKiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:01 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so37258132iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6BG2GFRFf/12wXMN/jFHpgwSxkgZKyfC+0Faha92Blw=;
        b=Gx1hp6WXraf2pOWidq9PLIc0tKcxxr/nBLhm71XD2mC+UnsmG8F5jiAO+rxbKQAMS5
         X0AYNx8/tU0CrpO364mawq8B963XZi1CRhrmPKTcRaDES7mhA7F/cISkC+NyX/u64a6N
         ErjyGteI1XagfFv7ZJsDHFYEOWxqUrQwf3Kis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6BG2GFRFf/12wXMN/jFHpgwSxkgZKyfC+0Faha92Blw=;
        b=d46VidEGRy69Lk0BKmuq5ptbhqjlrjO7USH9Aood5FyaUTL4zFRdNHR92H1i+UaXQE
         3eqZO5Gb75qVFnTj5apjFZfOLGcUhdrRHKuH9YoGudcDR86/8kiJREmWlK3PiKKMf0zb
         U+NB4VM817M70MlWu3OY+7pjMgaRjZb1ATccCvkPTJTfChx8f8Wjj+AeU68DdC/h7ak5
         Ao4p6KNenAFEd1ziqZmLm0i9wcTKwiF34d+QIdtZf3H97R7aF7Zj+b10ecWdauPrsSsZ
         J7S5Hw0yheB/c2zKgjbYFUf8K5cJF4yG9K2dy5fqNdbZM8KCedc4n2IdIMpZdtpLuUkk
         AEIA==
X-Gm-Message-State: AOUpUlFm667GhNZ9OhBuAkLbTUJmxNw9i1mW9zdTwPkUuEZTh6XKwTcW
        W4aGsu7POiVixWYBZRR6tV/Ji1bj7wl51hw0LrHQJg==
X-Google-Smtp-Source: AAOMgpe3jTE2sBTMqIdwSex5Ad9Vi4m7qzCYmoESmSfhSAhCrlzPXmiA0rTXFjYAtPiuEL2lsbN12g02i+iVBJVF6jc=
X-Received: by 2002:a6b:144c:: with SMTP id 73-v6mr38366277iou.218.1531735880805;
 Mon, 16 Jul 2018 03:11:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:11:20
 -0700 (PDT)
In-Reply-To: <20180712080650.13878-1-stefan@agner.ch>
References: <20180712080650.13878-1-stefan@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jul 2018 12:11:20 +0200
Message-ID: <CAPDyKFrwn--7=jRzSrQ2ZDgn1NL8C2ckYgtneH45b8ejNn-e0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: disable clocks before
 changing frequency
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 July 2018 at 10:06, Stefan Agner <stefan@agner.ch> wrote:
> In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency
> is set to 0. However, it could be that the stack asks for a frequency
> change while clocks are on. In that case the function clears the
> divider registers (by clearing ESDHC_CLOCK_MASK) while the clock is
> enabled! This causes a short period of time where the clock is
> undivided (on a i.MX 6DL a clock of 196MHz has been measured).
>
> For older IP variants the driver disables clock by clearing some bits
> in ESDHC_SYSTEM_CONTROL.
>
> Make sure to disable card clock before changing frequency for uSDHC
> IP variants too.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 85fd5a8b0b6d..acacd8481473 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>         int div = 1;
>         u32 temp, val;
>
> +       if (esdhc_is_usdhc(imx_data)) {
> +               val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> +               writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> +                       host->ioaddr + ESDHC_VENDOR_SPEC);
> +       }
> +
>         if (clock == 0) {
>                 host->mmc->actual_clock = 0;
> -
> -               if (esdhc_is_usdhc(imx_data)) {
> -                       val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> -                       writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -                                       host->ioaddr + ESDHC_VENDOR_SPEC);
> -               }
>                 return;
>         }
>
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
