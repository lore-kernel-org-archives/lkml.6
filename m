Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225cnIFWlkRvyQOCw8hH5qQ4XTFj5EFa6DYmmK/1YEu14J+qaj0vTuJ9es5a8y4izqCCk7Zi
ARC-Seal: i=1; a=rsa-sha256; t=1518246816; cv=none;
        d=google.com; s=arc-20160816;
        b=lMANHZN7NbSLmPZDpvYtBzggEOoda39oS2mw3qdu4rZpmYHhMOB6gIbgTEQnb4is44
         1J5RMX/H4SL6vwHzsvpNIit6AsRXkQ8BQRChM2PqsK1x4y+YNnDwnm0R9Hamh0kKP3b4
         xC9FU2XCQMuM09o4mfpSiXnnlCg+/eXlfiGzV1ktythZoh38v2cMlqWrDYNCek30OS7a
         oSc/+I3Y2rZM3ickJLJUp/6KZcO+Ty6Vd99jEuGSWeOnfgObwjFrmMl2nmehvhdgGi82
         ZV3zyiSMakq7fKuP+HuaMJZkFo0OCRES2Fvb53cX2TlfPr576UzxoXhd9E2ln90KWSEg
         YT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=/E6dWmgtCqmA40xfPP3l4Mpjmtx/eAoag7GT6kYqTfA=;
        b=NXTNaUkylds19qUIuA9lVTVvh0B7DIGEmhcPpvQsO91a8ESCmr/potouf7oq0KnqJp
         DivMq64L+hKQEQU0qPiyCOJFOij3esZ8SM3DYBBZSkdcwvCclClCgYxrMO6tcBvg4B3e
         W5U2oCPAdCUgE+sxeZTViKby7EHB5fKo8I3kqY9YSsfz585jEtqA6mc4zI8qoND7yW1l
         Fp56IuO2zedCPw8Wnv6IgIzxN/aNH3ez+pwVCoG+mDiLvDHTParKL1u/Rin9eu863eFO
         y1iG+UQTOWVTy6uhB7ssh6Zv0eALMViwg0bxaAq9lhUSRBw3vhFyDiYNuPqxAPKEvV8Y
         /oag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=DuytOIPx;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=DuytOIPx;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w1A7CsqA008832
