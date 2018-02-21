Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519210371; cv=none;
        d=google.com; s=arc-20160816;
        b=xWlzaiRroDKpjFUYXLhJh4bVZf5F4m4mxbG5xhRnNTIL/AZDBa5pObzrso8VjZq2xB
         pF1s+YuuishcOCng4PBtsjTIz48D+sLeChBVGpjj4BHaRLiEg7xmar7rpAU9PxSZBJuI
         g4TeIXvg4LEkKgsBsdQ3PaZ69I2r85ygWWG56QJCKO/KZHJn9SNiHy9MdJ23XZnQad9D
         jXyezs29eg4Gaz3YGfglbHEGLmeU/WEkO98uXH0egLeJnzMWiWuNJzof1D8Knl3zWBpz
         ffags5vNd9lxPQutTTGkrZ6NTPV8rs0vGi4NSlXQKWTApl3vdUY91fO9rh7eZhLJV3HC
         0nWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=cjl2ZJ2I/yx2SyjiiNamM0TFnbSgrz7EYwsTR16eyIY=;
        b=d9/1iMYFZs5S884w91jc2gYQD4IShjaO0ydL3dPnnp43Fdp2ZFRsfRGIZrzrLzwGrJ
         liQpuGIOK348RKsqno8d9KBuzX2JifcsyNzvEGmPH/kNp6nqoQFX8WQGyxXDkfB2QkRn
         bNaebZyMLAqOTNoKC9UJAbK/Lty4JgPVGKqxXIfnW30Gqp0kpeKjnvcYgQ0hktMfzGbf
         hVlXbZpSWkipbOgMZ4zbCBt7/Gg6T31tN4BvQCAV1C4HAGW+V+PsNN3wHpfRfjQTyDSL
         WsLjtKdyfn0YOlSqfqUMTOahKT0nMm3+auCtJjpVYU9Yf45TlE6zkyfKmxCtO2wvr2ur
         lMzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UflopgEp;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UflopgEp;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x225wuxj45hY+Oj3VSSfb2H+Tpl6kopJPdDHKNBXTMB9ogdQQ+Pr6nyvDkp6HaV1aFroGd/u/qZg1AF5cHS2DNEY=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAK7LNARtZcW1v53ridFJK1MULmj8tQT4s+DoRhKj9PrbMri5rQ@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <20180218221352.GA6651@ravnborg.org> <CAFkk2KT1krKuDkWt0eHcasfC61fTVQNf-1kqw7icLP9OYGYkXQ@mail.gmail.com>
 <CAK7LNAQH0WD3A3T97gce0xmZpMy0zWxTO2StfNWaDbiqjQg8gg@mail.gmail.com>
 <CAK8P3a2BOQt5Y0B4271WqaJvvWqfxHxD3S6r1i1xONvb+CJ5Dg@mail.gmail.com> <CAK7LNARtZcW1v53ridFJK1MULmj8tQT4s+DoRhKj9PrbMri5rQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 11:52:50 +0100
X-Google-Sender-Auth: yVgL0QuoTZLXo0GWwUWT9eSBJjU
Message-ID: <CAK8P3a1DrhxWXaEs6E85W5HEhvFr23E-GDsu=0X-sG0pX+PLag@mail.gmail.com>
Subject: Re: [PATCH 00/23] kconfig: move compiler capability tests to Kconfig
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rich Felker <dalias@libc.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>,
	X86 ML <x86@kernel.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	sparclinux <sparclinux@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>,
	Richard Weinberger <richard@nod.at>, Linux-sh list <linux-sh@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Emese Revfy <re.emese@gmail.com>, Kees Cook <keescook@chromium.org>,
	uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Jeff Dike <jdike@addtoit.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, user-mode-linux-user@lists.sourceforge.net,
	Thomas Gleixner <tglx@linutronix.de>, Michal Marek <michal.lkml@markovi.net>,
	Ulf Magnusson <ulfalizer@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583929666456907?=
X-GMAIL-MSGID: =?utf-8?q?1593007534600571433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 11:20 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-21 18:56 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> On Wed, Feb 21, 2018 at 8:38 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> 2018-02-20 0:18 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>
> Let me clarify my concern.
>
> When we test the compiler flag, is there a case
> where a particular flag depends on -m{32,64} ?
>
> For example, is there a compiler that supports -fstack-protector
> for 64bit mode, but unsupports it for 32bit mode?
>
>   $(cc-option -m32)                     ->  y
>   $(cc-option -m64)                     ->  y
>   $(cc-option -fstack-protector)        ->  y
>   $(cc-option -m32 -fstack-protector)   ->  n
>   $(cc-option -m64 -fstack-protector)   ->  y
>
> I guess this is unlikely to happen,
> but I am not whether it is zero possibility.
>
> If this could happen,
> $(cc-option ) must be evaluated together with
> correct bi-arch option (either -m32 or -m64).
>
>
> Currently, -m32/-m64 is specified in Makefile,
> but we are moving compiler tests to Kconfig
> and, CONFIG_64BIT can be dynamically toggled in Kconfig.

I don't think it can happen for this particular combination (stack protector
and word size), but I'm sure we'll eventually run into options that
need to be tested in combination. For the current CFLAGS_KERNEL
setting, we definitely have the case of needing the variables to be
evaluated in a specific order.

      Arnd
