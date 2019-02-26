Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF1FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78EE2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acttV7G4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfBZRJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:09:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39570 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfBZRI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:08:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so14803424wrw.6;
        Tue, 26 Feb 2019 09:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+xP4MHoEDgcyGpah3uADNPf3QtVMs/krcpmuCnfJaY=;
        b=acttV7G4xniAFRj+3YnXqXfNblC65aC5OpqZ9DFb0klXQQWPJC59z6e8veM/Pqlstz
         5Wy+YSQ3IRGT6hUCP33uVRZ5Vjt9DLdVKG1OzWHKPYK4iDcx/ccO6en9MqVsMmX/SnZ1
         xjJziFHVKQPjNUQ2PjaomJeZCTBN3piW7aAsnkCl6Hk3iyY1Lf0bkm78JzeOPS8TZULD
         4926WC+YEepxbs65rb2SipSwm06oi1BYPapu0AJNvTR8JlQS1C3GpEhKk/zGZf8sEd7Y
         TamWRmMSLQh1iiHL9aJoNLSL6He9qGbvdp5oEkiFN7G9KGwqNa/Rbxivbe0P6q6GurU9
         36Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+xP4MHoEDgcyGpah3uADNPf3QtVMs/krcpmuCnfJaY=;
        b=LEEXF/grEPYAyoWuBsP5oINHZJRbZjqIleLhX0eabuYtzN6tHvIqEOTicdnl8QkcV9
         p2omjZdmFyQ4UDzUlBAcFYteMA7anNfidUtivsiqcqgM0uHGC4R6KETC3AsRyLjB668/
         8c8sQye4TX3akdtAfBqb9x4KQzi883KDpYCQxQllRq2ROJdhbtDOt7hUYa8zniZVhp6G
         wx+MGiYdBaGLYO23IpmikcaveNV+TVsF6Mpb0VofR3AygZdzSgIT3EmEa1m8r+mXqzEF
         knCcdAJpOgVhxfduCvEPs69yeAC00rTJkrHIYWMr1H0dIp6LUQl8BjechTOP5c40s7FX
         ghvQ==
X-Gm-Message-State: AHQUAubWWK3fDS/wGWLvtOtOrRAAdEMxHUO+SIZIap+Vtpga9OetLpnY
        i+tAjIgtVCrWrY3sy3At5iyb2j5iG5vbEZGtR+opCqx6
X-Google-Smtp-Source: AHgI3IbceMYfeuX/nswSigzqJQNrkO7PAw7oCjdrp1GhZjHj00IENA2unlSR4zp84uaMl/QQ4ZnImAGXp3izEx85Soc=
X-Received: by 2002:a5d:6209:: with SMTP id y9mr18530356wru.140.1551200937432;
 Tue, 26 Feb 2019 09:08:57 -0800 (PST)
MIME-Version: 1.0
References: <1551023123-5031-1-git-send-email-zenghuiyu96@gmail.com> <20190225112640.50d6a2c5@lwn.net>
In-Reply-To: <20190225112640.50d6a2c5@lwn.net>
From:   Zenghui Yu <zenghuiyu96@gmail.com>
Date:   Wed, 27 Feb 2019 01:08:45 +0800
Message-ID: <CAKcZhuVqEJvO=wWYqkwNsnPULGA1WA7VPBh0rh7W0u3upgnvmA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation/process/howto: Update for 4.x -> 5.x versioning
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Tue, Feb 26, 2019 at 2:26 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Sun, 24 Feb 2019 23:45:23 +0800
> Zenghui Yu <zenghuiyu96@gmail.com> wrote:
>
> > As linux-5.0 is coming up soon, the howto.rst document can be
> > updated for the new kernel version. Change all 4.x references
> > to 5.x now.
> >
> > Signed-off-by: Zenghui Yu <zenghuiyu96@gmail.com>
>
> Overall: I think there's value in having the docs reflect current
> numbers, though it would be better if the docs as a whole were kept
> current at the same time.  howto.rst hasn't been updated yet, so this
> attention is welcome - thanks for taking a look at it.  That said, I
> really think we can do a little better.

