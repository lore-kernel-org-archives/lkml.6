Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeFAPzR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:55:17 -0400
Received: from ozlabs.org ([203.11.71.1]:49787 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753046AbeFAPzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:55:03 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8af1da40669609707303eecdb857f48a5ba5792d
In-Reply-To: <20180529192001.30200-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/prom: Fix %u/%llx usage since prom_printf() change
Message-Id: <40y86Y5sSdz9rxs@ozlabs.org>
Date: Sat,  2 Jun 2018 01:55:01 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-29 at 19:20:01 UTC, Mathieu Malaterre wrote:
> In commit eae5f709a4d7 ("powerpc: Add __printf verification to
> prom_printf") __printf attribute was added to prom_printf(), which
> means GCC started warning about type/format mismatches. As part of that
> commit we changed some "%lx" formats to "%llx" where the type is
> actually unsigned long long.
> 
> Unfortunately prom_printf() doesn't know how to print "%llx", it just
> prints a literal "lx", eg:
> 
>   reserved memory map:
>     lx - lx
>     lx - lx
> 
> prom_printf() also doesn't know how to print "%u" (only "%lu"), it just
> print a literal "u", eg:
> 
>   Max number of cores passed to firmware: u (NR_CPUS = 2048)
> 
> instead of:
> 
>   Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
> 
> This commit adds support for the missing formatters.
> 
> Fixes: eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8af1da40669609707303eecdb857f4

cheers
