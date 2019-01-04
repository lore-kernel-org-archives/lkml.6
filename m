Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68770C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34845208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7Vm8ZGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfADOVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:21:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43622 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfADOVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:21:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so18375605pfk.10;
        Fri, 04 Jan 2019 06:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dplJ5KNEkHath2J1X92gohwnmSWndIIVayF9PPw68+g=;
        b=H7Vm8ZGwJ8ibe7CjK/kGgcvO+IEFUKsNf8NRfMs7oTRyZRhexRdrUe1NUS56Yo+vZr
         EJiYjmmTeyLrwo1HFMe4Em+qkIB0ycgumW1qYQrd4qkL/L/fo8ikpDN84dAnQYPBtVp4
         O3o75Xq729n2AP96B96st+TQTN4Svd7IBr9TKjpvRZ1iSgJ0lVJHanjrh6tc4XTqvAld
         fYms7PZ7xcJDwBTjw/T7gC6C0S4OMnZFVOexp1fdTUWSymfmSpbj+tWuWrGpVhmW/uwi
         40ogQsBkpLB4bxXMORYRgWIQtAIYEQNvgbtrZDJKiJBBlFWwAL27qX7xvMmRCDjSkH2j
         bkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dplJ5KNEkHath2J1X92gohwnmSWndIIVayF9PPw68+g=;
        b=MZLk7GEGFoxfoPVaSjwOvWlJMOEQvNljocOwvzHudi7irDahSv1+Y3uR6yw6EVnVwA
         /SL5HaYHs959CQ9ov4PDpUiKLd4LCI1Zu1Gl290iXuqNYSiDSU7+X090Gy8g8phc1CCc
         O9yF43ihSFrqAvkVkgJ1Ua3N5piwQrf2A1edldE/ooRcGZ8C0UoRdPKRPZIYN2WPdTR5
         wJSbRJshQK31bYsB5PF9zEQb+oC9aG7ZmUB2DBFm9GUGlVb+mVm562kZIyHZov6XVhpA
         FQTBm812QjZELCp4DKRB3B6JtbaHvBoHo7M7E4NQ+NGiSVfS7rxwtiJpEYc8Tvdfy3Ko
         zisg==
X-Gm-Message-State: AJcUukcByDvX5yClOXp/Rdi1GeVb1fbEt7HpbotLO8IDnTpv/gr4K1zr
        thRVpFkaRF/18k5y3FUzSz/DApMj9mishjwiDxo=
X-Google-Smtp-Source: ALg8bN4/dwzQXWvfmKAWEUkYKHDAEhFjfrNnfp5TuYS2SKKcxbZttWqfd7q7ZzX5xKnKvpZzaZdmR0fBI4vQ9DXk/YA=
X-Received: by 2002:a63:3287:: with SMTP id y129mr1838823pgy.337.1546611667619;
 Fri, 04 Jan 2019 06:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-7-okaya@kernel.org>
 <CAHp75Ve0Ex245yt1efqSUS7tUuh6RnUdTowLebvJr-CtKkQSZA@mail.gmail.com>
In-Reply-To: <CAHp75Ve0Ex245yt1efqSUS7tUuh6RnUdTowLebvJr-CtKkQSZA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Jan 2019 16:20:56 +0200
Message-ID: <CAHp75Vfqx6S4fY1UKYEXOR63ROx6hmPO7QkF103QtW5xoYRKoQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] platform/x86: apple-gmux: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-next <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 4:12 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jan 2, 2019 at 8:10 PM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> > CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> > satisfied implicitly through dependencies on CONFIG_ACPI have to be
> > specified directly. This driver depends on the PCI infrastructure but
> > the dependency has not been explicitly called out.
> >
> > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  drivers/platform/x86/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index 7afb96cb1cd6..89f4b86244a7 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1136,6 +1136,7 @@ config SAMSUNG_Q10
> >  config APPLE_GMUX
> >         tristate "Apple Gmux Driver"
>
> >         depends on ACPI
> > +       depends on PCI
>
> Can you stick with the same pattern you have used for the rest in this series?
> I.e.
>          depends on ACPI && PCI

After satisfying it

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
>
> >         depends on PNP
> >         depends on BACKLIGHT_CLASS_DEVICE
> >         depends on BACKLIGHT_APPLE=n || BACKLIGHT_APPLE
> > --
> > 2.19.0
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
