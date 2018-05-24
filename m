Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2485797-1527192110-2-12571343789485614399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527192109; b=ku8cfWayt7W5kkNtlJi+fQVj6Ig8wY4cd4HIZ49BFh0shfam6E
    h5uzfBIcIBPkRS4Rssp1BjtSWoeweM4jnOoQUF5kf3+MhdvREYjIQR8jFplDIc8s
    VVKxu0F+URQcrOFg7hhl95BTEHiy/EpBr6YO3RCh3iNUt920dAsh8vP/3YSdUGXh
    Fq7RMOeT0CMr0XZMJvN3o9YLYsye+NopVTIMf1wM8tPoWPEMZEJRt6tiyrWKGM6O
    HvnCniJpo3ac0kCdjJbPoc2/0Wr5/1GlYmBqK7cRWH8P4wO8lTcnXZLmPXE9CsHr
    Tnlp/KY3vlL+QRfGf2ae5eFlwcddA2ZwvhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527192109; bh=pBVd/6eOHb8H6ZKg7scum3VoaUKxiXa+VDnjHA8l5h
    E=; b=lD/m7Yq586+LwvQI8TvEkNA2hYQ014G9S1Oa0DxnZGAWAnkZ3P4R7uY31p
    NOj/JwyXu0dYNtD3nZNgKhnZE6JZsMMkFrg8J0DD+3Ri6bEG0Q5l3tocGsYx1fsz
    NurmqHuSoBT+Z+F2A+HgPSBw8FLPc7wof0EKZlBmhfT+7LPEUR2O5bpkA4PVDEqo
    axu/XWG7TEVEzcw6XPbUFN1X+owq8qCAiVY9zoxQQk2SX8V/POTfYWzTbFS4Bs7N
    AJx0MsKHmjpCfKh22VWklOegGBF2dtqh/+3EtoFu0yp92bHoxxnN+h7YbCOT2vVa
    8+2Xq5TvR5yDXhVkye/ByiyRD+EA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=lpjQsNMv x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Q90z53lj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=lpjQsNMv x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Q90z53lj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGpjUFbsYN9pPybM2wnaDkNHvmbxB6rO7Bw/+4Wl4rqFc61R/ouocygxLi0hcSY4gi27C/FUNOWiL+voPCSS8/5ZjeQokYqF7mQUWWI4MoCeM4nkzC/7
    iSrxv0A3Cf+RnmGIX4KGwXDe+k5swd572l1BcRq5BsiT36XujeKDdVIt1L0yS96EvSUmgixczi+BEvo126kB5kYAK6SZ/lzG2/37F0dSisHKvhYcB9DlN6Ep
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=TTgf3g41wVxbUq42LhoA:9 a=Vn7uph7HnJobbn7Y:21
    a=D5t7-nLncKt_RRbz:21 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbeEXUBr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 16:01:47 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34452 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeEXUBq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 16:01:46 -0400
X-Google-Smtp-Source: ADUXVKLU7uQ8ubqFrlu/qGDaOWkKwM7Rm+eTtKgkRrC/DUbAkiQN/YktVmVfu3kDSThkbUoEzJ5MLpgu5lTvnapbS68=
MIME-Version: 1.0
References: <20180524093159.286472249@linuxfoundation.org> <20180524093204.290399449@linuxfoundation.org>
 <20180524105011.jkmjrmoyqtogtgnn@quack2.suse.cz> <20180524110546.GA16171@kroah.com>
 <CANsGZ6bsz-J9XB_O5+B+mmRV2CGaJ8e+Aa=N3WnE7YNARWsAnw@mail.gmail.com>
 <20180524112841.GA17626@kroah.com> <CANsGZ6anzAW3dcEQqgfRGxnk+n4ih_PpKOCGdcHv_SF86x2-0g@mail.gmail.com>
 <20180524190611.GD31019@kroah.com>
