Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7525BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D702087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWVj5/ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfBYCWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:22:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34667 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBYCWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:22:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id l5so6035880lje.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 18:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3GBjxHt0HsvvkXB9c6nrOu934T2gMILKR5cfwm5BmE=;
        b=aWVj5/jiPXZRvU5s0zoWRWvYVYISJ+bZtphhzMuSSRefylIe1TaGdRH/jXpHuQtdF+
         F/G9K0hlPXANDLgp/Juhw+8xJQ38oX7qqcDnBfeEICooGHAYRxnz5nLydZ4sVzTI2D/G
         EA854jH4PuPhYyntpA1YuoR31uoMfWv53gR2ZkCfDsdcyVUzas02HqECdM5ruIzW+O64
         d5pMVPf6kOkl4JNLy8+8M63s7UKAUm3ZoQ6We4shr9FXTU+VCN08U/ib7RchHRIQbzPY
         dpWJ/+FCuCT3y3QHcQW5ALqMHY3XAvDlKhs54apUqzKlY9811cpVcnUF/1xlx7Fp4CJ1
         r6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3GBjxHt0HsvvkXB9c6nrOu934T2gMILKR5cfwm5BmE=;
        b=VZXhtr5sJB5LcFdN0hDGKbm53STLAFeQuUTKRO+FMiFTBJxYcoGtnvgQY0hJzkFw+8
         8uCObZUnteqOACZfF1pLqROi1QZvSVQ7UfaZ9LghMQwu5n6vYsh4GFvycqTjkD6QqdU7
         ywfNkwG5Ifq4V/bCcOnjx31f6D0Fj32oGbW/kUjYY7aqR/xa8bhQcQu+a4/h3ieJQ7m+
         iy9piy0ydfi3cynDYpmCdAJMeSojW4lXnUontbBN8mKzTgeVkiEREdWn4QjkseQ5aFE2
         u+2NZIgM/BjSfEBGMxWAcNQPJwJJO5uPjsnjynvyugkBHt1Lw+r1UDr2e8FBYlK2NjOQ
         r9tQ==
X-Gm-Message-State: AHQUAuY0ixBBNiPy5DCD4/VJqXrjBPp+rsz6a93Zh7L6uzQns2Hlc09S
        bF1tLSgUMCuM49BjogmE16nugQ/Q8br1rkehxHkP3w==
X-Google-Smtp-Source: AHgI3IZ+u//lqi/OyUmqrDM3WZXkJWdJRCvtfPWb9szWij6zKIWSnfwR6T2+zHj18CYdipywYVlDC2oGYhE8ldQUZjs=
X-Received: by 2002:a2e:3807:: with SMTP id f7mr8519709lja.9.1551061358090;
 Sun, 24 Feb 2019 18:22:38 -0800 (PST)
MIME-Version: 1.0
References: <3d1f18412a927f69c733b6ed31659b7770610442.1550062410.git.baolin.wang@linaro.org>
In-Reply-To: <3d1f18412a927f69c733b6ed31659b7770610442.1550062410.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 25 Feb 2019 10:22:26 +0800
Message-ID: <CAMz4kuLqjqF3LCYKH1_BjQPnikNe6pd2T3HmgpBwoR0nYP=Wqg@mail.gmail.com>
Subject: Re: [PATCH] mfd: sc27xx: Use SoC compatible string for PMIC devices
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Wed, 13 Feb 2019 at 20:57, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> We should use SoC compatible string in stead of wildcard string for
> PMIC child devices.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Could you apply this patch if you have no other issues? Thanks.

