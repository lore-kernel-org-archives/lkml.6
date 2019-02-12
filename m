Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A78C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FDE21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/Ueq6i5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfBLIEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:04:02 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34273 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfBLIEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:04:02 -0500
Received: by mail-vk1-f193.google.com with SMTP id y14so405904vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZJj2fbw2xp2RToklDNMwLcaz9yaqOOEbTuk0woqPJg=;
        b=G/Ueq6i57AV9qx4qGeSAG/PQCx770oR5DFBAn2/ZswgJ8SYdKi06bu62rXFod3HLC0
         HTtx3PexnS45BTg1j6ToaMttYcFLVKTSU1RKfzbrQ0tIO9UHLdTYOV3kLdeyrd75sMv7
         EYSsCB/f64S3cmJKP7xzsTw4zaMDa6AlD3L3XeEry1xNBAHGjWQtNe+3Wkg/tg5Aarcp
         QvEwrNypugePpqQou1PEDVHnGO4ZserHB0FhcqGnBU3ROzjb9nwplIHIqfax3V7Rc2Fn
         4cP426pl9zh4PS0mOnw4NrifNAdanrjUJj3YGpQzjugkEHLi+4kQjbHNG3zS0THynthR
         GRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZJj2fbw2xp2RToklDNMwLcaz9yaqOOEbTuk0woqPJg=;
        b=RCgWPbE4vqkSX05Vpsy25H/g2pEQZJCo4/v1x7Ti1VV0DNopBigdnzejM7fqh0/UKm
         NxFnQgNcgmyUBP3ETYigbkA/KGJd+HfOxiBDn5ANzzOn6Rldi1HOz841k131thIyWqEG
         FxUW4tZ8/tLwUj/PYzQhGWQ/JrbLdRaLuN4bi5HpcKNMFdsjr5x9UGQdX9uwdl+DTChx
         mdgSyMcuo2eNC08xFvt7RLS3+gbRctCmLJkFfUM+yGIoD294W65+oXXnv7yzgzLt7mTK
         3fxBbUBiSNtD1dBZdWhpuSAwWHr9F2s71WQhfBTk32Q6YPpk96MFmw7/P43pDdWhXtDM
         shXQ==
X-Gm-Message-State: AHQUAubxLCGisFZ0EFlLAqop5Xa3j/grY/Hudx2Cf6HfpZkJy1lwYxrH
        7K4Ppq9njwJ+OffYemE5oThUn3zmUBLwqVgS8q8Dag==
X-Google-Smtp-Source: AHgI3IZUJIAZtnxvhwDDA33ttXlJBb5/cVJ7Xuqp0wTkGnb7Aq3ANqkMkhyxA/8QlKooYQ16EIoqDlOkbJaHp/WB8sg=
X-Received: by 2002:a1f:4982:: with SMTP id w124mr1032302vka.4.1549958640352;
 Tue, 12 Feb 2019 00:04:00 -0800 (PST)
MIME-Version: 1.0
References: <3917694.ab5GGAjohB@aspire.rjw.lan> <1634058.cXDNg15SOd@aspire.rjw.lan>
 <CAPDyKFpWCT9CcmxqqWk+S8tSPz_at56UCnk3EVBab-TnScHw8Q@mail.gmail.com>
 <CAPDyKFqnWgjZ1icajdzbaQ_HW-2ec0-npEU_nAWvSVEpZMzSRA@mail.gmail.com> <CAJZ5v0hV-G_U=XV1N=rpEv1LMgB+jjB3kVEoHKUasd2p3QP5Bg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hV-G_U=XV1N=rpEv1LMgB+jjB3kVEoHKUasd2p3QP5Bg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Feb 2019 09:03:23 +0100
Message-ID: <CAPDyKFrtVHNA0-zAbUYR9k_qWKQUS2f+1Z=VLhvfQ=EDcBkPKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: Take suppliers into account in __pm_runtime_set_status()
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

On Tue, 12 Feb 2019 at 00:05, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Feb 11, 2019 at 4:51 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Mon, 11 Feb 2019 at 14:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 7 Feb 2019 at 19:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > If the target device has any suppliers, as reflected by device links
> > > > to them, __pm_runtime_set_status() does not take them into account,
> > > > which is not consistent with the other parts of the PM-runtime
> > > > framework and may lead to programming mistakes.
> > > >
> > > > Modify __pm_runtime_set_status() to take suppliers into account by
> > > > activating them upfront if the new status is RPM_ACTIVE and
> > > > deactivating them on exit if the new status is RPM_SUSPENDED.
> > > >
> > > > If the activation of one of the suppliers fails, the new status
> > > > will be RPM_SUSPENDED and the (remaining) suppliers will be
> > > > deactivated on exit (the child count of the device's parent
> > > > will be dropped too then).
> > > >
> > > > Of course, adding device links locking to __pm_runtime_set_status()
> > > > means that it cannot be run fron interrupt context, so make it use
> > > > spin_lock_irq() and spin_unlock_irq() instead of spin_lock_irqsave()
> > > > and spin_unlock_irqrestore(), respectively.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Rafael, thanks for working on this!
> > >
> > > I am running some tests at my side, but still not achieving the
> > > behavior I expect to. Will let you know when I have more details, but
> > > first some comments below.
> >
> > Alright, this is what I found.
> >
> > When I call pm_runtime_set_suspended(), in the ->probe() error path of
> > my RPM test driver (I am removing the device link afterwards), then my
> > expectation was that this should allow the supplier to become runtime
> > suspended (sooner or later). This isn't the case, as it turns out the
> > runtime PM usage count of the supplier, still remains 1 after the
> > probe failure.
> >
> > My observation is that with $subject patch, the link->rpm_active count
> > is now reaching 1, before it stayed at 2 - so one step forward. :-)
> >
> > However, the reason to why the runtime PM usage count never reaches 0,
> > is because of the call to pm_runtime_get_noresume(supplier) in
> > device_link_rpm_prepare(), which is called from device_link_add().
>
> That was there previously, I've just moved it to device_link_rpm_prepare().

Correct. The problem been there before. Even without using  DL_FLAG_RPM_ACTIVE.

>
> But good catch!
>
> > To solve the problem, it seems like we need to call
> > pm_runtime_put(supplier), in case the device link is deleted while the
> > consumer is still probing.
>
> I'd rather change the way pm_runtime_get/put_suppliers() work, so that
> they use the rpm_active refcount, but pm_runtime_put_suppliers() only
> drops it by one - unless it is one already.

That seems like a very reasonable approach!

The mix between calling pm_runtime_get/put*() on the supplier device
directly vs using the path with the rpm_active count, is to me rather
confusing. Using only the latter, would be a nice cleanup anyway, I
think.

>
> Then, when adding a new link with DL_FLAG_RPM_ACTIVE,
> device_link_add() only needs to increment its rpm_active *twice*
> (instead of doing that once as to does now), so it will stay above one
> after the subsequent pm_runtime_put_suppliers() - and if it goes away
> in the meantime, then it will be cleaned up by the removal.

Assuming you will add a check for "consumer->links.status ==
DL_DEV_PROBING" to understand if rpm_active should by be decreased.

Yes, it seems reasonable.

>
> In turn, if a link is created without DL_FLAG_RPM_ACTIVE, its
> rpm_active is one and then pm_runtime_put_suppliers() will just skip
> it.
>
> A patch will follow. :-)

Great, I am here to review it. :-)

Kind regards
Uffe
