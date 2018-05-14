Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbeENPIC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:08:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752787AbeENPIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:08:01 -0400
Date: Mon, 14 May 2018 10:07:59 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [PATCH v2 6/6] x86/stacktrace: orc, mark it as reliable
Message-ID: <20180514150759.n6xfl4u33vu5stj4@treble>
References: <20180514140653.23678-1-jslaby@suse.cz>
 <20180514140653.23678-6-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180514140653.23678-6-jslaby@suse.cz>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 04:06:53PM +0200, Jiri Slaby wrote:
> In SUSE, we need a reliable stack unwinder for kernel live patching, but
> we do not want to enable frame pointers for performance reasons. So
> after the previous patches to make the ORC reliable, mark ORC as a
> reliable stack unwinder on x86.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 47e7f582f86a..e4199fbcc7f2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -181,7 +181,7 @@ config X86
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_RCU_TABLE_FREE
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> -	select HAVE_RELIABLE_STACKTRACE		if X86_64 && UNWINDER_FRAME_POINTER && STACK_VALIDATION
> +	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
>  	select HAVE_STACK_VALIDATION		if X86_64
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_UNSTABLE_SCHED_CLOCK

Maybe clarify the subject here as well:

  x86/stacktrace: Enable HAVE_RELIABLE_STACKTRACE for the ORC unwinder

-- 
Josh