X-Nifty-SrcIP: [209.85.213.46]
MIME-Version: 1.0
In-Reply-To: <20180210054843.z3g7wvcmlccvww3h@huvuddator>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator> <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator> <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 10 Feb 2018 16:12:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
Message-ID: <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1591997173495110755?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-10 14:48 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Fri, Feb 09, 2018 at 12:46:54PM -0800, Kees Cook wrote:
>> On Fri, Feb 9, 2018 at 4:46 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> > One thing that makes Kconfig confusing (though it works well enough in
>> > practice) is that .config files both record user selections (the saved
>> > configuration) and serve as a configuration output format for make.
>> >
>> > It becomes easier to think about .config files once you realize that
>> > assignments to promptless symbols never have an effect on Kconfig
>> > itself: They're just configuration output, intermixed with the saved
>> > user selections.
>> >
>> > Assume 'option env' symbols got written out for example:
>> >
>> >         - For a non-user-assignable symbol, the entry in the .config
>> >           file is just configuration output and ignored by Kconfig,
>> >           which will fetch the value from the environment instead.
>> >
>> >         - For an assignable 'option env' symbol, the entry in the
>> >           .config file is a saved user selection (as well as
>> >           configuration output), and will be respected by Kconfig.
>>
>> In the stack-protector case, this becomes quite important, since the
>> goal is to record the user's selection regardless of compiler
>> capability. For example, if someone selects _REGULAR, it shouldn't
>> "upgrade" to _STRONG. (Similarly for _NONE.) Having _AUTO provides a
>> way to pick "best possible for this compiler", though. If a user had
>> previously selected _STRONG but they're doing builds with an older
>> compiler (or a misconfigured newer compiler) without support, the goal
>> is to _fail_ to build, not silently select _REGULAR.
>>
>> So, in this case, what's gained is the logic for _AUTO, and the logic
>> to not show, say, _STRONG when it's not available in the compiler. But
>> we must still fail to build if _STRONG was in the .config. It can't
>> silently rewrite it to _REGULAR because the compiler support for
>> _STRONG regressed.
>>
>> -Kees
>>
>> --
>> Kees Cook
>> Pixel Security
>
> Provided that would be the desired behavior:
>
> What about changing the meaning of the choice symbols from e.g. "select
> -fstack-protector-strong" to "want -fstack-protector-strong"? Then the
> user preference would always be remembered, regardless of what's
> available.
>
> Here's a proof-of-concept. I realized that the fancy new 'imply' keyword
> fits pretty well here, since it works like a dependency-respecting
> select.
>
>         config CC_HAS_STACKPROTECTOR_STRONG
>                 bool
>                 option shell="$CC -Werror -fstack-protector-strong -c -x c /dev/null"
>
>         config CC_HAS_STACKPROTECTOR
>                 bool
>                 option shell="$CC -Werror -fstack-protector -c -x c /dev/null"
>
>
>         choice
>                 prompt "Stack Protector buffer overflow detection"
>                 default WANT_CC_STACKPROTECTOR_STRONG
>
>         config WANT_CC_STACKPROTECTOR_STRONG
>                 bool "Strong"
>                 imply CC_STACKPROTECTOR_STRONG
>
>         config WANT_CC_STACKPROTECTOR_REGULAR
>                 bool "Regular"
>                 imply CC_STACKPROTECTOR_REGULAR
>
>         config WANT_CC_STACKPROTECTOR_NONE
>                 bool "None"
>                 imply CC_STACKPROTECTOR_NONE
>
>         endchoice
>
>
>         config CC_STACKPROTECTOR_STRONG
>                 bool
>                 depends on CC_HAS_STACKPROTECTOR_STRONG


Do you mean

         config CC_STACKPROTECTOR_STRONG
                 bool
                 depends on CC_HAS_STACKPROTECTOR_STRONG && \
                            WANT_CC_STACKPROTECTOR_STRONG

or, maybe


         config CC_STACKPROTECTOR_STRONG
                 bool
                 depends on CC_HAS_STACKPROTECTOR_STRONG
                 default WANT_CC_STACKPROTECTOR_STRONG

?





>         config CC_STACKPROTECTOR_REGULAR
>                 bool
>                 depends on CC_HAS_STACKPROTECTOR_REGULAR
>
>         config CC_STACKPROTECTOR_NONE
>                 bool
>
> This version has the drawback of always showing all the options, even if
> some they wouldn't be available. Kconfig comments could be added to warn
> if an option isn't available at least:
>
>         comment "Warning: Your compiler does not support -fstack-protector-strong"
>                 depends on !CC_HAS_STACKPROTECTOR_STRONG
>
>         config WANT_CC_STACKPROTECTOR_STRONG
>                 ...
>
>
>         comment "Warning: Your compiler does not support -fstack-protector"
>                 depends on !CC_HAS_STACKPROTECTOR_REGULAR
>
>         config WANT_CC_STACKPROTECTOR_REGULAR
>                 ...
>
> This final comment might be nice to have too:
>
>         comment "Warning: Selected stack protector not available"
>                 depends on !(CC_STACKPROTECTOR_STRONG ||
>                              CC_STACKPROTECTOR_REGULAR ||
>                              CC_STACKPROTECTOR_NONE)
>
> Should probably introduce a clear warning that tells the user what they
> need to change in Kconfig if they build with a broken selection too.
>
>
> CC_STACKPROTECTOR_AUTO could be added to the choice in a slightly kludgy
> way too. Maybe there's something neater.
>
>         config CC_STACKPROTECTOR_AUTO
>                 bool "Automatic"
>                 imply CC_STACKPROTECTOR_STRONG
>                 imply CC_STACKPROTECTOR_REGULAR if !CC_HAS_STACKPROTECTOR_STRONG
>                 imply CC_STACKPROTECTOR_NONE    if !CC_HAS_STACKPROTECTOR_STRONG && \
>                                                    !CC_HAS_STACKPROTECTOR_REGULAR
>
>
> Another drawback of this approach is that it breaks existing .config
> files (the CC_STACKPROTECTOR_* settings are ignored, since they just
> look like "configuration output" to Kconfig now). If that'd be a
> problem, the old names could be used instead of
> WANT_CC_STACKPROTECTOR_STRONG, etc., and new names introduced instead,
> though it'd look a bit cryptic.
>
> Ideas?
>



