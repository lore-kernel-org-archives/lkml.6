Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754832AbeDYO5e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:57:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:54048 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753632AbeDYO5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:57:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="45969244"
Message-ID: <1524668248.21176.559.camel@linux.intel.com>
Subject: Re: [PATCH v5 02/11] vsprintf: Add missing const ptr qualifier to
 prt_to_id()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Wed, 25 Apr 2018 17:57:28 +0300
In-Reply-To: <20180425111251.13246-3-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
         <20180425111251.13246-3-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:12 +0200, Petr Mladek wrote:
> vsprintf() must not change any data that parameters point to.
> Let's add the missing const qualifier to ptr_to_id().
> 
> This patch does not change the existing behavior.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/vsprintf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 19fdfe621b40..eef9f725e9ff 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -661,7 +661,8 @@ static int __init initialize_ptr_random(void)
>  early_initcall(initialize_ptr_random);
>  
>  /* Maps a pointer to a 32 bit unique identifier. */
> -static char *ptr_to_id(char *buf, char *end, void *ptr, struct
> printf_spec spec)
> +static char *ptr_to_id(char *buf, char *end, const void *ptr,
> +		       struct printf_spec spec)
>  {
>  	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" :
> "(ptrval)";
>  	unsigned long hashval;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
