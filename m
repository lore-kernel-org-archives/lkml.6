Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519222754; cv=none;
        d=google.com; s=arc-20160816;
        b=OvccwRQyT0dWl4ckPK+/kDLOrZbnT5fPJuv0UP6pm6+9b7OkeoXqten4ZkrDGPtB92
         Tw+HhnE/xIBu5WK/vP3QThDi8rlFnMeSjB7lYmW0bDpzCtZoLDIZ84SoRA8rrVb1ZmCc
         mwBnvPeIxgQtvES8VhWkAcOlWXqFjOl/llVHAt/yWf0RHPo9rRXWcOEKI21IUzOFBVzj
         XtewDcb7kkZWCDlN/XZVv6xEq9CQ8IciwxEYg2pn+RKrTXWqR2deRj7LTWnfu/aoIL5M
         qpYYoA7B86cCD47lxoKYiPSkgeiIpEcm/yLEVc4x/jWPcJr0eJFJe8jErsgBxzxokoyj
         kXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=4uZsIEHeOmUcBwaUv233PXHC81LBBDxs1yfCPr7nQs8=;
        b=q/uuF4XgYSx8+rm3kAJYFVpwZ9cJTcPoGxJ0lNk/60i7NAXVRtRje54YShS/cEc2Ap
         j7CDVR7XnqBebG75bJpPUMr9WypT9o5CKETfhx7lx1pJZhoNC4SRyVbbRmZYgMP2p3Bi
         xJaJy7LCInDocKvgM9TZOnoNfggQFX1L98uzNlrvlfYdLZFhm9hJQj1ZP+GTtstuJ7dC
         3S8qLrIJx7g2zno+EGIsytW2/+WpyKgcZoOKn9pA0wWCzwcAHoqKcagcJkfHxiulnsl2
         ApP8MUsW15G6NLEgHfcXIMA3jARNbwzuuNG7Ei4W2JSWJ28ecyF8/HzWwyocDf/j1A+m
         IPhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ot/Kh6VI;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ot/Kh6VI;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AH8x227WNs2WlHpuFZ+xUqHcJjwTAarmen/Mcw8gKEbb4stOeAxdr9nuobXxQ2KhcM0KThAqaJuMlBU24hYtyCWyo6E=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1519219410.10722.25.camel@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
 <1519170907.4326.17.camel@perches.com> <1eac0dc6-93b0-2e01-075f-cf62c85318c5@prevas.dk>
 <1519219410.10722.25.camel@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2018 15:19:13 +0100
X-Google-Sender-Auth: 6tU2fQQPZaaIeNZvnuPG4h-FGg0
Message-ID: <CAMuHMdX6HeqB6wUSUCT4L9S2G6YCB9-r6Q4B3dojEUv0iY+duw@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Mark Salyzyn <salyzyn@android.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>, Jonathan Corbet <corbet@lwn.net>,
	Jonathan Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957911897092414?=
X-GMAIL-MSGID: =?utf-8?q?1593020518656087060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 2:23 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2018-02-21 at 08:38 +0100, Rasmus Villemoes wrote:
>> On 2018-02-21 00:55, Joe Perches wrote:
>> > On Tue, 2018-02-20 at 23:43 +0200, Andy Shevchenko wrote:
>> > > There are users which print time and date represented by content
>> > > of
>> > > struct rtc_time in human readable format.
>> > >
>> > > Instead of open coding that each time introduce %ptR[dt][rv]
>> > > specifier.
>> > >
>> > > Note, users have to select PRINTK_PEXT_TIMEDATE option in a
>> > > Kconfig.
>> >
>> > Not sure this is a great option.
>> > Not just the name, the need to select it.
>>
>> Bikeshedding first: If you do keep the config option, please use
>> PRINTF,
>> not PRINTK - vsprintf can be and is used by lots of code other than
>> printk.
>
> OK.
>
>> Well, on the one hand, I like to reduce the size of the kernel when
>> possible and ideally make all new functionality guarded by config
>> options, but OTOH, how much does compiling out the datetime formatters
>> really save?
>
> https://lists.01.org/pipermail/kbuild-all/2017-June/034950.html
>
> I understand that half a year time allows us to increase kernel text
> size by 750+ bytes unconditionally.
>
> I would really like to not use any option.

Agreed.

FTR, growth of my atari_defconfig kernel between v4.7 and v4.15:

add/remove: 351/155 grow/shrink: 691/429 up/down: 63095/-38665 (24430)
add/remove: 394/156 grow/shrink: 595/709 up/down: 61173/-31092 (30081)
add/remove: 1315/711 grow/shrink: 1269/442 up/down: 172871/-92075 (80796)
add/remove: 525/266 grow/shrink: 914/510 up/down: 116115/-46240 (69875)
add/remove: 443/222 grow/shrink: 906/456 up/down: 77807/-40657 (37150)
add/remove: 536/296 grow/shrink: 1043/652 up/down: 97366/-65459 (31907)
add/remove: 413/176 grow/shrink: 711/479 up/down: 75678/-41356 (34322)
add/remove: 311/145 grow/shrink: 898/438 up/down: 51655/-26851 (24804)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
