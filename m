Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeC0GwK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:52:10 -0400
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:50984 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752044AbeC0GwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:52:08 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2689:2828:2895:2911:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4425:5007:6119:10004:10400:10848:11026:11232:11473:11658:11914:12043:12663:12740:12760:12895:13069:13311:13357:13439:14040:14659:14721:21080:21324:21433:21627:21740:30051:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: roof35_4cbbbeea0e538
X-Filterd-Recvd-Size: 2675
Message-ID: <1522133524.12357.56.camel@perches.com>
Subject: Re: [PATCH script] hwmon: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        patches@opensource.cirrus.com
Date: Mon, 26 Mar 2018 23:52:04 -0700
In-Reply-To: <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
References: <1522096136.12357.21.camel@perches.com>
         <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-26 at 23:33 -0700, Guenter Roeck wrote:
> On 03/26/2018 01:28 PM, Joe Perches wrote:
> > drivers/hwmon is the most frequent user of symbolic permissions
> > like S_IRUGO in the kernel tree.
[]
> I have something similar using coccinelle,

Please post the script.
I expect it doesn't work quite the same as checkpatch.

> which has the added benefit
> of also adjusting multi-line alignments.

That's a benefit, but it's makes it difficult to review.
I also have the same patch rewrap alignment post this
automated patch, done with emacs formatting.

This patch is somewhat simpler to review which is why
it's not sent along with this script.

> But then I am hesitant to pull
> it in because I don't really see the point. A more intelligent approach
> would be to convert hwmon drivers to the latest API, and/or to introduce
> more intelligent macros such as SENSOR_DEVICE_ATTR_{RO,RW,WO}.

Another approach would be to separate the const bits
from the non-const bits to reduce data.

> But that
> would require active work as well as reviewers, and especially the latter
> is extremely difficult if not impossible to find for the hwmon subsystem.

[]

> Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",
> that is maybe not entirely surprising, and I think we are good as we are.

Maybe true.

> I am happy to accept patches updating permissions as other changes are made
> to a file, but I don't see a pressing need to change all files just to make
> statistics happy (and backports more difficult).

Not sure backports are a real issue.

If it were a real issue, the updated permissions are noise
and shouldn't be accepted for the other changes.
