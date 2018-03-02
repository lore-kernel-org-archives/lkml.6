Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519953609; cv=none;
        d=google.com; s=arc-20160816;
        b=RJ4V54KvHT/hohL484JZMK08kbh+fmwGa3ORlxsQ4DXmovVEMVT0x2vtuJpmTG7EWo
         gSvlkh3L9RJemfkKUqwXON9xUe++tJ9kjZLVUrybiJY25c9b54p15LWZAgMOpRe4j61C
         YQBgF9xwQRTeM/gGOpJ9dKTEJh37QjvoX6DyA129EAbxiSjLIngZYmmwu0QW29w7po9I
         1TZdzquRTKld0i3QH24OYVeozKcTb5pOn2KTFWLCyeFoB6AslQ+lrLVNNr0lt3WCUKhZ
         wPadYSdn5SWqBlexHXcuvPwu9zcLqEyNqNqUrcCqOSPf4vrnJil5+rHbWEonl6caK2aK
         bZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=elc8RoXzCFpTllYCJh0CWulJX8H585ENSRSit7X1vw4=;
        b=Uwn8FogXZCOszmjUSTzYm+y35xb5QHvo1sAfF/izVqodUB4jySCNJZHFWmxXmcBpwl
         MK09KZ51RhFP9wYgTvZwAV9X74u7jExPTY6QKNcIvjANiA0/OubL8T6re/f3g3l7b7tq
         1j3kkc77y1BG/+NqAQ7Rfk9WTtfvLGP/pMqib8jnVq7uu2NGUIYHOoaeqmQi5aQdVhAu
         Rp3ibOwkwGO0fzauvRdx8vHkshUEHdK30HG3h6V6l/L8e05/7aj6HEk0c3kAcnyq7sox
         SlKdRKWHRMfh7nylkXJWqXAO7lZxpLM2eTShVTwYKwPMyjCT6azvOStCF7wVrK4Bk87y
         6K5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=bE3wfN/n;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=bE3wfN/n;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AG47ELuvtXGGoMoRFBX9mF5WwA3zvJx4UzRF9Z5mjyZZtvp0U/wYuGBTDlv7o/VbUGQn2/fPN9LKtyfbBGG+ZQgUlEs=
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1802271243160.19255@pobox.suse.cz>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
 <1519421630-12025-2-git-send-email-joe.lawrence@redhat.com>
 <CAOFm3uF8HT=5gRG_AvvZwHnVDgrV1HxByG+Gxaqc+uEFYFnFxw@mail.gmail.com> <alpine.LSU.2.21.1802271243160.19255@pobox.suse.cz>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 1 Mar 2018 17:19:28 -0800
Message-ID: <CAOFm3uEJAY4T7yRxmbXBuTXa-x5LokLVe+-66tZJF6kHLYyKQA@mail.gmail.com>
Subject: Re: [PATCH v0 1/3] livepatch: add sample cumulative patch
To: Miroslav Benes <mbenes@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Petr Mladek <pmladek@suse.com>, Jason Baron <jbaron@akamai.com>,
	Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1593786875560764765?=
X-GMAIL-MSGID: =?utf-8?q?1593786875560764765?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Miroslav,

On Tue, Feb 27, 2018 at 3:54 AM, Miroslav Benes <mbenes@suse.cz> wrote:
> On Sat, 24 Feb 2018, Philippe Ombredanne wrote:
>
>> Joe,
>>
>> On Fri, Feb 23, 2018 at 1:33 PM, Joe Lawrence <joe.lawrence@redhat.com> wrote:
>> > Add a simple atomic replace / cumulative livepatch example.
>> >
>> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>> > ---
>> >  samples/livepatch/Makefile               |   1 +
>> >  samples/livepatch/livepatch-cumulative.c | 216 +++++++++++++++++++++++++++++++
>> >  2 files changed, 217 insertions(+)
>> >  create mode 100644 samples/livepatch/livepatch-cumulative.c
>> >
>> > diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
>> > index 2472ce39a18d..dd0e2a8af1af 100644
>> > --- a/samples/livepatch/Makefile
>> > +++ b/samples/livepatch/Makefile
>> > @@ -5,3 +5,4 @@ obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix2.o
>> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-demo.o
>> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-mod.o
>> >  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-busymod.o
>> > +obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-cumulative.o
>> > diff --git a/samples/livepatch/livepatch-cumulative.c b/samples/livepatch/livepatch-cumulative.c
>> > new file mode 100644
>> > index 000000000000..ab036439e08c
>> > --- /dev/null
>> > +++ b/samples/livepatch/livepatch-cumulative.c
>> > @@ -0,0 +1,216 @@
>> > +/*
>> > + * Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
>> > + *
>> > + * This program is free software; you can redistribute it and/or
>> > + * modify it under the terms of the GNU General Public License
>> > + * as published by the Free Software Foundation; either version 2
>> > + * of the License, or (at your option) any later version.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU General Public License
>> > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> > + */
>>
>> May be you could use the new SPDX tags instead of this fine but long
>> legalese? [1]
>> This would replace ~12 lines of comment by a single line with the same effect.
>> Thanks!
>
> I don't know about that. How come it is perceived as equivalent? I mean,
> we have a well-established way how to say that a particular source
> code/file is distributed with GPL license. Well-established means that
> it's been tested in court AFAIK many times. Even the license itself (found
> in COPYING file) mentions this as way how to attach the license to a file.
>
> Now you want it to be replaced with a tag. Does it say the same? It might.
> It might not. Do we know? Have you got a court ruling which would say that
> this is also a way how to attach a license to a file? I doubt it. It may
> seem trivially clear, but there are no such things in the legal world.
>
> Don't make me wrong. I don't like that copyright thingie much. I don't
> like that you can find even different versions of the text in the kernel
> source code (and not only there).
>
> However I'd prefer to leave at least a note there that the file is still
> distributed under the terms of GPL found in COPYING file. The tag can be
> there too, if it makes someone happy.
>
> Regards,
> Miroslav
>
>> [1]  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
>> --
>> Philippe
>>
>

To the best of my knowledge, this has been debated in person and on
list among maintainers and agreed to.
This has also been reviewed by the LF lawyers. The result of is the
documentation in [1]
You are welcomed not to agree of course, but this would make your
contributions stand out with its legalese boilerplate when we are
trying to get of it.

Greg, anything else to add?

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-- 
Cordially
Philippe Ombredanne
