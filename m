Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518444833; cv=none;
        d=google.com; s=arc-20160816;
        b=BKcHnIOMm9a8z6yX5OCCwZvVutvaoeYAlSPHdFDAarImq8EcRFRyi5+398mYwIoPuO
         7KC9UKLO9zViqBhpe8zmMz1t5zoSrLWsD38yYfQAJw3ZPBO7NlECvy30oyuAXeItHFGH
         Cfr6Elgm4DRz/u16CW/B8tSmhjFC7ORHqmGJzVb+dkonKFTX2kXg8xJ0OYJCIePBRlaz
         wXQhBF8tuq+ymptfs41eLGICQwR/G3Dgshgs9vEbiTLtPlKd2SjyV86pfRACk3o+HcSE
         EURTQF2Zm8OWDY3jIiWFWyPZbO6c4lhAZ+hNsoOLD2fbFRSiNrzkb0CgcN73yOzI1Lcl
         NThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=8ZDefpkFpzCh5FpkHwdyXxFIYxFDqwAY+0Aok1OJEaQ=;
        b=oyxnvAm4VWFfAcQ/9L7jag5EZCFxAdruxay/4FutvBZcGgUE4hQF4l6WeOQrg67UVg
         m3DF1vgBBWvJs5TDs6p3Ac+G7X2u0ydh45yIwlfmn3+Gf1+xgJqgxk/hta1cWEoVl0vQ
         EyI8ArCGdQkG8pGa/ABYaP/qMSf6zqd1Yj3XNxL4SN/WBhVOwvHO1Hj68IADBqVPcx7f
         b/O61kpgD7JGuTg0hy8T2vTBcM35LE71jnerGp4tG2tn7h+xlcmZt1TjmVenVJ5rjZof
         u2PhtagEtW8gxVJ4OoxZ1eJoXSnByNo28OTxsQbuJPnj2fF4zU4omvlH1kO0Vq7WqZop
         dNSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T/pc/EDl;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T/pc/EDl;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2257+bdCMmFXVpwmXOmZiCgBNpbCYAhEyDAAbCq7ocHMvpsRgoJhlNLnnukOhatTe65Tw79A7eEy7KXKKTlckVQ=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAR1tgw0hnjRF=T1tPkqA=_wSwn8x6Ux-LYsNCrqrbEyLg@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAK7LNARdm7UESEEh-2qEP9R8jWSwzZ4d2x=pZZPuj6EVAsXnAA@mail.gmail.com>
 <CAFkk2KQ+ybTQF4U9eHqhi-Hg8ML1Z72DsXij2sM58S5HHg6C-Q@mail.gmail.com> <CAK7LNAR1tgw0hnjRF=T1tPkqA=_wSwn8x6Ux-LYsNCrqrbEyLg@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 12 Feb 2018 15:13:52 +0100
