Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeDIKuk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:50:40 -0400
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:43017 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751902AbeDIKuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:50:39 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2692:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:10004:10400:10848:11232:11658:11914:12663:12740:12760:12895:13069:13161:13229:13311:13357:13439:14180:14659:21060:21080:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: unit64_586923d85817
X-Filterd-Recvd-Size: 1815
Message-ID: <e5d59c005cdf0183b866fd24a012ccc35118f121.camel@perches.com>
Subject: Re: [PATCH] checkpatch: relax check for revert commit
From: Joe Perches <joe@perches.com>
To: Jia He <hejianet@gmail.com>, Andy Whitcroft <apw@canonical.com>
Cc: linux-kernel@vger.kernel.org, Jia He <jia.he@hxt-semitech.com>
Date: Mon, 09 Apr 2018 03:50:36 -0700
In-Reply-To: <979a4ce5-2c68-6186-476c-1214aed2cdbc@gmail.com>
References: <1522679339-19067-1-git-send-email-hejianet@gmail.com>
         <1522679339-19067-2-git-send-email-hejianet@gmail.com>
         <d5f5fbc7-d01f-05e1-f8ac-c1db8ba5fd9e@gmail.com>
         <7d9467ac5aee4b81b5c58c167ac553c75dd26f4c.camel@perches.com>
         <979a4ce5-2c68-6186-476c-1214aed2cdbc@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-09 at 14:37 +0800, Jia He wrote:
> 
> On 4/9/2018 1:07 AM, Joe Perches Wrote:
> > On Sun, 2018-04-08 at 10:12 +0800, Jia He wrote:
> > > Hi Andy & Joe
> > > 
> > > Although it is minor, it is a real bug, I thought.
> > > 
> > > Is there any comment? Thank you
> > 
> > If you really want to do something useful here,
> > quote the quote characters and compare for that.
> > 
> > 
> 
> Hi Joe, thanks for the comments
> I am not sure I understand you comments here.

Change the tests to allow quote characters instead
of ignoring them.

To do this matching, any internal  quote character in
the actual commit string and the commit string from the
patch must be perl quoted with \Q<string>\E so that the
expected title can be matched properly.
