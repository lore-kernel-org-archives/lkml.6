Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8D2C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5AD205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIEmjcqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5AD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeJWH4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 03:56:16 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45932 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJWH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 03:56:16 -0400
Received: by mail-yw1-f68.google.com with SMTP id i185-v6so3018214ywa.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 16:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWNsEhGTVNZADfIpa9vpBr1MhvmkhQxt6lUoK5SXwpw=;
        b=BIEmjcqKjeJeT7J7o4As0c1Y0i4lIYb2hEMji/xb6kiFg+t3YK9j4wHojg/3O8A68V
         0fIPT8Ql0yz4eFQLKXRhsdeFK6/kVCpEA9Ocvk5lNU90wLXLxA9Jd4zJwiP7AZBBJXTt
         uCKMVdi/n/5QRZB2xbZqQmS8Cr/ktJmQlnQ74T/79k0YGFERerPk37es9niipxLg1aqw
         c1POWNgBPrc1j+/w/zdGlamYtPcbL5OlYRPB6vpfz2HQ50M1QjNBjalOdPx6ixL9pbd/
         eA1zwjqc3A9EE26v+LjvmTwE68uPNqJ/jD+8PO06AkTKUo5q/EmEQnc//F1hspBembQU
         XMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWNsEhGTVNZADfIpa9vpBr1MhvmkhQxt6lUoK5SXwpw=;
        b=uX4upCSNm5p9DF6/HmTBlhPwyQHefnUoPao+KKxOACvwTBecftZ+xC5ny7CAeGw+m4
         r3TX1g1huHG+MTMh2WslgLONsvveuJgNih2ayghoK3cFcTGQgYDkKeZZpftjxONWDZsO
         ErO54IqL87TDnPUhWddvRi0FO8JtRcnKPOu4yYpxJ/zU7rL2jOIDPVUS0P6/EeTMABgJ
         ae1G805DBzoCeebbKlT7qCVEVV63++hBuW7oYfQBHoPaeN4r+gbCw3i/I7EQZ7YX1wJF
         Sr9jqHyIQ0gefX7FUo8eTG2I/n4GJxu3V0IzCDJ6bODksfbcHveEke7Y4mNdzCcz8CtG
         3l+w==
X-Gm-Message-State: ABuFfohbg40Bs3OvEWPSGr/4XJ/Moa9mJEFoV0xHMBDHFqPxvRALs6lW
        6yG9v7zKJB1hKC0HQSnt9JnN+oL3jEC5DW3ZMw5qeA==
X-Google-Smtp-Source: ACcGV62JY/O/SHArxLO34uHjn8CcHZhJfEPqVYN1SJtUKhvXSXSn4yRWEyb0D2RVg3o2b2qT9IzdLSBbp5/rgI7uitQ=
X-Received: by 2002:a81:3c15:: with SMTP id j21-v6mr5157405ywa.119.1540251335270;
 Mon, 22 Oct 2018 16:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
 <20181018215101.169847-1-rajatja@google.com> <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
In-Reply-To: <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 22 Oct 2018 16:34:55 -0700
Message-ID: <CACK8Z6HOsUcPFyf-GguxPxh_Zdj6gCXP=FpGw-vQXJfnM=cquw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for your review.

