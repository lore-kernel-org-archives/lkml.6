Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbeBWIBF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:01:05 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12071 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbeBWIBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:01:04 -0500
Subject: Re: [PATCH 0/5] PPC32/ioremap: Use memblock API to check for RAM
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <ca471c17-d2a7-e8e6-2d5a-a5a534e7e6d9@c-s.fr>
Date: Fri, 23 Feb 2018 09:01:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222121516.23415-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/02/2018 à 13:15, Jonathan Neuschäfer a écrit :
> This patchset solves the same problem as my previous one[1] but follows
> a rather different approach. Instead of implementing DISCONTIGMEM for
> PowerPC32, I simply switched the "is this RAM" check in __ioremap_caller
> to the existing page_is_ram function, and unified page_is_ram to search
> memblock.memory on PPC64 and PPC32.
> 
> The intended result is, as before, that my Wii can allocate the MMIO
> range of its GPIO controller, which was previously not possible, because
> the reserved memory hack (__allow_ioremap_reserved) didn't affect the
> API in kernel/resource.c.
> 
> Thanks to Christophe Leroy for reviewing the previous patchset.

I tested your new serie, it doesn't break my 8xx so it is OK for me.

Christophe

> 
> [1]: https://www.spinics.net/lists/kernel/msg2726786.html
> 
> Jonathan Neuschäfer (5):
>    powerpc: mm: Simplify page_is_ram by using memblock_is_memory
>    powerpc: mm: Use memblock API for PPC32 page_is_ram
>    powerpc/mm/32: Use page_is_ram to check for RAM
>    powerpc: wii: Don't rely on the reserved memory hack
>    powerpc/mm/32: Remove the reserved memory hack
> 
>   arch/powerpc/mm/init_32.c                |  5 -----
>   arch/powerpc/mm/mem.c                    | 12 +-----------
>   arch/powerpc/mm/mmu_decl.h               |  1 -
>   arch/powerpc/mm/pgtable_32.c             |  4 +---
>   arch/powerpc/platforms/embedded6xx/wii.c | 14 +-------------
>   5 files changed, 3 insertions(+), 33 deletions(-)
> 
