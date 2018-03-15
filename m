Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbeCOSeN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:34:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751492AbeCOSeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:34:12 -0400
Date: Thu, 15 Mar 2018 13:34:11 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] x86/dumpstack: Add a show_ip() function
Message-ID: <20180315183411.bqq6fd5pqf4xyo5s@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-8-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315154448.16222-8-bp@alien8.de>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 04:44:46PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Which shows the Istruction Pointer along with the insn bytes around it.
> Use it whenever we print rIP.

s/Istruction/Instruction/

> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 5224c6099184..3d1f1226b972 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -76,9 +76,7 @@ void __show_regs(struct pt_regs *regs, int all)
>  		savesegment(gs, gs);
>  	}
>  
> -	printk(KERN_DEFAULT "EIP: %pS\n", (void *)regs->ip);
> -	printk(KERN_DEFAULT "EFLAGS: %08lx CPU: %d\n", regs->flags,
> -		raw_smp_processor_id());
> +	show_ip(regs, KERN_DEFAULT);

Did you intentionally remove the printing of EFLAGS?

-- 
Josh
