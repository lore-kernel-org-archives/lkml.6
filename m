Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeDDNNG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:13:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50903 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbeDDNND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:13:03 -0400
Date: Wed, 4 Apr 2018 15:12:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] mfd: add Gateworks System Controller core driver
Message-ID: <20180404131239.GD20869@lunn.ch>
References: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
 <1522250043-8065-3-git-send-email-tharvey@gateworks.com>
 <CAJ+vNU3-gaTcMAzo5wB6oSfE-JQC3NBVRJS5zFMTE-nVpD4F5g@mail.gmail.com>
 <20180403164715.GA5676@lunn.ch>
 <CAJ+vNU31f+iY5LOG6QmdJetb=pPvY_gpKoS+49FSy70U1Ksd8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU31f+iY5LOG6QmdJetb=pPvY_gpKoS+49FSy70U1Ksd8g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What about the 'reset' functionality? Is there something in the power
> supply API for hooking in a GPIO based power switch (in my case it
> would be i2c) as I would think that would be common for ATX supplies?
> I didn't see anything in Documentation/power.
> 
> This is what led me to the restart handler idea. Ultimately when
> someone issues a 'reboot' I would like it to use the GSC to
> power-cycle the board.

Hi Tim

I think you end up with the same problem. By the time you need to turn
the power supply off, too much of the kernel is shut down to be able
to use I2C. And if you are in the middle of an Oops, you have no idea
of the current state. Another I2C transaction could be under way etc.
All the current reset drivers are pretty much self contained, atomic
and use KISS hardware like a GPIO.

Maybe you best bet is to see if you can find any other I2C PMICs which
the kernel supports.

    Andrew
