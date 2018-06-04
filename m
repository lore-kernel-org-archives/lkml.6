Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753793AbeFDOLR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:11:17 -0400
Received: from ozlabs.org ([203.11.71.1]:58977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753770AbeFDOLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:11:14 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1c38976334c0efce1b285369a6037f205e196299
In-Reply-To: <20180528060834.72DE86F377@po14934vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/Makefile: set -mcpu=860 flag for the 8xx
Message-Id: <40zxgL3MdHz9s7X@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:07 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 06:08:34 UTC, Christophe Leroy wrote:
> When compiled with GCC 8.1, vmlinux is significantly bigger than
> with GCC 4.8.
> 
> When looking at the generated code with objdump, we notice that
> all functions and loops when a 16 bytes alignment. This significantly
> increases the size of the kernel. It is pointless and even
> counterproductive as on the 8xx 'nop' also consumes one clock cycle.
> 
> Size of vmlinux with GCC 4.8:
>    text	   data	    bss	    dec	    hex	filename
> 5801948	1626076	 457796	7885820	 7853fc	vmlinux
> 
> Size of vmlinux with GCC 8.1:
>    text	   data	    bss	    dec	    hex	filename
> 6764592	1630652	 456476	8851720	 871108	vmlinux
> 
> Size of vmlinux with GCC 8.1 and this patch:
>    text	   data	    bss	    dec	    hex	filename
> 6331544	1631756	 456476	8419776	 8079c0	vmlinux
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1c38976334c0efce1b285369a6037f

cheers
