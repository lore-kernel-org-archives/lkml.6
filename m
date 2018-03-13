Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeCMW32 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:29:28 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:35807 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932205AbeCMW31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:29:27 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4605:5007:6119:7514:7903:10004:10400:10848:10967:11026:11232:11473:11658:11914:12043:12438:12740:12760:12895:13069:13149:13230:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:30012:30025:30054:30055:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: berry94_1800623088962
X-Filterd-Recvd-Size: 2823
Message-ID: <1520980163.2049.54.camel@perches.com>
Subject: Re: [PATCH] clang-format: add configuration file
From: Joe Perches <joe@perches.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Robo Bot <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Tue, 13 Mar 2018 15:29:23 -0700
In-Reply-To: <CANiq72nKXXV7SDTmCwvizWA3ubdczNZV8qT2-PoGAQnDfX9qtg@mail.gmail.com>
References: <20180312233952.niz2cuz7psv4fe2s@gmail.com>
         <20180313140037.7717460162192c99775b135e@linux-foundation.org>
         <CANiq72nKXXV7SDTmCwvizWA3ubdczNZV8qT2-PoGAQnDfX9qtg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-13 at 22:52 +0100, Miguel Ojeda wrote:
> On Tue, Mar 13, 2018 at 10:00 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Tue, 13 Mar 2018 00:39:52 +0100 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> > > --- a/Documentation/process/4.Coding.rst
> > > +++ b/Documentation/process/4.Coding.rst
> > > @@ -58,6 +58,12 @@ can never be transgressed.  If there is a good reason to go against the
> > >  style (a line which becomes far less readable if split to fit within the
> > >  80-column limit, for example), just do it.
> > > 
> > > +Note that you can use the clang-format tool to help you with these rules
> > > +and to quickly re-format parts of your code automatically. It is specially
> > > +useful for new files/code and to spot coding style mistakes. It is also
> > > +useful to sort #includes, to align variables or comments, to reflow text
> > > +and other similar tasks.
> > 
> > It would be rather helpful to tell people how to invoke clang-format.

clang-format has its drawbacks but at least it is
likely to be improved more in the future.

That is a lot better than Lindent/indent.

Some not kernel-style compliant oddities:

o placements of braces for definitions is like:
static const struct pci_device_id e100_id_table[]
       = { INTEL_8255X_ETHERNET_DEVICE(0x1029, 0),
o alignment of block #defines
o alignment of function arguments
o logical tests continuations moved to BOL not EOL
o misalignment of per-line comments
o location of struct/union/enum braces

etc...

After applying Miguel's patch, try it with something like:

$ git ls-files -- "drivers/net/ethernet/intel/*.[ch]" | \
  while read file ; do clang-format -i $file ; done

and look at the diff (I used clang-format-5.0.0-3)
