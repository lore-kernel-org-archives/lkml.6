Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeBRQb4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 11:31:56 -0500
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:42131 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751259AbeBRQby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 11:31:54 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3872:4321:4605:5007:9149:10004:10400:10848:11026:11232:11658:11914:12043:12740:12760:12895:13069:13101:13146:13230:13311:13357:13439:14181:14659:14721:21080:21433:21611:21627:30054:30060:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: lunch99_4a7204765923b
X-Filterd-Recvd-Size: 2239
Message-ID: <1518971510.1894.2.camel@perches.com>
Subject: Re: [PATCH] i40evf: remove redundant array comparisons to 0 checks
From: Joe Perches <joe@perches.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 18 Feb 2018 08:31:50 -0800
In-Reply-To: <CAHp75VcsV4NfR3OiAjjYAowcHmK+rXOsrPN2aHnxBp5hqg+C+g@mail.gmail.com>
References: <20180215194245.28860-1-colin.king@canonical.com>
         <CAHp75Vcxt0kkzRaF1Zzkt4hVqcPt0VG61yTLgB7HvG1xwhPUbg@mail.gmail.com>
         <eb8a38bd-73a0-5f44-5e89-d9ded5be1800@canonical.com>
         <CAHp75VcsV4NfR3OiAjjYAowcHmK+rXOsrPN2aHnxBp5hqg+C+g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-18 at 16:58 +0200, Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 6:53 PM, Colin Ian King
> <colin.king@canonical.com> wrote:
> > On 16/02/18 16:51, Andy Shevchenko wrote:
> > > On Thu, Feb 15, 2018 at 9:42 PM, Colin King <colin.king@canonical.com> wrote:
> > > > +                       filter->f.mask.tcp_spec.dst_ip[i] |=
> > > >                                                         cpu_to_be32(0xffffffff);
> > > 
> > > Can it be one line then?
> > 
> > I re-adjusted the text because checkpatch was complaining.
> > > 
> > > > +                       filter->f.mask.tcp_spec.src_ip[i] |=
> > > >                                                         cpu_to_be32(0xffffffff);
> 
> For the rest OK, but for the above two how much over 80 it went if
> would be one line?
> If it 2-3 characters, consider to make it one line. It would increase
> readability.

Another possibility would be to use temporaries for
	filter->f.mask.tcp_spec
and
	filter->f.data.tcp_spec
as both are used ~10 times in the function
