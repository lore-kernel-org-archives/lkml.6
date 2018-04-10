Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx48Frw0CpYCqTwLxylUwr3IORdFXRFGWx+djV5xa9AaEejneDs52aY64qyowGjQCpAOYkCjG
ARC-Seal: i=1; a=rsa-sha256; t=1523341002; cv=none;
        d=google.com; s=arc-20160816;
        b=Ta4Ezoc4q2cUKWswoSAH/CvmNSoiDHnvXC4G/kXpr5Te2t3RRTj9NTQ4iApB4TvE3b
         8YSlgLneUoEnvRhYCuGpkWHW/ZFvTXYtCjkkxXwIRWD/BxopP6o4H6URcwjBGvaffZqS
         KUN9jQL/jJLe9P56sswd2UpjO84Wz6aCF+6VuYtSUaieAGjB068Bv+AWZ1wCInGml0Gy
         MEj5/Jz9WZ82iSuNHynKkn/Ei8fky2LGhtilzIIVpp1AV+hAwaifv/NsE0mPxD20wiKz
         GGJq+/+3LkqGGTz1Q98FUDKzrz9CbzibKFMZQL8UsQuvz/2s0N3C3bUTdforF49uSST2
         Bm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=RvR9Bo53++xLkOuKN6YSUuOa3L3xWVEODCcJegW0uRw=;
        b=s4Eu4H1+RaLwCizjGNaHnv5XxWRGmFcpUyGPT9/KrspOIFU3VHB9ONvK/rAIMC4SQX
         1VECYBGF532Q2w3i5y36SgjROnIYqO7OtlAxbK4SvBcTi/cXSTO6zf4VMQPL1ovDWdFs
         by6+ZkZkCpJIofH5/EDFxy59KcipZDExWaunhTUES77K+lnxx84tWjdk46tI9MpVoBor
         bAzkBkexMcQcqkBUu6jFPLqrHb2sTj12db+bm9yxlwqFhTVQXS1ZjyyRN+kw4RhSEwrw
         bE9uEpLyN5zEiBkRnoMCvcOrsgJhd53rhBw8hhuD39tr5uWGx5seogJT9H+n0mN9GHAt
         VeGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=MCG5Po0r;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=MCG5Po0r;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w3A6GOLo003264
X-Nifty-SrcIP: [209.85.213.52]
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJQfYXqsF7pcRsUtY9Mrw+Yi_Y6+CBAwDrQT_4kpUiHDA@mail.gmail.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-21-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jJQfYXqsF7pcRsUtY9Mrw+Yi_Y6+CBAwDrQT_4kpUiHDA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 10 Apr 2018 15:15:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATJidxieoNoo=CTk_-BpKJv8dwq+q1MAmsRDivd6ZrotQ@mail.gmail.com>
Message-ID: <CAK7LNATJidxieoNoo=CTk_-BpKJv8dwq+q1MAmsRDivd6ZrotQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/21] gcc-plugins: enable GCC_PLUGINS for COMPILE_TEST
To: Kees Cook <keescook@chromium.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067568210936951?=
X-GMAIL-MSGID: =?utf-8?q?1597338814454948853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-28 20:47 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> The plugin availability is checked in Kconfig, so all{yes,mod}config
>> will not be bothered.  Remove 'depends on !COMPILE_TEST'.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v2:
>>   - Remove more 'depends on'
>>
>>  arch/Kconfig | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 88cc925..b07094c 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -414,7 +414,6 @@ menuconfig GCC_PLUGINS
>>         bool "GCC plugins"
>>         depends on HAVE_GCC_PLUGINS
>>         depends on $(success $srctree/scripts/gcc-plugin.sh $HOSTCXX $CC)
>> -       depends on !COMPILE_TEST
>>         help
>>           GCC plugins are loadable modules that provide extra features to the
>>           compiler. They are useful for runtime instrumentation and static analysis.
>
> This one is nice, yes! We get coverage for anyone with plugin support.
>
>> @@ -424,7 +423,6 @@ menuconfig GCC_PLUGINS
>>  config GCC_PLUGIN_CYC_COMPLEXITY
>>         bool "Compute the cyclomatic complexity of a function" if EXPERT
>>         depends on GCC_PLUGINS
>> -       depends on !COMPILE_TEST
>>         help
>>           The complexity M of a function's control flow graph is defined as:
>>            M = E - N + 2P
>> @@ -487,7 +485,6 @@ config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
>>  config GCC_PLUGIN_STRUCTLEAK_VERBOSE
>>         bool "Report forcefully initialized variables"
>>         depends on GCC_PLUGIN_STRUCTLEAK
>> -       depends on !COMPILE_TEST
>>         help
>>           This option will cause a warning to be printed each time the
>>           structleak plugin finds a variable it thinks needs to be
>> @@ -527,7 +524,6 @@ config GCC_PLUGIN_RANDSTRUCT
>>  config GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
>>         bool "Use cacheline-aware structure randomization"
>>         depends on GCC_PLUGIN_RANDSTRUCT
>> -       depends on !COMPILE_TEST
>>         help
>>           If you say Y here, the RANDSTRUCT randomization will make a
>>           best effort at restricting randomization to cacheline-sized
>
> All three of these, though, please leave as they were. They're either
> needlessly noisy for COMPILE_TEST (GCC_PLUGIN_CYC_COMPLEXITY and
> *_VERBOSE),


CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is crazily annoying.
I wonder if the right thing might be to dump the log to
a separate report file instead of messing up the console,
but this is a different issue.
So I will keep this as-is.




CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE prinkles
 'userspace variable will be forcibly initialized'

If this is a matter of warning level,
we generally control this by W= option
as you see in scripts/Makefile.extrawarn

But, maybe I am wrong.  I will keep this as-is
until I figure out what is the right thing to do
for warning verbosity.




> or reduce the COMPILE_TEST coverage
> (GCC_PLUGIN_RANDSTRUCT_PERFORMANCE).
>

Can you explain a bit more about GCC_PLUGIN_RANDSTRUCT_PERFORMANCE?

IIUC, this option reduces the randomization.

Is it related to COMPILE_TEST coverage?






> (And perhaps a comment is needed to explain these to avoid confusion
> in the future?)
>
> -Kees
>
> --
> Kees Cook
> Pixel Security
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
