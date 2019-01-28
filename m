Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FACDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC1620882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="EJKogB0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfA1SOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:14:09 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:36572 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfA1SOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548699245; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1MCca4jrItpWdu9D+5hSkRuyw+9nQ4vUs/+Oz2uB+zM=;
        b=EJKogB0iiSE1nJid2W/FVm5Tdb4fCPDZ9R8o5XKn1kSzVFFtYIDXyXUlwFSGpS/fWkO5XT
        TNLocln5dNvEJjatoevmYMHmxXQXec6UaSyLLPXZ6ZrUG7PUQnTbcvPGNVqo44T3exRRZh
        0YYQ7W9zYoh21UPMbFmw4SV/KxUuipU=
Date:   Mon, 28 Jan 2019 15:13:50 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/3] Pinctrl: Ingenic: Add missing parts for JZ4770 and
 JZ4780.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul.burton@mips.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com, Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
Message-Id: <1548699230.7511.0@crapouillou.net>
In-Reply-To: <1548688799-129840-3-git-send-email-zhouyanjie@zoho.com>
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
        <1548688799-129840-1-git-send-email-zhouyanjie@zoho.com>
        <1548688799-129840-3-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lun. 28 janv. 2019 =E0 12:19, Zhou Yanjie <zhouyanjie@zoho.com> a=20
=E9crit :
> From: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
>=20
> Add mmc2 for JZ4770 and JZ4780:
> According to the datasheet, both JZ4770 and JZ4780 have mmc2. But this
> part of the original code is missing. It is worth noting that JZ4770's
> mmc2 supports 8bit mode while JZ4780's does not, so we added the
> corresponding code for both models.
>=20
> Add nemc-wait for JZ4770 and JZ4780:
> Both JZ4770 and JZ4780 have a nemc-wait pin. But this part of the
> original code is missing.
>=20
> Add mac for JZ4770:
> JZ4770 have a mac. But this part of the original code is missing.
>=20
> Signed-off-by: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Good job!

