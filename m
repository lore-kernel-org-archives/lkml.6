Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265CFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93FC2080F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIoFzl4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfBFPPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:15:23 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38098 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfBFPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:15:20 -0500
Received: by mail-ua1-f65.google.com with SMTP id p9so2373458uaa.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfjVTRMgavDZaXCbQcOCeYyPTeYES8g6zEmWSHHyiy8=;
        b=jIoFzl4gbIH0uCg4501Q22gUEwS6EeFE5UTGbaCKca68crXlqZqe9G7eEuWkrwyPSW
         OOUptiLMdZQkYoBhndBiN4N/6M+AheHqIhekkAF+DuNvxt17543CwUwq5L7cCrqZcdk7
         Aq0Uln96+6ZsILgQnUEgv5ZvEs+uRJjOWpQm8rv5nrlDKkHwMkzmj8f08etcN/c9oF3r
         xB36rwQBfeeOIjpH3nCRaJe92UswjAdp4wiqRTY6+rmonkfchW+d1sOv3w0cPqtjMrm8
         KxZHEog9gTi+R4qkwVxSeAbHOwZWeMRpgnQSNdVoM0ceWik1Qjx4MqTEJQMIle22e5JO
         ACbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfjVTRMgavDZaXCbQcOCeYyPTeYES8g6zEmWSHHyiy8=;
        b=eKj/f8F/DNErW5gjTAHDtwPPOtMr2RLmWvx1zUYiO0kAoP39F1FAdvXlr5as+ZwTHw
         HREif7DYl+9t7aem+Nsqgs+qqhHVfVvYJIMDn8znjSs3Y4nt6uUps7dFnCbg4MZBV3iN
         ILK1hrRZbxjBTryGl3VBgUavT3KS/gr4alAUXyKX3MzPuqpuf7k6ZMrWSjLec7oxjoeZ
         5jT9qFkbU0EuwyqR0Dfqq0DIxpLwYc3xBPSSnNEanC/nGCJXa9gKI+UOZ48fJMBfNTdW
         3Jn2GUpnbdtM9ir1YfzlbZYx1I0d+5KyjJReC55YcyGBNLOqiPn4Z2T6Y1w9Mqt5HGDY
         hERQ==
X-Gm-Message-State: AHQUAuYT1BBmwzQKOUldwZe/HhKZzabo6KMjY7AqTlXiQ4UgaWfAoFMD
        FmEzRXO1dG/V1vmIf+/AXGDdA75pYgJozzdxS8YDtA==
X-Google-Smtp-Source: AHgI3IaItSbgQz2BYa5Z+3C0CvZdj3X33EelQrHWVm6BpqVjOzMUbQ3fSnuC8CMJ3U4XqyGCvGMX0QKteE1YAb+Ondg=
X-Received: by 2002:ab0:526:: with SMTP id 35mr4154738uax.25.1549466119119;
 Wed, 06 Feb 2019 07:15:19 -0800 (PST)
MIME-Version: 1.0
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com> <1549452487-17193-4-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1549452487-17193-4-git-send-email-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Feb 2019 16:14:42 +0100
Message-ID: <CAPDyKFqrS+f4K-t6i0ZxAivtATddYepXLguX5svrQub-zH2JEw@mail.gmail.com>
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
>
> Actually, there is no need to check for the spec version like we are
> doing, as it is assured that the reserved bits in earlier versions are
> null. Do that anyway to document the spec version that introduce it.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Deferring this a bit, need some more time to review.

Kind regards
Uffe


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
>         if (mmc_card_sd(card) && arg != SD_ERASE_ARG)
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
