Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D0BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F53218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549494998;
	bh=exMkKBbXhhT95X3I/gvHXE4NEYCkDLgNypAVpsq7s/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=amHxcXO/0yWsmUvO8RScy35PVLDaevX7xfFhnJTCdn1RrxNkqJNqwgwqmkgKeZSeu
	 llEFFx0o0bwZFOXJqG3swV1D0ws2GG9y52cUwfNKriOR7yrvsAY6D8ysb9gHK6Hzsl
	 an+I/OIQYFvQn7CHD8JW6pDEplMfJoSuIMlUyHL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfBFXQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:16:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43022 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFXQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:16:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so15064062otr.10;
        Wed, 06 Feb 2019 15:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niW9xzR8HXazKHjHyB5B+Vq1LdApwoX++73+TW5nM0I=;
        b=LuWtodFvFk79ayCas3yxZeaQmXLf67BZ9WeI/+jOA7cQ9LYVtMczDw4eiPabsW9z60
         kMlaYInwD7jlG9p5Gm+IwhdfPkn3YBj8zh80Onxmmbv5k51tdveZlMzHMcJMR71/vunt
         enZnE+6abaByMqgEvWtAo3r4j/ChEV9I1rpIIXLoz1Eya9hT8jxK/7NXT/rUiKOQJHFi
         MrU1zIIFDGEJrwzsg2i3RWrBDjuvsrDDfH1Sx31y+IF37kuhTQSQjTxpAJDQPrX5MBqu
         GgHg7lxz2/7s/DeOdqfWv4Rv0srGvwmz9jJQkkJiDWhGmDYIaPHP8xXQXmBG55lpOh0d
         RkCA==
X-Gm-Message-State: AHQUAub8Lnloz48CIzF+ifPitiGXXbM/r7mrDj7Eoi7+bJhIJtqJtChP
        XOmm9aBKmalJcdZUuJGL/1/As+b0Pel1IjkXipA=
X-Google-Smtp-Source: AHgI3IYClNxZcL2lIHZNaSMmZ6fkyy9u9r5l91m+Tium+go1+Kz27efMJnBTfMTAwtVOUaqkQEfVXc2J1QzMtkl+rIM=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr954685oia.95.1549494995207;
 Wed, 06 Feb 2019 15:16:35 -0800 (PST)
MIME-Version: 1.0
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <CAJZ5v0jOVLZDoW5BAy9obp7AptTYzKikFo7Qd15kNt5Y9=vXRQ@mail.gmail.com>
 <CAPDyKFrq-r-rFDDB3yU=W4mOF2-A4xGGomqFqUba6MVWZugHmQ@mail.gmail.com>
 <24600564.pMaimVIQbW@aspire.rjw.lan> <CAJZ5v0gBYyoumVkLTuEcHsFE8QKEXdYuhDRGwmvoKPhx7gPvgQ@mail.gmail.com>
 <CAPDyKFoUfM8kopWfkorDhVKfk35wVaKVPzJeZ55RPRdc2Y1MYw@mail.gmail.com>
 <CAJZ5v0hnXyqdrq3cXLuwZ-imda2=EEUEq8rx=en7=DwdgB5N9A@mail.gmail.com> <CAPDyKFoQWTANLTdO1Ci_Vvtsq+QhWMxo=MZ811MoE6LSDWb7ng@mail.gmail.com>
