Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeFEQGk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:06:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50523 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeFEQGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:06:39 -0400
X-Google-Smtp-Source: ADUXVKIXnOIb/Ylnfl92UdUHGochb+F5qLVuOlmJyeOo1z5o454SWspdaC/aua6vs6lqH+zRQ4pvF1cVOM2M0vXYGVg=
MIME-Version: 1.0
In-Reply-To: <20180605114856.1558554-1-arnd@arndb.de>
References: <20180605114856.1558554-1-arnd@arndb.de>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 5 Jun 2018 10:06:37 -0600
Message-ID: <CANLsYkzoJ5bvsYB8PzLouWoaVPzOkVcY17vVX5dFu6vO+F5zCA@mail.gmail.com>
Subject: Re: [PATCH] coresight: include vmalloc.h for vmap/vunmap
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 June 2018 at 05:48, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly introduced code fails to build in some configurations
> unless we include the right headers:
>
> drivers/hwtracing/coresight/coresight-tmc-etr.c: In function 'tmc_free_table_pages':
> drivers/hwtracing/coresight/coresight-tmc-etr.c:206:3: error: implicit declaration of function 'vunmap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
>
> Fixes: 79613ae8715a ("coresight: Add generic TMC sg table framework")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 6164eed0b5fe..3556d9a849e9 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -8,6 +8,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/iommu.h>
>  #include <linux/slab.h>
> +#include <linux/vmalloc.h>
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
>

Thank you for that - I have picked it up for 4.18-rc1.

Mathieu

> --
> 2.9.0
>
