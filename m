Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3078C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70855208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550575190;
	bh=26Odait38MeRwBX4Med0lGADL1iej+UYnHWyo2lsr0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ygJ3EnUldVoeH8qpuyjTtAQqxeZh04hlO5tMOx/nZoSEvCvT8zbXsBgBiBJhD1KaS
	 11otkLaRv+jpWYUB8Kw2iR1wXikoa5xZ69BoJz1AgLDyCsTPovGYAGD3kUJCCSBqN7
	 ut7F1N71OvpphaxWi5VExN952XbN732AjeiIZvns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfBSLTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:19:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfBSLTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:19:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85CF9208E4;
        Tue, 19 Feb 2019 11:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550575171;
        bh=26Odait38MeRwBX4Med0lGADL1iej+UYnHWyo2lsr0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8ZTbiQhOPJ2R/mPgRIMiARiHtaNQcPPHLbLseiZ3GqKnmzKQvMMEjJ0hjlr9845c
         CK7y22cVZkwa4kgCSh7l6Tm3nOkp5VSXXtKkrOVL4MNYmKkSXsEiCsYOahVJz4Gr4p
         DxHhI7poFRp3DZtJiHaJd5FKlpvM9+cnB9Jf4txM=
Date:   Tue, 19 Feb 2019 12:19:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sandeep Patil <sspatil@google.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
Message-ID: <20190219111927.GA17012@kroah.com>
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com>
 <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
 <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
 <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com>
 <CAKv+Gu-Aj68gXoi9CXLyw96iRychWjqX=XtMCQxcZqOv0jhsLw@mail.gmail.com>
 <CAKv+Gu_nwKr65zLG0p0dSW4sQtN4dwEkevCMPe5s9U++SaDezg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_nwKr65zLG0p0dSW4sQtN4dwEkevCMPe5s9U++SaDezg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:35:12AM +0100, Ard Biesheuvel wrote:
> On Fri, 15 Feb 2019 at 20:45, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 15 Feb 2019 at 20:43, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Feb 15, 2019 at 11:28 AM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > >
> > > > > On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> > > > > <ard.biesheuvel@linaro.org> wrote:
> > > > > > Provided that we stop sending Clang enablement patches to -stable:
> > > > >
> > > > > What does that mean?  We're trying to provide clang support back to
> > > > > 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
> > > >
> > > > I understand that is what you are attempting, but that does not mean
> > > > it /belongs/ in -stable.
> > > >
> > > > There are rules for stable, and people that track stable kernels (such
> > > > as the distros) should be able to rely on us to only backport bug
> > > > fixes, not linker script changes and other updates that fix issues
> > > > that did not exist when those kernels were released.
> > > >
> > > > It is unclear to me how these clang changes benefit those users.
> > >
> > > If you're referring to
> > > https://www.spinics.net/lists/stable/msg278381.html, that's fair (I
> > > think those were helpful for LLD support on arm64).
> > >
> > > Why didn't you speak up then?  Why is this coming up now?
> >
> > That is just one example, and I failed to realise it at the time.
> >
> > I think the Clang/LLVM work you are doing is very important, but I
> > simply don't think any of it belongs in -stable kernels.
> 
> OK, to clarify my position:
> 
> I have no problem whatsoever with taking this patch into v5.x, so
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> but going forward, I will push back on -stable backports for
> Clang/LLVM specific changes, since they are obviously in violation of
> the stable kernel rules.

Getting older kernels to build/run properly on newer compilers is just a
part of life for the stable trees.  If you note, we have done a lot of
gcc7, then gcc8, and clang patches backported over the years in order to
make it possible for people (like me and my testing infrastructure at
the least) to keep building these old kernels on newer systems.

So while it's not part of the "documented" rules, I do take this type of
change, as it does help out a huge population of users and testers.

thanks,

greg k-h
