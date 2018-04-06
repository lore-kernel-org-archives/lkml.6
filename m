Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756627AbeDFO10 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:27:26 -0400
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:37013 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755153AbeDFO1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:27:23 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4043:4321:5007:7974:10004:10400:10450:10455:10848:11232:11658:11914:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14659:14777:19904:19999:21080:21324:21325:21433:21627:30022:30054:30083:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: lock74_7a5cf78fce62a
X-Filterd-Recvd-Size: 2970
Message-ID: <1523024839.6127.9.camel@perches.com>
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown
 pointer specifiers
From: Joe Perches <joe@perches.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Fri, 06 Apr 2018 07:27:19 -0700
In-Reply-To: <741c7f99-e39e-296c-1b91-3df7113ee71c@rasmusvillemoes.dk>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-5-pmladek@suse.com>
         <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
         <1522971908.11185.46.camel@perches.com>
         <1522972535.11185.49.camel@perches.com>
         <20180406114333.gblf4znpasmkc2wl@pathway.suse.cz>
         <741c7f99-e39e-296c-1b91-3df7113ee71c@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-06 at 15:17 +0200, Rasmus Villemoes wrote:
> On 2018-04-06 13:43, Petr Mladek wrote:
> > On Thu 2018-04-05 16:55:35, Joe Perches wrote:
> > > On Thu, 2018-04-05 at 16:45 -0700, Joe Perches wrote:
> > > > On Thu, 2018-04-05 at 16:25 +0200, Rasmus Villemoes wrote:
> > > > > Even just git grep -1 -E '%p"$' finds %pt and %po
> > > > > which should get fixed before somebody claims those extensions.
> > > > 
> > > > Neither %pt nor %po is used in a vsprintf
> > > > in the kernel.
> > > 
> > > Nope, you are right, both are defectively used in the
> > > kernel via string concatenation.
> > 
> > Ah, I see.
> 
> Yes, that was the point of that particular grep pattern with context. I
> sent patches three years ago and several pings, but despite an email
> telling me it would be picked up "for the next release" nothing has
> happened, so I've just been waiting for someone to implement a %po.
> 
> > Otherwise, the changes make perfect sense. Are you going to send
> > them as proper patches, please?
> 
> Good luck. Unless Petr will be taking them through the printk tree?

As the trivial maintainer seems to use a leaky bucket algorithm
for most trivial patches, I'll just retry and send actual
patches through Andrew Morton as patches through his quilt tree
seem to get upstream faster.

And thanks Petr for noticing the missing __func__, I was just
mindlessly editing those two files as a placeholder for where
the missing spaces in the %p concatenations exist.
