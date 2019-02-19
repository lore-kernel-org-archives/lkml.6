Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6646BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDBC2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjwtoSl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfBSLf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:35:29 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40277 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfBSLf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:35:29 -0500
Received: by mail-it1-f193.google.com with SMTP id i2so5320561ite.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 03:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q62Kg48ghBbijwcL6qdW6IrFyeQHl6ptcqcFoGHPA58=;
        b=SjwtoSl4aYbAcaO7SS5Ui6BzSU6U6HCC46Ds0w9EBHnuDtOKN7wD1HfR+V+bFLix9B
         T3jY1/7NUOXPDZ8sZ1/5nz/g7qk+W0FVKl238/+ZKkSH3k2y0fYqi7WZ1C2B28uzF0tJ
         /zDdDJcdAW42k1A0j+/sk1v/TSeg9yClehkfX7dQym24TyEIy3kdnUHJtmLZs+zRSSVJ
         /AzlLveNbWYL50aH7651Z4VCHQSckhXv8Jvb/9pndjjLeBfr9X1izqYAxEF70biWAZwv
         VBk1J6yVIfWYA8GpcHfKDXcEpJ5SQzwD9Md9fg+vE0vAeFchIOf2JkFF3jErsX7ZsBVB
         QlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q62Kg48ghBbijwcL6qdW6IrFyeQHl6ptcqcFoGHPA58=;
        b=HazzbVsTYj8j1DKRxd5UIYjtyNeKHkvp2zryXmJ3RwSg8VWAObFFwnlxsspXJbQKSo
         9mZPB2TE0hEipV/yR3fgj7l2IyFZfvjW5FAtJSpwtrwWTD8VUJjEeoiy5MGdkDO9XnRe
         P6oSCtA/Vhuuot5E4nFXogQljfam5NT/L8NIwT8rkDUe1Bw8Vum3E8y1VIQIwf+kDViP
         S1HvqWaTr/1/UrMmEg/VLBr1V/5bLsoipPutdM7nDSVRAR+l8b6yLtD3AlZcrq9haGur
         ZQ8QIzfAnuRccLqI/+7wanWcn34v6u9msS+r/HHFxuHcuI2SrwkNq1ebrNKGHt7AS1vz
         KmiQ==
X-Gm-Message-State: AHQUAuZgyUajWGop4TusPpbjxbc299y6IUqSUL8t3ThPM7pFSJEiW5ie
        FgWJ3PGQ/c3c/AbbNu2X0BTji0ArbennVXggobDA5w==
X-Google-Smtp-Source: AHgI3IbhGlAhVvJOxnIGcP9rZGjCooAyEe3AVeJc/1xXXTlEGXKBp5Ayp9Jq4QzlsBYVDHrelb2M8WDN4lFq/Ykqra8=
X-Received: by 2002:a02:5782:: with SMTP id b2mr15174690jad.2.1550576128089;
 Tue, 19 Feb 2019 03:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com> <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
 <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
 <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com>
 <CAKv+Gu-Aj68gXoi9CXLyw96iRychWjqX=XtMCQxcZqOv0jhsLw@mail.gmail.com>
 <CAKv+Gu_nwKr65zLG0p0dSW4sQtN4dwEkevCMPe5s9U++SaDezg@mail.gmail.com> <20190219111927.GA17012@kroah.com>
In-Reply-To: <20190219111927.GA17012@kroah.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 19 Feb 2019 12:35:16 +0100
Message-ID: <CAKv+Gu9v3htHyfCZvDU2Qd8vQozbBQVeHyyNsrdrwO2r7ReBwA@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sandeep Patil <sspatil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 at 12:19, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 19, 2019 at 11:35:12AM +0100, Ard Biesheuvel wrote:
> > On Fri, 15 Feb 2019 at 20:45, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Fri, 15 Feb 2019 at 20:43, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Feb 15, 2019 at 11:28 AM Ard Biesheuvel
> > > > <ard.biesheuvel@linaro.org> wrote:
> > > > >
> > > > > On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > > >
> > > > > > On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> > > > > > <ard.biesheuvel@linaro.org> wrote:
> > > > > > > Provided that we stop sending Clang enablement patches to -stable:
> > > > > >
> > > > > > What does that mean?  We're trying to provide clang support back to
> > > > > > 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
> > > > >
> > > > > I understand that is what you are attempting, but that does not mean
> > > > > it /belongs/ in -stable.
> > > > >
> > > > > There are rules for stable, and people that track stable kernels (such
> > > > > as the distros) should be able to rely on us to only backport bug
> > > > > fixes, not linker script changes and other updates that fix issues
> > > > > that did not exist when those kernels were released.
> > > > >
> > > > > It is unclear to me how these clang changes benefit those users.
> > > >
> > > > If you're referring to
> > > > https://www.spinics.net/lists/stable/msg278381.html, that's fair (I
> > > > think those were helpful for LLD support on arm64).
> > > >
> > > > Why didn't you speak up then?  Why is this coming up now?
> > >
> > > That is just one example, and I failed to realise it at the time.
> > >
> > > I think the Clang/LLVM work you are doing is very important, but I
> > > simply don't think any of it belongs in -stable kernels.
> >
> > OK, to clarify my position:
> >
> > I have no problem whatsoever with taking this patch into v5.x, so
> >
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > but going forward, I will push back on -stable backports for
> > Clang/LLVM specific changes, since they are obviously in violation of
> > the stable kernel rules.
>
> Getting older kernels to build/run properly on newer compilers is just a
> part of life for the stable trees.  If you note, we have done a lot of
> gcc7, then gcc8, and clang patches backported over the years in order to
> make it possible for people (like me and my testing infrastructure at
> the least) to keep building these old kernels on newer systems.
>
> So while it's not part of the "documented" rules, I do take this type of
> change, as it does help out a huge population of users and testers.
>

That doesn't make a lot of sense to me, but that is the common
practice, then I won't object any longer.
