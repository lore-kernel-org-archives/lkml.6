Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeC2QJo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:09:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10030 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752553AbeC2QJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:09:41 -0400
Date: Thu, 29 Mar 2018 18:09:22 +0200
Message-ID: <20180329180922.Horde.Mtq3N9paq5gkMn9QcIUlGQ1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 02/19] powerpc/powermac: Mark variable x as unused
References: <20180322202007.23088-3-malat@debian.org>
 <20180328193028.823-1-malat@debian.org>
In-Reply-To: <20180328193028.823-1-malat@debian.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> a écrit :

> Since the value of x is never intended to be read, remove it. Fix warning
> treated as error with W=1:
>
>   arch/powerpc/platforms/powermac/udbg_scc.c:76:9: error: variable  
> ‘x’ set but not used [-Werror=unused-but-set-variable]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> v2: remove x completely
>
>  arch/powerpc/platforms/powermac/udbg_scc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c  
> b/arch/powerpc/platforms/powermac/udbg_scc.c
> index d83135a9830e..8901973ed683 100644
> --- a/arch/powerpc/platforms/powermac/udbg_scc.c
> +++ b/arch/powerpc/platforms/powermac/udbg_scc.c
> @@ -73,7 +73,7 @@ void udbg_scc_init(int force_scc)
>  	struct device_node *stdout = NULL, *escc = NULL, *macio = NULL;
>  	struct device_node *ch, *ch_def = NULL, *ch_a = NULL;
>  	const char *path;
> -	int i, x;
> +	int i;
>
>  	escc = of_find_node_by_name(NULL, "escc");
>  	if (escc == NULL)
> @@ -120,7 +120,7 @@ void udbg_scc_init(int force_scc)
>  	mb();
>
>  	for (i = 20000; i != 0; --i)
> -		x = in_8(sccc);
> +		in_8(sccc);
>  	out_8(sccc, 0x09);		/* reset A or B side */
>  	out_8(sccc, 0xc0);
>
> --
> 2.11.0
