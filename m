Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2364419-1526376251-2-13614717445402738856
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526376250; b=dGojWrhZDkUMcaPm+GNvJzOOehNi5Jcw8zwPVnr4iF9Z3vWr1x
    aarBfcp/ZiSv/xBnC0eRLeGjKlFdiTuVy4anFJoufDtMDW/9GESVaHrFHrVyGArH
    vA/uwyfQJz62sUButfPggzDhwF0lEEXXjf/G3NVzaw/wvc8YispbjCyjiMc1Whhf
    1TqjlY2GKHCchaXCDjFxtoWsc8K2g3jNgrMREygM8bjv69Q9xvescewf3G0+nW4N
    G/FoXT/boe/ZkgNTY05v0pD5wWslk2YUSI4yIChnv0J5YQJIMBArWQ1x/I6/JwHs
    AICwiox2e5hjtVShd+gkhetE5npyUOBIb4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526376250;
    bh=h7d2QaUwcUR0ssuwX5qYbLsjJ4FvtB7oY9tvLBG8iik=; b=lB2Oq7uNLkeU
    OhmSWItcCKEQYjpuIdacsCUdLXo4i74b8WRQ4KPnU9TZAiRDL3buqK248hfQgRBE
    gNzBhuuSTy4PDpNkEoKKUrycYKoY3YQvMbXMUIOU0h+HV4QWzj7DRVTzpSp4fhwJ
    6c3gpLPX+mCvbrarE1jYqSjsQ6GqWJC9YIhby9mtJFgFEcVXZpepqjOTBMIJHF9i
    U7P/wPUeuwNIGOzmeGLiw8JO8Djp74fP22ytmjMJHSxjwdxtnr3yShODXCnc9czB
    s2+cdPpyJgViFi6RCpcnkVXheALkMrRGo5qh6pypbpm7u1ZqewdTCZTgOKKIhibi
    BZREq7B+UQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=microchip.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=microchip.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKvVspevwSPgdCWUmLEVD97TwHZRT5N7LVrXlaHaADhwAbhwngOOFcOGa5V5cJ9KyAz3NxLwlJFmdtDjPTsqbMeLpIR5TE9RmgJBgDgAma0DzQxnIYt+
    hlauVo0nlv6cv8tSKLdBmSw4uFZeQoHpwelmsQqiOXzejhkz0115Y1x8qel2XIFeVBuhj8XQjh5CICAyloUC/4Ypq6azBUU934nNPr6MNqmJpCIzJGKynalR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=d7Br21xq7p6gxlDypLIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeEOJYC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 05:24:02 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:23635 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeEOJX7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 May 2018 05:23:59 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="14262232"
Message-ID: <49c13a964f517c9c90e61beda327d4174fd1358c.camel@microchip.com>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
From: Radu Pirea <radu.pirea@microchip.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>
Date: Tue, 15 May 2018 12:25:10 +0300
In-Reply-To: <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
         <20180511103822.31698-6-radu.pirea@microchip.com>
         <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-05-13 at 16:33 +0300, Andy Shevchenko wrote:
