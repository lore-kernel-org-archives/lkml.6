Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeEMRar (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 13:30:47 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:51880 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751926AbeEMRaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 13:30:46 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:10004:10400:10848:11232:11658:11914:12296:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: soda65_5dd694680380a
X-Filterd-Recvd-Size: 1975
Message-ID: <92cfb1fbbcae16f4acd0096f598339d3d050b139.camel@perches.com>
Subject: Re: [PATCH 1/6] x86/early-quirks: Rename duplicate define of dev_err
From: Joe Perches <joe@perches.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Date: Sun, 13 May 2018 10:30:43 -0700
In-Reply-To: <alpine.DEB.2.21.1805131503050.1582@nanos.tec.linutronix.de>
References: <cover.1525878372.git.joe@perches.com>
         <8fb4b2a77d50e21ae1f7e4e267e68691efe2c270.1525878372.git.joe@perches.com>
         <alpine.DEB.2.21.1805131503050.1582@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-05-13 at 15:03 +0200, Thomas Gleixner wrote:
> On Wed, 9 May 2018, Joe Perches wrote:
> 
> > dev_err is becoming a macro calling _dev_err to allow prefixing of
> > dev_fmt to any dev_<level> use that has a #define dev_fmt(fmt) similar
> > to the existing #define pr_fmt(fmt) uses.
> > 
> > Remove this dev_err macro and convert the existing two uses to pr_err.
> > This allows clean compilation in the patch that introduces dev_fmt which
> > can prefix dev_<level> logging macros with arbitrary content similar to
> > the #define pr_fmt macro.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> I assume you want to take them as block, so:
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

I do not have a tree that Linus pulls.

I think it'd be fine if you apply this one as it's a
simple rename deduplication.

Corey Minyard has already taken the ipmi changes
separately.

Patch 2/6 could go separately, probably via Greg KH's
tree, after this 1/6 change is in the tree.
