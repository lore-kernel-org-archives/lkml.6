Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDF6C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DE7206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="TrQ8p7Vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DE7206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeI2A1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:27:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55905 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeI2A1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:27:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so3078966wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bItNCzbIip1U0eRatOVgiKLhunondv56R2ZU+g5mRGg=;
        b=TrQ8p7Vket9a4tmyqKnxpATG9DBuJ5Px2QyTIgtorKte38PRYEiTvFQB6Uxtw/1LVX
         NhetuzwgbyGLDbNKdHEopsHGopsO5GVZ6pbPkZO1F82LyYqwC5klPHtka5Xh3CeFX10y
         thBibmOz0okXEaqxQ5OBOKb2pq3SF56AeM/iPJLxorJYbR5RMjmn8QhCHMYyId2Gbxnh
         cVPgohEIxyLyTavR8ttNbVFvJIIyv+b7AEUFekL/BeIQRiMd5LTQF3v5wxvL+7zwWFpZ
         hNZMCLVyNHJARdBOVwZgqyqGgvT1qjkkRdAALK7Jnk35yZXMOKbeULOUmwN5clOnGH++
         BBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bItNCzbIip1U0eRatOVgiKLhunondv56R2ZU+g5mRGg=;
        b=JFoh/EyOs7ufgCGB7zzmhNjSp9q7dPomx0dd+Kd0TGPKdCBbkp0MlcbXXM9dymJL4P
         qKCh7lyUb3LrI1dOSRj5JznKzYVjACL5jD9pQvLpe0rTaqjlzYi0TOqAihheSQkJXOzv
         B1rZ6VQdkLSrlfF7E+HHNmuQzFhZTVjlRcKnr5vhqEdaW7IAC3VxCxjJZWWbuLrVrd3d
         zUj2lq/rRG5Wvayy6ezLHGkM/3rZZv+OBJUMYPkPLPgTc1B7WFwToZBGFQVJXXsjemo3
         CcaQjpGqoqdE9GSBiK1GdtZW1GZDFhN62yT+Idvo/cIOaZJvNfuSa9+VPiuuFiIo4cEF
         4SSw==
X-Gm-Message-State: ABuFfojgFxVwWlkbJdsn7qSRLfp88bc6GqtXQmzsxNZ+nQUfEp5UQnIg
        q3x7hcCFhUnwZXUT9sFnOFAWq4iuFIsNsqRn4d+u7w==
X-Google-Smtp-Source: ACcGV60kpWJh/qocEQAW7aFz8ubjSnB+yaFO9bG2aCkcDBTIzrqtGNBpInxh75RZt7fzI3oMBADgEhSD6zUwxODjUnk=
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr2574458wmd.128.1538157757987;
 Fri, 28 Sep 2018 11:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
 <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
 <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
 <20180928103726.07761672@mschwideX1> <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de>
 <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net> <20180928165321.0ddaf948@mschwideX1>
In-Reply-To: <20180928165321.0ddaf948@mschwideX1>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 28 Sep 2018 11:02:26 -0700
Message-ID: <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        fthain@telegraphics.com.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 7:53 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> On Fri, 28 Sep 2018 07:11:44 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>
> > > On Sep 28, 2018, at 1:42 AM, Thomas Gleixner <tglx@linutronix.de> wro=
te:
> > >
> > >> On Fri, 28 Sep 2018, Martin Schwidefsky wrote:
> > >> On Fri, 28 Sep 2018 09:12:10 +0200
> > >> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >>> I don't know if that has happened, and whether it would work on s39=
0 now.
> > >>
> > >> commit 03b8c7b623c80af264c4c8d6111e5c6289933666
> > >> Author: Heiko Carstens <heiko.carstens@de.ibm.com>
> > >> Date:   Sun Mar 2 13:09:47 2014 +0100
> > >>
> > >>    futex: Allow architectures to skip futex_atomic_cmpxchg_inatomic(=
) test
> > >>
> > >>    If an architecture has futex_atomic_cmpxchg_inatomic() implemente=
d and there
> > >>    is no runtime check necessary, allow to skip the test within fute=
x_init().
> > >>
> > >>    This allows to get rid of some code which would always give the s=
ame result,
> > >>    and also allows the compiler to optimize a couple of if statement=
s away.
> > >>
> > >>    Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> > >>    Cc: Finn Thain <fthain@telegraphics.com.au>
> > >>    Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > >>    Link: http://lkml.kernel.org/r/20140302120947.GA3641@osiris
> > >>    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > >>
> > >>
> > >> Heiko created the CONFIG_HAVE_FUTEX_CMPXCHG to get around this issue=
.
> > >> We just skip the runtime check as well as arc, m68k and sh. Not sure
> > >> about xtensa, the set it config option only for !MMU.
> > >
> > > Duh. grep would have told me. -ENOTENOUGHCOFFEE
> > >
> > >
> >
> > There=E2=80=99s another way to skin this cat: keep KERNEL_DS but pass a=
 valid pointer.
> > I don=E2=80=99t suppose you remember why you didn=E2=80=99t do that?
>
> No, I don't remember. To use a valid kernel pointer with KERNEL_DS and
> then test for =3D=3D 0 (vs -ENOSYS) imho should work.
>

There may be a much nicer solution.  Unless I missed something, only
mips and xtensa even have the possibility of cmpxchg being missing.
We could just make those arches supply a futex-detecting helper.
