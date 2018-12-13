Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69125C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188EC20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="S1aL6XSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188EC20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeLMJsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:48:39 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39916 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeLMJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:48:38 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so1090024iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JnzthssgCHCyfK4Tvc+YTxwLve2ENC9DKMVrmVFkkUs=;
        b=S1aL6XSnLAEEq5tgGi+0Z/TjocDAIoK1QWrFbT8riEH5DN9F6zBZnWtdJMzhPu/5Fc
         aRQg+w+D6YRhiVmMdADgwoqPtTduqhjtrkGfjLrhq+fnOE242KMKV7dwRhE7LXq3AqgZ
         lSiuQR3qN4Yr99Too7Jr3Jdr6hUli0yOW/CPA9bxvpLj+Y4Tfx8imy4A79bzGdH5W2U+
         DT9YogT09N40z/2YX6SICj0jxnMXGy8X7XUaYtk8dqhz+DuW8QOtAXJCtaBglLGqqBO6
         LAH8X7B7ojMl5O6lzuO3WQ3NVdqPfrg+F76SDB5hGsPm+woS2DxfkUlcILtmh5otpI+j
         dOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JnzthssgCHCyfK4Tvc+YTxwLve2ENC9DKMVrmVFkkUs=;
        b=XRRLY38aTf+PLqCPPeHAOySo+kKdpmqGsBEA9BR1sczV6gjhQ08krXVy2sbJYV51qN
         x1FGO2J2250ZYuAMR0JumroX34m503f+xQg+LoxtU0+Nmk5C6R/oG1QzJ0MjUcb+o9G/
         X8H9fdNnAcEq00LduTIgo9h/yoekDhXdzlhLLsehW4xyGep/kXya+jkurdRQXgQ6ujT4
         bWYOKjoaAHM+a9Y55C17oI+ILQ6bROZX0Bg43eqIaXTuLA0ikmamPoN/NosqSNNcoVhb
         U3PG1zbARKjczkGKowbUj3/a9fjBVvD3ZjYemMRc/VT3Ah8fpjM5SBXb8xg6UstHcFMZ
         f9ZQ==
X-Gm-Message-State: AA+aEWb6FjcoASNos2flnD7T9C/4IXCZ2qUpGlHl3N0QaVy8Sa+Jd97/
        vOBEfl/4887Rxbu4rlBUQvrqTU89f3ZPaTIskfIWjA==
X-Google-Smtp-Source: AFSGD/VqX131FiAO8gwmgKTGw/XoePJFck5bK4hOp4vP43oQa0SRKlHay9q3ILHwulwNuIbRs6A3oP2rYIFVmWis6HI=
X-Received: by 2002:a5e:aa06:: with SMTP id s6mr1864050ioe.187.1544694517480;
 Thu, 13 Dec 2018 01:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20181207130452.1910-1-brgl@bgdev.pl>
