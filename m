Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2FDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D4F20882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="GFGn5057"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfA1SSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:18:04 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40386 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1SSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548699479; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5NJ+dRE6eTx43wDVZsRdwO4Li7k9lloBZRYWq2KEJ0=;
        b=GFGn5057SINn0/ZN075H3YQ0qOxajPBbTBZur7SQ3Da5bfD3XOi+Kqy25m+CwOJqPhlAtk
        8eIBuqzr/1RZXuAzPyyQ3QkLJ5buYK3+98r5qdvAAjPC0dWma+Vtz9uGt254mX+cStHu9t
        TmthNWxkTnuUmWcLTHQmWKVmbJHJp/U=
Date:   Mon, 28 Jan 2019 15:17:47 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] Pinctrl: Ingenic: Fix bugs caused by differences
 between JZ4770 and JZ4780.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul.burton@mips.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com, Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
Message-Id: <1548699467.7511.1@crapouillou.net>
In-Reply-To: <1548688799-129840-2-git-send-email-zhouyanjie@zoho.com>
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
        <1548688799-129840-1-git-send-email-zhouyanjie@zoho.com>
        <1548688799-129840-2-git-send-email-zhouyanjie@zoho.com>
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
> Delete uart4 and i2c3/4 from JZ4770:
> According to the datasheet, only JZ4780 have uart4 and i2c3/4. So we
> remove it from the JZ4770 code and add a section corresponding the=20
> JZ4780.
>=20
> Fix bugs in i2c0/1:
> The pin number was wrong in the original code.
>=20
> Fix bugs in uart2:
> JZ4770 and JZ4780 have different uart2 pins. So the original section=20
> JZ4770
> has been modified and the corresponding section of JZ4780 has been=20
> added.
>=20
> Fix bugs in mmc0:
> JZ4770 and JZ4780 assigned different pins to mmc0's 4~7 data lines.=20
> So the
> original section JZ4770 has been modified and the corresponding=20
> section of
> JZ4780 has been added.
>=20
> Fix bugs in mmc1:
> JZ4770's mmc1 has 8bit mode, while JZ4780 doesn't. So the original
> section JZ4770 has been modified and the corresponding section of
> JZ4780 has been added.
>=20
> Fix bugs in nemc:
> JZ4770's nemc has 16bit mode, while JZ4780 doesn't. So the original=20
> section
> JZ4770 has been modified and the corresponding section of JZ4780 has=20
> been
> added. And add missing cs2~5 groups for JZ4770 and JZ4780.
>=20
> Fix bugs in cim:
> JZ4770's cim has 12bit mode, while JZ4780 doesn't. So the original
> section JZ4770 has been modified and the corresponding section of
> JZ4780 has been added.
>=20
> Fix bugs in lcd:
> Both JZ4770 and JZ4780 lcd should be 24bit instead of 32bit.
>=20
> Signed-off-by: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

