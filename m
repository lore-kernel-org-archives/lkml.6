Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35787C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD98020863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIAdL4bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD98020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeLAJdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:33:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42502 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:33:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id m5so4098389qka.9;
        Fri, 30 Nov 2018 14:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44OpprV4h0nRAiXZ3jQY29UAXQttTMsAEP4d0/lSb48=;
        b=nIAdL4bYZxwM12bqcs59Y7Dtp6QqhGsjudua2GJ8GxP6Nvb1ajAvqo/lHF37IOxivd
         w5XGv89B6wFKUYI/q3IvGBT9ioF7YavByFBGXNbfNr6kVUcNee3fgDx6JGcEG6fOTYoL
         WeVYXioqAYDHBm9O1qATp9UhbXl+0z+YhRRxuk1PrvvHz5jyCmZ2aCWllDBlGusdjNt/
         9LxF6jCrJqwSIDeETYcuzEzfgEJd0nHBxeCmjBKOnQfAmB3FrHoKbTKqIB91kEUVU+9/
         LDkPd6GBAjKfGl26t8z7fKhAimJWRzOBjIdUErpoxx1RcRCdge0Oom4yw2/D3DPkPVDm
         xe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44OpprV4h0nRAiXZ3jQY29UAXQttTMsAEP4d0/lSb48=;
        b=aKV3974cVSeEB//GmLeYtoyrzIRo2yaQN5Sz6iPuWMnhaRzxZ1/yotr94qLX+lXfq5
         i4Vd0jZ6tmYSQfuYeNFWOevcIwY27YUH4b+ku8xSzn4fcUF+xD8JHmTAuqOVqXUE7r9B
         pmoPi2Z9hNv1KO+kUjH7S2RMab1Gap3G5ypcSAQtYyk2wbP8SlPUY/JcQJrbIHvleRvd
         2YX4bgTaLy4FqcMnTINGtZfMXkqedLkH7VjMn6SpNvAh+lSaVTuhteCV5uVa4I1LBLxe
         v87Vny2l81z+5jyQEE+kfpNHY00m6cc6QMcdvoqzGB+Uu5yeHUqOuVR5Ef3LS/vBANJP
         ILzg==
X-Gm-Message-State: AA+aEWYHGTsBzc3Qd8ft3nXnoDZc+V9UjdMNlfgPPvgSM3WTqt2KC5qR
        imk2jIyr1L9xGEtQdsd8Lqba98GUPXMQdQn80uA=
X-Google-Smtp-Source: AFSGD/UBvMCxxZpWUkkncP89hZ6QTVg4q0Uiv5MD1NKGyf6FZJEJzjy7jvYGx52mAdlrdaB1Ctw/rdLxXi9a3vH4328=
X-Received: by 2002:a37:b405:: with SMTP id d5mr6777307qkf.162.1543616536633;
 Fri, 30 Nov 2018 14:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20181107085507.26126-1-enric.balletbo@collabora.com>
In-Reply-To: <20181107085507.26126-1-enric.balletbo@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 30 Nov 2018 23:22:05 +0100
Message-ID: <CAFqH_53NiYULqcc+2fCgbHETJoTc7tWD8BNxOFhPm6kFZ=e6_g@mail.gmail.com>
Subject: Re: [PATCH v3] backlight: pwm_bl: Fix brightness levels for non-DT case.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        robert.jarzmik@free.fr,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        stable@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
dia dc., 7 de nov. 2018 a les 9:56:
>
> Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye")' allows the possibility to compute a default
> brightness table when there isn't the brightness-levels property in the
> DT. Unfortunately the changes made broke the pwm backlight for the
> non-DT boards.
>
> Usually, the non-DT boards don't pass the brightness levels via platform
> data, instead, it sets the max_brightness in their platform data and the
> driver calculates the level without a table. The offending patch assumed
> that when there is no brightness levels table we should create one, but this
> is clearly wrong for the non-DT case.
>
> After this patch the code handles the DT and the non-DT case taking in
> consideration also if max_brightness is set or not.
>
> Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> Cc: <stable@vger.kernel.org>
> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Changes in v3:
> - Fixed some typos in commit message.
> - Removed ' in Fixes tag.
>
> Changes in v2:
> - Rebase on top of mainline
> - Add Tested-by and Acked-by tags.
>
>  drivers/video/backlight/pwm_bl.c | 41 +++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 678b27063198..f9ef0673a083 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -562,7 +562,30 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>                 goto err_alloc;
>         }
>
> -       if (!data->levels) {
> +       if (data->levels) {
> +               /*
> +                * For the DT case, only when brightness levels is defined
> +                * data->levels is filled. For the non-DT case, data->levels
> +                * can come from platform data, however is not usual.
> +                */
> +               for (i = 0; i <= data->max_brightness; i++) {
> +                       if (data->levels[i] > pb->scale)
> +                               pb->scale = data->levels[i];
> +
> +                       pb->levels = data->levels;
> +               }
> +       } else if (!data->max_brightness) {
> +               /*
> +                * If no brightness levels are provided and max_brightness is
> +                * not set, use the default brightness table. For the DT case,
> +                * max_brightness is set to 0 when brightness levels is not
> +                * specified. For the non-DT case, max_brightness is usually
> +                * set to some value.
> +                */
> +
> +               /* Get the PWM period (in nanoseconds) */
> +               pwm_get_state(pb->pwm, &state);
> +
>                 ret = pwm_backlight_brightness_default(&pdev->dev, data,
>                                                        state.period);
>                 if (ret < 0) {
> @@ -570,13 +593,19 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>                                 "failed to setup default brightness table\n");
>                         goto err_alloc;
>                 }
> -       }
>
> -       for (i = 0; i <= data->max_brightness; i++) {
> -               if (data->levels[i] > pb->scale)
> -                       pb->scale = data->levels[i];
> +               for (i = 0; i <= data->max_brightness; i++) {
> +                       if (data->levels[i] > pb->scale)
> +                               pb->scale = data->levels[i];
>
> -               pb->levels = data->levels;
> +                       pb->levels = data->levels;
> +               }
> +       } else {
> +               /*
> +                * That only happens for the non-DT case, where platform data
> +                * sets the max_brightness value.
> +                */
> +               pb->scale = data->max_brightness;
>         }
>
>         pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
> --
> 2.19.1
>

A gentle ping on this patch.

Best regards,
 Enric
