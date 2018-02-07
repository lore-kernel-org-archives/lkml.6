Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225LW1s33L5VsaHOHNLAdrdu8Z6ZxSp4LfH/eLV483X6DlWYN5boUfLH89mcQCyh+aX4wQCE
ARC-Seal: i=1; a=rsa-sha256; t=1518047155; cv=none;
        d=google.com; s=arc-20160816;
        b=SBr2QlIJh8Vo4HzGP6ORCtrbWKqxeYp0Ivg0SOZdJUefzARmc/HSxUugdjuMQD94nB
         WJFCr1RkY6Z1wWCBP9T59R9hKBpea74bZ9Wi6VIh906remoJzQOf7A7W3gpiLXowYkSU
         /XMhiLKubVOsE7TSsVye0Ea5cz1S7HpGr43em0JnBlHjd9FVZ+tArNAx+6Wh7hfkppGT
         dqANohH50ODPtihvNydDcorIsr5jTxmlsupBU5P1pr9Te+4Bq65eAx6oipbbT8gDUd73
         divLd3nGwaTifNhnDsGb9WVI7LxKwrcrmthWAy0PruwdeHE4CL5SpblwA27GFMp3QjUw
         QmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=0ZESHiE5dG3curQkNH/Hhy0pjb57a2Yh3T7LeL1u+KY=;
        b=BiXJz1bPizSQehgTJ2JkEEExQm7mLpcQbRI3klowirVp6w41XlOEWtHuEfnaN0/aHn
         9nan420+PYnidOBZMBI3OWp9VX/1YYNf3iYQyKl1bSuIB+zy97/ga2AwIQVqAiWz2tUt
         JgT5zIpcflBBYDBPwcIPxMTEYGfdKhrA3ew9Tkpub9j0fkxBKQmAyLXiIvSV9azeIGKt
         JoWC4YMnu+oK0GccntGa1RuzzYAPnaJH9nqv/1Qw2ICdy+ujKS7P8hi0NEQASoEJsxOD
         OpCD2icnNSraZPlzLVZDhrBP4BwXvJNoDN61I5fyaBc4bLDP5nf5i2wRjFw7M7z+n13z
         AbKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=kuix1Yd+;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=kuix1Yd+;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w17NjZS5014051
X-Nifty-SrcIP: [209.85.217.182]
MIME-Version: 1.0
In-Reply-To: <CA+55aFwVyCxWkcXk-y0WWo653XYWeZCRo-u4cy4rPWY++LMcgg@mail.gmail.com>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
 <1517986811-27819-7-git-send-email-schwidefsky@de.ibm.com>
 <20180207100726.GB31392@amd> <1518005275.3677.112.camel@infradead.org>
 <20180207131719.4aeb316e@mschwideX1> <CA+55aFwVyCxWkcXk-y0WWo653XYWeZCRo-u4cy4rPWY++LMcgg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Feb 2018 08:44:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQm09z7Lus=p-RGW4Q=95U9QzhV42eG3cnAA9nLiD6-Mw@mail.gmail.com>
Message-ID: <CAK7LNAQm09z7Lus=p-RGW4Q=95U9QzhV42eG3cnAA9nLiD6-Mw@mail.gmail.com>
Subject: Re: [PATCH 6/6] s390: introduce execute-trampolines for branches
To: Linus Torvalds <torvalds@linux-foundation.org>
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
        Kees Cook <keescook@chromium.org>, Ulf Magnusson <ulfalizer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724559737732044?=
X-GMAIL-MSGID: =?utf-8?q?1591787814734455429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-08 2:55 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Wed, Feb 7, 2018 at 4:17 AM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
>>> That isn't, though. Linus asked us to drop the $(warning) part.
>>>
>>> ... and then spent a week building with a non-retpoline compiler and
>>> not noticing, so he might have changed his mind ;)
>>
>> I found the warning to have some value, it helps for the case where my
>> fingers are faster than my brain and I type "make" instead of "smake"
>> which uses the alternative compiler with the required support.
>>
>> @Linus: do you want a warning or prefer not to have one ?
>
> Honestly, I think I'd be much happier with the warning as part of the
> "make config" phase.
>
> What really annoyed me was that it showed up at every build.
>
> What I would really want - and this is entirely unrelated to this
> particular case - is to have those damn compiler option tests as part
> of the config phase in general. We now have about a million of these
> crazy things, where we have config options that simply depend on which
> compiler we have, and we have no sane way to show them at
> configuration time.
>
> Though Andrew's tree I got yet another ugly hack
> (CONFIG_CC_STACKPROTECTOR_AUTO) that handles just _one_ special case
> by turning it into a special magic Kconfig entry in the main Makefile.
> See commit 44c6dc940b19 ("Makefile: introduce
> CONFIG_CC_STACKPROTECTOR_AUTO"). I wasn't sure if I really wanted it,
> and honestly, I'm still thinking of just reverting it, because it's
> _so_ ugly and _so_ wrong.
>
> What we need is an extension to the Kconfig language itself so that we can do
>
>    config CC_HAS_RETPOLINE
>         cc_option "-mindirect-branch=thunk -mindirect-branch-table"
>
> or something. And then we can make sane _conditional_ dependencies at
> Kconfig time, and our makefiles would be much cleaner too when you
> could just do
>
>      cflags-$(USE_RETPOLINE) += -mfunction-return=thunk -mindirect-branch-table
>
> because the validity of the C compiler flag has been tested when configuring.
>
> And then we could add that warning at configure time (or just disable
> the option there thanks to "depends on CC_HAS_xyz" logic).
>
> All our compiler option handling right now is just nasty nasty nasty crud.
>
> Adding more people in the hopes that somebody gets motivated.. I've
> talked about this before, so far we haven't made any progress.


Sorry for slow progress.

I agreed this before, and still motivated.
(because I also motivated to remove kbuild cache.
This turned out not so clever as I first thought)

I was trying to do this, but in this development cycle
I spent most of my time to flush out lots of piled up Kconfig patches.
Sorry.

Unless somebody is working, I will.



-- 
Best Regards
Masahiro Yamada
