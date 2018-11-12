Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52A8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA43223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPqVVcT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA43223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeKLU6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:58:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37658 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbeKLU6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:58:48 -0500
Received: by mail-it1-f196.google.com with SMTP id j79-v6so12581719itb.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 03:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vKlOBiuFbIol/qgBBWZ68+LA2QXtyJLGRQ4ZpHNWM4Y=;
        b=YPqVVcT1egygCplqeF/iHDVXsJrK5uBHUWvwI+Wuwq/oAHrme7KMKkzyrPLbgiTJR0
         tSpnoVuBkM7umtPZyqvN+COz1Mn9KvEbC6nY1zDNPwSyMYpWOWwtLSthK/f4C8uJiLX5
         RrTn3uqJpMlu5G3a0IDiheGViutYdwxk03eqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vKlOBiuFbIol/qgBBWZ68+LA2QXtyJLGRQ4ZpHNWM4Y=;
        b=U6yWBr/f1Ae/cqhb9TPZIhhMKzncDHD2lh8/dp0m+thgMRYe24DJ5SKp9t3jWpiH+x
         ohRJOM6oVN2W9+Xe4Fk1CfOe1ne7xxnC36X67Q4VU+01MgkLmhzWQYFTAn1rGAKd3g26
         tii4gH5gb6IX+CxinNCnBelWCLIgQHJKPGVCwjPgeUgKJzXeoTFqL8nEzE4hpCfcvgca
         1O25hLeTdLqKCkYkLVCElKycIkKfA9UV8hZ3yW5GFAuWdxc3dPkPc/YefytLA5qn7e38
         FcTHO2zsfoeM8mRg/DZvp1WeNg6c6irAvKRUvIPn8AIV/kTYSW1ykj/cgO8AShXsMC0Y
         G1tQ==
X-Gm-Message-State: AGRZ1gL5Y+dL/EZ44tvpTrohbUa0p+Edcr/AqnEOqOWDzYfqUHBbQ8NM
        dlJMG/FwGdPCu6WSH2sddH7f9ameABioePNPjDQorg==
X-Google-Smtp-Source: AJdET5cihoir0iVH8+cz9ioa5GhqOhFchHx1OTU6U9QR6GJKZljH+Fzfoa+EJYLIs4/FJAzPlIre/xqz+Z/WemA/gAw=
X-Received: by 2002:a05:660c:206:: with SMTP id y6mr5911841itj.157.1542020762377;
 Mon, 12 Nov 2018 03:06:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:38d:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 03:05:21 -0800 (PST)
In-Reply-To: <1540433556-12261-1-git-send-email-zhang.chunyan@linaro.org>
References: <1540368084-32202-1-git-send-email-zhang.chunyan@linaro.org> <1540433556-12261-1-git-send-email-zhang.chunyan@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Nov 2018 12:05:21 +0100
Message-ID: <CAPDyKFppgnbiGfYibi93bDMfyrC0ry=G-TcgAZ+QzXZXOAjPCQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Convert sdhci_allocate_bounce_buffer() to
 return void
To:     Chunyan Zhang <zhang.chunyan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 October 2018 at 04:12, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> The function sdhci_allocate_bounce_buffer() always return zero at
> present, so there's no need to have a return value, that will also make
> error path easier.
>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Applied for next, thanks!

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
