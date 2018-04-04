Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeDDMqY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:46:24 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54449 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeDDMqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:46:22 -0400
X-Google-Smtp-Source: AIpwx4/RQp0QYgmBfoHyG76Lj79d43pfsmgdhu9daktfDdNAkhs0DtNjf+BslFf1wfVNNTs3qjSxXtNcAuUq8oMnEv8=
MIME-Version: 1.0
In-Reply-To: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Apr 2018 14:46:21 +0200
Message-ID: <CAPDyKFrkp0bMPEz==CHO8BzttPQ5sV_S6O_dJOvVkzWnqNV3vw@mail.gmail.com>
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in /proc/partitions
To: Harish Jenny K N <harish_kandiga@mentor.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 February 2018 at 12:33, Harish Jenny K N
<harish_kandiga@mentor.com> wrote:
> From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>
> Since RPMB area is accessible via special ioctl only and boot areas
> are unlikely to contain any partitions, exclude them all from listing
> in /proc/partitions. This will hide them from various user-level
> software (e.g. fdisk), thus avoiding unnecessary access attempts.
>
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>

Queued up for 3.18, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 20135a5..376e47e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2341,7 +2341,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         set_disk_ro(md->disk, md->read_only || default_ro);
>         md->disk->flags = GENHD_FL_EXT_DEVT;
>         if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
> -               md->disk->flags |= GENHD_FL_NO_PART_SCAN;
> +               md->disk->flags |= GENHD_FL_NO_PART_SCAN
> +                                  | GENHD_FL_SUPPRESS_PARTITION_INFO;
>
>         /*
>          * As discussed on lkml, GENHD_FL_REMOVABLE should:
> --
> 1.9.1
>
