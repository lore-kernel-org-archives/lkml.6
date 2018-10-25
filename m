Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2862EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E5D2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbpLqCkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E5D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJYVNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:13:33 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33922 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeJYVNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:13:33 -0400
Received: by mail-oi1-f194.google.com with SMTP id 20-v6so6511675oip.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tnX4dPusBVgNmVMCIxGh34dcxxkyv7EW/5RlLHJTRtQ=;
        b=PbpLqCkSpTdgOx5Phu/gw5wQGYq0WnFakIu2ubfsRN//eQLJr1yYbvebQrB5ears9D
         eLnJkIrNM7MtQPIa8a0rTcpXkVvCSHVeALvX5AS4eaq8t7E1N/7CrLbktMY4UaOT+MGf
         wz6c08NqCo3lbt1xiGJ4ZmXt9CcXcybV0LaRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tnX4dPusBVgNmVMCIxGh34dcxxkyv7EW/5RlLHJTRtQ=;
        b=ADmOjG8WV7j9P2vFI3BItkkqIkNrXww8Vu2nuR+0tGHs+0s8NzstKiqQi8LMqh+PGJ
         QDlOcht2rqvhhDR3e1HKgJYwEajc3PCY287jReAO2hOZhOWOHeTZx/5OdXrIuCPyMMEc
         93cw4FU8XW9PZIW4p+cVar/a7S0yZci162DfxU8GAKMWchdMrkJQescVkfEKv/Nrwmrz
         IaXqe1MeKZXV5VbuGTGa0z+wkJP8LLbJgcqroZ6/ayBTB/Gao6pX7eCu3+ZDu2per2En
         gW+OPPxnoDdgc+qipvaOJHoOq7jR3Q+xZShjXt3K+S0pPKXrDB6DZBpy9eQLbXUtp7mT
         nuMQ==
X-Gm-Message-State: AGRZ1gIw+sycWjG9Wm+TQItKDD+5nahBmkOZFAoPezCnmJfbptzCz8Tp
        v09z3KLG09a8ae5Pe8IQOopeJSE8GXqmdLmtG9/pvw==
X-Google-Smtp-Source: AJdET5efMSJCz6Z6SU65o7qRBPPyDdjTBO9J0TrevQa435FQQwtOY0X7Mc5p+7ysI1KPSgrnAaB/+q/ozG16Ssj/7x8=
X-Received: by 2002:aca:ac4:: with SMTP id k65-v6mr342808oiy.265.1540471257084;
 Thu, 25 Oct 2018 05:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-3-git-send-email-p.paillet@st.com> <20181025112156.GB4870@dell>
