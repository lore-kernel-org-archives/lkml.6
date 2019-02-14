Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6E4222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi+Lc3uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393832AbfBNCI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:08:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36809 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390663AbfBNCI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:08:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so2246654plo.3;
        Wed, 13 Feb 2019 18:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqYfEH64IOFbjwkOLrTJ0jj4O4a1BShN3J3LGce0xUE=;
        b=Mi+Lc3ujQy+qTKLeIlsm0WWchoDh8LWoaTv8ohwq4ZiNwsqFEe4QTE8Gtq43bQb99s
         VVlvELNSjZcugoFktv9N/7aRd6Dyunt/DiFzh31JYGRtFJGnAgaq7QTB7K5ttjl0OJT+
         aBBoIzi/wsGJfSEYEeQiOQ1wm188sSS0lIdU87JI92Lz7GX2uUxVAxdIIMPKSJJG2JsX
         WZHWvjjGy2TJ7iD1Iv4kYqisuCt62zGq26TREYjf6AsG0IUlsE60GXMA5QNCXGlGh02G
         Rv+p/qwltGIDPs9KlNBLm8h4Ptm338crrhlABfX64SFQPQjCYy6IYrKL0qri9zeBCBaQ
         eZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqYfEH64IOFbjwkOLrTJ0jj4O4a1BShN3J3LGce0xUE=;
        b=N+Rv4hU/VTCGyPDQqB35/LNI0U97/BRdBU5CyZK9H0zBVy88Eohn3YLLVCJBd7IkVK
         PSmTowHcuj+pebBmpbxbpwZodZQhOnNkMrqJdx8ZC2WL1ESdNlaAq4hrWMthzuGv4qdK
         Tu0ykm8PtZbN53Hcnd+68moLuj1weqGOAwmzD4uNSBpSbD9IVJsBdyFQSeynPnU2lNW9
         +WbGKWBp3Imf9KVpOfh73KzcYZYaQSl3VVYOM0aq+wqM8GNY5R+LNWnM/JOEMdJ7PhWz
         KemizK3a89yZVNYPkXuwF5UZ2gNHqADlB/xe5kWjjc4mwx9KPEGCpgoWKvvbYwJuAaHL
         O4Mw==
X-Gm-Message-State: AHQUAubG+q6FTq2HpWBueE1uMoVBjlGmhk2Uzcv8oWDbo7UZTNgaEmaS
        w6yPV/AlGXIDikyl78Sx/be9s/KFb66BpV2eOZU=
X-Google-Smtp-Source: AHgI3IZyX1ByBqjgUIulEJbxP82x+o8VgNXC1WCFmVzJ9mTYEjEFTxZKCivwg+YSX80nohrxhkUc7t+WnYWdpdo0e8A=
X-Received: by 2002:a17:902:a50e:: with SMTP id s14mr1462711plq.311.1550110136158;
 Wed, 13 Feb 2019 18:08:56 -0800 (PST)
MIME-Version: 1.0
References: <1550091448-28578-1-git-send-email-info@metux.net> <1550091448-28578-2-git-send-email-info@metux.net>
In-Reply-To: <1550091448-28578-2-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Feb 2019 04:08:44 +0200
Message-ID: <CAHp75VeUEtRnRyJfpRC9Pdjy4ji=EMk=QQJ8gk7RpX6SsLg9Qg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: AMD G-Series PCH gpio driver
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:57 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

Thanks for this version, my comments below.

>
> GPIO platform driver for the AMD G-series PCH (eg. on GX-412TC)
>
> This driver doesn't registers itself automatically, as it needs to
> be provided with platform specific configuration, provided by some
> board driver setup code.
>
> Didn't implement oftree probing yet, as it's rarely found on x86.

Since I don't see neither changelog nor version of the series, it's
hard to say what had been changed and addressed.

> +static void *amd_fch_gpio_addr(struct amd_fch_gpio_priv *priv,
> +                              unsigned int gpio)
> +{

> +       if (unlikely(gpio > priv->pdata->gpio_num)) {
> +               dev_err(&priv->pdev->dev,
> +                       "gpio number %d out of range\n", gpio);
> +               return NULL;
> +       }

I'm pretty sure this wouldn't be the case.

> +
> +       return priv->base + priv->pdata->gpio_reg[gpio]*sizeof(u32);
> +}

> +       if (unlikely(!ptr))
> +               return -EINVAL;

Neither those ones.

> +       spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
> +
> +       if (value)
> +               writel_relaxed(readl_relaxed(ptr) | AMD_FCH_GPIO_FLAG_WRITE,
> +                              ptr);
> +       else
> +               writel_relaxed(readl_relaxed(ptr) & ~AMD_FCH_GPIO_FLAG_WRITE,
> +                              ptr);

This will look better in usual pattern, i.e.

u32 value;

...
value = readl...
if (...)
 ...
else
 ...
writel...

> +static int amd_fch_gpio_request(struct gpio_chip *chip,
> +                               unsigned int gpio_pin)
> +{
> +       if (likely(gpio_pin < chip->ngpio))
> +               return 0;
> +
> +       return -EINVAL;
> +}

Can't be generic request routine used?

> +
> +static int amd_fch_gpio_probe(struct platform_device *pdev)
> +{
> +       struct amd_fch_gpio_priv *priv;
> +       struct amd_fch_gpio_pdata *pdata;

> +       struct resource res = DEFINE_RES_MEM_NAMED(
> +                               AMD_FCH_MMIO_BASE + AMD_FCH_GPIO_BANK0_BASE,
> +                               AMD_FCH_GPIO_SIZE,
> +                               "amd-fch-gpio-iomem");

Define this outside the function as static variable.

> +
> +       pdata = dev_get_platdata(&pdev->dev);

> +

Redundant blank line.

> +       if (unlikely(pdata == NULL)) {

Simple if (!pdata)

> +               dev_err(&pdev->dev, "no platform_data\n");
> +               return -ENOENT;
> +       }
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);

> +

Redundant blank line.

> +       if (unlikely(priv == NULL))

This check is simple

if (!priv)

> +               return -ENOMEM;
> +

> +       spin_lock_init(&priv->gc.bgpio_lock);
> +
> +       priv->base = devm_ioremap_resource(&pdev->dev, &res);
> +       if (IS_ERR(priv->base))

> +               return -ENXIO;

Do not shadow error code.

> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
> +}



-- 
With Best Regards,
Andy Shevchenko