Thanks for your reviewing and nice suggestions.  Now I have realized that
simply changing version numbers in howto.rst (like what I've done ...) is
shortsighted. And yeah, we can do it better.

> >  Documentation/process/howto.rst | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
> > index f16242b..19001e2 100644
> > --- a/Documentation/process/howto.rst
> > +++ b/Documentation/process/howto.rst
> > @@ -235,16 +235,16 @@ Linux kernel development process currently consists of a few different
> >  main kernel "branches" and lots of different subsystem-specific kernel
> >  branches.  These different branches are:
> >
> > -  - main 4.x kernel tree
> > -  - 4.x.y -stable kernel tree
> > +  - main 5.x kernel tree
> > +  - 5.x.y -stable kernel tree
> >    - subsystem specific kernel trees and patches
> > -  - the 4.x -next kernel tree for integration tests
> > +  - the 5.x -next kernel tree for integration tests
>
> One thing I think we can do is to simply get rid of version numbers in a
> lot of places and make this process easier when 6.x comes around.  What
> this is really trying to say is that we have:
>
>  - Linus's mainline tree
>  - Various stable trees with multiple major numbers
>  - Subsystem-specific trees
>  - linux-next
>
> If we could rework this along those lines, it will more accurately
> reflect reality and not require updating next time.

Obviously a better classification. Will follow your suggestion and modify it.

> > -4.x kernel tree
> > +5.x kernel tree
> >  ~~~~~~~~~~~~~~~
> >
> > -4.x kernels are maintained by Linus Torvalds, and can be found on
> > -https://kernel.org in the pub/linux/kernel/v4.x/ directory.  Its development
> > +5.x kernels are maintained by Linus Torvalds, and can be found on
> > +https://kernel.org in the pub/linux/kernel/v5.x/ directory.  Its development
> >  process is as follows:
>
> And here too I think we can just say "mainline" and that they can be
> found at https://kernel.org/ or in the repo.

Will modify.

> >    - As soon as a new kernel is released a two weeks window is open,
> > @@ -277,21 +277,21 @@ mailing list about kernel releases:
> >       released according to perceived bug status, not according to a
> >       preconceived timeline."*
> >
> > -4.x.y -stable kernel tree
> > +5.x.y -stable kernel tree
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >  Kernels with 3-part versions are -stable kernels. They contain
> >  relatively small and critical fixes for security problems or significant
> > -regressions discovered in a given 4.x kernel.
> > +regressions discovered in a given 5.x kernel.
>
> Here too, especially since most of the outstanding stable kernels won't
> be 5.x for a long time.

Yes. Actually, I hesitated too when I was changing "4.x.y -stable kernel tree"
to "5.x.y -stable kernel tree" :)
Using "stable trees" instead will be better.

> >  This is the recommended branch for users who want the most recent stable
> >  kernel and are not interested in helping test development/experimental
> >  versions.
> >
> > -If no 4.x.y kernel is available, then the highest numbered 4.x
> > +If no 5.x.y kernel is available, then the highest numbered 5.x
> >  kernel is the current stable kernel.
>
> ...and this, I believe, is misleading at best.  I'd just take that
> sentence out.

Yes, I'll delete it.

> > -4.x.y are maintained by the "stable" team <stable@vger.kernel.org>, and
> > +5.x.y are maintained by the "stable" team <stable@vger.kernel.org>, and
> >  are released as needs dictate.  The normal release period is approximately
> >  two weeks, but it can be longer if there are no pressing problems.  A
> >  security-related problem, instead, can cause a release to happen almost
> > @@ -326,10 +326,10 @@ revisions to it, and maintainers can mark patches as under review,
> >  accepted, or rejected.  Most of these patchwork sites are listed at
> >  https://patchwork.kernel.org/.
> >
> > -4.x -next kernel tree for integration tests
> > +5.x -next kernel tree for integration tests
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > -Before updates from subsystem trees are merged into the mainline 4.x
> > +Before updates from subsystem trees are merged into the mainline 5.x
> >  tree, they need to be integration-tested.  For this purpose, a special
> >  testing repository exists into which virtually all subsystem trees are
> >  pulled on an almost daily basis:
>
> linux-next is called "linux-next"; we should just use that name.

Will modify.

> So what do you think?  Can we maybe get a version that removes most (or
> all) of the explicit version numbers from this file?

Actually, jon, you have already kindly pointed out everywhere to be noticed in
this patch. What I need to do is just follow your detailed suggestions and send
a V3 :)  And I think all of the explicit version numbers can be removed.


Many thanks,

zenghui