In-Reply-To: <20181025112156.GB4870@dell>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 25 Oct 2018 14:40:45 +0200
Message-ID: <CA+M3ks6s=mhLr0Hzcym_vmPVKjsuk8AFnQQe0qj-doVaXo9VcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] mfd: stpmic1: add stpmic1 driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     pascal paillet <p.paillet@st.com>, dmitry.torokhov@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, wim@linux-watchdog.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, eballetbo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 25 oct. 2018 =C3=A0 13:21, Lee Jones <lee.jones@linaro.org> a =C3=
=A9crit :
>
> On Thu, 18 Oct 2018, Pascal PAILLET-LME wrote:
>
> > From: pascal paillet <p.paillet@st.com>
> >
> > stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
> > regulators , 3 switches, a watchdog and an input for a power on key.
>
> Same comments as for the DT binding patch.
>
> > Signed-off-by: pascal paillet <p.paillet@st.com>
> > ---
> > changes in v4:
> > * rename PONKEY_PU_ACTIVE to PONKEY_PU_INACTIVE
> >
> >  drivers/mfd/Kconfig         |  13 ++
> >  drivers/mfd/Makefile        |   1 +
> >  drivers/mfd/stpmic1.c       | 401 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/mfd/stpmic1.h | 212 +++++++++++++++++++++++
> >  4 files changed, 627 insertions(+)
> >  create mode 100644 drivers/mfd/stpmic1.c
> >  create mode 100644 include/linux/mfd/stpmic1.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 11841f4..b8dabc7 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1855,6 +1855,19 @@ config MFD_STM32_TIMERS
> >         for PWM and IIO Timer. This driver allow to share the
> >         registers between the others drivers.
> >
> > +config MFD_STPMIC1
> > +     tristate "Support for STPMIC1 PMIC"
> > +     depends on (I2C=3Dy && OF)
> > +     select REGMAP_I2C
> > +     select REGMAP_IRQ
> > +     select MFD_CORE
> > +     help
> > +       Support for ST Microelectronics STPMIC1 PMIC. STPMIC1 MFD drive=
r is
>
> Remove 'MFD' and replace with something else.
>
> MFD is not a real thing.  It's a Linuxisum.
>
> > +       the core driver for STPMIC1 component that mainly handles inter=
rupts.
>
> You need to document what the child devices are.
>
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called stpmic1.
> > +
> >  menu "Multimedia Capabilities Port drivers"
> >       depends on ARCH_SA1100
> >
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 5856a94..76fff14 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -232,6 +232,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)     +=3D inte=
l_soc_pmic_chtdc_ti.o
> >  obj-$(CONFIG_MFD_MT6397)     +=3D mt6397-core.o
> >
> >  obj-$(CONFIG_MFD_ALTERA_A10SR)       +=3D altera-a10sr.o
> > +obj-$(CONFIG_MFD_STPMIC1)    +=3D stpmic1.o
> >  obj-$(CONFIG_MFD_SUN4I_GPADC)        +=3D sun4i-gpadc.o
> >
> >  obj-$(CONFIG_MFD_STM32_LPTIMER)      +=3D stm32-lptimer.o
> > diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
> > new file mode 100644
> > index 0000000..90dfee4
> > --- /dev/null
> > +++ b/drivers/mfd/stpmic1.c
> > @@ -0,0 +1,401 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) STMicroelectronics 2018
>
> '\n' here.
>
> > +// Author: Pascal Paillet <p.paillet@st.com>
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/stpmic1.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pm_wakeirq.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <dt-bindings/mfd/st,stpmic1.h>
> > +
> > +#define STPMIC1_MAIN_IRQ 0
> > +#define STPMIC1_WAKEUP_IRQ 1
> > +
> > +static bool stpmic1_reg_readable(struct device *dev, unsigned int reg)
> > +{
> > +     switch (reg) {
> > +     case TURN_ON_SR:
> > +     case TURN_OFF_SR:
> > +     case ICC_LDO_TURN_OFF_SR:
> > +     case ICC_BUCK_TURN_OFF_SR:
> > +     case RREQ_STATE_SR:
> > +     case VERSION_SR:
> > +     case SWOFF_PWRCTRL_CR:
> > +     case PADS_PULL_CR:
> > +     case BUCKS_PD_CR:
> > +     case LDO14_PD_CR:
> > +     case LDO56_VREF_PD_CR:
> > +     case VBUS_DET_VIN_CR:
> > +     case PKEY_TURNOFF_CR:
> > +     case BUCKS_MASK_RANK_CR:
> > +     case BUCKS_MASK_RESET_CR:
> > +     case LDOS_MASK_RANK_CR:
> > +     case LDOS_MASK_RESET_CR:
> > +     case WCHDG_CR:
> > +     case WCHDG_TIMER_CR:
> > +     case BUCKS_ICCTO_CR:
> > +     case LDOS_ICCTO_CR:
> > +     case BUCK1_ACTIVE_CR:
> > +     case BUCK2_ACTIVE_CR:
> > +     case BUCK3_ACTIVE_CR:
> > +     case BUCK4_ACTIVE_CR:
> > +     case VREF_DDR_ACTIVE_CR:
> > +     case LDO1_ACTIVE_CR:
> > +     case LDO2_ACTIVE_CR:
> > +     case LDO3_ACTIVE_CR:
> > +     case LDO4_ACTIVE_CR:
> > +     case LDO5_ACTIVE_CR:
> > +     case LDO6_ACTIVE_CR:
> > +     case BUCK1_STDBY_CR:
> > +     case BUCK2_STDBY_CR:
> > +     case BUCK3_STDBY_CR:
> > +     case BUCK4_STDBY_CR:
> > +     case VREF_DDR_STDBY_CR:
> > +     case LDO1_STDBY_CR:
> > +     case LDO2_STDBY_CR:
> > +     case LDO3_STDBY_CR:
> > +     case LDO4_STDBY_CR:
> > +     case LDO5_STDBY_CR:
> > +     case LDO6_STDBY_CR:
> > +     case BST_SW_CR:
> > +     case INT_PENDING_R1:
> > +     case INT_PENDING_R2:
> > +     case INT_PENDING_R3:
> > +     case INT_PENDING_R4:
> > +     case INT_DBG_LATCH_R1:
> > +     case INT_DBG_LATCH_R2:
> > +     case INT_DBG_LATCH_R3:
> > +     case INT_DBG_LATCH_R4:
> > +     case INT_CLEAR_R1:
> > +     case INT_CLEAR_R2:
> > +     case INT_CLEAR_R3:
> > +     case INT_CLEAR_R4:
> > +     case INT_MASK_R1:
> > +     case INT_MASK_R2:
> > +     case INT_MASK_R3:
> > +     case INT_MASK_R4:
> > +     case INT_SET_MASK_R1:
> > +     case INT_SET_MASK_R2:
> > +     case INT_SET_MASK_R3:
> > +     case INT_SET_MASK_R4:
> > +     case INT_CLEAR_MASK_R1:
> > +     case INT_CLEAR_MASK_R2:
> > +     case INT_CLEAR_MASK_R3:
> > +     case INT_CLEAR_MASK_R4:
> > +     case INT_SRC_R1:
> > +     case INT_SRC_R2:
> > +     case INT_SRC_R3:
> > +     case INT_SRC_R4:
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> > +static bool stpmic1_reg_writeable(struct device *dev, unsigned int reg=
)
> > +{
> > +     switch (reg) {
> > +     case SWOFF_PWRCTRL_CR:
> > +     case PADS_PULL_CR:
> > +     case BUCKS_PD_CR:
> > +     case LDO14_PD_CR:
> > +     case LDO56_VREF_PD_CR:
> > +     case VBUS_DET_VIN_CR:
> > +     case PKEY_TURNOFF_CR:
> > +     case BUCKS_MASK_RANK_CR:
> > +     case BUCKS_MASK_RESET_CR:
> > +     case LDOS_MASK_RANK_CR:
> > +     case LDOS_MASK_RESET_CR:
> > +     case WCHDG_CR:
> > +     case WCHDG_TIMER_CR:
> > +     case BUCKS_ICCTO_CR:
> > +     case LDOS_ICCTO_CR:
> > +     case BUCK1_ACTIVE_CR:
> > +     case BUCK2_ACTIVE_CR:
> > +     case BUCK3_ACTIVE_CR:
> > +     case BUCK4_ACTIVE_CR:
> > +     case VREF_DDR_ACTIVE_CR:
> > +     case LDO1_ACTIVE_CR:
> > +     case LDO2_ACTIVE_CR:
> > +     case LDO3_ACTIVE_CR:
> > +     case LDO4_ACTIVE_CR:
> > +     case LDO5_ACTIVE_CR:
> > +     case LDO6_ACTIVE_CR:
> > +     case BUCK1_STDBY_CR:
> > +     case BUCK2_STDBY_CR:
> > +     case BUCK3_STDBY_CR:
> > +     case BUCK4_STDBY_CR:
> > +     case VREF_DDR_STDBY_CR:
> > +     case LDO1_STDBY_CR:
> > +     case LDO2_STDBY_CR:
> > +     case LDO3_STDBY_CR:
> > +     case LDO4_STDBY_CR:
> > +     case LDO5_STDBY_CR:
> > +     case LDO6_STDBY_CR:
> > +     case BST_SW_CR:
> > +     case INT_DBG_LATCH_R1:
> > +     case INT_DBG_LATCH_R2:
> > +     case INT_DBG_LATCH_R3:
> > +     case INT_DBG_LATCH_R4:
> > +     case INT_CLEAR_R1:
> > +     case INT_CLEAR_R2:
> > +     case INT_CLEAR_R3:
> > +     case INT_CLEAR_R4:
> > +     case INT_SET_MASK_R1:
> > +     case INT_SET_MASK_R2:
> > +     case INT_SET_MASK_R3:
> > +     case INT_SET_MASK_R4:
> > +     case INT_CLEAR_MASK_R1:
> > +     case INT_CLEAR_MASK_R2:
> > +     case INT_CLEAR_MASK_R3:
> > +     case INT_CLEAR_MASK_R4:
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> > +static bool stpmic1_reg_volatile(struct device *dev, unsigned int reg)
> > +{
> > +     switch (reg) {
> > +     case TURN_ON_SR:
> > +     case TURN_OFF_SR:
> > +     case ICC_LDO_TURN_OFF_SR:
> > +     case ICC_BUCK_TURN_OFF_SR:
> > +     case RREQ_STATE_SR:
> > +     case INT_PENDING_R1:
> > +     case INT_PENDING_R2:
> > +     case INT_PENDING_R3:
> > +     case INT_PENDING_R4:
> > +     case INT_SRC_R1:
> > +     case INT_SRC_R2:
> > +     case INT_SRC_R3:
> > +     case INT_SRC_R4:
> > +     case WCHDG_CR:
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
>
> Can you use ranges for all of these?
>
> > +const struct regmap_config stpmic1_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .cache_type =3D REGCACHE_RBTREE,
> > +     .max_register =3D PMIC_MAX_REGISTER_ADDRESS,
> > +     .readable_reg =3D stpmic1_reg_readable,
> > +     .writeable_reg =3D stpmic1_reg_writeable,
> > +     .volatile_reg =3D stpmic1_reg_volatile,
> > +};
> > +
> > +static const struct regmap_irq stpmic1_irqs[] =3D {
> > +     [IT_PONKEY_F]           =3D { .mask =3D 0x01 },
> > +     [IT_PONKEY_R]           =3D { .mask =3D 0x02 },
> > +     [IT_WAKEUP_F]           =3D { .mask =3D 0x04 },
> > +     [IT_WAKEUP_R]           =3D { .mask =3D 0x08 },
> > +     [IT_VBUS_OTG_F]         =3D { .mask =3D 0x10 },
> > +     [IT_VBUS_OTG_R]         =3D { .mask =3D 0x20 },
> > +     [IT_SWOUT_F]            =3D { .mask =3D 0x40 },
> > +     [IT_SWOUT_R]            =3D { .mask =3D 0x80 },
> > +
> > +     [IT_CURLIM_BUCK1]       =3D { .reg_offset =3D 1, .mask =3D 0x01 }=
,
> > +     [IT_CURLIM_BUCK2]       =3D { .reg_offset =3D 1, .mask =3D 0x02 }=
,
> > +     [IT_CURLIM_BUCK3]       =3D { .reg_offset =3D 1, .mask =3D 0x04 }=
,
> > +     [IT_CURLIM_BUCK4]       =3D { .reg_offset =3D 1, .mask =3D 0x08 }=
,
> > +     [IT_OCP_OTG]            =3D { .reg_offset =3D 1, .mask =3D 0x10 }=
,
> > +     [IT_OCP_SWOUT]          =3D { .reg_offset =3D 1, .mask =3D 0x20 }=
,
> > +     [IT_OCP_BOOST]          =3D { .reg_offset =3D 1, .mask =3D 0x40 }=
,
> > +     [IT_OVP_BOOST]          =3D { .reg_offset =3D 1, .mask =3D 0x80 }=
,
> > +
> > +     [IT_CURLIM_LDO1]        =3D { .reg_offset =3D 2, .mask =3D 0x01 }=
,
> > +     [IT_CURLIM_LDO2]        =3D { .reg_offset =3D 2, .mask =3D 0x02 }=
,
> > +     [IT_CURLIM_LDO3]        =3D { .reg_offset =3D 2, .mask =3D 0x04 }=
,
> > +     [IT_CURLIM_LDO4]        =3D { .reg_offset =3D 2, .mask =3D 0x08 }=
,
> > +     [IT_CURLIM_LDO5]        =3D { .reg_offset =3D 2, .mask =3D 0x10 }=
,
> > +     [IT_CURLIM_LDO6]        =3D { .reg_offset =3D 2, .mask =3D 0x20 }=
,
> > +     [IT_SHORT_SWOTG]        =3D { .reg_offset =3D 2, .mask =3D 0x40 }=
,
> > +     [IT_SHORT_SWOUT]        =3D { .reg_offset =3D 2, .mask =3D 0x80 }=
,
> > +
> > +     [IT_TWARN_F]            =3D { .reg_offset =3D 3, .mask =3D 0x01 }=
,
> > +     [IT_TWARN_R]            =3D { .reg_offset =3D 3, .mask =3D 0x02 }=
,
> > +     [IT_VINLOW_F]           =3D { .reg_offset =3D 3, .mask =3D 0x04 }=
,
> > +     [IT_VINLOW_R]           =3D { .reg_offset =3D 3, .mask =3D 0x08 }=
,
> > +     [IT_SWIN_F]             =3D { .reg_offset =3D 3, .mask =3D 0x40 }=
,
> > +     [IT_SWIN_R]             =3D { .reg_offset =3D 3, .mask =3D 0x80 }=
,
> > +};
>
> There should be a MACRO for doing this.
>
> If there isn't, you should author one and put it in the Regmap header.

Hi Lee,
I don't understand why you want to put this MACRO in regmap header.
Offsets and masks are custom from this hardware block.
How can this become generic enough to be put in regmap ?

Regards,
Benjamin

>
> > +static const struct regmap_irq_chip stpmic1_regmap_irq_chip =3D {
> > +     .name =3D "pmic_irq",
> > +     .status_base =3D INT_PENDING_R1,
> > +     .mask_base =3D INT_CLEAR_MASK_R1,
> > +     .unmask_base =3D INT_SET_MASK_R1,
> > +     .ack_base =3D INT_CLEAR_R1,
> > +     .num_regs =3D STPMIC1_PMIC_NUM_IRQ_REGS,
> > +     .irqs =3D stpmic1_irqs,
> > +     .num_irqs =3D ARRAY_SIZE(stpmic1_irqs),
> > +};
> > +
> > +static int stpmic1_probe(struct i2c_client *i2c,
> > +                      const struct i2c_device_id *id)
> > +{
> > +     struct stpmic1 *ddata;
> > +     struct device *dev =3D &i2c->dev;
> > +     int ret;
> > +     struct device_node *np =3D dev->of_node;
> > +     u32 reg;
> > +
> > +     ddata =3D devm_kzalloc(dev, sizeof(struct stpmic1), GFP_KERNEL);
> > +     if (!ddata)
> > +             return -ENOMEM;
> > +
> > +     i2c_set_clientdata(i2c, ddata);
> > +     ddata->dev =3D dev;
> > +
> > +     ddata->regmap =3D devm_regmap_init_i2c(i2c, &stpmic1_regmap_confi=
g);
> > +     if (IS_ERR(ddata->regmap))
> > +             return PTR_ERR(ddata->regmap);
> > +
> > +     ddata->irq =3D of_irq_get(np, STPMIC1_MAIN_IRQ);
> > +     if (ddata->irq < 0) {
> > +             dev_err(dev, "Failed to get main IRQ: %d\n", ddata->irq);
> > +             return ddata->irq;
> > +     }
> > +
> > +     if (!of_property_read_u32(np, "st,main-control-register", &reg)) =
{
>
> I'm still waiting on feedback from Rob as to whether this is
> acceptable.  I suggest that it isn't.
>
> > +             ret =3D regmap_update_bits(ddata->regmap,
> > +                                      SWOFF_PWRCTRL_CR,
> > +                                      PWRCTRL_POLARITY_HIGH |
> > +                                      PWRCTRL_PIN_VALID |
> > +                                      RESTART_REQUEST_ENABLED,
> > +                                      reg);
> > +             if (ret) {
> > +                     dev_err(dev,
> > +                             "Failed to update main control register: =
%d\n",
> > +                             ret);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     /* Read Version ID */
> > +     ret =3D regmap_read(ddata->regmap, VERSION_SR, &reg);
> > +     if (ret) {
> > +             dev_err(dev, "Unable to read pmic version\n");
>
> "PMIC"
>
> > +             return ret;
> > +     }
> > +     dev_info(dev, "PMIC Chip Version: 0x%x\n", reg);
>
> [...]
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
