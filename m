Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965511AbeBMTPQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:15:16 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:40596 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965315AbeBMTPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:15:15 -0500
Date: Tue, 13 Feb 2018 20:15:09 +0100
From: Willy Tarreau <w@1wt.eu>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>
Subject: Re: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for
 graphics command
Message-ID: <20180213191509.GB20354@1wt.eu>
References: <20180209235012.4993-1-rabel@robertabel.eu>
 <20180209235012.4993-2-rabel@robertabel.eu>
 <CANiq72ka314rCgPHP4WVt5Rjidz8Rz0s2UtoVX6Bc0gWi=MLSw@mail.gmail.com>
 <20180210092003.GA20377@1wt.eu>
 <CANiq72m6bFYywFa30HhtiAxPP0sK+bWgsxwUhT+b-Sjh0baBCA@mail.gmail.com>
 <CAHp75VfQUNVB9qoxcM5DSWz7Peu40oqtVO6dQse8ASRQa5ufEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfQUNVB9qoxcM5DSWz7Peu40oqtVO6dQse8ASRQa5ufEg@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 03:36:45PM +0200, Andy Shevchenko wrote:
> On Sat, Feb 10, 2018 at 11:41 AM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Sat, Feb 10, 2018 at 10:20 AM, Willy Tarreau <w@1wt.eu> wrote:
> >> On Sat, Feb 10, 2018 at 09:58:44AM +0100, Miguel Ojeda wrote:
> >>> On Sat, Feb 10, 2018 at 12:50 AM, Robert Abel <rabel@robertabel.eu> wrote:
> 
> >>> >                         shift ^= 4;
> >>> >                         if (*esc >= '0' && *esc <= '9') {
> >>> >                                 value |= (*esc - '0') << shift;
> >>> > -                       } else if (*esc >= 'A' && *esc <= 'Z') {
> >>> > +                       } else if (*esc >= 'A' && *esc <= 'F') {
> >>> >                                 value |= (*esc - 'A' + 10) << shift;
> >>> > -                       } else if (*esc >= 'a' && *esc <= 'z') {
> >>> > +                       } else if (*esc >= 'a' && *esc <= 'f') {
> >>>
> >>> Willy, Geert: this seems obvious, but do you know if the broader range
> >>> was intended for some reason?
> >>
> >> No, I think it was simply a brain fart from me 14 years ago, as I can
> >> find it as well in the original 0.9.0 patch for kernel 2.4!
> 
> I understand that we have a huge and hopefully nice library in the
> kernel, but the question still the same, what prevents a developer or
> maintainer to look at it from time to time?

It's always the same, nobody knows that some code appeared somewhere to
solve some problem they already solved a long time ago and that they are
not even aware of anymore. That's why code cleanups like this session are
useful.

> For, I dare to say, ages we have hex_to_bin() and hex2bin().
> Can we use it?

I definitely think so after taking a quick look at hex2bin().

Thanks!
Willy
