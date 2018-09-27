Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F14C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799F920838
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZw3VcjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799F920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeI0Nnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:43:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34804 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbeI0Nnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:43:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id 80-v6so999401qkj.1;
        Thu, 27 Sep 2018 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIjr7lA69Q6T8Q3M0NSjP0c34DQtTrjB+YLR9/BpnLo=;
        b=nZw3VcjUVRX49lo3HpsIAjUG2uOgAxI3V2SvTt1nO7ah1p9eFkVhG9UzFqEP4PsnQm
         0QJ5vtjehvcvKwXf47mhwiJlYHccKzV0x5Gz4QP+upPC+a07X77xr8woHB9h1mS42RUV
         xOWDlSa/M93TnD8pkGFtjsX06OHrBZCZfJLzgCA3t2/jYD9IQqiXhe9ceOD3/SB+Xpft
         E1KfN34ZWzpmfdg04FE93KrEsjl37T3y8BDgkkfg0ySfIiitIc+CnUwNS2JnrKWojf4Q
         8hgbjd10fPe5rD0j4dAgrIddrUQYvsk1//cESHYiCoFLNI6Qkxyh1EHmWDRLnlvflMKs
         6w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIjr7lA69Q6T8Q3M0NSjP0c34DQtTrjB+YLR9/BpnLo=;
        b=I132AihTUAB7WsiEv0RWWibCSkTtBKrHk7zHxNuWHzuAslGxSLWuAzO1YDT/F5lVhI
         2Zw/tkYh/h13x5RSZzjHscBWh7bQ2FP6VQUviXPEGj1cGqlqLW+Blrh9Ch2Py2eXaBoe
         8mrjpQPEKlqKTSFA1qjB8LxNz9DZ6Zwo18MUCxnMA8ky4BSvBxAmRoidp8LYbnOUpmmV
         NR5F5sUXPYz+rqK585DRlYJDjZzV+VdQ70eX19fInRWqFRK6Oq810vagD++OJD2lIbCD
         IZf+aZJS8znGBUtp171te6Bv5izmr18fVROPaPY2s2CDJwzz1gtRfRHRkiueczukUaTK
         /P9Q==
X-Gm-Message-State: ABuFfogkBrXD5WPDJ+uB3uSIDVKoXN+lauz9063+ToDmksXozzBasjSi
        MzEzeNZTYHA3U2bPsqYqkrUyDfwICuLzYIemTBc=
X-Google-Smtp-Source: ACcGV63Uxlli77PgssZYqLpsTAEjexFrCRGLSgNaX84MNEvVKGWqGCcsXSum3CYepwAX3z1jY9+xdN/9LwL0YlYDx1c=
X-Received: by 2002:a37:4712:: with SMTP id u18-v6mr7016515qka.301.1538033213589;
 Thu, 27 Sep 2018 00:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
 <20180926074756.GD2664@lahna.fi.intel.com> <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
 <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com>
In-Reply-To: <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Sep 2018 10:26:42 +0300
Message-ID: <CAHp75VcQ0SviZ6vsn_5inn5oZxxj-5ZQq5bC+bXPxuF8KOa_Rg@mail.gmail.com>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't fallback
 to _CRS?
To:     Rajat Jain <rajatja@google.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dtor@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:26 PM Rajat Jain <rajatja@google.com> wrote:
> On Wed, Sep 26, 2018 at 1:42 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Sep 26, 2018 at 10:49 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:

> > > Or you can use con_id=<actual string> everywhere and supply
> > > acpi_dev_add_driver_gpios() where needed to cover cases where BIOS does
> > > not provide _DSD.
>
> This sounds like a good idea and I'd like to do this. I have some
> questions though:
>
> 1) If the BIOS does provide a _DSD entry for "cd-gpio", and
> additionally driver also uses devm_acpi_dev_add_driver_gpios() to add
> one more entry for the same string "cd-gpio", which one will (should?)
> actually be returned by the gpiolib? The one in BIOS or the one that
> was added by the driver?

Of course the one that BIOS provides. This hardcoded mapping tables is
a fallback for *old* BIOSes which do not have _DSD.

> 2) Related, I'm trying to understand how can a driver use
> devm_acpi_dev_add_driver_gpios(), for *only* the case where the BIOS
> does not have a _DSD (Or should it really care)? Does the driver need
> to check for _DSD using some other ACPI call?

The magic happens internally in ACPI core.
Whenever one calls gpiod_get() with a name on ACPI-enabled platform,
_DSD would be checked first.

> > See also Documentation/acpi/gpio-properties.txt for
> > > more information.

> > > In case of SDHCI I think the correct way is to stick using _CRS lookup
> > > only because there typically is just one GpioInt() and I have not seen a
> > > single BIOS yet where they implement _DSD for this besides yours. If
> > > there is not way to change the BIOS implementation then I guess we just
> > > need to amend the driver to call acpi_dev_add_driver_gpios().
>
> Since we shouldn't discourage a BIOS that is trying to do the right
> thing by exposing the details in _DST, I think it would be preferable
> if we can solve this in the kernel.

Patches are welcome, I think.

Btw, is there any existing hardware on the market with such BIOS?

-- 
With Best Regards,
Andy Shevchenko
