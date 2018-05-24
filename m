Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2289356-1527182911-2-15433663767833987257
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
    1527182910; b=nUamQlC9uV4aAI3kml7mdPOqQoV11VOORXQvmrTWLwvccuMzqM
    jA+CMIsZHHhFJpn3LOCEoBuqTHYYe6Lq3FIid5FcsEeHxv1JV3d7MmI4pVN68Iiw
    KYyyUfCtlDmXV4nt96EEmoXvCvN/QwCUA3jqXa1ENG+IgoiclE3qYM0VVRWwriGO
    OCSBGn9e2oKjSYV/dHt0tO0ay17gLIpph6OUlSTeVVurB5rrdeQ5jWkGZ5l9RNGa
    WB8umHv/SecK0zFym/BCqaUlIO4Tw2FylDPYU4T876BL3lNBDy48o4krMmwoSOGk
    tD3tW6d54o6lnB8kF2oy4yTUTvHJ2X4OfNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527182910; bh=XXNMwNh6nXwZtxzd1ikKBo5st23P7xGSkr/EOG3ZQi
    s=; b=JNi/0PKzrlZ3El+4mberp+eteZ1+nvuiobXOOOxnlwa2kD3f3YM87sjf/c
    +bOvLzu4GGr9yrcULmI23cDsOmvFH5rdwwm8I/ZPS8ITNvmHUFwmCWN1MvCa2Wwj
    juF+7yqP3T12sZZQ7TgG1N9F6XKtM3m77aHTr+BKkVC8kj1kfV+rriiuwBL5HYZq
    Y0UqMYzx5wq7/J2vrqyUJt6vIKbE1iAosuP5+zcUFQ1j8dJbaqmLRX5XD93gVv6B
    RjxomSA+a1lH9RT9WnhkLtzHYSi9wrY+yydzpIdHr3rkCczXfS0DQ5DVnHKc76h3
    K5IikffuZbOHLtNmGPe174yqpPXA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=BK9HFd0Q x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=FH4ZpI6F;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=BK9HFd0Q x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=FH4ZpI6F;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDMHVEBEm/IL0UeIGB6M0tXk0N9ngw92Z/5w4cXlYrR0UF1luzEzseLXiq7RtVBOH4CuUjjfYOqpKGqlYYSMp2j0GA9STUkW4Ct0dL6/L7KN2iTNKRrU
    DsaMKIU3sWDecGUmsxqtIK38v2wexUVO5rn8f4boM+kqijh+H0TM03pACU6gM3iDrDdDeDquUPOgiHF5cyWBw3jEzWVeSy/8zJSTHCTka4bOuqzfueMVVxvt
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=HsS3USe5Hb7EVSU5-J8A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031985AbeEXR23 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 13:28:29 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55236 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031011AbeEXR22 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 13:28:28 -0400
X-Google-Smtp-Source: AB8JxZrhUF18BXrsCXITEaW32CIAAL95AmSep2GrKHciruo9AuIpTfwgcb4Tk1bkpFRMyh1MYlBPDVQq4VA0laqnieA=
MIME-Version: 1.0
References: <20180524093159.286472249@linuxfoundation.org> <20180524093204.290399449@linuxfoundation.org>
 <20180524105011.jkmjrmoyqtogtgnn@quack2.suse.cz> <20180524110546.GA16171@kroah.com>
 <CANsGZ6bsz-J9XB_O5+B+mmRV2CGaJ8e+Aa=N3WnE7YNARWsAnw@mail.gmail.com> <20180524112841.GA17626@kroah.com>
In-Reply-To: <20180524112841.GA17626@kroah.com>
From: Hugh Dickins <hughd@google.com>
Date: Thu, 24 May 2018 10:27:59 -0700
Message-ID: <CANsGZ6anzAW3dcEQqgfRGxnk+n4ih_PpKOCGdcHv_SF86x2-0g@mail.gmail.com>
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

On Thu, May 24, 2018 at 4:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, May 24, 2018 at 04:17:12AM -0700, Hugh Dickins wrote:
> >   Thu, May 24, 2018 at 4:06 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>
> > wrote:
> >
> > > On Thu, May 24, 2018 at 12:50:11PM +0200, Jan Kara wrote:
> > > > On Thu 24-05-18 11:38:27, Greg Kroah-Hartman wrote:
> > > > > 4.4-stable review patch.  If anyone has any objections, please
let me
> > know.
> > > >
> > > > Just one objection: Why does stable care about this (and the
previous
> > > > patch)? I've checked the stable queue and I don't see anything that
> > would
> > > > have these patches as a prerequisite. And on their own, they are
only
> > > > cleanups without substantial gains.
> >
> > > There's a small gain here:
> >
> > > > > paralleldd
> > > > >                                     4.4.0                 4.4.0
> > > > >                                   vanilla             avoidlock
> > > > > Amean    Elapsd-1          5.28 (  0.00%)        5.15 (  2.50%)
> > > > > Amean    Elapsd-4          5.29 (  0.00%)        5.17 (  2.12%)
> > > > > Amean    Elapsd-7          5.28 (  0.00%)        5.18 (  1.78%)
> > > > > Amean    Elapsd-12         5.20 (  0.00%)        5.33 ( -2.50%)
> > > > > Amean    Elapsd-21         5.14 (  0.00%)        5.21 ( -1.41%)
> > > > > Amean    Elapsd-30         5.30 (  0.00%)        5.12 (  3.38%)
> > > > > Amean    Elapsd-48         5.78 (  0.00%)        5.42 (  6.21%)
> > > > > Amean    Elapsd-79         6.78 (  0.00%)        6.62 (  2.46%)
> > > > > Amean    Elapsd-110        9.09 (  0.00%)        8.99 (  1.15%)
> > > > > Amean    Elapsd-128       10.60 (  0.00%)       10.43 (  1.66%)
> > > > >
> > > > > The impact is small but intuitively, it makes sense to avoid
> > unnecessary
> > > > > calls to lock_page.
> >
> > > Yes, it's small, but it's marked in the SLES kernel as "needs to be
> > > merged into stable", so obviously it matters to someone :)
> >
> > Hmm. I had the same reaction to these two as Jan, but assumed that they
> > made applying later patches easier, and didn't take the trouble he did
to
> > find that's not so.
> >
> > I've no wish to be disputatious, but it does seem that the definition of
> > "stable" has changed, and not necessarily for the better, if it's now a
> > home for small gains: I thought we left those to upstream.

> This is in the SLES kernel for a reason, and again, it's in the section
> that says "this should be pushed to stable".  So if it's good enough for
> the SLES kernel, why isn't it good enough for all users of this kernel
> tree?

> If you all think it should be dropped in both places, that's fine with
> me :)

I think they are perfectly fine in SLES: folding in good work is a part of
what distros are about.

But I cannot find anything in stable-kernel-rules.rst that would admit them
- perhaps that's just out of date?

If -stable is to be a compendium of "this looks nice, you might like to
include it", so be it: but the rules should then be updated.

Hugh
