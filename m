Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeDFX7o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 19:59:44 -0400
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:46271 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751488AbeDFX7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 19:59:43 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1568:1593:1594:1711:1714:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3873:4250:4321:5007:9108:10004:10400:10450:10455:10848:11232:11658:11914:12740:12760:12895:13019:13069:13161:13229:13311:13357:13439:14096:14097:14659:19904:19999:21080:21324:21433:21627:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: judge80_1a4622aff622e
X-Filterd-Recvd-Size: 2405
Message-ID: <1523059179.6127.45.camel@perches.com>
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown
 pointer specifiers
From: Joe Perches <joe@perches.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Fri, 06 Apr 2018 16:59:39 -0700
In-Reply-To: <20180406235214.GA386@tigerII.localdomain>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-5-pmladek@suse.com>
         <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
         <1522971908.11185.46.camel@perches.com>
         <1522972535.11185.49.camel@perches.com>
         <20180406235214.GA386@tigerII.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-04-07 at 08:52 +0900, Sergey Senozhatsky wrote:
> On (04/05/18 16:55), Joe Perches wrote:
> > On Thu, 2018-04-05 at 16:45 -0700, Joe Perches wrote:
> > > On Thu, 2018-04-05 at 16:25 +0200, Rasmus Villemoes wrote:
> > > > Even just git grep -1 -E '%p"$' finds %pt and %po
> > > > which should get fixed before somebody claims those extensions.
> > > 
> > > Neither %pt nor %po is used in a vsprintf
> > > in the kernel.
> > 
> > Nope, you are right, both are defectively used in the
> > kernel via string concatenation.
> > 
> > Also there's a missing space in a concatenation adjacent.
> 
> Can we tweak checkpatch to catch such things?

Not really, no.

Adding regex logic for this is tricky at best
and probably not worth the effort because of
the various bits of patch contexts aren't
necessarily visible.

There are also concatenations like
	"foo" DEFINE "bar"
where DEFINE may not be visible in the patch
context and checkpatch is and likely will
remain just a limited regex checker.
