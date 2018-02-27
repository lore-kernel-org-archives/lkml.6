Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeB0LyU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:54:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:46694 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752141AbeB0LyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:54:18 -0500
Date: Tue, 27 Feb 2018 12:54:15 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Philippe Ombredanne <pombredanne@nexb.com>
cc: Joe Lawrence <joe.lawrence@redhat.com>, live-patching@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: Re: [PATCH v0 1/3] livepatch: add sample cumulative patch
In-Reply-To: <CAOFm3uF8HT=5gRG_AvvZwHnVDgrV1HxByG+Gxaqc+uEFYFnFxw@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.1802271243160.19255@pobox.suse.cz>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com> <1519421630-12025-2-git-send-email-joe.lawrence@redhat.com> <CAOFm3uF8HT=5gRG_AvvZwHnVDgrV1HxByG+Gxaqc+uEFYFnFxw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Feb 2018, Philippe Ombredanne wrote:

> Joe,
> 
> On Fri, Feb 23, 2018 at 1:33 PM, Joe Lawrence <joe.lawrence@redhat.com> wrote:
> > Add a simple atomic replace / cumulative livepatch example.
> >
> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> > ---
> >  samples/livepatch/Makefile               |   1 +
> >  samples/livepatch/livepatch-cumulative.c | 216 +++++++++++++++++++++++++++++++
> >  2 files changed, 217 insertions(+)
> >  create mode 100644 samples/livepatch/livepatch-cumulative.c
> >
> > diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
> > index 2472ce39a18d..dd0e2a8af1af 100644
> > --- a/samples/livepatch/Makefile
> > +++ b/samples/livepatch/Makefile
> > @@ -5,3 +5,4 @@ obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix2.o
> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-demo.o
> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-mod.o
> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-busymod.o
> > +obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-cumulative.o
> > diff --git a/samples/livepatch/livepatch-cumulative.c b/samples/livepatch/livepatch-cumulative.c
> > new file mode 100644
> > index 000000000000..ab036439e08c
> > --- /dev/null
> > +++ b/samples/livepatch/livepatch-cumulative.c
> > @@ -0,0 +1,216 @@
> > +/*
> > + * Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version 2
> > + * of the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> 
> May be you could use the new SPDX tags instead of this fine but long
> legalese? [1]
> This would replace ~12 lines of comment by a single line with the same effect.
> Thanks!

I don't know about that. How come it is perceived as equivalent? I mean, 
we have a well-established way how to say that a particular source 
code/file is distributed with GPL license. Well-established means that 
it's been tested in court AFAIK many times. Even the license itself (found 
in COPYING file) mentions this as way how to attach the license to a file.

Now you want it to be replaced with a tag. Does it say the same? It might. 
It might not. Do we know? Have you got a court ruling which would say that 
this is also a way how to attach a license to a file? I doubt it. It may 
seem trivially clear, but there are no such things in the legal world.

Don't make me wrong. I don't like that copyright thingie much. I don't 
like that you can find even different versions of the text in the kernel 
source code (and not only there).

However I'd prefer to leave at least a note there that the file is still 
distributed under the terms of GPL found in COPYING file. The tag can be 
there too, if it makes someone happy.

Regards,
Miroslav

> [1]  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
> --
> Philippe
> 
