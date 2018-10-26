Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC6ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EF52084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjzklzAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EF52084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeJ0COV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:14:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40104 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbeJ0COV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:14:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so2113655wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1agawPrMyMCesyFs7uh2XuBYRSxZV14itOlPhVsFdhE=;
        b=VjzklzAwtaCNh4A7EyghjRQ9dPDIMdJ8tGsGR9DGdT/3Lo38RkB2fQAhyA1tG3fuy4
         MlGZoIQyjny4cwryKhWRwCo2hwJ4tGIDK74yC4uRTawnFW5mX1ZedngI/fdZHcNOVnn3
         +aRJuLHNjBBzOEQzU/tu2ql+lTZ3HLk1GSfYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1agawPrMyMCesyFs7uh2XuBYRSxZV14itOlPhVsFdhE=;
        b=Rm8360mXKZrBUdVbNwW53KOdgIs0jKD4bCykW2HI9wJnljKNRB1F+wJJS9xlv2cdlq
         ew6CjIW0L8DTUm9kglFKHOJHe1oXkFRjjgQhQzdVQNZH15oqptcVS977G47+w7C6LP1m
         MK9zOPEIhhzWEE1zGj2TMbTNHlQBUPfHIYWKM8onoVFLzzR9UtZ0dM0WeOEXvBGmrZu2
         Q6Xlc6lVxUPanAcWutmDYk9I97MDqrAVJPEWuDFFK3fdQzt2IsDmICcGaNgzS4y4xMWu
         EPUh3sYe6ShziKsDTXH2vsTeMI/ccT5YTwcbRa2bGGyqo/K4H841SO5dBaANSgebE4qb
         8C9A==
X-Gm-Message-State: AGRZ1gLlMKm08OCaNmDjue5bR4VSC4JenEfOGNnqjjwrPfu524r62Gk/
        KruJ495KitlX7CdxQ5lTdzDYCTH6qWlNs5jGZJem/Q==
X-Google-Smtp-Source: AJdET5cM2DXhznn9j2iReJ+GqX07iAxThQsJR2jPKy0lLLaSYPu/+iATPQpmzwXmx9t6E8hkyrrlhi/rsw3TxXAF5UI=
X-Received: by 2002:a5d:410d:: with SMTP id l13-v6mr6483865wrp.61.1540575386051;
 Fri, 26 Oct 2018 10:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
 <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com>
 <20181023093521.dm3l5oen2j7etsot@kshutemo-mobl1> <CAHk-=wh6i5t5jYHrC-ZCdj8qoZWP3BptV87U=G9G4UyunzPf7Q@mail.gmail.com>
 <20181023200408.GA13179@chatter.qube.local> <CAHk-=wjVJ1w=MYXhu42+1rPybtztz+7q=KWo53nQmasR7R4SNA@mail.gmail.com>
In-Reply-To: <CAHk-=wjVJ1w=MYXhu42+1rPybtztz+7q=KWo53nQmasR7R4SNA@mail.gmail.com>
From:   Rob Herring <rob.herring@linaro.org>
Date:   Fri, 26 Oct 2018 12:36:14 -0500
Message-ID: <CABGGiszsw=QXPwTe3mf26BG=Pxig6zGcXXJfRA+w0Pawrm5qpQ@mail.gmail.com>
Subject: Re: Git pull ack emails..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kirill@shutemov.name, Linus Walleij <linus.walleij@linaro.org>,
        boris.brezillon@bootlin.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>, jacek.anaszewski@gmail.com,
        axboe@kernel.dk, Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 9:14 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm back home, slightly jetl-agged, but _oh_ so relieved to not be
> doing the merge window on a laptop any more.
>
> I've been continuing to just manually ack the pull requests, but I've
> almost forgotten a few times (and maybe I _did_ forget one or two and
> didn't catch it? Who knows?).
>
> So while maybe just continuing to do this means that it becomes second
> nature, I'm starting to think that mailing list automation really
> would be a good idea:
>
> On Tue, Oct 23, 2018 at 1:04 PM Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:
> >
> > On Tue, Oct 23, 2018 at 10:46:06AM +0100, Linus Torvalds wrote:
> > >If it's a "proper" pull request (ie done by git request-pull), then
> > >the magic marker would be that it as that
> > >
> > >    for you to fetch changes up to %H:
> > >
> > >line where %H is the hash of the tip of the tree that is requested to be pulled.
> > >
> > >Then automation could literally just check "is that commit in Linus'
> > >public tree", and when that happens, generate an automatic
> > >notification that the pull request in question has been merged.
> >
> > I can probably do something like that at kernel.org. How about something
> > more generic -- e.g. a simple tool that asks a remote web service to
> > notify you when a commit-id is seen in one of the kernel.org repos?
>
> So I think it might be good to have some generic model for "give me a
> trigger when XYZ hits git tree ABC" that people could just do in
> general, *but* I think the "scan mailing lists for regular pull
> requests" would actually be nicer.
>
> Maybe it would be just a special-case wrapper around a more generic
> thing, but this:
>
> > - send a REST request to https://foo.kerkel.org/lmk:
> >
> >   {
> >     "tree": "mainline",
> >     "commit": "123abc...abc555",
> >     "notify": "(output of $(git config user.email)"
> >   }
>
> doesn't really sound all that nice for the "I sent a git pull request,
> and want to be notified".
>
> It would be much nicer if the "notification" really did the right
> thing, and created an actual email follow-up, with the correct To/Cc
> and subject lines, but also the proper "References" line so that it
> actually gets threaded properly too.
>
> That implies that it really should be integrated into the mailing list itself.
>
> But I don't know how flexible the whole lkml archive bot is for things
> like this. But I assume you have _some_ hook into new messages coming
> in for lore.kernel.org?
>
> > Would that be a useful alternative? If yes, what would be your preferred
> > workflow for such tool instead of "git lmk [commit] [tree-moniker]"?
>
> I really do suspect that "I sent out a pull request, I'd like to be
> automatically notified when it gets upstream" would be the primary
> thing.
>
> And by "upstreamed" it isn't necessarily just my tree, of course.
>
> Are there other situations where you might want to track something
> _outside_ of a pull request? Maybe. I can't really think of a lot of
> them, though. Patches etc don't have commit ID's to track, but it
> *might* be interesting to see similar automation just based on the git
> patch-ID. But that sounds more like a patchwork issue than something
> like "track pull requests".

I would very much like to see something that works for patches too.
There's a lot of tribal knowledge needed for submitters to learn as to
what is each maintainer's process. Reducing that would be beneficial
IMO, and more solvable than discussions around non-email based
submissions. For example, with Greg and Mark B you can expect an
automated replies. Mark's reply gets threaded with the original, but
Greg's do not. For networking, you may or may not get a manual reply,
but patchwork always has the status if you know to go check it. In
reviewing patches I want to know the status too, but that's somewhat
my unique position of reviewing bindings which mostly other
maintainers apply. I've somewhat solved it for myself by automating
checking linux-next, but maybe automated email replies to patches
being in linux-next would be nice. While that's not immediate, it
should be quick enough. And I'd like to have automated replies sent on
patches I apply, but I'm lazy and haven't managed to set that up yet.

BTW, patchwork tracks pull requests too, so maybe there's a common solution.

Rob
