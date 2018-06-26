Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E38C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C3D26A69
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oN8Y2FS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C3D26A69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeFZTHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:07:09 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:39749 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbeFZTHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:07:05 -0400
Received: by mail-vk0-f67.google.com with SMTP id n81-v6so4625547vke.6;
        Tue, 26 Jun 2018 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VZKotvrwNPFphUqzlaTMRU8rEO/6NIZksU+asYw3/aM=;
        b=oN8Y2FS8Wk6z8Ys1Rzu3fG81vUnLiUkXucgm0jtwEgGR667KWWdsld1INYEnLgaIDb
         nY+DyBRfYxhC8zK8jU5AIbv05EBIVjLBCV9NAwEYu4yT1XsubP6wAmd1wpcZtK9IowuW
         1G+U299tf1usarrH2LuV4/QEOIVmnfhUceOmPPjR7mktWyZJ/ACQEnncnV1/X6UKRtdt
         Bw49FlLXgkwzmXklmqZAK45GknuYBy34C21B6GnWYVDmqp8gOy/MmGcrYLrs5sLp5v8K
         GzxaoXQAIUoUseWDq2z6OTMaqOSY9Ks4v75stkLygJa1qY7IfsNY0QBGl5GUwbF0Pqps
         anRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VZKotvrwNPFphUqzlaTMRU8rEO/6NIZksU+asYw3/aM=;
        b=NaBgicNHUqs77WELHyKeNuadqoWclLKeu8+k7iiQAwHv45JcWreyLHhs6TsvEQoLzg
         NMlYWRUPzNHto+0pMRiubs8Esn2xYBKeYZPNXkoMn6gpPV5fCyTrhb6O0zwNgG7OzDWo
         cB0yDUQYE3UVPpI5Ip/1OgC3KKT8mK8hYEAlxbTCvHo8WfFJ5Seux9gD2VteP+kskGLZ
         KV4yljDLpseZ2MUSPk8LbCIeyViqhTj66ufTIuHUorhyRETDWaXgvHRV1yysD4aHIvay
         O4NneLwvZY44ERlMEzkTEW6gKq6r3K9yRDWlfYfCNX2q2oM6N5Dn2f8DJuRyEvgdc+Jz
         91Cw==
X-Gm-Message-State: APt69E23yZcwpe5VjzvdNbFfp7Iu89URPNE3yVd/TtKC+nRUQJpdt73K
        Ei2v9VROwARt3AuHiTdcJjrzirYAvQD0rAEmTBU=
X-Google-Smtp-Source: AAOMgpcwXD+NsWsC/LTG2HMns86EimLpI7f/ruSYdnaEcXWDogmetbE9WODIBN/PEqVvAIgnxtfKhBgvxxpzu+N2VII=
X-Received: by 2002:a1f:50c:: with SMTP id 12-v6mr1770307vkf.26.1530040024410;
 Tue, 26 Jun 2018 12:07:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 12:07:03
 -0700 (PDT)
In-Reply-To: <20180622104930.32050-10-boris.brezillon@bootlin.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com> <20180622104930.32050-10-boris.brezillon@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 22:07:03 +0300
Message-ID: <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO expander
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 1:49 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Add a driver for Cadence I3C GPIO expander.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

> +       scratchbuf = kmalloc(sizeof(*scratchbuf) * 2, GFP_KERNEL);

kmalloc_array() ?

> +       ret = i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
> +                                      ARRAY_SIZE(xfers));

One line?


> +static void cdns_i3c_gpio_set_multiple(struct gpio_chip *g,
> +                                      unsigned long *mask,
> +                                      unsigned long *bits)
> +{
> +       struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
> +       u8 newovr;
> +       int ret;
> +
> +       newovr = (gpioc->ovr & ~(*mask)) | (*bits & *mask);
> +       if (newovr == gpioc->ovr)
> +               return;
> +
> +       ret = cdns_i3c_gpio_write_reg(gpioc, OVR, newovr);
> +       if (!ret)
> +               gpioc->ovr = newovr;

You don't change mask here, why do you need a pointer to it?

> +}

> +static int cdns_i3c_gpio_get_multiple(struct gpio_chip *g,
> +                                     unsigned long *mask,
> +                                     unsigned long *bits)
> +{
> +       struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
> +       int ret;
> +       u8 ivr;
> +
> +       ret = cdns_i3c_gpio_read_reg(gpioc, IVR, &ivr);
> +       if (ret)
> +               return ret;
> +
> +       *bits = ivr & *mask & gpioc->dir;
> +       *bits |= gpioc->ovr & *mask & ~gpioc->dir;

Ditto.

> +
> +       return 0;
> +}

> +static void cdns_i3c_gpio_ibi_handler(struct i3c_device *i3cdev,
> +                                     const struct i3c_ibi_payload *payload)
> +{
> +       struct cdns_i3c_gpio *gpioc = i3cdev_get_drvdata(i3cdev);

> +       u8 isr = 0;

Perhaps you need to check the result of _read_reg() below instead of
dummy assignment?

> +       int i;
> +
> +       cdns_i3c_gpio_read_reg(gpioc, ISR, &isr);

> +       for (i = 0; i < 8; i++) {
> +               unsigned int irq;
> +
> +               if (!(BIT(i) & isr & gpioc->imr))
> +                       continue;

for_each_set_bit() ?

> +
> +               irq = irq_find_mapping(gpioc->gpioc.irq.domain, i);
> +               handle_nested_irq(irq);
> +       }
> +}

> +static const struct i3c_device_id cdns_i3c_gpio_ids[] = {
> +       I3C_DEVICE(0x1c9, 0x0, NULL),

> +       { /* sentinel */ },

Slightly better without comma.

> +};
> +MODULE_DEVICE_TABLE(i3c, cdns_i3c_gpio_ids);

-- 
With Best Regards,
Andy Shevchenko
