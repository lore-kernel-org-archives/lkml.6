Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5910D222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFIUMRPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfBLS23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:28:29 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33887 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfBLS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:28:28 -0500
Received: by mail-vs1-f66.google.com with SMTP id e10so2233831vsp.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZwFDk0xM1aJPTl7CsbyQporOjEvFZ14SRbsKRfZ0us=;
        b=dFIUMRPtrNeuT0dKFFS/OIVxY2XZ5r09cxmoqb+ZMy36EhZTL1FmU3jn68WCwXAwxb
         0yYKepvir2lmZ4ig9WReDZwoGY2wn8xndcVQiaKDGMtW7l13n55Gu8NCkHOfZx+HeS+Q
         16fKM3u7zCrM63jFWoxDS/qU6c+1AW+CWa8PTZCPQC9e1kxJ6ZGfFY8IeDtLawKqCkNr
         9N7XViouKkiqcvNeZ/1jj1otuyoZRizssrhZ/QTp36FGzKFFfaruJstpwQ1gVmIyAgMo
         v89ip3RQPq6/ZD1yLowk7qFIkQGDx4QuGEksMW7nK7v1EaMVmk8Anem+79+9sAaV3VGR
         bBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZwFDk0xM1aJPTl7CsbyQporOjEvFZ14SRbsKRfZ0us=;
        b=hyw/AlXHJxVpH+CoMcFyISUYb/A6nRScOdRUYudebLMpgKYnhYTaLyZoHuJig3qqqw
         jZAqVifXHRl72YYPrba1KZsFGFaMI14utA1FCIiZgFkew5APEtVBEeNgeb71oxREhqNr
         17xAAiaVbOBDz19c519YzPYapI1D01hrSMQFLvwwOoSYz5EAHiWvARrQ5vVJTkrpKQ79
         vG3vkghHrlSW5xoEB3g8G1p99XHiAk01JjxIXlLAon4unWfhS2M6MlTXHP2B97aVRgew
         ytk8LLboU3r9ZITJuFx1HGY3+ypkczATb9lIZWP6eSIsSAa61At2qIiT3MfIMkW1J7Xz
         GKnQ==
X-Gm-Message-State: AHQUAuZ6jxWpcdr/03aceWdEl/2EAZqw35Kf06DOsGa4B3JwHCgRUOTN
        rPm7MuE7LZNsMtPeDayrm0l17yRs8fj+t5OB10F1KQ==
X-Google-Smtp-Source: AHgI3IacYKC2qFakMSGQOGooH3Yy5Dj0Y3zhpWdGm9IZ1yIDtj+zqKnEsiab+P3GRA8D1hxpvrl7SCQl3SI5vhheJHg=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr2109265vsa.165.1549996106632;
 Tue, 12 Feb 2019 10:28:26 -0800 (PST)
MIME-Version: 1.0
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <1670239.00ZbddH1IV@aspire.rjw.lan>
 <CAPDyKFoR+evmvDehgTJvxcZ70ZLTqU5J4To_c=2vYdOk26h92w@mail.gmail.com> <CAJZ5v0jv6dboQd=iu9pHA_B2HzCEhd2WaN3-732S9px_u6MA-w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jv6dboQd=iu9pHA_B2HzCEhd2WaN3-732S9px_u6MA-w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Feb 2019 19:27:50 +0100
Message-ID: <CAPDyKFpNWrVCW9xwwsWf=vGukEkSj4qYs58terDy0tmmrhyLDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: Fix __pm_runtime_set_status() race with
 runtime resume
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
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 at 17:28, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 12, 2019 at 5:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 12 Feb 2019 at 13:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Commit 4080ab083000 ("PM-runtime: Take suppliers into account in
> > > __pm_runtime_set_status()") introduced a race condition that may
> > > trigger if __pm_runtime_set_status() is used incorrectly (that is,
> > > if it is called when PM-runtime is enabled for the target device
> > > and working).
> > >
> > > In that case, if the original PM-runtime status of the device is
> > > RPM_SUSPENDED, a runtime resume of the device may occur after
> > > __pm_runtime_set_status() has dropped its power.lock spinlock
> > > and before deactivating its suppliers, so the suppliers may be
> > > deactivated while the device is PM-runtime-active which may lead
> > > to functional issues.
> > >
> > > To avoid that, modify __pm_runtime_set_status() to check whether
> > > or not PM-runtime is enabled for the device before activating its
> > > suppliers (if the new status is RPM_ACTIVE) and either return an
> > > error if that's the case or increment the device's disable_depth
> > > counter to prevent PM-runtime from being enabled for it while
> > > the remaining part of the function is running (disable_depth is
> > > then decremented on the way out).
> > >
> > > Fixes: 4080ab083000 ("PM-runtime: Take suppliers into account in __pm_runtime_set_status()")
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/runtime.c |   24 ++++++++++++++++++------
> > >  1 file changed, 18 insertions(+), 6 deletions(-)
> > >
> > > Index: linux-pm/drivers/base/power/runtime.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > +++ linux-pm/drivers/base/power/runtime.c
> > > @@ -1129,6 +1129,22 @@ int __pm_runtime_set_status(struct devic
> > >         if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
> > >                 return -EINVAL;
> > >
> > > +       spin_lock_irq(&dev->power.lock);
> > > +
> > > +       /*
> > > +        * Prevent PM-runtime from being enabled for the device or return an
> > > +        * error if it is enabled already and working.
> > > +        */
> > > +       if (dev->power.runtime_error || dev->power.disable_depth)
> > > +               dev->power.disable_depth++;
> > > +       else
> > > +               error = -EAGAIN;
> > > +
> > > +       spin_unlock_irq(&dev->power.lock);
> > > +
> > > +       if (error)
> > > +               return error;
> > > +
> > >         /*
> > >          * If the new status is RPM_ACTIVE, the suppliers can be activated
> > >          * upfront regardless of the current status, because next time
> > > @@ -1147,12 +1163,6 @@ int __pm_runtime_set_status(struct devic
> > >
> > >         spin_lock_irq(&dev->power.lock);
> > >
> > > -       if (!dev->power.runtime_error && !dev->power.disable_depth) {
> > > -               status = dev->power.runtime_status;
> > > -               error = -EAGAIN;
> > > -               goto out;
> > > -       }
> > > -
> > >         if (dev->power.runtime_status == status || !parent)
> > >                 goto out_set;
> > >
> > > @@ -1205,6 +1215,8 @@ int __pm_runtime_set_status(struct devic
> > >                 device_links_read_unlock(idx);
> > >         }
> > >
> > > +       pm_runtime_enable(dev);
> >
> > pm_runtime_enable() uses spin_lock_irqsave(), rather than
> > spin_lock_irq() - is there a reason to why you want to allow that
> > here, but not earlier in the function?
>
> Device links locking cannot be used in interrupt context.

I get that, but thanks for clarifying.

However, then why did you convert __pm_runtime_set_status() from using
spin_lock_irqsave() to spin_lock_irq() in commit "PM-runtime: Take
suppliers into account in __pm_runtime_set_status()"?

As far as I can tell, the spin_lock is not being held while we operate
on the device links anyway. Or is this just to give the caller an
indication what kind of context the function can be called from?

Kind regards
Uffe
