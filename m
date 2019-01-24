Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0C4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FAB2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzCbU31v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfAXWxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:53:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40775 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAXWxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 17:53:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so3321518pgp.7;
        Thu, 24 Jan 2019 14:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7rIVrogJA48mufbve07iZa5QQwPNEs7vGbrN7BSrbQ=;
        b=CzCbU31vCHiOyRcrNfR1lLH+ptM/iapBMUmxkTSRLzrChHBYE35WxknL/fmhMpOxm+
         4rAiuw8uowNz7YdZ5Y+WrBcwNTvlgqp3SGfocXS5bhFY4ZPbBAx0qVHkkN2IEtMk0YHJ
         L7TUKm7oSsIiaHGPAaS3NvyZur5S93pYE5jTSodO9U0WvV+MpGG8t3c4VdlnOpJwt8+M
         Gj/8/KBOy49HvOv3Ezi28Py3kZXXMvjUeyIzg9Ic0mDjQWk2Zec0YrdEZvWeJmHo5EjS
         fPEIKyIaFUZFFG2qfGcFl2MNdLCoidF0jh8B5oAgfYCkFMM694mgk7nrr2WLxfhPkvco
         7Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7rIVrogJA48mufbve07iZa5QQwPNEs7vGbrN7BSrbQ=;
        b=MHCaYHxC9AewNJyhO+NVuECbvgRcIOSkn0GHeZtl0eDJM97hCkHV4gyMeONro92Ffv
         OKpHWy7LLFLyTZmdcKMdyVYBnXzmtpFLffeSFKsMuh2+jdsSZVmqs5WhXCHFUuNjVIrK
         /SnBKe0XkXpqeIEV3DoleV/38ALEzbDig8WiN1PnUGPOPPq+3KD4zhfN1cTLJbl4m6nl
         YsU+JikL2/u1uM6cJOiwSfj4/ImvBx7soUj3moqAZSpJBm9/57iC3EYANFQK4mijCgw+
         +TAHu3kb413wxRwKzRVOPlkJPC1wk601iiUDVT8rZSs4iBUrphI/t7tzdzvtn7GXMUk4
         SwAg==
X-Gm-Message-State: AJcUukdamVvrCnTPENLO+P3EtuVSpCjsYQeBVcAi7/tJYckOuUFzNyRI
        ZWPnEqCLKyKXYigVxwir9uoAsQDPlC4wveG+6/c=
X-Google-Smtp-Source: ALg8bN5u9jNQlfMw3ySkcxszvrzWG76IZTIJ5BRv9lFEnrYbteABu/FJUVkToPjtev9hq8tTEuRHa/TO503VWXBGVvk=
X-Received: by 2002:a63:d450:: with SMTP id i16mr7602831pgj.246.1548370387666;
 Thu, 24 Jan 2019 14:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20190109105245.25954-1-andriy.shevchenko@linux.intel.com> <e5e54be2-7be1-9496-b455-336e9edfb406@redhat.com>
In-Reply-To: <e5e54be2-7be1-9496-b455-336e9edfb406@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 25 Jan 2019 00:52:56 +0200
Message-ID: <CAHp75VfHTiPnOqT3ONq_bW8=ceCRFebuogsH9xVOc=S4nKdnOw@mail.gmail.com>
Subject: Re: [alsa-devel] [RFT][PATCH v2] gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 2:20 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 09-01-19 11:52, Andy Shevchenko wrote:
> > New quirk enforces search for GPIO based on its type,
> > i.e. iterate over GpioIo resources only.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >
> > - it was sent few weeks ago to Hans for testing, but better to re-test
>
> I've just re-tested this on a device which uses the speaker-enable
> GPIO with a rt5651 codec, still works as advertised:
>
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Thanks, Hans, I will resend it rebased and with tags tomorow.
-- 
With Best Regards,
Andy Shevchenko
