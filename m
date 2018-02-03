Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBCNVl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 08:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbeBCNVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 08:21:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D6221785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 3 Feb 2018 22:21:28 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Josef Bacik <jbacik@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 3/3] x86: error_inject: make  just_return_func globally
 visible
Message-Id: <20180203222128.c551eb3e12bd38d3341ce3de@kernel.org>
In-Reply-To: <20180202145634.200291-3-arnd@arndb.de>
References: <20180202145434.100626-1-arnd@arndb.de>
        <20180202145634.200291-1-arnd@arndb.de>
        <20180202145634.200291-3-arnd@arndb.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Feb 2018 15:56:19 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> With link time optimizations enabled, I get a link failure:
> 
> ./ccLbOEHX.ltrans19.ltrans.o: In function `override_function_with_return':
> <artificial>:(.text+0x7f3): undefined reference to `just_return_func'
> 
> Marking the symbol .globl makes it work as expected.

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Fixes: 540adea3809f ("error-injection: Separate error-injection from kprobe")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/lib/error-inject.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
> index 7b881d03d0dd..3cdf06128d13 100644
> --- a/arch/x86/lib/error-inject.c
> +++ b/arch/x86/lib/error-inject.c
> @@ -7,6 +7,7 @@ asmlinkage void just_return_func(void);
>  
>  asm(
>  	".type just_return_func, @function\n"
> +	".globl just_return_func\n"
>  	"just_return_func:\n"
>  	"	ret\n"
>  	".size just_return_func, .-just_return_func\n"
> -- 
> 2.9.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
