Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeDFNMq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:12:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:57026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752833AbeDFNMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:12:45 -0400
Date: Fri, 6 Apr 2018 15:12:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Perches <joe@perches.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] vsprintf: Factor out %pV handler as va_format()
Message-ID: <20180406131242.mnxutlobi7r6qi6u@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-7-pmladek@suse.com>
 <1522851967.11185.1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522851967.11185.1.camel@perches.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-04-04 07:26:07, Joe Perches wrote:
> On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:
> > Move the code from the long pointer() function. We are going to add a check
> > for the access to the address that will make it even more complicated.
> > 
> > This patch does not change the existing behavior.
> 
> But it might increase stack consumption.
> 
> As the %pV is recursive, this is may not be a good thing.

It seems to be safe to pass just a pointer to struct printf_spec.
In fact, it would make sense to use this also in string() and
__string() calls. Copying 64 bytes many times look useless.

Do you think that other optimizations would be necessary?
For example, marking the function as inline?

Best Regards,
Petr
