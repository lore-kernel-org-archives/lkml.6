Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeC2Lu6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:50:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33628 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2Luz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:50:55 -0400
X-Google-Smtp-Source: AIpwx4+oeBrKrEzmdkSZFQpFajorFfplhuZtaN4wjNuBcLThTS05QdL+x5RRyYLyXUN+pHpbtYwxeg==
Date: Thu, 29 Mar 2018 20:50:51 +0900
From: Stafford Horne <shorne@gmail.com>
To: Shea Levy <shea@shealevy.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v5 12/16] openrisc: Switch to generic free_initrd_mem.
Message-ID: <20180329115051.GF2836@lianli.shorne-pla.net>
References: <20180328203659.18692-1-shea@shealevy.com>
 <20180329113207.30674-1-shea@shealevy.com>
 <20180329113207.30674-12-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329113207.30674-12-shea@shealevy.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 07:32:03AM -0400, Shea Levy wrote:
> The generic implementation is functionally identical.
> 
> Signed-off-by: Shea Levy <shea@shealevy.com>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/mm/init.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index 6972d5d6f23f..c1a3dcf9ad40 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -222,13 +222,6 @@ void __init mem_init(void)
>  	return;
>  }
>  
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> -}
> -#endif
> -
>  void free_initmem(void)
>  {
>  	free_initmem_default(-1);
> -- 
> 2.16.2
> 
