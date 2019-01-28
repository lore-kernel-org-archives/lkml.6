Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A22C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FDA20882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nS6r1ixE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfA1SSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:18:30 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40794 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1SS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548699506; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqOIPFqBna+9AZqz3Mi7Jy50GTSC3er1awuk6gBkU3c=;
        b=nS6r1ixEfH92Oztu17kE1u/axKQESujmovVIQkRgoXFqL90dhm0/HYui3I+htVKhW/H+BW
        wYyq4RFQIDMxxoKiCzq8CPkap+ixXoIVWCxbwobUtJvzjwGU4l1mMnaxJOH5aM9t+ZcYei
        atSCo/UQLyHVJptyesdzAtLG6Nm7XUA=
Date:   Mon, 28 Jan 2019 15:18:15 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/3] Pinctrl: Ingenic: Unify the function name prefix
 to "ingenic_gpio_".
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul.burton@mips.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com, Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
Message-Id: <1548699495.7511.2@crapouillou.net>
In-Reply-To: <1548688799-129840-4-git-send-email-zhouyanjie@zoho.com>
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
        <1548688799-129840-1-git-send-email-zhouyanjie@zoho.com>
        <1548688799-129840-4-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 28 janv. 2019 =E0 12:19, Zhou Yanjie <zhouyanjie@zoho.com> a=20
=E9crit :
> From: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
>=20
> In the original code, some function names begin with "ingenic_gpio_",
> and some with "gpio_ingenic_". For the sake of uniform style,
> all of them are changed to the beginning of "ingenic_gpio_".
>=20
> Signed-off-by: Zhou Yanjie <zhouyanjie@cduestc.edu.cn>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

