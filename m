Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D494AC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930AF2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Klgv3cvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930AF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeJXWSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:18:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46034 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJXWSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:18:55 -0400
Received: by mail-io1-f68.google.com with SMTP id p83-v6so3163718iod.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UwCxgTY7tIBBn3y37lNQQ/aQwUmlWJFHLrrsMY5uiQQ=;
        b=Klgv3cvdarNNMSvtAMDWSQuOdEJ/r2H/JjMSErEkNUU6meA6alzJ2GJ6/hpjFzu6rI
         cZELeefJMnqLx1pI1cN8zV0hlZqicJ2IbR8NzjfFRby9bc87BT8Kaodf/mwqxUZHRbJ3
         UEKmzB7aCOtt4dBn8bVbFxUX6Sa4rkWZnIjYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UwCxgTY7tIBBn3y37lNQQ/aQwUmlWJFHLrrsMY5uiQQ=;
        b=XK49Jgf1ib1gcoswzCo9LoaO33Dq3JSe0YKN6jr8TAXqOaeytCne9TYMGnwOJwDu6i
         xZukZxB1VamnB/6BdIgoykm/+IJrOApo4su7YirFaCOIcentXdRhRa/D48/MgmIDl3+K
         2KZ9Inmq6Fg69M5plbWX5fCdu1209HlTz642bS0qdBOmYi9KdxO+Lyc83u3YvhIWhBDy
         kqbr43o540oMKwpTfCOkHMYcgjRHRXkcFJc4MQ9wfsGAl9y7mqbulMN3DwMurPsfsK9F
         VyOp70ZPlejaunNr/kQRRGmVt6lE5k0FL1w7xxhclmv+MX0CfmGjeLu1LvyB7Tzrrslm
         gn/w==
X-Gm-Message-State: AGRZ1gI7ZY2TIOgV0q1BcLzSR4p60TkXVp/lITd2ShmHW5vCPCy3ZMON
        OO+l490iJXIFlHDp3P9Nf0chQTmEJ+skqg9J/27w8w==
X-Google-Smtp-Source: AJdET5f7v+j/miR03jYCz3xOMpYME5wOcHLabMpD0TFWh7rku4k0To/9z0uzIJlkPtpI7IxEeq9OpJyn7yxHJSzAmos=
X-Received: by 2002:a6b:b487:: with SMTP id d129-v6mr14009360iof.131.1540389042691;
 Wed, 24 Oct 2018 06:50:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 06:50:02
 -0700 (PDT)
In-Reply-To: <1540368084-32202-1-git-send-email-zhang.chunyan@linaro.org>
References: <1540368084-32202-1-git-send-email-zhang.chunyan@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Oct 2018 15:50:02 +0200
Message-ID: <CAPDyKFp8vo11pb-5qVdhkxTgMnL-R0FvYKuh_dkLDNbF6_4=XQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Convert sdhci_allocate_bounce_buffer() to
 return void
To:     Chunyan Zhang <zhang.chunyan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 October 2018 at 10:01, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> The function sdhci_allocate_bounce_buffer() always return zero at
> present, so there's no need to have a return value, that will also make
> error path easier.
>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

This looks good to me, however please re-post to linux-mmc.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1b3fbd9..e94f4aa 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3408,7 +3408,7 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
>  }
>  EXPORT_SYMBOL_GPL(__sdhci_read_caps);
>
> -static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
> +static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>  {
>         struct mmc_host *mmc = host->mmc;
>         unsigned int max_blocks;
> @@ -3446,7 +3446,7 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>                  * Exiting with zero here makes sure we proceed with
>                  * mmc->max_segs == 1.
>                  */
> -               return 0;
> +               return;
>         }
>
>         host->bounce_addr = dma_map_single(mmc->parent,
> @@ -3456,7 +3456,7 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>         ret = dma_mapping_error(mmc->parent, host->bounce_addr);
>         if (ret)
>                 /* Again fall back to max_segs == 1 */
> -               return 0;
> +               return;
>         host->bounce_buffer_size = bounce_size;
>
>         /* Lie about this since we're bouncing */
> @@ -3466,8 +3466,6 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>
>         pr_info("%s bounce up to %u segments into one, max segment size %u bytes\n",
>                 mmc_hostname(mmc), max_blocks, bounce_size);
> -
> -       return 0;
>  }
>
>  int sdhci_setup_host(struct sdhci_host *host)
> @@ -3987,12 +3985,9 @@ int sdhci_setup_host(struct sdhci_host *host)
>          */
>         mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
>
> -       if (mmc->max_segs == 1) {
> +       if (mmc->max_segs == 1)
>                 /* This may alter mmc->*_blk_* parameters */
> -               ret = sdhci_allocate_bounce_buffer(host);
> -               if (ret)
> -                       return ret;
> -       }
> +               sdhci_allocate_bounce_buffer(host);
>
>         return 0;
>
> --
> 2.7.4
>
