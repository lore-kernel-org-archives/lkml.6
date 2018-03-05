Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934554AbeCEMNq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:13:46 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:55605 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933518AbeCEMNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:13:43 -0500
X-Google-Smtp-Source: AG47ELuOQ++onHGDMVYhILj+YhZL99YYom6sRHc9/pJYSNGKew2NsTnblk5Kmq4BC3jPb4ER/0K1vnfN6l0G1Gz5F8k=
MIME-Version: 1.0
In-Reply-To: <1520242120-2924-1-git-send-email-harish_kandiga@mentor.com>
References: <1520242120-2924-1-git-send-email-harish_kandiga@mentor.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Mar 2018 13:13:41 +0100
Message-ID: <CAPDyKFqL0tE3fdODbpo5Ci1_e=RbOfxZkTXKQ4XWo4FKHzwMiw@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: Export host capabilities to debugfs.
To: Harish Jenny K N <harish_kandiga@mentor.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, avri.altman@wdc.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <Vladimir_Zapolskiy@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 March 2018 at 10:28, Harish Jenny K N <harish_kandiga@mentor.com> wrote:
> From: Abbas Raza <Abbas_Raza@mentor.com>
>
> This patch exports the host capabilities to debugfs
>
> Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
>
> Changes in v3:
> - Removed typecasting of &host->caps to (u32 *)
>
> Changes in v2:
> - Changed Author
>
>  drivers/mmc/core/debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index c51e0c0..570c9e4 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -289,6 +289,9 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>
>         card->debugfs_root = root;
>
> +       if (!debugfs_create_x32("host_caps", S_IRUSR, root, &host->caps))
> +               goto err;
> +

This isn't the correct place to created the node(s). Please move this
to mmc_add_host_debugfs().

Moreover, I suggest you export both caps and caps2 in the same change,
there is no need to have two changes for that - and finally name the
nodes to "caps" and "caps2".

>         if (!debugfs_create_x32("state", S_IRUSR, root, &card->state))
>                 goto err;
>
> --
> 1.9.1
>

Kind regards
Uffe