On Fri, Oct 19, 2018 at 2:13 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Oct 19, 2018 at 12:53 AM Rajat Jain <rajatja@google.com> wrote:
> >
> > Problem:
> >
> > The card detect IRQ does not work with modern BIOS (that want
> > to use DSD to provide the card detect GPIO to the driver).
> >
> > Details:
> >
>
> > (Discussion: https://lkml.org/lkml/2018/9/25/1113)
>
> We have a Link tag for such references.
>
> > The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
> > request the gpio descriptor for the "card detect" (or carrier detect?) pin.
>
> card detect is a right term.
>
> > This pin is specified in the ACPI for the SDHC device:
> >
> >  * Either as a resource using _CRS. This is a method used by legacy BIOS.
> >    (The driver needs to tell which resource index).
> >
> >  * Or as a named property ("cd-gpio") in DSD (which may internally point
>
> cd-gpios (gpio suffix is a legacy).
>
> >    to an entry in _CRS). This way, the driver can lookup using a string.
> >    This is what modern BIOS prefer to use.
> >
> > This API finally results in a call to the following code:
> >
> > struct gpio_desc *acpi_find_gpio(..., const char *con_id,...)
> > {
> > ...
> >    /* Lookup gpio (using "<con_id>-gpio") in the _DSD */
> > ...
> >    if (!acpi_can_fallback_to_crs(adev, con_id))
> >           return ERR_PTR(-ENOENT);
> > ...
> >    /* Falling back to _CRS is allowed, Lookup gpio in the _CRS */
> > ...
> > }
> >
> > Note that this means that if the ACPI has _DSD properties, the kernel
> > will never use _CRS for the lookup (Because acpi_can_fallback_to_crs()
> > will always be false for any device hat has _DSD entries).
> >
> > The SDHCI driver is thus currently broken on a modern BIOS
>
> > (even if
> > BIOS provides both _CRS and DSD entries, either of which could be used for
>
> _DSD
>
> > a successful lookup).
>
> This is incorrect. _DSD for GPIOs without any accompanying _CRS
> doesn't make any sense.
>
> > Ironically, none of these will be used for the
> > lookup currently because:
> >
> > * Since the con_id is NULL, acpi_find_gpio() does not find a matching
> >   entry in DSDT. (The DSDT entry has the property name = "cd-gpio")
>
> cd-gpios
>
> >
> > * Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
> >   returns false (because device properties have been populated from
> >   DSD), thus the _CRS is never used for the lookup.
>
> _DSD
>
> >
> > Fix:
> >
> > Try "cd" for lookup in the _DSD before falling back to using NULL so
> > as to try looking up in the _CRS.
> >
> > I've tested this patch successfully with both Legacy BIOS (that
> > provide only _CRS method) as well as modern BIOS (that provide both
> > _CRS and DSD). Also the use of "cd" also appears to be farly consistent
>
> _DSD
> fairly

I can fix the commit log to take care of all your review comments.

>
> > across other users of this API (other MMC host controller drivers).
>
> >         if (slot->cd_idx >= 0) {
> > -               ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
> > +               ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
> >                                            slot->cd_override_level, 0, NULL);
>
> Yes.
>
> > +               if (ret && ret != -EPROBE_DEFER)
> > +                       ret = mmc_gpiod_request_cd(host->mmc, NULL,
> > +                                                  slot->cd_idx,
> > +                                                  slot->cd_override_level,
> > +                                                  0, NULL);
>
> And no. Instead of this part you need to provide an ACPI GPIO mapping table.

Sure, I am willing to do so, and I tried earlier too. However, certain
doubts arose in my mind when I tried that and I posted my questions
earlier (https://lkml.org/lkml/2018/9/28/507) but couldn't elicit any
response. Unfortunately I still do not have answers. My primary
questions are:

1) - It seems that 1 SDHCI device may support multiple slots (looking
at the code). It is not clear to me if they could share card detect
interrupts, or should have separate ones? Also, the driver may not
really know? So should I add 1 or two pins using the
devm_acpi_dev_add_driver_gpios(). Is some one familiar with SDHC
driver can answer these questions, it shall be great.

2) I'm not really sure what should I set "active_low" to? Isn't this
something that should be specified by platform / ACPI too, and driver
should just be able to say say choose whatever the ACPI says?

struct acpi_gpio_params {
        unsigned int crs_entry_index;
        unsigned int line_index;
        bool active_low;
};

Since I do not understand the above two issues, and thus I chose the
safest path and not disturb the current code so as not to cause any
regressions.

Please let me know, and I'm happy to re-spin my patch.

Thanks,

Rajat

>
> See examples, like
> net/rfkill/rfkill-gpio.c
>
> (look for acpi_rfkill_default_gpios)
>
> >                 if (ret == -EPROBE_DEFER)
> >                         goto remove;
>
> --
> With Best Regards,
> Andy Shevchenko
