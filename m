Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54981C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018B32086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M66Q42DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018B32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeKGQvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 11:51:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41218 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeKGQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 11:51:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so10724017lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 23:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E/QYVRqWatiPsHyhF/045rmlvu0p5kMoyiWwvimmKNM=;
        b=M66Q42DVZ3ZeZQoaPZ1KDKD1qjRpHs/9gaF2pEnvYi6aV7K+cm3zyuIuRycsnaQ7uL
         vAZuRUdXLBZBqqu39sKYAlrnGc7ZPItxSgn5e+7BfrAJzYd60jjGQxEVObWqlb/eRYiw
         WvIAQmXYzOJ18aVBMveS94+K17vvTim4RB0ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E/QYVRqWatiPsHyhF/045rmlvu0p5kMoyiWwvimmKNM=;
        b=YaBfWZejg1bG53n5FXdDzSh62X9f637tLBjwZqtdE+gfnp9i3KFFIyU9JzbWD8uSHw
         88hINX8bSY16OsgtdbAjUfROgqONt/XUjvD3XSQW1kdoU+/jMwLhvi1uWqbx++J27P8O
         2lXVLeVCpt5hAO4e3nOf9F/GI2guVWPxiTe8ClSt730rVqzBnMu850kQ82KgDeX9Pco4
         zYndVB8M04wP8Z1fvuykGs5fjj51MuTVayLbzKMX9FwzDMvJDfbQbUMG0/k6hG2OYKL7
         2sBG0wZkwElp4lec6MmUIkvhvnf/sy3i51cr4dwTSChmegooXv6MPrTo4DY6Os2xbryr
         OmNA==
X-Gm-Message-State: AGRZ1gIsvB7ZSf4a4XTuUlKS6AwYziCjRMoDIvjD9kxOKk98mMLNYBrj
        WPk8OSQTl5wthySUbTLBy5ONbP7sUkEv0A5bSAl5+Q==
X-Google-Smtp-Source: AJdET5dh7pa+dt84VoOoyjiRzM2ieqgVzLb/06qKO+FMToBS8SFpspAx/zHBWCp03NiWwoBfjbmva8K24h90Bp+Kz5M=
X-Received: by 2002:a19:2203:: with SMTP id i3mr500702lfi.2.1541575366152;
 Tue, 06 Nov 2018 23:22:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:95ca:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 23:22:45 -0800 (PST)
In-Reply-To: <1541542052-10081-7-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com> <1541542052-10081-7-git-send-email-jacek.anaszewski@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 7 Nov 2018 15:22:45 +0800
Message-ID: <CAMz4kuL9r7pOiqVm9vD4G0AOXe6_UN2nTGmCchp=TVy98XLWJw@mail.gmail.com>
Subject: Re: [PATCH 06/24] leds: sc27xx-blt: Use led_compose_name()
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh@kernel.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 7 November 2018 at 06:07, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
> Switch to using generic LED support for composing LED class
> device name.
>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>

Thanks for simplifying the code, it can work well for SC27XX LED.
Tested-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/leds/leds-sc27xx-bltc.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
> index 9d9b7aa..9fe7cb1 100644
> --- a/drivers/leds/leds-sc27xx-bltc.c
> +++ b/drivers/leds/leds-sc27xx-bltc.c
> @@ -6,7 +6,6 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> -#include <uapi/linux/uleds.h>
>
>  /* PMIC global control register definition */
>  #define SC27XX_MODULE_EN0      0xc08
> @@ -36,7 +35,7 @@
>  #define SC27XX_LEDS_MAX                3
>
>  struct sc27xx_led {
> -       char name[LED_MAX_NAME_SIZE];
> +       struct fwnode_handle *fwnode;
>         struct led_classdev ldev;
>         struct sc27xx_led_priv *priv;
>         u8 line;
> @@ -132,16 +131,22 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
>
>         for (i = 0; i < SC27XX_LEDS_MAX; i++) {
>                 struct sc27xx_led *led = &priv->leds[i];
> +               struct led_init_data init_data = { led->fwnode };
>
>                 if (!led->active)
>                         continue;
>
> +               err = led_compose_name(led->fwnode, "sc27xx", ":",
> +                                      init_data.name);
> +               if (err)
> +                       return err;
> +
>                 led->line = i;
>                 led->priv = priv;
> -               led->ldev.name = led->name;
>                 led->ldev.brightness_set_blocking = sc27xx_led_set;
>
> -               err = devm_led_classdev_register(dev, &led->ldev);
> +               err = devm_led_classdev_register_ext(dev, &led->ldev,
> +                                                    &init_data);
>                 if (err)
>                         return err;
>         }
> @@ -154,7 +159,6 @@ static int sc27xx_led_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct device_node *np = dev->of_node, *child;
>         struct sc27xx_led_priv *priv;
> -       const char *str;
>         u32 base, count, reg;
>         int err;
>
> @@ -196,15 +200,8 @@ static int sc27xx_led_probe(struct platform_device *pdev)
>                         return -EINVAL;
>                 }
>
> +               priv->leds[reg].fwnode = of_fwnode_handle(child);
>                 priv->leds[reg].active = true;
> -
> -               err = of_property_read_string(child, "label", &str);
> -               if (err)
> -                       snprintf(priv->leds[reg].name, LED_MAX_NAME_SIZE,
> -                                "sc27xx::");
> -               else
> -                       snprintf(priv->leds[reg].name, LED_MAX_NAME_SIZE,
> -                                "sc27xx:%s", str);
>         }
>
>         err = sc27xx_led_register(dev, priv);
> --
> 2.1.4
>



-- 
Baolin Wang
Best Regards
