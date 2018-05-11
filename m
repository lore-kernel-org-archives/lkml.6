Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeEKCNB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:13:01 -0400
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:58973 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750805AbeEKCNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:13:00 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3874:4250:4321:4605:5007:6119:7514:7875:7903:10004:10400:10848:11026:11232:11658:11914:12043:12296:12740:12760:12895:13069:13311:13357:13439:14093:14096:14097:14181:14659:14721:21080:21451:21627:21740:30041:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: chalk40_715bf17666d21
X-Filterd-Recvd-Size: 2951
Message-ID: <8cbdd3e5d08c3faf3e7d10e19e8261f3222ce27c.camel@perches.com>
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to
 KBUILD_MODNAME
From: Joe Perches <joe@perches.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 19:12:57 -0700
In-Reply-To: <18d24efb4d5dafae2360cb2103b366098311998a.camel@perches.com>
References: <cover.1525964381.git.joe@perches.com>
         <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
         <20180511015140.GB895@jagdpanzerIV>
         <18d24efb4d5dafae2360cb2103b366098311998a.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-10 at 18:57 -0700, Joe Perches wrote:
> On Fri, 2018-05-11 at 10:51 +0900, Sergey Senozhatsky wrote:
> > On (05/10/18 08:45), Joe Perches wrote:
> > > There are more than 1000 uses of #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > Make that the default define so these uses can be removed later via script.
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > In general, the idea looks OK to me, so FWIW
> > Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > 
> > A quick question:
> > 
> > - Would "can be removed later via script" be so trivial?
> >   What about these guys?
> > 
> > drivers/of/address.c:#define pr_fmt(fmt)        "OF: " fmt
> > drivers/of/base.c:#define pr_fmt(fmt)   "OF: " fmt
> > drivers/of/dynamic.c:#define pr_fmt(fmt)        "OF: " fmt
> > drivers/of/fdt.c:#define pr_fmt(fmt)    "OF: fdt: " fmt
> > drivers/of/fdt_address.c:#define pr_fmt(fmt)    "OF: fdt: " fmt
> > drivers/of/irq.c:#define pr_fmt(fmt)    "OF: " fmt
> > drivers/of/of_numa.c:#define pr_fmt(fmt) "OF: NUMA: " fmt
> > drivers/of/of_reserved_mem.c:#define pr_fmt(fmt)        "OF: reserved mem: " fmt
> > drivers/of/overlay.c:#define pr_fmt(fmt)        "OF: overlay: " fmt
> > drivers/of/platform.c:#define pr_fmt(fmt)       "OF: " fmt
> > drivers/of/property.c:#define pr_fmt(fmt)       "OF: " fmt
> > drivers/of/resolver.c:#define pr_fmt(fmt)       "OF: resolver: " fmt
> 
> What about them?
> 
> All those defines above are non-generic as they are
> specified to start with "OF: " and then some optional
> extra bit.
> 
> Why should these defines be updated or modified?

What would be good, and is something that I will
eventually work on, is to make the KBUILD_MODNAME ": "
use a singleton looked up and inserted by the printk
subsystem instead of stored with each format.
