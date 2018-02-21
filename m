Return-Path: <kernel-hardening-return-11851-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227uDMDg75QJoKJNf5h5QgEJypwWBp95Lw1ZXIJYT/QnbDZ3G6cp3Kl7Ha8u6AD8L5uBDG2r
ARC-Seal: i=1; a=rsa-sha256; t=1519208476; cv=none;
        d=google.com; s=arc-20160816;
        b=CjzEzeIZFP7Mx1I1LTZB5vqyf9bErVohhukjJdH55rpixSeHBhCK7vPiMpg1ZC2K2e
         5Jk2ySiR5Su9pgm+lWj3sgepZ+40gQkBo7de+7LD8xc/HhIHKYmeOJxyQQo9xdBl6+4Q
         nV6i+m13a2pC464ArBQHqy1MFS1fsUvy60V5H6WOjCCmEMj6nzwG5Ns5FVNTi8JNctG1
         kppTgpdk0M5kdw9g9jc1gpLWnwCXPLJAa0Appo1eLJ25YCvcY7vOypuN9LtRE5OVf9XO
         pFzlj2hfox1EWW2R5QF4TppgGc6pkXICL0N6NTWU3jzxVtc/exhy1OdmHfqJapjC2Kxd
         bIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Bi4fA2ypTG6Mvop+Fzpk/VgkeoGzhkCYUgy69xdsQDA=;
        b=ncKqZGya2S88T4SrlUObbGpuMsR8dq9FjGT3bANxdGEAdlkk/pwlb3lJfr9BjzLg9o
         UVN/5XfscV9gTebfte/+4WX5vcXMnk0EoDzhxiYb6ak5fAFXSnsT2OXTLWiJYfVImCf+
         bRjDSF+xLEQd/4SL5srLj5CiYvNA0Wa5uIKnap0EUkLB9n4LglFkcqdam/+PdIAVr59e
         RMSL96Nr77YUaEuFWzh1qewci5q3rFD6wlsz/I9IK2UyB4z3YRcGQt62J23QBHaLigny
         y9RiLSe9Cyv/nv2QLF0K0BIsL8yZv5V/p1CsLEiseT6jvcx6HJ9s3oUkZxnEnI0FzD2n
         sdRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=MYqbZ2G9;
       spf=pass (google.com: domain of kernel-hardening-return-11851-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11851-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=MYqbZ2G9;
       spf=pass (google.com: domain of kernel-hardening-return-11851-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11851-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w1LAKooO022924
X-Nifty-SrcIP: [209.85.213.48]
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2BOQt5Y0B4271WqaJvvWqfxHxD3S6r1i1xONvb+CJ5Dg@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <20180218221352.GA6651@ravnborg.org> <CAFkk2KT1krKuDkWt0eHcasfC61fTVQNf-1kqw7icLP9OYGYkXQ@mail.gmail.com>
 <CAK7LNAQH0WD3A3T97gce0xmZpMy0zWxTO2StfNWaDbiqjQg8gg@mail.gmail.com> <CAK8P3a2BOQt5Y0B4271WqaJvvWqfxHxD3S6r1i1xONvb+CJ5Dg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 19:20:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNARtZcW1v53ridFJK1MULmj8tQT4s+DoRhKj9PrbMri5rQ@mail.gmail.com>
Message-ID: <CAK7LNARtZcW1v53ridFJK1MULmj8tQT4s+DoRhKj9PrbMri5rQ@mail.gmail.com>
Subject: Re: [PATCH 00/23] kconfig: move compiler capability tests to Kconfig
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jonathan Corbet <corbet@lwn.net>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Emese Revfy <re.emese@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        user-mode-linux-user@lists.sourceforge.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583929666456907?=
X-GMAIL-MSGID: =?utf-8?q?1593005547338036950?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-21 18:56 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Feb 21, 2018 at 8:38 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-20 0:18 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>>
>>>>
>>>> I'm not happy that we in one context can reference CONFIG variables
>>>> directly, but inside the $(call ...) and $(shell ...) needs the $ prefix.
>>>> But I could not come up with something un-ambigious where this could be avoided.
>>>
>>> I think we should be careful about allowing references to config
>>> symbols. It mixes up the parsing and evaluation phases, since $() is
>>> expanded during parsing (which I consider a feature and think is
>>> needed to retain sanity).
>>>
>>> Patch 06/23 removes the last existing instance of symbol references in
>>> strings by getting rid of 'option env'. That's an improvement to me.
>>> We shouldn't add it back.
>>
>>
>> This is really important design decision,
>> so I'd like to hear a little more from experts.
>>
>>
>> For example, x86 allows users to choose sub-arch, either 'i386' or 'x86_64'.
>>
>> https://github.com/torvalds/linux/blob/v4.16-rc2/arch/x86/Kconfig#L4
>>
>>
>>
>> If the user toggles CONFIG_64BIT,
>> the bi-arch compiler will work in a slightly different mode
>> (at least, back-end parts)
>>
>> So, my question is, is there a case,
>>
>> $(cc-option, -m32 -foo) is y, but
>> $(cc-option, -m64 -foo) is n  ?
>> (or vice versa)
>>
>>
>> If the answer is yes, $(cc-option -foo) would have to be re-calculated
>> every time CONFIG_64BIT is toggled.
>>
>> This is what I'd like to avoid, though.
>
> The -m32/-m64 trick (and -mbig-endian/-mlittle-endian on other architectures
> as well as a couple of other flags) only works if the compiler is configured to
> support it. In other cases (e.g. big-endian xtensa), the kernel always
> detects what the compiler does and silently configures itself to match
> using Makefile logic.
>
> On x86, compilers are usually built as bi-arch, but you can build one that
> only allows one of them.
>
> I can see two reasonable ways out:
>
> - we don't use  $(cc-option -foo) in a case like this, and instead require the
>   user to have a matching toolchain.
> - we could make the 32/64 selection on x86 a 'choice' statement where
>   each option depends on both the ARCH= variable and the
>   $(cc-option, -m32)/ $(cc-option, -m64) output.
>
>        Arnd



Let me clarify my concern.

When we test the compiler flag, is there a case
where a particular flag depends on -m{32,64} ?

For example, is there a compiler that supports -fstack-protector
for 64bit mode, but unsupports it for 32bit mode?

  $(cc-option -m32)                     ->  y
  $(cc-option -m64)                     ->  y
  $(cc-option -fstack-protector)        ->  y
  $(cc-option -m32 -fstack-protector)   ->  n
  $(cc-option -m64 -fstack-protector)   ->  y

I guess this is unlikely to happen,
but I am not whether it is zero possibility.

If this could happen,
$(cc-option ) must be evaluated together with
correct bi-arch option (either -m32 or -m64).


Currently, -m32/-m64 is specified in Makefile,
but we are moving compiler tests to Kconfig
and, CONFIG_64BIT can be dynamically toggled in Kconfig.




-- 
Best Regards
Masahiro Yamada
