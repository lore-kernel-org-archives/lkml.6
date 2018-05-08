Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeEHLEg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:04:36 -0400
Received: from foss.arm.com ([217.140.101.70]:56356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752239AbeEHLEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:04:35 -0400
From: Punit Agrawal <punit.agrawal@arm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com, paulmck@linux.vnet.ibm.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: Re: [PATCH v10 02/25] x86/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
        <1523975611-15978-3-git-send-email-ldufour@linux.vnet.ibm.com>
Date: Tue, 08 May 2018 12:04:32 +0100
In-Reply-To: <1523975611-15978-3-git-send-email-ldufour@linux.vnet.ibm.com>
        (Laurent Dufour's message of "Tue, 17 Apr 2018 16:33:08 +0200")
Message-ID: <87sh72jtmn.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:

> Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT which turns on the
> Speculative Page Fault handler when building for 64bit.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d8983df5a2bc..ebdeb48e4a4a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -30,6 +30,7 @@ config X86_64
>  	select MODULES_USE_ELF_RELA
>  	select X86_DEV_DMA_OPS
>  	select ARCH_HAS_SYSCALL_WRAPPER
> +	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT

I'd suggest merging this patch with the one making changes to the
architectural fault handler towards the end of the series.

The Kconfig change is closely tied to the architectural support for SPF
and makes sense to be in a single patch.

If there's a good reason to keep them as separate patches, please move
the architecture Kconfig changes after the patch adding fault handler
changes.

It's better to enable the feature once the core infrastructure is merged
rather than at the beginning of the series to avoid potential bad
fallout from incomplete functionality during bisection.

All the comments here definitely hold for the arm64 patches that you
plan to include with the next update.

Thanks,
Punit

>  
>  #
>  # Arch settings
