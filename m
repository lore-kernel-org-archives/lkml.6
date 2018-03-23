Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755487AbeCWKIL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:08:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11260 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755426AbeCWKII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:08:08 -0400
Subject: Re: [PATCH 04/19] powerpc/kvm: Mark variable tmp unused
To: Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-5-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <db7962e0-88f8-b801-9ccb-1f57b14836d3@c-s.fr>
Date: Fri, 23 Mar 2018 11:08:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322202007.23088-5-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/03/2018 à 21:19, Mathieu Malaterre a écrit :
> Add gcc attribute unused to variable tmp. Fix warning treated as error with
> W=1:
> 
>    arch/powerpc/kernel/kvm.c:675:6: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/kernel/kvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> index 9ad37f827a97..cd3c088283f9 100644
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -672,7 +672,7 @@ static void kvm_use_magic_page(void)
>   {
>   	u32 *p;
>   	u32 *start, *end;
> -	u32 tmp;
> +	u32 tmp __maybe_unused;
>   	u32 features;
>   
>   	/* Tell the host to map the magic page to -4096 on all CPUs */
> 

This fonction should use  fault_in_pages_readable() instead of 
hardcoding the verification.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
