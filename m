Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeDILpA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:45:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbeDILo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:44:59 -0400
Date: Mon, 9 Apr 2018 13:44:55 +0200
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
Message-ID: <20180409114455.6wt6zvn6dzlgyhvp@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-7-pmladek@suse.com>
 <1522851967.11185.1.camel@perches.com>
 <20180406131242.mnxutlobi7r6qi6u@pathway.suse.cz>
 <1523024355.6127.3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523024355.6127.3.camel@perches.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-04-06 07:19:15, Joe Perches wrote:
> On Fri, 2018-04-06 at 15:12 +0200, Petr Mladek wrote:
> > On Wed 2018-04-04 07:26:07, Joe Perches wrote:
> > > On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:
> > > > Move the code from the long pointer() function. We are going to add a check
> > > > for the access to the address that will make it even more complicated.
> > > > 
> > > > This patch does not change the existing behavior.
> > > 
> > > But it might increase stack consumption.
> > > 
> > > As the %pV is recursive, this is may not be a good thing.
> > 
> > It seems to be safe to pass just a pointer to struct printf_spec.
> > In fact, it would make sense to use this also in string() and
> > __string() calls. Copying 64 bytes many times look useless.
> 
> huh?
> 
> struct printf_spec is 64 bits, the same size as a
> pointer on 64 bit systems.

Yes, it was a nonsense. It was late Friday here when I wrote it.


> I'm dubious about this entire patch series.

I would appreciate some constructive feedback.
What exactly is wrong? What you would suggest instead?

Best Regards,
Petr
