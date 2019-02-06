Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37928C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7F92175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549455051;
	bh=bqNMKvsHLsTxSy24+4x9/lnwCCxdiV0vDS70NkcaqRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ua486b+pjQZiliSUeIMIIA0R5QJFceJLDPOV7jCuiisOhC/2vsCAoKV0nMQt+wNWj
	 SDtC6xqJTK3srZS4fNZaoPtojhqTAg/TafR79QYHKHkMy3NRXPGqIiPROp0mTDbX6Z
	 3vM6RClbWkoAvc2oXYT3UQcQvTsEaDlX7RjAEDJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfBFMKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:10:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43985 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfBFMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:10:49 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so11376159otr.10;
        Wed, 06 Feb 2019 04:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iU9FZ7LsLqk37gyhfU2Cej00CA9dwq7wg+MRo8yI1FU=;
        b=AxmtxzdTNwwUYp6Faf7vbmiI8N980z8sGz7lU6o5dxkKxoq6AmysENWxcKupXgKhMi
         p0UYxKLxktS40UEKuP2NDUduLFUL/sG0Mpr5iiipjQqYJ8E/O5Y0Wo5VQXtpcYcRxq7+
         hE3WmdSlDffMsrJuYNS39whA8lUrouZSj3ROySibrwc2TfroV5G0YrJtvdWrS8Vc5YBa
         /DFy/Zp1+JQ849yx3MPmveV7ihWMjWU2NVTRGhYyuA8UOSyiMTm4S7VHF0IUogHZt1wS
         Aq4VRwTTaM5tbMcEG6kCbohX9xymMdhVTzwBTGjTcyXCDCRQ0IUZNVfQQXOJ+Yfdsch7
         EzUQ==
X-Gm-Message-State: AHQUAuab/Al5TnyRCkdGOl9Otk8O5cP8Xjqc7MFXcG7/OkFZhN7G/yBJ
        b/CZH4KtkXqd/krtj+FiXfjxzOvnNujxINHg1J0=
X-Google-Smtp-Source: AHgI3Ia5Gs/MNg+UkT5qBPibqN7u6i14i1ff2jlaYvMCN8KR5pBvkFRd+znGrNCRMMTuFz4YgaaS2vf9Iw0DYPMg24Y=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr5656765oti.258.1549455047618;
 Wed, 06 Feb 2019 04:10:47 -0800 (PST)
MIME-Version: 1.0
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <CAJZ5v0jOVLZDoW5BAy9obp7AptTYzKikFo7Qd15kNt5Y9=vXRQ@mail.gmail.com>
 <CAPDyKFrq-r-rFDDB3yU=W4mOF2-A4xGGomqFqUba6MVWZugHmQ@mail.gmail.com>
 <24600564.pMaimVIQbW@aspire.rjw.lan> <CAJZ5v0gBYyoumVkLTuEcHsFE8QKEXdYuhDRGwmvoKPhx7gPvgQ@mail.gmail.com>
 <CAPDyKFoUfM8kopWfkorDhVKfk35wVaKVPzJeZ55RPRdc2Y1MYw@mail.gmail.com>
In-Reply-To: <CAPDyKFoUfM8kopWfkorDhVKfk35wVaKVPzJeZ55RPRdc2Y1MYw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Feb 2019 13:10:35 +0100
Message-ID: <CAJZ5v0hnXyqdrq3cXLuwZ-imda2=EEUEq8rx=en7=DwdgB5N9A@mail.gmail.com>
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

On Wed, Feb 6, 2019 at 12:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 6 Feb 2019 at 10:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Feb 5, 2019 at 12:27 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Tuesday, February 5, 2019 9:15:49 AM CET Ulf Hansson wrote:
> > > > On Mon, 4 Feb 2019 at 12:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Mon, Feb 4, 2019 at 12:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Feb 1, 2019 at 4:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > [cut]
> >
> > > > >
> > > > > For example, if the consumer device is suspended after the
> > > > > device_link_add() that incremented the supplier's PM-runtime count and
> > > > > then resumed again, the rpm_active refcount will be greater than one
> > > > > because of the last resume and not because of the initial link
> > > > > creation.  In that case, dropping the supplier's PM-runtime count on
> > > > > link deletion may not work as expected.
> > > >
> > > > I see what your are saying and I must admit, by looking at the code,
> > > > that it has turned into being rather complicated. Assuming of good
> > > > reasons, of course.
> > > >
> > > > Anyway, I will play a little bit more with my tests to see what I can find out.
> > > >
> > > > >
> > > > > > Arguably, device_link_del() could be made automatically drop the
> > > > > > supplier's PM-runtime count by one if the link's rpm_active refcount
> > > > > > is not one, but there will be failing scenarios in that case too
> > > > > > AFAICS.
> > > >
> > > > Let's see.
> > >
> > > So for the record, below is the (untested) patch I'm thinking about.
> > >
> > > Having considered this for some time, I think that it would be better to
> > > try to drop the supplier's PM-runtime usage counter on link removal even if
> > > the link doesn't go away then.  That would be more consistent at least IMO.
> >
> > So I can't convince myself that this is the case.
> >
> > Either way, if there are two callers of device_link_add() for one
> > consumer-supplier pair trying to add a stateless link between them and
> > one of these callers passes DL_FLAG_RPM_ACTIVE set in the flags to it,
> > there may be issues regardless of what device_link_del() and
> > device_link_remove() do.  However, if they decrement the link's
> > rpm_active refcount (and possibly the supplier's PM-runtime usage
> > counter too), the supplier may be suspended prematurely, whereas in
> > the other case (no decrementation of rpm_active, which how the code
> > works after this series) it may just be prevented from suspending.  To
> > me, the former is worse than the latter.
>
> Well, I would say it sucks in both cases. :-)
>
> >
> > Moreover, there is a workaround for the latter issue that seems to be
> > easy enough: it is sufficient to let the consumer runtime suspend
> > after calling device_link_add() to create the link (with
> > DL_FLAG_RPM_ACTIVE set) and before trying to remove it.
>
> I get your point, but unfortunate I don't think it's that simple.
>
> For example, someone (like a child) may prevent runtime suspend for
> the consumer. Hence, also the supplier is prevented from being runtime
> suspended.

Well, in that case the supplier should not be suspended until the
consumer can be suspended too.

IOW, if you call device_link_del() in that case, it would be a bug if
it allowed the supplier suspend.

> So, if you want to push this responsibility to the driver, then I
> think we need make __pm_runtime_set_status() to respect device links,
> similar to how it already deals with child/parents.
>
> In that way, the driver could call pm_runtime_set_suspended(), before
> dropping the device link in ->probe(), which would allow the supplier
> to also become runtime suspended.

I guess you mean that runtime PM would be disabled for the consumer at
that point?

> I did a quick research of users of device links, unless I am mistaken,
> this seems like an okay approach.
>
> What do you think?

Well, I think I need to know the exact use case you have in mind. :-)
