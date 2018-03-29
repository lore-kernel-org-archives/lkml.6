Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeC2Q1P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:27:15 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:33512 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeC2Q1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:27:14 -0400
Date: Thu, 29 Mar 2018 12:26:56 -0400
From: Rich Felker <dalias@libc.org>
To: Shea Levy <shea@shealevy.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v5 15/16] sh: Switch to generic free_initrd_mem.
Message-ID: <20180329162656.GP1436@brightrain.aerifal.cx>
References: <20180328203659.18692-1-shea@shealevy.com>
 <20180329113207.30674-1-shea@shealevy.com>
 <20180329113207.30674-15-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329113207.30674-15-shea@shealevy.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 07:32:06AM -0400, Shea Levy wrote:
> The generic implementation is functionally identical.
> 
> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>  arch/sh/mm/init.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index ce0bbaa7e404..7451459d0725 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -477,13 +477,6 @@ void free_initmem(void)
>  	free_initmem_default(-1);
>  }
>  
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> -}
> -#endif
> -
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>  		bool want_memblock)
> -- 
> 2.16.2

LGTM.

Acked-by: Rich Felker <dalias@libc.org>
