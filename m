Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeENJ5g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:57:36 -0400
Received: from foss.arm.com ([217.140.101.70]:38644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750917AbeENJ5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:57:34 -0400
Date: Mon, 14 May 2018 10:57:30 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/18] arm64: consistently use unsigned long for thread
 flags
Message-ID: <20180514095722.GW7753@e103592.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-2-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:46:23AM +0100, Mark Rutland wrote:
> In do_notify_resume, we manipulate thread_flags as a 32-bit unsigned
> int, whereas thread_info::flags is a 64-bit unsigned long, and elsewhere
> (e.g. in the entry assembly) we manipulate the flags as a 64-bit
> quantity.
> 
> For consistency, and to avoid problems if we end up with more than 32
> flags, let's make do_notify_resume take the flags as a 64-bit unsigned
> long.

Looks sensible.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 154b7d30145d..8e624fec4707 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -896,7 +896,7 @@ static void do_signal(struct pt_regs *regs)
>  }
>  
>  asmlinkage void do_notify_resume(struct pt_regs *regs,
> -				 unsigned int thread_flags)
> +				 unsigned long thread_flags)
>  {
>  	/*
>  	 * The assembly code enters us with IRQs off, but it hasn't
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
