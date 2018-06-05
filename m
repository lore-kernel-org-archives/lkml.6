Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeFEPTk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:19:40 -0400
Received: from ozlabs.org ([203.11.71.1]:41381 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751885AbeFEPTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:19:35 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 415520373975d2eba565c256d2cad875ed4e9243
In-Reply-To: <fa51770430e00ac2db1c621365473a0c893d105e.1528179842.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: fix build failure by disabling attribute-alias warning in pci_32
Message-Id: <410b7p2cVbz9s08@ozlabs.org>
Date: Wed,  6 Jun 2018 01:19:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-05 at 06:57:43 UTC, Christophe Leroy wrote:
> Commit 2479bfc9bc600 ("powerpc: Fix build by disabling attribute-alias
> warning for SYSCALL_DEFINEx") forgot arch/powerpc/kernel/pci_32.c
> 
> Latest GCC version emit the following warnings
> 
> As arch/powerpc code is built with -Werror, this breaks build with
> GCC 8.1
> 
> This patch inhibits this warning
> 
> In file included from arch/powerpc/kernel/pci_32.c:14:
> ./include/linux/syscalls.h:233:18: error: 'sys_pciconfig_iobase' alias between functions of incompatible types 'long int(long int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
>   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                   ^~~
> ./include/linux/syscalls.h:222:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/415520373975d2eba565c256d2cad8

cheers
