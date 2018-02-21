Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227Xq6tZBIAkfJxrgyNPuFtAH83JiQr2VMBLKo/boZLcWe4KeZ//9Cwu1PLOiU8Up2J9yFkq
ARC-Seal: i=1; a=rsa-sha256; t=1519217879; cv=none;
        d=google.com; s=arc-20160816;
        b=QdgstGX1mpWu6VRMHtjI9hdfZRi9F/SLnTrYk/1T5E1MGZzdtxQejJL5Dt/B3x7gKg
         Dmt9q37vw3P0aTCFQtMsVK8rvnOfh6DN4mMKgJdoH0sCivvTKzh9OhY/O94WIcTnEMqG
         x++FeI6xVJvLzISs6qCOszhGmTlDQKCOip8fbPCK+aT+tUu1Q2w5dF2S+IcK7/KqHNmY
         J4Z+PIDITl79TLFWNxrCXl2QtMvV4JWuMEJ69/W9+tehBBpojrmxzD9WK8otAsaRy3b4
         YLSM+NCF0A/Frm49uzY8nC80wV5W1omUY1F6jg9eXylBJ5vR2pjg74hB/gEN/LuJ42nV
         d8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=K4UIT7NLyatWkqe4qwVrCM5M/VanEw2Zh7sKSKYJ/3Q=;
        b=e2f+0XV2dNvASBEsGdR7mi8pLxWoU56SyxBOsnT1vCJwQiHFToirKa/5K1ERDr/TQy
         BIM7cgTukV9WZBZbo7cxh7gB1Qu9MiHP66UI1i2S38SesIiC6ttlZ1ij8NcgbJgf2U2D
         CIOnOOr1yxIusBDPKUHWZZTVatKykHrQpvo628Yt+WumcPWJdoOBA8hZbXPE3OlAbcwX
         i2oxiD6yVjLbdgKt5JoJrm2nmm0R26X93SwBU3Wdhmm9+EtiaMnoHrKmqMn0uCZzPBf4
         /lM8iT0rsOl0Q6mZoHsXgnCZAIKVRQxbAcQELNaTQfzETzKGCgriv9PAf0Gqr81VGcNS
         Oi+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Vt81dy9I;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Vt81dy9I;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1LCvkP7016328
X-Nifty-SrcIP: [209.85.217.179]
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1DrhxWXaEs6E85W5HEhvFr23E-GDsu=0X-sG0pX+PLag@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <20180218221352.GA6651@ravnborg.org> <CAFkk2KT1krKuDkWt0eHcasfC61fTVQNf-1kqw7icLP9OYGYkXQ@mail.gmail.com>
 <CAK7LNAQH0WD3A3T97gce0xmZpMy0zWxTO2StfNWaDbiqjQg8gg@mail.gmail.com>
 <CAK8P3a2BOQt5Y0B4271WqaJvvWqfxHxD3S6r1i1xONvb+CJ5Dg@mail.gmail.com>
 <CAK7LNARtZcW1v53ridFJK1MULmj8tQT4s+DoRhKj9PrbMri5rQ@mail.gmail.com> <CAK8P3a1DrhxWXaEs6E85W5HEhvFr23E-GDsu=0X-sG0pX+PLag@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 21:57:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR3OMh9Q9ZfaBq=FpSJ-+DT5-RH_20ohV-iu34pX9hFKw@mail.gmail.com>
Message-ID: <CAK7LNAR3OMh9Q9ZfaBq=FpSJ-+DT5-RH_20ohV-iu34pX9hFKw@mail.gmail.com>
Subject: Re: [PATCH 00/23] kconfig: move compiler capability tests to Kconfig
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rich Felker <dalias@libc.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        X86 ML <x86@kernel.org>, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Emese Revfy <re.emese@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        user-mode-linux-user@lists.sourceforge.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583929666456907?=
X-GMAIL-MSGID: =?utf-8?q?1593015407035328109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-21 19:52 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Feb 21, 2018 at 11:20 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-21 18:56 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Wed, Feb 21, 2018 at 8:38 AM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> 2018-02-20 0:18 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>>
>> Let me clarify my concern.
>>
>> When we test the compiler flag, is there a case
>> where a particular flag depends on -m{32,64} ?
>>
>> For example, is there a compiler that supports -fstack-protector
>> for 64bit mode, but unsupports it for 32bit mode?
>>
>>   $(cc-option -m32)                     ->  y
>>   $(cc-option -m64)                     ->  y
>>   $(cc-option -fstack-protector)        ->  y
>>   $(cc-option -m32 -fstack-protector)   ->  n
>>   $(cc-option -m64 -fstack-protector)   ->  y
>>
>> I guess this is unlikely to happen,
>> but I am not whether it is zero possibility.
>>
>> If this could happen,
>> $(cc-option ) must be evaluated together with
>> correct bi-arch option (either -m32 or -m64).
>>
>>
>> Currently, -m32/-m64 is specified in Makefile,
>> but we are moving compiler tests to Kconfig
>> and, CONFIG_64BIT can be dynamically toggled in Kconfig.
>
> I don't think it can happen for this particular combination (stack protector
> and word size), but I'm sure we'll eventually run into options that
> need to be tested in combination. For the current CFLAGS_KERNEL
> setting, we definitely have the case of needing the variables to be
> evaluated in a specific order.
>




I was thinking of how we can handle complex cases
in the current approach.



(Case 1)

Compiler flag -foo and -bar interacts, so
we also need to check the combination of the two.


config CC_HAS_FOO
        def_bool $(cc-option -foo)

config CC_HAS_BAR
        def_bool $(cc-option -bar)

config CC_HAS_FOO_WITH_BAR
        def_bool $(cc-option -foo -bar)



(Case 2)
Compiler flag -foo is sensitive to word-size.
So, we need to test this option together with -m32/-m64.
User can toggle CONFIG_64BIT, like i386/x86_64.


config CC_NEEDS_M64
          def_bool $(cc-option -m64) && 64BIT

config CC_NEEDS_M32
          def_bool $(cc-option -m32) && !64BIT

config CC_HAS_FOO
         bool
         default $(cc-option -m64 -foo) if CC_NEEDS_M64
         default $(cc-option -m32 -foo) if CC_NEEDS_M32
         default $(cc-option -foo)



(Case 3)
Compiler flag -foo is sensitive to endian-ness.


config CC_NEEDS_BIG_ENDIAN
          def_bool $(cc-option -mbig-endian) && CPU_BIG_ENDIAN

config CC_NEEDS_LITTLE_ENDIAN
          def_bool $(cc-option -mlittle-endian) && CPU_LITTLE_ENDIAN

config CC_HAS_FOO
         bool
         default $(cc-option -mbig-endian -foo) if CC_NEEDS_BIG_ENDIAN
         default $(cc-option -mlittle-endian -foo) if CC_NEEDS_LITTLE_ENDIAN
         default $(cc-option -foo)




Hmm, I think I can implement those somehow.
But, I hope we do not have many instances like this...


If you know more naive cases, please share your knowledge.

Thanks!


-- 
Best Regards
Masahiro Yamada
