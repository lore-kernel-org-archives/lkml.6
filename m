Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeDJPOi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:14:38 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:38672 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753685AbeDJPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:14:36 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:599:800:960:966:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2553:2559:2562:2691:2692:2828:2903:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:3873:3874:4321:4385:5007:9010:9040:9121:10004:10400:10848:11232:11233:11658:11914:12043:12262:12296:12438:12555:12679:12740:12760:12895:13069:13163:13184:13229:13311:13357:13439:13891:13972:14093:14096:14097:14181:14659:14721:21080:21365:21451:21627:21740:30029:30045:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: flock94_280e7bcf8a446
X-Filterd-Recvd-Size: 2770
Message-ID: <a3ffaea6a161e667854127d2e021a04034985a97.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host
 drivers
From: Joe Perches <joe@perches.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 08:14:33 -0700
In-Reply-To: <20180410144654.fg2pbvh4d2y3rucv@katana>
References: <20180410141125.4477-1-wsa@the-dreams.de>
         <f0ce07bdb69602450ea1681936706b16962ce41f.camel@perches.com>
         <20180410144654.fg2pbvh4d2y3rucv@katana>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-10 at 16:46 +0200, Wolfram Sang wrote:
> > As far as I understand, all this seems correct to me.
> 
> Good. Thank you, Joe!
> /
> > You want to maintain the core files in drivers/i2c/
> > but not any files in any of algos/, busses/, or muxes/.
> 
> More specific: I don't want get_maintainer.pl to print me as a
> maintainer for these drivers.

I believe get_maintainer.pl is still going to do that for
awhile as you are a commit signer for several of these driver
files.  Files that are not either "supported" or "maintained"
by default add the --git-fallback option.

For instance, With your patch:
$ ./scripts/get_maintainer.pl -f drivers/i2c/algos/i2c-algo-bit.c
Wolfram Sang <wsa+renesas@sang-engineering.com> (commit_signer:3/2=100%,authored:1/2=50%,added_lines:5/15=33%)
Jean Delvare <jdelvare@suse.de> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:10/15=67%,removed_lines:3/3=100%)
linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM DRIVERS)
linux-kernel@vger.kernel.org (open list)

Your name should not be shown after a year or so unless you
actually sign-off on patches to those subdirectories.

btw: You signed-off using 2 different addresses on one
of those patches.  I think that's odd.

commit 3e5f06bed72fe72166a6778f630241a893f67799
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Mon Dec 4 09:16:18 2017 +0100

    i2c: algo-bit: init the bus to a known state
    
    Ensure the bus is free when we register the adapter. Before the SCL/SDA
    wires were in an unknown state. It used to work because sending a byte
    has a retry mechanism which was triggered if the bus was initially in a
    non-free state. But the graceful way to do it is to initialize
    correctly.
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
