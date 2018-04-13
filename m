Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbeDMMnK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 08:43:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754147AbeDMMnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 08:43:06 -0400
Date: Fri, 13 Apr 2018 14:43:02 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2]: perf/x86: expose user space frame-pointer value on a
 sample
Message-ID: <20180413124302.GC28241@krava>
References: <e702f8c9-1bb4-e9fd-cc53-452ed9a82762@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e702f8c9-1bb4-e9fd-cc53-452ed9a82762@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 06:40:04PM +0300, Alexey Budankov wrote:

SNIP

> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v2:
> - lifted restriction on frame pointer architecture so it's value is provided
>   as for i386 as for x86_64 processes
> 
> MAINTAINERS file lacks references to appropriate folks for reviewing 
>   changes at arch/x86/kernel/perf_regs.c so probably it makes sense to 
>   update the file as well in this respect. 
> ---
>  arch/x86/kernel/perf_regs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index e47b2dbbdef3..8d68658eff7f 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -156,7 +156,13 @@ void perf_get_regs_user(struct perf_regs *regs_user,
>  	 * Most system calls don't save these registers, don't report them.
>  	 */
>  	regs_user_copy->bx = -1;
> -	regs_user_copy->bp = -1;
> +	/*
> +	 * Store user space frame-pointer value on sample
> +	 * to facilitate stack unwinding for cases when
> +	 * user space executable code has such support
> +	 * enabled at compile time;
> +	 */
> +	regs_user_copy->bp = user_regs->bp;
>  	regs_user_copy->r12 = -1;
>  	regs_user_copy->r13 = -1;
>  	regs_user_copy->r14 = -1;

looks ok to me

thanks,
jirka
