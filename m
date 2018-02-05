Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeBEUQG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:16:06 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52663 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751015AbeBEUQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:16:00 -0500
X-ME-Sender: <xms:f7t4WqJ_do3vmnEB3cG-MikEJK5xQl3LkEnvcb3VyxW6QN05c4wEwQ>
Date: Tue, 6 Feb 2018 07:15:55 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Kees Cook <keescook@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>, Adam Borowski <kilobyte@angband.pl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
Message-ID: <20180205201555.GQ29988@eros>
References: <20180204174521.21383-1-kilobyte@angband.pl>
 <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
 <CAGXu5j+rWhT7_DH5Z96_7naPou96-6736x4mjq0r_8EG4iiQ_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+rWhT7_DH5Z96_7naPou96-6736x4mjq0r_8EG4iiQ_g@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 05:57:17AM +1100, Kees Cook wrote:
> On Mon, Feb 5, 2018 at 8:44 PM, Petr Mladek <pmladek@suse.com> wrote:
> > Hi,
> >
> > I add people who actively commented on adding %px modifier,
> > see the thread starting at
> > https://lkml.kernel.org/r/1511921105-3647-5-git-send-email-me@tobin.cc
> >
> > Just for reference. It seems to be related to the commit 9f36e2c448007b54
> > ("printk: use %pK for /proc/kallsyms and /proc/modules").
> >
> >
> > On Sun 2018-02-04 18:45:21, Adam Borowski wrote:
> >> Like %pK already does, print "00000000" instead.
> >>
> >> This confused people -- the convention is that "(null)" means you tried to
> >> dereference a null pointer as opposed to printing the address.
> >
> > By other words, this avoids regressions when people convert
> > %x to %px. Do I get it right, please?
> 
> Nothing should be converting from %x to %px, it's %p to %px. %p print
> "(null)" for 0x0, so it would be surprising for a conversion from %p
> to %px to change that. (Though generally speaking "(null)" is never
> useful...)

Leaving aside what is converting to %px.  If we consider that using %px
is meant to convey to us that we _really_ want the address, in hex hence
the 'x', then it is not surprising that we will get "00000000"'s for a
null pointer, right?  Yes it is different to before but since we are
changing the specifier does this not imply that there may be some
change?

In what is now to be expected fashion for %p the discussion appears to
have split into two different things - what to do with %px and what to
do with %pK :)

thanks,
Tobin.
