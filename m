Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeCWMUp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:20:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37773 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbeCWMUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:20:43 -0400
Subject: Re: [PATCH 15/19] powerpc: Add missing prototype
To: Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-16-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <bd4be06c-b5f5-2516-1c1d-d2b6d7861090@c-s.fr>
Date: Fri, 23 Mar 2018 13:20:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322202007.23088-16-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/03/2018 à 21:20, Mathieu Malaterre a écrit :
> Add one missing prototype for function rh_dump_blk. Fix warning treated as
> error in W=1:
> 
>    arch/powerpc/lib/rheap.c:740:6: error: no previous prototype for ‘rh_dump_blk’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/include/asm/rheap.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/rheap.h b/arch/powerpc/include/asm/rheap.h
> index 172381769cfc..e75d96de19a0 100644
> --- a/arch/powerpc/include/asm/rheap.h
> +++ b/arch/powerpc/include/asm/rheap.h
> @@ -83,6 +83,9 @@ extern int rh_get_stats(rh_info_t * info, int what, int max_stats,
>   /* Simple dump of remote heap info */
>   extern void rh_dump(rh_info_t * info);
>   
> +/* Simple dump of remote info block */
> +extern void rh_dump_blk(rh_info_t *info, rh_block_t *blk);
> +

Only used in one place, should be static

Christophe

>   /* Set owner of taken block */
>   extern int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner);
>   
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
