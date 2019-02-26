Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5FD218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mee4RO3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfBZUwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:52:53 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52059 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbfBZUww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:52:52 -0500
Received: by mail-it1-f196.google.com with SMTP id e24so6030663itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 12:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5CQUZRpETpJgd/qj4sQWah8yYajnATRLgXEBzXN+tE=;
        b=mee4RO3J1VK+UqxetnHiPpgwiWLSTE/apf+oAUN9L+dgeVVaqsk4YNX4136lrMaVgd
         79PxQtbsqvFR+ATtadLHtqhMsOYflBKpZqmP9OZn7v/jAtNPQrZfBomw0ae60Dnm4TLV
         g7J9+Pgyokcw1d+Out3U7IKBF+s9umZZbK3sRZQ/u0nHcftEiVdSiYyXpY4g8mQjRsq6
         tA3ve5YWwbgXFkDcRSyzqi36vwAe+aCJQBoS2rL8FXc/8cmhcR9S+jHOn5YzEy6BL/pj
         4J7yHg5wfvJl/KA23pjCzHZlYRtpV1ElAryyVPqsLcNn+4RmjJAyd2wYp4d74lJX4Vi8
         t6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5CQUZRpETpJgd/qj4sQWah8yYajnATRLgXEBzXN+tE=;
        b=fLWDA6S9DrWhQz/0vB8xs5mhpiPFi7k+UALnx9RXUqIkFgb0SuGmqOaabgQjHu87Yi
         Bf1alCrhR4gO3iyDCjKO4VD/DnIqcu2BA6JVjuXFztsYlKzBkXEvs8SBL83XE9C+Jdzz
         TPIvJykWuKlXv+s9JFDrrB+CWrSr1gFEEqi0oQlxLVjoRb276SpNL/Fx020De+2XSFSB
         nVBnpPqSfPOcKLar79cicz+YhgWM35bHqZoHfXtGK8iXja3CFs8mBttDYUi76RDebXXv
         TToGKTBfHVNlLJZ9ChAGrUQGkzEUfsMnyuEkdaHNYSvxbQ2cnXd6mJmSTw8Pr/p1rH4v
         NF/A==
X-Gm-Message-State: APjAAAVWSHsKPfF7e+RnutiSBgXn/6rIxL2E0VFwEcnDSO3Kjwcc3oDE
        el2W1ix1CTOypqfbTZKuQQ188f5CKsijQ97hg8l+2w==
X-Google-Smtp-Source: AHgI3IYt/QyrXb8YEbYqW7hSqmZaIJo7ICA9joT1Z2bqYtuvVwKUpPrkhvgW3RmyrlZ+2bvp6TjXzuolugucs4/JoSk=
X-Received: by 2002:a24:45dd:: with SMTP id c90mr3802493itd.71.1551214371635;
 Tue, 26 Feb 2019 12:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20190226040345.202047-1-ndesaulniers@google.com>
 <CAKv+Gu-5DvWZL6ogLVNDEvgKe6TENX+5sF1U7QxiyYC8Wx0nXw@mail.gmail.com> <CAKwvOdmzb1WF6NU5LYWGXK_O2cbqwMjbWGAa5xk5x+EMz7A1yw@mail.gmail.com>
In-Reply-To: <CAKwvOdmzb1WF6NU5LYWGXK_O2cbqwMjbWGAa5xk5x+EMz7A1yw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 26 Feb 2019 21:52:33 +0100
Message-ID: <CAKv+Gu_TXtSBhTOuucw+6ULEGMkiFS2TBZ7gQ-EJqC7wxC7nrA@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: use vdupq_n_u8 to avoid endianness warnings
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 at 21:44, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Feb 25, 2019 at 11:19 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 26 Feb 2019 at 05:03, <ndesaulniers@google.com> wrote:
> > >
> > > Clang warns: vector initializers are not compatible with NEON intrinsics
> > > in big endian mode [-Wnonportable-vector-initialization]
> > >
> > > While this is usually the case, it's not an issue for this case since
> > > we're initializing the uint8x16_t (16x uint8_t's) with the same value.
> > >
> > > Instead, use vdupq_n_u8 which both compilers lower into a single movi
> > > instruction: https://godbolt.org/z/vBrgzt
> > >
> > > This avoids the static storage for a constant value.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/214
> > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Much better, thanks,
> >
> > Did you double check that the intrinsic exists on 32-bit ARM as well?
> > I assume it does, but please make sure if you haven't yet.
>
> Thanks for the review!

My pleasure.

> Looking through Clang's generated arm_neon.h, vdupq_n_u8 seems to have
> 2 definitions predicated on __LITTLE_ENDIAN__ (not __arch64__ or
> __ARM_ARCH >= 8 like some of the other types and functions).
>
> So NEON got some additions in v8?

Basically, yes. One example is right there in the NEON recovery code,
guarded by #ifdef CONFIG_ARM.

New intrinsics were also introduced for the crypto instructions,
although I think those were also added to the 32-bit version of
arm_neon.h

>  Is there a doc that lists them?

Not that I know of.

> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0491g/BABDBBJB.html
> is where I found vdupq_n_u8, but it doesn't seem to mention
> compatibility (so I assume it's been around since the introduction of
> NEON?).

Yes, it appears that the 32-bit arm_neon.h header on my box defines
this intrinsic, so this should be fine.
