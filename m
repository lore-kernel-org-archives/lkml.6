Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AD7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E16218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXzgVVbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfBFLYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:24:05 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37866 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbfBFLYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:24:04 -0500
Received: by mail-vs1-f68.google.com with SMTP id s16so2092039vsk.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 03:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBzByadEqtyMn00ZURP2kVUXxq2O5WTctd4wSpJkOdU=;
        b=eXzgVVbqFtp0EhOq+O7UFYWd97qgWwKv5P/m3TqKJdfUpQCEay+24mWymts+6wK7wH
         inov+kbzxG7Ar15hdVzbViEF9B0d8636C6gvt6Np0zCyUtnLnXW0iDySjNcMsgXpxZdW
         vxS5dmfN1W9a09ziKnOEpLEAcp7MIvJgKio5z5tVc7wkA/RVulo7ix873d5g6aQNte0Z
         yeYnCBzUJ9Ypge109F8i305iwkR61w6FIYbZRjkVKDe447nDiLof0KSfgdf75K72idLj
         irWZCyW+ZTRNpf8F84FaxTCtCsNq8rkxS5L4x6YSHnhXpf/gkiP1JRqefoDf0aJebzrh
         hhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBzByadEqtyMn00ZURP2kVUXxq2O5WTctd4wSpJkOdU=;
        b=FD1zdu06manf5K+Zdoyw4kU9znpoMpakOslsGW5MZZ/vF3oGgbTOJ0g77SiUFYqHsU
         joaZE9Twb22EPl2wHY8OiGVjC53xdZvIqfePM4NP+TN8Ke3XLA9RNvvWzahTN7Ib4AOq
         o2bXOcbVLdnosd+nIzthPqs2Ds7qLaYFCcT6xzZ8EfORljncKJK11JVEZ1MhMjrs267C
         7U5MTijAvHoevRC6yGl++nNifZzuL1DHfHvNjx8qvedotbCrv717aeGt8S1rm9Fd/wr7
         /ykNAJkoNHZknvXN2k3QkjhJ0Dm4n3jDzB14UjzRUx7LB5W8Gb5rUe/u/1qnCNzsZsAE
         BH4Q==
X-Gm-Message-State: AHQUAuZY9iPtfvKcfam9eHBQnlN8wog0GBq0A8rzsM/jouHvrFpDtawV
        GM0F6GrgHnHSrJyDRz4dbB7rmoQswfM4UzstwkIAIA==
X-Google-Smtp-Source: AHgI3IYAx/KNU4xx3iQ+QsHhDAwqmiPsdK4ID6ia+YowdybCwtLIBFHGYcKLDvxg//Pc/hJyAb1vanyUKtXJ7L9lf3w=
X-Received: by 2002:a67:7685:: with SMTP id r127mr4076466vsc.35.1549452243118;
 Wed, 06 Feb 2019 03:24:03 -0800 (PST)
MIME-Version: 1.0
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <CAJZ5v0jOVLZDoW5BAy9obp7AptTYzKikFo7Qd15kNt5Y9=vXRQ@mail.gmail.com>
 <CAPDyKFrq-r-rFDDB3yU=W4mOF2-A4xGGomqFqUba6MVWZugHmQ@mail.gmail.com>
 <24600564.pMaimVIQbW@aspire.rjw.lan> <CAJZ5v0gBYyoumVkLTuEcHsFE8QKEXdYuhDRGwmvoKPhx7gPvgQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gBYyoumVkLTuEcHsFE8QKEXdYuhDRGwmvoKPhx7gPvgQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Feb 2019 12:23:26 +0100
Message-ID: <CAPDyKFoUfM8kopWfkorDhVKfk35wVaKVPzJeZ55RPRdc2Y1MYw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] driver core: Fix some device links issues and add
 "consumer autoprobe" flag
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 at 10:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 5, 2019 at 12:27 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Tuesday, February 5, 2019 9:15:49 AM CET Ulf Hansson wrote:
> > > On Mon, 4 Feb 2019 at 12:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Mon, Feb 4, 2019 at 12:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Fri, Feb 1, 2019 at 4:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> [cut]
>
> > > >
> > > > For example, if the consumer device is suspended after the
> > > > device_link_add() that incremented the supplier's PM-runtime count and
> > > > then resumed again, the rpm_active refcount will be greater than one
> > > > because of the last resume and not because of the initial link
> > > > creation.  In that case, dropping the supplier's PM-runtime count on
> > > > link deletion may not work as expected.
> > >
> > > I see what your are saying and I must admit, by looking at the code,
> > > that it has turned into being rather complicated. Assuming of good
> > > reasons, of course.
> > >
> > > Anyway, I will play a little bit more with my tests to see what I can find out.
> > >
> > > >
> > > > > Arguably, device_link_del() could be made automatically drop the
> > > > > supplier's PM-runtime count by one if the link's rpm_active refcount
> > > > > is not one, but there will be failing scenarios in that case too
> > > > > AFAICS.
> > >
> > > Let's see.
> >
> > So for the record, below is the (untested) patch I'm thinking about.
> >
> > Having considered this for some time, I think that it would be better to
> > try to drop the supplier's PM-runtime usage counter on link removal even if
> > the link doesn't go away then.  That would be more consistent at least IMO.
>
> So I can't convince myself that this is the case.
>
> Either way, if there are two callers of device_link_add() for one
> consumer-supplier pair trying to add a stateless link between them and
> one of these callers passes DL_FLAG_RPM_ACTIVE set in the flags to it,
> there may be issues regardless of what device_link_del() and
> device_link_remove() do.  However, if they decrement the link's
> rpm_active refcount (and possibly the supplier's PM-runtime usage
> counter too), the supplier may be suspended prematurely, whereas in
> the other case (no decrementation of rpm_active, which how the code
> works after this series) it may just be prevented from suspending.  To
> me, the former is worse than the latter.

Well, I would say it sucks in both cases. :-)

>
> Moreover, there is a workaround for the latter issue that seems to be
> easy enough: it is sufficient to let the consumer runtime suspend
> after calling device_link_add() to create the link (with
> DL_FLAG_RPM_ACTIVE set) and before trying to remove it.

I get your point, but unfortunate I don't think it's that simple.

For example, someone (like a child) may prevent runtime suspend for
the consumer. Hence, also the supplier is prevented from being runtime
suspended.

So, if you want to push this responsibility to the driver, then I
think we need make __pm_runtime_set_status() to respect device links,
similar to how it already deals with child/parents.

In that way, the driver could call pm_runtime_set_suspended(), before
dropping the device link in ->probe(), which would allow the supplier
to also become runtime suspended.

I did a quick research of users of device links, unless I am mistaken,
this seems like an okay approach.

What do you think?

>
> Because of the above, I'm just going to post a patch to document the
> current behavior of the code as a known limitation.

Let's not give up, yet, please. I am sure we can figure something out.

Kind regards
Uffe
