Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EC7ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1BD20644
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmGdlL11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1BD20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJSVGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:06:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33778 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbeJSVGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:06:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id q40-v6so38150440qte.0;
        Fri, 19 Oct 2018 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eatvjCtQArRR+RWSaGNj713Zv+wOaev5807kh6p8yo=;
        b=kmGdlL115YME3g5gtJnQUuFw0RiPxDCqJqzDBsoWYsgN77q5u5PRpG/53IyF1lbIQJ
         2buZjuROWKGj3nbuvdHk3BoZJa88PTYfLXKnJ+kJTdAKpqeKjTXtBoS0yZBqo/zpQrXx
         KvzCkFjS8aMSf+xbbDmWdeHnitC+yDiTUerUJud79zV17lP55kdCwO1iqJGpZuSmtwcY
         qqVdR2glZ+yg7UxPQOr7G34kWdcoTvw3+/8aP8ptjIVyMNbn+OxnkQm/UUvhWTwQtqsg
         7+DOxD2i7LYaVGdfJJcjFlcO1dNfkVzInkK63pTUiK5IY4X1ivFjWzByHkHS+0iY3Ons
         MhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eatvjCtQArRR+RWSaGNj713Zv+wOaev5807kh6p8yo=;
        b=e/f4mWUJMkI9I3VjxSzv2J4DhVcmBONi2cBkvhNY9dgD7AgEvDecLcQdmx4WD26OCo
         1Ud7jnW3vTEC4CGG80O+3L7LrmzEt+8zF9HFSJUV1YQ+qLDFgFG2vhnLKYHUjrYsKMey
         CH5b1UobN+zBFWJdiYdFlu3zPY3opJwzSF/aGFkKKO4TUsCYN01xK6Eu6L5uFpprZ8Nf
         2DwPEgzAqQwyv7ETyBhfMHI2TkDE275S1FEmFv33Js9aGpJcHgW7UUgm4fZRxfUbtcKz
         xi0mSikI6+sl8nHkOzhrAWOtPP4AuiuraJKOAFSZ22Kb1/QoUxHBWkrXCIpXeCbuDXIb
         VHyQ==
X-Gm-Message-State: AGRZ1gL5PDxv2nnpwZPWbgu9hX1v5oZ6zco8TaWhcFvJhIMVDfQ86blw
        zlhjmR90Xzq93KLheP1Ci2vpehCv97xSLDFX0TM=
X-Google-Smtp-Source: ACcGV606vi3DEy+PkS0eTCYM98hKI+JlWMnFRSSlt2/8iayuUm7yWdmJWVVeac0+1EwSmvMONSGaDwyDHnAR0oQlQWM=
X-Received: by 2002:ac8:191a:: with SMTP id t26-v6mr1222999qtj.327.1539954043712;
 Fri, 19 Oct 2018 06:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-2-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-2-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:00:32 +0300
Message-ID: <CAHp75VenECSZWR3RVh=t35Os93t-MzEH_YzPgT=qQWL-SwjgFQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] power: supply: olpc_battery: correct the
 temperature units
To:     Lubomir Rintel <lkundrak@v3.sk>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> According to [1] and [2], the temperature values are in tenths of degree
> Celsius. Exposing the Celsius value makes the battery appear on fire:
>
>   $ upower -i /org/freedesktop/UPower/devices/battery_olpc_battery
>   ...
>       temperature:         236.9 degrees C
>
> Tested on OLPC XO-1 and OLPC XO-1.75 laptops.

It's interesting that the very author of that code is not included in
so-o long Cc list :)
Cc: David.

David, do you remember if and how you had tested temperature report of
the battery on OLPC?
I guess this kind of error would be appear immediately.

OTOH it might be that power framework had changed requirements (which
would be noticeable change).
If the latter is true, this patch misses Fixes tag. Actually in any
case it misses it.

>
> [1] include/linux/power_supply.h
> [2] Documentation/power/power_supply_class.txt
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/power/supply/olpc_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index 6da79ae14860..5a97e42a3547 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -428,14 +428,14 @@ static int olpc_bat_get_property(struct power_supply *psy,
>                 if (ret)
>                         return ret;
>
> -               val->intval = (s16)be16_to_cpu(ec_word) * 100 / 256;
> +               val->intval = (s16)be16_to_cpu(ec_word) * 10 / 256;
>                 break;
>         case POWER_SUPPLY_PROP_TEMP_AMBIENT:
>                 ret = olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
>                 if (ret)
>                         return ret;
>
> -               val->intval = (int)be16_to_cpu(ec_word) * 100 / 256;
> +               val->intval = (int)be16_to_cpu(ec_word) * 10 / 256;
>                 break;
>         case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>                 ret = olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
