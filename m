Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753782AbeCFNbX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:31:23 -0500
Received: from ozlabs.org ([103.22.144.67]:47539 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753720AbeCFNbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:31:21 -0500
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 51d42f0f5fd6c74144d19bf6a663521e2ea99765
In-Reply-To: <20180301010249.GA18370@beast>
To: Kees Cook <keescook@chromium.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Keep const vars out of writable .sdata
Message-Id: <3zwd2v0v8nz9shN@ozlabs.org>
Date: Wed,  7 Mar 2018 00:31:17 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-01 at 01:02:49 UTC, Kees Cook wrote:
> From: Segher Boessenkool <segher@kernel.crashing.org>
> 
> Newer gcc will support "-mno-readonly-in-sdata"[1], which makes sure that
> the optimization on PPC32 for variables getting moved into the .sdata
> section will not apply to const variables (which must be in .rodata).
> 
> This was originally noticed in mm/rodata_test.c when rodata_test_data
> was not static:
> 
> c0695034 g     O .data	00000004 rodata_test_data
> 
> After this patch with an updated compiler, this is correctly in .rodata.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82411
> 
> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/51d42f0f5fd6c74144d19bf6a66352

cheers
