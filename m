Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755424AbeEaPMa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:12:30 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:52177 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755134AbeEaPM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:12:27 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7903:10004:10400:10848:11026:11232:11658:11914:12043:12295:12296:12438:12555:12740:12760:12895:13069:13311:13357:13439:14093:14096:14097:14659:14721:21080:21433:21451:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: cows72_4f4f8cbd75302
X-Filterd-Recvd-Size: 2434
Message-ID: <f42f8c4aeceb9025bc63716ec43e3a07a36dca8d.camel@perches.com>
Subject: Re: [PATCH 1/2] printk: remove unused flag LOG_NOCONS
From: Joe Perches <joe@perches.com>
To: Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>
Cc: sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Date: Thu, 31 May 2018 08:12:23 -0700
In-Reply-To: <20180531121633.acuffu2b66q24c5c@pathway.suse.cz>
References: <CGME20180531102133epcas5p2e8d47887c1708836c9b70964983093e2@epcas5p2.samsung.com>
         <20180531102133epcas5p2e8d47887c1708836c9b70964983093e2~zs4eTmEuv0380103801epcas5p2U@epcas5p2.samsung.com>
         <20180531121633.acuffu2b66q24c5c@pathway.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-31 at 14:16 +0200, Petr Mladek wrote:
> On Thu 2018-05-31 15:47:51, Maninder Singh wrote:
> > This patch removes unused flag LOG_NOCONS for printk.
> > usage of this flag is removed long back with below commit.
> 
> Make sense.
> 
> > "5c2992ee7fd8a29d04125dc0aa3522784c5fa5eb"
> > printk: remove console flushing special cases for
> >  partial buffered lines
[]
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
[]
> > @@ -349,10 +349,9 @@ enum con_msg_format_flags {
> >   */
> >  
> >  enum log_flags {
> > -	LOG_NOCONS	= 1,	/* already flushed, do not print to console */
> > -	LOG_NEWLINE	= 2,	/* text ended with a newline */
> > -	LOG_PREFIX	= 4,	/* text started with a prefix */
> > -	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
> > +	LOG_NEWLINE	= 1,	/* text ended with a newline */
> > +	LOG_PREFIX	= 2,	/* text started with a prefix */
> > +	LOG_CONT	= 4,	/* text is a fragment of a continuation line */
> >  };
> 
> Please, do not renumber the bits if there is no real need for it.
> The format of the log buffer is read also by external tool like
> "crash". It seems that "crash" ignores these flags but...

Hmm, if it's not an internal interface, then these
definitions should probably be removed from this file
and exposed in a uapi file.
