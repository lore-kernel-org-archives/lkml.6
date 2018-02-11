Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518384125; cv=none;
        d=google.com; s=arc-20160816;
        b=wHPEwnhuNVONp5db3pT3cYEKVAPNXOjXACoFERqj8X0qf5GFynmUBHrfYlo9ODsPxk
         imWkJRMu6HrtlEd4ofd3BA50Td22RzOkOdlekPh2Z8UJHNty4ODuM/CyI4Y7o+pwIDfx
         sujsjt8DVuIFmi8XLc+3IBthUlVQcoKGqSKhhMskxNTXaaeDTh60Zx7Si/H1BphWQO8r
         8AOUvAHcYcID5wWbM6ZBPjznEDoiSXLI/660oa/CULY04SZViPf1m/J7/UqsLB03B2rM
         9wCM3jXgAF0Y0qaPOv+jBKMuyreqp6ya/JsrSG6kKskeUxKkGA5OFjeeowu7JQcbEOU8
         pDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1vyb5DlEF7a3OaSuw5gBD93M0Wa9TQ0rNw1txN91hsw=;
        b=lZ9ZE17gddRixoaDkNvJPhJEwF2uzv/JnfENE2cxWYK2OFgTiesvavTxm8TXZv1Zb8
         QyTLInBOZ02dCQJWWQEAhP0tpEmbTP9LzGz27Rkr5rcOuslvsZKr+im0JCHwjuHAlN0V
         lTxpVrrFeyzdbK1W72WHfzOMDub/q4ZyAUASmbK2GPUPxzqlmkhFB2zqLG4XavyCPFTD
         UMc7Z3Ck3OSxjQRRQY9spHtn87Y4guHRyp2rX/O9KG2y1OZ3yiQIJqnQediLFVMgXbGX
         9lf7iSXgFlfU7z3IJXcXYbUkKh2CNoQZerQ6J0Oun+k442rB5JQh+wEvlQGfRy+sNC4z
         qt5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=by2EBk94;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=by2EBk94;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2275Z+hnE3/cyJWVqJwmDKYj/7cjehTU/33knMgmZrsPHGAEIpGPaQHlKGP9ISu3VQGsugBck/p50ThmICDENZM=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 11 Feb 2018 22:22:04 +0100
Message-ID: <CAFkk2KQBCUT84rH22-+e6=hstQcdcpKQ7SM8=0SshrQ++vbMKg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592141152984091069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 6:56 PM, Kees Cook <keescook@chromium.org> wrote:
>> 3. Whether to implement CC_STACKPROTECTOR_AUTO in Kconfig or the Makefiles
>>
>> I'd just go with whatever is simplest here. I don't find the Kconfig version
>> too bad, but I'm already very familiar with Kconfig, so it's harder for me to
>> tell how it looks to other people.
>>
>> I'd add some comments to explain the idea in the final version.
>>
>> @Kees:
>> I was assuming that the Makefiles would error out with a message if none of the
>> CC_STACKPROTECTOR_* variables are set, in addition to the Kconfig warning.
>
> That doesn't happy either before nor after _AUTO. The default value
> before was _NONE, and the default value after is _AUTO, which will use
> whatever is available.

I was thinking in the case where you explicitly select one of
CC_STACKPROTECTOR_{STRONG,REGULAR} and it isn't available. With the
new WANT_* version, that will cause none of
CC_STACKPROTECTOR_{STRONG,REGULAR,NONE} to be set, and in that case
you'd error out to match the old behavior (if I understand it
correctly).

CHOSEN_CC_STACKPROTECTOR_AVAILABLE would just be a helper symbol to
detect that case. It's not like it's a huge deal to detect it on the
Makefile end either, but turns it pretty nice and readable, IMO, with
more of the logic in a single location.

>>         # User request
>>         WANT_CC_STACKPROTECTOR_AUTO
>>         WANT_CC_STACKPROTECTOR_STRONG
>>         WANT_CC_STACKPROTECTOR_REGULAR
>>         WANT_CC_STACKPROTECTOR_NONE
>>
>>         # The actual "output" to the Makefiles
>>         CC_STACKPROTECTOR_STRONG
>>         CC_STACKPROTECTOR_REGULAR
>>         CC_STACKPROTECTOR_NONE
>
> This should be fine too (though by this point, I think Kconfig would
> already know the specific option, so it could just pass it with a
> single output (CC_OPT_STACKPROTECTOR below?)

Ah, yeah, that'd be simpler if all that's needed is the compiler flag.

Cheers,
Ulf
