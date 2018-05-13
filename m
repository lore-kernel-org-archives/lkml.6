Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3043489-1526218440-2-6196620781805928819
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526218439; b=VO6cxlex98u4HJdDT0+7YHwnWDebIuwMIZ6ilORiaGAn8Q2AfR
    hdso8AvNxqDd2BxE4uBOgkpA8XqFRyYV7BFMyFU1WXDx+N4j02h+m33G2pZPJFnQ
    UUFFmBDcYpWtw6JgAHw5O2qeYyXukGTdovx8qy0renRi56WFVLF8ujObvxAnexXT
    O0ibBYPMT8AYP0RDB08n/wF87hXb8tE3ZvRpgYyCqE/Xt2SBdsypIDeEo10UBJnT
    aP987Qs64PHutdveS2P//EEOvI/wZhCTQN4rgxDtk7gXpxIwlJyoxDEtlY9t3JVg
    Lj/35y0yXl22Eqjw0lU7F1LbD8YVZAtHeN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526218439; bh=3zBMA/9xyA9TjdUzr54YMCyuOCp3ZT7sy5kZ2ivxIU
    g=; b=XxpDr2RrXNk+YZW0R5auVyx8JSg72fXklhZkpTLoPaik77F6ESPv73M7ww
    Wj1omHbvTOLno+OdVnQxKov7hNZqIXCPPSIsIUePMNodbtUiwI2ybzpWIn5JZSbZ
    YANaRX5Qg8i1CDSQ8S69C6AUok05SYpLEUqje3ROzQPRAcjM4IS9k053nTsBR1qJ
    a71cq6mODtPc9JqD9egZVY8vJCEFXKue7N0mu1XED3Og/bzXk81Ad2wjPie2qesK
    nXXG/IOSmJLxkZn5OZ2rOQgBjCc+YVFV92fk0aAXd+VhUom+CBcsBT33+N5OJ/Sy
    Fql9pka+Var9jZfw6rbNZUJDTLdQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=GH72xJaH x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gcFhKkr/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=GH72xJaH x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gcFhKkr/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMz8G+0om65Dd9SY1eMCJKaTfcV8obXaU6I4Qg4cegGklTij0bJWdr3xJZictJibT9ulCnuiqF6fwY0S+RQw5Q2CS/V4yoDb2ekKerCH+1lcg8o9lm1k
    XHRmJ37J9b4076OA1x7Xadz6ILmDef4+ynDv/MWmamhO6U17ATEfKkGHWM48slHarTzR8RoyrMIMWvTi6vAUiwKoveq1K8QpFZKw0zXm7vaIfTOmKN6hJoSL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8
    a=f8qPlYrIzZgS6YEgYdwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeEMNdn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 13 May 2018 09:33:43 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36514 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeEMNdm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 13 May 2018 09:33:42 -0400
X-Google-Smtp-Source: AB8JxZqCbkSqB+caaTCeSvPOSx4IIw77Z+d9ZGVUk8dFKYYcvhvmIfGfPKeoNTy353UeMgy6NKOiupQlNwwlBQsI8F0=
MIME-Version: 1.0
In-Reply-To: <20180511103822.31698-6-radu.pirea@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com> <20180511103822.31698-6-radu.pirea@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 16:33:40 +0300
Message-ID: <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
To: Radu Pirea <radu.pirea@microchip.com>
Cc: devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        alexandre.belloni@bootlin.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 1:38 PM, Radu Pirea <radu.pirea@microchip.com> wrote:
> This is the driver for at91-usart in spi mode. The USART IP can be configured
> to work in many modes and one of them is SPI.

> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>

Here is something wrong. You need to use latter one in new code.

> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>

Hmm... Do you need all of them?

