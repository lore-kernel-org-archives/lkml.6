Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B597520842
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="J04ALZMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfBMK6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:58:38 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54600 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfBMK6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:58:37 -0500
Received: by mail-it1-f193.google.com with SMTP id z9so3009195itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 02:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0W6Q9SfqR8KsuOuRSWCMyZ1zIwyFEMKMRw07twav4j4=;
        b=J04ALZMKqA4I20RGv7cJ6bzD7OEAll6AlCzXZi20Z5FN+BZSUjuaQEJvHq/BnhrStt
         OcNmbTvKdmG7uPZPx/DsJThqPTbBrkbo1w13f89FaHia7/B0XhbFm8Ojuteuo6qhlsP5
         FgRBWiUXQaSeGeN+wPf45LZg4XLo993lOTxiRhQai+5TFZrV61ANlZFri5DFjZhDePqc
         paBYZX8vUG43vyyOlRmmXobcVBmSFT9bFjs8syb36+WG54d4gGNSZ3Ps2EIw7FP79GD+
         K9aTWj8lG629CYzm0BWFvaCHidDfzBnHoZ4oVs7/l+F8kQSo9/oBGxPt2yV+R3lFVccr
         itzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0W6Q9SfqR8KsuOuRSWCMyZ1zIwyFEMKMRw07twav4j4=;
        b=UMgE35E9uYuadUcR6nzVqk1ToWXLTDDB3JvZHIqEhZ2ESCRBASBU6KAkMWn8Fj+cEo
         +Qxm1D61RibU/nY97WJCqt9xPVYCEOEHyR3CsTJny+YkIcG7qRUUn0uFZCqJuqwOFnr/
         qmB+ODOjlHt7jTBBYcZar7D6N7dcTb3i7EWr2v9u00somKrAHiiGeyfhJpRWT9jlluzQ
         gYfbwTtKP6XH//1P6KfrimZIJR9NQF+2VAq+5KAWkYrJGurOwNtOQNZ50c7iGxyD7NWW
         4jXqiRmtihlTfqS1VmnnbDaKBcV3HNx7BoSvXAXlNWq6GaTE43fAsaD4svnSkTXuo3Ww
         3u8A==
X-Gm-Message-State: AHQUAuZSH4WWIjBTntDFcv7Ic2aTeoELY0KpW6clDvBM2IFgAvZ1Gpo4
        WaTA3x1+h959QsPOi6XwXBm2HtJDAMkfbSsLp1J3mg==
X-Google-Smtp-Source: AHgI3IYS74n3xlLGwLzRtJiPda1ytTZSzXXFn641T7eF/Jv0ykQff3/+Oj67SyNCS+iLus3YKwXb40DaxYzTtHS4oZ4=
X-Received: by 2002:a24:7284:: with SMTP id x126mr2084192itc.96.1550055516743;
 Wed, 13 Feb 2019 02:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20190201094736.32057-1-brgl@bgdev.pl> <20190201094736.32057-10-brgl@bgdev.pl>
 <20190212121236.GD25613@amd>
In-Reply-To: <20190212121236.GD25613@amd>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Feb 2019 11:58:26 +0100
Message-ID: <CAMRc=MfpCU0fRGrQb5CncaHu2Yfdv=NbuZc9Oujb7FUWdn93Pg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] leds: max77650: add LEDs support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lut 2019 o 13:12 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
>
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index a72f97fca57b..6e7a8f51eccc 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -608,6 +608,12 @@ config LEDS_TLC591XX
> >         This option enables support for Texas Instruments TLC59108
> >         and TLC59116 LED controllers.
> >
> > +config LEDS_MAX77650
> > +     tristate "LED support for Maxim MAX77650 PMIC"
> > +     depends on MFD_MAX77650
> > +     help
> > +       LEDs driver for MAX77650 family of PMICs from Maxim Integrated.=
"
> > +
>
> List the chips? Remove extra "?
>                                                                         P=
avel

They are already listed in the core mfd Kconfig, but thanks for
spotting that stray ".

Bart
