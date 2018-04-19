Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754102AbeDSQhd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:37:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753806AbeDSQhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:37:31 -0400
Message-ID: <1524155850.3134.16.camel@redhat.com>
Subject: Re: [PATCH v6 05/16] c6x: Switch to generic free_initrd_mem.
From: Mark Salter <msalter@redhat.com>
To: Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Date: Thu, 19 Apr 2018 12:37:30 -0400
In-Reply-To: <20180401145931.7932-5-shea@shealevy.com>
References: <20180329113207.30674-1-shea@shealevy.com>
         <20180401145931.7932-1-shea@shealevy.com>
         <20180401145931.7932-5-shea@shealevy.com>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-04-01 at 10:59 -0400, Shea Levy wrote:
> The first patch in this series added a weakly-defined generic
> implementation, which is functionally identical to the
> architecture-specific one removed here.
> 
> Series boot-tested on RISC-V (which now uses the generic
> implementation) and x86_64 (which doesn't).
> 
> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>  arch/c6x/mm/init.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
> index 4cc72b0d1c1d..a11cb657182a 100644
> --- a/arch/c6x/mm/init.c
> +++ b/arch/c6x/mm/init.c
> @@ -66,13 +66,6 @@ void __init mem_init(void)
>  	mem_init_print_info(NULL);
>  }
>  
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> -}
> -#endif
> -
>  void __init free_initmem(void)
>  {
>  	free_initmem_default(-1);

Acked-by: Mark Salter <msalter@redhat.com>