In-Reply-To: <CAPDyKFoQWTANLTdO1Ci_Vvtsq+QhWMxo=MZ811MoE6LSDWb7ng@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Feb 2019 00:16:24 +0100
Message-ID: <CAJZ5v0jqZTuL_DKcJ308=4RDvTRoAxgzZkEaUSKcbTk=KNLW8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] driver core: Fix some device links issues and add
 "consumer autoprobe" flag
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Feb 6, 2019 at 2:02 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 6 Feb 2019 at 13:10, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Feb 6, 2019 at 12:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 6 Feb 2019 at 10:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Tue, Feb 5, 2019 at 12:27 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >
> > > > > On Tuesday, February 5, 2019 9:15:49 AM CET Ulf Hansson wrote:
> > > > > > On Mon, 4 Feb 2019 at 12:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 4, 2019 at 12:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Feb 1, 2019 at 4:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > [cut]
> > > >
> > > > > > >
> > > > > > > For example, if the consumer device is suspended after the
> > > > > > > device_link_add() that incremented the supplier's PM-runtime count and
> > > > > > > then resumed again, the rpm_active refcount will be greater than one
> > > > > > > because of the last resume and not because of the initial link
> > > > > > > creation.  In that case, dropping the supplier's PM-runtime count on
> > > > > > > link deletion may not work as expected.
> > > > > >
> > > > > > I see what your are saying and I must admit, by looking at the code,
> > > > > > that it has turned into being rather complicated. Assuming of good
> > > > > > reasons, of course.
> > > > > >
> > > > > > Anyway, I will play a little bit more with my tests to see what I can find out.
> > > > > >
> > > > > > >
> > > > > > > > Arguably, device_link_del() could be made automatically drop the
> > > > > > > > supplier's PM-runtime count by one if the link's rpm_active refcount
> > > > > > > > is not one, but there will be failing scenarios in that case too
> > > > > > > > AFAICS.
> > > > > >
> > > > > > Let's see.
> > > > >
> > > > > So for the record, below is the (untested) patch I'm thinking about.
> > > > >
> > > > > Having considered this for some time, I think that it would be better to
> > > > > try to drop the supplier's PM-runtime usage counter on link removal even if
> > > > > the link doesn't go away then.  That would be more consistent at least IMO.
> > > >
> > > > So I can't convince myself that this is the case.
> > > >
> > > > Either way, if there are two callers of device_link_add() for one
> > > > consumer-supplier pair trying to add a stateless link between them and
> > > > one of these callers passes DL_FLAG_RPM_ACTIVE set in the flags to it,
> > > > there may be issues regardless of what device_link_del() and
> > > > device_link_remove() do.  However, if they decrement the link's
> > > > rpm_active refcount (and possibly the supplier's PM-runtime usage
> > > > counter too), the supplier may be suspended prematurely, whereas in
> > > > the other case (no decrementation of rpm_active, which how the code
> > > > works after this series) it may just be prevented from suspending.  To
> > > > me, the former is worse than the latter.
> > >
> > > Well, I would say it sucks in both cases. :-)
> > >
> > > >
> > > > Moreover, there is a workaround for the latter issue that seems to be
> > > > easy enough: it is sufficient to let the consumer runtime suspend
> > > > after calling device_link_add() to create the link (with
> > > > DL_FLAG_RPM_ACTIVE set) and before trying to remove it.
> > >
> > > I get your point, but unfortunate I don't think it's that simple.
> > >
> > > For example, someone (like a child) may prevent runtime suspend for
> > > the consumer. Hence, also the supplier is prevented from being runtime
> > > suspended.
> >
> > Well, in that case the supplier should not be suspended until the
> > consumer can be suspended too.
> >
> > IOW, if you call device_link_del() in that case, it would be a bug if
> > it allowed the supplier suspend.
>
> Well, maybe the "child" was a bad example. The point is, the driver
> doesn't control the RPM child count and nor the RPM usage count for
> its consumer device - solely by itself.
>
> Someone, like the driver/PM core can at some point decide to increase
> the runtime PM usage count for example for the consumer device. For
> whatever good reason.

If PM-runtime is enabled for the consumer and there is a good enough
reason why it cannot suspend, then the supplier cannot suspend too.
Again, allowing the supplier to suspend in that situation would be a
bug.

However, the supplier can be allowed to suspend if PM-runtime is not
enabled for the consumer and it is not operational (and the latter
needs to be known to whoever wants to allow the supplier to suspend).

> >
> > > So, if you want to push this responsibility to the driver, then I
> > > think we need make __pm_runtime_set_status() to respect device links,
> > > similar to how it already deals with child/parents.
> > >
> > > In that way, the driver could call pm_runtime_set_suspended(), before
> > > dropping the device link in ->probe(), which would allow the supplier
> > > to also become runtime suspended.
> >
> > I guess you mean that runtime PM would be disabled for the consumer at
> > that point?
>
> Yes.
>
> Calling pm_runtime_set_suspended() should be a part of the error path
> in the driver, which includes disabling runtime PM as well (if it
> enabled it in the first place of course).

OK

I admit that it would make sense to change __pm_runtime_set_status()
to take device links into account.

> >
> > > I did a quick research of users of device links, unless I am mistaken,
> > > this seems like an okay approach.
> > >
> > > What do you think?
> >
> > Well, I think I need to know the exact use case you have in mind. :-)
>
> The use case is simply a generic driver that fails to probe by
> returning -EPROBE_DEFER. So it's hypothetical, but I often tests
> common sequences by using my RPM testdriver, to make sure it all works
> as expected.
> The below sequence is common, so then I have added the use of device
> links, to see how this plays. And it doesn't.
>
> ->probe()
>   ...
>
>   pm_runtime_get_noresume()
>   pm_runtime_set_active()
>   pm_runtime_enable()

I don't think you can do the above safely without ensuring that the
supplier is not suspended upfront.  So you need

pm_runtim_get_sync(supplier);

before the above, and then ->

>
>   ...
>
>   device_link_add(con, supp, DL_FLAG_STATELESS |DL_FLAG_PM_RUNTIME |
> DL_FLAG_RPM_ACTIVE);
>
> we got some errors...
>   goto err:

-> it is not necessary to add the link before the point at which you
know that you are not going to return any errors (except when the link
creation itself fails).  So then you do

device_link_add(con, supp, DL_FLAG_STATELESS |
                          DL_FLAG_PM_RUNTIME |
                          DL_FLAG_RPM_ACTIVE);
...
pm_runtime_put_noidle(supplier);

and the link prevents the supplier from suspending until the consumer
is suspended.

>
>   ...
>
> err:
>   pm_runtime_put_noidle()
>   pm_runtime_disable()
>   pm_runtime_set_suspended()
>
>   device_link_remove()
>
>   return err;

In particular, device links really should not be added and removed
before returning -EPROBE_DEFER IMO, because adding them causes
dpm_list to be re-ordered and that may be quite heavy if the consumer
has children etc.
