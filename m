Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA26C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AECA22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDwnXkqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AECA22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbeKLVSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:18:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37184 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbeKLVSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:18:51 -0500
Received: by mail-qk1-f193.google.com with SMTP id 131so12590687qkd.4;
        Mon, 12 Nov 2018 03:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhIlc1SVFqKqcYPRbDWARTZm9pj1ecUjykjdD4Hqpxk=;
        b=NDwnXkqNE8ivocJ96bNaziE614xhBMsKI4eGgXI2GbKpzvAifpEfsRh40viEh3vkzy
         LI0CHd4/NpIlTE3Ul0RCVSukrWAqSZY1uQnPQRy0GD1XWV3xPQhgDvtgiw7WQYpR3/qU
         yOVc8Qg9gYb9ocsLc0NrDjJYY5T64pjZFahBJCcQCvvLpqJiYlFng1e0RW3NuJSMfLgR
         Wju+421Kqan3DW3MUYPo4wVbyMFLpzx3pwIEjD2YVxh/SmKA0QRw/6PpWOYJC76KUvZd
         lF4AEzqfQNmBc1Pb+f6xn82TKIf79GiIYvd/TdFBZMCx76uB+nEboTZQUtkVgJvqcpZ7
         vv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhIlc1SVFqKqcYPRbDWARTZm9pj1ecUjykjdD4Hqpxk=;
        b=F7ULjaIJ89YW0uRq2xAddSiIk4zfqxOtm+egqNQVmpB7qgenfptiIxstFspHI++O2R
         OwZFqpCM9sXDlyJEM06SKRRZ35GZx+y7IgMi6Amtppy/+yfZ+nbG2tgmmn0NAklczZZe
         /DHOsFoYzBpvyh4cdbom5zpsmwyUZ+t6Bbkafmq3Nd134gZA3xFy3U5319KAL3bbk15k
         FG09KhymGdt412kK8Ek5ClwFNcNU41feBtoja7aC8c6/O1tBf6jynKBN4wWfxd23gyLI
         WI0uwZONkDde2zOLTksiyUD5nHVX7ZfoaE57q14t8jgloLwcjUyyITPa+GZIlQ/nhbhR
         mykg==
X-Gm-Message-State: AGRZ1gIuFRn8CN86UYmTO5gECQPsvjG5ZqxsR2Fr2XWgLRin0Efdkef/
        8ZnJi9xS2lrczXOAp2a+iHUjF3Gw6URqo8paxv0=
X-Google-Smtp-Source: AJdET5cqXVe+EtxDZbTbZBtLQXkRGoCFP/3FU/lJUcTKN5sjXIxLMtxWoHuwHN9yKCP5wE4gLxITleGBJzk9aLb/Bzs=
X-Received: by 2002:ac8:6151:: with SMTP id d17mr466425qtm.194.1542021961399;
 Mon, 12 Nov 2018 03:26:01 -0800 (PST)
MIME-Version: 1.0
References: <CAA93t1oaZ5zkv+BsGnYZg6pqKv0DzXi3j8oZHUyTyffUWHtHug@mail.gmail.com>
 <20181029221701.51376-1-rajatja@google.com> <CAPDyKFpqzpxUzZe-ekfwg1Nqeg1RFB1bdbSNwrGPwtfNds4p0w@mail.gmail.com>
In-Reply-To: <CAPDyKFpqzpxUzZe-ekfwg1Nqeg1RFB1bdbSNwrGPwtfNds4p0w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Nov 2018 13:25:49 +0200
Message-ID: <CAHp75VezX-agNFp2wEHorH7U9NmZgpX-PfXdBbGDETnJY2AFGA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 1:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 29 October 2018 at 23:17, Rajat Jain <rajatja@google.com> wrote:
> > Problem:
> >
> > The card detect IRQ does not work with modern BIOS (that want
> > to use _DSD to provide the card detect GPIO to the driver).
> >
> > Details:
> >
> > The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
> > request the gpio descriptor for the "card detect" pin.
> > This pin is specified in the ACPI for the SDHC device:
> >
> >  * Either as a resource using _CRS. This is a method used by legacy BIOS.
> >    (The driver needs to tell which resource index).
> >
> >  * Or as a named property ("cd-gpios"/"cd-gpio") in _DSD (which internally
> >    points to an entry in _CRS). This way, the driver can lookup using a
> >    string. This is what modern BIOS prefer to use.
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
> > The SDHCI driver is thus currently broken on a modern BIOS, even if
> > BIOS provides both _CRS (for index based lookup) and _DSD entries (for
> > string based lookup). Ironically, none of these will be used for the
> > lookup currently because:
> >
> > * Since the con_id is NULL, acpi_find_gpio() does not find a matching
> >   entry in DSDT. (The _DSDT entry has the property name = "cd-gpios")
> >
> > * Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
> >   returns false (because device properties have been populated from
> >   _DSD), thus the _CRS is never used for the lookup.
> >
> > Fix:
> >
> > Try "cd" for lookup in the _DSD before falling back to using NULL so
> > as to try looking up in the _CRS.
> >
> > I've tested this patch successfully with both Legacy BIOS (that
> > provide only _CRS method) as well as modern BIOS (that provide both
> > _CRS and _DSD). Also the use of "cd" appears to be fairly consistent
> > across other users of this API (other MMC host controller drivers).
> >
> > Link: https://lkml.org/lkml/2018/9/25/1113
> > Signed-off-by: Rajat Jain <rajatja@google.com>
>
> Applied for fixes, thanks!
>
> Should I add a stable tag to this as well?

If you go with that it might make sense to have Fixes tag against

commit f10e4bf6632b5be11cea875b66ba959833a69258
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue May 23 20:03:19 2017 +0300

   gpio: acpi: Even more tighten up ACPI GPIO lookups

-- 
With Best Regards,
Andy Shevchenko
