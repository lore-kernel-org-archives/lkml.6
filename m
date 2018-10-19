Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D150ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2669121476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJiRt/3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2669121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeJSWBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:01:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35975 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJSWBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:01:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id u34-v6so38328071qth.3;
        Fri, 19 Oct 2018 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1+pE6ya2Qch0CRNiXp2HXv2eWyrx6d+/K+VD9I+pu0=;
        b=bJiRt/3Lu6Y2xZBcwlcNhuqFTmpRpn5mCFwI8i3gwdf9dMUNlPeWQD1uHFxhBHpj/N
         Vve7601OdtWJNJCbcZse9f7iwMg12HUqfSfn04mLeSg4EnYV9EXvH7ml5RWtuIKfT3Zo
         ieOHPPcvzUNYxlgfTOBIzaX0rwTtS7GLGQNTWhYkcLMVnGR+c+2n04gqF+MO5WVh7X6a
         jtLTtxcnWxD1f4b/ZaEN+QE/xOTLfvYvWEi8tZwQLO9dFzNG9rhxRWMGmsdPYbAcTYIL
         R7JB2mw0Sirqr4ygrp4DB8lyVFrbOYH/2fZP2jNB+D/outQmZ3NeKwdMVFtZmoVHMX4J
         bblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1+pE6ya2Qch0CRNiXp2HXv2eWyrx6d+/K+VD9I+pu0=;
        b=bAIUsx+Q4xS5ybkdM7zvaMxfopx3JcIDaZPNOZGolu0JW6lh9cZXUF5ktou4NchtRk
         guhLdtVftCntqXp8K4UKgT4txFZV767bPzLe3tBedYiuw/65xj/ihea2JyDVkyziGzbm
         7rt4d1DD8klgP5kUHl9MGEjYfhFdd+8Z3QXNlNlDE1znlRzDn/5D6Qv9egU0eahTMdQK
         ah3AypntzYAjWgki48wq0hxel4Ej5TRLEZDYxZ4vpJp88i5uc0H92kVmQt3b4kSif3zz
         HECjUAi+2Oy7Be0GftAA7opXpZyqA304yRbn4wjrTO+3RxbuJYQnvO7haooUG0rjatm9
         es3w==
X-Gm-Message-State: ABuFfohtUBbGv0gQACAewIa4qGQhoanbw5LSHPS8XJoxxdD2enIMaTah
        WgFrTR2K2THSgkiN6EJiin5oxNmZ9KecybuStzg=
X-Google-Smtp-Source: ACcGV63qY9rwRkJKKQ3BlmuDEAgzpBwr9+34hwR+rZAycSNb8lp3jn4GAaU+gDud8UDkL7auRDu37cuig0xZgazWmNk=
X-Received: by 2002:aed:2de3:: with SMTP id i90-v6mr14657997qtd.229.1539957336228;
 Fri, 19 Oct 2018 06:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-16-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-16-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:55:25 +0300
Message-ID: <CAHp75VepkJ2yy==rDO+WCrmj28_GDvin_3+MEnL7k0n4ZVP8QA@mail.gmail.com>
Subject: Re: [PATCH 15/15] power: supply: olpc_battery: Add OLPC XO 1.75 support
To:     Lubomir Rintel <lkundrak@v3.sk>
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
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:24 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The battery and the protocol are essentially the same as OLPC XO 1.5,
> but the responses from the EC are LSB first.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/power/supply/olpc_battery.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index dde9863e5c4a..2adf33b9f641 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -56,6 +56,7 @@ struct olpc_battery_data {
>         struct power_supply *olpc_bat;
>         char bat_serial[17];
>         int new_proto;
> +       int little_endian;
>  };
>
>  /*********************************************************************
> @@ -321,6 +322,14 @@ static int olpc_bat_get_voltage_max_design(union power_supply_propval *val)
>         return ret;
>  }
>
> +static s16 ecword_to_cpu(struct olpc_battery_data *data, u16 ec_byte)

ec_byte is misleading name. It's a 16-bit word. and since we called in
I/O accessor it as word, you may do the similar here.

And why result is s16 and not u16?

> +{
> +       if (data->little_endian)
> +               return le16_to_cpu(ec_byte);
> +       else
> +               return be16_to_cpu(ec_byte);

> +
>  /*********************************************************************
>   *             Battery properties
>   *********************************************************************/
> @@ -393,7 +402,7 @@ static int olpc_bat_get_property(struct power_supply *psy,
>                 if (ret)
>                         return ret;
>
> -               val->intval = (s16)be16_to_cpu(ec_word) * 9760L / 32;
> +               val->intval = ecword_to_cpu(data, ec_word) * 9760L / 32;
>                 break;
>         case POWER_SUPPLY_PROP_CURRENT_AVG:
>         case POWER_SUPPLY_PROP_CURRENT_NOW:
> @@ -401,7 +410,7 @@ static int olpc_bat_get_property(struct power_supply *psy,
>                 if (ret)
>                         return ret;
>
> -               val->intval = (s16)be16_to_cpu(ec_word) * 15625L / 120;
> +               val->intval = ecword_to_cpu(data, ec_word) * 15625L / 120;
>                 break;
>         case POWER_SUPPLY_PROP_CAPACITY:
>                 ret = olpc_ec_cmd(EC_BAT_SOC, NULL, 0, &ec_byte, 1);
> @@ -432,21 +441,21 @@ static int olpc_bat_get_property(struct power_supply *psy,
>                 if (ret)
>                         return ret;
>
> -               val->intval = (s16)be16_to_cpu(ec_word) * 10 / 256;
> +               val->intval = ecword_to_cpu(data, ec_word) * 10 / 256;
>                 break;
>         case POWER_SUPPLY_PROP_TEMP_AMBIENT:
>                 ret = olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
>                 if (ret)
>                         return ret;
>
> -               val->intval = (int)be16_to_cpu(ec_word) * 10 / 256;
> +               val->intval = (int)ecword_to_cpu(data, ec_word) * 10 / 256;
>                 break;
>         case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>                 ret = olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
>                 if (ret)
>                         return ret;
>
> -               val->intval = (s16)be16_to_cpu(ec_word) * 6250 / 15;
> +               val->intval = ecword_to_cpu(data, ec_word) * 6250 / 15;
>                 break;
>         case POWER_SUPPLY_PROP_SERIAL_NUMBER:
>                 ret = olpc_ec_cmd(EC_BAT_SERIAL, NULL, 0, (void *)&ser_buf, 8);
> @@ -626,6 +635,10 @@ static int olpc_battery_probe(struct platform_device *pdev)
>         if (ecver[0] > 0x44) {
>                 /* XO 1 or 1.5 with a new EC firmware. */
>                 data->new_proto = 1;
> +       } else if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
> +               /* XO 1.75 */
> +               data->new_proto = 1;
> +               data->little_endian = 1;
>         } else if (ecver[0] < 0x44) {
>                 /*
>                  * We've seen a number of EC protocol changes; this driver
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
