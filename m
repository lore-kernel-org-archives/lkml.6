Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90E1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962D6216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962D6216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeI1Nen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:34:43 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33105 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbeI1Nem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:34:42 -0400
Received: by mail-ua1-f65.google.com with SMTP id i4-v6so1943547uak.0;
        Fri, 28 Sep 2018 00:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lx2kvmyzFXtyNwJo4GJFS0YazllSeFipqFTT7DhtrOs=;
        b=FTSuwUrQJvufF2Cf1/SrxASQTpskmRd5EGsW32w9o1se7wvgoa+j6TBNO3LQmUmrFZ
         cqi9hHYVB1eEJAdaxI558J19w5j39FIEUsMx40FcK7mMSCwPyul2CT93GxhZl8U+wmS0
         qUJuG2Rei3Q8oKHwrVNv/bQCbiW5BLi5uRcGLlJsjuZiAUCbzXr9+QEEWcxEEfzb+50h
         WtFki9aMjdacvfohn/oLMMcgL/GIfkRMq2uBx8cfpA2RvhiuiQeb+j3nEOACEMcdGCHx
         EJSRWkQ0qQ5fdTmvyyLrF426gWmRDJ7CoV7TSEF7UrHGwKbezxPw1sKYAVpQ2/IaGk7E
         dYxQ==
X-Gm-Message-State: ABuFfog2R4yHtZin8nYFtSLqYo85h16woeLclemjL9f5fjyqFQQSTcJ2
        ygqFifww7wh00PR2WzrVuHEw/V4/WedJ6Sd2nx8=
X-Google-Smtp-Source: ACcGV62hFqhddCYOAkeyvbwTuc5Q7Ublx5/L2D+WAc+On8WIEliqNIOcev36x4a+aTpJtC8OarVjpL+FAmC2FqNL324=
X-Received: by 2002:ab0:1e46:: with SMTP id n6-v6mr3058822uak.78.1538118742005;
 Fri, 28 Sep 2018 00:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
 <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Sep 2018 09:12:10 +0200
Message-ID: <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Sep 28, 2018 at 8:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 27 Sep 2018, Andy Lutomirski wrote:
> > I have a couple questions here:
> >
> >  - Is this actually okay on all architectures?  That is, are there
> >    cases where we'll screw up if we fail a USER_DS access this early?
> >    s390 stands out as the obvious special case (where USER_DS is not
> >    than just a subset of KERNEL_DS), but s390 opts out.
> >
> >  - Why doesn't x86 set HAVE_FUTEX_CMPXCHG?  Or do we still support
> >    some 32-bit configurations that don't have cmpxchg and don't know
> >    about it at compile time?
>
> I'm not entirely sure. Have to dig into the details. I assume S390 just can
> set it though.

Not sure. My "[PATCH] futex: Switch to USER_DS for futex test"
(https://www.spinics.net/lists/stable/msg28846.html), which is
basically the same
as this patch, broke s390, so it was never merged.

See "[BUG -next] "futex: switch to USER_DS for futex test" breaks s390"
(https://www.spinics.net/lists/linux-next/msg27902.html)

Heiko said:
| Martin and I discussed this today and we will change the s390 code so that
| it will also survive very early USER_DS accesses (without valid current->mm)
| since we also discovered a couple of other oddities in our code.

I don't know if that has happened, and whether it would work on s390 now.

> >  kernel/futex.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/futex.c b/kernel/futex.c
> > index 11fc3bb456d6..16bd3e72602a 100644
> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -3593,6 +3593,7 @@ static void __init futex_detect_cmpxchg(void)
> >  {
> >  #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
> >       u32 curval;
> > +     mm_segment_t old_seg;
> >
> >       /*
> >        * This will fail and we want it. Some arch implementations do
> > @@ -3604,8 +3605,11 @@ static void __init futex_detect_cmpxchg(void)
> >        * implementation, the non-functional ones will return
> >        * -ENOSYS.
> >        */
> > +     old_seg = get_fs();
> > +     set_fs(USER_DS);
> >       if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
> >               futex_cmpxchg_enabled = 1;
> > +     set_fs(old_seg);
> >  #endif
> >  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
