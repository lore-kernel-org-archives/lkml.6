Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753710AbeCVKTz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:19:55 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40902 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753248AbeCVKTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:19:46 -0400
X-Google-Smtp-Source: AG47ELtN5F5K6BYgz1XUNHVliYNbphdjD9C9KPI7ZGDtmFH8x3I0eWOJIJwKAwEKdTpftQtKE3r94PyFJJDuR42a8iU=
MIME-Version: 1.0
In-Reply-To: <1520257159-27699-1-git-send-email-harish_kandiga@mentor.com>
References: <1520257159-27699-1-git-send-email-harish_kandiga@mentor.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Mar 2018 11:19:45 +0100
Message-ID: <CAPDyKFotmS3ZxTCaYxuu7c-_KiLfNfz2GQMzmZn8JSOeSbgrbg@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: Export host capabilities to debugfs.
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

On 5 March 2018 at 14:39, Harish Jenny K N <harish_kandiga@mentor.com> wrote:
> From: Abbas Raza <Abbas_Raza@mentor.com>
>
> This patch exports the host capabilities to debugfs
>
> Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> [Harish: Added caps2, moved creation to mmc_add_host_debugfs]
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Changes in v4:
> - Moved the creation of nodes to mmc_add_host_debugfs
> - Exported caps2
> - Renamed host_caps to caps
>
> Changes in v3:
> - Removed typecasting of &host->caps to (u32 *)
>
> Changes in v2:
> - Changed Author
>
>  drivers/mmc/core/debugfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index c51e0c0..d2275c5 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -243,6 +243,12 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>         if (!debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops))
>                 goto err_node;
>
> +       if (!debugfs_create_x32("caps", S_IRUSR, root, &host->caps))
> +               goto err_node;
> +
> +       if (!debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2))
> +               goto err_node;
> +
>         if (!debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
>                         &mmc_clock_fops))
>                 goto err_node;
> --
> 1.9.1
>
