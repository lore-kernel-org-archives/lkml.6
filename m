Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbeBPUoO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:44:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:48945 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbeBPUoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:44:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="35368538"
Message-ID: <1518813847.22495.370.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/7] lib/test_printf: Mark big constant with ULL
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Tobin C. Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 16 Feb 2018 22:44:07 +0200
In-Reply-To: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
References: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-16 at 21:28 +0200, Andy Shevchenko wrote:
> Sparse complains that constant is so bit for unsigned long on 64-bit
> architecture.
> 
> lib/test_printf.c:217:54: warning: constant 0xffff0123456789ab is so
> big it is unsigned long
> lib/test_printf.c:246:54: warning: constant 0xffff0123456789ab is so
> big it is unsigned long
> 
> To satisfy everyone, mark the constant with ULL.
> 

Please, drop entire series.

I found more candidates inside the file which can utilize changes.
Besides that, there is a typo in commit message of patch 3.



> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/test_printf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 71ebfa43ad05..309cf8d7e6d4 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -204,7 +204,7 @@ test_string(void)
>  #if BITS_PER_LONG == 64
>  
>  #define PTR_WIDTH 16
> -#define PTR ((void *)0xffff0123456789ab)
> +#define PTR ((void *)0xffff0123456789abULL)
>  #define PTR_STR "ffff0123456789ab"
>  #define ZEROS "00000000"	/* hex 32 zero bits */
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
