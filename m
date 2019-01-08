Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1725FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D677520883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eSElZoQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfAHWUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:20:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46210 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbfAHWUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:20:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so4947415otm.13;
        Tue, 08 Jan 2019 14:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FszoKRoii4/tLSRpYfFx7gzdLe873cr0aXmZDyBbvM=;
        b=eSElZoQn2DIH72z1EWOtHQjqzOkOhH5QnFfqy7b9Hhs3Ok5QLq26EFK7TQXK9PIeNc
         dRkbSaZRdX31zO07z4sYC53kT2ixhtlWrUrK/6qXWo0pGq74ijj9KxcsHSl3CAX+dzqr
         HcTPexMTO25vmu0T1YzJU2W+lHmnlQOiML/fXxEeo5VnCsUMFO6x2cho4XNJN/fDrf19
         kle0rtYJ/UzUtk6TD2E+brpt86zSh0i2LipeHeexFeB1rl+9tvD9Ta8uVraqWz82b6Fn
         Z6BUBkv0WiMgf7Ix1kZqlmFmV6Y+Q0OI7mDhbRQyy4ln3DR9gbXBHfHssCq6ni2dTUq/
         PORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FszoKRoii4/tLSRpYfFx7gzdLe873cr0aXmZDyBbvM=;
        b=h/yjbe8BQdhyUnkifXdxU6WgXGibCqY2Sf3Mg7YpJUEk42CwGdZ0ZYyB3KCVIEK/L9
         Ds8NYWRdAqiVk2auRmLiVq31agERWTHW0lfvK26/rYBNiAZJTBlXFFLPhOOUSea2z59d
         mO9FBIzOGboObViAcNj83e/+OU257RH1nhLZ3XxZB95ZsftoaZ+FyPvMiVowyq8B1yho
         zR6zqpvRaQ0WlbOS+fNykhRFsi5zLOwLiIlYWlhycpUWnhFIHcVrUzsaM9zDzjjHmswd
         +Is3e4ZqGFxpUqa83X+VcLfgwZCs3x0kQblsf3MfbUQmCkFVEtUjrNzCsFzX/4UUtKbu
         JKNQ==
X-Gm-Message-State: AJcUukcNWXxGMGAO27r8lqvBC27ONtnETXitb7NgH1qDFsxMAlbI5gIe
        P5mSQTzQVDIsLMoN6jMG/ut3PX8Ugffz6NEIDPQ=
X-Google-Smtp-Source: ALg8bN69o9Zg29FBhXVFYmT+twlXqMLAu0kW630fZwzdzoS2zn+fub1h/543Z5T3yGcYcFHhyySw1fLgxs1GKQQL230=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr2392346otg.308.1546986022444;
 Tue, 08 Jan 2019 14:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20190101194414.24766-1-martin.blumenstingl@googlemail.com>
 <20190101194414.24766-2-martin.blumenstingl@googlemail.com> <CACRpkda8cSt7J8+2P1xpOn13KkS_xmeO1MBRR9dXZcWXgzpQwQ@mail.gmail.com>
In-Reply-To: <CACRpkda8cSt7J8+2P1xpOn13KkS_xmeO1MBRR9dXZcWXgzpQwQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 8 Jan 2019 23:20:11 +0100
Message-ID: <CAFBinCDj-CpaQb2wfreJOCkFVj6ysV7943mqTs3xSvMfhy3yGw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: core: don't override the CD GPIO level when
 "cd-inverted" is set
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Jan 3, 2019 at 11:06 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Jan 1, 2019 at 8:44 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>
> > Since commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
> > tree") gpiolib-of parses the "cd-gpios" property and flips the polarity
> > if "cd-inverted" is also set. This results in the "cd-inverted" property
> > being evaluated twice, which effectively makes it a no-op:
> > - first in drivers/gpio/gpiolib-of.c (of_xlate_and_get_gpiod_flags) when
> >   setting up the CD GPIO
> > - then again in drivers/mmc/core/slot-gpio.c (mmc_gpio_get_cd) when
> >   reading the CD GPIO value at runtime
> >
> > On boards which are using device-tree with the "cd-inverted" property
> > being set any inserted card are not detected anymore. This is due to the
> > MMC core treating the CD GPIO with the wrong polarity.
> >
> > Disable "override_cd_active_level" for the card detection GPIO which is
> > parsed using mmc_of_parse. This fixes SD card detection on the boards
> > which are currently using the "cd-inverted" device-tree property (tested
> > on Meson8b Odroid-C1 and Meson8b EC-100).
> >
> > This does not remove the CD GPIO inversion logic from the MMC core
> > because there's at least one driver (sdhci-pci-core for Intel BayTrail
> > based boards) which still passes "override_cd_active_level = true" to
> > mmc_gpiod_request_cd(). Due to lack of hardware for testing this is left
> > untouched.
> > In the future the GPIO inversion logic for both, card and read-only
> > detection can be removed once no driver is using it anymore.
> >
> > Fixes: 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> OK two steps forward, one step back, that's a good fix for now, I
> can fix it properly for v4.22.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
great, thanks for reviewing this!

feel free to keep me CC'ed on the "cleanup patches". I can review them
if you don't mind that I usually need a few days to do that


Regards
Martin
