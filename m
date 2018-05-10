Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935634AbeEJOGm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:06:42 -0400
Received: from ozlabs.org ([203.11.71.1]:39933 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935622AbeEJOGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:06:38 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: df78d3f6148092d33a9a24c7a9cfac3d0220b484
In-Reply-To: <20180504123834.GA16581@lst.de>
To: Torsten Duwe <duwe@lst.de>, Josh Poimboeuf <jpoimboe@redhat.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, live-patching@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-Id: <40hZlc4mBGz9s1B@ozlabs.org>
Date: Fri, 11 May 2018 00:06:36 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-04 at 12:38:34 UTC, Torsten Duwe wrote:
> The "Power Architecture 64-Bit ELF V2 ABI" says in section 2.3.2.3:
> 
> [...] There are several rules that must be adhered to in order to ensure
> reliable and consistent call chain backtracing:
> 
> * Before a function calls any other function, it shall establish its
>   own stack frame, whose size shall be a multiple of 16 bytes.
> 
>  – In instances where a function’s prologue creates a stack frame, the
>    back-chain word of the stack frame shall be updated atomically with
>    the value of the stack pointer (r1) when a back chain is implemented.
>    (This must be supported as default by all ELF V2 ABI-compliant
>    environments.)
> [...]
>  – The function shall save the link register that contains its return
>    address in the LR save doubleword of its caller’s stack frame before
>    calling another function.
> 
> To me this sounds like the equivalent of HAVE_RELIABLE_STACKTRACE.
> This patch may be unneccessarily limited to ppc64le, but OTOH the only
> user of this flag so far is livepatching, which is only implemented on
> PPCs with 64-LE, a.k.a. ELF ABI v2.
> 
> Feel free to add other ppc variants, but so far only ppc64le got tested.
> 
> This change also implements save_stack_trace_tsk_reliable() for ppc64le
> that checks for the above conditions, where possible.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/df78d3f6148092d33a9a24c7a9cfac

cheers
