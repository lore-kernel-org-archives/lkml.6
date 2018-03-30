Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeC3UR0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 16:17:26 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:35707 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752639AbeC3URZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 16:17:25 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3873:4321:5007:6119:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30017:30054:30090:30091,0,RBL:172.56.31.163:@perches.com:.lbl8.mailshell.net-62.8.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: day69_63316626b209
X-Filterd-Recvd-Size: 1907
Message-ID: <1522441039.2210.50.camel@perches.com>
Subject: Re: [PATCH] crypto: cavium: zip: Remove unnecessary parentheses
From: Joe Perches <joe@perches.com>
To: Varsha Rao <rvarsha016@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>
Date: Fri, 30 Mar 2018 13:17:19 -0700
In-Reply-To: <CAAFX7JTfWdaGra+kWBJt-GXVVO601K03qWnExFKFD_9vxS-03g@mail.gmail.com>
References: <20180328175736.17360-1-rvarsha016@gmail.com>
         <1522260676.12357.121.camel@perches.com>
         <CAAFX7JTfWdaGra+kWBJt-GXVVO601K03qWnExFKFD_9vxS-03g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-29 at 21:03 +0530, Varsha Rao wrote:
> On Wed, Mar 28, 2018 at 11:41 PM, Joe Perches wrote:
> > 
> > On Wed, 2018-03-28 at 23:27, Varsha Rao wrote:
> > > This patch fixes the clang warning of extraneous parentheses, with the
> > > following coccinelle script.
> > > 
> > > @@
> > > identifier i;
> > > constant c;
> > > @@
> > > (
> > > -((i == c))
> > > +i == c
> > > > 
> > > 
> > > -((i <= c))
> > > +i <= c
> > 
> > Why just the "==" and "<=" cases?
> > Why not "<", ">" and ">=" too?
> > 
> > Why not expression instead of constant?
> 
> Initially I had the other cases too and used expression instead of
> constant. But the results included only "==" and "<=" cases with
> constant. Along with one false positive case.
hmm
Perhaps you should use something like this?
@@
identifier i;
constant c;
@@

-(
\(i == c\|i <= c\|i < c\|i >= c\|i > c\)
-)