In-Reply-To: <20180524190611.GD31019@kroah.com>
From: Hugh Dickins <hughd@google.com>
Date: Thu, 24 May 2018 13:01:18 -0700
Message-ID: <CANsGZ6YgFCzGqktw2zQGKd91NDnHHqEAdr8k22W4LaRqeZ1Lqw@mail.gmail.com>
Subject: Re: [PATCH 4.4 50/92] mm: filemap: avoid unnecessary calls to
 lock_page when waiting for IO to complete during a read
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 12:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, May 24, 2018 at 10:27:59AM -0700, Hugh Dickins wrote:
> > On Thu, May 24, 2018 at 4:28 AM Greg KH <gregkh@linuxfoundation.org>
wrote:
> > > On Thu, May 24, 2018 at 04:17:12AM -0700, Hugh Dickins wrote:
> > > >   Thu, May 24, 2018 at 4:06 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org>
> > > > wrote:
> > > >
> > > > > On Thu, May 24, 2018 at 12:50:11PM +0200, Jan Kara wrote:
> > > > > > On Thu 24-05-18 11:38:27, Greg Kroah-Hartman wrote:
> > > > > > > 4.4-stable review patch.  If anyone has any objections, please
> > let me
> > > > know.
> > > > > >
> > > > > > Just one objection: Why does stable care about this (and the
> > previous
> > > > > > patch)? I've checked the stable queue and I don't see anything
that
> > > > would
> > > > > > have these patches as a prerequisite. And on their own, they are
> > only
> > > > > > cleanups without substantial gains.
> > > >
> > > > > There's a small gain here:
> > > >
> > > > > > > paralleldd
> > > > > > >                                     4.4.0
4.4.0
> > > > > > >                                   vanilla
avoidlock
> > > > > > > Amean    Elapsd-1          5.28 (  0.00%)        5.15 (
  2.50%)
> > > > > > > Amean    Elapsd-4          5.29 (  0.00%)        5.17 (
  2.12%)
> > > > > > > Amean    Elapsd-7          5.28 (  0.00%)        5.18 (
  1.78%)
> > > > > > > Amean    Elapsd-12         5.20 (  0.00%)        5.33 (
-2.50%)
> > > > > > > Amean    Elapsd-21         5.14 (  0.00%)        5.21 (
-1.41%)
> > > > > > > Amean    Elapsd-30         5.30 (  0.00%)        5.12 (
  3.38%)
> > > > > > > Amean    Elapsd-48         5.78 (  0.00%)        5.42 (
  6.21%)
> > > > > > > Amean    Elapsd-79         6.78 (  0.00%)        6.62 (
  2.46%)
> > > > > > > Amean    Elapsd-110        9.09 (  0.00%)        8.99 (
  1.15%)
> > > > > > > Amean    Elapsd-128       10.60 (  0.00%)       10.43 (
  1.66%)
> > > > > > >
> > > > > > > The impact is small but intuitively, it makes sense to avoid
> > > > unnecessary
> > > > > > > calls to lock_page.
> > > >
> > > > > Yes, it's small, but it's marked in the SLES kernel as "needs to
be
> > > > > merged into stable", so obviously it matters to someone :)
> > > >
> > > > Hmm. I had the same reaction to these two as Jan, but assumed that
they
> > > > made applying later patches easier, and didn't take the trouble he
did
> > to
> > > > find that's not so.
> > > >
> > > > I've no wish to be disputatious, but it does seem that the
definition of
> > > > "stable" has changed, and not necessarily for the better, if it's
now a
> > > > home for small gains: I thought we left those to upstream.
> >
> > > This is in the SLES kernel for a reason, and again, it's in the
section
> > > that says "this should be pushed to stable".  So if it's good enough
for
> > > the SLES kernel, why isn't it good enough for all users of this kernel
> > > tree?
> >
> > > If you all think it should be dropped in both places, that's fine with
> > > me :)
> >
> > I think they are perfectly fine in SLES: folding in good work is a part
of
> > what distros are about.

> And it's also what stable is for.  We have had backports of performance
> improvements in the past, along with lots of other things over the
> years.  This is a performance improvement.  A tiny one, yes, but getting
> rid of a lock is a good thing, and I picked it up as part of my review
> of what a distro decided was worth adding for their users, as that's a
> huge signal that might be of value to others.

> > But I cannot find anything in stable-kernel-rules.rst that would admit
them
> > - perhaps that's just out of date?

> Nope, that's the list I use to say "no" to.  You can't describe
> everything in that file, it's a judgement call.

> > If -stable is to be a compendium of "this looks nice, you might like to
> > include it", so be it: but the rules should then be updated.

> This is a "a bunch of people I trust took it in their kernel, and it's
> been running on zillion of machines for a while and causes no harm and a
> slight benefit, so let's add it!" type of thing.  It's not the only
> patch in this series that was like that, but for some reason this one is
> the one the triggered the debate, which is funny to me as this does have
> numbers in it showing that it is an improvement :)

Thank you for looking after the -stable trees: please let me not waste your
time any further. I have no specific objection to the two patches, which
are certainly not egregious offenders. But I do still find the disconnect
between stable-kernel-rules.rst and reality confusing - or perhaps I just
find reality confusing :)

Hugh
