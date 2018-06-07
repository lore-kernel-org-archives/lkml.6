Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /pzGN5EwGVtWLQAAmS7hNA
	; Thu, 07 Jun 2018 13:18:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C5FA7608BA; Thu,  7 Jun 2018 13:18:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLlHfrAx"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 44245601D2;
	Thu,  7 Jun 2018 13:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44245601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932542AbeFGNSH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:18:07 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:42644 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbeFGNSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:18:05 -0400
Received: by mail-ua0-f193.google.com with SMTP id x18-v6so6463883uaj.9;
        Thu, 07 Jun 2018 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=edGcZCt3jAO9B9/oFloXClSB4mLzSk0Xy5Aa5yHXe/k=;
        b=tLlHfrAxrv2JwZsxHmxX20J7lSIYL8jnP+IEu9PTF1NsBM1MHwgg5nmBMLCT9ma0my
         FAAvyizFsal0kFB5vOc7I4K+3Gt3cXOQPP/CWDfrXw+KJ4/jsxke3NRRHQ9sJQGco1YZ
         krPAJGz771Vgev1jngfahwhU9X5GAj6AhnhFBGDQ/EB7jLgWTZxy53/hC1cBcCmNSuaq
         Fi+D8rwLBvjgwFKWtC6r+Xr/Xn+6CYGiXCmHOjudI92Sqisg75QwfYUnQ+lQNRcXj6fn
         qKF1x5oSssRukSclUK2oJlTKXM5NGqTcWheZjnOs7S2Wbdh+GF+FLKZjRtPs7qG1M/Sr
         11Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=edGcZCt3jAO9B9/oFloXClSB4mLzSk0Xy5Aa5yHXe/k=;
        b=VpXTW7iG/idvrYIi6qhq2JO4a0x9EXVgQV5CpwoQ/hH/tXC3ZnC4GZSsmJOudgKH2P
         7h0L8nHeR1iO+7+90uI4xbKHf9lqTqUEqigu7MRWWKt5wYhjQn2I8c/aUmZIiwMQyPTc
         ZE5Ywcfuq98EFFxRfMUt4/LmC/sDC9hMcm7AgjnfQxanYgEkVNvxwsZgwW4IdDi/xcC/
         okj3M3FjaVtXeG6skT8dKRqIy0BdSx6Hxa2dE7YAugmnxbmD4YDNSIC5s1sE4CAKxr0E
         2wMQmbPJXpHxB/H60D7jzZgXoddETX+Ad1IMDD8PDJA38tyKoP8Hfc/co3dvywwKhmDr
         Wq8w==
X-Gm-Message-State: APt69E07HfxSNyFjKVNVQl0zrnyPdyAEaIU7bhxc7hQQJjngMF+HqDty
        p7AM9syZEm+OTEFTNE2ZYxzB3WqgMzNPY/RHBr0=
X-Google-Smtp-Source: ADUXVKJBajJfP0rvhy1msVoMEEsTAgzn3WpFLvqMcwnAOfuBWEmMF7FPPBKORXIOcRiqoOT8eknPL4hBP3ITO1ZFGr4=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr1140528uai.47.1528377484205;
 Thu, 07 Jun 2018 06:18:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8f:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 06:18:02 -0700 (PDT)
In-Reply-To: <20180607110020.20565-1-radu.pirea@microchip.com>
References: <20180607110020.20565-1-radu.pirea@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Jun 2018 16:18:02 +0300
Message-ID: <CAHp75Vf=CC=UximfkB5a0-PHLiT6ugR4jH3NKdU3w=k=-kPnSA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Driver for at91 usart in spi mode
To: Radu Pirea <radu.pirea@microchip.com>
Cc: Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        alexandre.belloni@bootlin.com, Lee Jones <lee.jones@linaro.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 2:00 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
> Hello,
>
> This is the second version of driver. I added a mfd driver which by
> default probes atmel_serial driver and if in dt is specified to probe
> the spi driver, then the spi-at91-usart driver will be probed. The
> compatible for atmel_serial is now the compatible for at91-usart mfd
> driver and compatilbe for atmel_serial driver was changed in order to
> keep the bindings for serial as they are.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for patches 3, 5, 6 only.

> Changes in v1:
> - added spi-at91-usart driver
>
> Changes in v2:
> - added at91-usart mfd driver
> - modified spi-at91-usart driver to work as mfd driver child
> - modified atmel_serial driver to work as mfd driver child
>
> Changes in v3:
> - fixed spi slaves probing
>
> Changes in v4:
> - modified the spi driver to use cs gpio support form spi subsystem
> - fixed dma transfers for serial driver
> - squashed binding for spi and serial and moved them to mfd/atmel-usart.txt
>
> Changes in v5:
> - fixed usage of stdout-path property with atmel_serial driver
>
> Changes in v6:
> - removed unused compatible strings from serial and spi drivers
>
> Radu Pirea (6):
>   MAINTAINERS: add at91 usart mfd driver
>   dt-bindings: add binding for atmel-usart in SPI mode
>   mfd: at91-usart: added mfd driver for usart
>   MAINTAINERS: add at91 usart spi driver
>   spi: at91-usart: add driver for at91-usart as spi
>   tty/serial: atmel: change the driver to work under at91-usart mfd
>
>  .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
>  MAINTAINERS                                   |  16 +
>  drivers/mfd/Kconfig                           |   9 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/at91-usart.c                      |  68 +++
>  drivers/spi/Kconfig                           |   9 +
>  drivers/spi/Makefile                          |   1 +
>  drivers/spi/spi-at91-usart.c                  | 434 ++++++++++++++++++
>  drivers/tty/serial/Kconfig                    |   1 +
>  drivers/tty/serial/atmel_serial.c             |  42 +-
>  include/dt-bindings/mfd/at91-usart.h          |  17 +
>  11 files changed, 606 insertions(+), 17 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
>  create mode 100644 drivers/mfd/at91-usart.c
>  create mode 100644 drivers/spi/spi-at91-usart.c
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
