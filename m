Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932442AbeENOi5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:38:57 -0400
Received: from foss.arm.com ([217.140.101.70]:43898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932202AbeENOi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:38:56 -0400
Date: Mon, 14 May 2018 15:38:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Christian Hansen <chansen3@cisco.com>
Cc: catalin.marinas@arm.com, linux@dominikbrodowski.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        xe-linux-external@cisco.com
Subject: Re: [PATCH] arm64: allowing mmap to be traced
Message-ID: <20180514143852.tmbzqij2t35wjtdy@lakrids.cambridge.arm.com>
References: <1526308362-45443-1-git-send-email-chansen3@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308362-45443-1-git-send-email-chansen3@cisco.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 02:32:42PM +0000, Christian Hansen wrote:
> Adding missing macro which is present all other system calls to
> to mmap declaration for ARM.  This allows it to appear as a kernel
> tracing target.
> 
> Signed-off-by: Christian Hansen <chansen3@cisco.com>

FWIW, I sent out a patch doing this earlier today [1], which is
identical modulo some spacing.

Mark.

[1] https://lkml.kernel.org/r/20180514094640.27569-17-mark.rutland@arm.com

> ---
>  arch/arm64/kernel/sys.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> index 72981ba..1ccdbfc 100644
> --- a/arch/arm64/kernel/sys.c
> +++ b/arch/arm64/kernel/sys.c
> @@ -27,9 +27,9 @@
>  #include <linux/syscalls.h>
>  #include <asm/cpufeature.h>
>  
> -asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
> -			 unsigned long prot, unsigned long flags,
> -			 unsigned long fd, off_t off)
> +SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
> +		unsigned long, prot, unsigned long, flags,
> +		unsigned long, fd, off_t, off)
>  {
>  	if (offset_in_page(off) != 0)
>  		return -EINVAL;
> -- 
> 2.5.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
