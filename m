Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30681C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB0D20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSIaMY0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfBENdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:33:50 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42550 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBENdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:33:49 -0500
Received: by mail-vs1-f65.google.com with SMTP id b74so2111277vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 05:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prvhephNXIydJvkflBaOKno9ZKAnc8T5wtxtA/w0psM=;
        b=CSIaMY0vIhc86nAsbhL2w6X4PmK0zYrErL9DXxsAN2vvWugY+VHtUm65/KTK9Uptmu
         LvBBpvs6OiiJdJEtGzKpp5hIOln9bh9KPMuHM+K91+BjJVzlzUB2MWIv2HTQBIJmLNnr
         8A0+rlnp1TLqBi3Bb7m2DDjXymQ6tmrwWr259bp805MmYY1rhtJNpCmDCiZwoFjNn0f1
         WCB7h3juUnNlLxA7RqPc5cdKh+9OceusPUi7RDNeRZfTrkn1L/621gKdnycm0gu3zJVV
         KKqa2DqOz1z1sksycc80XalfPfqwbE6kcqwaKxW2TwHSoC+4x6AXZ8GLp4r18teK2EKo
         +Xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prvhephNXIydJvkflBaOKno9ZKAnc8T5wtxtA/w0psM=;
        b=Cv+BrUsTDVCA7ZJxdeTIQ15mHi9gZUp4To5aHPPBsdc0s17hth5juPE8WNtvylYIYt
         BvvmP4hFiWs73r+mLtdESqcghKUhMmLnDJ/w4/uEV963kjMJEL/M+qrYKD2mewWhsdw0
         YemLFJD1C5+qqjb9yjImrURD6bSvvJM8noNYyiLLucjmirL7EVfPEb61aP4N8uWak9vt
         x/ea2AuLP4xxdgsfLSudC991Go0qdDUB/Ax/YOfzTNF2n6QSkHrR2iO5d10eVymBdtsl
         i+3zEHeny9lIFk1ng+n4QK/IeCvZbV6pTfo37Cy4vv3beYHTOK8QTIXDNUCcGnI1rJXF
         MVqA==
X-Gm-Message-State: AHQUAuav1fpzJXE3glwpEF/r6SmzaVlHnY8aEdQd2VySSOlbMwFDxCDP
        9Vnw53awHUi+RkkKAMcJplfgDTEGWI1W0gLr52NsCQ==
X-Google-Smtp-Source: AHgI3IbXHMeZ8TUF0z8Z/jZxqW9DQWvvyXBRGcg/ZZlQpWkg0An2GxuNv272J+er1iCyww15Krb2nPKpPnQidRHBCqA=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr575422vsi.191.1549373628614;
 Tue, 05 Feb 2019 05:33:48 -0800 (PST)
MIME-Version: 1.0
References: <1549183828-17316-1-git-send-email-avri.altman@wdc.com> <1549183828-17316-2-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1549183828-17316-2-git-send-email-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 Feb 2019 14:33:12 +0100
Message-ID: <CAPDyKFqO0RX-Nz+WDo6VA5Sqh-npJKkqfHN9cpH6gxMPo1tJPw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: core: Calculate the discard arg only once
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

On Sun, 3 Feb 2019 at 09:51, Avri Altman <avri.altman@wdc.com> wrote:
>
> The discard arg is a read-only ext_csd parameter -
> set it once on card init.

I like the idea here. There is really no point checking this for every
corresponding request, nice!

However, the "discard arg" isn't specific to eMMC, as it's also used
for SD cards. So, the change log is a bit miss-leading, I think. Can
you please clarify this.

>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 12 +++---------
>  drivers/mmc/core/mmc.c   |  8 ++++++++
>  include/linux/mmc/card.h |  2 ++
>  3 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b08fb91..3502f2c 100644
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
> +                                        card->discard_arg == MMC_TRIM_ARG ?
>                                          INAND_CMD38_ARG_TRIM :
>                                          INAND_CMD38_ARG_ERASE,
>                                          0);
>                 }
>                 if (!err)
> -                       err = mmc_erase(card, from, nr, arg);
> +                       err = mmc_erase(card, from, nr, card->discard_arg);
>         } while (err == -EIO && !mmc_blk_reset(md, card->host, type));
>         if (err)
>                 status = BLK_STS_IOERR;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index da892a5..120739c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1743,6 +1743,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                         card->ext_csd.power_off_notification = EXT_CSD_POWER_ON;
>         }
>
> +       /* set discard_arg */
> +       if (mmc_can_discard(card))
> +               card->discard_arg = MMC_DISCARD_ARG;
> +       else if (mmc_can_trim(card))
> +               card->discard_arg = MMC_TRIM_ARG;
> +       else
> +               card->discard_arg = MMC_ERASE_ARG;

You are assigning card->discard_arg only for (e)MMC, while I think you
should do that also for SD.

I guess it practice it doesn't matter, because MMC_ERASE_ARG is zero.
Although, I would prefer to keep the code consistent, so I think you
should assign card->discard_arg for for SD cards as well.

> +
>         /*
>          * Select timing interface
>          */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index de73778..447648b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -308,6 +308,8 @@ struct mmc_card {
>         unsigned int    nr_parts;
>
>         unsigned int            bouncesz;       /* Bounce buffer size */
> +
> +       unsigned int            discard_arg;    /* discard args */

Please move this a couple of lines above, close to the other "erase"
related variables.

You may even consider to rename the arg to "erase_arg", but I have no
strong opinion changing to that.

>  };
>
>  static inline bool mmc_large_sector(struct mmc_card *card)
> --
> 1.9.1
>

Kind regards
Uffe
