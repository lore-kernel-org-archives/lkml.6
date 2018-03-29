Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeC2QIE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:08:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12440 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeC2QID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:08:03 -0400
Date: Thu, 29 Mar 2018 18:07:43 +0200
Message-ID: <20180329180743.Horde.0e_zt3S4Pqcv7Z0dJwOgOg9@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 01/19] powerpc/powermac: Mark variable x as unused
References: <20180322202007.23088-2-malat@debian.org>
 <20180328192717.656-1-malat@debian.org>
In-Reply-To: <20180328192717.656-1-malat@debian.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> a écrit :

> Since the value of x is never intended to be read, declare it with gcc
> attribute as unused. Fix warning treated as error with W=1:
>
>   arch/powerpc/platforms/powermac/bootx_init.c:471:21: error:  
> variable ‘x’ set but not used [-Werror=unused-but-set-variable]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: move x variable within its local scope
>
>  arch/powerpc/platforms/powermac/bootx_init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powermac/bootx_init.c  
> b/arch/powerpc/platforms/powermac/bootx_init.c
> index c3c9bbb3573a..d44e8571c1ec 100644
> --- a/arch/powerpc/platforms/powermac/bootx_init.c
> +++ b/arch/powerpc/platforms/powermac/bootx_init.c
> @@ -468,7 +468,7 @@ void __init bootx_init(unsigned long r3,  
> unsigned long r4)
>  	boot_infos_t *bi = (boot_infos_t *) r4;
>  	unsigned long hdr;
>  	unsigned long space;
> -	unsigned long ptr, x;
> +	unsigned long ptr;
>  	char *model;
>  	unsigned long offset = reloc_offset();
>
> @@ -562,6 +562,7 @@ void __init bootx_init(unsigned long r3,  
> unsigned long r4)
>  	 * MMU switched OFF, so this should not be useful anymore.
>  	 */
>  	if (bi->version < 4) {
> +		unsigned long x __maybe_unused;
>  		bootx_printf("Touching pages...\n");

Stylewise, there should be an empty line after your declaration.

But I believe you should remove that ugly loop and replace it by a  
call to fault_in_pages_readable()

Christophe
>
>  		/*
> --
> 2.11.0
