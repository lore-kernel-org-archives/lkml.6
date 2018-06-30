Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC83C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2AD24D5C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5AAeuzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2AD24D5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936987AbeF3MOn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 08:14:43 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38982 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936201AbeF3MOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 08:14:39 -0400
Received: by mail-ua0-f196.google.com with SMTP id n4-v6so7397541uad.6;
        Sat, 30 Jun 2018 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zq6VXt2bfARvl22I/S/0Ilegom0XCF2UdbkMBhJED5M=;
        b=I5AAeuzia5dEkCDeiaX1/+INHOg8caOEwgj+GKRlyU8/gkHv/5TNqoO6Ixav8IvXrt
         cXkdrViWeDVnQBO8RquV+B+n8UsIYh30fvg+JpGPmIyU3EPP+429WTHHzvWkAdTNCc4d
         BWL66lf71t7AxMEyN/df7uthfHwxkmUbJsVvYag5RKNKH25KfDV39rPF5PGfv5X5uX8O
         W6HEUbZKCgLmRT1IiPpnzQVGg4Ukja8ozMlCCWcm3DCt5AqaGbzEjPOMkb4ZXjwO5iLA
         uLlUshMB75fXoXTiIaEx9fQQ3F4ed4WioxKChXaxQNHOIS9xA5qI3Q18Xdr0jWZYHGwv
         jwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zq6VXt2bfARvl22I/S/0Ilegom0XCF2UdbkMBhJED5M=;
        b=e0oVTItQ8KDCGW3C/jJ1Tqdp0WLxtRoMsSAS21/55b3Burt+0dubATYbQHOYwlDj8f
         MvgKVlUCU961+BzK5GNBtDxA52vFUFptVhL7WHk+6wwo7hKWePHApea1221LV9RmX0wn
         tkXTSSjnMTDKAdNdIQTp3rHh/XgHHCxeVOD4OYGhh7dYeLMT5k+fEFamHNSmIPFfzhQv
         Xn89/K73Cjg8cToc/VQmQBWJX99WhBeeouglCsZpDw3HnqnPTMURAK3HUYih88+9ChCa
         qr+X5DPm2e+pgsM9NN5MbfLvNhaYBK5YGaSlYTKW5ArDItmiHluALDK9Nc03I6Mm4fnq
         mJ4A==
X-Gm-Message-State: APt69E0wDP5p8J2aMRWB/oCtct9r+z+7tEQfRn04J++C9Gti6RY2NcCh
        Ixx2DKnrg23waPRUSF3BnViJZ8gtN+n+0YR0nqfBk8yS
X-Google-Smtp-Source: AAOMgpcEggWh5J9U8Pi0xo1eZZ+UOBKbwcHCTVWiVpvNw0T8bJAhK+eR7bO5eHuQesam+JO5+kB3hoPjDcqVBH2mjus=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr11937705uad.49.1530360878188;
 Sat, 30 Jun 2018 05:14:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 05:14:37
 -0700 (PDT)
In-Reply-To: <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org> <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jun 2018 15:14:37 +0300
Message-ID: <CAHp75Vd__qOXVxZTdxREwD6p1sEw49R2Kqb+esAmr_EhtT=gFg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] i2c: Add Actions Semi OWL family S900 I2C driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        Thomas Liau <thomas.liau@actions-semi.com>,
        jeff.chen@actions-semi.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 9:10 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add Actions Semi OWL family S900 I2C driver.

> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

> +#include <linux/io.h>

Perhaps keep in order?

> +#define OWL_I2C_DEFAULT_SPEED  100000
> +#define OWL_I2C_MAX_SPEED      400000

..._SPEED -> ..._SPEED_HZ ?

DEFAULT -> DEF ?

> +static int owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
> +{
> +       unsigned int val, timeout = 0;
> +
> +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +                               OWL_I2C_CTL_EN, false);

> +       mdelay(1);

1 ms keeping CPU busy for nothing. Perhaps usleep_range() / msleep()?
Is it called in atomic context?

> +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +                               OWL_I2C_CTL_EN, true);
> +
> +       /* Reset FIFO */
> +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +                               OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR,
> +                               true);
> +
> +       /* Wait 50ms for FIFO reset complete */
> +       do {
> +               val = readl(i2c_dev->base + OWL_I2C_REG_FIFOCTL);
> +               if (!(val & (OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR)))
> +                       break;

> +               mdelay(1);

Ditto.

> +       } while (timeout++ < OWL_I2C_MAX_RETRIES);

OK, I see you call it from IRQ context. 50ms for IRQ handler is
inappropriate. (1ms either, but at least not so drastically).

> +}

> +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> +{

> +       stat = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> +       if (stat & OWL_I2C_STAT_BEB) {
> +               dev_dbg(&i2c_dev->adap.dev, "bus error");

> +               owl_i2c_reset(i2c_dev);

This is questionable to be here (looking at so loong delays in it).

> +               goto stop;
> +       }

> +       return IRQ_HANDLED;
> +}

> +static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +                               int num)
> +{

> +       int ret = 0, idx;

Redundant assignment.

> +       ret = owl_i2c_hw_init(i2c_dev);
> +       if (ret)
> +               return ret;

> +}

> +static const struct i2c_algorithm owl_i2c_algorithm = {
> +       .master_xfer    = owl_i2c_master_xfer,

> +       .functionality  = owl_i2c_func

Slightly better to keep comma at the end

> +};
> +
> +static const struct i2c_adapter_quirks owl_i2c_quirks = {
> +       .flags          = I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
> +       .max_read_len   = 240,
> +       .max_write_len  = 240,
> +       .max_comb_1st_msg_len = 6,
> +       .max_comb_2nd_msg_len = 240

Ditto.

> +};

-- 
With Best Regards,
Andy Shevchenko
