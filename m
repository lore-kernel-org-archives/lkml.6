Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeEBMuR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751076AbeEBMuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:50:16 -0400
Date: Wed, 2 May 2018 08:50:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] tracing: Remove PPC32 wart from config TRACING_SUPPORT
Message-ID: <20180502085013.2571183b@gandalf.local.home>
In-Reply-To: <20180502112948.1747-1-mpe@ellerman.id.au>
References: <20180502112948.1747-1-mpe@ellerman.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 May 2018 21:29:48 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> config TRACING_SUPPORT has an exception for PPC32, because PPC32
> didn't have irqflags tracing support.
> 
> But that hasn't been true since commit 5d38902c4838 ("powerpc: Add
> irqtrace support for 32-bit powerpc") (Jun 2009).
> 
> So remove the exception for PPC32 and the comment.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Feel free to take this patch through the PPC tree.

Thanks!

-- Steve

> ---
>  kernel/trace/Kconfig | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index c4f0f2e4126e..dd6c0a2ad969 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -110,11 +110,7 @@ config GENERIC_TRACER
>  #
>  config TRACING_SUPPORT
>  	bool
> -	# PPC32 has no irqflags tracing support, but it can use most of the
> -	# tracers anyway, they were tested to build and work. Note that new
> -	# exceptions to this list aren't welcomed, better implement the
> -	# irqflags tracing for your architecture.
> -	depends on TRACE_IRQFLAGS_SUPPORT || PPC32
> +	depends on TRACE_IRQFLAGS_SUPPORT
>  	depends on STACKTRACE_SUPPORT
>  	default y
>  
