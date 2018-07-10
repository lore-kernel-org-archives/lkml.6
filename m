Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D81C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B231C208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwDjFmSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B231C208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbeGJSTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:19:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43146 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbeGJSTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:19:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so17442770ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQToQr/PYuYrEmF68GwpQkdjdSwUPAU8nrGjUNoHfsI=;
        b=qwDjFmSSr8osC9dD9Cteu4adh5RqbVZT0SUDHpIz9nSYlP8jIiKDKM9P+4qQBJc2u4
         Re+LDmohdUhvXd9hErAmqDywUJK51A2R1RPG/u4M8+vRgMEKcAsxBRSXQtS8dlqKCJXL
         Hm52I0Zfzlohl9gWJ6dux4sgbJo/5iomWtUVWU8M3jM3gQako1RgutPdvUY8+E2d9VhM
         zz3sfUWKdnfN0Xb2KbyOoXPwLyepjyLpUsiRRGEcuRkfDO2Xihk25EaUAA08LzkK/gXo
         ceVPxTy8vevDSHvbi8x2aJ/2XpRXOnYg8EsDJB1QRSVUn55rKHRib1nzCpnt2Xm7kASc
         mpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQToQr/PYuYrEmF68GwpQkdjdSwUPAU8nrGjUNoHfsI=;
        b=JjitmHbifWi1o43ZwNes1TAQFpFqYDE2Zzp2SQCW6QWjpNFE/60JkVLFcikMr+bYca
         JTFKv9Quvao5w5QY93zpuUFuOUsuWR+1fb49OtmL4Q8KI1hVCIPUnmH/VLO43UO1R1cD
         ib/evFhtg8xrL7nXIcT0TRTxVp5CKzcEHVQEa9EiMjNyfgl2f9kZFN0p8wlV6mVhS9yM
         2UGs/DsGxEtMMaismbMo5c9AFElMpvnra9tvIWRdchGIaRaoPEWbK+gLEwteqhYI7PMo
         mS8jujYFaG8rQRc9mx2NYIs4FPNEQOepeJctiqu5OjLgWA7AerbghAGmE+SrPWtxUKfQ
         TNkg==
X-Gm-Message-State: APt69E3HSs+5gx3IIkA4LQXCqYy9KU9U77WNkhE6h3dkiZZWnDjQApId
        9ko+39vlSFZT19E3Pp4YcsfuKoYO
X-Google-Smtp-Source: AAOMgpdaI0Hox3s5V35WOkkJOFnVuDrh0oyo2DyLkRPJRkvVsBsHnB/gF/Y7Who1uqRnfl/QrN1arA==
X-Received: by 2002:a2e:9b04:: with SMTP id u4-v6mr2341714lji.78.1531245374765;
        Tue, 10 Jul 2018 10:56:14 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id b9-v6sm2621948ljd.62.2018.07.10.10.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 10:56:13 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v4] regulator: fixed: Convert to use GPIO descriptor only
Date:   Tue, 10 Jul 2018 19:56:54 +0200
Message-ID: <5893595.ygSzo8aE2W@z50>
In-Reply-To: <20180710061112.28736-1-linus.walleij@linaro.org>
References: <20180710061112.28736-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Regarding OMAP1 part (limited to board-ams-delta.c):

On Tuesday, July 10, 2018 8:11:12 AM CEST Linus Walleij wrote:
> ...
> ChangeLog v3->v4:
> - Rebase and adapt the OMAP1 changes for the GPIO descriptor
>   look-up tables deployed by Janusz.
> ...
> - Go over all patches to board files and make sure we pass
>   a NULL descriptor instead of an "enable" descriptor. The code
>   is looking for unnamed GPIOs as the device tree also just pass
>   gpio[s] = <&foo> so board files also need to use anonymous
>   GPIOs.
> ...
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 80f54cb54276..2d24cab22134 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -288,7 +288,6 @@ static struct regulator_init_data modem_nreset_data = {
>  static struct fixed_voltage_config modem_nreset_config = {
>  	.supply_name		= "modem_nreset",
>  	.microvolts		= 3300000,
> -	.gpio			= AMS_DELTA_GPIO_PIN_MODEM_NRESET,

This is OK but not enough for clean build of board-ams-delta.c when merged 
into current linux-next as one more struct fixed_voltage_config introduced there 
recently - keybrd_pwr_config - needs removal of .gpio member (respective lookup 
table with NULL function name is already there).

>  	.startup_delay		= 25000,
>  	.enable_high		= 1,
>  	.enabled_at_boot	= 1,
> @@ -303,6 +302,15 @@ static struct platform_device modem_nreset_device = {
>  	},
>  };
> 
> +static struct gpiod_lookup_table ams_delta_nreset_gpiod_table = {
> +	.dev_id = "reg-fixed-voltage",
> +	.table = {
> +		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_MODEM_NRESET,
> +			    NULL, GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +
>  struct modem_private_data {
>  	struct regulator *regulator;
>  };
> @@ -538,6 +546,7 @@ static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
>  };
> 
>  static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
> +	&ams_delta_nreset_gpiod_table,

That is also OK but may raise a conflict when merged into current linux-next 
where late_gpio_tables[] has been removed from board-ams-delta.c  and its 
content integrated into ams_delta_gpio_tables[].

>  	&ams_delta_lcd_gpio_table,
>  	&ams_delta_nand_gpio_table,
>  };

If that makes your life easier, I can prepare a fix for board-ams-delta.c on 
top of your patch.  In that case you can add my:
Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Thanks,
Janusz



