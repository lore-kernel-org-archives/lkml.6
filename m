Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754878AbeEHJGO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:06:14 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55622 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754525AbeEHJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:06:12 -0400
X-Google-Smtp-Source: AB8JxZrVqJOec4jh9srpmQ6Te+2kQcjpcFC8BLJNpz2CXIzFdJnew7Qk4NskX1vqvnfcBsTxv0WMZ7+0fZWo8pH1CXM=
MIME-Version: 1.0
In-Reply-To: <20180504092053.GA20277@orion>
References: <20180504092053.GA20277@orion>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 May 2018 11:06:11 +0200
Message-ID: <CAPDyKFrb0eJVUQ1Nq7d9GwHzw6zzm8GpgYiexsQN-7KwdY5RKw@mail.gmail.com>
Subject: Re: [PATCH] mmc: tegra: remove redundant return statement
To: Aapo Vienamo <aapo.vienamo@iki.fi>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 May 2018 at 11:20, Aapo Vienamo <aapo.vienamo@iki.fi> wrote:
> A redundant return statement is removed from
> tegra_sdhci_set_uhs_signaling(). The function returns void and the
> return does not affect the control flow of the function.
>
> Signed-off-by: Aapo Vienamo <aapo.vienamo@iki.fi>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index b877c13184c2..970d38f68939 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -231,7 +231,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>         if (timing == MMC_TIMING_UHS_DDR50)
>                 tegra_host->ddr_signaling = true;
>
> -       return sdhci_set_uhs_signaling(host, timing);
> +       sdhci_set_uhs_signaling(host, timing);
>  }
>
>  static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
> --
> 2.16.1
>
