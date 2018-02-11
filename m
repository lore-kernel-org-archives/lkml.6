Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518334127; cv=none;
        d=google.com; s=arc-20160816;
        b=It3p6haOr72hIjj56mEd/VkYpBm4KA8z0ayLSjtX9Mo6pQ/YIyBf8lKc7ykGtMgAqe
         0GEhsh2uIX0iu/cydzOqH9v5lj61cXwcm46SOjlaN9LRQg2p5mjoYBw1AUXEcKWp+RIS
         uU0PcLHtRY7KeJNb9tV5/shEFEwDVxZESYRRjp6l7aQcHBlwz3qbcINjZHlmTnnSQXGr
         ds+yB1bPtpKTQfOeKNUgQR5leCbG5U4KRKII7+GChALLIT3fV7ytr1h2MVkleqfo62Lp
         QPh2+GbaEMSJYtEks3BOFAzxyWr1qnsXC7KZqurtNCwE60UcLE0ZyIXcD3+88S0x3gBq
         e6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=IoAM5Tpxmi7IIN+m95hNQjdCrnhLhxN/hBQc+Oe35h8=;
        b=ehIfwJjEnQmKRYzbrHeSRnzWy/C3bpkJ3+XeDZ1N8R6wyv1KCWuB2jacG+PvOUJ/cl
         y3FNkQABKLKx46xYtZQrKyyeaqDh9qQfCROp2rQQDE9vSezkGUGWktscsj/R6qr+WeQ1
         HI0wPHtdK47HsNJYclGgRzDxaOTvVYihi70yAEzRFktz4pmci7wCJeMFUXHDiX22ViDp
         1xsHYo53gxj6dklltYx9uMSmKEJHh8winrOOwO2jn5QgMV70nmohgeIV5YXHe2fff94S
         qMcohZ35QWhHIXPPC+atTEBSKpJMHXRgOLDbS59dgNABa4bZwJ/eI9bFT3O/Z3JIDi20
         kwDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WEAwQmd4;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WEAwQmd4;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225vr1DRETN1cfjgho3D5r6I6RCH2guQyOqw4TPbR+1BZWwPQngN2QkYtlIA7u/AEIxiLDco991sqX8xqu1eXoo=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator> <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator> <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com> <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Feb 2018 23:28:45 -0800
X-Google-Sender-Auth: w8u3h57pDhQwBZIxM6_BPvvZBNg
Message-ID: <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Kees Cook <keescook@chromium.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592088726221946868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 8:46 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Argh. I wanted to get rid of all that entirely, and simplify this all.
> The mentioned script (and bugzilla) was from 2006, I assumed this was
> all historical.
>
> But if it has broken again since, I guess we need to have a silly script. Grr.

Ok, so this really ended up bothering me.

I was hoping to really just unify all the stupid compiler flag testing
in just the Kconfig files and hoping we could really just use

    config CC_xyz
        bool
        option cc_option "-fwhatever-xyz"

to set them, and then build Kconfig rules from that:

    config USE_xyz
        bool "Some question that needs xyz"
        depends on CC_xyz

and have a nice simple

    ccflags-$(CONFIG_USE_xyz) += -fwhataver-xyz

in the Makefiles.

And one thought I had was "hey, if we need a script for
-fstack-protector, maybe we can simply standardize on _everything_
using a script".

But doing the stats, we test about two _hundred_  different compiler
options, and it really looks like -fstack-protector is the _only_ one
that uses a dedicated script. Everything else is just using the "see
if the compiler accepts the flag". So no, we wouldn't want to
standardize around a script.

We do have a script for some other build options related to gcc
breakage, but not command line flags per se: both 'asm goto' and for
gcc version generation. And gcc plugin compatibility checking.

Oh well. It looks like we really have to have those nasty exceptions
from the normal rules.

                 Linus
