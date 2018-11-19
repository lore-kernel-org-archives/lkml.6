Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CA0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE7E20671
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GduGwELN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE7E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbeKSXnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:43:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54281 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbeKSXnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:43:04 -0500
Received: by mail-it1-f195.google.com with SMTP id a205-v6so8135255itd.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 05:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X1hwbqHB8wj5zSjDLM3U/OJpi7dx7f2yxpPkG9WM/Qk=;
        b=GduGwELNI97/vFhj1G/8E6o0qLrCZ1tB1YNhb+bVPvglFr4CvbmtdKBsGpZR5cqRRB
         lA1TrGqpt2XFAdrHvCB+/pz2KCBR6LkM16kfpy1WKjYX0cEagHBZqLtO02VLqNbzRSXL
         lNasN8LyvaUuiOIGf3J3LZ0+JNPI/6o4VMbdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X1hwbqHB8wj5zSjDLM3U/OJpi7dx7f2yxpPkG9WM/Qk=;
        b=pfBG4v0kWYQ8GaIlKdU4YyJ225k+vh7xSmtqc5g26xBW8aK7ZdF92jSqvyNRSH52HO
         nFWwZGV6q2dmgi1cDLemwXja36VxZSDQhS2Bp1WL+c5C+Tue6jwIlVS+LhHRP3LRjETN
         F5QSIr1HFfDlkhpInYDS3AfCPvX3IYvsbDIt3TpSFKjM2pH3/xpnPUlRg9eS9nMMloVI
         0dW8giscxWYgXXZXXGJvv5UlcY3QYEULv8HlzPi+NzmcBT3HuQGH3NoDsd9QQZSLKpos
         VJMpRB5coG8TMIm2dAhf89fh1uEdCOZ2EdDSx5QDLI4A9vmvK5OXBsag2OpYItKz8mK/
         d/MA==
X-Gm-Message-State: AA+aEWaTYbC9ojUJIACca7IjHttYsDoie/hK/VbFWSNqvJxdpfWvrfgM
        3GGtRiPuDdzsKP5CDUmBVAUMOV0VmBs2FgOMrfBuUg==
X-Google-Smtp-Source: AFSGD/WqUbDMqtYK2ARayNF2de9VVymVp9Urv4eFFEcmq7OPPV8zOarjcLT9p94WwR1YlDpnv774u7KRZHG2E2GUZjU=
X-Received: by 2002:a24:108a:: with SMTP id 132-v6mr7821245ity.78.1542633567082;
 Mon, 19 Nov 2018 05:19:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 05:18:46
 -0800 (PST)
In-Reply-To: <20181119111618.2745-3-faiz_abbas@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com> <20181119111618.2745-3-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Nov 2018 14:18:46 +0100
Message-ID: <CAPDyKFqkscm9ZhJhk7SWFc_tmqqqXSx5_t2tzEL-DV6aE+Q=KA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: sdhci-omap: Add variable to indicate host is tuning
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 November 2018 at 12:16, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Add a variable in sdhc_omap_host to indicate whether a tuning
> operation is ongoing.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Please squash this into patch3 as it seems a bit silly to keep this a
separate change.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-omap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 87138067e334..cfffcf58be3f 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -115,6 +115,7 @@ struct sdhci_omap_host {
>
>         struct pinctrl          *pinctrl;
>         struct pinctrl_state    **pinctrl_state;
> +       bool                    is_tuning;
>  };
>
>  static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
> @@ -318,6 +319,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          */
>         host->ier &= ~SDHCI_INT_DATA_CRC;
>
> +       omap_host->is_tuning = true;
> +
>         while (phase_delay <= MAX_PHASE_DELAY) {
>                 sdhci_omap_set_dll(omap_host, phase_delay);
>
> @@ -355,9 +358,12 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         phase_delay = max_window + 4 * (max_len >> 1);
>         sdhci_omap_set_dll(omap_host, phase_delay);
>
> +       omap_host->is_tuning = false;
> +
>         goto ret;
>
>  tuning_error:
> +       omap_host->is_tuning = false;
>         dev_err(dev, "Tuning failed\n");
>         sdhci_omap_disable_tuning(omap_host);
>
> --
> 2.19.1
>
