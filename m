Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6E1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727632173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNsOwq+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfBGTzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:55:36 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39396 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfBGTzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:55:35 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so2905439itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 11:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yuwb+5FOI6hWVyTZ/nLpjSNm5TPH0/gmq35Pv0UCtNk=;
        b=HNsOwq+wJ8HKOEW3kDCnKXq7K11ens5V2X0pjzTUjS5uRiOA6xtWfWIAD8fiLLCZw1
         x0BQLv5H9JyE7BWPW2f58U69j2bpEKSumwr4mxGPB9pufQg/ZnVwKpzVyMY9wLUjxMz0
         Vy6I+yE2UNQ9GSE2R89qeglqTgkmoGm31hGaldUxePxJk0wMUEtye5DAnwNNOlTaci3n
         8dgNERlOsn9wKIy2j2hGt1ZXeZ7P9cSABqCjw0fMzidbtG6OwS4s6IW14BvRazXjqjXF
         hjhGm/77bdybLxzkEpz2/CCwOnr+k5dftZwg1o8ak5BhcTbFhUB99fIjlQKzEDcL2Vt7
         wGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yuwb+5FOI6hWVyTZ/nLpjSNm5TPH0/gmq35Pv0UCtNk=;
        b=D0EdkBdTJZWuuSXp3zyvJM/QyNETpAu55BZa8OTnLR+zehtYuqltPzcsLGkrGwmBwI
         3gY4fkK42kY0PWdAYKvhp9ChmQcQ5gOQUUDVFm94GFw45ZEyfZ1uk9D13ALIa0Bjpbfz
         CsFObsX6TWL2x+ndtXBjyswNF0qPzMFFjv2DZLRl0ZGxS61XXw69utV+OP7/ELBXi1ZN
         JhdKiy2zUSZ/89e/RmDX5j4bC5pjP93Z75kdqhxLIr1oGID1bHIGJdTFTiqT1FrBnNn4
         90n3UwQ7Tq1gCouPBnR0ibfTkcCcCte8FV8Q1U7Svf/ZT1xvm6Z4rcdD6oZF5VDTZyCv
         4Ogw==
X-Gm-Message-State: AHQUAuZWAU5m1J2y/5yvHnMj3HHoKfTVGcnbEbVLx1IwPrrfOyFZNgXv
        B2gKb/bkcpLIPO6vNOo2dRjzzCFHoFVLsjTFv1jQnw==
X-Google-Smtp-Source: AHgI3IaKHd/NHuIDU+4Yyvf7byW07bRylK2p4NHS3AW6hF3cMHdPC9k3UGbBRdVprOULszcz0GRvkRnr9XgiFsVRWLk=
X-Received: by 2002:a02:9549:: with SMTP id y67mr9885238jah.4.1549569334272;
 Thu, 07 Feb 2019 11:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20190207185917.167829-1-egranata@google.com> <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
 <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
In-Reply-To: <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
From:   Enrico Granata <egranata@google.com>
Date:   Thu, 7 Feb 2019 11:55:22 -0800
Message-ID: <CAPR809svTVRJX-GrcSuBe+GmMOzzSHsoOTqHOCydWksEfetf=Q@mail.gmail.com>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to platform_get_irq()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as plain text; comments inlined.

On Thu, Feb 7, 2019 at 11:39 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Feb 7, 2019 at 9:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > +Mika Westerberg
> > +Andy Shevchenko
> > +Hans de Goede
>
> Thanks, Rafael.
> My comments below.
>
> > On Thu, Feb 7, 2019 at 7:59 PM <egranata@google.com> wrote:
> > >
> > > From: Enrico Granata <egranata@chromium.org>
> > >
> > > ACPI 5 added support for GpioInt resources as a way to provide
> > > information about interrupts mediated via a GPIO controller.
> > >
> > > Several device buses (e.g. SPI, I2C) have support for retrieving
> > > an IRQ specified via this type of resource, and providing it
> > > directly to the driver as an IRQ number.
>
> > > This is not currently done for the platform drivers, as platform_get_irq()
> > > does not try to parse GpioInt() resources.
>
> And why is this a problem?

In ChromeOS, we have a driver (cros_ec_lpc) which can run either on
systems that directly expose the interrupt,
or systems where the interrupt goes through a GPIO controller. On the
former, firmware provides an Interrupt resource
and platform_get_irq() finds it. On the latter, firmware provides a
GpioInt resource and platform_get_irq does not
find it. We could work around this in the driver by probing both
paths, but since other subsystems seem to directly
look for GpioInt resources, it seemed to us to make more sense to
extend platform_get_irq() instead.

> > > This commit adds that functionality.
>
> How that can override the configuration / BIOS flavour when driver
> needs to register an interrupt out of GpioIo() resource?
>
> P.S. Have you looked at drivers/platform/x86/i2c-multi-instantiate.c
> and intel_cht_int33fe.c?

Those drivers seem to only ever expect a GpioInt(). Our case is one
where both are possible,
depending on the system we're running on. We are trying not to put
ad-hoc logic in the driver,
but if you think that doing so would be our best course of action,
please do let us know.

> They are the only drivers which needs something like this for now and
> I would rather say it's a bad BIOS decision to write a table like
> that.

Do you have any suggestions to write proper firmware tables to avoid this issue?

>
> --
> With Best Regards,
> Andy Shevchenko
