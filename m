Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79A3C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BCA218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ohKgXYoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfAYR7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:59:39 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35080 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548439176; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K48GMAhaif94u/43ivelHOJGKNU5v5rBX2nqGTZ4/9A=;
        b=ohKgXYoeyZWflGfx2dG+SDN1eN8dMQ36bqXb68ylA4RZibovzw94mbzksmn+VDtl/uTYZV
        yYkxpTXtOerZafwuUZGbHdAHkWlIGnVUBsnkCPQpvLzJq3PnBQp4GHeUPXC0GrW0JOeXgP
        FrAPPX7xyLi7FzwdRvBp0rh05Gd02Ro=
Date:   Fri, 25 Jan 2019 14:59:17 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH RESEND 4/4] Pinctrl: Ingenic: Fix const declaration.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul.burton@mips.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Message-Id: <1548439157.1804.1@crapouillou.net>
In-Reply-To: <1548410393-6981-5-git-send-email-zhouyanjie@zoho.com>
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
        <1548410393-6981-5-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 25, 2019 at 6:59 AM, Zhou Yanjie <zhouyanjie@zoho.com>=20
wrote:
> Warning is reported when checkpatch indicates that
> "static const char * array" should be changed to
> "static const char * const".
>=20
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com=20
> <mailto:zhouyanjie@zoho.com>>
> ---
>  drivers/pinctrl/pinctrl-ingenic.c | 136=20
> +++++++++++++++++++++-----------------
>  1 file changed, 76 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c=20
> b/drivers/pinctrl/pinctrl-ingenic.c
> index 2b3f7e4..e982896 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -172,23 +172,25 @@ static const struct group_desc jz4740_groups[]=20
> =3D {
>  	INGENIC_PIN_GROUP("pwm7", jz4740_pwm_pwm7),
>  };
>=20
> -static const char *jz4740_mmc_groups[] =3D { "mmc-1bit", "mmc-4bit", };
> -static const char *jz4740_uart0_groups[] =3D { "uart0-data",=20
> "uart0-hwflow", };
> -static const char *jz4740_uart1_groups[] =3D { "uart1-data", };
> -static const char *jz4740_lcd_groups[] =3D {
> +static const char * const jz4740_mmc_groups[] =3D { "mmc-1bit",=20
> "mmc-4bit", };
> +static const char * const jz4740_uart0_groups[] =3D {
> +	"uart0-data", "uart0-hwflow",
> +};
> +static const char * const jz4740_uart1_groups[] =3D { "uart1-data", };
> +static const char * const jz4740_lcd_groups[] =3D {
>  	"lcd-8bit", "lcd-16bit", "lcd-18bit", "lcd-18bit-tft",=20
> "lcd-no-pins",
>  };
> -static const char *jz4740_nand_groups[] =3D {
> +static const char * const jz4740_nand_groups[] =3D {
>  	"nand-cs1", "nand-cs2", "nand-cs3", "nand-cs4",
>  };
> -static const char *jz4740_pwm0_groups[] =3D { "pwm0", };
> -static const char *jz4740_pwm1_groups[] =3D { "pwm1", };
> -static const char *jz4740_pwm2_groups[] =3D { "pwm2", };
> -static const char *jz4740_pwm3_groups[] =3D { "pwm3", };
> -static const char *jz4740_pwm4_groups[] =3D { "pwm4", };
> -static const char *jz4740_pwm5_groups[] =3D { "pwm5", };
> -static const char *jz4740_pwm6_groups[] =3D { "pwm6", };
> -static const char *jz4740_pwm7_groups[] =3D { "pwm7", };
> +static const char * const jz4740_pwm0_groups[] =3D { "pwm0", };
> +static const char * const jz4740_pwm1_groups[] =3D { "pwm1", };
> +static const char * const jz4740_pwm2_groups[] =3D { "pwm2", };
> +static const char * const jz4740_pwm3_groups[] =3D { "pwm3", };
> +static const char * const jz4740_pwm4_groups[] =3D { "pwm4", };
> +static const char * const jz4740_pwm5_groups[] =3D { "pwm5", };
> +static const char * const jz4740_pwm6_groups[] =3D { "pwm6", };
> +static const char * const jz4740_pwm7_groups[] =3D { "pwm7", };
>=20
>  static const struct function_desc jz4740_functions[] =3D {
>  	{ "mmc", jz4740_mmc_groups, ARRAY_SIZE(jz4740_mmc_groups), },

With this patch applied I get this:

drivers/pinctrl/pinctrl-ingenic.c:196:11: attention : initialization=20
discards
=91const=92 qualifier from pointer target type [-Wdiscarded-qualifiers]
  { "mmc", jz4740_mmc_groups, ARRAY_SIZE(jz4740_mmc_groups), },
           ^~~~~~~~~~~~~~~~~

> @@ -272,19 +274,19 @@ static const struct group_desc jz4725b_groups[]=20
> =3D {
>  	INGENIC_PIN_GROUP("pwm5", jz4725b_pwm_pwm5),
>  };
>=20
> -static const char *jz4725b_mmc0_groups[] =3D { "mmc0-1bit",=20
> "mmc0-4bit", };
> -static const char *jz4725b_mmc1_groups[] =3D { "mmc1-1bit",=20
> "mmc1-4bit", };
> -static const char *jz4725b_uart_groups[] =3D { "uart-data", };
> -static const char *jz4725b_nand_groups[] =3D {
> +static const char * const jz4725b_mmc0_groups[] =3D { "mmc0-1bit",=20
> "mmc0-4bit", };
> +static const char * const jz4725b_mmc1_groups[] =3D { "mmc1-1bit",=20
> "mmc1-4bit", };
> +static const char * const jz4725b_uart_groups[] =3D { "uart-data", };
> +static const char * const jz4725b_nand_groups[] =3D {
>  	"nand-cs1", "nand-cs2", "nand-cs3", "nand-cs4",
>  	"nand-cle-ale", "nand-fre-fwe",
>  };
> -static const char *jz4725b_pwm0_groups[] =3D { "pwm0", };
> -static const char *jz4725b_pwm1_groups[] =3D { "pwm1", };
> -static const char *jz4725b_pwm2_groups[] =3D { "pwm2", };
> -static const char *jz4725b_pwm3_groups[] =3D { "pwm3", };
> -static const char *jz4725b_pwm4_groups[] =3D { "pwm4", };
> -static const char *jz4725b_pwm5_groups[] =3D { "pwm5", };
> +static const char * const jz4725b_pwm0_groups[] =3D { "pwm0", };
> +static const char * const jz4725b_pwm1_groups[] =3D { "pwm1", };
> +static const char * const jz4725b_pwm2_groups[] =3D { "pwm2", };
> +static const char * const jz4725b_pwm3_groups[] =3D { "pwm3", };
> +static const char * const jz4725b_pwm4_groups[] =3D { "pwm4", };
> +static const char * const jz4725b_pwm5_groups[] =3D { "pwm5", };
>=20
>  static const struct function_desc jz4725b_functions[] =3D {
>  	{ "mmc0", jz4725b_mmc0_groups, ARRAY_SIZE(jz4725b_mmc0_groups), },
> @@ -500,46 +502,56 @@ static const struct group_desc jz4770_groups[]=20
> =3D {
>  	INGENIC_PIN_GROUP("mac-mii", jz4770_mac_mii),
>  };
>=20
> -static const char *jz4770_uart0_groups[] =3D { "uart0-data",=20
> "uart0-hwflow", };
> -static const char *jz4770_uart1_groups[] =3D { "uart1-data",=20
> "uart1-hwflow", };
> -static const char *jz4770_uart2_groups[] =3D { "uart2-data",=20
> "uart2-hwflow", };
> -static const char *jz4770_uart3_groups[] =3D { "uart3-data",=20
> "uart3-hwflow", };
> -static const char *jz4770_mmc0_groups[] =3D {
> +static const char * const jz4770_uart0_groups[] =3D {
> +	"uart0-data", "uart0-hwflow",
> +};
> +static const char * const jz4770_uart1_groups[] =3D {
> +	"uart1-data", "uart1-hwflow",
> +};
> +static const char * const jz4770_uart2_groups[] =3D {
> +	"uart2-data", "uart2-hwflow",
> +};
> +static const char * const jz4770_uart3_groups[] =3D {
> +	"uart3-data", "uart3-hwflow",
> +};
> +static const char * const jz4770_mmc0_groups[] =3D {
>  	"mmc0-1bit-a", "mmc0-4bit-a",
>  	"mmc0-1bit-e", "mmc0-4bit-e", "mmc0-8bit-e",
>  };
> -static const char *jz4770_mmc1_groups[] =3D {
> +static const char * const jz4770_mmc1_groups[] =3D {
>  	"mmc1-1bit-d", "mmc1-4bit-d",
>  	"mmc1-1bit-e", "mmc1-4bit-e", "mmc1-8bit-e",
>  };
> -static const char *jz4770_mmc2_groups[] =3D {
> +static const char * const jz4770_mmc2_groups[] =3D {
>  	"mmc2-1bit-b", "mmc2-4bit-b",
>  	"mmc2-1bit-e", "mmc2-4bit-e", "mmc2-8bit-e",
>  };
> -static const char *jz4770_nemc_groups[] =3D {
> +static const char * const jz4770_nemc_groups[] =3D {
>  	"nemc-8bit-data", "nemc-16bit-data", "nemc-cle-ale",
>  	"nemc-addr", "nemc-rd-we", "nemc-frd-fwe", "nemc-wait",
>  };
> -static const char *jz4770_cs1_groups[] =3D { "nemc-cs1", };
> -static const char *jz4770_cs2_groups[] =3D { "nemc-cs2", };
> -static const char *jz4770_cs3_groups[] =3D { "nemc-cs3", };
> -static const char *jz4770_cs4_groups[] =3D { "nemc-cs4", };
> -static const char *jz4770_cs5_groups[] =3D { "nemc-cs5", };
> -static const char *jz4770_cs6_groups[] =3D { "nemc-cs6", };
> -static const char *jz4770_i2c0_groups[] =3D { "i2c0-data", };
> -static const char *jz4770_i2c1_groups[] =3D { "i2c1-data", };
> -static const char *jz4770_i2c2_groups[] =3D { "i2c2-data", };
> -static const char *jz4770_cim_groups[] =3D { "cim-data-8bit",=20
> "cim-data-12bit", };
> -static const char *jz4770_lcd_groups[] =3D { "lcd-24bit",=20
> "lcd-no-pins", };
> -static const char *jz4770_pwm0_groups[] =3D { "pwm0", };
> -static const char *jz4770_pwm1_groups[] =3D { "pwm1", };
> -static const char *jz4770_pwm2_groups[] =3D { "pwm2", };
> -static const char *jz4770_pwm3_groups[] =3D { "pwm3", };
> -static const char *jz4770_pwm4_groups[] =3D { "pwm4", };
> -static const char *jz4770_pwm5_groups[] =3D { "pwm5", };
> -static const char *jz4770_pwm6_groups[] =3D { "pwm6", };
> -static const char *jz4770_pwm7_groups[] =3D { "pwm7", };
> -static const char *jz4770_mac_groups[] =3D { "mac-rmii", "mac-mii", };
> +static const char * const jz4770_cs1_groups[] =3D { "nemc-cs1", };
> +static const char * const jz4770_cs2_groups[] =3D { "nemc-cs2", };
> +static const char * const jz4770_cs3_groups[] =3D { "nemc-cs3", };
> +static const char * const jz4770_cs4_groups[] =3D { "nemc-cs4", };
> +static const char * const jz4770_cs5_groups[] =3D { "nemc-cs5", };
> +static const char * const jz4770_cs6_groups[] =3D { "nemc-cs6", };
> +static const char * const jz4770_i2c0_groups[] =3D { "i2c0-data", };
> +static const char * const jz4770_i2c1_groups[] =3D { "i2c1-data", };
> +static const char * const jz4770_i2c2_groups[] =3D { "i2c2-data", };
> +static const char * const jz4770_cim_groups[] =3D {
> +	"cim-data-8bit", "cim-data-12bit",
> +};
> +static const char * const jz4770_lcd_groups[] =3D { "lcd-24bit",=20
> "lcd-no-pins", };
> +static const char * const jz4770_pwm0_groups[] =3D { "pwm0", };
> +static const char * const jz4770_pwm1_groups[] =3D { "pwm1", };
> +static const char * const jz4770_pwm2_groups[] =3D { "pwm2", };
> +static const char * const jz4770_pwm3_groups[] =3D { "pwm3", };
> +static const char * const jz4770_pwm4_groups[] =3D { "pwm4", };
> +static const char * const jz4770_pwm5_groups[] =3D { "pwm5", };
> +static const char * const jz4770_pwm6_groups[] =3D { "pwm6", };
> +static const char * const jz4770_pwm7_groups[] =3D { "pwm7", };
> +static const char * const jz4770_mac_groups[] =3D { "mac-rmii",=20
> "mac-mii", };
>=20
>  static const struct function_desc jz4770_functions[] =3D {
>  	{ "uart0", jz4770_uart0_groups, ARRAY_SIZE(jz4770_uart0_groups), },
> @@ -652,25 +664,29 @@ static const struct group_desc jz4780_groups[]=20
> =3D {
>  	INGENIC_PIN_GROUP("pwm7", jz4770_pwm_pwm7),
>  };
>=20
> -static const char *jz4780_uart2_groups[] =3D { "uart2-data",=20
> "uart2-hwflow", };
> -static const char *jz4780_uart4_groups[] =3D { "uart4-data", };
> -static const char *jz4780_mmc0_groups[] =3D {
> +static const char * const jz4780_uart2_groups[] =3D {
> +	"uart2-data", "uart2-hwflow",
> +};
> +static const char * const jz4780_uart4_groups[] =3D { "uart4-data", };
> +static const char * const jz4780_mmc0_groups[] =3D {
>  	"mmc0-1bit-a", "mmc0-4bit-a", "mmc0-8bit-a",
>  	"mmc0-1bit-e", "mmc0-4bit-e",
>  };
> -static const char *jz4780_mmc1_groups[] =3D {
> +static const char * const jz4780_mmc1_groups[] =3D {
>  	"mmc1-1bit-d", "mmc1-4bit-d", "mmc1-1bit-e", "mmc1-4bit-e",
>  };
> -static const char *jz4780_mmc2_groups[] =3D {
> +static const char * const jz4780_mmc2_groups[] =3D {
>  	"mmc2-1bit-b", "mmc2-4bit-b", "mmc2-1bit-e", "mmc2-4bit-e",
>  };
> -static const char *jz4780_nemc_groups[] =3D {
> +static const char * const jz4780_nemc_groups[] =3D {
>  	"nemc-data", "nemc-cle-ale", "nemc-addr",
>  	"nemc-rd-we", "nemc-frd-fwe", "nemc-wait",
>  };
> -static const char *jz4780_i2c3_groups[] =3D { "i2c3-data", };
> -static const char *jz4780_i2c4_groups[] =3D { "i2c4-data-e",=20
> "i2c4-data-f", };
> -static const char *jz4780_cim_groups[] =3D { "cim-data", };
> +static const char * const jz4780_i2c3_groups[] =3D { "i2c3-data", };
> +static const char * const jz4780_i2c4_groups[] =3D {
> +	"i2c4-data-e", "i2c4-data-f",
> +};
> +static const char * const jz4780_cim_groups[] =3D { "cim-data", };
>=20
>  static const struct function_desc jz4780_functions[] =3D {
>  	{ "uart0", jz4770_uart0_groups, ARRAY_SIZE(jz4770_uart0_groups), },
> --
> 2.7.4
>=20
>=20

=

