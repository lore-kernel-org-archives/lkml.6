Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519229006; cv=none;
        d=google.com; s=arc-20160816;
        b=Tm/kAQA39/OZTdgZQQKssxaP6UIWWCjOqC2b+rRaqTuyluujlwsgQwp6xbbmvVEmfm
         8SbOCbAPQWFGceWZVR3A0nkPovUgpXaTW0048RAKzY7rUBQAhQpODJjQGhYmqPDmAAxr
         2+nz7sCoTBkszXSKBMUqcWaosDVtTko375PocOTQ/M7h6fLU4ag9Hm82+lbg6AOtAZ/r
         U+U9NktgVBLvIB/mepOgapEV7odLxKO2jo2MfJuU8CXcakjnfLOyLIbvJYoo4jGSyT4y
         6uCzrI7dNpC+ky6lTYuNBoOFiW4hhLhekaGW4PlNnrkH966lMQoRV2yGkWpmguLq3iIV
         e/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=R+M9dDvFHBmW6sK0W/a45XHD/0qAZawn0vb2Z4wDHoY=;
        b=p9ijzfw9sFmTOIhTDa46RMpIAZviQgjMglday101aB/p2/SjQefbzMEQ7Vt1r/Tug9
         lbM+j8Z2bu90g3MJ0ljBvD1CR806d+CrXVDBOGlMi50yObwdEj978ZYNusLc5rz/sGC4
         iw9IuKQWJiGw4IPrz4GgTcIIiR2ScGKtgnwFrDOeURyGbFSPclLS88gc8pNfx9IuyAoZ
         6J6HyhCeioclUCDBOgFhTGb38ju88WCz6+sbtsajj4PdfkXdLg6ftU1YPboPkrzWw5bb
         aLv+fKviDUvAIUj/fotjmkGoTCHzPBxyy9wTy1gVamCcv3Xd53nO8hhlWeCcTjN9N8ra
         q61w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=holoYr4t;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=holoYr4t;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x227hnOn5KaU1/RFB5elKhk/e6w3VxzJSKMMeNVAa62P4SwSNxp17RBR/cdnih3IfGMCQB5aLEypJprs3iaq7Fio=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAK7LNAR3OMh9Q9ZfaBq=FpSJ-+DT5-RH_20ohV-iu34pX9hFKw@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <20180218221352.GA6651@ravnborg.org> <CAFkk2KT1krKuDkWt0eHcasfC61fTVQNf-1kqw7icLP9OYGYkXQ@mail.gmail.com>
 <CAK7LNAQH0WD3A3T97gce0xmZpMy0zWxTO2StfNWaDbiqjQg8gg@mail.gmail.com>
 <CAK8P3a2BOQt5Y0B4271WqaJvvWqfxHxD3S6r1i1xONvb+CJ5Dg@mail.gmail.com>
 <CAK7LNARtZcW1v53ridFJK1MULmj8tQT4s+DoRhKj9PrbMri5rQ@mail.gmail.com>
 <CAK8P3a1DrhxWXaEs6E85W5HEhvFr23E-GDsu=0X-sG0pX+PLag@mail.gmail.com> <CAK7LNAR3OMh9Q9ZfaBq=FpSJ-+DT5-RH_20ohV-iu34pX9hFKw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 17:03:25 +0100
X-Google-Sender-Auth: jDM0EIwjd-fBzCHaTGUJDFFIbO4
Message-ID: <CAK8P3a3-eufj=HM4Mi+KaSLxuoPwtw0P4EfmtYfVcbnR0mVwAw@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1593027074039396162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 1:57 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-21 19:52 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> On Wed, Feb 21, 2018 at 11:20 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> 2018-02-21 18:56 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>>> On Wed, Feb 21, 2018 at 8:38 AM, Masahiro Yamada
>>>> <yamada.masahiro@socionext.com> wrote:
>>>>> 2018-02-20 0:18 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>
> Hmm, I think I can implement those somehow.
> But, I hope we do not have many instances like this...
>
>
> If you know more naive cases, please share your knowledge.
>

One case that comes to mind would be architecture level selection on 32-bit
ARM, which is roughly this (I probably have some details wrong, but you
get the idea):

- older compilers don't support the latest architecture setting (-march=armv8
  or -march=armv7ve)
- newer compilers no longer support really old architectures (-march=armv4)
- setting -mthumb requires setting one of  -march=armv7-a, armv7ve, armv7-m or
  armv8 if the compiler doesn't default to those
- on a compiler that defaults to -marm, setting -march=armv7-m requires
  setting -mthumb (IIRC)
- really old compilers only support OABI, but not EABI
- newer compilers no longer support OABI
- mthumb requires EABI
- armv6 and higher are subtly broken with OABI, but only when using
  certain inline assembly with 64-bit arguments in register pairs.

I think we just shouldn't try to capture all of the above correctly in Kconfig
conditionals.

       Arnd