> ---
>  drivers/pinctrl/pinctrl-ingenic.c | 249=20
> +++++++++++++++++++++++++++++---------
>  1 file changed, 191 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c=20
> b/drivers/pinctrl/pinctrl-ingenic.c
> index db6b48e..710062b 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -321,23 +321,26 @@ static int jz4770_uart0_data_pins[] =3D { 0xa0,=20
> 0xa3, };
>  static int jz4770_uart0_hwflow_pins[] =3D { 0xa1, 0xa2, };
>  static int jz4770_uart1_data_pins[] =3D { 0x7a, 0x7c, };
>  static int jz4770_uart1_hwflow_pins[] =3D { 0x7b, 0x7d, };
> -static int jz4770_uart2_data_pins[] =3D { 0x66, 0x67, };
> -static int jz4770_uart2_hwflow_pins[] =3D { 0x65, 0x64, };
> +static int jz4770_uart2_data_pins[] =3D { 0x5c, 0x5e, };
> +static int jz4770_uart2_hwflow_pins[] =3D { 0x5d, 0x5f, };
>  static int jz4770_uart3_data_pins[] =3D { 0x6c, 0x85, };
>  static int jz4770_uart3_hwflow_pins[] =3D { 0x88, 0x89, };
> -static int jz4770_uart4_data_pins[] =3D { 0x54, 0x4a, };
> -static int jz4770_mmc0_8bit_a_pins[] =3D { 0x04, 0x05, 0x06, 0x07,=20
> 0x18, };
> -static int jz4770_mmc0_4bit_a_pins[] =3D { 0x15, 0x16, 0x17, };
>  static int jz4770_mmc0_1bit_a_pins[] =3D { 0x12, 0x13, 0x14, };
> -static int jz4770_mmc0_4bit_e_pins[] =3D { 0x95, 0x96, 0x97, };
> +static int jz4770_mmc0_4bit_a_pins[] =3D { 0x15, 0x16, 0x17, };
>  static int jz4770_mmc0_1bit_e_pins[] =3D { 0x9c, 0x9d, 0x94, };
> -static int jz4770_mmc1_4bit_d_pins[] =3D { 0x75, 0x76, 0x77, };
> +static int jz4770_mmc0_4bit_e_pins[] =3D { 0x95, 0x96, 0x97, };
> +static int jz4770_mmc0_8bit_e_pins[] =3D { 0x98, 0x99, 0x9a, 0x9b, };
>  static int jz4770_mmc1_1bit_d_pins[] =3D { 0x78, 0x79, 0x74, };
> -static int jz4770_mmc1_4bit_e_pins[] =3D { 0x95, 0x96, 0x97, };
> +static int jz4770_mmc1_4bit_d_pins[] =3D { 0x75, 0x76, 0x77, };
>  static int jz4770_mmc1_1bit_e_pins[] =3D { 0x9c, 0x9d, 0x94, };
> -static int jz4770_nemc_data_pins[] =3D {
> +static int jz4770_mmc1_4bit_e_pins[] =3D { 0x95, 0x96, 0x97, };
> +static int jz4770_mmc1_8bit_e_pins[] =3D { 0x98, 0x99, 0x9a, 0x9b, };
> +static int jz4770_nemc_8bit_data_pins[] =3D {
>  	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
>  };
> +static int jz4770_nemc_16bit_data_pins[] =3D {
> +	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +};
>  static int jz4770_nemc_cle_ale_pins[] =3D { 0x20, 0x21, };
>  static int jz4770_nemc_addr_pins[] =3D { 0x22, 0x23, 0x24, 0x25, };
>  static int jz4770_nemc_rd_we_pins[] =3D { 0x10, 0x11, };
> @@ -348,20 +351,21 @@ static int jz4770_nemc_cs3_pins[] =3D { 0x17, };
>  static int jz4770_nemc_cs4_pins[] =3D { 0x18, };
>  static int jz4770_nemc_cs5_pins[] =3D { 0x19, };
>  static int jz4770_nemc_cs6_pins[] =3D { 0x1a, };
> -static int jz4770_i2c0_pins[] =3D { 0x6e, 0x6f, };
> -static int jz4770_i2c1_pins[] =3D { 0x8e, 0x8f, };
> +static int jz4770_i2c0_pins[] =3D { 0x7e, 0x7f, };
> +static int jz4770_i2c1_pins[] =3D { 0x9e, 0x9f, };
>  static int jz4770_i2c2_pins[] =3D { 0xb0, 0xb1, };
> -static int jz4770_i2c3_pins[] =3D { 0x6a, 0x6b, };
> -static int jz4770_i2c4_e_pins[] =3D { 0x8c, 0x8d, };
> -static int jz4770_i2c4_f_pins[] =3D { 0xb9, 0xb8, };
> -static int jz4770_cim_pins[] =3D {
> -	0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,=20
> 0x31,
> +static int jz4770_cim_8bit_pins[] =3D {
> +	0x26, 0x27, 0x28, 0x29,
> +	0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31,
> +};
> +static int jz4770_cim_12bit_pins[] =3D {
> +	0x32, 0x33, 0xb0, 0xb1,
>  };
> -static int jz4770_lcd_32bit_pins[] =3D {
> +static int jz4770_lcd_24bit_pins[] =3D {
>  	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
>  	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
>  	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
> -	0x58, 0x59, 0x51,
> +	0x58, 0x59, 0x5a, 0x5b,
>  };
>  static int jz4770_pwm_pwm0_pins[] =3D { 0x80, };
>  static int jz4770_pwm_pwm1_pins[] =3D { 0x81, };
> @@ -376,21 +380,22 @@ static int jz4770_uart0_data_funcs[] =3D { 0, 0,=20
> };
>  static int jz4770_uart0_hwflow_funcs[] =3D { 0, 0, };
>  static int jz4770_uart1_data_funcs[] =3D { 0, 0, };
>  static int jz4770_uart1_hwflow_funcs[] =3D { 0, 0, };
> -static int jz4770_uart2_data_funcs[] =3D { 1, 1, };
> -static int jz4770_uart2_hwflow_funcs[] =3D { 1, 1, };
> +static int jz4770_uart2_data_funcs[] =3D { 0, 0, };
> +static int jz4770_uart2_hwflow_funcs[] =3D { 0, 0, };
>  static int jz4770_uart3_data_funcs[] =3D { 0, 1, };
>  static int jz4770_uart3_hwflow_funcs[] =3D { 0, 0, };
> -static int jz4770_uart4_data_funcs[] =3D { 2, 2, };
> -static int jz4770_mmc0_8bit_a_funcs[] =3D { 1, 1, 1, 1, 1, };
> -static int jz4770_mmc0_4bit_a_funcs[] =3D { 1, 1, 1, };
>  static int jz4770_mmc0_1bit_a_funcs[] =3D { 1, 1, 0, };
> -static int jz4770_mmc0_4bit_e_funcs[] =3D { 0, 0, 0, };
> +static int jz4770_mmc0_4bit_a_funcs[] =3D { 1, 1, 1, };
>  static int jz4770_mmc0_1bit_e_funcs[] =3D { 0, 0, 0, };
> -static int jz4770_mmc1_4bit_d_funcs[] =3D { 0, 0, 0, };
> +static int jz4770_mmc0_4bit_e_funcs[] =3D { 0, 0, 0, };
> +static int jz4770_mmc0_8bit_e_funcs[] =3D { 0, 0, 0, 0, };
>  static int jz4770_mmc1_1bit_d_funcs[] =3D { 0, 0, 0, };
> -static int jz4770_mmc1_4bit_e_funcs[] =3D { 1, 1, 1, };
> +static int jz4770_mmc1_4bit_d_funcs[] =3D { 0, 0, 0, };
>  static int jz4770_mmc1_1bit_e_funcs[] =3D { 1, 1, 1, };
> -static int jz4770_nemc_data_funcs[] =3D { 0, 0, 0, 0, 0, 0, 0, 0, };
> +static int jz4770_mmc1_4bit_e_funcs[] =3D { 1, 1, 1, };
> +static int jz4770_mmc1_8bit_e_funcs[] =3D { 1, 1, 1, 1, };
> +static int jz4770_nemc_8bit_data_funcs[] =3D { 0, 0, 0, 0, 0, 0, 0, 0,=20
> };
> +static int jz4770_nemc_16bit_data_funcs[] =3D { 0, 0, 0, 0, 0, 0, 0,=20
> 0, };
>  static int jz4770_nemc_cle_ale_funcs[] =3D { 0, 0, };
>  static int jz4770_nemc_addr_funcs[] =3D { 0, 0, 0, 0, };
>  static int jz4770_nemc_rd_we_funcs[] =3D { 0, 0, };
> @@ -404,14 +409,13 @@ static int jz4770_nemc_cs6_funcs[] =3D { 0, };
>  static int jz4770_i2c0_funcs[] =3D { 0, 0, };
>  static int jz4770_i2c1_funcs[] =3D { 0, 0, };
>  static int jz4770_i2c2_funcs[] =3D { 2, 2, };
> -static int jz4770_i2c3_funcs[] =3D { 1, 1, };
> -static int jz4770_i2c4_e_funcs[] =3D { 1, 1, };
> -static int jz4770_i2c4_f_funcs[] =3D { 1, 1, };
> -static int jz4770_cim_funcs[] =3D { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,=20
> 0, };
> -static int jz4770_lcd_32bit_funcs[] =3D {
> +static int jz4770_cim_8bit_funcs[] =3D { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,=20
> 0, 0, };
> +static int jz4770_cim_12bit_funcs[] =3D { 0, 0, 0, 0, };
> +static int jz4770_lcd_24bit_funcs[] =3D {
> +	0, 0, 0, 0, 0, 0, 0, 0,
>  	0, 0, 0, 0, 0, 0, 0, 0,
>  	0, 0, 0, 0, 0, 0, 0, 0,
> -	0, 0, 0,
> +	0, 0, 0, 0,
>  };
>  static int jz4770_pwm_pwm0_funcs[] =3D { 0, };
>  static int jz4770_pwm_pwm1_funcs[] =3D { 0, };
> @@ -431,17 +435,18 @@ static const struct group_desc jz4770_groups[]=20
> =3D {
>  	INGENIC_PIN_GROUP("uart2-hwflow", jz4770_uart2_hwflow),
>  	INGENIC_PIN_GROUP("uart3-data", jz4770_uart3_data),
>  	INGENIC_PIN_GROUP("uart3-hwflow", jz4770_uart3_hwflow),
> -	INGENIC_PIN_GROUP("uart4-data", jz4770_uart4_data),
> -	INGENIC_PIN_GROUP("mmc0-8bit-a", jz4770_mmc0_8bit_a),
> -	INGENIC_PIN_GROUP("mmc0-4bit-a", jz4770_mmc0_4bit_a),
>  	INGENIC_PIN_GROUP("mmc0-1bit-a", jz4770_mmc0_1bit_a),
> -	INGENIC_PIN_GROUP("mmc0-4bit-e", jz4770_mmc0_4bit_e),
> +	INGENIC_PIN_GROUP("mmc0-4bit-a", jz4770_mmc0_4bit_a),
>  	INGENIC_PIN_GROUP("mmc0-1bit-e", jz4770_mmc0_1bit_e),
> -	INGENIC_PIN_GROUP("mmc1-4bit-d", jz4770_mmc1_4bit_d),
> +	INGENIC_PIN_GROUP("mmc0-4bit-e", jz4770_mmc0_4bit_e),
> +	INGENIC_PIN_GROUP("mmc0-8bit-e", jz4770_mmc0_8bit_e),
>  	INGENIC_PIN_GROUP("mmc1-1bit-d", jz4770_mmc1_1bit_d),
> -	INGENIC_PIN_GROUP("mmc1-4bit-e", jz4770_mmc1_4bit_e),
> +	INGENIC_PIN_GROUP("mmc1-4bit-d", jz4770_mmc1_4bit_d),
>  	INGENIC_PIN_GROUP("mmc1-1bit-e", jz4770_mmc1_1bit_e),
> -	INGENIC_PIN_GROUP("nemc-data", jz4770_nemc_data),
> +	INGENIC_PIN_GROUP("mmc1-4bit-e", jz4770_mmc1_4bit_e),
> +	INGENIC_PIN_GROUP("mmc1-8bit-e", jz4770_mmc1_8bit_e),
> +	INGENIC_PIN_GROUP("nemc-8bit-data", jz4770_nemc_8bit_data),
> +	INGENIC_PIN_GROUP("nemc-16bit-data", jz4770_nemc_16bit_data),
>  	INGENIC_PIN_GROUP("nemc-cle-ale", jz4770_nemc_cle_ale),
>  	INGENIC_PIN_GROUP("nemc-addr", jz4770_nemc_addr),
>  	INGENIC_PIN_GROUP("nemc-rd-we", jz4770_nemc_rd_we),
> @@ -455,11 +460,9 @@ static const struct group_desc jz4770_groups[] =3D=20
> {
>  	INGENIC_PIN_GROUP("i2c0-data", jz4770_i2c0),
>  	INGENIC_PIN_GROUP("i2c1-data", jz4770_i2c1),
>  	INGENIC_PIN_GROUP("i2c2-data", jz4770_i2c2),
> -	INGENIC_PIN_GROUP("i2c3-data", jz4770_i2c3),
> -	INGENIC_PIN_GROUP("i2c4-data-e", jz4770_i2c4_e),
> -	INGENIC_PIN_GROUP("i2c4-data-f", jz4770_i2c4_f),
> -	INGENIC_PIN_GROUP("cim-data", jz4770_cim),
> -	INGENIC_PIN_GROUP("lcd-32bit", jz4770_lcd_32bit),
> +	INGENIC_PIN_GROUP("cim-data-8bit", jz4770_cim_8bit),
> +	INGENIC_PIN_GROUP("cim-data-12bit", jz4770_cim_12bit),
> +	INGENIC_PIN_GROUP("lcd-24bit", jz4770_lcd_24bit),
>  	{ "lcd-no-pins", },
>  	INGENIC_PIN_GROUP("pwm0", jz4770_pwm_pwm0),
>  	INGENIC_PIN_GROUP("pwm1", jz4770_pwm_pwm1),
> @@ -475,26 +478,29 @@ static const char *jz4770_uart0_groups[] =3D {=20
> "uart0-data", "uart0-hwflow", };
>  static const char *jz4770_uart1_groups[] =3D { "uart1-data",=20
> "uart1-hwflow", };
>  static const char *jz4770_uart2_groups[] =3D { "uart2-data",=20
> "uart2-hwflow", };
>  static const char *jz4770_uart3_groups[] =3D { "uart3-data",=20
> "uart3-hwflow", };
> -static const char *jz4770_uart4_groups[] =3D { "uart4-data", };
>  static const char *jz4770_mmc0_groups[] =3D {
> -	"mmc0-8bit-a", "mmc0-4bit-a", "mmc0-1bit-a",
> -	"mmc0-1bit-e", "mmc0-4bit-e",
> +	"mmc0-1bit-a", "mmc0-4bit-a",
> +	"mmc0-1bit-e", "mmc0-4bit-e", "mmc0-8bit-e",
>  };
>  static const char *jz4770_mmc1_groups[] =3D {
> -	"mmc1-1bit-d", "mmc1-4bit-d", "mmc1-1bit-e", "mmc1-4bit-e",
> +	"mmc1-1bit-d", "mmc1-4bit-d",
> +	"mmc1-1bit-e", "mmc1-4bit-e", "mmc1-8bit-e",
>  };
>  static const char *jz4770_nemc_groups[] =3D {
> -	"nemc-data", "nemc-cle-ale", "nemc-addr", "nemc-rd-we",=20
> "nemc-frd-fwe",
> +	"nemc-8bit-data", "nemc-16bit-data", "nemc-cle-ale",
> +	"nemc-addr", "nemc-rd-we", "nemc-frd-fwe",
>  };
>  static const char *jz4770_cs1_groups[] =3D { "nemc-cs1", };
> +static const char *jz4770_cs2_groups[] =3D { "nemc-cs2", };
> +static const char *jz4770_cs3_groups[] =3D { "nemc-cs3", };
> +static const char *jz4770_cs4_groups[] =3D { "nemc-cs4", };
> +static const char *jz4770_cs5_groups[] =3D { "nemc-cs5", };
>  static const char *jz4770_cs6_groups[] =3D { "nemc-cs6", };
>  static const char *jz4770_i2c0_groups[] =3D { "i2c0-data", };
>  static const char *jz4770_i2c1_groups[] =3D { "i2c1-data", };
>  static const char *jz4770_i2c2_groups[] =3D { "i2c2-data", };
> -static const char *jz4770_i2c3_groups[] =3D { "i2c3-data", };
> -static const char *jz4770_i2c4_groups[] =3D { "i2c4-data-e",=20
> "i2c4-data-f", };
> -static const char *jz4770_cim_groups[] =3D { "cim-data", };
> -static const char *jz4770_lcd_groups[] =3D { "lcd-32bit",=20
> "lcd-no-pins", };
> +static const char *jz4770_cim_groups[] =3D { "cim-data-8bit",=20
> "cim-data-12bit", };
> +static const char *jz4770_lcd_groups[] =3D { "lcd-24bit",=20
> "lcd-no-pins", };
>  static const char *jz4770_pwm0_groups[] =3D { "pwm0", };
>  static const char *jz4770_pwm1_groups[] =3D { "pwm1", };
>  static const char *jz4770_pwm2_groups[] =3D { "pwm2", };
> @@ -509,17 +515,18 @@ static const struct function_desc=20
> jz4770_functions[] =3D {
>  	{ "uart1", jz4770_uart1_groups, ARRAY_SIZE(jz4770_uart1_groups), },
>  	{ "uart2", jz4770_uart2_groups, ARRAY_SIZE(jz4770_uart2_groups), },
>  	{ "uart3", jz4770_uart3_groups, ARRAY_SIZE(jz4770_uart3_groups), },
> -	{ "uart4", jz4770_uart4_groups, ARRAY_SIZE(jz4770_uart4_groups), },
>  	{ "mmc0", jz4770_mmc0_groups, ARRAY_SIZE(jz4770_mmc0_groups), },
>  	{ "mmc1", jz4770_mmc1_groups, ARRAY_SIZE(jz4770_mmc1_groups), },
>  	{ "nemc", jz4770_nemc_groups, ARRAY_SIZE(jz4770_nemc_groups), },
>  	{ "nemc-cs1", jz4770_cs1_groups, ARRAY_SIZE(jz4770_cs1_groups), },
> +	{ "nemc-cs2", jz4770_cs2_groups, ARRAY_SIZE(jz4770_cs2_groups), },
> +	{ "nemc-cs3", jz4770_cs3_groups, ARRAY_SIZE(jz4770_cs3_groups), },
> +	{ "nemc-cs4", jz4770_cs4_groups, ARRAY_SIZE(jz4770_cs4_groups), },
> +	{ "nemc-cs5", jz4770_cs5_groups, ARRAY_SIZE(jz4770_cs5_groups), },
>  	{ "nemc-cs6", jz4770_cs6_groups, ARRAY_SIZE(jz4770_cs6_groups), },
>  	{ "i2c0", jz4770_i2c0_groups, ARRAY_SIZE(jz4770_i2c0_groups), },
>  	{ "i2c1", jz4770_i2c1_groups, ARRAY_SIZE(jz4770_i2c1_groups), },
>  	{ "i2c2", jz4770_i2c2_groups, ARRAY_SIZE(jz4770_i2c2_groups), },
> -	{ "i2c3", jz4770_i2c3_groups, ARRAY_SIZE(jz4770_i2c3_groups), },
> -	{ "i2c4", jz4770_i2c4_groups, ARRAY_SIZE(jz4770_i2c4_groups), },
>  	{ "cim", jz4770_cim_groups, ARRAY_SIZE(jz4770_cim_groups), },
>  	{ "lcd", jz4770_lcd_groups, ARRAY_SIZE(jz4770_lcd_groups), },
>  	{ "pwm0", jz4770_pwm0_groups, ARRAY_SIZE(jz4770_pwm0_groups), },
> @@ -542,6 +549,130 @@ static const struct ingenic_chip_info=20
> jz4770_chip_info =3D {
>  	.pull_downs =3D jz4770_pull_downs,
>  };
>=20
> +static int jz4780_uart2_data_pins[] =3D { 0x66, 0x67, };
> +static int jz4780_uart2_hwflow_pins[] =3D { 0x65, 0x64, };
> +static int jz4780_uart4_data_pins[] =3D { 0x54, 0x4a, };
> +static int jz4780_mmc0_8bit_a_pins[] =3D { 0x04, 0x05, 0x06, 0x07,=20
> 0x18, };
> +static int jz4780_i2c3_pins[] =3D { 0x6a, 0x6b, };
> +static int jz4780_i2c4_e_pins[] =3D { 0x8c, 0x8d, };
> +static int jz4780_i2c4_f_pins[] =3D { 0xb9, 0xb8, };
> +
> +static int jz4780_uart2_data_funcs[] =3D { 1, 1, };
> +static int jz4780_uart2_hwflow_funcs[] =3D { 1, 1, };
> +static int jz4780_uart4_data_funcs[] =3D { 2, 2, };
> +static int jz4780_mmc0_8bit_a_funcs[] =3D { 1, 1, 1, 1, 1, };
> +static int jz4780_i2c3_funcs[] =3D { 1, 1, };
> +static int jz4780_i2c4_e_funcs[] =3D { 1, 1, };
> +static int jz4780_i2c4_f_funcs[] =3D { 1, 1, };
> +
> +static const struct group_desc jz4780_groups[] =3D {
> +	INGENIC_PIN_GROUP("uart0-data", jz4770_uart0_data),
> +	INGENIC_PIN_GROUP("uart0-hwflow", jz4770_uart0_hwflow),
> +	INGENIC_PIN_GROUP("uart1-data", jz4770_uart1_data),
> +	INGENIC_PIN_GROUP("uart1-hwflow", jz4770_uart1_hwflow),
> +	INGENIC_PIN_GROUP("uart2-data", jz4780_uart2_data),
> +	INGENIC_PIN_GROUP("uart2-hwflow", jz4780_uart2_hwflow),
> +	INGENIC_PIN_GROUP("uart3-data", jz4770_uart3_data),
> +	INGENIC_PIN_GROUP("uart3-hwflow", jz4770_uart3_hwflow),
> +	INGENIC_PIN_GROUP("uart4-data", jz4780_uart4_data),
> +	INGENIC_PIN_GROUP("mmc0-1bit-a", jz4770_mmc0_1bit_a),
> +	INGENIC_PIN_GROUP("mmc0-4bit-a", jz4770_mmc0_4bit_a),
> +	INGENIC_PIN_GROUP("mmc0-8bit-a", jz4780_mmc0_8bit_a),
> +	INGENIC_PIN_GROUP("mmc0-1bit-e", jz4770_mmc0_1bit_e),
> +	INGENIC_PIN_GROUP("mmc0-4bit-e", jz4770_mmc0_4bit_e),
> +	INGENIC_PIN_GROUP("mmc1-1bit-d", jz4770_mmc1_1bit_d),
> +	INGENIC_PIN_GROUP("mmc1-4bit-d", jz4770_mmc1_4bit_d),
> +	INGENIC_PIN_GROUP("mmc1-1bit-e", jz4770_mmc1_1bit_e),
> +	INGENIC_PIN_GROUP("mmc1-4bit-e", jz4770_mmc1_4bit_e),
> +	INGENIC_PIN_GROUP("nemc-data", jz4770_nemc_8bit_data),
> +	INGENIC_PIN_GROUP("nemc-cle-ale", jz4770_nemc_cle_ale),
> +	INGENIC_PIN_GROUP("nemc-addr", jz4770_nemc_addr),
> +	INGENIC_PIN_GROUP("nemc-rd-we", jz4770_nemc_rd_we),
> +	INGENIC_PIN_GROUP("nemc-frd-fwe", jz4770_nemc_frd_fwe),
> +	INGENIC_PIN_GROUP("nemc-cs1", jz4770_nemc_cs1),
> +	INGENIC_PIN_GROUP("nemc-cs2", jz4770_nemc_cs2),
> +	INGENIC_PIN_GROUP("nemc-cs3", jz4770_nemc_cs3),
> +	INGENIC_PIN_GROUP("nemc-cs4", jz4770_nemc_cs4),
> +	INGENIC_PIN_GROUP("nemc-cs5", jz4770_nemc_cs5),
> +	INGENIC_PIN_GROUP("nemc-cs6", jz4770_nemc_cs6),
> +	INGENIC_PIN_GROUP("i2c0-data", jz4770_i2c0),
> +	INGENIC_PIN_GROUP("i2c1-data", jz4770_i2c1),
> +	INGENIC_PIN_GROUP("i2c2-data", jz4770_i2c2),
> +	INGENIC_PIN_GROUP("i2c3-data", jz4780_i2c3),
> +	INGENIC_PIN_GROUP("i2c4-data-e", jz4780_i2c4_e),
> +	INGENIC_PIN_GROUP("i2c4-data-f", jz4780_i2c4_f),
> +	INGENIC_PIN_GROUP("cim-data", jz4770_cim_8bit),
> +	INGENIC_PIN_GROUP("lcd-24bit", jz4770_lcd_24bit),
> +	{ "lcd-no-pins", },
> +	INGENIC_PIN_GROUP("pwm0", jz4770_pwm_pwm0),
> +	INGENIC_PIN_GROUP("pwm1", jz4770_pwm_pwm1),
> +	INGENIC_PIN_GROUP("pwm2", jz4770_pwm_pwm2),
> +	INGENIC_PIN_GROUP("pwm3", jz4770_pwm_pwm3),
> +	INGENIC_PIN_GROUP("pwm4", jz4770_pwm_pwm4),
> +	INGENIC_PIN_GROUP("pwm5", jz4770_pwm_pwm5),
> +	INGENIC_PIN_GROUP("pwm6", jz4770_pwm_pwm6),
> +	INGENIC_PIN_GROUP("pwm7", jz4770_pwm_pwm7),
> +};
> +
> +static const char *jz4780_uart2_groups[] =3D { "uart2-data",=20
> "uart2-hwflow", };
> +static const char *jz4780_uart4_groups[] =3D { "uart4-data", };
> +static const char *jz4780_mmc0_groups[] =3D {
> +	"mmc0-1bit-a", "mmc0-4bit-a", "mmc0-8bit-a",
> +	"mmc0-1bit-e", "mmc0-4bit-e",
> +};
> +static const char *jz4780_mmc1_groups[] =3D {
> +	"mmc1-1bit-d", "mmc1-4bit-d", "mmc1-1bit-e", "mmc1-4bit-e",
> +};
> +static const char *jz4780_nemc_groups[] =3D {
> +	"nemc-data", "nemc-cle-ale", "nemc-addr",
> +	"nemc-rd-we", "nemc-frd-fwe",
> +};
> +static const char *jz4780_i2c3_groups[] =3D { "i2c3-data", };
> +static const char *jz4780_i2c4_groups[] =3D { "i2c4-data-e",=20
> "i2c4-data-f", };
> +static const char *jz4780_cim_groups[] =3D { "cim-data", };
> +
> +static const struct function_desc jz4780_functions[] =3D {
> +	{ "uart0", jz4770_uart0_groups, ARRAY_SIZE(jz4770_uart0_groups), },
> +	{ "uart1", jz4770_uart1_groups, ARRAY_SIZE(jz4770_uart1_groups), },
> +	{ "uart2", jz4780_uart2_groups, ARRAY_SIZE(jz4780_uart2_groups), },
> +	{ "uart3", jz4770_uart3_groups, ARRAY_SIZE(jz4770_uart3_groups), },
> +	{ "uart4", jz4780_uart4_groups, ARRAY_SIZE(jz4780_uart4_groups), },
> +	{ "mmc0", jz4780_mmc0_groups, ARRAY_SIZE(jz4780_mmc0_groups), },
> +	{ "mmc1", jz4780_mmc1_groups, ARRAY_SIZE(jz4780_mmc1_groups), },
> +	{ "nemc", jz4780_nemc_groups, ARRAY_SIZE(jz4780_nemc_groups), },
> +	{ "nemc-cs1", jz4770_cs1_groups, ARRAY_SIZE(jz4770_cs1_groups), },
> +	{ "nemc-cs2", jz4770_cs2_groups, ARRAY_SIZE(jz4770_cs2_groups), },
> +	{ "nemc-cs3", jz4770_cs3_groups, ARRAY_SIZE(jz4770_cs3_groups), },
> +	{ "nemc-cs4", jz4770_cs4_groups, ARRAY_SIZE(jz4770_cs4_groups), },
> +	{ "nemc-cs5", jz4770_cs5_groups, ARRAY_SIZE(jz4770_cs5_groups), },
> +	{ "nemc-cs6", jz4770_cs6_groups, ARRAY_SIZE(jz4770_cs6_groups), },
> +	{ "i2c0", jz4770_i2c0_groups, ARRAY_SIZE(jz4770_i2c0_groups), },
> +	{ "i2c1", jz4770_i2c1_groups, ARRAY_SIZE(jz4770_i2c1_groups), },
> +	{ "i2c2", jz4770_i2c2_groups, ARRAY_SIZE(jz4770_i2c2_groups), },
> +	{ "i2c3", jz4780_i2c3_groups, ARRAY_SIZE(jz4780_i2c3_groups), },
> +	{ "i2c4", jz4780_i2c4_groups, ARRAY_SIZE(jz4780_i2c4_groups), },
> +	{ "cim", jz4780_cim_groups, ARRAY_SIZE(jz4780_cim_groups), },
> +	{ "lcd", jz4770_lcd_groups, ARRAY_SIZE(jz4770_lcd_groups), },
> +	{ "pwm0", jz4770_pwm0_groups, ARRAY_SIZE(jz4770_pwm0_groups), },
> +	{ "pwm1", jz4770_pwm1_groups, ARRAY_SIZE(jz4770_pwm1_groups), },
> +	{ "pwm2", jz4770_pwm2_groups, ARRAY_SIZE(jz4770_pwm2_groups), },
> +	{ "pwm3", jz4770_pwm3_groups, ARRAY_SIZE(jz4770_pwm3_groups), },
> +	{ "pwm4", jz4770_pwm4_groups, ARRAY_SIZE(jz4770_pwm4_groups), },
> +	{ "pwm5", jz4770_pwm5_groups, ARRAY_SIZE(jz4770_pwm5_groups), },
> +	{ "pwm6", jz4770_pwm6_groups, ARRAY_SIZE(jz4770_pwm6_groups), },
> +	{ "pwm7", jz4770_pwm7_groups, ARRAY_SIZE(jz4770_pwm7_groups), },
> +};
> +
> +static const struct ingenic_chip_info jz4780_chip_info =3D {
> +	.num_chips =3D 6,
> +	.groups =3D jz4780_groups,
> +	.num_groups =3D ARRAY_SIZE(jz4780_groups),
> +	.functions =3D jz4780_functions,
> +	.num_functions =3D ARRAY_SIZE(jz4780_functions),
> +	.pull_ups =3D jz4770_pull_ups,
> +	.pull_downs =3D jz4770_pull_downs,
> +};
> +
>  static u32 gpio_ingenic_read_reg(struct ingenic_gpio_chip *jzgc, u8=20
> reg)
>  {
>  	unsigned int val;
> @@ -1185,7 +1316,9 @@ static int __init ingenic_pinctrl_probe(struct=20
> platform_device *pdev)
>  	else
>  		jzpc->version =3D (enum jz_version)id->driver_data;
>=20
> -	if (jzpc->version >=3D ID_JZ4770)
> +	if (jzpc->version >=3D ID_JZ4780)
> +		chip_info =3D &jz4780_chip_info;
> +	else if (jzpc->version >=3D ID_JZ4770)
>  		chip_info =3D &jz4770_chip_info;
>  	else if (jzpc->version >=3D ID_JZ4725B)
>  		chip_info =3D &jz4725b_chip_info;
> --
> 2.7.4
>=20
>=20
=

