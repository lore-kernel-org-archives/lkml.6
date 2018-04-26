Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732268; cv=none;
        d=google.com; s=arc-20160816;
        b=BzUY/Y1QtxSx9XHuCRbkoDhhHDvwK9C9zB6iZH8Axr3E6vQuRmTWG2N/SBlQmwmYEH
         +3vi2horNvERUB8xXo1/PGraawtEzjkxzT+yiVI1hl2t/E50zH1QcnWJZmzT8p3uaghO
         pZYo460IVzeXydpT0ZduaYOFF23FS9Xa7JQCg3JEtEDe0tsaZOzSRy+cbcyryH1V6h6Q
         +j9B+Ez2YRlBHp9EZzxadyr9ChrSUsDaHzHxjMttzWbjS8YLcVz/kFwy+Mi59FHlsQbG
         BZMdlsmpLYQymnYndbCYWkANBzcuWnu4xqZxfTvWf5xRFUL9HODvqMliiWsBvNaFZa/f
         yUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=K9aClyGZjPs/V2O1Mn4D/qIgC/WMPxw7UB+vj4khDV8=;
        b=NVkxxLC65k+XigtslnxqJqARdgySQWm0qkWh2mYV1a33k1RAc38Yl5co4SkxZK4AP+
         f4VT2m7krzFHjZ7F67YBk7kabScqPHIkkZhVPQ+JLoT3hMU9QIC5zLjV/HtFK060J/jU
         joQdjgmki+BVnjnOKFXJ3bpc36fo45yNl7ZFdOkVp07p/mP+POftx0Z3eLnYcHtyg3u1
         dgvJ/2F892ZYpJsQoBsEJbBCWGY5hMV4Oiv8RxdgbsB2lKpLKIuyKmH6UAbm8v9urE1u
         GQoVhk4g/7Pd7Ggh0FE1bNfEkwy82u2G+96mZlCWtmsPdptHKC9dIQVoTzztiBVXXoF7
         PALw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=SjrS/isO;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=SjrS/isO;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqLR4MilXCsUuuJE/H0gnUsmMe1R0XrZ2dJiDxq3O6qcdh9Qbr70P9eGtu0i3dvLX3BkfobVyXhx/rhCV1g+eQ=
MIME-Version: 1.0
In-Reply-To: <20180330074751.25987-10-boris.brezillon@bootlin.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com> <20180330074751.25987-10-boris.brezillon@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Apr 2018 10:44:26 +0200
Message-ID: <CACRpkdY_7mi8GPiopZ9Yg4Y0-AV_SriZe=1yN5is6eH6FUm6Qg@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] gpio: Add a driver for Cadence I3C GPIO expander
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Xiang Lin <Xiang.Lin@synaptics.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347993252647140?=
X-GMAIL-MSGID: =?utf-8?q?1598797663056635599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 9:47 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> Add a driver for Cadence I3C GPIO expander.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

This is pretty much OK, and I don't want to raise the bar
even higher for you to get this code into the kernel, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

The following is an observation for future improvement:

> +static int cdns_i3c_gpio_read_reg(struct cdns_i3c_gpio *gpioc, u8 reg,
> +                                 u8 *val)
> +{
> +       struct i3c_priv_xfer xfers[] = {
> +               {
> +                       .len = sizeof(reg),
> +                       .data.out = &reg,
> +               },
> +               {
> +                       .rnw = true,
> +                       .len = sizeof(*val),
> +                       .data.in = val,
> +               },
> +       };
> +
> +       return i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
> +                                       ARRAY_SIZE(xfers));
> +}
> +
> +static int cdns_i3c_gpio_write_reg(struct cdns_i3c_gpio *gpioc, u8 reg,
> +                                  u8 val)
> +{
> +       struct i3c_priv_xfer xfers[] = {
> +               {
> +                       .len = sizeof(reg),
> +                       .data.out = &reg,
> +               },
> +               {
> +                       .len = sizeof(val),
> +                       .data.out = &val,
> +               },
> +       };
> +
> +       return i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
> +                                       ARRAY_SIZE(xfers));
> +}

This is starting to resemble
drivers/base/regmap/regmap-i2c.c

Maybe we should very quickly add regmap-i3c.c as this
infrastructre has had a great positive effect on may kernel
subsystems.

> +static int cdns_i3c_gpio_get_direction(struct gpio_chip *g, unsigned offset)
> +{
> +       struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
> +
> +       return gpioc->dir & BIT(offset);

I would:

return !!(gpioc->dir & BIT(offset));

So you clamp it to bit 0.

Yours,
Linus Walleij
