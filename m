Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeBJVUP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 16:20:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:49300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbeBJVUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 16:20:14 -0500
Date: Sat, 10 Feb 2018 22:19:46 +0100
From: Borislav Petkov <bp@suse.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: clobber flags in clear_page()
Message-ID: <20180210211945.GA21424@pd.tnic>
References: <20180113185048.GA23111@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180113185048.GA23111@avx2>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2018 at 09:50:48PM +0300, Alexey Dobriyan wrote:
> All clear_page() implementations use XOR which resets flags.
> 
> Judging by allyesconfig disassembly no code is affected.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  arch/x86/include/asm/page_64.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/include/asm/page_64.h
> +++ b/arch/x86/include/asm/page_64.h
> @@ -47,7 +47,7 @@ static inline void clear_page(void *page)
>  			   clear_page_erms, X86_FEATURE_ERMS,
>  			   "=D" (page),
>  			   "0" (page)
> -			   : "memory", "rax", "rcx");
> +			   : "cc", "memory", "rax", "rcx");
>  }
>  
>  void copy_page(void *to, void *from);

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
