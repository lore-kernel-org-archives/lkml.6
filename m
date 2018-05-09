Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965848AbeEIRFA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:05:00 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:57794 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965677AbeEIREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:04:54 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2689:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3873:3874:4250:4321:5007:7903:8660:10004:10400:10848:11232:11658:11914:12296:12555:12663:12740:12760:12895:12986:13069:13095:13148:13161:13229:13230:13311:13357:13439:14096:14097:14659:14721:21080:21433:21451:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: knee66_479c34012034b
X-Filterd-Recvd-Size: 2293
Message-ID: <ee5a0e0065047cd4d1da340f6ee924f3a31b0fac.camel@perches.com>
Subject: Re: [PATCH 0/6] treewide: Add and use dev_fmt similar to pr_fmt
From: Joe Perches <joe@perches.com>
To: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-rdma@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 09 May 2018 10:04:50 -0700
In-Reply-To: <4a397208-bd6c-a6c3-c161-4de8579ca17e@gmail.com>
References: <cover.1525878372.git.joe@perches.com>
         <4a397208-bd6c-a6c3-c161-4de8579ca17e@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-09 at 11:47 -0500, Corey Minyard wrote:
> On 05/09/2018 10:15 AM, Joe Perches wrote:
> > The pr_fmt mechanism exists for pr_<level> logging message prefixing,
> > but no similar capability exists for dev_<level> message prefixing.
> > 
> > Many uses of dev_<level> have an embedded prefix for logging output.
> > 
> > So add a similar dev_fmt macro that can automatically prefix the
> > dev_<level> logging output.
> > 
> > Rename the existing dev_<level> functions to _dev_<level> and add new
> > macros that call _dev_<level> with the desired prefix if defined.
> > 
> > The new default #define for dev_fmt is blank.
> > 
> > Convert ipmi and infiniband to use this mechanism.
> 
> The IPMI changes look good to me.

Oh good.

> There are some conflicts with a patch I have pulling out the proc 
> interface that is destined for 3.18.

I'm sure you mean 4.18.

> I can take the IPMI changes into my tree, if you want.

These patches are not at all urgent and were done
on top of next-20180509.

As there are dependencies between the patch that
introduces dev_fmt and the reset of the patches,
I think it makes sense to take these as a single
patchset rather than take parts into various trees.

Respinning the IPMI patches is trivial and can be
done whenever appropriate.

When do you expect your IPMI patches to hit -next?
