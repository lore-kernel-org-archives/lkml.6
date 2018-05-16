Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbeEPM4f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:56:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752563AbeEPMup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:50:45 -0400
Date: Wed, 16 May 2018 14:50:42 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH V1 00/19] perf tools and x86 PTI entry trampolines
Message-ID: <20180516125042.GA507@krava>
References: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 03:43:14PM +0300, Adrian Hunter wrote:

SNIP

> 
>  # Overhead  Command    Shared Object     Symbol
>  # ........  .........  ................  ..................................
>  #
>     41.91%  uname_x_n  [kernel.vmlinux]  [k] syscall_return_via_sysret
>     24.70%  uname_x_n  [kernel.vmlinux]  [k] entry_SYSCALL_64_trampoline
>     19.22%  uname_x_n  [kernel.vmlinux]  [k] copy_user_enhanced_fast_string
>      4.09%  uname_x_n  libc-2.19.so      [.] __GI___uname
>      3.08%  uname_x_n  [kernel.vmlinux]  [k] do_syscall_64
>      2.32%  uname_x_n  [kernel.vmlinux]  [k] down_read
>      2.27%  uname_x_n  ld-2.19.so        [.] _dl_start
>      1.25%  uname_x_n  [kernel.vmlinux]  [k] up_read
>      0.99%  uname_x_n  [kernel.vmlinux]  [k] entry_SYSCALL_64
>      0.16%  uname_x_n  [kernel.vmlinux]  [k] flush_signal_handlers
>      0.01%  perf       [kernel.vmlinux]  [k] native_sched_clock
>      0.00%  perf       [kernel.vmlinux]  [k] native_write_msr
> 
> 
> Adrian Hunter (17):
>       kallsyms: Simplify update_iter_mod()
>       x86: kcore: Give entry trampolines all the same offset in kcore
>       perf tools: Use the _stest symbol to identify the kernel map when loading kcore
>       perf tools: Fix kernel_start for PTI on x86
>       perf tools: Workaround missing maps for x86 PTI entry trampolines
>       perf tools: Fix map_groups__split_kallsyms() for entry trampoline symbols
>       perf tools: Allow for extra kernel maps
>       perf tools: Create maps for x86 PTI entry trampolines
>       perf tools: Synthesize and process mmap events for x86 PTI entry trampolines

the perf tools patches look good to me:

    Acked-and-tested-by: Jiri Olsa <jolsa@kernel.org>

jirka

>       perf buildid-cache: kcore_copy: Keep phdr data in a list
>       perf buildid-cache: kcore_copy: Keep a count of phdrs
>       perf buildid-cache: kcore_copy: Calculate offset from phnum
>       perf buildid-cache: kcore_copy: Layout sections
>       perf buildid-cache: kcore_copy: Iterate phdrs
>       perf buildid-cache: kcore_copy: Get rid of kernel_map
>       perf buildid-cache: kcore_copy: Copy x86 PTI entry trampoline sections
>       perf buildid-cache: kcore_copy: Amend the offset of sections that remap kernel text
