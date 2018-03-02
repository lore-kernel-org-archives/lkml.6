Return-Path: <mbenes@suse.cz>
X-Google-Smtp-Source: AG47ELuuScfON1aZiinCWilOYBwLfwsFYT4Ij+MjpxYW6hPQtDhvh9/eEbHMXbRM1DNnxBgu79mD
ARC-Seal: i=1; a=rsa-sha256; t=1519981872; cv=none;
        d=google.com; s=arc-20160816;
        b=VMh1jDMca1ZuACbyKeO1Xe0T2l2GgcMpnrPWFkkj8y/bH/9QopqfWnOYzbwuJIQrvp
         BGxbVQYE/Vb667I7+G26/VxkVg/kpqnZd1ZH4DxTUZWRHRg16QQhN1NcLodfITfMEkVg
         NNDfTWbrUe2GfrryiQEsSsu5lBtDHdHZ/AC4dKTd22Zi7ZIy8xcssd9lqbu5CcBx97fN
         7UXyz5p48YCUyYA/2CftGiZNZBdAZ2TVP+7WDOjQD63Wa2aLIW/lXg9YwQJtHnuyAE6T
         P/jkbhP5vP6PsTlG8qjqc8PS8Sy2creSHNSydxZEE/8LzF/UQoqZFpqx26BVhLYPwiwC
         U44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=DLwjYMdEjpqNXWCOwi6+gyjieXOanXWHMi8c5aGpGdk=;
        b=ZL2IrPg5NZ2Hv88uXSplYmNZltzqEbvdZ+j+2eVXRm5HKVuUwF7/GV4A/agIHeXKM1
         nm8GQMYqpOOL2fMrb9Pyf/qaayHAc1UGE6AUPC8RPJlxTfpZiEp7XV3IiWtOJt5/nr6t
         SQTWbR+U3WTc4UkN88p04Mp6zXdwKygIeUXc0QW0QJbZPHdUAxKwKS7Elb/VrCj4MGS5
         W+GGU0v+0vfTDqoW1J71w8Il4rZpBlYdXI/OiZmUqecC9t4xN+EojaRxkz5/yrYdO7eu
         D6kBSf/0P4Xbig/kOyk4S5YA5bBKOZQgRdyqiVYzxridRdYss6QfnbCB+cF4ReQWvkAI
         GOQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mbenes@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=mbenes@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mbenes@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=mbenes@suse.cz
Date: Fri, 2 Mar 2018 10:11:05 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Philippe Ombredanne <pombredanne@nexb.com>,
    Joe Lawrence <joe.lawrence@redhat.com>, live-patching@vger.kernel.org,
    LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
    Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
    Petr Mladek <pmladek@suse.com>, Jason Baron <jbaron@akamai.com>,
    Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: Re: [PATCH v0 1/3] livepatch: add sample cumulative patch
In-Reply-To: <20180302083132.GA9636@kroah.com>
Message-ID: <alpine.LSU.2.21.1803021008590.18384@pobox.suse.cz>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com> <1519421630-12025-2-git-send-email-joe.lawrence@redhat.com> <CAOFm3uF8HT=5gRG_AvvZwHnVDgrV1HxByG+Gxaqc+uEFYFnFxw@mail.gmail.com> <alpine.LSU.2.21.1802271243160.19255@pobox.suse.cz>
 <CAOFm3uEJAY4T7yRxmbXBuTXa-x5LokLVe+-66tZJF6kHLYyKQA@mail.gmail.com> <20180302083132.GA9636@kroah.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1593786875560764765?=
X-GMAIL-MSGID: =?utf-8?q?1593816511300329872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Mar 2018, Greg Kroah-Hartman wrote:

