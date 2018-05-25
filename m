Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966906AbeEYLoR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:44:17 -0400
Received: from ozlabs.org ([203.11.71.1]:38925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966560AbeEYLli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:38 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: eae5f709a4d738c52b6ab636981755d76349ea9e
In-Reply-To: <20180406201220.31957-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: powerpc: add __printf verification to prom_printf
Message-Id: <40skqN5jpmz9s3x@ozlabs.org>
Date: Fri, 25 May 2018 21:41:35 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-06 at 20:12:19 UTC, Mathieu Malaterre wrote:
> __printf is useful to verify format and arguments. Fix arg mismatch
> reported by gcc, remove the following warnings (with W=1):
> 
>   arch/powerpc/kernel/prom_init.c:1467:31: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:1471:31: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:1504:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:1505:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:1506:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:1507:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:1508:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:1509:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:1975:39: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:1986:27: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:2567:38: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:2567:46: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:2569:38: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/kernel/prom_init.c:2569:46: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘long unsigned int’ [-Werror=format=]
> 
> The patch also include arg mismatch fix for case with #define DEBUG_PROM
> (warning not listed here).
> 
> This patch fix also the following warnings revealed by checkpatch:
> 
>   WARNING: Prefer using '"%s...", __func__' to using 'alloc_up', this function's name, in a string
>   #101: FILE: arch/powerpc/kernel/prom_init.c:1235:
>   + prom_debug("alloc_up(%lx, %lx)\n", size, align);
> 
> and
> 
>   WARNING: Prefer using '"%s...", __func__' to using 'alloc_down', this function's name, in a string
>   #138: FILE: arch/powerpc/kernel/prom_init.c:1278:
>   + prom_debug("alloc_down(%lx, %lx, %s)\n", size, align,
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/eae5f709a4d738c52b6ab636981755

cheers
