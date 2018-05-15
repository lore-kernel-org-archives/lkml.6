Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeEOAYE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 20:24:04 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:38774 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752078AbeEOAYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 20:24:03 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3874:4321:5007:6119:7903:8957:10004:10400:10848:11232:11658:11914:12296:12740:12760:12895:13069:13184:13229:13311:13357:13439:14096:14097:14659:14721:21080:21451:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: fly33_7a693e05d7e3b
X-Filterd-Recvd-Size: 2079
Message-ID: <0cb282d85c37d9b626933a03574848d17430f04c.camel@perches.com>
Subject: Re: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging
 output
From: Joe Perches <joe@perches.com>
To: paulmck@linux.vnet.ibm.com
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 17:23:59 -0700
In-Reply-To: <20180514235832.GR26088@linux.vnet.ibm.com>
References: <cover.1525964381.git.joe@perches.com>
         <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
         <20180514202910.GI26088@linux.vnet.ibm.com>
         <32216d8f154b29400d4c11bae91850591114f7f8.camel@perches.com>
         <20180514222456.GO26088@linux.vnet.ibm.com>
         <3c7770a062355650fb61e48a5fbeb9653d98d85a.camel@perches.com>
         <20180514235832.GR26088@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-14 at 16:58 -0700, Paul E. McKenney wrote:
> OK, so if I define pr_fmt as follows, I get the old behavior?
> 
> 	#define pr_fmt(fmt) fmt

yes.

> I just queued
> a commit to be squashed into my version of your patch 18/18 that adds
> this to kernel/rcu/rcu_segcblist.c.  This joins the ones that your
> patch added to kernel/rcu/srcutree.c and kernel/rcu/tree.c.
> 
> Should I also add "#define pr_fmt(fmt) "rcu: " fmt" to these files?
> 
> kernel/rcu/srcutiny.c
> kernel/rcu/sync.c
> kernel/rcu/tiny.c

Well, I don't actually remember why the define
was added to rcu_segcblist.c.

Most of this was done via a script which looked
for pr_<level> uses without a pr_fmt in the same
file.

Dunno why rcu_segcblist was modified.
Maybe it was a braino.
