Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeDEOOo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:14:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:41664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbeDEOOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:14:43 -0400
Date: Thu, 5 Apr 2018 16:14:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/9] vsprintf: Factor out %p[iI] handler as
 ip_addr_string()
Message-ID: <20180405141441.ocdzhuqezlkuitv4@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-6-pmladek@suse.com>
 <20180404235816.GD622@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404235816.GD622@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-05 08:58:16, Sergey Senozhatsky wrote:
> On (04/04/18 10:58), Petr Mladek wrote:
> > 
> > Also it is better to warn about unknown specifier instead of falling
> > back to the %p behavior. It will help people to understand what is
> > going wrong. They expect the IP address and not a pointer anyway
> > in this situation.
> >
> 
> May be. If one sees a hashed value where IP address/device name/etc
> was meant to be then it's already a sign that something is wrong.
> Those WARN_ONCE that you have added make things simpler, I agree.
> A quick question, what happens on !CONFIG_BUG systems (where we have
> no_printk() WARN)?

People with CONFIG_BUG disabled will miss much more important
warnings. IMHO, an unreported typo in printk format will be
one of their smallest problems.

Best Regards,
Petr