> ---
>  drivers/pinctrl/pinctrl-ingenic.c | 46=20
> +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c=20
> b/drivers/pinctrl/pinctrl-ingenic.c
> index 710062b..6501f35 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -335,6 +335,11 @@ static int jz4770_mmc1_4bit_d_pins[] =3D { 0x75,=20
> 0x76, 0x77, };
>  static int jz4770_mmc1_1bit_e_pins[] =3D { 0x9c, 0x9d, 0x94, };
>  static int jz4770_mmc1_4bit_e_pins[] =3D { 0x95, 0x96, 0x97, };
>  static int jz4770_mmc1_8bit_e_pins[] =3D { 0x98, 0x99, 0x9a, 0x9b, };
> +static int jz4770_mmc2_1bit_b_pins[] =3D { 0x3c, 0x3d, 0x34, };
> +static int jz4770_mmc2_4bit_b_pins[] =3D { 0x35, 0x3e, 0x3f, };
> +static int jz4770_mmc2_1bit_e_pins[] =3D { 0x9c, 0x9d, 0x94, };
> +static int jz4770_mmc2_4bit_e_pins[] =3D { 0x95, 0x96, 0x97, };
> +static int jz4770_mmc2_8bit_e_pins[] =3D { 0x98, 0x99, 0x9a, 0x9b, };
>  static int jz4770_nemc_8bit_data_pins[] =3D {
>  	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
>  };
> @@ -345,6 +350,7 @@ static int jz4770_nemc_cle_ale_pins[] =3D { 0x20,=20
> 0x21, };
>  static int jz4770_nemc_addr_pins[] =3D { 0x22, 0x23, 0x24, 0x25, };
>  static int jz4770_nemc_rd_we_pins[] =3D { 0x10, 0x11, };
>  static int jz4770_nemc_frd_fwe_pins[] =3D { 0x12, 0x13, };
> +static int jz4770_nemc_wait_pins[] =3D { 0x1b, };
>  static int jz4770_nemc_cs1_pins[] =3D { 0x15, };
>  static int jz4770_nemc_cs2_pins[] =3D { 0x16, };
>  static int jz4770_nemc_cs3_pins[] =3D { 0x17, };
> @@ -375,6 +381,10 @@ static int jz4770_pwm_pwm4_pins[] =3D { 0x84, };
>  static int jz4770_pwm_pwm5_pins[] =3D { 0x85, };
>  static int jz4770_pwm_pwm6_pins[] =3D { 0x6a, };
>  static int jz4770_pwm_pwm7_pins[] =3D { 0x6b, };
> +static int jz4770_mac_rmii_pins[] =3D {
> +	0xa9, 0xab, 0xaa, 0xac, 0xa5, 0xa4, 0xad, 0xae, 0xa6, 0xa8,
> +};
> +static int jz4770_mac_mii_pins[] =3D { 0xa7, 0xaf, };
>=20
>  static int jz4770_uart0_data_funcs[] =3D { 0, 0, };
>  static int jz4770_uart0_hwflow_funcs[] =3D { 0, 0, };
> @@ -394,12 +404,18 @@ static int jz4770_mmc1_4bit_d_funcs[] =3D { 0, 0,=20
> 0, };
>  static int jz4770_mmc1_1bit_e_funcs[] =3D { 1, 1, 1, };
>  static int jz4770_mmc1_4bit_e_funcs[] =3D { 1, 1, 1, };
>  static int jz4770_mmc1_8bit_e_funcs[] =3D { 1, 1, 1, 1, };
> +static int jz4770_mmc2_1bit_b_funcs[] =3D { 0, 0, 0, };
> +static int jz4770_mmc2_4bit_b_funcs[] =3D { 0, 0, 0, };
> +static int jz4770_mmc2_1bit_e_funcs[] =3D { 2, 2, 2, };
> +static int jz4770_mmc2_4bit_e_funcs[] =3D { 2, 2, 2, };
> +static int jz4770_mmc2_8bit_e_funcs[] =3D { 2, 2, 2, 2, };
>  static int jz4770_nemc_8bit_data_funcs[] =3D { 0, 0, 0, 0, 0, 0, 0, 0,=20
> };
>  static int jz4770_nemc_16bit_data_funcs[] =3D { 0, 0, 0, 0, 0, 0, 0,=20
> 0, };
>  static int jz4770_nemc_cle_ale_funcs[] =3D { 0, 0, };
>  static int jz4770_nemc_addr_funcs[] =3D { 0, 0, 0, 0, };
>  static int jz4770_nemc_rd_we_funcs[] =3D { 0, 0, };
>  static int jz4770_nemc_frd_fwe_funcs[] =3D { 0, 0, };
> +static int jz4770_nemc_wait_funcs[] =3D { 0, };
>  static int jz4770_nemc_cs1_funcs[] =3D { 0, };
>  static int jz4770_nemc_cs2_funcs[] =3D { 0, };
>  static int jz4770_nemc_cs3_funcs[] =3D { 0, };
> @@ -425,6 +441,8 @@ static int jz4770_pwm_pwm4_funcs[] =3D { 0, };
>  static int jz4770_pwm_pwm5_funcs[] =3D { 0, };
>  static int jz4770_pwm_pwm6_funcs[] =3D { 0, };
>  static int jz4770_pwm_pwm7_funcs[] =3D { 0, };
> +static int jz4770_mac_rmii_funcs[] =3D { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,=20
> };
> +static int jz4770_mac_mii_funcs[] =3D { 0, 0, };
>=20
>  static const struct group_desc jz4770_groups[] =3D {
>  	INGENIC_PIN_GROUP("uart0-data", jz4770_uart0_data),
> @@ -445,12 +463,18 @@ static const struct group_desc jz4770_groups[]=20
> =3D {
>  	INGENIC_PIN_GROUP("mmc1-1bit-e", jz4770_mmc1_1bit_e),
>  	INGENIC_PIN_GROUP("mmc1-4bit-e", jz4770_mmc1_4bit_e),
>  	INGENIC_PIN_GROUP("mmc1-8bit-e", jz4770_mmc1_8bit_e),
> +	INGENIC_PIN_GROUP("mmc2-1bit-b", jz4770_mmc2_1bit_b),
> +	INGENIC_PIN_GROUP("mmc2-4bit-b", jz4770_mmc2_4bit_b),
> +	INGENIC_PIN_GROUP("mmc2-1bit-e", jz4770_mmc2_1bit_e),
> +	INGENIC_PIN_GROUP("mmc2-4bit-e", jz4770_mmc2_4bit_e),
> +	INGENIC_PIN_GROUP("mmc2-8bit-e", jz4770_mmc2_8bit_e),
>  	INGENIC_PIN_GROUP("nemc-8bit-data", jz4770_nemc_8bit_data),
>  	INGENIC_PIN_GROUP("nemc-16bit-data", jz4770_nemc_16bit_data),
>  	INGENIC_PIN_GROUP("nemc-cle-ale", jz4770_nemc_cle_ale),
>  	INGENIC_PIN_GROUP("nemc-addr", jz4770_nemc_addr),
>  	INGENIC_PIN_GROUP("nemc-rd-we", jz4770_nemc_rd_we),
>  	INGENIC_PIN_GROUP("nemc-frd-fwe", jz4770_nemc_frd_fwe),
> +	INGENIC_PIN_GROUP("nemc-wait", jz4770_nemc_wait),
>  	INGENIC_PIN_GROUP("nemc-cs1", jz4770_nemc_cs1),
>  	INGENIC_PIN_GROUP("nemc-cs2", jz4770_nemc_cs2),
>  	INGENIC_PIN_GROUP("nemc-cs3", jz4770_nemc_cs3),
> @@ -472,6 +496,8 @@ static const struct group_desc jz4770_groups[] =3D {
>  	INGENIC_PIN_GROUP("pwm5", jz4770_pwm_pwm5),
>  	INGENIC_PIN_GROUP("pwm6", jz4770_pwm_pwm6),
>  	INGENIC_PIN_GROUP("pwm7", jz4770_pwm_pwm7),
> +	INGENIC_PIN_GROUP("mac-rmii", jz4770_mac_rmii),
> +	INGENIC_PIN_GROUP("mac-mii", jz4770_mac_mii),
>  };
>=20
>  static const char *jz4770_uart0_groups[] =3D { "uart0-data",=20
> "uart0-hwflow", };
> @@ -486,9 +512,13 @@ static const char *jz4770_mmc1_groups[] =3D {
>  	"mmc1-1bit-d", "mmc1-4bit-d",
>  	"mmc1-1bit-e", "mmc1-4bit-e", "mmc1-8bit-e",
>  };
> +static const char *jz4770_mmc2_groups[] =3D {
> +	"mmc2-1bit-b", "mmc2-4bit-b",
> +	"mmc2-1bit-e", "mmc2-4bit-e", "mmc2-8bit-e",
> +};
>  static const char *jz4770_nemc_groups[] =3D {
>  	"nemc-8bit-data", "nemc-16bit-data", "nemc-cle-ale",
> -	"nemc-addr", "nemc-rd-we", "nemc-frd-fwe",
> +	"nemc-addr", "nemc-rd-we", "nemc-frd-fwe", "nemc-wait",
>  };
>  static const char *jz4770_cs1_groups[] =3D { "nemc-cs1", };
>  static const char *jz4770_cs2_groups[] =3D { "nemc-cs2", };
> @@ -509,6 +539,7 @@ static const char *jz4770_pwm4_groups[] =3D {=20
> "pwm4", };
>  static const char *jz4770_pwm5_groups[] =3D { "pwm5", };
>  static const char *jz4770_pwm6_groups[] =3D { "pwm6", };
>  static const char *jz4770_pwm7_groups[] =3D { "pwm7", };
> +static const char *jz4770_mac_groups[] =3D { "mac-rmii", "mac-mii", };
>=20
>  static const struct function_desc jz4770_functions[] =3D {
>  	{ "uart0", jz4770_uart0_groups, ARRAY_SIZE(jz4770_uart0_groups), },
> @@ -517,6 +548,7 @@ static const struct function_desc=20
> jz4770_functions[] =3D {
>  	{ "uart3", jz4770_uart3_groups, ARRAY_SIZE(jz4770_uart3_groups), },
>  	{ "mmc0", jz4770_mmc0_groups, ARRAY_SIZE(jz4770_mmc0_groups), },
>  	{ "mmc1", jz4770_mmc1_groups, ARRAY_SIZE(jz4770_mmc1_groups), },
> +	{ "mmc2", jz4770_mmc2_groups, ARRAY_SIZE(jz4770_mmc2_groups), },
>  	{ "nemc", jz4770_nemc_groups, ARRAY_SIZE(jz4770_nemc_groups), },
>  	{ "nemc-cs1", jz4770_cs1_groups, ARRAY_SIZE(jz4770_cs1_groups), },
>  	{ "nemc-cs2", jz4770_cs2_groups, ARRAY_SIZE(jz4770_cs2_groups), },
> @@ -537,6 +569,7 @@ static const struct function_desc=20
> jz4770_functions[] =3D {
>  	{ "pwm5", jz4770_pwm5_groups, ARRAY_SIZE(jz4770_pwm5_groups), },
>  	{ "pwm6", jz4770_pwm6_groups, ARRAY_SIZE(jz4770_pwm6_groups), },
>  	{ "pwm7", jz4770_pwm7_groups, ARRAY_SIZE(jz4770_pwm7_groups), },
> +	{ "mac", jz4770_mac_groups, ARRAY_SIZE(jz4770_mac_groups), },
>  };
>=20
>  static const struct ingenic_chip_info jz4770_chip_info =3D {
> @@ -584,11 +617,16 @@ static const struct group_desc jz4780_groups[]=20
> =3D {
>  	INGENIC_PIN_GROUP("mmc1-4bit-d", jz4770_mmc1_4bit_d),
>  	INGENIC_PIN_GROUP("mmc1-1bit-e", jz4770_mmc1_1bit_e),
>  	INGENIC_PIN_GROUP("mmc1-4bit-e", jz4770_mmc1_4bit_e),
> +	INGENIC_PIN_GROUP("mmc2-1bit-b", jz4770_mmc2_1bit_b),
> +	INGENIC_PIN_GROUP("mmc2-4bit-b", jz4770_mmc2_4bit_b),
> +	INGENIC_PIN_GROUP("mmc2-1bit-e", jz4770_mmc2_1bit_e),
> +	INGENIC_PIN_GROUP("mmc2-4bit-e", jz4770_mmc2_4bit_e),
>  	INGENIC_PIN_GROUP("nemc-data", jz4770_nemc_8bit_data),
>  	INGENIC_PIN_GROUP("nemc-cle-ale", jz4770_nemc_cle_ale),
>  	INGENIC_PIN_GROUP("nemc-addr", jz4770_nemc_addr),
>  	INGENIC_PIN_GROUP("nemc-rd-we", jz4770_nemc_rd_we),
>  	INGENIC_PIN_GROUP("nemc-frd-fwe", jz4770_nemc_frd_fwe),
> +	INGENIC_PIN_GROUP("nemc-wait", jz4770_nemc_wait),
>  	INGENIC_PIN_GROUP("nemc-cs1", jz4770_nemc_cs1),
>  	INGENIC_PIN_GROUP("nemc-cs2", jz4770_nemc_cs2),
>  	INGENIC_PIN_GROUP("nemc-cs3", jz4770_nemc_cs3),
> @@ -623,9 +661,12 @@ static const char *jz4780_mmc0_groups[] =3D {
>  static const char *jz4780_mmc1_groups[] =3D {
>  	"mmc1-1bit-d", "mmc1-4bit-d", "mmc1-1bit-e", "mmc1-4bit-e",
>  };
> +static const char *jz4780_mmc2_groups[] =3D {
> +	"mmc2-1bit-b", "mmc2-4bit-b", "mmc2-1bit-e", "mmc2-4bit-e",
> +};
>  static const char *jz4780_nemc_groups[] =3D {
>  	"nemc-data", "nemc-cle-ale", "nemc-addr",
> -	"nemc-rd-we", "nemc-frd-fwe",
> +	"nemc-rd-we", "nemc-frd-fwe", "nemc-wait",
>  };
>  static const char *jz4780_i2c3_groups[] =3D { "i2c3-data", };
>  static const char *jz4780_i2c4_groups[] =3D { "i2c4-data-e",=20
> "i2c4-data-f", };
> @@ -639,6 +680,7 @@ static const struct function_desc=20
> jz4780_functions[] =3D {
>  	{ "uart4", jz4780_uart4_groups, ARRAY_SIZE(jz4780_uart4_groups), },
>  	{ "mmc0", jz4780_mmc0_groups, ARRAY_SIZE(jz4780_mmc0_groups), },
>  	{ "mmc1", jz4780_mmc1_groups, ARRAY_SIZE(jz4780_mmc1_groups), },
> +	{ "mmc2", jz4780_mmc2_groups, ARRAY_SIZE(jz4780_mmc2_groups), },
>  	{ "nemc", jz4780_nemc_groups, ARRAY_SIZE(jz4780_nemc_groups), },
>  	{ "nemc-cs1", jz4770_cs1_groups, ARRAY_SIZE(jz4770_cs1_groups), },
>  	{ "nemc-cs2", jz4770_cs2_groups, ARRAY_SIZE(jz4770_cs2_groups), },
> --
> 2.7.4
>=20
>=20
=

