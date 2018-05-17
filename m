Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeEQS1i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:27:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50626 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751965AbeEQS1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:27:35 -0400
Date: Thu, 17 May 2018 20:27:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de, joe@perches.com,
        linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/cleanups] x86: Remove pr_fmt duplicate logging prefixes
Message-ID: <20180517182659.GB27807@pd.tnic>
References: <e7b709a2b040af7faa81b0aa2c3a125aed628a82.1525964383.git.joe@perches.com>
 <tip-1de392f5d5e803663abbd8ed084233f154152bcd@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tip-1de392f5d5e803663abbd8ed084233f154152bcd@git.kernel.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 12:27:45PM -0700, tip-bot for Joe Perches wrote:
> Commit-ID:  1de392f5d5e803663abbd8ed084233f154152bcd
> Gitweb:     https://git.kernel.org/tip/1de392f5d5e803663abbd8ed084233f154152bcd
> Author:     Joe Perches <joe@perches.com>
> AuthorDate: Thu, 10 May 2018 08:45:30 -0700
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Sun, 13 May 2018 21:25:18 +0200
> 
> x86: Remove pr_fmt duplicate logging prefixes
> 
> Converting pr_fmt from a default simple #define to use KBUILD_MODNAME
> added some duplicate prefixes.
> 
> Remove the duplicate prefixes.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Link: https://lkml.kernel.org/r/e7b709a2b040af7faa81b0aa2c3a125aed628a82.1525964383.git.joe@perches.com
> 
> ---
>  arch/x86/events/amd/ibs.c |  2 +-
>  arch/x86/kernel/e820.c    | 32 +++++++++++++++++---------------
>  arch/x86/kernel/hpet.c    |  5 ++---
>  arch/x86/kernel/uprobes.c |  4 ++--
>  arch/x86/mm/numa.c        | 22 +++++++++++-----------
>  5 files changed, 33 insertions(+), 32 deletions(-)

...

> @@ -830,8 +832,8 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
>  	if (last_pfn > max_arch_pfn)
>  		last_pfn = max_arch_pfn;
>  
> -	pr_info("e820: last_pfn = %#lx max_arch_pfn = %#lx\n",
> -			 last_pfn, max_arch_pfn);
> +	pr_info("last_pfn = %#lx max_arch_pfn = %#lx\n",
> +		last_pfn, max_arch_pfn);
>  	return last_pfn;
>  }
>  
> @@ -1005,7 +1007,7 @@ void __init e820__finish_early_params(void)
>  		if (e820__update_table(e820_table) < 0)
>  			early_panic("Invalid user supplied memory map");
>  
> -		pr_info("e820: user-defined physical RAM map:\n");
> +		pr_info("user-defined physical RAM map:\n");
>  		e820__print_table("user");
>  	}
>  }
> @@ -1238,7 +1240,7 @@ void __init e820__memory_setup(void)
>  	memcpy(e820_table_kexec, e820_table, sizeof(*e820_table_kexec));
>  	memcpy(e820_table_firmware, e820_table, sizeof(*e820_table_firmware));
>  
> -	pr_info("e820: BIOS-provided physical RAM map:\n");
> +	pr_info("BIOS-provided physical RAM map:\n");
>  	e820__print_table(who);
>  }

Maybe I'm missing something but this dropped the prefixes now
completely:

-e820: BIOS-provided physical RAM map:
+BIOS-provided physical RAM map:

-e820: last_pfn = 0x43f000 max_arch_pfn = 0x400000000
+last_pfn = 0x43f000 max_arch_pfn = 0x400000000

-e820: last_pfn = 0x9d000 max_arch_pfn = 0x400000000
+last_pfn = 0x9d000 max_arch_pfn = 0x400000000

...

I don't think that was the intention.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
