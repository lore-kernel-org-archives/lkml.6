Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4ACC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8142245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vj01yCAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8142245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbeKMLWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:22:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33266 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeKMLWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:22:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so9353367ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 17:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qXi9m1EulATWmGfYBw5Cjhb1utlEj6BLCwIhwhrK84=;
        b=vj01yCAOJWvCj1PGB9oyRIKsrx2ypCtblitEkKp5VYxbUHe+gXi9UbVgna0qBi3d5T
         oe9/O9eBjx6scLHQE3Mip2NG7v/e9O0wv2ns1tvSJOAyplHLGIc89oE67Cqcu+lvVvJS
         e6uzVajhO9z46mv4W8Z6Crdw+ECsALdqkM7CaWJRFljZi23zdn9yylVKepx5uoUdXQpZ
         psUJTVQCvPnf0L3YnKqaR2GuxxvZ9l/MaLJK8xkoljJI9UtJQAvclV3pI5QgZ8Ret/a4
         0C7FQDORk8KCm7SjuW4sNvQ1vzT54THjt+cF6Hx0ubuZhHOt17pOL3tfizghVdAM5JhY
         ffjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qXi9m1EulATWmGfYBw5Cjhb1utlEj6BLCwIhwhrK84=;
        b=rNRYwPqDXemn0sMSGA8IyRsaaRBE7t/jtB6wVjW4/6ZQsGsmUx2seE6PM82nLt3rYM
         W2CR4O/NZnIVI+ph3C36FlZdogIOEh0tTT+UrAvlcbnORvkAgoghU4eDK/8EzLu8dLyF
         3I8oxgzMT6tULY519ZY2gRIMG7fftr3/V/GBgkYVxp1F8PMV1wRK4IkZqPMRBYf9+38+
         QyBIS8ayXdoP038LgbUX+kD3TRGhUR7gmOp/I97ErFufjUjBXbAYpnjh1RaOm8rlWBWF
         3ufrpFE+ap8Qzq4GkvxLyFNIM8Qxkem4iqBQ59exiUEiQgdauy0n9XtXXz1cRuwqKGdz
         KKew==
X-Gm-Message-State: AGRZ1gLLeYrKU9fv2pUQTZOOmnbKv9ioFVoUSzNOh4vsXKQASgHau78x
        E2Q5hJgno4mOTmrB0+wv7+jozRPtI7Bgs7LDhdt8PQ==
X-Google-Smtp-Source: AJdET5dbojofevMCYWbQyWO2La8eP6QDTQbewX8zQyU/Yv3MTppKvAxQ+IRxr7lkHOVasKlG+K+qNv4XImxlNr4QHvM=
X-Received: by 2002:a2e:8099:: with SMTP id i25-v6mr2137334ljg.174.1542072424269;
 Mon, 12 Nov 2018 17:27:04 -0800 (PST)
MIME-Version: 1.0
References: <CAA93t1oaZ5zkv+BsGnYZg6pqKv0DzXi3j8oZHUyTyffUWHtHug@mail.gmail.com>
 <20181029221701.51376-1-rajatja@google.com> <CAPDyKFpqzpxUzZe-ekfwg1Nqeg1RFB1bdbSNwrGPwtfNds4p0w@mail.gmail.com>
 <CAHp75VezX-agNFp2wEHorH7U9NmZgpX-PfXdBbGDETnJY2AFGA@mail.gmail.com>
In-Reply-To: <CAHp75VezX-agNFp2wEHorH7U9NmZgpX-PfXdBbGDETnJY2AFGA@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 12 Nov 2018 17:26:27 -0800
Message-ID: <CACK8Z6F0xrC340SHmnZHEb2jYizna_ZCeK_NGGeg_7iRb7wUsw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
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

On Mon, Nov 12, 2018 at 3:26 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Nov 12, 2018 at 1:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On 29 October 2018 at 23:17, Rajat Jain <rajatja@google.com> wrote:
> > > Problem:
> > >
> > > The card detect IRQ does not work with modern BIOS (that want
> > > to use _DSD to provide the card detect GPIO to the driver).
> > >
> > > Details:
> > >
> > > The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
> > > request the gpio descriptor for the "card detect" pin.
> > > This pin is specified in the ACPI for the SDHC device:
> > >
> > >  * Either as a resource using _CRS. This is a method used by legacy BIOS.
> > >    (The driver needs to tell which resource index).
> > >
> > >  * Or as a named property ("cd-gpios"/"cd-gpio") in _DSD (which internally
> > >    points to an entry in _CRS). This way, the driver can lookup using a
> > >    string. This is what modern BIOS prefer to use.
> > >
> > > This API finally results in a call to the following code:
> > >
> > > struct gpio_desc *acpi_find_gpio(..., const char *con_id,...)
> > > {
> > > ...
> > >    /* Lookup gpio (using "<con_id>-gpio") in the _DSD */
> > > ...
> > >    if (!acpi_can_fallback_to_crs(adev, con_id))
> > >           return ERR_PTR(-ENOENT);
> > > ...
> > >    /* Falling back to _CRS is allowed, Lookup gpio in the _CRS */
> > > ...
> > > }
> > >
> > > Note that this means that if the ACPI has _DSD properties, the kernel
> > > will never use _CRS for the lookup (Because acpi_can_fallback_to_crs()
> > > will always be false for any device hat has _DSD entries).
> > >
> > > The SDHCI driver is thus currently broken on a modern BIOS, even if
> > > BIOS provides both _CRS (for index based lookup) and _DSD entries (for
> > > string based lookup). Ironically, none of these will be used for the
> > > lookup currently because:
> > >
> > > * Since the con_id is NULL, acpi_find_gpio() does not find a matching
> > >   entry in DSDT. (The _DSDT entry has the property name = "cd-gpios")
> > >
> > > * Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
> > >   returns false (because device properties have been populated from
> > >   _DSD), thus the _CRS is never used for the lookup.
> > >
> > > Fix:
> > >
> > > Try "cd" for lookup in the _DSD before falling back to using NULL so
> > > as to try looking up in the _CRS.
> > >
> > > I've tested this patch successfully with both Legacy BIOS (that
> > > provide only _CRS method) as well as modern BIOS (that provide both
> > > _CRS and _DSD). Also the use of "cd" appears to be fairly consistent
> > > across other users of this API (other MMC host controller drivers).
> > >
> > > Link: https://lkml.org/lkml/2018/9/25/1113
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> >
> > Applied for fixes, thanks!
> >
> > Should I add a stable tag to this as well?
>
> If you go with that it might make sense to have Fixes tag against
>
> commit f10e4bf6632b5be11cea875b66ba959833a69258
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Tue May 23 20:03:19 2017 +0300
>
>    gpio: acpi: Even more tighten up ACPI GPIO lookups
>

I agree.

Thanks,

Rajat


> --
> With Best Regards,
> Andy Shevchenko