FWIW, the following is what I was playing with.
(The idea for emitting warnings is Ulf's idea)


------------------>8-------------------
config CC
        string
        option env="CC"

config CC_HAS_STACKPROTECTOR
        bool
        option shell="$CC -Werror -fstack-protector -c -x c /dev/null"

config CC_HAS_STACKPROTECTOR_STRONG
        bool
        option shell="$CC -Werror -fstack-protector-strong -c -x c /dev/null"

config CC_HAS_STACKPROTECTOR_NONE
        bool
        option shell="$CC -Werror -fno-stack-protector -c -x c /dev/null"

config CC_STACKPROTECTOR
        bool

choice
        prompt "Stack Protector buffer overflow detection"

config CC_STACKPROTECTOR_AUTO
        bool "Auto"
        select CC_STACKPROTECTOR if (CC_HAS_STACKPROTECTOR || \
                                     CC_HAS_STACKPROTECTOR_STRONG)

config CC_STACKPROTECTOR_REGULAR
        bool "Regular"
        select CC_STACKPROTECTOR

config CC_STACKPROTECTOR_STRONG
        bool "Strong"
        select CC_STACKPROTECTOR

config CC_STACKPROTECTOR_NONE
        bool "None"

endchoice


comment "(WARNING) stackprotecter was chosen, but your compile does
not support it.  Build will fail"
        depends on CC_STACKPROTECTOR_REGULAR && \
                   !CC_HAS_STACKPROTECTOR

comment "(WARNING) stackprotecter-strong was chosen, but your compile
does not support it.  Build will fail"
        depends on CC_STACKPROTECTOR_STRONG && \
                   !CC_HAS_STACKPROTECTOR_STRONG
------------------------->8---------------------------------





BTW, setting option flags in Makefile is dirty, like follows:


ccflags-$(CONFIG_CC_STACKPROTECTOR_STRONG)  += -fstack-protector-strong
ccflags-$(CONFIG_CC_STACKPROTECTOR_REGULAR) += -fstack-protector

if ($(CONFIG_CC_STACKPROTECTOR_AUTO),y)
ccflags-$(CONFIG_CC_HAS_STACKPROTECTOR)        += -fstack-protector
ccflags-$(CONFIG_CC_HAS_STACKPROTECTOR_STRONG) += -fstack-protector-strong
ccflags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE)   += -fno-stack-protector
endif

if ($(CONFIG_CC_STACKPROTECTOR_NONE),y)
ccflags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE)   += -fno-stack-protector
endif




One idea could be to calculate the compiler option in Kconfig.

config CC_OPT_STACKPROTECTOR
        string
        default "-fstack-protector-strong" if CC_STACKPROTECTOR_STRONG || \
                                             (CC_STACKPROTECTOR_AUTO && \
                                              CC_HAS_STACKPROTECTOR_STRONG)
        default "-fstack-protector"        if CC_STACKPROTECTOR_REGULAR || \
                                              (CC_STACKPROTECTOR_AUTO && \
                                               CC_HAS_STACKPROTECTOR)
        default "-fno-stack-protector"        if CC_HAS_STACKPROTECTOR_NONE



Makefile will become clean.
Of course, this is at the cost of ugliness in Kconfig.




-- 
Best Regards
Masahiro Yamada