Message-ID: <CAFkk2KRwpNv6ew4iZ9LM3YZU3HgOKZm34gtG3ZqGuP91mNJd4g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592204809178127491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 2:53 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-12 20:44 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>
>>>
>>> I think Linus's comment was dismissed here.
>>>
>>>
>>> Linus said:
>>>
>>>> But yes, I also reacted to your earlier " It can't silently rewrite it
>>>> to _REGULAR because the compiler support for _STRONG regressed."
>>>> Because it damn well can. If the compiler doesn't support
>>>> -fstack-protector-strong, we can just fall back on -fstack-protector.
>>>> Silently. No extra crazy complex logic for that either.
>>>
>>>
>>> If I understood his comment correctly,
>>> we do not need either WANT_* or _AUTO.
>>>
>>>
>>>
>>>
>>> Kees' comment:
>>>
>>>> In the stack-protector case, this becomes quite important, since the
>>>> goal is to record the user's selection regardless of compiler
>>>> capability. For example, if someone selects _REGULAR, it shouldn't
>>>> "upgrade" to _STRONG. (Similarly for _NONE.)
>>>
>>> No.  Kconfig will not do this silently.
>>
>> (Playing devil's advocate...)
>>
>> If the user selected _STRONG and it becomes unavailable later, it
>> seems to silently fall back on other options, even for oldnoconfig
>> (which just checks if there are any new symbols in the choice).
>>
>> It would be possible to also check if the old user selection still
>> applies btw. I do that in Kconfiglib. It's arguable whether that
>> matches the intent of oldnoconfig.
>>
>>>
>>>
>>> "make oldconfig" (or "make silentoldconfig" as well)
>>> always ask users about new symbols.
>>>
>>>
>>> For example, let's say your compiler supports -fstack-protector
>>> but not -fstack-protector-strong.
>>> CC_STACKPROTECTOR_REGULAR is the best you can choose.
>>>
>>> Then, let's say you upgrade your compiler and the new compiler supports
>>> -fstack-protector-strong as well.
>>>
>>> In this case, CC_STACKPROTECTOR_STRONG is a newly visible symbol,
>>> so Kconfig will ask you
>>> "Hey, you were previously using _REGULAR, but your new compiler
>>> also supports _STRONG.  Do you want to use it?"
>>>
>>>
>>> The "make oldconfig" will look like follows:
>>>
>>>
>>> masahiro@grover:~/workspace/linux-kbuild$ make oldconfig
>>>   HOSTCC  scripts/kconfig/conf.o
>>>   HOSTLD  scripts/kconfig/conf
>>> scripts/kconfig/conf  --oldconfig Kconfig
>>> *
>>> * Restart config...
>>> *
>>> *
>>> * Linux Kernel Configuration
>>> *
>>> Stack Protector buffer overflow detection
>>>   1. Strong (CC_STACKPROTECTOR_STRONG) (NEW)
>>>> 2. Regular (CC_STACKPROTECTOR_REGULAR)
>>>   3. None (CC_STACKPROTECTOR_NONE)
>>> choice[1-3?]:
>>>
>>>
>>>
>>> Please notice the Strong is marked as "(NEW)".
>>>
>>> Kconfig handles this really nicely with Linus' suggestion.
>>>
>>> [1] Users can select only features supported by your compiler
>>>     - this makes sense.
>>>
>>> [2] If you upgrade your compiler and it provides more capability,
>>>     "make (silent)oldconfig" will ask you about new choices.
>>>      - this also makes sense.
>>
>> If you switch to a compiler that provides less capability, it'll
>> silently forget the old user preference though.
>
>
> Yes, forget.
>
> So, "make oldconfig" will ask user preference again
> when you switch back to a compiler that provides more capability.
> This is not rude, right?

Nopes, makes perfect sense to me.

> To remember user preference (for both upgrade/downgrade capability),
> we need 3 symbols for each feature.
>
> [1] WANT_FOO
>     A user can enable this option regardless of compiler capability.
>     This will remember your preference forever.
>
> [2] CC_HAS_FOO
>     Compiler capability.
>
> [3] FOO
>     logical 'and' of WANT_FOO and CC_HAS_FOO.
>
> If we do this way, what's the point of
> moving compiler capability tests to Kconfig?

I think this would only be done for the stack protector stuff, if it's
really warranted to have an exception there.

For other symbols, you'd just silently turn them off if a feature they
depend on isn't there, which is the way Kconfig usually works anyway.

>
>
> [1] is the same as what we do now.
>
> Then, it will be disabled later
> if it turns out unsupported by your compiler.
>
> The only difference is,
> whether we calculate [2], [3] in Makefile or Kconfig.
>
> Kconfig is, in the end, inter-symbol dependency/visibility solver.
> The WANT_ is not using the benefit of Kconfig.
> We can calculate the logical 'and' by other means.

Yeah, once you go with the WANT_* stuff, it's probably only about
whether it's easiest to do it Kconfig or the Makefiles. If it's in
Kconfig you might have more of the logic in one place at least.

> The problem I see in this approach is 'savedefconfig'.
>
> 'make defconfig && make savedefconfig'
> will produce the subset of user preference and compiler capability.
>
> To make arbitrary set of CONFIG options,
> we need a full-featured compiler
> in order to enable all CC_HAS_... options.
>
>
> Maybe, we can add a new environment to ease this.
>
> KCONFIG_SHELL_ALWAYS_TRUE
>   If this environment is specified, all 'option shell=...'
>   will be evaluated as true.  So, all symbols that depend on
>   CC_HAS_  will be visible.   This is useful to make
>   arbitrary set of CONFIG options regardless of
>   your compiler capability.
>
>
> $ KCONFIG_SHELL_ALWAYS_TRUE=1  make  menuconfig
>    -> build up your favorite config setting
>
> $ KCONFIG_SHELL_ALWAYS_TRUE=1 make savedefconfig
>    ->  write out the minimum set of config
>
>
> Thought?

I wonder if this could cause problems if people start using 'option
shell=...' for other things besides feature tests. It assumes that 'y'
always corresponds to "available" too.

If the cc_opt Kconfig helper is added, then maybe it could just turn
all those 'y'.

Perhaps it wouldn't be so horrible to require people to generate
defconfigs on systems that have all the features they want in the
defconfig either.

Cheers,
Ulf
