Return-Path: <kernel-hardening-return-12396-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELswObyJTI5pJPCnj+9FDxz2fPU+Ew1ah1vmYfljH+hSsQHb7qQ6lNdXzwF3tYDAAFpsLpaN
ARC-Seal: i=1; a=rsa-sha256; t=1520792631; cv=none;
        d=google.com; s=arc-20160816;
        b=nowGrf30r3W1DhB/JQ7SmofN8FyOp8jm/Ug/S8EZkNLxpUcaR0BmeGR6RjI3l2fKDs
         aAhJhUqxFBtBgxUl4cq07WcPpg5tVfFJjkEDCQ+AEApWsYbsuIUHXpM+miE0gce7IF+D
         Gfb6/Sm0PCh2ZIjU+vMYamUbyUXPczjo3rhW2ja7WUeyjE0x8fmxGbWFUQGjMLtwW+VJ
         OfKTBp590r/dVvtZ7x5ViODCaGiez+ogObmSkM6ihK48vzKYtheUP7mOR1yoeFvEddz4
         zsYXADaZ7vhYc3aPr9GjT78rzWgg4ATXdtNo4+Amlb22t6ywQ+Fm5UOTmqc5i75rLC/t
         trXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=mclZKkYMJRLwiVTTAPEs4yMRaPLfHSZla5rPHLX/5d0=;
        b=qXuE5HrcDf7nhicTBZV7VXWHsIRAjeCsD243AB5hXjeuTVEJQuUvfqvL/o53Logk7L
         /QfKKpV8cJShIZqw1LUBhkMaHj5iXsnJkmt8rPQT5DLaWHEAiNUP0+tLLFBOK/kVuNay
         Vt0fHex3fKKfCE9qLZZTXWu014njIWV9Uai8JiaiGU7c0KAOFUBPcNIaCwskPbQ5ugGO
         z75wv51pcEbq8jpAWy0TNV1X2F+vKH/qzE1EP4Kg7n3cbtIDjuP13LyvbEJUBAsIOP3+
         euSiZNNDNkDUII8nE+3XnehRHdZeozCdfg56rfktDaKz4yPJ+rbOQYou027nxLfn7tSZ
         NPXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aRTALX1D;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=ML0sZqq2;
       spf=pass (google.com: domain of kernel-hardening-return-12396-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12396-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aRTALX1D;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=ML0sZqq2;
       spf=pass (google.com: domain of kernel-hardening-return-12396-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12396-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180311110543.pgcnrafloj5qbdjm@gmail.com>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <e8874944-f0b7-7a1f-26f3-446d7d7fcc38@infradead.org> <CANiq72k_vsTPMXvcfTNo+sjRoVMkihvRz-fzeXdcXvNEEeY-Pw@mail.gmail.com>
 <CAGXu5jLtKAUsoYemHZTrJqKEH9=BqwO_QXk=x3BPfCKqZ6DRYA@mail.gmail.com>
 <CA+55aFyLicYSe+R4yQ2Eu+P9m6qsRfso-HiK78Sw+-dPuZvAYg@mail.gmail.com>
 <CANiq72nwg3mMhWeE_bLKdQ5WP+0E+SxxvcuUF=Rn9a1MM+EapQ@mail.gmail.com>
 <CA+55aFw+guiiJ3OavrP-RpFV9NRAF4t=oj3-GDfSyuZ9zBRfdg@mail.gmail.com> <20180311110543.pgcnrafloj5qbdjm@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Mar 2018 11:23:29 -0700
X-Google-Sender-Auth: 4ElfKIMqYxqzZXIV_vhAbBidnpk
Message-ID: <CA+55aFykPUaZUjxf9qkWN-QhTH_fK=R4bXHBb-iKT1EaEh87uQ@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Ingo Molnar <mingo@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Masahiro Yamada <yamada.masahiro@socionext.com>,
	Borislav Petkov <bp@suse.de>, Ian Abbott <abbotti@mev.co.uk>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594666654874712618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 4:05 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> BTW., while I fully agree with everything you said, it's not entirely correct to
> claim that if a C compiler can generate VLA code it is necessarily able to parse
> and evaluate constant array sizes "just fine".
>
> Constant expressions are typically parsed very early on, at the preprocessing
> stage. They can be used with some preprocessor directives as well, such as '#if'
> (with some further limitations on their syntax).

Yes. But constant simplification and CSE etc is just a very
fundamental part of a compiler, and anybody who actually implements
VLA's would have to do it anyway.

So no, a message like

  warning: Array declaration is not a C90 constant expression,
resulting in VLA code generation

would be moronic. Only some completely mindless broken shit would do
"oh, it's not a parse-time constant, so it will be variable". The two
just do not follow AT ALL.

So the message might be about _possibly_ resulting in VLA code
generation, but honestly, at that point you should just add the
warning when you actually generate the code to do the stack
allocation.

Because at that point, you know whether it's variable or not.

And trust me, it won't be variable for things like (2,3), or even for
our "max()" thing with other odd builtins. Not unless the compiler
doesn't really support VLA at all (maybe some bolted-on crazy thing
that just turns a VLA at the front-end time into just an alloca), or
the user has explicitly asked to disable some fundamental optimization
phase.

               Linus
