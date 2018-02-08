Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518051479; cv=none;
        d=google.com; s=arc-20160816;
        b=SBwW1Y6PG+CBmVEc1ydAko1zpC199vPtVca1qBK2+VevYqtPC5n03FJ3k2DyKzvu1X
         vCFnBnEUCO+/3JrOWkTV4x4CrrstTaLcB+n0j8hno+b0Ox+kvWb41Pnv/r/v+NWx0pQ3
         rtyXXYJhy0YfjcsZlQQEkHDd1Xax+re/Xan89qMo/4mP1fWOg5QwauNNFgnRBZ8pnKPT
         9rgRrETZCCUPlbW8kSDUskkgHjUFJDp5V8NdCfObH6LljJkrByEGiHb34YaxHMPh5VxC
         egsX6ZSAqzSDRWMuRIXjupEfLv1G0hHAm1VvlKmUuTZ/7xIIH+j8/wJpigsxrXBXslk5
         aEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=vhTJ5LQEQHc0CNBIPor7Dpem1d9eF5jOrT7/68oH5UM=;
        b=rETgu3sgdZW1ZFHSt472Have3jbx9gY2GIX6J8UWFYojPTvYI3Hf2O0E3VMQ9LF7Mc
         yMDRmEG28lEMY76MiV+3cGMZ55Tw9vdHdlb/Jk5RZ8vlhKiUOEPOeMWxvXl6Q/0gTuTD
         d+TKsYWM6agDLvnhgA7VEXUMedbbLT/vZfkbeakJqO4FKk5UP4y/RHhyKthf7cqvPlYL
         Jy2/3KkW73lpC4s4ZmdZ7b2bxS2lEAWUM7Z96jj40K8MjW1Y2uvVopyWgKiAeuP3ZtBw
         bQ8X8yQrn+ML6gPlqajm6K26d5oAIYiuDo1ROYJvO97TxVI5nS2UEwB1e1UJpEP7AJoV
         8IWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=V4lo81Mn;
       dkim=pass header.i=@chromium.org header.s=google header.b=A+N4kl9u;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=V4lo81Mn;
       dkim=pass header.i=@chromium.org header.s=google header.b=A+N4kl9u;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x225ldtwXKHnNlHZa/+ckYPUlVh65rXo4TVI5V0a41Yb4J9HHqfoTyUUxti8qIWpgFgvzr8COHiwBjG1dQY4FHCs=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAK7LNAQm09z7Lus=p-RGW4Q=95U9QzhV42eG3cnAA9nLiD6-Mw@mail.gmail.com>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
 <1517986811-27819-7-git-send-email-schwidefsky@de.ibm.com>
 <20180207100726.GB31392@amd> <1518005275.3677.112.camel@infradead.org>
 <20180207131719.4aeb316e@mschwideX1> <CA+55aFwVyCxWkcXk-y0WWo653XYWeZCRo-u4cy4rPWY++LMcgg@mail.gmail.com>
 <CAK7LNAQm09z7Lus=p-RGW4Q=95U9QzhV42eG3cnAA9nLiD6-Mw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Feb 2018 11:57:58 +1100
X-Google-Sender-Auth: adjQD5utoNym3WZNIAMnnL8hTNE
Message-ID: <CAGXu5jJwsZM1O=r36TF4kNRX8NZaUq+jmTFjZMr4X5wKSYvfDA@mail.gmail.com>
Subject: Re: [PATCH 6/6] s390: introduce execute-trampolines for branches
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, David Woodhouse <dwmw2@infradead.org>,
	Pavel Machek <pavel@ucw.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
	David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Ulf Magnusson <ulfalizer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724559737732044?=
X-GMAIL-MSGID: =?utf-8?q?1591792348715171433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 10:44 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-08 2:55 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
>> What I would really want - and this is entirely unrelated to this
>> particular case - is to have those damn compiler option tests as part
>> of the config phase in general. We now have about a million of these
>> crazy things, where we have config options that simply depend on which
>> compiler we have, and we have no sane way to show them at
>> configuration time.
>>
>> Though Andrew's tree I got yet another ugly hack
>> (CONFIG_CC_STACKPROTECTOR_AUTO) that handles just _one_ special case
>> by turning it into a special magic Kconfig entry in the main Makefile.
>> See commit 44c6dc940b19 ("Makefile: introduce
>> CONFIG_CC_STACKPROTECTOR_AUTO"). I wasn't sure if I really wanted it,
>> and honestly, I'm still thinking of just reverting it, because it's
>> _so_ ugly and _so_ wrong.
>>
>> What we need is an extension to the Kconfig language itself so that we can do
>>
>>    config CC_HAS_RETPOLINE
>>         cc_option "-mindirect-branch=thunk -mindirect-branch-table"
>>
>> or something. And then we can make sane _conditional_ dependencies at
>> Kconfig time, and our makefiles would be much cleaner too when you
>> could just do
>>
>>      cflags-$(USE_RETPOLINE) += -mfunction-return=thunk -mindirect-branch-table
>>
>> because the validity of the C compiler flag has been tested when configuring.
>>
>> And then we could add that warning at configure time (or just disable
>> the option there thanks to "depends on CC_HAS_xyz" logic).
>>
>> All our compiler option handling right now is just nasty nasty nasty crud.
>>
>> Adding more people in the hopes that somebody gets motivated.. I've
>> talked about this before, so far we haven't made any progress.
>
>
> Sorry for slow progress.
>
> I agreed this before, and still motivated.
> (because I also motivated to remove kbuild cache.
> This turned out not so clever as I first thought)
>
> I was trying to do this, but in this development cycle
> I spent most of my time to flush out lots of piled up Kconfig patches.
> Sorry.
>
> Unless somebody is working, I will.

FWIW, I did try to do this before I went with the STACKPROTECTOR_AUTO
solution, and it defeated me at every turn. Between the circular
dependency of the Makefile setting up KBUILD flags and Kconfig wanting
to know about the compiler, I got stuck. And it also seemed like the
cache was a problem too, as I couldn't find a way to re-evaluate the
script-controlled CONFIG items once it got cached.

And ultimately, a lot of the operational logic ended up sticking
around in the Makefile anyway (to provide fallback decisions, warns,
and errors). To correctly deal with the complex corner-cases for
stack-protector, I end up with three pieces:

the user config:

- do you want auto, weak, strong, or off?

the compiler tests:

- which of weak, strong, or off are supported?
- does the flag _actually produce working code_ for this
architecture/compiler version/etc?

and the build behavior:

- for auto, choose best available flag and warn if none
- for user-selected weak or strong, stop if unavailable/non-functional
- for off (or auto-none) use the "off" flag, if it is supported (to
force-disable it on ssp-by-default distro compilers)

And all of this needs to bypass the Kconfig cache, since if it gets
cached, it won't get re-evaluated when a selection is changed. If we
had a working "option shell $(CC) ..." then I could do the "compiler
tests" part in Kconfig, and I could probably do the bulk of the "build
behavior" logic in Kconfig too, though any intermediate configs would
need to avoid getting cached too.

The ssp handling has always been extremely complex due to all its gory
details, but I've tried _really_ hard to improve it, keep it
documented, and in one place (e.g. the compiler tests used to be
stuffed in per-arch Makefile).

-Kees

-- 
Kees Cook
Pixel Security
