Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeEOTDb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 15:03:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeEOTD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 15:03:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3350C60558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date: Tue, 15 May 2018 14:03:26 -0500
From: Richard Kuo <rkuo@codeaurora.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hexagon: fix printk format warning in setup.c
Message-ID: <20180515190326.GC22553@codeaurora.org>
References: <adce8db5-4b01-dc10-7fbb-6a64e0787eb5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adce8db5-4b01-dc10-7fbb-6a64e0787eb5@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 06:48:49PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix printk format warning in hexagon/kernel/setup.c:
> 
> ../arch/hexagon/kernel/setup.c: In function 'setup_arch':
> ../arch/hexagon/kernel/setup.c:69:2: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Wformat]
> 
> where:
> extern unsigned long	__phys_offset;
> #define PHYS_OFFSET	__phys_offset
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> ---
>  arch/hexagon/kernel/setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20180510.orig/arch/hexagon/kernel/setup.c
> +++ linux-next-20180510/arch/hexagon/kernel/setup.c
> @@ -66,7 +66,7 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	__vmsetvec(_K_VM_event_vector);
>  
> -	printk(KERN_INFO "PHYS_OFFSET=0x%08x\n", PHYS_OFFSET);
> +	printk(KERN_INFO "PHYS_OFFSET=0x%08lx\n", PHYS_OFFSET);
>  
>  	/*
>  	 * Simulator has a few differences from the hardware.
> 
> 


Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
