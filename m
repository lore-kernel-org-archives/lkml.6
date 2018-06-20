Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2521C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D18C20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D18C20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753853AbeFTGnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:43:24 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44461 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752871AbeFTGnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:43:21 -0400
Received: by mail-lf0-f66.google.com with SMTP id p23-v6so3169663lfh.11;
        Tue, 19 Jun 2018 23:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6O13VrLEyydz4l6iyi8LndIlLmdh+yMz0nhB2EUulrs=;
        b=MFgT1WcMULnrouEf1vGSaqqj9ZO+oB2el9m4yE3g16cjLwynnLvwPp9J4TtIBB6exX
         dwKUinANcBlaUvMiToKc+5kcilgH+2afOA+EUI2tl+pFNQxZ/LQjjamXzqq1ghysKjPr
         VRK6yrBMbG3lt3u66hXc90+aNI2qsmMQ0TC3PQzKNh0ciKQ6Ff42QJTm5qfsUnPFCCZt
         ijqHAore+W8tqslIsDow6GkWq2Q+2UNPJd06UKe5rOjbzjC2TH6yEe4/NXm+iHM0h5+i
         ucHRX8fdN4GKtmHT1oEaP5wUzUoWUB0w63aTP9A5LUauLFdYpSrHTrSvtiiYAn51IFFb
         ZP7w==
X-Gm-Message-State: APt69E2CGLjAmGEP7qss7wPEv3ML0pthI0HTO9w/EV/vMc5FqVk8AmlR
        Fl1PEakz4Mtsik+Lb2qXI7I=
X-Google-Smtp-Source: ADUXVKI8fIklHNyLmqO0lvWNyC12vBdb7XsBOdDyl5meIkBawi3aXF7lmLYmDCy/ncIsiIwgLRgwuA==
X-Received: by 2002:a2e:9744:: with SMTP id f4-v6mr365797ljj.5.1529476999840;
        Tue, 19 Jun 2018 23:43:19 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.34])
        by smtp.gmail.com with ESMTPSA id f124-v6sm266665lfg.33.2018.06.19.23.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 23:43:19 -0700 (PDT)
Date:   Wed, 20 Jun 2018 09:43:16 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 4/4] input/power: Add driver for BD71837/BD71847 PMIC
 power button
Message-ID: <20180620064316.GB28784@localhost.localdomain>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <af60857c6db5fcf14fbf0112f74719d898952459.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <20180619175028.GA71788@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619175028.GA71788@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

First of all -  thanks for taking the time to review the patch =)

On Tue, Jun 19, 2018 at 10:50:28AM -0700, Dmitry Torokhov wrote:
> Hi Matti,
> 
> On Tue, Jun 19, 2018 at 01:57:09PM +0300, Matti Vaittinen wrote:
> > ROHM BD71837 PMIC power button driver providing power-key press
> > information to user-space.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/input/misc/Kconfig          | 10 +++++
> >  drivers/input/misc/Makefile         |  1 +
> >  drivers/input/misc/bd718xx-pwrkey.c | 90 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 101 insertions(+)
> >  create mode 100644 drivers/input/misc/bd718xx-pwrkey.c
> > 
> > +	platform_set_drvdata(pdev, pk);
> > +	err = regmap_update_bits(pk->mfd->regmap,
> > +				 BD71837_REG_PWRONCONFIG0,
> > +				 BD718XX_PWRBTN_SHORT_PRESS_MASK,
> > +				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
> 
> This seems to be the only custom bit of set up in the driver, the rest I
> think can easily be handled by gpio-keys.c in interrupt-only mode. Maybe
> we could move this into MFD piece and drop this driver?

I looked at the gpio_keys.c (for first time so please bear with me if I
ask something you consider as obvious). This is also the first time I am
dealing with input subsystem drivers. So this patch was kind of "RFC"
because I am unsure if this is the best way...

HW we are dealing with is a PMIC which can hace a power-button attached.
HW can generate 3 different types of interrupts for power button
presses:

1. interrupt when button is pressed or released. (Eg. if someone just
hits the button we get two interrupts of this type). We get no 'position
information' from PMIC - just the irqs. Hence it is difficult to know if
buttown was pressed or released. This is the reason why I decided not to
use this IRQ (at least not for now).

2. interrupt when button is pressed for 'short time'. Short time is
configurable and IRQ is generated when button is released based on the
duration it was held down. The limit for 'short time' can be configured.
By default if button is pressed longer than 3 seconds but less than 10
seconds the the PMIC detects 'short push'.

3. interrupt when button is pressed for 'long time'. Mechanism is same
as with short push. Default time is button held over 10 seconds. This
interrupt is not handled if PMIC provides power to processor as PMIC
will cut the power when long push is detected.

So the custom piece is setting the 'short push detection' time from
t > 3 sec to t > 10 msec. Driver is then using short push irq.

This means that we don't detect button press if it is shorter than 10ms.
But we don't need any button state information in driver either. This is
why I decided to use the short push irq - is it Ok?

After this explanation - the gpio_keys_irq_isr seems to be doing exactly
what is needed for short push handling (as far as I can tell). Now it
boils down to question how we should bundle the MFD and gpio_keys
together?

Should I just fill the gpio_keys_platform_data for gpio_keys in MFD
driver? After my short browsing of existing MFD drivers I did not see
any other drivers doing that. This is why I wonder if this is a correct
approach?

Still if MFD is configuring the button presses the gpio_keys for this chip
should only be used if MFD is used, right? Hence the gpio_keys driver
should be instantiaed from MFD, right?

Another option would be using DT and adding gpio_keys node to MFD node
or to simple-bus node. But I have an idea that this would make Rob
unhappy :) I had lenghty discussion with him about declaring the PMIC
as interrupt-controller in device-tree - and I was kindly educated that
it was not the way to go :) I'd rather not started this discussion
again.

Finally, there may be cases when power button is not attached to PMIC
or is needing different configuration for 'short push'. This is why I
would prefer having own Kconfig option for this power-key driver. I am
not sure if it is easily doable if we use gpio_keys?

Can you please give me some further pointer on how I could use the
gpio_keys from MFD?

Best Regards
    Matti Vaittinen

