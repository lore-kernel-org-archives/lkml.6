Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF385C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E6020657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0wKYL1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E6020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeJ3AMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:12:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36673 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJ3AMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:12:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so9655187qth.3;
        Mon, 29 Oct 2018 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lA1pWmOjLyLw3eXRdhS2W58k9UmAUeZfL6ecWjOd6s0=;
        b=D0wKYL1cNPlivZ5ebmWIXJDSwhMvtDhd+wdBWQEde7A77Dmo2qDTIbkE9XDJo7cSZG
         QzRdfyEqIctOIPIFFaKy/n3Xp2qRZme6TfKAY8DwKHfZXPTihsm8jo5f8W/qXV7unEHN
         M+/Wff82BvfcOQAfJRS087lWKVYPab65c0YTBue/XmlVORQunSvrodXZhtRqlC5fNxJX
         jjQrRJ2cgYdS5KqyU6YXB9oibEbW+dU7E4/ssB3j0M7KFgwhRZjmhhmoV5C5DfYuTSF3
         pr9ZJuImUiuRnclaXX/RdIC3Yua5K1nhbH/q5jmvQtr5/4WJmhN3QbaliAmRFzIu9UDS
         Zwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lA1pWmOjLyLw3eXRdhS2W58k9UmAUeZfL6ecWjOd6s0=;
        b=GC5HHVzEe8lCsgxvRiygV/gddQJrDh8yur4atidGd3QN4XJKtrR/gtgJtDPQ7iZSU/
         J3ya1fIjEc4fBEktpF1QvmJcBQygY03w+bbsvb+Qr+Wiyb/UN3ENE3OKLm0VyJbCmjHI
         68nbxijc5cGEb5UZ9pFiETFT2ZGJ8blIBePm32gJbYZc9gDVUOC+uhxCF9CZ8Jt2yDKp
         SUdMt5979r5RNXmAETN24YvOt/xV7HT71X+9VGBMHuuLjJcOl9hGHDNUvXDmL45rNGzC
         y5kRLSQEivIhYW3dHOOzm544pHiTtxc3zbCBm8UWFmi4RoW8w7ANe71D7ZTuL89GboSE
         Ae0g==
X-Gm-Message-State: AGRZ1gJjiy09mrRaDg6giN+jryg7OSe1yt6+0EQQXEnOnGTqmQNtV7Bd
        13tVyALuDwdzzV1uIMJgjubG+0OtIGH+h2hxmPY=
X-Google-Smtp-Source: AJdET5dLcQ/W5XNnnIDMfB3ll8l7rQ4HAtdTtGhHkjDd0KoZL+2lskUz1/PJg0L5YWFIQnEDTtPILScQzoe+k1ZzKlo=
X-Received: by 2002:ac8:764e:: with SMTP id i14-v6mr13445272qtr.373.1540826616051;
 Mon, 29 Oct 2018 08:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
 <20181018215101.169847-1-rajatja@google.com> <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
 <CACK8Z6HOsUcPFyf-GguxPxh_Zdj6gCXP=FpGw-vQXJfnM=cquw@mail.gmail.com>
 <20181024100230.GQ10650@smile.fi.intel.com> <CAE_wzQ-80NCNbzbFx1eEDwEEOEAbv-5u+W171iUagY2pOahbmw@mail.gmail.com>
