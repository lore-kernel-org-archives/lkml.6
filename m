Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62356FF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6F220882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6aroWsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6F220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeG2M5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 08:57:30 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46209 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeG2M5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 08:57:30 -0400
Received: by mail-vk0-f65.google.com with SMTP id b14-v6so4461967vke.13;
        Sun, 29 Jul 2018 04:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pJ8JyHMqIYr/gindlb/Z2FeLEKJwg4/vhsvy92c/6yU=;
        b=c6aroWsK7eFqgJcEgKi2mXyulOcRkhIV3FrLqab+qqg+i6W2SVt7lJt0uAiUrYkQBU
         FM1bEh28Bi9pYqeub/akcQrN1yZuULabxofD7nG1hhggtap5X032VkNmXA+w73KWnh+R
         L83Jd3wicmT+5R44kP9EcBIFZDc5gMmMmtNcowg3v75ar/3YNmluwyZ9mZmz4WL6Ei9b
         cTihpt53rryct84wSmYcYYiwWhkqfACOZJicsRvQO1zGgAxHwnXlLOOpeKHS9iN3jWz1
         Kqdx6NBV32yY6a24tFv1PTXXZJE+8gi1wxXmiH8cNMDQSND4nTnVL42/3938lyqQTGIy
         gr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pJ8JyHMqIYr/gindlb/Z2FeLEKJwg4/vhsvy92c/6yU=;
        b=ahLykliAQ1ucRdxKOY4jOWT2CGC1QBneORBMwwq3W+MOiFv1jfPCuAt4VrafT3ioZj
         SD63qT4ENCzrnWweXp4PSo5Ae4eqraEX2FVOBzW9mO2jjgkPknk8339CcxokZGMnh8KI
         YYwgyRslwr3qMiTkYDDrLQvKt3m/4rTa/m+PDMIihdX0975vXUqfyGG+iQIMn57DH7li
         SMZvGXa9U9piih7ueeftdtwLN+mEhm30MLKxup90b0jsPSxG0tdgf13ezkuDQGOPtAX8
         /gqvLOASsjH8s5oRWzB3OIWgyCmYWEWOmFvFrKXVe5nWwvFlS+mrWAKNUesvm+p3iOs4
         CDaw==
X-Gm-Message-State: AOUpUlExSnK1zX7XnNOaev6pVWn7o8N4gRdYT3qt3FBr4azZ3+X9epEo
        z/uneXHAroYPgigoa7MHVZbRxvdjR2Cg2HUY2BQ=
X-Google-Smtp-Source: AAOMgpfASYAFjLZiuXu3UWi762Tv6YSQhHihrb/7cNcjsFZmo360oDvPLqefikYmzpZVPPQrnEWHj4CgwRmiF5LHrIM=
X-Received: by 2002:a1f:b503:: with SMTP id e3-v6mr8573653vkf.97.1532863642121;
 Sun, 29 Jul 2018 04:27:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 04:27:21
 -0700 (PDT)
In-Reply-To: <20180729091449.385951-3-tali.perry1@gmail.com>
References: <20180729091449.385951-1-tali.perry1@gmail.com> <20180729091449.385951-3-tali.perry1@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 29 Jul 2018 14:27:21 +0300
Message-ID: <CAHp75VdKhSbAj5c_41Xm1zWDnmTnaQjCMKXQ_7Lxfz03Ktft9A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] i2c: npcm7xx: add i2c controller master mode only
To:     Tali Perry <tali.perry1@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        pierre-yves.mordret@st.com, cedric.madianga@gmail.com,
        Baolin Wang <baolin.wang@spreadtrum.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        rmk+kernel@armlinux.org.uk,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 12:14 PM, Tali Perry <tali.perry1@gmail.com> wrote:
> Nuvoton NPCM7XX I2C Controller
> NPCM7xx includes 16 I2C contollers. THis driver operates the controller.
> This module also includes a slave mode, which will be submitted later on.
>
> Any feedback would be appreciated.

Too much lines of code as for I2C driver.

Briefly looking it seems it doesn't utilize what kernel already has
(e.g. crc8 already is in kernel library) and doesn't follow modern
style of drivers there.

> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/jiffies.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/clk/nuvoton.h>
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>

