Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E88C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892692080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3e+ix8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbfBFPPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:15:15 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44538 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfBFPPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:15:14 -0500
Received: by mail-vk1-f195.google.com with SMTP id h128so1679684vkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MzxEqdmzgRm9ABhEBl1EkhxWXGkKxySRtdTHSRyP/w=;
        b=v3e+ix8YrTsvrqAuAZILOJPkj5Co6Yll5OcESaHgyzK+qfXiX9iFFtxeQl8zn0cITD
         kqiQ3QdugN/y96XC2a1RYSI+AV3/tcESy8prCJQAQAs5WW8d1XifPddJVsRt2+Lbk8g2
         JvEh8Hy3h7ganJxBzGEhBT6WRZLMhjfKfI28xKNowV7M+QraCEFh76rxOKyZv4mu3Nfq
         dXY8CL6dkN446s2MXIvzIVT33MpTExPBD54SeqtErKcLxOJy359wc0TI+N8BAvXidqXm
         8v+Ij4OUiaqjthus38kx/FFhrVp27L4+GMeS41AQMA79n6RY24uWCeA1k3l0cHVVS5wj
         Rlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MzxEqdmzgRm9ABhEBl1EkhxWXGkKxySRtdTHSRyP/w=;
        b=bfiuxK6Y8U5diQFZlNvQyQmUEjsxq59AHNuo3uh/KSYxMFyRxvTUs6k3YbV27vM0c2
         UQqfNJHBhr/PQZrr+3NgssyJIN2Sp1TkK//DxRjR9ZJhpS5WK2e4Wnxnu5iHEfAzxR51
         dZe6ly22b7skZks/GG6IBVAzHIbNjHI/PXmcBpVzNWjgCSjasdddjjaGUmYHB6lQ9wBG
         D88QXMNw24s5L+Wv1TDxDXsMxl4l7qpfPGHNoEBxNPuRgJ4ya3DQOAF+ZiaRQtGpvUm2
         f2VJoonHwdfI212yeLxFynWsDR/IELqEKXsWobeF+EDX4g6sCj9fmzXmnxzpR5lAYzVE
         kweg==
X-Gm-Message-State: AHQUAubMdPJuyIsgKabX3dT+GBHPlJQ03Z1lG57zbE6k7tk2vMmEJpBV
        rmul2QHIdMqQRGRKhwgfDGjwEIA1X/0/ErEvUGRgxw==
X-Google-Smtp-Source: AHgI3IZN5cMUsQPDogvlsyk6T7N8jywOXgLbkeUnRpITtzHpRFrhBBKjbcsyI/K/agigAgBQsIxyW2K9fbvQmI4hrd4=
X-Received: by 2002:a1f:1c81:: with SMTP id c123mr4371109vkc.52.1549466112711;
 Wed, 06 Feb 2019 07:15:12 -0800 (PST)
MIME-Version: 1.0
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com> <1549452487-17193-2-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1549452487-17193-2-git-send-email-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Feb 2019 16:14:36 +0100
Message-ID: <CAPDyKFq=CW89xOpqE82ZtxajrZ7mi+Z5M-Zcuqkj-pWz+YTv+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: core: Calculate the discard arg only once
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

On Wed, 6 Feb 2019 at 12:28, Avri Altman <avri.altman@wdc.com> wrote:
>
> In MMC, the discard arg is a read-only ext_csd parameter - set it once
> on card init. To be consistent, do that for SD as well even though its
> discard arg is always 0x0.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 12 +++---------
>  drivers/mmc/core/core.c  |  4 ++--
>  drivers/mmc/core/mmc.c   |  8 ++++++++
>  drivers/mmc/core/sd.c    |  2 ++
>  include/linux/mmc/card.h |  1 +
>  include/linux/mmc/sd.h   |  5 +++++
>  6 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b08fb91..131e80e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1124,7 +1124,7 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_blk_data *md = mq->blkdata;
>         struct mmc_card *card = md->queue.card;
> -       unsigned int from, nr, arg;
> +       unsigned int from, nr;
>         int err = 0, type = MMC_BLK_DISCARD;
>         blk_status_t status = BLK_STS_OK;
>
> @@ -1136,24 +1136,18 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>         from = blk_rq_pos(req);
>         nr = blk_rq_sectors(req);
>
> -       if (mmc_can_discard(card))
> -               arg = MMC_DISCARD_ARG;
> -       else if (mmc_can_trim(card))
> -               arg = MMC_TRIM_ARG;
> -       else
> -               arg = MMC_ERASE_ARG;
>         do {
>                 err = 0;
>                 if (card->quirks & MMC_QUIRK_INAND_CMD38) {
>                         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                          INAND_CMD38_ARG_EXT_CSD,
> -                                        arg == MMC_TRIM_ARG ?
> +                                        card->erase_arg == MMC_TRIM_ARG ?
>                                          INAND_CMD38_ARG_TRIM :
>                                          INAND_CMD38_ARG_ERASE,
>                                          0);
>                 }
>                 if (!err)
> -                       err = mmc_erase(card, from, nr, arg);
> +                       err = mmc_erase(card, from, nr, card->erase_arg);
>         } while (err == -EIO && !mmc_blk_reset(md, card->host, type));
>         if (err)
>                 status = BLK_STS_IOERR;
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5bd58b9..de0f1a1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2164,7 +2164,7 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
>   * @card: card to erase
>   * @from: first sector to erase
>   * @nr: number of sectors to erase
> - * @arg: erase command argument (SD supports only %MMC_ERASE_ARG)
> + * @arg: erase command argument (SD supports only %SD_ERASE_ARG)
>   *
>   * Caller must claim host before calling this function.
>   */
> @@ -2181,7 +2181,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>         if (!card->erase_size)
>                 return -EOPNOTSUPP;
>
> -       if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
> +       if (mmc_card_sd(card) && arg != SD_ERASE_ARG)
>                 return -EOPNOTSUPP;
>
>         if ((arg & MMC_SECURE_ARGS) &&
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index da892a5..09c688f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1743,6 +1743,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                         card->ext_csd.power_off_notification = EXT_CSD_POWER_ON;
>         }
>
> +       /* set erase_arg */
> +       if (mmc_can_discard(card))
> +               card->erase_arg = MMC_DISCARD_ARG;
> +       else if (mmc_can_trim(card))
> +               card->erase_arg = MMC_TRIM_ARG;
> +       else
> +               card->erase_arg = MMC_ERASE_ARG;
> +
>         /*
>          * Select timing interface
>          */
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index d0d9f90..bd48b28 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -271,6 +271,8 @@ static int mmc_read_ssr(struct mmc_card *card)
>                 }
>         }
>
> +       card->erase_arg = SD_ERASE_ARG;
> +
>         return 0;
>  }
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index de73778..8f429b6 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -277,6 +277,7 @@ struct mmc_card {
>         unsigned int            erase_shift;    /* if erase unit is power 2 */
>         unsigned int            pref_erase;     /* in sectors */
>         unsigned int            eg_boundary;    /* don't cross erase-group boundaries */
> +       unsigned int            erase_arg;      /* erase / trim / discard */
>         u8                      erased_byte;    /* value of erased bytes */
>
>         u32                     raw_cid[4];     /* raw card CID */
> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> index 1ebcf9b..1a6d10f 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -91,4 +91,9 @@
>  #define SD_SWITCH_ACCESS_DEF   0
>  #define SD_SWITCH_ACCESS_HS    1
>
> +/*
> + * Erase/discard
> + */
> +#define SD_ERASE_ARG                   0x00000000
> +
>  #endif /* LINUX_MMC_SD_H */
> --
> 1.9.1
>