> On Fri, May 11, 2018 at 1:38 PM, Radu Pirea <radu.pirea@microchip.com
> > wrote:
> > This is the driver for at91-usart in spi mode. The USART IP can be
> > configured
> > to work in many modes and one of them is SPI.
> > +#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> 
> Here is something wrong. You need to use latter one in new code.
> 
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_gpio.h>
> 
> Hmm... Do you need all of them?
> 
> > +static inline void at91_usart_spi_cs_activate(struct spi_device
> > *spi)
> > +{
> 
> ...
> > +       gpiod_set_value(ausd->npcs_pin, active);
> > +       aus->cs_active = true;
> > +}
> > +
> > +static inline void at91_usart_spi_cs_deactivate(struct spi_device
> > *spi)
> > +{
> 
> ...
> > +       gpiod_set_value(ausd->npcs_pin, !active);
> > +       aus->cs_active = false;
> > +}
> 
> ...
> > +       if (!ausd) {
> > +               if (gpio_is_valid(spi->cs_gpio)) {
> > +                       npcs_pin = gpio_to_desc(spi->cs_gpio);
> 
> ...
> > +               }
> 
> ...
> > +               gpiod_direction_output(npcs_pin, !(spi->mode &
> > SPI_CS_HIGH));
> > +
> > +               ausd->npcs_pin = npcs_pin;
> 
> ...
> > +       }
> 
> I will refer to above as (1) later on.
> 
> > +       dev_dbg(&spi->dev, "new message %p submitted for %s\n",
> > +               msg, dev_name(&spi->dev));
> 
> %p does make a very little sense.
> 
> > +       list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> > +               ret = at91_usart_spi_one_transfer(controller, msg,
> > xfer);
> > +               if (ret)
> > +                       goto msg_done;
> > +       }
> 
> Cant SPI core do this for your?
> 
> > +static void at91_usart_spi_cleanup(struct spi_device *spi)
> > +{
> > +       struct at91_usart_spi_device *ausd = spi->controller_state;
> > +
> > +       if (!ausd)
> > +               return;
> 
> Is it even possible?
> 
> Anyway the code below will work fine even if it's the case.
> 
> > +
> > +       spi->controller_state = NULL;
> > +       kfree(ausd);
> > +}
> > +static int at91_usart_spi_gpio_cs(struct platform_device *pdev)
> > +{
> > +       struct spi_controller *controller =
> > platform_get_drvdata(pdev);
> > +       struct device_node *np = controller->dev.parent->of_node;
> > +       struct gpio_desc *cs_gpio;
> > +       int nb;
> > +       int i;
> > +
> > +       if (!np)
> > +               return 0;
> > +
> > +       nb = of_gpio_named_count(np, "cs-gpios");
> > +       for (i = 0; i < nb; i++) {
> > +               cs_gpio = devm_gpiod_get_from_of_node(&pdev->dev,
> > +                                                     pdev-
> > >dev.parent->of_node,
> > +                                                     "cs-gpios",
> > +                                                     i,
> > GPIOD_OUT_HIGH,
> > +                                                     dev_name(&pde
> > v->dev));
> > +               if (IS_ERR(cs_gpio))
> > +                       return PTR_ERR(cs_gpio);
> > +       }
> > +
> > +       controller->num_chipselect = nb;
> > +
> > +       return 0;
> > +}
> 
> The question is, why you didn't utilize what SPI core provides you?
> 
> > +       spi_writel(aus, MR, US_MR_SPI_MASTER | US_MR_CHRL |
> > US_MR_CLKO |
> > +                       US_MR_WRDBT);
> > +       spi_writel(aus, CR, US_CR_RXDIS | US_CR_TXDIS | US_CR_RSTRX
> > |
> > +                       US_CR_RSTTX);
> 
> I didn't check over, but it seems like you might have duplication in
> these bitwise ORs. Consider to unify them into another (shorter)
> definitions and reuse all over the code.
> 
> > +       regs = platform_get_resource(to_platform_device(pdev-
> > >dev.parent),
> > +                                    IORESOURCE_MEM, 0);
> > +       if (!regs)
> > +               return -ENXIO;
> 
> Strange error code for getting MMIO resource. ENOMEM sounds better.
> 
> > +       dev_info(&pdev->dev,
> > +                "Atmel USART SPI Controller version 0x%x at
> > 0x%08lx (irq %d)\n",
> > +                spi_readl(aus, VERSION),
> > +                (unsigned long)regs->start, irq);
> 
> If you do explicit casting when printing something you are doing
> wrong.
> Please use %pR or %pr in this case.
> 
> > +static struct platform_driver at91_usart_spi_driver = {
> > +       .driver = {
> > +               .name = "at91_usart_spi",
> > +               .of_match_table =
> > of_match_ptr(at91_usart_spi_dt_ids),
> 
> Can it work as pure platform driver? If no, of_match_ptr() is
> redundant.

This driver can not work as pure platform driver, but I the way I used
to probe it from MFD(by compatbile string).
Do you know another way?

> 
> > +       },
> > +       .probe = at91_usart_spi_probe,
> > +       .remove = at91_usart_spi_remove, };
> 
> Two lines at one. Split.
> 