Just wow. Are you sure you need all of them? (Also, to see better what
it's used, keep them in order)

> +#define ENABLE 1
> +#define DISABLE        0

So, what's wrong with 1, 0 or true, false?

> +#define _1Hz_          (u32)1UL
> +#define _1KHz_         (1000 * _1Hz_)
> +#define _1MHz_         (1000 * _1KHz_)
> +#define _1GHz_         (1000 * _1MHz_)

If you need such constants it would be something like for time periods we have

HZ_PER_KHZ 1000
HZ_PER_MHZ 1000000

etc.

I saw in a code some of those predefined. If they are not yet generic
(in scope of kernel) it might be worth to do in the future.

> +#ifndef ASSERT
> +#ifdef DEBUG
> +#define ASSERT(cond)  {if (!(cond)) for (;;) ; }
> +#else
> +#define ASSERT(cond)
> +#endif
> +#endif

Hmm... In production code?!

> +
> +#define ROUND_UP(val, n)       (((val)+(n)-1) & ~((n)-1))
> +#define DIV_CEILING(a, b)       (((a) + ((b)-1)) / (b))


You really need to check what kernel provides.

> +#define I2C_DEBUG2(f, x...)

???

> +
> +
> +
> +

Why to have so many blank lines?

> +
> +

Ditto.

> +// Common regs
> +#define NPCM7XX_SMBSDA(bus)            (bus->base + 0x000)
> +#define NPCM7XX_SMBST(bus)             (bus->base + 0x002)
> +#define NPCM7XX_SMBCST(bus)            (bus->base + 0x004)
> +#define NPCM7XX_SMBCTL1(bus)           (bus->base + 0x006)
> +#define NPCM7XX_SMBADDR1(bus)          (bus->base + 0x008)
> +#define NPCM7XX_SMBCTL2(bus)           (bus->base + 0x00A)
> +#define NPCM7XX_SMBADDR2(bus)          (bus->base + 0x00C)
> +#define NPCM7XX_SMBCTL3(bus)           (bus->base + 0x00E)
> +#define NPCM7XX_SMBCST2(bus)           (bus->base + 0x018)  // Control Status 2
> +#define NPCM7XX_SMBCST3(bus)           (bus->base + 0x019)  // Control Status 3
> +#define SMB_VER(bus)                   (bus->base + 0x01F)  // SMB Version reg

Usually we put just numbers here and use custom I/O accessors which
take bus as a parameter.

> +
> +// BANK 0 regs
> +#define NPCM7XX_SMBADDR3(bus)          (bus->base + 0x010)
> +#define NPCM7XX_SMBADDR7(bus)          (bus->base + 0x011)
> +#define NPCM7XX_SMBADDR4(bus)          (bus->base + 0x012)
> +#define NPCM7XX_SMBADDR8(bus)          (bus->base + 0x013)
> +#define NPCM7XX_SMBADDR5(bus)          (bus->base + 0x014)
> +#define NPCM7XX_SMBADDR9(bus)          (bus->base + 0x015)
> +#define NPCM7XX_SMBADDR6(bus)          (bus->base + 0x016)
> +#define NPCM7XX_SMBADDR10(bus)         (bus->base + 0x017)

> +#define NPCM7XX_SMBADDR(bus, i)        (bus->base + 0x008 + \
> +       (u32)(((int)i * 4) + (((int)i < 2) ? 0 : \
> +       ((int)i - 2)*(-2)) + (((int)i < 6) ? 0 : (-7))))

It's rather complicated.

> +       // Current state of SMBus

I guess more compact is to put a kernel doc descriprion.

> +       enum smb_state          state;


> +static bool NPCM7XX_smb_init_module(struct NPCM7XX_i2c *bus,
> +                                   enum smb_mode mode, u16 bus_freq);

Do you need all forward declarations? Why?


So, I stopped here.

Try to make your code twice less in a lenght (looking at it I think
it's doable).


> +static const struct of_device_id NPCM7XX_i2c_bus_of_table[] = {
> +       { .compatible = "nuvoton,npcm750-i2c-bus", },

> +       {},

Slightly better without comma for terminator lines.

> +};
> +MODULE_DEVICE_TABLE(of, NPCM7XX_i2c_bus_of_table);

-- 
With Best Regards,
Andy Shevchenko