> On Thu, Mar 01, 2018 at 05:19:28PM -0800, Philippe Ombredanne wrote:
> > Miroslav,
> > 
> > On Tue, Feb 27, 2018 at 3:54 AM, Miroslav Benes <mbenes@suse.cz> wrote:
> > > On Sat, 24 Feb 2018, Philippe Ombredanne wrote:
> > >
> > >> Joe,
> > >>
> > >> On Fri, Feb 23, 2018 at 1:33 PM, Joe Lawrence <joe.lawrence@redhat.com> wrote:
> > >> > Add a simple atomic replace / cumulative livepatch example.
> > >> >
> > >> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> > >> > ---
> > >> >  samples/livepatch/Makefile               |   1 +
> > >> >  samples/livepatch/livepatch-cumulative.c | 216 +++++++++++++++++++++++++++++++
> > >> >  2 files changed, 217 insertions(+)
> > >> >  create mode 100644 samples/livepatch/livepatch-cumulative.c
> > >> >
> > >> > diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
> > >> > index 2472ce39a18d..dd0e2a8af1af 100644
> > >> > --- a/samples/livepatch/Makefile
> > >> > +++ b/samples/livepatch/Makefile
> > >> > @@ -5,3 +5,4 @@ obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix2.o
> > >> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-demo.o
> > >> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-mod.o
> > >> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-busymod.o
> > >> > +obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-cumulative.o
> > >> > diff --git a/samples/livepatch/livepatch-cumulative.c b/samples/livepatch/livepatch-cumulative.c
> > >> > new file mode 100644
> > >> > index 000000000000..ab036439e08c
> > >> > --- /dev/null
> > >> > +++ b/samples/livepatch/livepatch-cumulative.c
> > >> > @@ -0,0 +1,216 @@
> > >> > +/*
> > >> > + * Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> > >> > + *
> > >> > + * This program is free software; you can redistribute it and/or
> > >> > + * modify it under the terms of the GNU General Public License
> > >> > + * as published by the Free Software Foundation; either version 2
> > >> > + * of the License, or (at your option) any later version.
> > >> > + *
> > >> > + * This program is distributed in the hope that it will be useful,
> > >> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > >> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > >> > + * GNU General Public License for more details.
> > >> > + *
> > >> > + * You should have received a copy of the GNU General Public License
> > >> > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> > >> > + */
> > >>
> > >> May be you could use the new SPDX tags instead of this fine but long
> > >> legalese? [1]
> > >> This would replace ~12 lines of comment by a single line with the same effect.
> > >> Thanks!
> > >
> > > I don't know about that. How come it is perceived as equivalent? I mean,
> > > we have a well-established way how to say that a particular source
> > > code/file is distributed with GPL license. Well-established means that
> > > it's been tested in court AFAIK many times. Even the license itself (found
> > > in COPYING file) mentions this as way how to attach the license to a file.
> > >
> > > Now you want it to be replaced with a tag. Does it say the same? It might.
> > > It might not. Do we know? Have you got a court ruling which would say that
> > > this is also a way how to attach a license to a file? I doubt it. It may
> > > seem trivially clear, but there are no such things in the legal world.
> > >
> > > Don't make me wrong. I don't like that copyright thingie much. I don't
> > > like that you can find even different versions of the text in the kernel
> > > source code (and not only there).
> > >
> > > However I'd prefer to leave at least a note there that the file is still
> > > distributed under the terms of GPL found in COPYING file. The tag can be
> > > there too, if it makes someone happy.
> > >
> > > Regards,
> > > Miroslav
> > >
> > >> [1]  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
> > >> --
> > >> Philippe
> > >>
> > >
> > 
> > To the best of my knowledge, this has been debated in person and on
> > list among maintainers and agreed to.
> > This has also been reviewed by the LF lawyers. The result of is the
> > documentation in [1]
> > You are welcomed not to agree of course, but this would make your
> > contributions stand out with its legalese boilerplate when we are
> > trying to get of it.
> > 
> > Greg, anything else to add?
> 
> Yes, do not add new "boiler plate" license code in new files, otherwise
> you will just have to rip them out again later on.  If you have
> questions about this, please contact your company's lawyers, as they
> know all about this issue and last I heard, agreed with it.

I certainly will. Thanks.

Miroslav
