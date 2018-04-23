Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeDWVNt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:13:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932191AbeDWVNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:13:47 -0400
Subject: Re: [PATCH v2] powerpc/mm/radix: use do/while(0) trick for single
 statement block
To: Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20180408194424.8719-1-malat@debian.org>
 <20180423193638.10535-1-malat@debian.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3aa2afca-5d9a-60a2-78d7-9504cf05f78c@infradead.org>
Date: Mon, 23 Apr 2018 14:13:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423193638.10535-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/18 12:36, Mathieu Malaterre wrote:
> In commit 7a22d6321c3d ("powerpc/mm/radix: Update command line parsing for
> disable_radix") an `if` statement was added for a possible empty body
> (prom_debug).
> 
> Fix the following warning, treated as error with W=1:
> 
>   arch/powerpc/kernel/prom_init.c:656:46: error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body]
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v2: update macro directly
> 
>  arch/powerpc/kernel/prom_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 5ae153b97d0a..7edf3aa5bc6d 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -103,7 +103,7 @@ int of_workarounds;
>  #ifdef DEBUG_PROM
>  #define prom_debug(x...)	prom_printf(x)
>  #else
> -#define prom_debug(x...)
> +#define prom_debug(x...)	do { } while (0)
>  #endif
>  
>  
> 


-- 
~Randy
