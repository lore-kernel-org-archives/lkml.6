Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx49B1q7MtDHcwX7rO0LiYc5zh+XVOh+unnblbv6PWtQYN6Ag2mO5XlkYFsDlMsbydSOt9tvA
ARC-Seal: i=1; a=rsa-sha256; t=1523264126; cv=none;
        d=google.com; s=arc-20160816;
        b=l5mAR60viEFMYrcPsS3dqSAwYVG9g/3AmN6OMGRZgjdEt3nvq+BREzjN1UkcN8Fpip
         V4nLJLll430eYkvlDv8hqiPRta/A9n3bMUrSJbX1m8jgK7kysFtZkwKleXREOvJ35WDj
         T5WHu6g50p3aMGMa5bz9uGkPZ16Ay8hrVtfXaa7yz3f++SfXz0Q3WupPvOGowKtHjJWZ
         AGbNlnk/nSWNu6dP8f8s5RHtVMAOkblXQDOKZZ515IPHfy9IpPlwi+nnjN+4FMKAdS54
         g/TlyKQOuljL0CCKx0X8s4jhw/PyFS3T7dIJJaSlnX+F3ZbFWp2H+hzPg1VHA4ApSTCK
         7Wpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=QSvGDfx7rVJHqtZDBG2Z05AGbymmtFRoba71vWrC76I=;
        b=fdV1eC0xk++9FN5tu8dHfpMeRC92TMd7N/YCDE88qJqiHOF0FV189oJGM628Dj01do
         FfiTE81Tql8JZ8ZFBUX7BVLKXuUyEQDWOl0IQae8M3MgzcuvQGVLL3RsDldvK6nAu+GD
         dXXS6Ste6YRlOcwmw1gfxdWVEFhpiUmQFP+n2U0+u4Vsfcu9WVJxN8c+BR+IHS9Nra0q
         pTs5qngV/Q9nULh3X8ZaZgk3Sy1iYZkEv1/PEOWwiy52SvNSlInPlI0XbcGWORbLG05S
         pVYBqSVnAAr4N3FgSsV87K7hkVBvcK9vTShuY5tf1bbId0+IkzmnrFdlaq7RX88iDeQY
         PgbA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=cnuHqW1z;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=cnuHqW1z;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w398tCJx027494
