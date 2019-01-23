Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2342FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57092085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="X2W9nfXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfAWR1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:27:47 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:36324 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWR1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548264463; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SNmejVZ6E9h68DkJr+OJGS+RH6VpPmkQYhsz5XTWz8=;
        b=X2W9nfXy6rZLMTLJrmOouqp8XD2FGxdj5QVqxAfk65zlVe1cTztLy37Zc6ng7MIDWi1x0a
        wt3IESMC5Ra2dj7sSSD1bT6pkW7a5cE/a6t+dOFwPBedSgQOqeegAADn0TVxT4VqlIbJYB
        7tesc97JZSlaU8oBZkkpsVp7ujBW4As=
Date:   Wed, 23 Jan 2019 14:27:25 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 05/26] clocksource: Add driver for the Ingenic JZ47xx
 OST
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me,
        Maarten ter Huurne <maarten@treewalker.org>
Message-Id: <1548264445.3173.2@crapouillou.net>
In-Reply-To: <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-6-paul@crapouillou.net>
        <CA+7wUsxNN2SL9_7tDh0DiBAgdUwxd_osgmi=09HP7110Tm0DYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(re-send, in plain text this time, sorry for those who got it twice)


Le mer. 23 janv. 2019 =E0 9:58, Mathieu Malaterre <malat@debian.org> a=20
=E9crit :
> On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  From: Maarten ter Huurne <maarten@treewalker.org>
>>=20
>>  OST is the OS Timer, a 64-bit timer/counter with buffered reading.
>>=20
>>  SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
>>  JZ4780 have a 64-bit OST.
>>=20
>>  This driver will register both a clocksource and a sched_clock to=20
>> the
>>  system.
>>=20
>>  Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>       v5: New patch
>>=20
>>       v6: - Get rid of SoC IDs; pass pointer to ingenic_ost_soc_info=20
>> as
>>             devicetree match data instead.
>>           - Use device_get_match_data() instead of the of_* variant
>>           - Handle error of dev_get_regmap() properly
>>=20
>>       v7: Fix section mismatch by using=20
>> builtin_platform_driver_probe()
>>=20
>>       v8: builtin_platform_driver_probe() does not work anymore in
>>           4.20-rc6? The probe function won't be called. Work around=20
>> this
>>           for now by using late_initcall.
>>=20
>>   drivers/clocksource/Kconfig       |   8 ++
>>   drivers/clocksource/Makefile      |   1 +
>>   drivers/clocksource/ingenic-ost.c | 215=20
>> ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 224 insertions(+)
>>   create mode 100644 drivers/clocksource/ingenic-ost.c
>>=20
>>  diff --git a/drivers/clocksource/Kconfig=20
>> b/drivers/clocksource/Kconfig
>>  index 4e69af15c3e7..e0646878b0de 100644
>>  --- a/drivers/clocksource/Kconfig
>>  +++ b/drivers/clocksource/Kconfig
>>  @@ -648,4 +648,12 @@ config INGENIC_TIMER
>>          help
>>            Support for the timer/counter unit of the Ingenic JZ SoCs.
>>=20
>>  +config INGENIC_OST
>>  +       bool "Ingenic JZ47xx Operating System Timer"
>>  +       depends on MIPS || COMPILE_TEST
>>  +       depends on COMMON_CLK
>>  +       select INGENIC_TIMER
>>  +       help
>>  +         Support for the OS Timer of the Ingenic JZ4770 or similar=20
>> SoC.
>>  +
>>   endmenu
>>  diff --git a/drivers/clocksource/Makefile=20
>> b/drivers/clocksource/Makefile
>>  index 7c8f790dcf67..7faa8108574a 100644
>>  --- a/drivers/clocksource/Makefile
>>  +++ b/drivers/clocksource/Makefile
>>  @@ -75,6 +75,7 @@ obj-$(CONFIG_ASM9260_TIMER)           +=3D=20
>> asm9260_timer.o
>>   obj-$(CONFIG_H8300_TMR8)               +=3D h8300_timer8.o
>>   obj-$(CONFIG_H8300_TMR16)              +=3D h8300_timer16.o
>>   obj-$(CONFIG_H8300_TPU)                        +=3D h8300_tpu.o
>>  +obj-$(CONFIG_INGENIC_OST)              +=3D ingenic-ost.o
>>   obj-$(CONFIG_INGENIC_TIMER)            +=3D ingenic-timer.o
>>   obj-$(CONFIG_CLKSRC_ST_LPC)            +=3D clksrc_st_lpc.o
>>   obj-$(CONFIG_X86_NUMACHIP)             +=3D numachip.o
>>  diff --git a/drivers/clocksource/ingenic-ost.c=20
>> b/drivers/clocksource/ingenic-ost.c
>>  new file mode 100644
>>  index 000000000000..cc0fee3efd29
>>  --- /dev/null
>>  +++ b/drivers/clocksource/ingenic-ost.c
>>  @@ -0,0 +1,215 @@
>>  +// SPDX-License-Identifier: GPL-2.0
>>  +/*
>>  + * JZ47xx SoCs TCU Operating System Timer driver
>>  + *
>>  + * Copyright (C) 2016 Maarten ter Huurne <maarten@treewalker.org>
>>  + * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
>>  + */
>>  +
>>  +#include <linux/clk.h>
>>  +#include <linux/clocksource.h>
>>  +#include <linux/mfd/ingenic-tcu.h>
>>  +#include <linux/of.h>
>>  +#include <linux/platform_device.h>
>>  +#include <linux/pm.h>
>>  +#include <linux/regmap.h>
>>  +#include <linux/sched_clock.h>
>>  +
>>  +#include "ingenic-timer.h"
>>  +
>>  +#define TCU_OST_TCSR_MASK      0xc0
>>  +#define TCU_OST_TCSR_CNT_MD    BIT(15)
>>  +
>>  +#define TCU_OST_CHANNEL                15
>>  +
>>  +struct ingenic_ost_soc_info {
>>  +       bool is64bit;
>>  +};
>>  +
>>  +struct ingenic_ost {
>>  +       struct regmap *map;
>>  +       struct clk *clk;
>>  +
>>  +       struct clocksource cs;
>>  +};
>>  +
>>  +static u64 notrace ingenic_ost_read_cntl(void)
>>  +{
>>  +       /* Bypass the regmap here as we must return as soon as=20
>> possible */
>>  +       return readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
>>  +}
>>  +
>>  +static u64 notrace ingenic_ost_read_cnth(void)
>>  +{
>>  +       /* Bypass the regmap here as we must return as soon as=20
>> possible */
>>  +       return readl(ingenic_tcu_base + TCU_REG_OST_CNTH);
>>  +}
>>  +
>>  +static u64 notrace ingenic_ost_clocksource_read(struct clocksource=20
>> *cs)
>>  +{
>>  +       u32 val1, val2;
>>  +       u64 count, recount;
>>  +       s64 diff;
>>  +
>>  +       /*
>>  +        * The buffering of the upper 32 bits of the timer prevents=20
>> wrong
>>  +        * results from the bottom 32 bits overflowing due to the=20
>> timer ticking
>>  +        * along. However, it does not prevent wrong results from=20
>> simultaneous
>>  +        * reads of the timer, which could reset the buffer=20
>> mid-read.
>>  +        * Since this kind of wrong read can happen only when the=20
>> bottom bits
>>  +        * overflow, there will be minutes between wrong reads, so=20
>> if we read
>>  +        * twice in succession, at least one of the reads will be=20
>> correct.
>>  +        */
>>  +
>>  +       /* Bypass the regmap here as we must return as soon as=20
>> possible */
>>  +       val1 =3D readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
>>  +       val2 =3D readl(ingenic_tcu_base + TCU_REG_OST_CNTHBUF);
>>  +       count =3D (u64)val1 | (u64)val2 << 32;
>>  +
>>  +       val1 =3D readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
>>  +       val2 =3D readl(ingenic_tcu_base + TCU_REG_OST_CNTHBUF);
>>  +       recount =3D (u64)val1 | (u64)val2 << 32;
>>  +
>>  +       /*
>>  +        * A wrong read will produce a result that is 1<<32 too=20
>> high: the bottom
>>  +        * part from before overflow and the upper part from after=20
>> overflow.
>>  +        * Therefore, the lower value of the two reads is the=20
>> correct value.
>>  +        */
>>  +
>>  +       diff =3D (s64)(recount - count);
>>  +       if (unlikely(diff < 0))
>>  +               count =3D recount;
>>  +
>>  +       return count;
>>  +}
>>  +
>>  +static int __init ingenic_ost_probe(struct platform_device *pdev)
>>  +{
>>  +       const struct ingenic_ost_soc_info *soc_info;
>>  +       struct device *dev =3D &pdev->dev;
>>  +       struct ingenic_ost *ost;
>>  +       struct clocksource *cs;
>>  +       unsigned long rate, flags;
>>  +       int err;
>>  +
>>  +       soc_info =3D device_get_match_data(dev);
>>  +       if (!soc_info)
>>  +               return -EINVAL;
>>  +
>>  +       ost =3D devm_kzalloc(dev, sizeof(*ost), GFP_KERNEL);
>>  +       if (!ost)
>>  +               return -ENOMEM;
>>  +
>>  +       ost->map =3D dev_get_regmap(dev->parent, NULL);
>>  +       if (!ost->map) {
>>  +               dev_err(dev, "regmap not found\n");
>>  +               return -EINVAL;
>>  +       }
>>  +
>>  +       ost->clk =3D devm_clk_get(dev, "ost");
>>  +       if (IS_ERR(ost->clk))
>>  +               return PTR_ERR(ost->clk);
>>  +
>>  +       err =3D clk_prepare_enable(ost->clk);
>>  +       if (err)
>>  +               return err;
>>  +
>>  +       /* Clear counter high/low registers */
>>  +       if (soc_info->is64bit)
>>  +               regmap_write(ost->map, TCU_REG_OST_CNTL, 0);
>>  +       regmap_write(ost->map, TCU_REG_OST_CNTH, 0);
>>  +
>>  +       /* Don't reset counter at compare value. */
>>  +       regmap_update_bits(ost->map, TCU_REG_OST_TCSR,
>>  +                          TCU_OST_TCSR_MASK, TCU_OST_TCSR_CNT_MD);
>>  +
>>  +       rate =3D clk_get_rate(ost->clk);
>>  +
>>  +       /* Enable OST TCU channel */
>>  +       regmap_write(ost->map, TCU_REG_TESR, BIT(TCU_OST_CHANNEL));
>>  +
>>  +       cs =3D &ost->cs;
>>  +       cs->name        =3D "ingenic-ost";
>>  +       cs->rating      =3D 320;
>>  +       cs->flags       =3D CLOCK_SOURCE_IS_CONTINUOUS;
>>  +
>>  +       if (soc_info->is64bit) {
>>  +               cs->mask =3D CLOCKSOURCE_MASK(64);
>>  +               cs->read =3D ingenic_ost_clocksource_read;
>>  +       } else {
>>  +               cs->mask =3D CLOCKSOURCE_MASK(32);
>>  +               cs->read =3D (u64 (*)(struct clocksource=20
>> *))ingenic_ost_read_cnth;
>=20
> The function is declared as ingenic_ost_read_cnth(void), are you sure
> this is going to work ?

Hence the cast. The clocksource pointer passed as the first argument=20
will
simply be ignored by the function. This works fine.

>>  +       }
>>  +
>>  +       err =3D clocksource_register_hz(cs, rate);
>>  +       if (err) {
>>  +               dev_err(dev, "clocksource registration failed:=20
>> %d\n", err);
>>  +               clk_disable_unprepare(ost->clk);
>>  +               return err;
>>  +       }
>>  +
>>  +       /* Cannot register a sched_clock with interrupts on */
>>  +       local_irq_save(flags);
>>  +       if (soc_info->is64bit)
>>  +               sched_clock_register(ingenic_ost_read_cntl, 32,=20
>> rate);
>>  +       else
>>  +               sched_clock_register(ingenic_ost_read_cnth, 32,=20
>> rate);
>>  +       local_irq_restore(flags);
>>  +
>>  +       return 0;
>>  +}
>>  +
>>  +#ifdef CONFIG_PM_SLEEP
>>  +static int ingenic_ost_suspend(struct device *dev)
>>  +{
>>  +       struct ingenic_ost *ost =3D dev_get_drvdata(dev);
>>  +
>>  +       clk_disable(ost->clk);
>>  +       return 0;
>>  +}
>>  +
>>  +static int ingenic_ost_resume(struct device *dev)
>>  +{
>>  +       struct ingenic_ost *ost =3D dev_get_drvdata(dev);
>>  +
>>  +       return clk_enable(ost->clk);
>>  +}
>>  +
>>  +static SIMPLE_DEV_PM_OPS(ingenic_ost_pm_ops, ingenic_ost_suspend,
>>  +                        ingenic_ost_resume);
>>  +#define INGENIC_OST_PM_OPS (&ingenic_ost_pm_ops)
>>  +#else
>>  +#define INGENIC_OST_PM_OPS NULL
>>  +#endif /* CONFIG_PM_SUSPEND */
>>  +
>>  +static const struct ingenic_ost_soc_info jz4725b_ost_soc_info =3D {
>>  +       .is64bit =3D false,
>>  +};
>>  +
>>  +static const struct ingenic_ost_soc_info jz4770_ost_soc_info =3D {
>>  +       .is64bit =3D true,
>>  +};
>>  +
>>  +static const struct of_device_id ingenic_ost_of_match[] =3D {
>>  +       { .compatible =3D "ingenic,jz4725b-ost", .data =3D=20
>> &jz4725b_ost_soc_info, },
>>  +       { .compatible =3D "ingenic,jz4770-ost",  .data =3D=20
>> &jz4770_ost_soc_info,  },
>>  +       { }
>>  +};
>>  +
>>  +static struct platform_driver ingenic_ost_driver =3D {
>>  +       .driver =3D {
>>  +               .name   =3D "ingenic-ost",
>>  +               .pm     =3D INGENIC_OST_PM_OPS,
>>  +               .of_match_table =3D ingenic_ost_of_match,
>>  +       },
>>  +};
>>  +
>>  +/* FIXME: Using device_initcall (or buildin_platform_driver_probe)=20
>> results
>>  + * in the driver not being probed at all. It worked in 4.18...
>>  + */
>>  +static int __init ingenic_ost_drv_register(void)
>>  +{
>>  +       return platform_driver_probe(&ingenic_ost_driver,
>>  +                                    ingenic_ost_probe);
>>  +}
>>  +late_initcall(ingenic_ost_drv_register);
>>  --
>>  2.11.0
>>=20
=

