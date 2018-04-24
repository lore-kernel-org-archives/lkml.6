Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932603AbeDXLiw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:38:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43910 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932497AbeDXLit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:38:49 -0400
Date: Tue, 24 Apr 2018 13:38:37 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>, Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m68k: Fix off-by-one calendar month
Message-ID: <20180424113837.GB19011@piout.net>
References: <5add30d1.1c69fb81.b868a.84f1SMTPIN_ADDED_MISSING@mx.google.com>
 <CAMuHMdULPOWQPo1G1s5m52rNLzhmPFzfwxsZH0iR_OwVc8VRKw@mail.gmail.com>
 <20180424103737.GA19011@piout.net>
 <CAMuHMdVh8Pg9r9OoDzh9fWmkcuS1NDQUBOLzRQkiKXD+V+XbPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVh8Pg9r9OoDzh9fWmkcuS1NDQUBOLzRQkiKXD+V+XbPA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2018 12:51:32+0200, Geert Uytterhoeven wrote:
> > Note that this change may break existing users. I'm perfectly fine with
> > it as doing this is generally wrong anyway and this is something I'd
> > like to see eliminated.
> 
> The year handling is moved into the various mach_hwclk() implementations
> in the same patch (in the "<snip>" part).
> 

Ok.

> >
> >> > -               ts->tv_sec = mktime(time.tm_year, time.tm_mon, time.tm_mday,
> >> > -                                     time.tm_hour, time.tm_min, time.tm_sec);
> >> > -       }
> >> > +       ts->tv_sec = mktime(time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
> >> > +                           time.tm_hour, time.tm_min, time.tm_sec);
> >>
> >> That might explain why my Amiga spends so much time on file system checks
> >> since I wrote the rp5c01 RTC driver...
> 
> Upon closer look, it's not, as Amiga no longer provides mach_hwclk().
> So it must be due to fsck running before the rtc module is loaded?
> 

Quite possibly, an easy way to know is to check the system time beofre
fsck runs.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
