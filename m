Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDHUeh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:34:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752394AbeDHUeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:34:36 -0400
Subject: Re: [PATCH] powerpc/mm/radix: add missing braces for single statement
 block
To: Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20180408194424.8719-1-malat@debian.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a21ced59-8cf6-b8e0-2305-fb9d040dfc5c@infradead.org>
Date: Sun, 8 Apr 2018 13:34:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180408194424.8719-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2018 12:44 PM, Mathieu Malaterre wrote:
> In commit 7a22d6321c3d ("powerpc/mm/radix: Update command line parsing for
> disable_radix") an `if` statement was added for a possible empty body
> (prom_debug).
> 
> Fix the following warning, treated as error with W=1:
> 
>   arch/powerpc/kernel/prom_init.c:656:46: error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/powerpc/kernel/prom_init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 5ae153b97d0a..f0e802495530 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -652,8 +652,9 @@ static void __init early_cmdline_parse(void)
>  		} else
>  			prom_radix_disable = true;
>  	}
> -	if (prom_radix_disable)
> +	if (prom_radix_disable) {
>  		prom_debug("Radix disabled from cmdline\n");

Looks like the macro for #prom_debug() should be fixed instead.

> +	}
>  }
>  
>  #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
> 


-- 
~Randy
