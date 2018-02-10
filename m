Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518290639; cv=none;
        d=google.com; s=arc-20160816;
        b=MLNzXe1SFzHWWWhrK61EkoaqsGIA9acnS3T1Fe31I0GQSjf+SbNuPL7Qup4ml23+E6
         VbaluOkCCeV6s2q0n0VdNxJtDNY+NbhgzEj/oazd6ML6uru2k/gdtdbROz3zNdzH+ys4
         Edg/2f3QuVfIqQzUUAEhcGwTtKdRD2WCz7jups8s586wI55OFG236uKSL1JP+YL3QPSU
         cPLgNFy4wO+mPf2O7fi6P7B3xU0ip9oyWMEHWzF3HJz5yxe53QZzGdeZT5JMg0sM1hGB
         fZsgP/hQlx7pFRdSjxJbpbZ95sbLdEB+3cDflQ4MSZJK0Uq7KM2dKfSajrG8y8AMgZPX
         yV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ot7QSzaLe/HM3r3BUS7EAlMprWtlPVH/1jMg0W1t8oM=;
        b=lhLcvhz14ZBaJ7LaSSueVXBbW+WBCC/tN3Vegz7pXuLxfQmxWVqYSY655gtUdrXOay
         JD39lUuIEa5YJThSmTT11ufGWdyVgwTiHpBwDhHN6GbjX2JV+bQVQeQgamNGC5OmXhi9
         38TUStJKQ0Mm/UJl/HDCjzoo1QEDuL0/VRJKVt+JzUzT3lyinwlpEhEjIC2zQySRutMl
         3fRN0OsRmdKmfpiHOe1djuDN12jWChbuLbEpSt0TOg0IF+5TCYGXHMYtrliKQIhCGTcw
         B3N+Yud7oAkMkGNAWCNSlHNpCvQOpYK36bc2sSG36gIHN2WOBLh1pibh2H6l8yqBxHos
         ShTw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=LMQFuypo;
       dkim=pass header.i=@chromium.org header.s=google header.b=PGaTQfhT;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=LMQFuypo;
       dkim=pass header.i=@chromium.org header.s=google header.b=PGaTQfhT;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x227DtSultWNsvR4BdqWRv0BXprvRMaZtIWTynak/7LeJB8AiRdKrRN9Tv3bsLtKpnDyt80JCVCUnYL5rRSV4/YQ=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180210085519.737ckf4bcl57h4g2@huvuddator>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator> <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator> <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
 <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 10 Feb 2018 11:23:58 -0800
X-Google-Sender-Auth: EBcKCEwW5MDsB4Cu03QGoepio3Q
Message-ID: <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592043125632755659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 12:55 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> Here's a complete updated example, with some stuff from Masahiro added.
>
> Turns out warnings inside choices get cut off easily in menuconfig, so I
> went with just a single warning instead (which should be enough anyway).
>
> With this version, the only "outputs" that the Makefiles needs to look
> at are CC_STACKPROTECTOR_{STRONG,REGULAR,NONE} (and
> CC_OPT_STACKPROTECTOR). WANT_CC_OPT_STACKPROTECTOR_AUTO is handled
> automatically.
>
> The caveat related to old .config files mentioned above still applies.
>
> How many compilers don't support -fno-stack-protector by the way?
>
>         config CC_HAS_STACKPROTECTOR_STRONG
>                 bool
>                 option shell="$CC -Werror -fstack-protector-strong -c -x c /dev/null"
>
>         config CC_HAS_STACKPROTECTOR_REGULAR
>                 bool
>                 option shell="$CC -Werror -fstack-protector -c -x c /dev/null"
>
>         config CC_HAS_STACKPROTECTOR_NONE
>                 bool
>                 default y
>                 option shell="$CC -Werror -fno-stack-protector -c -x c /dev/null"

Instead of just $CC for these, we need the test script that runs with
all the per-architecture flags configured and runs the actual _build_
test of the output. It is, unfortunately, not sufficient to test that
the compiler supports the flag: it has to be tested to produce the
correct output too, as there are continual regressions here (old
compilers, misbuilt compilers, misconfigured compilers, etc).

So, if this could do something like this:

        config CC_HAS_STACKPROTECTOR_STRONG
                bool
                option
shell="scripts/gcc-${ARCH}_${BITS}-has-stack-protector.sh $CC
$KBUILD_CPPFLAGS"

then this could all work from Kconfig.

>         choice
>                 prompt "Stack Protector buffer overflow detection"
>                 default WANT_CC_STACKPROTECTOR_AUTO

Otherwise, this WANT_ approach looks decent.

>         comment "Warning: Selected stack protector not available"
>                 depends on !(CC_STACKPROTECTOR_STRONG || \
>                              CC_STACKPROTECTOR_REGULAR || \
>                              CC_STACKPROTECTOR_NONE)

For WANT...AUTO, a warning is fine. for WANT...STRONG or
WANT...REGULAR this must fail the build.

>         config CC_OPT_STACKPROTECTOR
>                 string
>                 default "-fstack-protector-strong" if CC_STACKPROTECTOR_STRONG
>                 default "-fstack-protector"        if CC_STACKPROTECTOR_REGULAR
>                 default "-fno-stack-protector"     if CC_HAS_STACKPROTECTOR_NONE
>                 # If the compiler doesn't even support
>                 # -fno-stack-protector
>                 default ""
>
> Of course, at some point you're just moving complexity from one place to
> another. Maybe this all-Kconfig approach isn't worth it if people find
> it harder to understand. I don't know how bad the Makefiles are here at
> the moment.

FWIW, it feels more readable in Kconfig, if we can solve the circular
issue of $KBUILD_CPPFLAGS...

-Kees

-- 
Kees Cook
Pixel Security
