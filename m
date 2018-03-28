Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx486alhvTThi7coa8vMSm5guZ6hRYwH5+U/4HuRbMhifAMzTjBIfM776HtNrvjYEaFs0Yp+8
ARC-Seal: i=1; a=rsa-sha256; t=1522237977; cv=none;
        d=google.com; s=arc-20160816;
        b=Z8pXNgU4/AwPmpkmmXwHQ1Rqgt6mGdW1c1KCAXhFwOHFtWLv3rUKP64bHl3qyX1J1J
         pzdWTI54HuebgyyZsdZ6OhE6DJbEcbEs9YiZ2tHynNB8mDnewHzWHi124JqjGlirV2dh
         Ph5RHKsqd1jEaQcZP/I/W6tJWcqNM0Y7VUCPkcpSYJv4MQgshnWjHBz56vVrNuD1NDjh
         KTzIZfYRTWbNMFo53Y1PP5VwV/XRbN4IUHu1U3/sKoAQg4axit+s6ht2qjNvHmatOYAs
         ezzncF1RnxCSZN87hVmRLGjPfhK7Mhzpe9eDV+eWzMApG0qblUga8BRH9Tvy3I9aVvkS
         myug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=OWacSSt29Y6NdcQ3w7J26Y0n6eL4Fho+8E4PuW2vrNQ=;
        b=BpDdqmo4XQIrih7DgRmb0hkhd2ZqbOjUC+FuW60dyQ4f8sxZ37cb3wHQjxGzxwQVQ8
         j1E9uh5pxetARsxA4TloyWA6DBfp/nTtwy9EYpjSrdUDzqCtgrUBK1xSaonw/mTbForD
         Nix5PIkch6mM5VlLMh6t8Wu3ocqlTpvRKukgpG+jdt7FztZ72yUxvf0KE5A32C7RvMPP
         ZrG90M3zTiU1adouJL3PTmbgVJLbP0N/OwRkSRzBIDefXoVdRuB9++cr0rxuHApsbrAK
         IWGKP4DbzPEP7UmGJNnE1Ie0YyjMhJG69bJPsZHWOiOCxDocdSy4PdSD7fke/PuJXxru
         3V2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=m/W4pc6x;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=m/W4pc6x;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w2SBqg4S027794
X-Nifty-SrcIP: [209.85.213.53]
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK48XYSpga0M-49GPrMT3iud7rqEOD7ZpKQR-MXi=zjWw@mail.gmail.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-15-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jK48XYSpga0M-49GPrMT3iud7rqEOD7ZpKQR-MXi=zjWw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 28 Mar 2018 20:52:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQAvt7uWyY+FdnKfxzMBXHAgkxmycKm+-NRHYxo1LtLJA@mail.gmail.com>
Message-ID: <CAK7LNAQAvt7uWyY+FdnKfxzMBXHAgkxmycKm+-NRHYxo1LtLJA@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] kconfig: add CC_IS_CLANG and CLANG_VERSION
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
X-GMAIL-THRID: =?utf-8?q?1596067545333051904?=
X-GMAIL-MSGID: =?utf-8?q?1596182208912960641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-28 20:22 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> This will be useful to describe the clang version dependency.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> One aspect of clang version checking that may be "weird" (and likely
> won't be meaningful for very long as we're about to raise the minimum
> gcc version), is that clang claims to be gcc version 4.2 if you look
> at #defines. This is already handled in compiler.h, but may be weird
> in Kconfig.
>


CONFIG_CLANG_VERSION gives me real clang version.


$ clang --version
clang version 7.0.0 (http://llvm.org/git/clang.git
f1d1f4c4591e81cfa80034df094b26d7eb4fa92b)
(http://llvm.org/git/llvm.git
d157ba2f80790d23d717c4ff3f5bee30d98d6a51)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/masahiro/toolchains/clang-latest/bin

$ make CC=clang defconfig
*** Default configuration is based on 'x86_64_defconfig'
#
# configuration written to .config
#
$ grep  CLANG_VERSION .config
CONFIG_CLANG_VERSION=70000



I am just porting
https://patchwork.kernel.org/patch/10085765/
to Kconfig.


-- 
Best Regards
Masahiro Yamada
