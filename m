Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeDIMaP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:30:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39105 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbeDIMaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:30:14 -0400
Date: Mon, 9 Apr 2018 14:30:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Perches <joe@perches.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
Message-ID: <20180409123010.jmoibgva5fvlc7vi@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-5-pmladek@suse.com>
 <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
 <1522971908.11185.46.camel@perches.com>
 <1522972535.11185.49.camel@perches.com>
 <20180406114333.gblf4znpasmkc2wl@pathway.suse.cz>
 <741c7f99-e39e-296c-1b91-3df7113ee71c@rasmusvillemoes.dk>
 <1523024839.6127.9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523024839.6127.9.camel@perches.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-04-06 07:27:19, Joe Perches wrote:
> On Fri, 2018-04-06 at 15:17 +0200, Rasmus Villemoes wrote:
> > On 2018-04-06 13:43, Petr Mladek wrote:
> > > On Thu 2018-04-05 16:55:35, Joe Perches wrote:
> > > > On Thu, 2018-04-05 at 16:45 -0700, Joe Perches wrote:
> > > > > On Thu, 2018-04-05 at 16:25 +0200, Rasmus Villemoes wrote:
> > > > > > Even just git grep -1 -E '%p"$' finds %pt and %po
> > > > > > which should get fixed before somebody claims those extensions.
> > > > > 
> > > > > Neither %pt nor %po is used in a vsprintf
> > > > > in the kernel.
> > > > 
> > > > Nope, you are right, both are defectively used in the
> > > > kernel via string concatenation.
> > > 
> > > Ah, I see.
> > 
> > Yes, that was the point of that particular grep pattern with context. I
> > sent patches three years ago and several pings, but despite an email
> > telling me it would be picked up "for the next release" nothing has
> > happened, so I've just been waiting for someone to implement a %po.
> > 
> > > Otherwise, the changes make perfect sense. Are you going to send
> > > them as proper patches, please?
> > 
> > Good luck. Unless Petr will be taking them through the printk tree?
> 
> As the trivial maintainer seems to use a leaky bucket algorithm
> for most trivial patches, I'll just retry and send actual
> patches through Andrew Morton as patches through his quilt tree
> seem to get upstream faster.

I could take them via printk.git. But Andrew is a good choice
as well.

Best Regards,
Petr
