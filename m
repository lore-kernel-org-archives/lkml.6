Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932977AbeE2Kf4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:35:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54147 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeE2Kfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:35:53 -0400
X-Google-Smtp-Source: ADUXVKKESKnNHMRa/obenFxzwfc5UzyhJng8A80sqVlmx4lizonyX9hNh6Q9ps4CqgXsDeCVKmkTMvxGP51APpb0Oa4=
MIME-Version: 1.0
In-Reply-To: <20180529103057.1378025-1-arnd@arndb.de>
References: <20180529103057.1378025-1-arnd@arndb.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 29 May 2018 12:35:52 +0200
Message-ID: <CAPDyKFo2b9biWkmJ1tM4QU1RbGvF6SOOpTxpYFuUchkhZKXnug@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxmmc: include linux/highmem.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Lin <shawn.lin@rock-chips.com>, Allen <allen.lkml@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 May 2018 at 12:30, Arnd Bergmann <arnd@arndb.de> wrote:
> The highmem conversion caused a build error in some configurations:
>
> drivers/mmc/host/mxcmmc.c: In function 'mxcmci_transfer_data':
> drivers/mmc/host/mxcmmc.c:622:10: error: implicit declaration of function 'kmap_atomic'; did you mean 'in_atomic'? [-Werror=implicit-function-declaration]
>
> This includes the correct header file.
>
> Fixes: b189e7589f6d ("mmc: mxcmmc: handle highmem pages")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mxcmmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 150fbdba777d..d62bf7efce13 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -21,6 +21,7 @@
>  #include <linux/init.h>
>  #include <linux/ioport.h>
>  #include <linux/platform_device.h>
> +#include <linux/highmem.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/blkdev.h>
> --
> 2.9.0
>
