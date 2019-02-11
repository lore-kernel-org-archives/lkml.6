Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F03C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF1F21773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549915530;
	bh=Gqg5I4OcIA8EvWc4w8moI4nNe6Pt42VIwG0LkYRbrqQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jN2SgTkufgiWyMU0mVHwRyRNB10mVFcryroaHiEeNOLQaDywkYg+gY3vynJYlOWKe
	 05Pz9BXrq/YXwYN6b36sVsjY9mWAuPtVye9UO++s/sk8wgbnapOm7AIG4k5oeDd7nX
	 Y1XksYFiOGqv5lk5ywyTxVJ5Ll1jeyG3843xPX5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfBKUF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:05:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46304 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfBKUF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:05:27 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so154682qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gqg5I4OcIA8EvWc4w8moI4nNe6Pt42VIwG0LkYRbrqQ=;
        b=bwaRzhRijjorvMjBAFvcgWTk4j+arx9W3DBXj6xI6BxcbhN4rW8WAo9odSDW7CGBBa
         LncBBFle8OwMSPvJQht5SsVBaLtYRnqP+y6OpmRS2vM0PlrHAR9NpvwkQWfXvHPyqhEM
         oiCe7eXahew8ARnRC7l1AW6mq8G0SzpyAvU3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gqg5I4OcIA8EvWc4w8moI4nNe6Pt42VIwG0LkYRbrqQ=;
        b=ZxuOSlmDmQseXan5Jp5yhK1oKd5Neg61is5kgVdZNDWPQdci9b66Isk8qP4saYk59W
         iECGKTxpIIwMtU0N5uPI1sZqfbyEecsEdiOOAprnkwjGbPvyzfI5vDmoUrLwrQatqh+Z
         arP/lETm/rWSFB9P129Op8lJwih6mfwR1IGbEhCxlvUEenSwf9SezSfzmMcnIIkIUWnH
         EP+uKSjYHUQRU0fmH8J7cqD37kPsyHCvGbwzcDj+/3r+QvkztOio3Y/LOxZC+bnDfLv5
         TFe3ZycjcaAUfO7sjaR8Ylmst83ifd5pRzm3XvmR29Xvd/TWMo/+sFlj7iGOPWkRg94Y
         27gA==
X-Gm-Message-State: AHQUAuY7hz7/wuIAkdz20eFsP+NUUltPX82w33yNIEvhs21yr+s8M249
        vdWbNOaZLo/2Y34WwfmpELKrsQciJZvVrKEP3df7/w==
X-Google-Smtp-Source: AHgI3IYGFhfVvV39ao9OlAMeDxxSDVJ6TaNsNjKqg4c7qUC7u/e0gM4Jr+xcdjFliT+JlYckaLAmuhO5sWYyXFg+v4o=
X-Received: by 2002:ac8:6887:: with SMTP id m7mr2295344qtq.381.1549915526279;
 Mon, 11 Feb 2019 12:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20190210041721.GA2805@localhost.localdomain> <154977271617.2362.11794417398216386913.pr-tracker-bot@kernel.org>
 <20190211031921.GA1799@localhost.localdomain> <CAHk-=wgz_WpD7jc084QROuM0zszEG0-WvQhQZPsCboMOWNRiWw@mail.gmail.com>
 <20190211184000.GA4907@chatter.qube.local>
In-Reply-To: <20190211184000.GA4907@chatter.qube.local>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Mon, 11 Feb 2019 15:05:13 -0500
Message-ID: <CAMwyc-QpYpwqFsGpKSZL1mHdggFYR-XeT9Nb0WgH5LNrgB1KMQ@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v5.0-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>, pr-tracker-bot@kernel.org,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 at 13:40, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> >> On Sun, Feb 10, 2019 at 04:25:16AM +0000, pr-tracker-bot@kernel.org wrote:
> >> > The pull request you sent on Sat, 9 Feb 2019 20:17:23 -0800:
> >> >
> >> > > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes
> >> >
> >> > has been merged into torvalds/linux.git:
> >> > https://git.kernel.org/torvalds/c/7ad915f5ebf5b9e7ca98a7048d8f84a631fe388b
> >>
> >> I think the bot is off here because the above commit is about a merge
> >> from the linux-omap tree from Tony.
> >
> >Indeed.
> >
> >.. and the pr-tracker-bot thing actually made me ignore the pull
> >request, thinking I had left it in my inbox despite having pulled it.
> >
> >So it would be really good to know why pr-tracker-bot ended up
> >replying to the wrong email, because it can cause real problems.
>
> Simply put, it's because "it's a pull request sent to Linus." We
> currently don't disambiguate between Linus showing up in "To" or in "Cc"
> -- is that an important differentiation that should be enforced?

Linus:

Sorry, I totally misunderstood what you were saying -- I blame the jet
lag. I'll check out what's going on.

-K