> +static inline void at91_usart_spi_cs_activate(struct spi_device *spi)
> +{
...
> +       gpiod_set_value(ausd->npcs_pin, active);
> +       aus->cs_active = true;
> +}
> +
> +static inline void at91_usart_spi_cs_deactivate(struct spi_device *spi)
> +{
...
> +       gpiod_set_value(ausd->npcs_pin, !active);
> +       aus->cs_active = false;
> +}
...
> +       if (!ausd) {
> +               if (gpio_is_valid(spi->cs_gpio)) {
> +                       npcs_pin = gpio_to_desc(spi->cs_gpio);
...
> +               }
...
> +               gpiod_direction_output(npcs_pin, !(spi->mode & SPI_CS_HIGH));
> +
> +               ausd->npcs_pin = npcs_pin;
...
> +       }

I will refer to above as (1) later on.

> +       dev_dbg(&spi->dev, "new message %p submitted for %s\n",
> +               msg, dev_name(&spi->dev));

%p does make a very little sense.

> +       list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +               ret = at91_usart_spi_one_transfer(controller, msg, xfer);
> +               if (ret)
> +                       goto msg_done;
> +       }

Cant SPI core do this for your?

> +static void at91_usart_spi_cleanup(struct spi_device *spi)
> +{
> +       struct at91_usart_spi_device *ausd = spi->controller_state;
> +

> +       if (!ausd)
> +               return;

Is it even possible?

Anyway the code below will work fine even if it's the case.

> +
> +       spi->controller_state = NULL;
> +       kfree(ausd);
> +}

> +static int at91_usart_spi_gpio_cs(struct platform_device *pdev)
> +{
> +       struct spi_controller *controller = platform_get_drvdata(pdev);
> +       struct device_node *np = controller->dev.parent->of_node;
> +       struct gpio_desc *cs_gpio;
> +       int nb;
> +       int i;
> +
> +       if (!np)
> +               return 0;
> +
> +       nb = of_gpio_named_count(np, "cs-gpios");
> +       for (i = 0; i < nb; i++) {
> +               cs_gpio = devm_gpiod_get_from_of_node(&pdev->dev,
> +                                                     pdev->dev.parent->of_node,
> +                                                     "cs-gpios",
> +                                                     i, GPIOD_OUT_HIGH,
> +                                                     dev_name(&pdev->dev));
> +               if (IS_ERR(cs_gpio))
> +                       return PTR_ERR(cs_gpio);
> +       }
> +
> +       controller->num_chipselect = nb;
> +
> +       return 0;
> +}

The question is, why you didn't utilize what SPI core provides you?

> +       spi_writel(aus, MR, US_MR_SPI_MASTER | US_MR_CHRL | US_MR_CLKO |
> +                       US_MR_WRDBT);
> +       spi_writel(aus, CR, US_CR_RXDIS | US_CR_TXDIS | US_CR_RSTRX |
> +                       US_CR_RSTTX);

I didn't check over, but it seems like you might have duplication in
these bitwise ORs. Consider to unify them into another (shorter)
definitions and reuse all over the code.

> +       regs = platform_get_resource(to_platform_device(pdev->dev.parent),
> +                                    IORESOURCE_MEM, 0);
> +       if (!regs)
> +               return -ENXIO;

Strange error code for getting MMIO resource. ENOMEM sounds better.

> +       dev_info(&pdev->dev,
> +                "Atmel USART SPI Controller version 0x%x at 0x%08lx (irq %d)\n",
> +                spi_readl(aus, VERSION),
> +                (unsigned long)regs->start, irq);

If you do explicit casting when printing something you are doing wrong.
Please use %pR or %pr in this case.

> +static struct platform_driver at91_usart_spi_driver = {
> +       .driver = {
> +               .name = "at91_usart_spi",

> +               .of_match_table = of_match_ptr(at91_usart_spi_dt_ids),

Can it work as pure platform driver? If no, of_match_ptr() is redundant.

> +       },
> +       .probe = at91_usart_spi_probe,
> +       .remove = at91_usart_spi_remove, };

Two lines at one. Split.

-- 
With Best Regards,
Andy Shevchenko
