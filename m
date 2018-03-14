Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeCNJ2p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:28:45 -0400
Received: from ozlabs.org ([103.22.144.67]:53397 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751860AbeCNJ2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:43 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 603b892200e653dd7e86a0e4a315561534d97441
In-Reply-To: <20180307203436.23696-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        open list <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
        <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [v2, 05/21] powerpc: Avoid comparison of unsigned long >= 0 in pfn_valid
Message-Id: <401RHF2pwPz9sCS@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:25 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 20:34:35 UTC, Mathieu Malaterre wrote:
> Rewrite comparison since all values compared are of type `unsigned long`.
> 
> Instead of using unsigned properties and rewriting the original code as:
> (originally suggested by Segher Boessenkool <segher@kernel.crashing.org>)
> 
>   #define pfn_valid(pfn) \
>                (((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))
> 
> Prefer a static inline function to make code as readable as possible.
> 
> Fix a warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/irq.o
> In file included from ./include/linux/bug.h:5:0,
>                  from ./include/linux/cpumask.h:13,
>                  from ./include/linux/smp.h:13,
>                  from ./include/linux/kernel_stat.h:5,
>                  from arch/powerpc/kernel/irq.c:35:
> ./include/linux/dma-mapping.h: In function ‘dma_map_resource’:
> ./arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
>  #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
>                                 ^
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/603b892200e653dd7e86a0e4a31556

cheers
