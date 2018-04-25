Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbeDYNIf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:08:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:57839 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753371AbeDYNIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:08:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="36333097"
Message-ID: <1524661706.21176.550.camel@linux.intel.com>
Subject: Re: [PATCH v5 05/11] vsprintf: Consolidate handling of unknown
 pointer specifiers
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
Date: Wed, 25 Apr 2018 16:08:26 +0300
In-Reply-To: <20180425111251.13246-6-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
         <20180425111251.13246-6-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:12 +0200, Petr Mladek wrote:
> There are few printk formats that make sense only with two or more
> specifiers. Also some specifiers make sense only when a kernel feature
> is enabled.
> 
> The handling of unknown specifiers is strange, inconsistent, and
> even leaking the address. For example, netdev_bits() prints the
> non-hashed pointer value or clock() prints "(null)".
> 
> Using WARN() looks like an overkill for this type of error. pr_warn()
> is not good either. It would by handled via printk_sage buffer and
> it might be hard to match it with the problematic string.
> 
> A reasonable compromise seems to be writing the unknown format
> specifier
> into the original string with a question mark, for example (%pC?).
> It should be self-explaining enough. Note that it is in brackets
> to follow the (null) style.

> +		return valid_string(buf, end, "(%pG?)", spec);

>  
>  	if (!IS_ENABLED(CONFIG_OF))
> -		return valid_string(buf, end, "(!OF)", spec);
> +		return valid_string(buf, end, "(%OF?)", spec);

"(%pOF?)" ?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
