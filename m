Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BEDC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAF62087E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYyvijAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfAYS3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:29:48 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34458 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfAYS3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:29:48 -0500
Received: by mail-yw1-f66.google.com with SMTP id g75so4298825ywb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Hd0xLUBccaWgZV4P39EiAtUCWkkIREEP9KA/fKQb64=;
        b=cYyvijAGASiLQVyPaNpKFnF+PPk5Ak4IISWNTvNC0A+4XaScUwAxncoLJJt0EWPxPj
         JLbAjcfriwUpE7PN1klrcf31c8HSqTmV6ZUo3ewZMv+gpph/HaLsBXY6Unbsu9UUIPpe
         CEgkaC/zfy845JK2L7vqsXtA5VhBh/3jXiAOWlAwBhPr5nWYlvIv+5tWq8IMpZhsjt0v
         EY2ZCmJD54SOPq3OuhDiLDhqcf5C3xbwM8D9lMVQXIARpmPdhK38xWKmqdl6B0YuyIZ3
         kxm0F9SVScwgprRnyn5v/JkKdIpA/cK5yIfMvU4nG3Ibl5SpqIJZ68mRjYBzB8naubOX
         6SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Hd0xLUBccaWgZV4P39EiAtUCWkkIREEP9KA/fKQb64=;
        b=i9+Wk8LkG8rCC7U0dCPsKOav181Miij6vaf0A/YsZ7knMNzk5WqZ650rQhWdoNIVhz
         8PMLDUVSyYQUZvpT6BGfVJ03YwZf3vJIh0swVOqv6LDf7eG/qFASf7vkmtBcIrvBvE4A
         MlM91ga69c8XhFR91MxrAjcEFFNhdkeyc27Gen967k/j7lasrq0Kf/um0uENcoz/CbTy
         QRJSOrkJapNzeOfO0wMqFMRm/hejrkbFHr1A66V9IU14QD8nbCui840/CZq8KqIj8QHO
         svpWv7wIR/Qo7CVUI0DtcdgnxUfCS+LQF223/1DkivUVQ7vA6PuRheejkRgcZAq4S043
         P8aA==
X-Gm-Message-State: AJcUukeVkBO6luxqzZZ8TMYuXgGRcpoWsvRXDKyL7tnv9SPg9Q7cnVor
        xKmuralTl+OXOwSyOYMCbdwCvKfuYnlxN/FOZ18tpfy+
X-Google-Smtp-Source: ALg8bN5f9AnOLzMm7KD3RClCIkLasggaQBXDmR6aHGvtKnPY4Eo9uxSlySLDBJM+W3tYk1wRtwj+owU5BW3Lmj09zjM=
X-Received: by 2002:a0d:ea81:: with SMTP id t123mr12004415ywe.496.1548440987410;
 Fri, 25 Jan 2019 10:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20190125025747.1853-1-jcmvbkbc@gmail.com> <CAMuHMdV-HiZt9PP6LyF8c=7ARNbMX3bJH6r6Ru7koBxEu+9ZSw@mail.gmail.com>
In-Reply-To: <CAMuHMdV-HiZt9PP6LyF8c=7ARNbMX3bJH6r6Ru7koBxEu+9ZSw@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 25 Jan 2019 10:29:35 -0800
Message-ID: <CAMo8BfK_scDwFor7j_LX4wEoOj2gpotD-i0xD3UPy89W0ekdnA@mail.gmail.com>
Subject: Re: [PATCH] treewide: get rid of HAVE_FUTEX_CMPXCHG
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

> > --- a/arch/m68k/Kconfig
> > +++ b/arch/m68k/Kconfig
> > @@ -20,7 +20,6 @@ config M68K
> >         select GENERIC_STRNLEN_USER if MMU
> >         select ARCH_WANT_IPC_PARSE_VERSION
> >         select ARCH_USES_GETTIMEOFFSET if MMU && !COLDFIRE
> > -       select HAVE_FUTEX_CMPXCHG if MMU && FUTEX
>
> I guess it didn't really matter for !MMU?

I see that m68k uses generic futex.h, which doesn't depend on
MMU vs noMMU.

> > --- a/include/asm-generic/futex.h
> > +++ b/include/asm-generic/futex.h
> > @@ -136,6 +136,8 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
> >         return ret;
> >  }
> >
> > +#define arch_have_futex_cmpxchg() (0)
>
> This is for the SMP=y case only, right?

Yes, that's where generic implementation always returns -ENOSYS

> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -174,7 +174,11 @@
> >   * double_lock_hb() and double_unlock_hb(), respectively.
> >   */
> >
> > -#ifdef CONFIG_HAVE_FUTEX_CMPXCHG
> > +/*
> > + * Architectures should define this macro if futex_atomic_cmpxchg_inatomic()
> > + * may not be always working.
> > + */
> > +#ifdef arch_have_futex_cmpxchg
>
> Shouldn't this be #ifndef now...

Oops, thank you.
I thought I've build-tested both cases, but I obviously haven't...

> > @@ -3880,7 +3864,9 @@ static int __init futex_init(void)
> >                                                futex_hashsize, futex_hashsize);
> >         futex_hashsize = 1UL << futex_shift;
> >
> > -       futex_detect_cmpxchg();
> > +#ifdef arch_have_futex_cmpxchg
> > +       futex_cmpxchg_enabled = arch_have_futex_cmpxchg();
>
> ... else you're assigning to the constant:
>
>     error: lvalue required as left operand of assignment

Will send v2...

-- 
Thanks.
-- Max
