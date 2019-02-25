Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA57C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460C620842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHNvN6Fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfBYNnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:43:08 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36671 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfBYNnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:43:06 -0500
Received: by mail-vk1-f196.google.com with SMTP id v131so2100791vkd.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 05:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xP/eylsEw/AILLQ+roIACxEMo/0EuKRwFzs92PrDQ7A=;
        b=JHNvN6FeGigPCYS2A4L80xsIMVHUnLajxkjateAnqeogTJcIYavgAD13yYtFewuaYO
         KG8cWRMqpp4gAj6qGUrwE8ilxRXBVkemZ9UIpcAn9wupexnLKHMvZUopJZ0CCZTmLaaF
         hGHiaTZbBLUByySn7cPmd+PsjX8ZVuOhdbTwskCXtm3b1nTxX4Y5q9UeFwO7pXIyJTeC
         R7lw3E7fCiVKxhks4bPBq3EJcRdiTTb6hT6p3lNLGLdW/BLHm6vauIWBVgb9jsoEaeOo
         +crdckqF0P4iXHtgSEm8FX3V+DBoNVF4AyDwJh9A3Ec7RINFUr15YZrqEqpDc2J19btz
         dWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xP/eylsEw/AILLQ+roIACxEMo/0EuKRwFzs92PrDQ7A=;
        b=FNBMPZE0IIpbvY39B4v3+LWnfDigberqscD/AaKHNdVwgUE0lDkicczAqz/zQ4xr4Z
         TyY50AapwqXfnvsDxX96cnnXCw6JMdwFpwhgpfAZxFwuD4BjdBqe7jROZMa1KWmMHqrC
         vk38eYc6FjnSEaBwYoKhx2dvgD/r6x/X7hJU6t1T/aHE/83n1c3TsOYsUFAt+gZbMWEj
         +qG3GjT8ajhRGMYWMeTCj3KuFsf/RPeQyn3fI8q/ts3xw+8Yz1Q0kBj2nDMGR0EHepv6
         5nTwOPzQ1FAobUPFq2s+jVwDxpog7E2AFsrWBsW6o2q1abQ625Nh9bTGB6lhM/ZQ55Ml
         2kJQ==
X-Gm-Message-State: AHQUAuZy4QdwwBSSbYNGP7FMKbFlftH419r3E5Oard6A7drX+SqZHKbS
        xoE7KuiWyNbaHc6FLtURPdeg3tp6VEcoP8/GihhNfQ==
X-Google-Smtp-Source: AHgI3IZZZpfqvC6oRreQ07/i/428CGL3WnUwv88BxvHyd4V9Cfxr3ZzgEiPlmHnbP6WXcFJgpq21AXW28D+Fj7/pwaI=
X-Received: by 2002:a1f:a5d3:: with SMTP id o202mr9488422vke.40.1551102185582;
 Mon, 25 Feb 2019 05:43:05 -0800 (PST)
MIME-Version: 1.0
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com> <1549452487-17193-4-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1549452487-17193-4-git-send-email-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Feb 2019 14:42:29 +0100
Message-ID: <CAPDyKFobAAGU+=H1y-nGgQXAbRh7ybQxm0zkdBi_DJqSWRApvg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: core: Add discard support to sd
To:     Avri Altman <avri.altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 at 12:29, Avri Altman <avri.altman@wdc.com> wrote:
>
> SD spec v5.1 adds discard support. The flows and commands are similar to
> mmc, so just set the discard arg in CMD38.

So this means that we from now on, if the SD card supports discard, we
are going to use it in favor of erase. This is consistent with how we
treat eMMC, so I think it makes sense. Could you perhaps fold in some
information about this in the changelog, to make this clear on what
this change means.

You may also want to explain a little bit what the difference is from
the SD card storage point of view. Like after an erase, it either 1 or
0s on the media, while after a discard it can be whatever.

>
> Actually, there is no need to check for the spec version like we are
> doing, as it is assured that the reserved bits in earlier versions are
> null. Do that anyway to document the spec version that introduce it.

The check is needed for other purposes, so please just drop this statement.

>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/core.c |  6 +++++-
>  drivers/mmc/core/sd.c   | 10 +++++++++-
>  include/linux/mmc/sd.h  |  1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index de0f1a1..4d62f28 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2164,7 +2164,7 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
>   * @card: card to erase
>   * @from: first sector to erase
>   * @nr: number of sectors to erase
> - * @arg: erase command argument (SD supports only %SD_ERASE_ARG)
> + * @arg: erase command argument
>   *
>   * Caller must claim host before calling this function.
>   */
> @@ -2181,6 +2181,9 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>         if (!card->erase_size)
>                 return -EOPNOTSUPP;
>
> +       if (mmc_card_sd(card) && arg == SD_DISCARD_ARG)
> +               goto skip_arg_testing;
> +

This isn't consistent with the rest of the code path in this function,
please adopt to that.

>         if (mmc_card_sd(card) && arg != SD_ERASE_ARG)

Couldn't you add a check for !SD_DISCARD_ARG here instead?

>                 return -EOPNOTSUPP;
>
> @@ -2200,6 +2203,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>         if (arg == MMC_ERASE_ARG)
>                 nr = mmc_align_erase_size(card, &from, &to, nr);
>
> +skip_arg_testing:
>         if (nr == 0)
>                 return 0;
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c2db94d..2b4fc22 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -231,6 +231,8 @@ static int mmc_read_ssr(struct mmc_card *card)
>  {
>         unsigned int au, es, et, eo;
>         __be32 *raw_ssr;
> +       u32 resp[4] = {};
> +       u8 discard_support;
>         int i;
>
>         if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
> @@ -276,7 +278,13 @@ static int mmc_read_ssr(struct mmc_card *card)
>                 }
>         }
>
> -       card->erase_arg = SD_ERASE_ARG;
> +       /*
> +        * starting SD5.1 discard is supported if DISCARD_SUPPORT (b313) is set
> +        */
> +       resp[3] = card->raw_ssr[6];
> +       discard_support = UNSTUFF_BITS(resp, 313 - 288, 1);

Couldn't you just replace this with "discard_support =
UNSTUFF_BITS(card->raw_ssr, 313 - 256, 1);" ?

> +       card->erase_arg = (card->scr.sda_specx && discard_support) ?
> +                           SD_DISCARD_ARG : SD_ERASE_ARG;
>
>         return 0;
>  }
> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> index 1a6d10f..ec94a5a 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -95,5 +95,6 @@
>   * Erase/discard
>   */
>  #define SD_ERASE_ARG                   0x00000000
> +#define SD_DISCARD_ARG                 0x00000001
>
>  #endif /* LINUX_MMC_SD_H */
> --
> 1.9.1
>

Besides the above changes, there is more important thing I think you
have left out to consider. With discard the operation should be
completed by the card within 250ms, while for erase the timeout
depends on the number of blocks to be erased. I am fine if we address
that on top this change though, just want to point it out so we don't
forget it.

Kind regards
Uffe
