Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDPQKo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:10:44 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:50214 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbeDPQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:10:42 -0400
Date: Mon, 16 Apr 2018 18:10:41 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.17-rc1
Message-ID: <20180416161041.GA23075@isilmar-4.linta.de>
References: <CA+55aFx62iBkj+hOmhLksUtvjwTcm_o1dwcyvaNnVpJ-AmvzVQ@mail.gmail.com>
 <CAMuHMdUQyiY6cPqYViHtgEX1rnBmSbrmQOivtCmSAO_b3ci5Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUQyiY6cPqYViHtgEX1rnBmSbrmQOivtCmSAO_b3ci5Uw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 11:01:57AM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 16, 2018 at 3:55 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > We actually have a fair amount of other removal and cleanups too. I
> > was somewhat pleasantly surprised by the number of pull requests that
> > actually ended up removing a lot of lines. Some of it was staging
> > drivers that finally gave up the ghost (like irda), but we also got
> > rid of some copyright language boiler-plate in favor of just the spdx
> > lines. And some pre-shipped lexer/parser files are no more, we're
> > better off just generating them.
> >
> > End result: we actually removed more lines than we added:
> >
> >  13538 files changed, 627723 insertions(+), 818855 deletions(-)
> >
> > which is probably a first. Ever. In the history of the universe. Or at
> > least kernel releases.
> >
> > I'd call it momentous, but I think the arch removal was most of it,
> > and I'm sure people will quickly rectify that momentary glitch of
> > actually shrinking the kernel source code.
> 
> For the first time ever(?), we also had a kernel size reduction, according
> to bloat-o-meter (for an m68k atari_defconfig kernel):
> 
>     add/remove: 341/440 grow/shrink: 445/359 up/down: 60125/-133422 (-73297)
> 
> which brings us (size-wise) back to v4.13-and-a-half.
> This is mostly attributed to the removal of lots of SyS_* functions.

Please note that the SyS_* stubs were renamed to __se_sys_* () [__se for
sign-extending], which bloat-o-meter does not handle well.

Thanks,
	Dominik