> ---
>  drivers/pinctrl/pinctrl-ingenic.c | 46=20
> +++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c=20
> b/drivers/pinctrl/pinctrl-ingenic.c
> index 6501f35..2b3f7e4 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -715,7 +715,7 @@ static const struct ingenic_chip_info=20
> jz4780_chip_info =3D {
>  	.pull_downs =3D jz4770_pull_downs,
>  };
>=20
> -static u32 gpio_ingenic_read_reg(struct ingenic_gpio_chip *jzgc, u8=20
> reg)
> +static u32 ingenic_gpio_read_reg(struct ingenic_gpio_chip *jzgc, u8=20
> reg)
>  {
>  	unsigned int val;
>=20
> @@ -724,7 +724,7 @@ static u32 gpio_ingenic_read_reg(struct=20
> ingenic_gpio_chip *jzgc, u8 reg)
>  	return (u32) val;
>  }
>=20
> -static void gpio_ingenic_set_bit(struct ingenic_gpio_chip *jzgc,
> +static void ingenic_gpio_set_bit(struct ingenic_gpio_chip *jzgc,
>  		u8 reg, u8 offset, bool set)
>  {
>  	if (set)
> @@ -738,7 +738,7 @@ static void gpio_ingenic_set_bit(struct=20
> ingenic_gpio_chip *jzgc,
>  static inline bool ingenic_gpio_get_value(struct ingenic_gpio_chip=20
> *jzgc,
>  					  u8 offset)
>  {
> -	unsigned int val =3D gpio_ingenic_read_reg(jzgc, GPIO_PIN);
> +	unsigned int val =3D ingenic_gpio_read_reg(jzgc, GPIO_PIN);
>=20
>  	return !!(val & BIT(offset));
>  }
> @@ -747,9 +747,9 @@ static void ingenic_gpio_set_value(struct=20
> ingenic_gpio_chip *jzgc,
>  				   u8 offset, int value)
>  {
>  	if (jzgc->jzpc->version >=3D ID_JZ4770)
> -		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_PAT0, offset, !!value);
> +		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_PAT0, offset, !!value);
>  	else
> -		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_DATA, offset, !!value);
> +		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_DATA, offset, !!value);
>  }
>=20
>  static void irq_set_type(struct ingenic_gpio_chip *jzgc,
> @@ -767,21 +767,21 @@ static void irq_set_type(struct=20
> ingenic_gpio_chip *jzgc,
>=20
>  	switch (type) {
>  	case IRQ_TYPE_EDGE_RISING:
> -		gpio_ingenic_set_bit(jzgc, reg2, offset, true);
> -		gpio_ingenic_set_bit(jzgc, reg1, offset, true);
> +		ingenic_gpio_set_bit(jzgc, reg2, offset, true);
> +		ingenic_gpio_set_bit(jzgc, reg1, offset, true);
>  		break;
>  	case IRQ_TYPE_EDGE_FALLING:
> -		gpio_ingenic_set_bit(jzgc, reg2, offset, false);
> -		gpio_ingenic_set_bit(jzgc, reg1, offset, true);
> +		ingenic_gpio_set_bit(jzgc, reg2, offset, false);
> +		ingenic_gpio_set_bit(jzgc, reg1, offset, true);
>  		break;
>  	case IRQ_TYPE_LEVEL_HIGH:
> -		gpio_ingenic_set_bit(jzgc, reg2, offset, true);
> -		gpio_ingenic_set_bit(jzgc, reg1, offset, false);
> +		ingenic_gpio_set_bit(jzgc, reg2, offset, true);
> +		ingenic_gpio_set_bit(jzgc, reg1, offset, false);
>  		break;
>  	case IRQ_TYPE_LEVEL_LOW:
>  	default:
> -		gpio_ingenic_set_bit(jzgc, reg2, offset, false);
> -		gpio_ingenic_set_bit(jzgc, reg1, offset, false);
> +		ingenic_gpio_set_bit(jzgc, reg2, offset, false);
> +		ingenic_gpio_set_bit(jzgc, reg1, offset, false);
>  		break;
>  	}
>  }
> @@ -791,7 +791,7 @@ static void ingenic_gpio_irq_mask(struct irq_data=20
> *irqd)
>  	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(irqd);
>  	struct ingenic_gpio_chip *jzgc =3D gpiochip_get_data(gc);
>=20
> -	gpio_ingenic_set_bit(jzgc, GPIO_MSK, irqd->hwirq, true);
> +	ingenic_gpio_set_bit(jzgc, GPIO_MSK, irqd->hwirq, true);
>  }
>=20
>  static void ingenic_gpio_irq_unmask(struct irq_data *irqd)
> @@ -799,7 +799,7 @@ static void ingenic_gpio_irq_unmask(struct=20
> irq_data *irqd)
>  	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(irqd);
>  	struct ingenic_gpio_chip *jzgc =3D gpiochip_get_data(gc);
>=20
> -	gpio_ingenic_set_bit(jzgc, GPIO_MSK, irqd->hwirq, false);
> +	ingenic_gpio_set_bit(jzgc, GPIO_MSK, irqd->hwirq, false);
>  }
>=20
>  static void ingenic_gpio_irq_enable(struct irq_data *irqd)
> @@ -809,9 +809,9 @@ static void ingenic_gpio_irq_enable(struct=20
> irq_data *irqd)
>  	int irq =3D irqd->hwirq;
>=20
>  	if (jzgc->jzpc->version >=3D ID_JZ4770)
> -		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
> +		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
>  	else
> -		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, true);
> +		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, true);
>=20
>  	ingenic_gpio_irq_unmask(irqd);
>  }
> @@ -825,9 +825,9 @@ static void ingenic_gpio_irq_disable(struct=20
> irq_data *irqd)
>  	ingenic_gpio_irq_mask(irqd);
>=20
>  	if (jzgc->jzpc->version >=3D ID_JZ4770)
> -		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_INT, irq, false);
> +		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, false);
>  	else
> -		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
> +		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
>  }
>=20
>  static void ingenic_gpio_irq_ack(struct irq_data *irqd)
> @@ -850,9 +850,9 @@ static void ingenic_gpio_irq_ack(struct irq_data=20
> *irqd)
>  	}
>=20
>  	if (jzgc->jzpc->version >=3D ID_JZ4770)
> -		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_FLAG, irq, false);
> +		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_FLAG, irq, false);
>  	else
> -		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_DATA, irq, true);
> +		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_DATA, irq, true);
>  }
>=20
>  static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned=20
> int type)
> @@ -907,9 +907,9 @@ static void ingenic_gpio_irq_handler(struct=20
> irq_desc *desc)
>  	chained_irq_enter(irq_chip, desc);
>=20
>  	if (jzgc->jzpc->version >=3D ID_JZ4770)
> -		flag =3D gpio_ingenic_read_reg(jzgc, JZ4770_GPIO_FLAG);
> +		flag =3D ingenic_gpio_read_reg(jzgc, JZ4770_GPIO_FLAG);
>  	else
> -		flag =3D gpio_ingenic_read_reg(jzgc, JZ4740_GPIO_FLAG);
> +		flag =3D ingenic_gpio_read_reg(jzgc, JZ4740_GPIO_FLAG);
>=20
>  	for_each_set_bit(i, &flag, 32)
>  		generic_handle_irq(irq_linear_revmap(gc->irq.domain, i));
> --
> 2.7.4
>=20
>=20
=

