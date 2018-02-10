Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeBJRnE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 12:43:04 -0500
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:50765 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750909AbeBJRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 12:43:01 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:46:150:152:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2892:2899:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6691:6742:7875:7903:8531:9901:10004:10400:10848:10967:11232:11658:11914:11984:12296:12740:12895:13095:13161:13181:13229:13894:14096:14097:14181:14659:14721:21080:21325:21433:21451:21611:21627:30012:30025:30054:30056:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: stage32_542eabb89c554
X-Filterd-Recvd-Size: 3694
Message-ID: <1518284577.16865.8.camel@perches.com>
Subject: Re: Software evolution around
 =?UTF-8?Q?=E2=80=9Ccheckpatch=2Epl=E2=80=9D=3F?=
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Jiri Kosina <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Sat, 10 Feb 2018 09:42:57 -0800
In-Reply-To: <20180210155734.708d01b6@archlinux>
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
         <20180204112346.0977e938@archlinux>
         <9420fc82-1a37-3601-bafe-f57ef953bfcd@users.sourceforge.net>
         <87DF341A-1356-4B1B-8D25-14D5B0AAB01D@jic23.retrosnub.co.uk>
         <f008911b-c595-6e0f-d85f-076e994ae7db@users.sourceforge.net>
         <20180210145336.233c721d@archlinux> <1518274783.6579.2.camel@perches.com>
         <20180210155734.708d01b6@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-10 at 15:57 +0000, Jonathan Cameron wrote:
> On Sat, 10 Feb 2018 06:59:43 -0800
> Joe Perches <joe@perches.com> wrote:
> 
> > On Sat, 2018-02-10 at 14:53 +0000, Jonathan Cameron wrote:
> > > While it would be great to improve checkpatches false
> > > positive rate, it's very nature as a string matcher makes
> > > this hard.  
> > 
> > true.
> > 
> > what are the false positives you see?
> > 
> 
> This particular case is only 'sort of' a false positive
> in the warning that a message printed on a memory allocation
> failure 'may' not add any information over the generic case.

Right.  So it's not a 'false positive' at all.
Are there any actual 'false positives' you know of?

> Very hard to judge on whether it is useful to know more than
> an allocation failed somewhere or not.
> 
> Message makes this clear:
> > “WARNING: Possible unnecessary 'out of memory' message”
> > (from the script “checkpatch.pl”)  
> 
> We also have the balance between any changes to existing code
> adding 'some' maintenance overhead vs changing this stuff
> in a new driver - which is what checkpatch is really intended
> for.

There's almost zero maintenance overhead here.
The time it takes for the back and forth
replies is likely larger.

> So I think checkpatch is striking the right balance here in
> how it warns.  Obviously if it could assess the text
> and come to an informed decision that would be great but
> we are some way from that ;)

The 'informed' bit is difficult as it is mostly
a political problem.

This particular message really is unnecessary as
the generic dump_stack on any normal allocation
(ie: without __GFP_WARN) already emits location
specific information.

Removing these messages can help make the kernel
image smaller and thereby help make these OOM
messages a tiny bit less likely.

I just wish Markus would improve his consistently
terrible commit messages that just restate the
action being done and detail _why_ a particular
thing _should_ be done.

His acceptance rate would improve as many of these
back and forth replies for what trivialities he
posts as patches would be minimized.
