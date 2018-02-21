Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519206985; cv=none;
        d=google.com; s=arc-20160816;
        b=dfwKS+u907FSkKRtQEUaNnvGa3K15sWXwvYNO+nJOuppsfhimkXMd4pHY5iVZpyzjq
         yws6oVnu0xwPThg8fU4OYILZ0h2SU75FONIubBjQzIBQxM/fBonHwPPhs2ZamE18YpGi
         rXnrdD9AdaoOX/i0bmYA2+7EPMWrMlSnqj2uJByXoxdkyLEM+ZgfEdsA7CZoAa6zMmxH
         5cU7/49WZNSugJdlPL5x+FTLD4x+MyrRZ9y8oLzHs1bWUO3UeRwftEm36/55YvY2tJf3
         POLYOLh5RimdjhRZWxtOGGanTf5Sm7wHWItC10mprQLAYO7/IHiU52VAriM0yOgWTxKR
         NO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=UYl3Z4M4NzIWAW+K+Sl5kmCsn04zVrhGEchfFtkeXbs=;
        b=y+V7An019eYt0AaPb1YedLmZ0t3uOJ7kTsHMQEeT1RrRgK5z+gwRS37UvRnjs+23um
         o9I98L6tmGpH7Z/6MeFuDkRpG8nCvk5r1ajqHwkEHNtpvEIH9Qg8M8aFibEHPpi1gRI/
         kVdtssypWjj1g8h2THaA9/YyUcw5rT1zq0gXUNvRJw1P+lryK+4D4sc0+iCJtZz1ShSR
         3TB9uw7ODp6w6rYDhYh45Oc8IqhO/xw56/L3hvceLsM3rCLpzRkYY8qD2cO9hFdSnQLs
         MfZypT6aM+GfxD/Jty+1FdozyCtxmBHSUSJyRtvvcTYtSfRMtDU2POiLIXE/LVoSlnm9
         6w1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=i5RnqzZe;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=i5RnqzZe;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x2249QLCIGuceTP6TlkAqhDfLftl3rrRxe8/umJaQ67Nl4YNZWdB9S9MYI9ICxaK/LkhBz5IEs7qBeh01nYNEh44=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAK7LNAQH0WD3A3T97gce0xmZpMy0zWxTO2StfNWaDbiqjQg8gg@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <20180218221352.GA6651@ravnborg.org> <CAFkk2KT1krKuDkWt0eHcasfC61fTVQNf-1kqw7icLP9OYGYkXQ@mail.gmail.com>
 <CAK7LNAQH0WD3A3T97gce0xmZpMy0zWxTO2StfNWaDbiqjQg8gg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 10:56:24 +0100
X-Google-Sender-Auth: erArf6J-lT1oLoqdT6TbYVxCaZ4
Message-ID: <CAK8P3a2BOQt5Y0B4271WqaJvvWqfxHxD3S6r1i1xONvb+CJ5Dg@mail.gmail.com>
Subject: Re: [PATCH 00/23] kconfig: move compiler capability tests to Kconfig
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Rich Felker <dalias@libc.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, X86 ML <x86@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
	Emese Revfy <re.emese@gmail.com>, Kees Cook <keescook@chromium.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Jeff Dike <jdike@addtoit.com>,
	user-mode-linux-user@lists.sourceforge.net,
	Thomas Gleixner <tglx@linutronix.de>, Michal Marek <michal.lkml@markovi.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583929666456907?=
X-GMAIL-MSGID: =?utf-8?q?1593003984040893568?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 8:38 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-20 0:18 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>
>>>
>>> I'm not happy that we in one context can reference CONFIG variables
>>> directly, but inside the $(call ...) and $(shell ...) needs the $ prefix.
>>> But I could not come up with something un-ambigious where this could be avoided.
>>
>> I think we should be careful about allowing references to config
>> symbols. It mixes up the parsing and evaluation phases, since $() is
>> expanded during parsing (which I consider a feature and think is
>> needed to retain sanity).
>>
>> Patch 06/23 removes the last existing instance of symbol references in
>> strings by getting rid of 'option env'. That's an improvement to me.
>> We shouldn't add it back.
>
>
> This is really important design decision,
> so I'd like to hear a little more from experts.
>
>
> For example, x86 allows users to choose sub-arch, either 'i386' or 'x86_64'.
>
> https://github.com/torvalds/linux/blob/v4.16-rc2/arch/x86/Kconfig#L4
>
>
>
> If the user toggles CONFIG_64BIT,
> the bi-arch compiler will work in a slightly different mode
> (at least, back-end parts)
>
> So, my question is, is there a case,
>
> $(cc-option, -m32 -foo) is y, but
> $(cc-option, -m64 -foo) is n  ?
> (or vice versa)
>
>
> If the answer is yes, $(cc-option -foo) would have to be re-calculated
> every time CONFIG_64BIT is toggled.
>
> This is what I'd like to avoid, though.

The -m32/-m64 trick (and -mbig-endian/-mlittle-endian on other architectures
as well as a couple of other flags) only works if the compiler is configured to
support it. In other cases (e.g. big-endian xtensa), the kernel always
detects what the compiler does and silently configures itself to match
using Makefile logic.

On x86, compilers are usually built as bi-arch, but you can build one that
only allows one of them.

I can see two reasonable ways out:

- we don't use  $(cc-option -foo) in a case like this, and instead require the
  user to have a matching toolchain.
- we could make the 32/64 selection on x86 a 'choice' statement where
  each option depends on both the ARCH= variable and the
  $(cc-option, -m32)/ $(cc-option, -m64) output.

       Arnd
