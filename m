Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeFENTn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:19:43 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46376 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeFENTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:19:40 -0400
X-Google-Smtp-Source: ADUXVKJJeX+VTc8JV1D6YHuQORs+wo8CCVMhnpndR0LaRmJY4mAwT/8DG7eTFdVa219LtCSopfhC0/eDPpV7ZJLV114=
MIME-Version: 1.0
In-Reply-To: <1527765086-19873-5-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com> <1527765086-19873-5-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 16:19:39 +0300
Message-ID: <CAHp75Vd1C1X7V4a9PzfFfCFi92M3iaZP_ahsOtGP7V5Y=1LjiQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] cxgb4: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ganesh Goudar <ganeshgr@chelsio.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 2:11 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Ganesh Goudar <ganeshgr@chelsio.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
> v2:
>  - no change from v1.
>
>  drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
> index 9da6f57..bd61610 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
> @@ -782,17 +782,11 @@ static int cudbg_get_mem_region(struct adapter *padap,
>         if (rc)
>                 return rc;
>
> -       for (i = 0; i < ARRAY_SIZE(cudbg_region); i++) {
> -               if (!strcmp(cudbg_region[i], region_name)) {
> -                       found = 1;
> -                       idx = i;
> -                       break;
> -               }
> -       }
> -       if (!found)
> -               return -EINVAL;
> +       rc = match_string(cudbg_region, ARRAY_SIZE(cudbg_region), region_name);
> +       if (rc < 0)
> +               return rc;
>
> -       found = 0;
> +       idx = rc;
>         for (i = 0; i < meminfo->mem_c; i++) {
>                 if (meminfo->mem[i].idx >= ARRAY_SIZE(cudbg_region))
>                         continue; /* Skip holes */
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
