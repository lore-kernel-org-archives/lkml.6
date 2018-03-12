Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932657AbeCLRZo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:25:44 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:58255 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932511AbeCLRZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:25:42 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:541:599:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3873:3874:4321:5007:6691:8828:10004:10400:10848:11026:11232:11658:11914:12679:12740:12760:12895:13069:13071:13095:13141:13230:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21433:21451:21627:30012:30029:30054:30070:30091,0,RBL:172.58.40.157:@perches.com:.lbl8.mailshell.net-62.8.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: wool78_4e83b89075e60
X-Filterd-Recvd-Size: 2879
Message-ID: <1520875536.2049.11.camel@perches.com>
Subject: Re: [PATCH] mtd: chips: Replace printk() with pr_*() and define
 pr_fmt()
From: Joe Perches <joe@perches.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>, dwmw2@infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Mar 2018 10:25:36 -0700
In-Reply-To: <20180312170208.GA10604@seema-Inspiron-15-3567>
References: <20180312170208.GA10604@seema-Inspiron-15-3567>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 22:32 +0530, Arushi Singhal wrote:
> Using pr_<loglevel>() is more concise than printk(KERN_<LOGLEVEL>).
> This patch:
> * Replace printks having a log level with the appropriate pr_*() macros.
> * Define pr_fmt() to include relevant name.
> * Remove redundant prefixes from pr_*() calls.
> * Indent the code where possible.

Hello Arushi.

When you do these, please remember to remove the unnecessary
and inconsistent uses of periods and to coalesce formats
where appropriate.

Also, there was _some_ logic here behind the use of the
"cfi_cmdset_0001:" prefix on only some of the error messages.

Perhaps the commit message should describe that change a bit
more fully.

Lastly, please run checkpatch on your proposed patches.

$ ./scripts/checkpatch.pl --terse patch.mbox
patch.mbox:151: ERROR: space prohibited before that close parenthesis ')'
patch.mbox:160: ERROR: space prohibited before that close parenthesis ')'
patch.mbox:183: WARNING: line over 80 characters
patch.mbox:201: WARNING: line over 80 characters
patch.mbox:211: ERROR: space required after that ',' (ctx:VxV)
patch.mbox:253: WARNING: quoted string split across lines
patch.mbox:273: WARNING: line over 80 characters
patch.mbox:273: WARNING: Prefer using '"%s...", __func__' to using 'put_chip', this function's name, in a string
patch.mbox:282: WARNING: line over 80 characters
patch.mbox:304: WARNING: line over 80 characters
patch.mbox:313: WARNING: line over 80 characters
patch.mbox:346: WARNING: line over 80 characters
patch.mbox:364: WARNING: line over 80 characters
patch.mbox:376: WARNING: line over 80 characters
patch.mbox:383: WARNING: line over 80 characters
patch.mbox:456: WARNING: line over 80 characters
patch.mbox:465: WARNING: line over 80 characters
total: 3 errors, 14 warnings, 343 lines checked
