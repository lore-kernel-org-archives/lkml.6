Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx48c7FmPlxNyxt4pOQ8mSh/kUy2QLSaBlB06O0sd0aZwiKL4Ca7IA1dbKujYeANsDhcC3kfm
ARC-Seal: i=1; a=rsa-sha256; t=1523330200; cv=none;
        d=google.com; s=arc-20160816;
        b=upnfiSYCR7c7oGk9sJkB7SuuhaqX7qAS7KKHl3xIffFdRjE9mjkvhHklCyMIBo23e8
         Pqu7jIMqGhFWSqTjKKjfjw/x6VIkXKlFPRVZPSGTGFzGOChALEKwtZNaxOWhTk8KEl3W
         le9jj8lyzikqoSnLdKrd+Sys+d+hDjJ0tqROyu/U3o/bH7bsybjN2g4Jwsg4UOJsYnaW
         8M3kQuxXEwa5IFD6qBkU+0Vxk2KWEHuvna8O97c7+3SvZ0mfxQ6M6o/mPqssXAilZOL8
         kLGcjXJB8Eg3PxjY5k5WOdkM5WealQzyACOZ1hHMV7ddg6ghPDjGq1EXqGGAmBo8mFYn
         xAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=KSiIYmnWCn8t54g9kSnsKbas4U6RcYA4I0ZTeHdX2Mk=;
        b=jbzowZrJvTzMTJjEtFIZwYU+pBgdlbDGxbsqWcM7IhHL1bgIPcFqZT1fVCU7lG0Elf
         NBg824Sr3Vw7DJc4nsJwRky869B1AkpM9EIBG0P94bcP9r5jUoE4GOKdeTlwcdJeGimM
         iGMSsFpGb1ciqvo8ptiRdEobVNDiB8QaTBEvx7lc526jatOSstV8vFseGFoiGu8Q+pEK
         ZAt261ewrBEBSAYCt8w8d0uxIfc8C31FCug/lf6hDtfLUrjPIQhGPxzoV/yyBD6AdTo5
         THPyUFBFMLB8ARchRQGj0ZmaopEWddBjGq/ExQigEYcBWmPBgvfFNFNRTFVEC70rSO/9
         mGyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=OeKVbl1g;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=OeKVbl1g;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w3A3GBQN010599
X-Nifty-SrcIP: [209.85.217.179]
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJCpDtVcFckLzeTg=Du0TWL=KGUH1_k2LSbv8PTONQ2Mw@mail.gmail.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-12-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+F1GXNE9T3vOo+Sq+GfX2Cy5a8tFU--qVBJwaJkt=s6Q@mail.gmail.com>
 <CAK7LNAScTUhpvgnNzuOGZ2ueh-d4R4r=v5wzOGsd+pYn+MF-rQ@mail.gmail.com> <CAGXu5jJCpDtVcFckLzeTg=Du0TWL=KGUH1_k2LSbv8PTONQ2Mw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 10 Apr 2018 12:15:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATULgbS6mxYJUumnkVZU_1LhQwS0jL=v_=HAjtRiF12yA@mail.gmail.com>
Message-ID: <CAK7LNATULgbS6mxYJUumnkVZU_1LhQwS0jL=v_=HAjtRiF12yA@mail.gmail.com>
Subject: Re: [PATCH v2 11/21] stack-protector: test compiler capability in
 Kconfig and drop AUTO mode
To: Kees Cook <keescook@chromium.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538122129787?=
X-GMAIL-MSGID: =?utf-8?q?1597327487499265069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-10 0:04 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Mon, Apr 9, 2018 at 1:54 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-03-28 20:18 GMT+09:00 Kees Cook <keescook@chromium.org>:
>>> On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>> index 8e0d665..b42378d 100644
>>>> --- a/arch/Kconfig
>>>> +++ b/arch/Kconfig
>>>> @@ -535,13 +535,13 @@ config HAVE_CC_STACKPROTECTOR
>>>>         bool
>>>>         help
>>>>           An arch should select this symbol if:
>>>> -         - its compiler supports the -fstack-protector option
>>>
>>> Please leave this note: it's still valid. An arch must still have
>>> compiler support for this to be sensible.
>>>
>>
>> No.
>>
>> "its compiler supports the -fstack-protector option"
>> is tested by $(cc-option -fstack-protector)
>>
>> ARCH does not need to know the GCC support level.
>
> That's not correct: if you enable stack protector for a kernel
> architecture that doesn't having it enabled, it's unlikely for the
> resulting kernel to boot. An architecture must handle the changes that
> the compiler introduces when adding -fstack-protector (for example,
> having the stack protector canary value defined, having the failure
> function defined, handling context switches changing canaries, etc).
>



It is still hard to understand this.


When we "its compiler supports the -fstack-protector option",
we have two meanings

[1] the stack protector feature is implemented in GCC source code.

[2] -fstack-protector is recognized as a valid option in the GCC being used.
    This can be tested by $(cc-option -fstack-protector)

I guess you were talking about [1], where as I [2].
Is this correct?


Does [2] happen only after [1] happens?
Or, are they independent?

If there is a case where GCC recognizes -fstack-protector,
but not implemented?


For x86, there are cases where the option is recognized but not working.
That's why we have
scripts/gcc-x86_{32,64}-has-stack-protector.sh

Generally, if GCC accepts -fstack-protector as a valid option,
we expect "it is working".

I wonder why we need additional information about the compiler
even after $(cc-option -fstack-protector) succeeds.


This is just a matter of comment.

Can you clarify your problem?




> resulting kernel to boot. An architecture must handle the changes that
> the compiler introduces when adding -fstack-protector (for example,
> having the stack protector canary value defined, having the failure
> function defined, handling context switches changing canaries, etc).
>

All of these are talking about the kernel side implementation.
So, it is included in the following comment I am still keeping.

  - it has implemented a stack canary (e.g. __stack_chk_guard)



-- 
Best Regards
Masahiro Yamada
