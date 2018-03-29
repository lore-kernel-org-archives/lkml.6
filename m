Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeC2QLg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:11:36 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:45962 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751859AbeC2QLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:11:34 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2911:3138:3139:3140:3141:3142:3622:3865:3867:3872:4321:4425:5007:10004:10400:10848:11026:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: cup92_81caf15d7bd00
X-Filterd-Recvd-Size: 1957
Message-ID: <1522339890.2210.35.camel@perches.com>
Subject: Re: [PATCH] vsprintf: Make "null" pointer dereference more robust
From: Joe Perches <joe@perches.com>
To: Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 29 Mar 2018 09:11:30 -0700
In-Reply-To: <20180329151309.omdoxcdku5xoshgx@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
         <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
         <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
         <1519752950.10722.231.camel@linux.intel.com>
         <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
         <1519814544.10722.266.camel@linux.intel.com>
         <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
         <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
         <1520000254.10722.389.camel@linux.intel.com>
         <20180329151309.omdoxcdku5xoshgx@pathway.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-29 at 17:13 +0200, Petr Mladek wrote:
> The original simple patch grew into something bigger. I have it
> almost ready. It looks the following way at the moment:
[]
>   vsprintf: Factor out %p[iI] handler as ip_addr_string()
>   vsprintf: Factor out %pV handler as va_format()
>   vsprintf: Factor out %pO handler as kobject_string()

I would like to review these before being applied.
