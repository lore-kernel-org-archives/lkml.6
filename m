Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754797AbeDYPB0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:01:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:1063 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753571AbeDYPBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:01:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="194312178"
Message-ID: <1524668476.21176.561.camel@linux.intel.com>
Subject: Re: [PATCH v5 08/11] vsprintf: Factor out %pO handler as
 kobject_string()
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
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Date: Wed, 25 Apr 2018 18:01:16 +0300
In-Reply-To: <20180425111251.13246-9-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
         <20180425111251.13246-9-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:12 +0200, Petr Mladek wrote:
> Move code from the long pointer() function. We are going to add a
> check for
> the access to the address that will make it even more complicated.
> 
> Also it is better to warn about unknown specifier instead of falling
> back to the %p behavior. It will help people to understand what is
> going wrong. They expect some device node names and not a pointer
> in this situation.
> 
> In fact, this avoids leaking the address when invalid %pO format
> specifier is used. The old code fallen back to printing the
> non-hashed value.
> 

> +static char *kobject_string(char *buf, char *end, void *ptr,
> +			    struct printf_spec spec, const char *fmt)

Do we need noinline_for_stack annotation? (Same question applies to
patch 7)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
