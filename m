Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754487AbeCGOYO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:24:14 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39940 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754457AbeCGOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:24:11 -0500
X-Google-Smtp-Source: AG47ELvGeXSRmh//x02pqOKReaNOobSzDl4peBj8smnbxBB0pk5Cb+08MkntA3KsLQm7HrmZaSH6ootQ9GhGaJPiYzM=
MIME-Version: 1.0
In-Reply-To: <20180220163540.6704-1-ckeepax@opensource.cirrus.com>
References: <20180220163540.6704-1-ckeepax@opensource.cirrus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Mar 2018 11:24:10 -0300
Message-ID: <CAOMZO5BNYkuz6pH2qZmj+4kBPQB=j-JniiqVbqzdH8nTOXVZQQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mfd: arizona: Update reset pin to use GPIOD
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On Tue, Feb 20, 2018 at 1:35 PM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
> index 77875250abe5..9558c4d9c8ca 100644
> --- a/drivers/mfd/arizona-core.c
> +++ b/drivers/mfd/arizona-core.c
> @@ -279,7 +279,7 @@ static int arizona_wait_for_boot(struct arizona *arizona)
>  static inline void arizona_enable_reset(struct arizona *arizona)
>  {
>         if (arizona->pdata.reset)
> -               gpio_set_value_cansleep(arizona->pdata.reset, 0);
> +               gpiod_set_value_cansleep(arizona->pdata.reset, 0);

This should be:

gpiod_set_value_cansleep(arizona->pdata.reset, 1);

as here you want to put the reset GPIO into its active state.

Assuming that in the dts this GPIO is defined as GPIO_ACTIVE_LOW, then
the command should put it to logic level 0 as done originally.

>  static void arizona_disable_reset(struct arizona *arizona)
> @@ -295,7 +295,7 @@ static void arizona_disable_reset(struct arizona *arizona)
>                         break;
>                 }
>
> -               gpio_set_value_cansleep(arizona->pdata.reset, 1);
> +               gpiod_set_value_cansleep(arizona->pdata.reset, 1);

This should be:

gpiod_set_value_cansleep(arizona->pdata.reset, 0);

as here you want to put the reset GPIO into its inactive state.
