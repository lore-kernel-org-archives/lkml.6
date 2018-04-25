Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753836AbeDYNLP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:11:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:57956 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752826AbeDYNLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:11:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="49829214"
Message-ID: <1524661868.21176.552.camel@linux.intel.com>
Subject: Re: [PATCH v5 06/11] vsprintf: Factor out %p[iI] handler as
 ip_addr_string()
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
Date: Wed, 25 Apr 2018 16:11:08 +0300
In-Reply-To: <20180425111251.13246-7-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
         <20180425111251.13246-7-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:12 +0200, Petr Mladek wrote:
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
> 

Can we split to 1) move out + 2) misc changes ?

> +			return valid_string(buf, end, "(invalid
> address)",
> +					    spec);

I would still put it on one line.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