>  drivers/mfd/sprd-sc27xx-spi.c |   42 ++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index 69df277..43ac716 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -53,67 +53,67 @@ struct sprd_pmic_data {
>  static const struct mfd_cell sprd_pmic_devs[] = {
>         {
>                 .name = "sc27xx-wdt",
> -               .of_compatible = "sprd,sc27xx-wdt",
> +               .of_compatible = "sprd,sc2731-wdt",
>         }, {
>                 .name = "sc27xx-rtc",
> -               .of_compatible = "sprd,sc27xx-rtc",
> +               .of_compatible = "sprd,sc2731-rtc",
>         }, {
>                 .name = "sc27xx-charger",
> -               .of_compatible = "sprd,sc27xx-charger",
> +               .of_compatible = "sprd,sc2731-charger",
>         }, {
>                 .name = "sc27xx-chg-timer",
> -               .of_compatible = "sprd,sc27xx-chg-timer",
> +               .of_compatible = "sprd,sc2731-chg-timer",
>         }, {
>                 .name = "sc27xx-fast-chg",
> -               .of_compatible = "sprd,sc27xx-fast-chg",
> +               .of_compatible = "sprd,sc2731-fast-chg",
>         }, {
>                 .name = "sc27xx-chg-wdt",
> -               .of_compatible = "sprd,sc27xx-chg-wdt",
> +               .of_compatible = "sprd,sc2731-chg-wdt",
>         }, {
>                 .name = "sc27xx-typec",
> -               .of_compatible = "sprd,sc27xx-typec",
> +               .of_compatible = "sprd,sc2731-typec",
>         }, {
>                 .name = "sc27xx-flash",
> -               .of_compatible = "sprd,sc27xx-flash",
> +               .of_compatible = "sprd,sc2731-flash",
>         }, {
>                 .name = "sc27xx-eic",
> -               .of_compatible = "sprd,sc27xx-eic",
> +               .of_compatible = "sprd,sc2731-eic",
>         }, {
>                 .name = "sc27xx-efuse",
> -               .of_compatible = "sprd,sc27xx-efuse",
> +               .of_compatible = "sprd,sc2731-efuse",
>         }, {
>                 .name = "sc27xx-thermal",
> -               .of_compatible = "sprd,sc27xx-thermal",
> +               .of_compatible = "sprd,sc2731-thermal",
>         }, {
>                 .name = "sc27xx-adc",
> -               .of_compatible = "sprd,sc27xx-adc",
> +               .of_compatible = "sprd,sc2731-adc",
>         }, {
>                 .name = "sc27xx-audio-codec",
> -               .of_compatible = "sprd,sc27xx-audio-codec",
> +               .of_compatible = "sprd,sc2731-audio-codec",
>         }, {
>                 .name = "sc27xx-regulator",
> -               .of_compatible = "sprd,sc27xx-regulator",
> +               .of_compatible = "sprd,sc2731-regulator",
>         }, {
>                 .name = "sc27xx-vibrator",
> -               .of_compatible = "sprd,sc27xx-vibrator",
> +               .of_compatible = "sprd,sc2731-vibrator",
>         }, {
>                 .name = "sc27xx-keypad-led",
> -               .of_compatible = "sprd,sc27xx-keypad-led",
> +               .of_compatible = "sprd,sc2731-keypad-led",
>         }, {
>                 .name = "sc27xx-bltc",
> -               .of_compatible = "sprd,sc27xx-bltc",
> +               .of_compatible = "sprd,sc2731-bltc",
>         }, {
>                 .name = "sc27xx-fgu",
> -               .of_compatible = "sprd,sc27xx-fgu",
> +               .of_compatible = "sprd,sc2731-fgu",
>         }, {
>                 .name = "sc27xx-7sreset",
> -               .of_compatible = "sprd,sc27xx-7sreset",
> +               .of_compatible = "sprd,sc2731-7sreset",
>         }, {
>                 .name = "sc27xx-poweroff",
> -               .of_compatible = "sprd,sc27xx-poweroff",
> +               .of_compatible = "sprd,sc2731-poweroff",
>         }, {
>                 .name = "sc27xx-syscon",
> -               .of_compatible = "sprd,sc27xx-syscon",
> +               .of_compatible = "sprd,sc2731-syscon",
>         },
>  };
>
> --
> 1.7.9.5
>


-- 
Baolin Wang
Best Regards
