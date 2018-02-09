Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeBIMDS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:03:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:40258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbeBIMDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:03:17 -0500
Date: Fri, 9 Feb 2018 13:03:13 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Adam Borowski <kilobyte@angband.pl>, Kees Cook <keescook@chromium.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
Message-ID: <20180209120313.rckq3s54nr6yyus4@pathway.suse.cz>
References: <20180204174521.21383-1-kilobyte@angband.pl>
 <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
 <CAGXu5j+rWhT7_DH5Z96_7naPou96-6736x4mjq0r_8EG4iiQ_g@mail.gmail.com>
 <20180205201555.GQ29988@eros>
 <CAGXu5j+KSm3rOK46xiYPx8SRaO9T5LaeaXxOA3PSktJv4F__dg@mail.gmail.com>
 <20180205205817.72dy7e7xzjcnwmhs@angband.pl>
 <20180207150328.nuk7f76nutq2trcg@pathway.suse.cz>
 <CAMuHMdVJZnbFrLxBZm1m6C+sR1MKuk3=G4RoYVkAgcxYDHgMGw@mail.gmail.com>
 <20180207154116.xvojw3bzmnmexkav@pathway.suse.cz>
 <CAHp75VeSds86y9+YBebhfVAS-ZOA1yeMXUD2o2du0SkbQjPDAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeSds86y9+YBebhfVAS-ZOA1yeMXUD2o2du0SkbQjPDAw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-02-08 17:29:14, Andy Shevchenko wrote:
> On Wed, Feb 7, 2018 at 5:41 PM, Petr Mladek <pmladek@suse.com> wrote:
> > On Wed 2018-02-07 16:11:13, Geert Uytterhoeven wrote:
> 
> > To make it clear. I was talking about "%p" format that is handled
> > in the pointer() function in lib/vsprintf.c. The "(null)" makes
> > sense only for the many modifiers that do deference of
> > the pointer, e.g. "%pa", "%pE", "%ph".
> 
> JFYI: I have a patch to eliminate those for %pE & %ph.
>
> Google for "lib/vsprintf: Remove useless NULL checks" as a first in
> the series for new extension to print times.

I am slightly confused. IMHO, it makes sense to printk "(null)"
for %pE and %ph.

Or do you just want to avoid the duplicit check in hex_string()
and escaped_string()?

Well, it might be better to discuss this once you send the patch.

> I just need time to address comments and resend the series.

Good to know.

Best Regards,
Petr