In-Reply-To: <CAE_wzQ-80NCNbzbFx1eEDwEEOEAbv-5u+W171iUagY2pOahbmw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 17:23:24 +0200
Message-ID: <CAHp75VfMHqT+aAGVaXzXGbzF2=VEABOOaGhkjfV-D0NPbBM+Rw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
To:     Dmitry Torokhov <dtor@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 9:03 PM Dmitry Torokhov <dtor@google.com> wrote:
> On Wed, Oct 24, 2018 at 3:02 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Oct 22, 2018 at 04:34:55PM -0700, Rajat Jain wrote:
> > > On Fri, Oct 19, 2018 at 2:13 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Oct 19, 2018 at 12:53 AM Rajat Jain <rajatja@google.com> wrote:
> >
> > > > > across other users of this API (other MMC host controller drivers).
> > > >
> > > > >         if (slot->cd_idx >= 0) {
> > > > > -               ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
> > > > > +               ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
> > > > >                                            slot->cd_override_level, 0, NULL);
> > > >
> > > > Yes.
> > > >
> > > > > +               if (ret && ret != -EPROBE_DEFER)
> > > > > +                       ret = mmc_gpiod_request_cd(host->mmc, NULL,
> > > > > +                                                  slot->cd_idx,
> > > > > +                                                  slot->cd_override_level,
> > > > > +                                                  0, NULL);
> > > >
> > > > And no. Instead of this part you need to provide an ACPI GPIO mapping table.
> > >
> > > Sure, I am willing to do so, and I tried earlier too. However, certain
> > > doubts arose in my mind when I tried that and I posted my questions
> > > earlier (https://lkml.org/lkml/2018/9/28/507) but couldn't elicit any
> > > response. Unfortunately I still do not have answers. My primary
> > > questions are:
> > >
> > > 1) - It seems that 1 SDHCI device may support multiple slots (looking
> > > at the code). It is not clear to me if they could share card detect
> > > interrupts, or should have separate ones?
> >
> > This is more likely question to HW engineers of your platform with a caveat
> > that there should be a way to distinguish exact slot in which card is being
> > inserted.
> >
> > > Also, the driver may not
> > > really know?
> >
> > I think in such case the bug in HW design and / or driver.
>
> Why? You can have a shared or dedicated interrupt and the driver does
> not really need to know if it can poll the status.

Yes, that's my point either we get 1:1 mapping between slot and GPIOs
or have a possibility to read back from some register(s) the actual
status of all of them, otherwise it's a bad design. Sorry if I wasn't
clear about it.

> > > So should I add 1 or two pins using the
> > > devm_acpi_dev_add_driver_gpios().
> >
> > This depends on the above, e.g. HW design, ACPI tables.
>
> Yes, it depends on the HW design and that is exactly why the approach
> with devm_acpi_dev_add_driver_gpios() does not work well here: this is
> a generic driver used on many platforms and you are trying to put the
> platform knowledge into the driver. Here we are lucky I guess as I do
> not believe anyone is using more than one slot, so we can have a tavle
> with a single entry, but actually doing the fallback the way Rajat was
> proposing is more correct. Or you have a table with N entries, where N
> is hopefully sufficiently large.

Yes, unfortunately this is the case. We need to keep somewhere the
list to support old firmwares (see hci_bcm.c as an example how BIOS
can screw things up).
Soonish we start _DSD in BIOSes in a correct way (ha-ha), better for everyone.

> > > Is some one familiar with SDHC
> > > driver can answer these questions, it shall be great.
> >
> > Actually above questions better to ask in linux-mmc mailing list, which by the
> > fact is in Cc list already. So, wait for someone to clarify.
> >
> >
> > > 2) I'm not really sure what should I set "active_low" to? Isn't this
> > > something that should be specified by platform / ACPI too, and driver
> > > should just be able to say say choose whatever the ACPI says?
> > >
> > > struct acpi_gpio_params {
> > >         unsigned int crs_entry_index;
> > >         unsigned int line_index;
> > >         bool active_low;
> > > };
> >
> >
> > ACPI specification misses this property, that's why we have it in the
> > structure. In your case it should be provided by _DSD and thus be consistent
> > with the hardcoded values.
>
> Again, you think as if the driver was platform specific; it is not. I
> have 1000s of systems with different ACPI tables. Let's say half of
> them use one polarity, and half another. Which polarity do you propose
> to use?

Use one table for one half and another for the rest.

-- 
With Best Regards,
Andy Shevchenko