In-Reply-To: <20181207130452.1910-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 13 Dec 2018 10:48:26 +0100
Message-ID: <CAMRc=MeSr80=k10foLpQZwos2zRnGtD42mQA2bcKXXL_WEWLRA@mail.gmail.com>
Subject: Re: [PATCH v2] regmap: irq: handle HW using separate rising/falling
 edge interrupts
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 7 gru 2018 o 14:04 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a)=
:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Some interrupt controllers use separate bits for controlling rising
> and falling edge interrupts in the mask register i.e. they have one
> interrupt for rising edge and one for falling.
>
> We already handle the case where we have a single interrupt in the
> mask register and a separate type configuration register.
>
> Add a new switch to regmap_irq_chip which tells the framework to use
> the mask_base address for configuring the edge of the interrupts that
> define type_falling/rising_mask values.
>
> For such interrupts we never update the type_base bits. For interrupts
> that don't define type masks or their regmap irq chip doesn't set the
> type_in_mask to true everything stays the same.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> This is a second try at supporting HW which uses separate interrupts
> for rising/falling edge events.
>
> This time we're adding an explicit flag for such chips.
>
> Below is an example of the regmap irq chip configuration that makes
> use of this new feature:
>
> static const struct regmap_irq foobar_irqs[] =3D {
>         /*
>          * Make two interrupts into a single virtual irq with
>          * configurable edge.
>          */
>         [FOOBAR_INT_EDGE] =3D {
>                 .reg_offset             =3D FOOBAR_INT_GLBL_OFFSET,
>                 /* mask is two bits here but regmap handles it nicely */
>                 .mask                   =3D FOOBAR_INT_GPIO_MSK,
>                 .type_falling_mask      =3D FOOBAR_INT_GPIO_F_MSK,
>                 .type_rising_mask       =3D FOOBAR_INT_GPIO_R_MSK,
>         },
>         /* Regular interrupt, nothing changes. */
>         [FOOBAR_INT_NOEDGE] =3D {
>                 .reg_offset             =3D FOOBAR_INT_GLBL_OFFSET,
>                 .mask                   =3D FOOBAR_INT_FOO_MSK,
>         },
>
> static struct regmap_irq_chip foobar_irq_chip =3D {
>         .name                   =3D "foobar-irq",
>         .irqs                   =3D foobar_irqs,
>         .num_irqs               =3D ARRAY_SIZE(foobar_irqs),
>         .num_regs               =3D 2,
>         .status_base            =3D FOOBAR_REG_INT_GLBL,
>         .mask_base              =3D FOOBAR_REG_INTM_GLBL,
>         .type_in_mask           =3D true,
>         /* NOTE: we're not defining type_base here. */
> };
>

Hi Mark,

would you be willing to pick this one up for v4.21 or do you have some
objections? If it would go in in the next merge window then it would
make it easier to merge my driver afterwards since I could already
make use of it.

Bart

>  drivers/base/regmap/regmap-irq.c | 64 ++++++++++++++++++++++----------
>  include/linux/regmap.h           |  4 ++
>  2 files changed, 48 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regma=
p-irq.c
> index 429ca8ed7e51..603b1554f81c 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -157,20 +157,23 @@ static void regmap_irq_sync_unlock(struct irq_data =
*data)
>                 }
>         }
>
> -       for (i =3D 0; i < d->chip->num_type_reg; i++) {
> -               if (!d->type_buf_def[i])
> -                       continue;
> -               reg =3D d->chip->type_base +
> -                       (i * map->reg_stride * d->type_reg_stride);
> -               if (d->chip->type_invert)
> -                       ret =3D regmap_irq_update_bits(d, reg,
> -                               d->type_buf_def[i], ~d->type_buf[i]);
> -               else
> -                       ret =3D regmap_irq_update_bits(d, reg,
> -                               d->type_buf_def[i], d->type_buf[i]);
> -               if (ret !=3D 0)
> -                       dev_err(d->map->dev, "Failed to sync type in %x\n=
",
> -                               reg);
> +       /* Don't update the type bits if we're using mask bits for irq ty=
pe. */
> +       if (!d->chip->type_in_mask) {
> +               for (i =3D 0; i < d->chip->num_type_reg; i++) {
> +                       if (!d->type_buf_def[i])
> +                               continue;
> +                       reg =3D d->chip->type_base +
> +                               (i * map->reg_stride * d->type_reg_stride=
);
> +                       if (d->chip->type_invert)
> +                               ret =3D regmap_irq_update_bits(d, reg,
> +                                       d->type_buf_def[i], ~d->type_buf[=
i]);
> +                       else
> +                               ret =3D regmap_irq_update_bits(d, reg,
> +                                       d->type_buf_def[i], d->type_buf[i=
]);
> +                       if (ret !=3D 0)
> +                               dev_err(d->map->dev, "Failed to sync type=
 in %x\n",
> +                                       reg);
> +               }
>         }
>
>         if (d->chip->runtime_pm)
> @@ -194,8 +197,27 @@ static void regmap_irq_enable(struct irq_data *data)
>         struct regmap_irq_chip_data *d =3D irq_data_get_irq_chip_data(dat=
a);
>         struct regmap *map =3D d->map;
>         const struct regmap_irq *irq_data =3D irq_to_regmap_irq(d, data->=
hwirq);
> +       unsigned int mask, type;
> +
> +       type =3D irq_data->type_falling_mask | irq_data->type_rising_mask=
;
> +
> +       /*
> +        * The type_in_mask flag means that the underlying hardware uses
> +        * separate mask bits for rising and falling edge interrupts, but
> +        * we want to make them into a single virtual interrupt with
> +        * configurable edge.
> +        *
> +        * If the interrupt we're enabling defines the falling or rising
> +        * masks then instead of using the regular mask bits for this
> +        * interrupt, use the value previously written to the type buffer
> +        * at the corresponding offset in regmap_irq_set_type().
> +        */
> +       if (d->chip->type_in_mask && type)
> +               mask =3D d->type_buf[irq_data->reg_offset / map->reg_stri=
de];
> +       else
> +               mask =3D irq_data->mask;
>
> -       d->mask_buf[irq_data->reg_offset / map->reg_stride] &=3D ~irq_dat=
a->mask;
> +       d->mask_buf[irq_data->reg_offset / map->reg_stride] &=3D ~mask;
>  }
>
>  static void regmap_irq_disable(struct irq_data *data)
> @@ -430,6 +452,7 @@ int regmap_add_irq_chip(struct regmap *map, int irq, =
int irq_flags,
>         struct regmap_irq_chip_data *d;
>         int i;
>         int ret =3D -ENOMEM;
> +       int num_type_reg;
>         u32 reg;
>         u32 unmask_offset;
>
> @@ -479,13 +502,14 @@ int regmap_add_irq_chip(struct regmap *map, int irq=
, int irq_flags,
>                         goto err_alloc;
>         }
>
> -       if (chip->num_type_reg) {
> -               d->type_buf_def =3D kcalloc(chip->num_type_reg,
> -                                       sizeof(unsigned int), GFP_KERNEL)=
;
> +       num_type_reg =3D chip->type_in_mask ? chip->num_regs : chip->num_=
type_reg;
> +       if (num_type_reg) {
> +               d->type_buf_def =3D kcalloc(num_type_reg,
> +                                         sizeof(unsigned int), GFP_KERNE=
L);
>                 if (!d->type_buf_def)
>                         goto err_alloc;
>
> -               d->type_buf =3D kcalloc(chip->num_type_reg, sizeof(unsign=
ed int),
> +               d->type_buf =3D kcalloc(num_type_reg, sizeof(unsigned int=
),
>                                       GFP_KERNEL);
>                 if (!d->type_buf)
>                         goto err_alloc;
> @@ -600,7 +624,7 @@ int regmap_add_irq_chip(struct regmap *map, int irq, =
int irq_flags,
>                 }
>         }
>
> -       if (chip->num_type_reg) {
> +       if (chip->num_type_reg && !chip->type_in_mask) {
>                 for (i =3D 0; i < chip->num_irqs; i++) {
>                         reg =3D chip->irqs[i].type_reg_offset / map->reg_=
stride;
>                         d->type_buf_def[reg] |=3D chip->irqs[i].type_risi=
ng_mask |
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index a367d59c301d..b7aa50cfb306 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1131,6 +1131,9 @@ struct regmap_irq {
>   * @ack_invert:  Inverted ack register: cleared bits for ack.
>   * @wake_invert: Inverted wake register: cleared bits are wake enabled.
>   * @type_invert: Invert the type flags.
> + * @type_in_mask: Use the mask registers for controlling irq type. For
> + *                interrupts defining type_rising/falling_mask use mask_=
base
> + *                for edge configuration and never update bits in type_b=
ase.
>   * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
>   *
>   * @num_regs:    Number of registers in each control bank.
> @@ -1169,6 +1172,7 @@ struct regmap_irq_chip {
>         bool wake_invert:1;
>         bool runtime_pm:1;
>         bool type_invert:1;
> +       bool type_in_mask:1;
>
>         int num_regs;
>
> --
> 2.19.1
>
