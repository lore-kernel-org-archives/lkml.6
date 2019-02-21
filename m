Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B224FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773682083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxM8uB/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfBUS63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:58:29 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46981 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfBUS62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:58:28 -0500
Received: by mail-io1-f68.google.com with SMTP id k21so3096512ior.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fg/zRGOqEr6soWn4lYJNlKofJY1rut3rOP2dQ7jtbg=;
        b=SxM8uB/EhPIbquPtTx+TLO7T5riQ5OPLUZfupa6Zy44VtZyYwS5NwnmmeevrNXgqGj
         cW25YRZF7Z9QIVEy9o2viCI3xY3MOzitcKt0vyobIbUopELNc1CM+FdAVz8bXY7tCStK
         K/6+dfUwYkNdDOd38Gg1IT4IjA9DHqbtEU+nat+wCwscqWnMb25kY05osIlBVxZ1IqAy
         WpBni+wLqbhg7wWDd1vXj+ZzkV5h7VLVgffBUeDArnH0g8qsZQvdbges9IxV6a52Arqi
         rrsWayyQiaPc+ZZ6Bv36lbHRtUp2L5hxvMSNXXH5/86oIRI81hm5e71J5cksSVxOx43X
         o1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fg/zRGOqEr6soWn4lYJNlKofJY1rut3rOP2dQ7jtbg=;
        b=gNTpCXUGWdossBKR704yt/52Udcwc055yujguhthbubTPNcdZ/+5hNZX+G2GmOA9IS
         LyHYrF/pHvVRohuVxjLhm7iTrQGYCf2AdjfUarTknSD7bfqGCoyMU8rQYsnnlchlcNnE
         QN03ODYBgXJcmorUK21KL8VHmn5S6LFNJZlcIXUnS8ZC8tqKUDZSGY0jh72PR90svEyr
         RL0MJvH3EGLVufBGTz0Cg/Iad8JESrsIoWMXG31vbbuqhJvJ7HGXxRy/waIAUFsYnQxA
         B5leH0gwPlDaVoxf6DERBazcAEyE/9s1Z/fukfU82GlXTO3h5MAWH+5AeSlHPqQGJF9Y
         DQ0Q==
X-Gm-Message-State: AHQUAubcFS+/7zztxRe9TOURS8kPEJ9kD7S/Oy9um4Gc717C9budIerD
        pdaEC7i7p1A8xsWiLVTlhvWMnZ/2LZ/jd3DlE1u9KA==
X-Google-Smtp-Source: AHgI3IY7GFh/XR5IlViSNt4nPxBdVo2ZM6qPDSc2iF6BF1qdYdK0N0ChHtb5YYAQROyhTus+MSV4Vp2zrUypLQAcVyQ=
X-Received: by 2002:a02:bb82:: with SMTP id g2mr35469jan.8.1550775507001; Thu,
 21 Feb 2019 10:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20190207185917.167829-1-egranata@google.com> <20190211190112.209286-1-egranata@chromium.org>
 <20190220180538.GA42642@google.com>
In-Reply-To: <20190220180538.GA42642@google.com>
From:   Enrico Granata <egranata@google.com>
Date:   Thu, 21 Feb 2019 10:58:15 -0800
Message-ID: <CAPR809uFwmg8GUPbT81tNooDpKQD2oZ2UqsTGwYH--Jh_CWGGQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver: platform: Support parsing GpioInt 0 in platform_get_irq()
To:     Brian Norris <briannorris@chromium.org>
Cc:     Enrico Granata <egranata@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for catching that and sorry for the delayed response, I was on vacation.

I think your analysis makes sense. I would personally lean towards the
former suggestion (keeping the change localized to the return value of
platform_get_irq() which is the function that apparently has an
informal contract about returning -ENXIO specifically).

I am happy to post a PATCH v3 to that effect if this seems amenable.

Thanks

Enrico Granata | egranata@google.com | ChromeOS | MTV1600


On Wed, Feb 20, 2019 at 10:05 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi,
>
> On Mon, Feb 11, 2019 at 11:01:12AM -0800, egranata@chromium.org wrote:
> > From: Enrico Granata <egranata@chromium.org>
> >
> > ACPI 5 added support for GpioInt resources as a way to provide
> > information about interrupts mediated via a GPIO controller.
> >
> > Several device buses (e.g. SPI, I2C) have support for retrieving
> > an IRQ specified via this type of resource, and providing it
> > directly to the driver as an IRQ number.
> >
> > This is not currently done for the platform drivers, as platform_get_irq()
> > does not try to parse GpioInt() resources. This requires drivers to
> > either have to support only one possible IRQ resource, or to have code
> > in place to try both as a failsafe.
> >
> > While there is a possibility of ambiguity for devices that exposes
> > multiple IRQs, it is easy and feasible to support the common case
> > of devices that only expose one IRQ which would be of either type
> > depending on the underlying system's architecture.
> >
> > This commit adds support for parsing a GpioInt resource in order
> > to fulfill a request for the index 0 IRQ for a platform device.
> >
> > Signed-off-by: Enrico Granata <egranata@chromium.org>
> > ---
> > Changes in v2:
> >  - only support IRQ index 0
> >
> >  drivers/base/platform.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 1c958eb33ef4d..0d3611cd1b3bc 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -127,7 +127,20 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> >               irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
> >       }
> >
> > -     return r ? r->start : -ENXIO;
> > +     if (r)
> > +             return r->start;
> > +
> > +     /*
> > +      * For the index 0 interrupt, allow falling back to GpioInt
> > +      * resources. While a device could have both Interrupt and GpioInt
> > +      * resources, making this fallback ambiguous, in many common cases
> > +      * the device will only expose one IRQ, and this fallback
> > +      * allows a common code path across either kind of resource.
> > +      */
> > +     if (num == 0 && has_acpi_companion(&dev->dev))
> > +             return acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
>
> For ACPI devices, this changes the return code for a missing interrupt
> 0 from ENXIO to ENOENT, because acpi_dev_gpio_irq_get() uses ENOENT
> instead of ENXIO. While ENXIO isn't exactly documented as the *specific*
> error code for a missing interrupt in platform_get_irq(), there are
> definitely drivers out there that are looking specifically for ENXIO
> (grepping the tree finds several Rockchip platform drivers and a few
> ethernet drivers at a minimum). And it also incidentally broke some
> usage of the very driver you were trying to support
> (drivers/platform/chrome/cros_ec_lpc.c).
>
> I suspect a good strategy here would be to check
> acpi_dev_gpio_irq_get()'s return codes here with something like:
>
>         if (ret > 0 || ret == -EPROBE_DEFER)
>                 return ret;
>         return -ENXIO;
>
> Although, the gpiolib functions embedded in there also can return EIO,
> so maybe something like this is better?
>
>         if (ret == -ENOENT || ret == 0)
>                 return -ENXIO;
>         return ret;
>
> I'm kinda unsure what to do with error codes besides PROBE_DEFER or
> "missing", since most users don't really have it in their mind that
> platform_get_irq() can fail with EIO or similar.
>
> Brian
>
> > +
> > +     return -ENXIO;
> >  #endif
> >  }
> >  EXPORT_SYMBOL_GPL(platform_get_irq);
> > --
> > 2.20.1.791.gb4d0f1c61a-goog
> >
