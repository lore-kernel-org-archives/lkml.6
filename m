Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A614C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 21:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE362530F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 21:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp7DWYEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE362530F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeF3VLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 17:11:05 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38456 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbeF3VLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 17:11:01 -0400
Received: by mail-ua0-f193.google.com with SMTP id 59-v6so7882914uas.5;
        Sat, 30 Jun 2018 14:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S6W4rNccygV7hsh0F7O5I+PYoxZ2/somAtUq43BzwSU=;
        b=Sp7DWYEYB9E5MZ7wG1KyUuOIAS6oqmCZBcQDoHrKfw+hLuuuNoaWo5zvJo74Nn0W6s
         EcTC7KlG9nExjtJjAsstVQFbJ6OZK9SPstOyoOYtRtu8Q9+srd24J6am5E6UfqyKqU1m
         No4cag9mobGC9PtA9Wsy+lkRJIKdozLXVmvUUgJJMas4Pgh900V+WpUa9apXs28Exixt
         BbkRmEyJ0YncvfyA7yaUne20Rzdx+OZqXl+kW2mFxvxOyE39SYVsdxqCeRs+g+EM62OS
         EmOdoHC5cMItHMZMr5ORq4qBaDOgO0PoRIQlTYq4qNjMZIkV/5MkP/hgqYuRLAZQcjNJ
         a0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S6W4rNccygV7hsh0F7O5I+PYoxZ2/somAtUq43BzwSU=;
        b=bcxEZwVcZLTkL0xRcwGgOf9zMByOxufmZvj9NMvQFVAn72eQ3AcXc2H2u0job5aTB1
         jX25elcBdi3e01txiK9vNb+p/Tzw2pJKR2NMJnOACRu3Ru3zaq3dANh93iqIintQC+um
         4wHZSzooUSpySNxVEUb8q6JhwCViB88S7h3+tAX2EaG+990tkw2nyD9LXLj8UQDT6ju0
         ietl7xfIIocm6uZOf8fj/ZOJASMOOEamJDXDJJRtHSMqD4TYcXWItUUUxsf5LQdw3bul
         tNtetyylqSKSXvUu4SdF+d4o7Gqo0+uDODRjsoyKXgD6Vgp5AW6XVQ0SEGj6VP/PgtUQ
         DqWw==
X-Gm-Message-State: APt69E2uT9K+/mvR25FFajVNu4Et8KAJrvW6Q3eF6Dricv1FMKdRB/Ko
        gb/worAYCrqLUtwAN1d3HTv9G6nDoyQcd1S3Ng8=
X-Google-Smtp-Source: AAOMgpejk4mBDwwtfb7n7AN81Xi2T+II75okMGyZKgMRWpOWliF9lVCOkTwktiFxY0Uq2bM2/sDRFAUdI+q4j+9FiXs=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr12310732uae.199.1530393061003;
 Sat, 30 Jun 2018 14:11:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 14:11:00
 -0700 (PDT)
In-Reply-To: <20180630133330.23858-6-manivannan.sadhasivam@linaro.org>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org> <20180630133330.23858-6-manivannan.sadhasivam@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 1 Jul 2018 00:11:00 +0300
Message-ID: <CAHp75VcVNb51tJzKbCU3pqf0XYPCUZWpv38nfaV1711vyf2S0Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C driver
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

On Sat, Jun 30, 2018 at 4:33 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add Actions Semiconductor Owl family S900 I2C driver.

Thanks for an update. Few left comments and it would LGTM.

> +static int owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
> +{

> +       mdelay(1);

But now, since it's not used in atomic context, we may switch to
usleep_range() / msleep() instead.

> +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +                               OWL_I2C_CTL_EN, true);
> +

> +       /* Wait 50ms for FIFO reset complete */
> +       do {

> +               mdelay(1);

Especially in this case it's very important.

> +       } while (timeout++ < OWL_I2C_MAX_RETRIES);

> +}

> +       val = (i2c_dev->clk_rate + i2c_dev->bus_freq * 16 - 1) /
> +                               (i2c_dev->bus_freq * 16);

This is effectively DIV_ROUND_UP(->clk_rate, ->bus_freq * 16).

> +       /*
> +        * By default, 0 will be returned if interrupt occurred but no
> +        * read or write happened. Else if msg_ptr equals to message length,
> +        * message count will be returned.
> +        */

> +       if (i2c_dev->msg_ptr == msg->len)
> +               ret = num;

I dunno if

ret = ->msg_ptr == len ? num : 0;

would be slightly more explicit (yes, I aware about ret == 0).

Up to you to choose.

> +       /* We support only frequencies of 100k and 400k for now */
> +       if (i2c_dev->bus_freq != OWL_I2C_DEF_SPEED_HZ &&
> +                       i2c_dev->bus_freq > OWL_I2C_MAX_SPEED_HZ) {

I think it should be != in the second case as well.

> +               dev_err(dev, "invalid clock-frequency %d\n", i2c_dev->bus_freq);
> +               return -EINVAL;
> +       }

-- 
With Best Regards,
Andy Shevchenko
