Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B72EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDB020857
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YQArrIzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBGU3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:29:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34360 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfBGU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:29:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id v14-v6so1087667ljv.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bs5aframrMddA9aAdMAvLmi9jddHh2qt8Hvh1nB2Cyg=;
        b=YQArrIzHcvxvvv2fEUccRbF7wewJGzG+8eQchPcxPhU3InQergLTp434vKraHaloCN
         YCDJMrMaZkPeyAiH/Z0+3Ymhg+GhI1A1pU4cEkp/GUJKx6N+uTwW1yzVpYXTDe5lb7K/
         h+tFz+zPk5fh0SowU3qdP9OTTnaHTEJcUV3Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bs5aframrMddA9aAdMAvLmi9jddHh2qt8Hvh1nB2Cyg=;
        b=VheEzA/LbLxQIBtW55oYhmXvH4P86RrUqa8Kljv5XRHCNEEPEN4X0ZiqfHbe35GLFA
         KSStEdI40/ePa+8yKooIyJZMrBuq3v+mEmkfm0Uz/zZFgOomX9UyuBM2Z8WyVO6Avq13
         BlFPitpIL1xcrMOEk3BoM3+xGKZ8mvilikRYdh6YOavLEo1Axi2U3v+fVCtzWA8S5PYl
         436C+dskFHl6uiS0IDlk/gG8gJDwv1Ybm1drY9zNAEh0fMVXMtLGAN6DOVUw8A8C6QVz
         QweeJUGGbr0ztQ+xh2c/c8z3IcbrBXFjMn+SzZHLz0hn/3GcwM0ZcK0yvWGbh7SLw8EZ
         IJzQ==
X-Gm-Message-State: AHQUAuZywjCxwuFSLcJzY6TZlofLJG6+BxtYnoBhILOOFi3DiU4jANga
        Hz4lQ9bbHWe2E5yqNaeJHVSwn/erUBg=
X-Google-Smtp-Source: AHgI3IbCHnOGb/hefZ+DPoWNt5J0qnpYZ+jJruSvFhq4HTGxqz1+dTVFiv68aaT4LsGhRy38J3KY1g==
X-Received: by 2002:a2e:5816:: with SMTP id m22-v6mr5094168ljb.177.1549571370596;
        Thu, 07 Feb 2019 12:29:30 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a18sm3256659lfb.57.2019.02.07.12.29.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 12:29:29 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id q11so919359lfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:29:29 -0800 (PST)
X-Received: by 2002:a19:aa87:: with SMTP id t129mr11683850lfe.139.1549571368976;
 Thu, 07 Feb 2019 12:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20190207185917.167829-1-egranata@google.com> <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
 <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
 <CAPR809vnpuh8nOjU3QMCh6YJUKmtX92+bnHSUKGiAXAp6NwCHQ@mail.gmail.com> <CAHp75Ve5Q0d0PCmQ6KZdcyuLd-XFfVjYqyujjM9SSbyBG+Hrmg@mail.gmail.com>
In-Reply-To: <CAHp75Ve5Q0d0PCmQ6KZdcyuLd-XFfVjYqyujjM9SSbyBG+Hrmg@mail.gmail.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Thu, 7 Feb 2019 12:29:17 -0800
X-Gmail-Original-Message-ID: <CAE_wzQ_RLC7N=jzj693d42T4K-CtSA-ckavt1FNDFZmLcXkB6w@mail.gmail.com>
Message-ID: <CAE_wzQ_RLC7N=jzj693d42T4K-CtSA-ckavt1FNDFZmLcXkB6w@mail.gmail.com>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to platform_get_irq()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Enrico Granata <egranata@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 12:18 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Feb 7, 2019 at 9:45 PM Enrico Granata <egranata@google.com> wrote=
:
> > On Thu, Feb 7, 2019 at 11:39 AM Andy Shevchenko <andy.shevchenko@gmail.=
com> wrote:
> >> On Thu, Feb 7, 2019 at 9:04 PM Rafael J. Wysocki <rafael@kernel.org> w=
rote:
>
> >> > > This is not currently done for the platform drivers, as platform_g=
et_irq()
> >> > > does not try to parse GpioInt() resources.
> >>
> >> And why is this a problem?
>
> > In ChromeOS, we have a driver (cros_ec_lpc) which can run either on sys=
tems that directly expose the interrupt,
> > or systems where the interrupt goes through a GPIO controller. On the f=
ormer, firmware provides an Interrupt resource
> > and platform_get_irq() finds it. On the latter, firmware provides a Gpi=
oInt resource and platform_get_irq does not
> > find it. We could work around this in the driver by probing both paths,=
 but since other subsystems seem to directly
> > look for GpioInt resources, it seemed to us to make more sense to exten=
d platform_get_irq() instead.
>
> Looking briefly into the driver I found third scenario =E2=80=94 no resou=
rce at all.
> So, you already have a quirk for that. Now it's the question either
> you go for global quirk (trying to find an IRQ via iterating over
> GpioInt() resources like in this patch, but in the driver), or use DMI
> table for more stricter rules.

No, no DMI rules please, they are more pain than anything.

>
> Either way you choose, I don't see a necessity to put this to the
> driver core for now since it would be the only (let's assume properly
> written ACPI tables) driver needs such.

This is simply kicking the can down the road.

>
> > Do you have a suggestion as to how to write ACPI tables to avoid the is=
sue?
>
> 1. Allocate new ID and use it (perhaps not the best path).
> 2. Use GPE(s).
>

Or just solve the issue of intermixing Interrupt() with GpioInt(). We
have similar issue with i2c and spi, but we sidestep that there as we
only parse the first interrupt and do not give option of fetching 2nd,
3rd, etc. Maybe we should only GpioInt parsing for the first interrupt
in platform_get_irq() as well for the first iteration and then see if
we need to improve it if we see devices with multiple interrupts.

Thanks,
Dmitry
