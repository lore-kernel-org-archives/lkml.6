Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D8FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DD4215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsJ5SeMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DD4215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeI1AQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:16:43 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40010 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbeI1AQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:16:42 -0400
Received: by mail-yw1-f68.google.com with SMTP id z143-v6so1455142ywa.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/DViyCS5+HLAwKbwRK+27QcwxEuET/Wpo/dzZjQRHA=;
        b=SsJ5SeMy0aGwbWJyO4s2OHDgJ+aznIbnubaFotEs8xg0AAw2BnmNI6+0pYOGz1dDMB
         pxdhZZ2ys8/OPUM3zBnH4AGkcGdVXhSMuQQhS1aMBh2Cp334pjiOKLXLtki58CfsUNVO
         w7tdNLFjxTawVmO2XsH1WCCbMr4UMjidgprMeBlihXC5iipHJEolATQzhJs8oXGB5Fir
         MXo9SkFEhOFcidOyMEqZ96T+rLehnxavjjdd4P9zSmhujvgsIGto6Bk+IArwDRHsQciT
         Aej8CwRf4vrEtvEaT/dbjqa8Fs5jGIIBXIOMc3zk6QMKy2gNyLkiVzq1Fzz9tTPP0zRy
         kDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/DViyCS5+HLAwKbwRK+27QcwxEuET/Wpo/dzZjQRHA=;
        b=ITIMGbpEDlfSYncXM1cGK92xCUNThBfZMSBtjytvy4K3DGZO4GYUP7RnUVzjGnIULk
         o65iktV3PD0hVMYc30xRQj56Gdm+0UrisqAUVaVA4/tKNELbvGG3R0ez+5giVAYnpY6O
         Ry2nKuzE0a+HisLvNdiK/Yw2vGdaI7pJmJI2JOFzolmUtmfBvI4IZPTmKJwQVgET4jCt
         f0b03RkKtehUcDGypxhjGejTV4U4epqyJuYGnqWR8GEVllXsXgFF8B9znmm9cR75AVqq
         PKkPYPah11Lk4qCtipXcmyyo2NnmL6YS5NNa+mr/9l0td7PIb61WvTchWTG3oSEPEkBN
         BrZg==
X-Gm-Message-State: ABuFfog0U1WfVZqhxRr5oNs6tzt9/76fDlO0mAKPvjau3+sV8b25KpUy
        A1dwp/uHannUYl1+LfMTMdNQFy2q/RJSwQ2GSHwuFw==
X-Google-Smtp-Source: ACcGV61D+Kj8B4jxr9Dyz+jCfxOUJk4jxWAQrl4YPZ1it2RZw3pqVjfzmOzymgeqss6CaB4uAOz2alHMzJ5dpHTdC4I=
X-Received: by 2002:a0d:df8d:: with SMTP id i135-v6mr6279590ywe.349.1538071036696;
 Thu, 27 Sep 2018 10:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
 <20180926074756.GD2664@lahna.fi.intel.com> <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
 <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com> <CAHp75VcQ0SviZ6vsn_5inn5oZxxj-5ZQq5bC+bXPxuF8KOa_Rg@mail.gmail.com>
In-Reply-To: <CAHp75VcQ0SviZ6vsn_5inn5oZxxj-5ZQq5bC+bXPxuF8KOa_Rg@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 27 Sep 2018 10:56:39 -0700
Message-ID: <CACK8Z6HjFy_5sv_ZRRyfRgCYMYPpuoFqmKekyi7fSLk14YpN6w@mail.gmail.com>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't fallback
 to _CRS?
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:26 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Sep 26, 2018 at 10:26 PM Rajat Jain <rajatja@google.com> wrote:
> > On Wed, Sep 26, 2018 at 1:42 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Sep 26, 2018 at 10:49 AM Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
>
> > > > Or you can use con_id=<actual string> everywhere and supply
> > > > acpi_dev_add_driver_gpios() where needed to cover cases where BIOS does
> > > > not provide _DSD.
> >
> > This sounds like a good idea and I'd like to do this. I have some
> > questions though:
> >
> > 1) If the BIOS does provide a _DSD entry for "cd-gpio", and
> > additionally driver also uses devm_acpi_dev_add_driver_gpios() to add
> > one more entry for the same string "cd-gpio", which one will (should?)
> > actually be returned by the gpiolib? The one in BIOS or the one that
> > was added by the driver?
>
> Of course the one that BIOS provides. This hardcoded mapping tables is
> a fallback for *old* BIOSes which do not have _DSD.
>
> > 2) Related, I'm trying to understand how can a driver use
> > devm_acpi_dev_add_driver_gpios(), for *only* the case where the BIOS
> > does not have a _DSD (Or should it really care)? Does the driver need
> > to check for _DSD using some other ACPI call?
>
> The magic happens internally in ACPI core.
> Whenever one calls gpiod_get() with a name on ACPI-enabled platform,
> _DSD would be checked first.

Got it, thanks.

>
> > > See also Documentation/acpi/gpio-properties.txt for
> > > > more information.
>
> > > > In case of SDHCI I think the correct way is to stick using _CRS lookup
> > > > only because there typically is just one GpioInt() and I have not seen a
> > > > single BIOS yet where they implement _DSD for this besides yours. If
> > > > there is not way to change the BIOS implementation then I guess we just
> > > > need to amend the driver to call acpi_dev_add_driver_gpios().
> >
> > Since we shouldn't discourage a BIOS that is trying to do the right
> > thing by exposing the details in _DST, I think it would be preferable
> > if we can solve this in the kernel.
>
> Patches are welcome, I think.
>
> Btw, is there any existing hardware on the market with such BIOS?

Yes, all the chrome books available in the market (at least the ones
released in last 3 years) have same ACPI layout (provide _DSD for
card-detect). They are all working fine today because they use an
older kernel, but if we update them to the latest kernel, this part
will be broken.

Thanks,

Rajat Jain

>
> --
> With Best Regards,
> Andy Shevchenko
