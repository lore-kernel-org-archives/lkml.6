Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227ckF7O0e2ukOkErF3yAL6QOzuQjompVEBYr+Cf59FNzy7SEjq0tU0K+b82LqJnhNeuhbQb
ARC-Seal: i=1; a=rsa-sha256; t=1518109985; cv=none;
        d=google.com; s=arc-20160816;
        b=JKP508SklqTu4IuJdGARu9pZOAUHoD03IzmKzW1Uq52HZS2wyM4aBL4VZgaEDDzUdc
         XN0XiIGipGjdKKmxTR+MwG//5XxnhnXyr6WJO5jNz/Dvzo8f5amIEHn0AlaNh82bI0N8
         RFLhccM2+B7iyRgcXlbbThqDMkNTFSnDFeDtcVW2TrurUwfDTZfpbkd2wG+PLuXQK2gn
         xXgOAaeA4uaPMvkhldlNOJtgkKNFPOYi0Uu/sVVmcptH9U3igkbhP41dBmvC1PvgdwDd
         CtmhNnKtcmg45Oq/vnT5uvsqxGXNa1q95dkHLaw3+aod8WAj6YE8JO+RSwLsNFtVl1JU
         lM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=quo+TnQYI1nQ1NEGeCSzEqQDTsshMji9fJJVl6g8SZk=;
        b=UotUEi04qRVr6Fd7lwvvklc95q5sO+HU2tYETuUTvXBLQdTHkpgKNuvs3wj02apXbU
         XkymP2GM7oSQ0kJ4t6Vw8X4xs2lpt/Vlp0mQVNZFmFMpaAgG4lw5QL3HniA4KoxZwXGC
         yutpKVAyQTToGn6ANxUJJpDiWpDkHGdXWT/cOCOR5CwCZHcJEg/Pk1cW5Oi9hLyi6nRb
         yDmOoH7tCvNhGmypTn7OulrVgCRpyVI0mqdseK0JQaHZZCsxo8EKY5Kez6tCRZ6A2ffF
         5hFd4OJesDdBWHBfxbRcVFAZbL0GU/mYSgJP9uRa4rvSXZWix8g5EAbpxGQjiXDZrgA2
         2wxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=NJ9vc7ER;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=NJ9vc7ER;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w18HCa6R031342
X-Nifty-SrcIP: [209.85.217.176]
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJwsZM1O=r36TF4kNRX8NZaUq+jmTFjZMr4X5wKSYvfDA@mail.gmail.com>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
 <1517986811-27819-7-git-send-email-schwidefsky@de.ibm.com>
 <20180207100726.GB31392@amd> <1518005275.3677.112.camel@infradead.org>
 <20180207131719.4aeb316e@mschwideX1> <CA+55aFwVyCxWkcXk-y0WWo653XYWeZCRo-u4cy4rPWY++LMcgg@mail.gmail.com>
 <CAK7LNAQm09z7Lus=p-RGW4Q=95U9QzhV42eG3cnAA9nLiD6-Mw@mail.gmail.com> <CAGXu5jJwsZM1O=r36TF4kNRX8NZaUq+jmTFjZMr4X5wKSYvfDA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 9 Feb 2018 02:11:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQewHbO-xUGHjhwn1YQUQpEV+gbvwm89VH+keYN6kp35w@mail.gmail.com>
Message-ID: <CAK7LNAQewHbO-xUGHjhwn1YQUQpEV+gbvwm89VH+keYN6kp35w@mail.gmail.com>
Subject: Re: [PATCH 6/6] s390: introduce execute-trampolines for branches
To: Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Ulf Magnusson <ulfalizer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724559737732044?=
X-GMAIL-MSGID: =?utf-8?q?1591853696775921851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-08 9:57 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Thu, Feb 8, 2018 at 10:44 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-08 2:55 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
>>> What I would really want - and this is entirely unrelated to this
>>> particular case - is to have those damn compiler option tests as part
>>> of the config phase in general. We now have about a million of these
>>> crazy things, where we have config options that simply depend on which
>>> compiler we have, and we have no sane way to show them at
>>> configuration time.
>>>
>>> Though Andrew's tree I got yet another ugly hack
>>> (CONFIG_CC_STACKPROTECTOR_AUTO) that handles just _one_ special case
>>> by turning it into a special magic Kconfig entry in the main Makefile.
>>> See commit 44c6dc940b19 ("Makefile: introduce
>>> CONFIG_CC_STACKPROTECTOR_AUTO"). I wasn't sure if I really wanted it,
>>> and honestly, I'm still thinking of just reverting it, because it's
>>> _so_ ugly and _so_ wrong.
>>>
>>> What we need is an extension to the Kconfig language itself so that we can do
>>>
>>>    config CC_HAS_RETPOLINE
>>>         cc_option "-mindirect-branch=thunk -mindirect-branch-table"
>>>
>>> or something. And then we can make sane _conditional_ dependencies at
>>> Kconfig time, and our makefiles would be much cleaner too when you
>>> could just do
>>>
>>>      cflags-$(USE_RETPOLINE) += -mfunction-return=thunk -mindirect-branch-table
>>>
>>> because the validity of the C compiler flag has been tested when configuring.
>>>
>>> And then we could add that warning at configure time (or just disable
>>> the option there thanks to "depends on CC_HAS_xyz" logic).
>>>
>>> All our compiler option handling right now is just nasty nasty nasty crud.
>>>
>>> Adding more people in the hopes that somebody gets motivated.. I've
>>> talked about this before, so far we haven't made any progress.
>>
>>
>> Sorry for slow progress.
>>
>> I agreed this before, and still motivated.
>> (because I also motivated to remove kbuild cache.
>> This turned out not so clever as I first thought)
>>
>> I was trying to do this, but in this development cycle
>> I spent most of my time to flush out lots of piled up Kconfig patches.
>> Sorry.
>>
>> Unless somebody is working, I will.

I sent the first draft.

For people interested, I pushed the series in the following too.

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
kconfig-opt-shell-rfc



-- 
Best Regards
Masahiro Yamada
