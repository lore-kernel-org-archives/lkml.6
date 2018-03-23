Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbeCWJSb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:18:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49969 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752195AbeCWJS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:18:29 -0400
Subject: Re: [PATCH 01/19] powerpc/powermac: Mark variable x as unused
To: Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-2-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <eaf8b87a-a2f0-03ea-1a27-50931dfd16fb@c-s.fr>
Date: Fri, 23 Mar 2018 10:18:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322202007.23088-2-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/03/2018 à 21:19, Mathieu Malaterre a écrit :
> Since the value of x is never intended to be read, declare it with gcc
> attribute as unused. Fix warning treated as error with W=1:
> 
>    arch/powerpc/platforms/powermac/bootx_init.c:471:21: error: variable ‘x’ set but not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/platforms/powermac/bootx_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
> index c3c9bbb3573a..d3ce55dae78f 100644
> --- a/arch/powerpc/platforms/powermac/bootx_init.c
> +++ b/arch/powerpc/platforms/powermac/bootx_init.c
> @@ -468,7 +468,7 @@ void __init bootx_init(unsigned long r3, unsigned long r4)
>   	boot_infos_t *bi = (boot_infos_t *) r4;
>   	unsigned long hdr;
>   	unsigned long space;
> -	unsigned long ptr, x;
> +	unsigned long ptr, x __maybe_unused;

Why not use fault_in_pages_readable() instead of the hardcoded part that 
uses x ?

If you decide to keep it as is, at least x should be declared inside the 
if (bi->version < 4)

Christophe


>   	char *model;
>   	unsigned long offset = reloc_offset();
>   
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
