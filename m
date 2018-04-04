Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeDDO0O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:26:14 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:58253 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751179AbeDDO0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:26:12 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2901:3138:3139:3140:3141:3142:3622:3865:3867:3871:3872:3874:4321:5007:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13146:13230:13311:13357:13439:14659:21080:21627:30012:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: edge06_8d16cf9dafb00
X-Filterd-Recvd-Size: 1534
Message-ID: <1522851967.11185.1.camel@perches.com>
Subject: Re: [PATCH v4 6/9] vsprintf: Factor out %pV handler as va_format()
From: Joe Perches <joe@perches.com>
To: Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Wed, 04 Apr 2018 07:26:07 -0700
In-Reply-To: <20180404085843.16050-7-pmladek@suse.com>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-7-pmladek@suse.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:
> Move the code from the long pointer() function. We are going to add a check
> for the access to the address that will make it even more complicated.
> 
> This patch does not change the existing behavior.

But it might increase stack consumption.

As the %pV is recursive, this is may not
be a good thing.
