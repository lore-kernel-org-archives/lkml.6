Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeDGObB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 10:31:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:43375 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751869AbeDGObA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 10:31:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,419,1517904000";
   d="scan'208";a="31787334"
Message-ID: <1523111455.21176.418.camel@linux.intel.com>
Subject: Re: [PATCH v4 5/9] vsprintf: Factor out %p[iI] handler as
 ip_addr_string()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Sat, 07 Apr 2018 17:30:55 +0300
In-Reply-To: <20180404085843.16050-6-pmladek@suse.com>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-6-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:
> Move the non-trivial code from the long pointer() function. We are
> going
> to add a check for the access to the address that will make it even
> more
> complicated.
> 
> Also it is better to warn about unknown specifier instead of falling
> back to the %p behavior. It will help people to understand what is
> going wrong. They expect the IP address and not a pointer anyway
> in this situation.

> +	WARN_ONCE(1, "Unsupported pointer format specifier:
> %%p%c%c\n",
> +		  fmt[0], fmt[1]);
> 

I think WARN is too much here.

pr_warn_once() ?


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
