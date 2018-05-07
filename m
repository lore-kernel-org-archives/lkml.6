Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeEGPmM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:42:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751923AbeEGPmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:42:10 -0400
Date: Mon, 7 May 2018 10:42:08 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH v3] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20180507154208.jo4s43olrf5a3hw4@treble>
References: <20180305164928.GA17953@lst.de>
 <20180308162616.yhbymodggnfzpskx@treble>
 <20180309174718.2700b29e@blackhole.lan>
 <20180312153536.7avozx64ku4lvd3e@treble>
 <20180504123834.GA16581@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180504123834.GA16581@lst.de>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 02:38:34PM +0200, Torsten Duwe wrote:
> 
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

The subject doesn't actively describe what the patch does, maybe change
it to something like:

  powerpc: Add support for HAVE_RELIABLE_STACKTRACE

or maybe

  powerpc: Add support for livepatch consistency model

Otherwise it looks great to me.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