X-Nifty-SrcIP: [209.85.213.43]
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+F1GXNE9T3vOo+Sq+GfX2Cy5a8tFU--qVBJwaJkt=s6Q@mail.gmail.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-12-git-send-email-yamada.masahiro@socionext.com> <CAGXu5j+F1GXNE9T3vOo+Sq+GfX2Cy5a8tFU--qVBJwaJkt=s6Q@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 9 Apr 2018 17:54:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAScTUhpvgnNzuOGZ2ueh-d4R4r=v5wzOGsd+pYn+MF-rQ@mail.gmail.com>
Message-ID: <CAK7LNAScTUhpvgnNzuOGZ2ueh-d4R4r=v5wzOGsd+pYn+MF-rQ@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1597258204842855963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-28 20:18 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Move the test for -fstack-protector(-strong) option to Kconfig.
>>
>> If the compiler does not support the option, the corresponding menu
>> is automatically hidden.  If _STRONG is not supported, it will fall
>> back to _REGULAR.  If _REGULAR is not supported, it will be disabled.
>> This means, _AUTO is implicitly handled by the dependency solver of
>> Kconfig, hence removed.
>>
>> I also turned the 'choice' into only two boolean symbols.  The use of
>> 'choice' is not a good idea here, because all of all{yes,mod,no}config
>> would choose the first visible value, while we want allnoconfig to
>> disable as many features as possible.
>>
>> X86 has additional shell scripts in case the compiler supports the
>> option, but generates broken code.  I added CC_HAS_SANE_STACKPROTECTOR
>> to test this.  I had to add -m32 to gcc-x86_32-has-stack-protector.sh
>> to make it work correctly.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> This looks really good. Notes below...
>
>> ---
>>
>> Changes in v2:
>>   - Describe $(cc-option ...) directly in depends on context
>>
>>  Makefile                                  | 93 ++-----------------------------
>>  arch/Kconfig                              | 29 +++-------
>>  arch/x86/Kconfig                          |  8 ++-
>>  scripts/gcc-x86_32-has-stack-protector.sh |  7 +--
>>  scripts/gcc-x86_64-has-stack-protector.sh |  5 --
>>  5 files changed, 22 insertions(+), 120 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 5c395ed..5cadffa 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -675,55 +675,11 @@ ifneq ($(CONFIG_FRAME_WARN),0)
>>  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
>>  endif
>>
>> -# This selects the stack protector compiler flag. Testing it is delayed
>> -# until after .config has been reprocessed, in the prepare-compiler-check
>> -# target.
>> -ifdef CONFIG_CC_STACKPROTECTOR_AUTO
>> -  stackp-flag := $(call cc-option,-fstack-protector-strong,$(call cc-option,-fstack-protector))
>> -  stackp-name := AUTO
>> -else
>> -ifdef CONFIG_CC_STACKPROTECTOR_REGULAR
>> -  stackp-flag := -fstack-protector
>> -  stackp-name := REGULAR
>> -else
>> -ifdef CONFIG_CC_STACKPROTECTOR_STRONG
>> -  stackp-flag := -fstack-protector-strong
>> -  stackp-name := STRONG
>> -else
>> -  # If either there is no stack protector for this architecture or
>> -  # CONFIG_CC_STACKPROTECTOR_NONE is selected, we're done, and $(stackp-name)
>> -  # is empty, skipping all remaining stack protector tests.
>> -  #
>> -  # Force off for distro compilers that enable stack protector by default.
>> -  KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
>> -endif
>> -endif
>> -endif
>> -# Find arch-specific stack protector compiler sanity-checking script.
>> -ifdef stackp-name
>> -ifneq ($(stackp-flag),)
>> -  stackp-path := $(srctree)/scripts/gcc-$(SRCARCH)_$(BITS)-has-stack-protector.sh
>> -  stackp-check := $(wildcard $(stackp-path))
>> -  # If the wildcard test matches a test script, run it to check functionality.
>> -  ifdef stackp-check
>> -    ifneq ($(shell $(CONFIG_SHELL) $(stackp-check) $(CC) $(KBUILD_CPPFLAGS) $(biarch)),y)
>> -      stackp-broken := y
>> -    endif
>> -  endif
>> -  ifndef stackp-broken
>> -    # If the stack protector is functional, enable code that depends on it.
>> -    KBUILD_CPPFLAGS += -DCONFIG_CC_STACKPROTECTOR
>> -    # Either we've already detected the flag (for AUTO) or we'll fail the
>> -    # build in the prepare-compiler-check rule (for specific flag).
>> -    KBUILD_CFLAGS += $(stackp-flag)
>> -  else
>> -    # We have to make sure stack protector is unconditionally disabled if
>> -    # the compiler is broken (in case we're going to continue the build in
>> -    # AUTO mode).
>
> Let's keep this comment (slightly rewritten) since the reason for
> setting this flag isn't obvious.

Will move this to help of arch/x86/Kconfig


>> -    KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
>> -  endif
>> -endif
>> -endif
>> +stackp-flags-y                                 := -fno-stack-protector
>
> This is a (minor?) regression in my testing. Making this unconditional
> may break for a compiler built without stack-protector. It should be
> rare, but it's technically possible. Perhaps:
>
> stackp-flags-y := ($call cc-option, -fno-stack-protector)

Will add CONFIG_CC_HAS_STACKPROTECTOR_NONE


>> +stackp-flags-$(CONFIG_CC_STACKPROTECTOR)       := -fstack-protector
>> +stackp-flags-$(CONFIG_CC_STACKPROTECTOR_STRONG)        := -fstack-protector-strong
>> +
>> +KBUILD_CFLAGS += $(stackp-flags-y)
>> [...]
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 8e0d665..b42378d 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -535,13 +535,13 @@ config HAVE_CC_STACKPROTECTOR
>>         bool
>>         help
>>           An arch should select this symbol if:
>> -         - its compiler supports the -fstack-protector option
>
> Please leave this note: it's still valid. An arch must still have
> compiler support for this to be sensible.
>

No.

"its compiler supports the -fstack-protector option"
is tested by $(cc-option -fstack-protector)

ARCH does not need to know the GCC support level.




>>           - it has implemented a stack canary (e.g. __stack_chk_guard)

-- 
Best Regards
Masahiro Yamada
