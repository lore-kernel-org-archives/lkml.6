Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AH8x226Wh6Q4ZOSpxH9L8H8BE2LzzR/BlWJ+/oPWn491RrnqqGa6KzhgqrA/8BjY+RIjGAg4zANW
ARC-Seal: i=1; a=rsa-sha256; t=1519269724; cv=none;
        d=google.com; s=arc-20160816;
        b=Xhy+fKuMXnbSFSuOG3g0D2dc94PRPQImID9HymCRgoJY8P9qi+JL/hY2qjDHHq0vTj
         7ueb5fahB1X/OxYJtFjkNRg55xDGKr94PmDlatlu6bUbyF9sbNrXp2W0yy3hEDg35mmp
         kGk0rVquoi80Lz1CAxTAPDqE0Vln9garFwlU9DQMtDpTLxBpaBi+y8j2CbsYKq2eMKUk
         h3NqnL3BmyxfjZ+wo3DCCjz7GyZOa2NWaju5t8IamzE7FnmW3ECs2tHuoKBVsiHVZkJw
         rF60/OC6QpqoiAVXoi5Ns90IOBeM+ehaIEwhTT0MB2zMYGQPilW5iJBKuQa515kjBBUy
         P01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=Uf6TwmzigFLVPZbm0XEWy7U0t1FJAQ0t3LrqmEytrUQ=;
        b=Vq/PWTAWsuJfqoCmVto+HVH+3vfZcF1wqTkZsoDVwlJztMGbpHlmseyFaBPTbk1AqG
         VOIRwcXlonZV+LgoKh91/bfq4d+yCBht/uGBnVd0xP0uur6yk2/YQzKh1+RwhWmLFeXX
         RtkefYWetJY92yKPBdwi49z/Qv7p5ouEMKwlkrCywoFuH4/U3HyH4sB45ovOb9xRodaw
         dWOCk9Rj7/rQqFxaXIl4B4TibRrGk+CRAbhufAJwxmNSfHOHgCJHrzp3XU5ct4ROxxVT
         NbfkyENzy/nBSCwey/juqyQuljG+XBNSgIXjJMcoMeQEg9X9UqFI2Ic6XNzHNwf4erJs
         ssCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 103.22.144.67 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 103.22.144.67 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Rich Felker <dalias@libc.org>, Kernel Hardening
 <kernel-hardening@lists.openwall.com>, X86 ML <x86@kernel.org>, Paul
 Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux
 <sparclinux@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>,
 Richard Weinberger <richard@nod.at>, Linux-sh list
 <linux-sh@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Emese
 Revfy <re.emese@gmail.com>, Kees Cook <keescook@chromium.org>, uml-devel
 <user-mode-linux-devel@lists.sourceforge.net>, Linux Kbuild mailing list
 <linux-kbuild@vger.kernel.org>, Peter Oberparleiter
 <oberpar@linux.vnet.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 user-mode-linux-user@lists.sourceforge.net, Thomas Gleixner
 <tglx@linutronix.de>, Michal Marek <michal.lkml@markovi.net>, Ulf
 Magnusson <ulfalizer@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, "open
 list\:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 00/23] kconfig: move compiler capability tests to Kconfig
In-Reply-To: <CAK7LNAR3OMh9Q9ZfaBq=FpSJ-+DT5-RH_20ohV-iu34pX9hFKw@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com> <20180218221352.GA6651@ravnborg.org> <CAFkk2KT1krKuDkWt0eHcasfC61fTVQNf-1kqw7icLP9OYGYkXQ@mail.gmail.com> <CAK7LNAQH0WD3A3T97gce0xmZpMy0zWxTO2StfNWaDbiqjQg8gg@mail.gmail.com> <CAK8P3a2BOQt5Y0B4271WqaJvvWqfxHxD3S6r1i1xONvb+CJ5Dg@mail.gmail.com> <CAK7LNARtZcW1v53ridFJK1MULmj8tQT4s+DoRhKj9PrbMri5rQ@mail.gmail.com> <CAK8P3a1DrhxWXaEs6E85W5HEhvFr23E-GDsu=0X-sG0pX+PLag@mail.gmail.com> <CAK7LNAR3OMh9Q9ZfaBq=FpSJ-+DT5-RH_20ohV-iu34pX9hFKw@mail.gmail.com>
Date: Thu, 22 Feb 2018 14:22:02 +1100
Message-ID: <87efldr9np.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583929666456907?=
X-GMAIL-MSGID: =?utf-8?q?1593069771054342377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>
<snip>
>
> (Case 3)
> Compiler flag -foo is sensitive to endian-ness.
>
>
> config CC_NEEDS_BIG_ENDIAN
>           def_bool $(cc-option -mbig-endian) && CPU_BIG_ENDIAN
>
> config CC_NEEDS_LITTLE_ENDIAN
>           def_bool $(cc-option -mlittle-endian) && CPU_LITTLE_ENDIAN
>
> config CC_HAS_FOO
>          bool
>          default $(cc-option -mbig-endian -foo) if CC_NEEDS_BIG_ENDIAN
>          default $(cc-option -mlittle-endian -foo) if CC_NEEDS_LITTLE_ENDIAN
>          default $(cc-option -foo)

We may do something like this on powerpc, where we have 32/64-bit and
big/little endian (on 64-bit) and then some ABI options that we
set/unset depending on endian.

The above looks like it could work though.

cheers
