Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359D3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC42420818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehuZw6Dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfBEIQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:16:28 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34855 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfBEIQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:16:27 -0500
Received: by mail-vs1-f68.google.com with SMTP id e7so1637527vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 00:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJRZPHo4UdrivNyUfxxuCBcvinGNtztDTT9MkE5hMQo=;
        b=ehuZw6DvsokpE/nBdprpY/tgDFN3CKTiqbk2xtyDOv5jRNMSpzcnp8AsSe5isVS64r
         W4rut2Jw91gg6iSNb6dcNZeAsq3eEESISvwwKL6ImKoVRwBJ0DmW8uC7ES5PwfT+2WrO
         in+DZUS46XWR816U8M9ERf84hE2Y7VMqM1K0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJRZPHo4UdrivNyUfxxuCBcvinGNtztDTT9MkE5hMQo=;
        b=SDAeQYqC1PgrpswhGL/+kbdhVGZLy+WdBIwT51CqIv6lIXJBb5rTZE5H7taN37JQMA
         xeHj4CSUDlwSveVEoe//VrrhO6k8/sbFUIFJZtM5cRX1TYgPcqZXnFMbOSwDKH5l9EbZ
         Pqxjn8FHfRjKH3m43xFBgIwAXDpMyM0Y+zI8k6KkN3Y/jvoSbXR8pewWnJCr9JHz0gK4
         s+8ctETYYitQogzi1QGuYRghT/t4DPlH5e0UN1D3f90YGn0p/7yez42ivicnFoKYWO9b
         bnT1DNggXqxRYIsKZaIyjrlq+K2n/H6u7k+Vq09QjVugX2WZoFXtv6MpNSsWf3rGV/B9
         pi6w==
X-Gm-Message-State: AHQUAuZuCcNGPuh5SMt+knW1Ur3bkfQhyIW0qsgi+EGffnvDkuEPK/RY
        5yqKTFfdQeQuMsClWJ0QM7ZQS8IjgDfkCE6zpKGO1Q==
X-Google-Smtp-Source: AHgI3IZkdVsPYcGQHfmqKYS50vqMjZLhBnAA+Bt+lQy1J6IkZM/haveBA+uND9GZmBspW+g7Uw8cInTDegki0s7wfm8=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr1516022vsa.165.1549354586410;
 Tue, 05 Feb 2019 00:16:26 -0800 (PST)
MIME-Version: 1.0
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <CAPDyKFqG-wN+=9i4X+BeREekzKNt0icE==P60Cu1FhsGRNcJjg@mail.gmail.com>
 <CAJZ5v0g0BC900-u1wivAWqq=XomPgpfpz7s=sWgvCML+2MwLgg@mail.gmail.com> <CAJZ5v0jOVLZDoW5BAy9obp7AptTYzKikFo7Qd15kNt5Y9=vXRQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jOVLZDoW5BAy9obp7AptTYzKikFo7Qd15kNt5Y9=vXRQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 Feb 2019 09:15:49 +0100
Message-ID: <CAPDyKFrq-r-rFDDB3yU=W4mOF2-A4xGGomqFqUba6MVWZugHmQ@mail.gmail.com>
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

On Mon, 4 Feb 2019 at 12:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Feb 4, 2019 at 12:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Feb 1, 2019 at 4:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Fri, 1 Feb 2019 at 02:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > Hi Greg at al,
> > > >
> > > > This is a combination of the two device links series I have posted
> > > > recently (https://lore.kernel.org/lkml/2493187.oiOpCWJBV7@aspire.rjw.lan/
> > > > and https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) rebased
> > > > on top of your driver-core-next branch.
> > > >
> > > > Recently I have been looking at the device links code because of the
> > > > recent discussion on possibly using them in the DRM subsystem (see for
> > > > example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> > > > found a few issues in that code which should be addressed by this patch
> > > > series.  Please refer to the patch changelogs for details.
> > > >
> > > > None of the problems addressed here should be manifesting themselves in
> > > > mainline kernel today, but if there are more device links users in the
> > > > future, they most likely will be encountered sooner or later.  Also they
> > > > need to be fixed for the DRM use case to be supported IMO.
> > > >
> > > > On top of this the series makes device links support the "composite device"
> > > > use case in the DRM subsystem mentioned above (essentially, the last patch
> > > > in the series is for that purpose).
> > > >
> > >
> > > Rafael, Greg, I have reviewed patch 1 -> 7, they all look good to me.
> > >
> > > If not too late, feel free to add for the first 7 patches:
> > >
> > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Thanks!
> >
> > > Although, I want to point out one problem that I have found when using
> > > device links. I believe it's already there, even before this series,
> > > but just wanted to described it for your consideration.
> > >
> > > This is what happens:
> > > I have a platform driver is being probed. During ->probe() the driver
> > > adds a device link like this:
> > >
> > > link = device_link_add(consumer-dev, supplier-dev, DL_FLAG_STATELESS |
> > > DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
> > >
> > > At some point later in ->probe(), the driver realizes that it must
> > > remove the device link, either because it encountered an error or
> > > simply because it doesn't need the device link to be there anymore.
> > > Thus it calls:
> > >
> > > device_link_del(link);
> > >
> > > When probe finished of the driver, the runtime PM usage count for the
> > > supplier-dev remains increased to 1 and thus it never becomes runtime
> > > suspended.
> >
> > OK, so this is a tricky one.
> >
> > With this series applied, if the link actually goes away after the
> > cleanup device_link_del(), device_link_free() should take care of
> > dropping the PM-runtime count of the supplier.  If it doesn't do that,
> > there is a mistake in the code that needs to be fixed.

Unless this is a of your "distracted part", then I think this is what
happening and thus is a problem.

> >
> > However, if the link doesn't go away after the cleanup
> > device_link_del(), the supplier's PM-runtime count will not be
> > dropped, because the core doesn't know whether or not the
> > device_link_del() has been called by the same entity that caused the
> > supplier's PM-runtime count to be incremented.  For example, if the
> > consumer device is suspended after the device_link_add() that
> > incremented the supplier's PM-runtime count and then suspended again,
>
> I was distracted while writing this, sorry for the confusion.
>
> So let me rephrase:
>
> For example, if the consumer device is suspended after the
> device_link_add() that incremented the supplier's PM-runtime count and
> then resumed again, the rpm_active refcount will be greater than one
> because of the last resume and not because of the initial link
> creation.  In that case, dropping the supplier's PM-runtime count on
> link deletion may not work as expected.

I see what your are saying and I must admit, by looking at the code,
that it has turned into being rather complicated. Assuming of good
reasons, of course.

Anyway, I will play a little bit more with my tests to see what I can find out.

>
> > Arguably, device_link_del() could be made automatically drop the
> > supplier's PM-runtime count by one if the link's rpm_active refcount
> > is not one, but there will be failing scenarios in that case too
> > AFAICS.

Let's see.

Kind regards
Uffe
