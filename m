Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61021C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F6F218DE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UL1sMCmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfADHYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:24:07 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36211 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADHYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 02:24:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so39521347qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 23:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKWUMxf88NWViWFmYDY1Jjf2hR11PWQTEi3F9sobwQ0=;
        b=UL1sMCmFuI+m+0qkycZSPloEbOKJQbapInEpVr2KqlQhHUV2DJeGfARMze5s3uugX/
         liAPYg05AdZVP8Bc8nxj51OXlTPTNyWmhOMvALpoBqBAHjeHtrZloD3P46mS2fW8cj2m
         aidzjGeZKjaWpdv5UmDSaD9EYMnN71U8Ep5i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKWUMxf88NWViWFmYDY1Jjf2hR11PWQTEi3F9sobwQ0=;
        b=gcoJwgu1rKd/pLkj8/0i8GUG2F+zdF+YpCpRmewXXbz5vMekUlj4omdZG0mg/ooDwA
         tJ7ksT6fBmPrvFs5UmZiIRrbwKNGjBK/hh1yVcKf8vsmrnnsClJ+K5eixI4Rz5Pp3t1x
         fAeRU2moewn9yxo6XFI1492zvW7nUfncXfRg92WQ0HoRctRbyjgXUulqaqHAtHk9dtPh
         l1HcDhj2VQGF2ZfxOc+TgKEudy2pgXvA5nCv5uvp4azh3xS/MU+xPu2lYmsFeNLzBhot
         Ye2ruBpCjhpyjZOQnT5JMlvBPeqkVRFYZQS/Ti63fWKVaLTKIH4ZdOqBArDiFNspUJcd
         q7YA==
X-Gm-Message-State: AJcUukchi5BRBJ5dXiwAgB0oY8zDmT7RJvokqUGI+DhZwnIAlFgiP5L8
        lzqby6I+cdfWk2nUf1KweLDGjeRXP19NkGOkhVJU5g==
X-Google-Smtp-Source: ALg8bN7nO9vjh5BYmd1zFXWPjtxbSb3KfiOwBm/ASSbKnNLOG++nfBpa781uxJReCV6wrMEMUJaavKgSosgqyUVg5ds=
X-Received: by 2002:a0c:fb4c:: with SMTP id b12mr13425629qvq.177.1546586644662;
 Thu, 03 Jan 2019 23:24:04 -0800 (PST)
MIME-Version: 1.0
References: <1546436644-19234-1-git-send-email-henryc.chen@mediatek.com>
 <1546436644-19234-7-git-send-email-henryc.chen@mediatek.com>
 <CANMq1KBn2YoJtLXO1-Yf9RO5YEwqqBnLLEaFDH2GxJdDwvVTow@mail.gmail.com> <1546524991.6818.55.camel@mtksdaap41>
In-Reply-To: <1546524991.6818.55.camel@mtksdaap41>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 4 Jan 2019 15:23:53 +0800
Message-ID: <CANMq1KBvKPA2SFQg3V25vtpyxQqJ790fitc0J2VOmOXBBKxH4A@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] soc: mediatek: add MT8183 dvfsrc support
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 10:16 PM Henry Chen <henryc.chen@mediatek.com> wrote:
>
> On Thu, 2019-01-03 at 10:16 +0800, Nicolas Boichat wrote:
> > On Wed, Jan 2, 2019 at 10:01 PM Henry Chen <henryc.chen@mediatek.com> wrote:
> > >
> > > Add dvfsrc driver for MT8183
> > >
> > > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > > ---
> > >  drivers/soc/mediatek/Kconfig      |  15 ++
> > >  drivers/soc/mediatek/Makefile     |   1 +
> > >  drivers/soc/mediatek/mtk-dvfsrc.c | 473 ++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 489 insertions(+)
> > >  create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
> > >
> > > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > > index a7d0667..f956f03 100644
> > > --- a/drivers/soc/mediatek/Kconfig
> > > +++ b/drivers/soc/mediatek/Kconfig
> > > @@ -12,6 +12,21 @@ config MTK_INFRACFG
> > >           INFRACFG controller contains various infrastructure registers not
> > >           directly associated to any device.
> > >
> > > +config MTK_DVFSRC
> > > +       bool "MediaTek DVFSRC Support"
> > > +       depends on ARCH_MEDIATEK
> > > +       default ARCH_MEDIATEK
> > > +       select REGMAP
> > > +       select MTK_INFRACFG
> > > +       select PM_GENERIC_DOMAINS if PM
> > > +       depends on MTK_SCPSYS
> > > +       help
> > > +         Say yes here to add support for the MediaTek DVFSRC found
> > > +         on different MediaTek SoCs. The DVFSRC is a proprietary
> > > +         hardware which is used to collect all the requests from
> > > +         system and turn into the decision of minimum Vcore voltage
> > > +         and minimum DRAM frequency to fulfill those requests.
> > > +
> > >  config MTK_PMIC_WRAP
> > >         tristate "MediaTek PMIC Wrapper Support"
> > >         depends on RESET_CONTROLLER
> > > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > > index 9dc6670..5c010b9 100644
> > > --- a/drivers/soc/mediatek/Makefile
> > > +++ b/drivers/soc/mediatek/Makefile
> > > @@ -1,3 +1,4 @@
> > > +obj-$(CONFIG_MTK_DVFSRC) += mtk-dvfsrc.o
> > >  obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
> > >  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> > >  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> > > diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
> > > new file mode 100644
> > > index 0000000..af462a3
> > > --- /dev/null
> > > +++ b/drivers/soc/mediatek/mtk-dvfsrc.c
> > > @@ -0,0 +1,473 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2018 MediaTek Inc.
> > > + */
> > > +#include <linux/arm-smccc.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/delay.h>
> >
> > Alphabetical order.
> I will fix it.
> >
> > > +#include <linux/kthread.h>
> > > +#include <linux/module.h>
> > > +#include <linux/notifier.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_qos.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/spinlock.h>
> > > +#include <soc/mediatek/mtk_sip.h>
> > > +#include <dt-bindings/power/mt8183-power.h>
> > > +#include <dt-bindings/soc/mtk,dvfsrc.h>
> > > +#include "mtk-scpsys.h"
> > > +
> > > +#define DVFSRC_IDLE            0x00
> > > +#define DVFSRC_GET_TARGET_LEVEL(x)     (((x) >> 0) & 0x0000ffff)
> > > +#define DVFSRC_GET_CURRENT_LEVEL(x)    (((x) >> 16) & 0x0000ffff)
> > > +
> > > +/* macro for irq */
> > > +#define DVFSRC_IRQ_TIMEOUT_EN          BIT(1)
> > > +
> > > +struct dvfsrc_opp {
> > > +       int vcore_opp;
> > > +       int dram_opp;
> > > +};
> > > +
> > > +struct dvfsrc_domain {
> > > +       int id;
> > > +       int state;
> > > +};
> > > +
> > > +struct mtk_dvfsrc;
> > > +struct dvfsrc_soc_data {
> > > +       const int *regs;
> > > +       int num_opp;
> > > +       int num_domains;
> > > +       int dram_sft;
> > > +       int vcore_sft;
> > > +       const struct dvfsrc_opp **opps;
> > > +       struct dvfsrc_domain *domains;
> > > +       void (*init_soc)(struct mtk_dvfsrc *dvfsrc);
> > > +       int (*get_target_level)(struct mtk_dvfsrc *dvfsrc);
> > > +       int (*get_current_level)(struct mtk_dvfsrc *dvfsrc);
> > > +};
> > > +
> > > +struct mtk_dvfsrc {
> > > +       struct device *dev;
> > > +       struct clk *clk_dvfsrc;
> > > +       const struct dvfsrc_soc_data *dvd;
> > > +       int dram_type;
> > > +       int irq;
> > > +       void __iomem *regs;
> > > +       struct mutex lock;      /* generic mutex for dvfsrc driver */
> > > +
> > > +       struct notifier_block qos_notifier;
> > > +       struct notifier_block scpsys_notifier;
> > > +};
> > > +
> > > +static u32 dvfsrc_read(struct mtk_dvfsrc *dvfs, u32 offset)
> > > +{
> > > +       return readl(dvfs->regs + dvfs->dvd->regs[offset]);
> > > +}
> > > +
> > > +static void dvfsrc_write(struct mtk_dvfsrc *dvfs, u32 offset, u32 val)
> > > +{
> > > +       writel(val, dvfs->regs + dvfs->dvd->regs[offset]);
> > > +}
> > > +
> > > +enum dvfsrc_regs {
> > > +       DVFSRC_BASIC_CONTROL,
> > > +       DVFSRC_SW_REQ,
> > > +       DVFSRC_SW_REQ2,
> > > +       DVFSRC_EMI_REQUEST,
> > > +       DVFSRC_EMI_REQUEST2,
> > > +       DVFSRC_EMI_REQUEST3,
> > > +       DVFSRC_EMI_QOS0,
> > > +       DVFSRC_EMI_QOS1,
> > > +       DVFSRC_EMI_QOS2,
> > > +       DVFSRC_EMI_MD2SPM0,
> > > +       DVFSRC_EMI_MD2SPM1,
> > > +       DVFSRC_VCORE_REQUEST,
> > > +       DVFSRC_VCORE_REQUEST2,
> > > +       DVFSRC_VCORE_MD2SPM0,
> > > +       DVFSRC_INT,
> > > +       DVFSRC_INT_EN,
> > > +       DVFSRC_INT_CLR,
> > > +       DVFSRC_TIMEOUT_NEXTREQ,
> > > +       DVFSRC_LEVEL,
> > > +       DVFSRC_LEVEL_LABEL_0_1,
> > > +       DVFSRC_LEVEL_LABEL_2_3,
> > > +       DVFSRC_LEVEL_LABEL_4_5,
> > > +       DVFSRC_LEVEL_LABEL_6_7,
> > > +       DVFSRC_LEVEL_LABEL_8_9,
> > > +       DVFSRC_LEVEL_LABEL_10_11,
> > > +       DVFSRC_LEVEL_LABEL_12_13,
> > > +       DVFSRC_LEVEL_LABEL_14_15,
> > > +       DVFSRC_SW_BW_0,
> > > +       DVFSRC_QOS_EN,
> > > +       DVFSRC_FORCE,
> > > +       DVFSRC_LAST,
> > > +       DVFSRC_RSRV_0,
> > > +       DVFSRC_RSRV_1,
> > > +};
> > > +
> > > +static int mt8183_regs[] = {
> > > +       [DVFSRC_BASIC_CONTROL] =        0x0,
> > > +       [DVFSRC_SW_REQ] =               0x4,
> > > +       [DVFSRC_SW_REQ2] =              0x8,
> > > +       [DVFSRC_EMI_REQUEST] =          0xC,
> > > +       [DVFSRC_EMI_REQUEST2] =         0x10,
> > > +       [DVFSRC_EMI_REQUEST3] =         0x14,
> > > +       [DVFSRC_EMI_QOS0] =             0x24,
> > > +       [DVFSRC_EMI_QOS1] =             0x28,
> > > +       [DVFSRC_EMI_QOS2] =             0x2C,
> > > +       [DVFSRC_EMI_MD2SPM0] =          0x30,
> > > +       [DVFSRC_EMI_MD2SPM1] =          0x34,
> > > +       [DVFSRC_VCORE_REQUEST] =        0x48,
> > > +       [DVFSRC_VCORE_REQUEST2] =       0x4C,
> > > +       [DVFSRC_VCORE_MD2SPM0] =        0x68,
> > > +       [DVFSRC_INT] =                  0x98,
> > > +       [DVFSRC_INT_EN] =               0x9C,
> > > +       [DVFSRC_INT_CLR] =              0xA0,
> > > +       [DVFSRC_TIMEOUT_NEXTREQ] =      0xD8,
> > > +       [DVFSRC_LEVEL] =                0xDC,
> > > +       [DVFSRC_LEVEL_LABEL_0_1] =      0xE0,
> > > +       [DVFSRC_LEVEL_LABEL_2_3] =      0xE4,
> > > +       [DVFSRC_LEVEL_LABEL_4_5] =      0xE8,
> > > +       [DVFSRC_LEVEL_LABEL_6_7] =      0xEC,
> > > +       [DVFSRC_LEVEL_LABEL_8_9] =      0xF0,
> > > +       [DVFSRC_LEVEL_LABEL_10_11] =    0xF4,
> > > +       [DVFSRC_LEVEL_LABEL_12_13] =    0xF8,
> > > +       [DVFSRC_LEVEL_LABEL_14_15] =    0xFC,
> > > +       [DVFSRC_SW_BW_0] =              0x160,
> > > +       [DVFSRC_QOS_EN] =               0x180,
> > > +       [DVFSRC_FORCE] =                0x300,
> > > +       [DVFSRC_LAST] =                 0x308,
> > > +       [DVFSRC_RSRV_0] =               0x600,
> > > +       [DVFSRC_RSRV_1] =               0x604,
> > > +};
> >
> > Why do you need this indirection table? Do you plan to support HW with
> > very different register offsets?
> Yes. The dvfsrc not only on mt8183 but also exist on following Mediatek
> SoCs. I afraid some of them may be different because the design is
> changed.
> >
> > > +
> > > +static bool dvfsrc_is_idle(struct mtk_dvfsrc *dvfsrc)
> > > +{
> > > +       int val = 0;
> >
> > So 0 is DVFSRC_IDLE, so the function returns true?
> >
> > Maybe this is more readable?
> Ok. it good to me.
> >
> > if (!dvfsrc->dvd->get_target_level)
> >     return true;
> >
> > return dvfsrc->dvd->get_target_level(dvfsrc) == DVFSRC_IDLE;
> >
> > > +
> > > +       if (dvfsrc->dvd->get_target_level)
> >
> > However... can this be false? In what case?
> hmm, it just null function check to prevent someone who forget to hook
> the callback.

Well, isn't it better to just crash the kernel in that case? I mean,
the hook is setup just below, so I'd rather know that we forgot to
hook the callback, rather than masking the error...

> >
> > > +               val = dvfsrc->dvd->get_target_level(dvfsrc);
> > > +
> > > +       return val == DVFSRC_IDLE;
> > > +}
> > > +
> > > +static int dvfsrc_wait_for_state(struct mtk_dvfsrc *dvfsrc,
> > > +                                bool (*fp)(struct mtk_dvfsrc *))
> > > +{
> > > +       unsigned long timeout;
> > > +
> > > +       timeout = jiffies + usecs_to_jiffies(1000);
> > > +
> > > +       do {
> > > +               if (fp(dvfsrc))
> > > +                       return 0;
> > > +       } while (!time_after(jiffies, timeout));
> > > +
> > > +       return -ETIMEDOUT;
> > > +}
> >
> > Can we use wait_event_timeout here?
> I will give a try.
> >
> > > +
> > > +static void mtk_dvfsrc_mt8183_init(struct mtk_dvfsrc *dvfsrc)
> > > +{
> > > +       struct arm_smccc_res res;
> > > +
> > > +       mutex_lock(&dvfsrc->lock);
> > > +
> > > +       arm_smccc_smc(MTK_SIP_SPM, MTK_SIP_SPM_DVFSRC_INIT, 0, 0, 0, 0, 0, 0,
> > > +                     &res);
> > > +
> > > +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_0_1, 0x00100000);
> > > +
> > > +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_2_3, 0x00210011);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_4_5, 0x01100100);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_6_7, 0x01210111);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_8_9, 0x02100200);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_10_11, 0x02210211);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_12_13, 0x03210321);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_LEVEL_LABEL_14_15, 0x03210321);
> > > +
> > > +       /* EMI/VCORE HRT, MD2SPM, BW setting */
> > > +       dvfsrc_write(dvfsrc, DVFSRC_EMI_QOS0, 0x32);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_EMI_QOS1, 0x66);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_EMI_MD2SPM0, 0x80F8);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_EMI_MD2SPM1, 0x0);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_VCORE_MD2SPM0, 0x80C0);
> > > +
> > > +       dvfsrc_write(dvfsrc, DVFSRC_RSRV_1, 0x0000001C);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_TIMEOUT_NEXTREQ, 0x00000013);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_INT_EN, 0x2);
> > > +
> > > +       dvfsrc_write(dvfsrc, DVFSRC_EMI_REQUEST, 0x00290209);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_EMI_REQUEST2, 0);
> > > +
> > > +       dvfsrc_write(dvfsrc, DVFSRC_VCORE_REQUEST, 0x00150000);
> > > +
> > > +       dvfsrc_write(dvfsrc, DVFSRC_QOS_EN, 0x0000407F);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_EMI_REQUEST3, 0x09000000);
> > > +
> > > +       dvfsrc_write(dvfsrc, DVFSRC_FORCE, 0x00400000);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_BASIC_CONTROL, 0x0000C07B);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_BASIC_CONTROL, 0x0000017B);
> >
> > Lots of magic values here, can you describe what they do? (either as
> > #define, or at the very least with comments)
> I will give a brief comment on these settings.
> >
> > > +
> > > +       dvfsrc_write(dvfsrc, DVFSRC_VCORE_REQUEST,
> > > +                    (dvfsrc_read(dvfsrc, DVFSRC_VCORE_REQUEST)
> > > +                    & ~(0x3 << 20)));
> > > +       dvfsrc_write(dvfsrc, DVFSRC_EMI_REQUEST,
> > > +                    (dvfsrc_read(dvfsrc, DVFSRC_EMI_REQUEST)
> > > +                    & ~(0x3 << 20)));
> > > +
> > > +       mutex_unlock(&dvfsrc->lock);
> > > +}
> > > +
> > > +static int mt8183_get_target_level(struct mtk_dvfsrc *dvfsrc)
> > > +{
> > > +       return DVFSRC_GET_TARGET_LEVEL(dvfsrc_read(dvfsrc, DVFSRC_LEVEL));
> > > +}
> > > +
> > > +static int mt8183_get_current_level(struct mtk_dvfsrc *dvfsrc)
> > > +{
> > > +       return DVFSRC_GET_CURRENT_LEVEL(dvfsrc_read(dvfsrc, DVFSRC_LEVEL));
> > > +}
> > > +
> > > +static int get_cur_performance_level(struct mtk_dvfsrc *dvfsrc)
> > > +{
> > > +       int bit = 0;
> > > +
> > > +       if (dvfsrc->dvd->get_current_level)
> >
> > Same question as above, is this possible?
> >
> > > +               bit = dvfsrc->dvd->get_current_level(dvfsrc);
> > > +
> > > +       return ffs(bit);
> >
> > So ffs(0) = 0... Maybe just return 0 if get_current_level is NULL.
> ok. it will be change to
>         if  (!dvfsrc->dvd->get_current_level)
>                 return 0;
>         return ffs(dvfsrc->dvd->get_current_level(dvfsrc));
> >
> > > +}
> > > +
> > > +static int pm_qos_memory_bw_notify(struct notifier_block *b,
> > > +                                  unsigned long bw, void *v)
> > > +{
> > > +       struct mtk_dvfsrc *dvfsrc;
> > > +
> > > +       dvfsrc = container_of(b, struct mtk_dvfsrc, qos_notifier);
> > > +       mutex_lock(&dvfsrc->lock);
> > > +
> > > +       dev_dbg(dvfsrc->dev, "data: 0x%lx\n", bw);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_SW_BW_0, bw / 100);
> > > +
> > > +       mutex_unlock(&dvfsrc->lock);
> > > +
> > > +       return NOTIFY_OK;
> > > +}
> > > +
> > > +static int dvfsrc_set_performace(struct notifier_block *b,
> >
> > set_performaNce
> Thanks.
> >
> > > +                                unsigned long l, void *v)
> > > +{
> > > +       int i, val, highest = 0, vcore_opp = 0, dram_opp = 0;
> >
> > No need to initialize any of these to 0.
> Ok.
> >
> > > +       struct mtk_dvfsrc *dvfsrc;
> > > +       struct scp_event_data *sc = v;
> > > +       struct dvfsrc_domain *d;
> > > +
> > > +       if (sc->event_type != MTK_SCPSYS_PSTATE)
> > > +               return 0;
> > > +
> > > +       dvfsrc = container_of(b, struct mtk_dvfsrc, scpsys_notifier);
> > > +
> > > +       mutex_lock(&dvfsrc->lock);
> > > +       d = dvfsrc->dvd->domains;
> > > +
> > > +       if (l > dvfsrc->dvd->num_opp || l <= 0) {
> > > +               dev_err(dvfsrc->dev, "pstate out of range = %ld\n", l);
> > > +               goto out;
> > > +       }
> > > +
> > > +       for (i = 0, highest = 0; i < dvfsrc->dvd->num_domains - 1; i++, d++) {
> > > +               if (sc->domain_id == d->id)
> > > +                       d->state = l;
> > > +               if (d->state > highest)
> > > +                       highest = d->state;
> > > +       }
> > > +
> > > +       if (highest == 0) {
> > > +               dev_err(dvfsrc->dev, "domain not match\n");
> > > +               goto out;
> > > +       }
> > > +
> > > +       /* translate pstate to dvfsrc level, and set it to DVFSRC HW */
> > > +       vcore_opp =
> > > +               dvfsrc->dvd->opps[dvfsrc->dram_type][highest - 1].vcore_opp;
> > > +       dram_opp = dvfsrc->dvd->opps[dvfsrc->dram_type][highest - 1].dram_opp;
> > > +
> > > +       if (dvfsrc_wait_for_state(dvfsrc, dvfsrc_is_idle)) {
> > > +               dev_warn(dvfsrc->dev, "[%s] wait idle, last: %d -> %d\n",
> > > +                        __func__, dvfsrc_read(dvfsrc, DVFSRC_LEVEL),
> > > +               dvfsrc_read(dvfsrc, DVFSRC_LAST));
> > > +               goto out;
> > > +       }
> > > +
> > > +       dvfsrc_write(dvfsrc, DVFSRC_SW_REQ,
> > > +                    dram_opp << dvfsrc->dvd->dram_sft |
> > > +                    vcore_opp << dvfsrc->dvd->vcore_sft);
> > > +
> > > +       if (dvfsrc_wait_for_state(dvfsrc, dvfsrc_is_idle)) {
> > > +               dev_warn(dvfsrc->dev, "[%s] wait idle, last: %d -> %d\n",
> > > +                        __func__, dvfsrc_read(dvfsrc, DVFSRC_LEVEL),
> > > +                        dvfsrc_read(dvfsrc, DVFSRC_LAST));
> > > +               goto out;
> > > +       }
> > > +
> > > +       val = get_cur_performance_level(dvfsrc);
> > > +       if (val < highest) {
> > > +               dev_err(dvfsrc->dev, "current: %d < hightest: %x\n",
> >
> > highest
> Thanks.
> >
> > > +                       highest, val);
> > > +       }
> > > +out:
> > > +       mutex_unlock(&dvfsrc->lock);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void pstate_notifier_register(struct mtk_dvfsrc *dvfsrc)
> > > +{
> > > +       dvfsrc->scpsys_notifier.notifier_call = dvfsrc_set_performace;
> > > +       register_scpsys_notifier(&dvfsrc->scpsys_notifier);
> > > +}
> > > +
> > > +static void pm_qos_notifier_register(struct mtk_dvfsrc *dvfsrc)
> > > +{
> > > +       dvfsrc->qos_notifier.notifier_call = pm_qos_memory_bw_notify;
> > > +       pm_qos_add_notifier(PM_QOS_MEMORY_BANDWIDTH, &dvfsrc->qos_notifier);
> > > +}
> > > +
> > > +static irqreturn_t mtk_dvfsrc_interrupt(int irq, void *dev_id)
> > > +{
> > > +       u32 val;
> > > +       struct mtk_dvfsrc *dvfsrc = dev_id;
> > > +
> > > +       val = dvfsrc_read(dvfsrc, DVFSRC_INT);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_INT_CLR, val);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_INT_CLR, 0x0);
> > > +       if (val & DVFSRC_IRQ_TIMEOUT_EN)
> > > +               dev_warn(dvfsrc->dev, "timeout at spm = %x", val);
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int mtk_dvfsrc_probe(struct platform_device *pdev)
> > > +{
> > > +       struct resource *res;
> > > +       struct mtk_dvfsrc *dvfsrc;
> > > +       int ret;
> > > +
> > > +       dvfsrc = devm_kzalloc(&pdev->dev, sizeof(*dvfsrc), GFP_KERNEL);
> > > +       if (!dvfsrc)
> > > +               return -ENOMEM;
> > > +
> > > +       dvfsrc->dvd = of_device_get_match_data(&pdev->dev);
> > > +       dvfsrc->dev = &pdev->dev;
> > > +
> > > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       dvfsrc->regs = devm_ioremap_resource(&pdev->dev, res);
> > > +       if (IS_ERR(dvfsrc->regs))
> > > +               return PTR_ERR(dvfsrc->regs);
> > > +
> > > +       dvfsrc->clk_dvfsrc = devm_clk_get(dvfsrc->dev, "dvfsrc");
> > > +       if (IS_ERR(dvfsrc->clk_dvfsrc)) {
> > > +               dev_err(dvfsrc->dev, "failed to get clock: %ld\n",
> > > +                       PTR_ERR(dvfsrc->clk_dvfsrc));
> > > +               return PTR_ERR(dvfsrc->clk_dvfsrc);
> > > +       }
> > > +
> > > +       ret = clk_prepare_enable(dvfsrc->clk_dvfsrc);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret = of_property_read_u32(dvfsrc->dev->of_node, "dram_type",
> > > +                                  &dvfsrc->dram_type);
> > > +       if (ret) {
> > > +               dev_err(dvfsrc->dev, "failed to get dram_type: %d\n", ret);
> > > +               clk_disable_unprepare(dvfsrc->clk_dvfsrc);
> > > +               return ret;
> > > +       }
> > > +
> > > +       dvfsrc->irq = platform_get_irq(pdev, 0);
> > > +       ret = request_irq(dvfsrc->irq, mtk_dvfsrc_interrupt
> > > +               , IRQF_TRIGGER_HIGH, "dvfsrc", dvfsrc);
> >
> > comma on the line above
> Thanks.
> >
> > > +       if (ret)
> > > +               dev_dbg(dvfsrc->dev, "interrupt not use\n");
> > > +
> > > +       mutex_init(&dvfsrc->lock);
> > > +       if (dvfsrc->dvd->init_soc)
> > > +               dvfsrc->dvd->init_soc(dvfsrc);
> > > +
> > > +       pstate_notifier_register(dvfsrc);
> > > +       pm_qos_notifier_register(dvfsrc);
> > > +       platform_set_drvdata(pdev, dvfsrc);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct dvfsrc_opp dvfsrc_opp_mt8183_lp4[] = {
> > > +       {0, 0}, {1, 0}, {1, 1}, {1, 2},
> > > +};
> > > +
> > > +static const struct dvfsrc_opp dvfsrc_opp_mt8183_1p3[] = {
> > > +       {0, 0}, {0, 1}, {1, 1}, {1, 2},
> > > +};
> >
> > 1p3? Should this be lp3?
> Yes, thanks.
> >
> > > +
> > > +static const struct dvfsrc_opp *dvfsrc_opp_mt8183[] = {
> > > +       [MT8183_DVFSRC_OPP_LP4] = dvfsrc_opp_mt8183_lp4,
> > > +       [MT8183_DVFSRC_OPP_LP4X] = dvfsrc_opp_mt8183_1p3,
> > > +       [MT8183_DVFSRC_OPP_LP3] = dvfsrc_opp_mt8183_1p3,
> > > +};
> > > +
> > > +static struct dvfsrc_domain dvfsrc_domains_mt8183[] = {
> > > +       {MT8183_POWER_DOMAIN_MFG_ASYNC, 0},
> > > +       {MT8183_POWER_DOMAIN_MFG, 0},
> > > +       {MT8183_POWER_DOMAIN_CAM, 0},
> > > +       {MT8183_POWER_DOMAIN_DISP, 0},
> > > +       {MT8183_POWER_DOMAIN_ISP, 0},
> > > +       {MT8183_POWER_DOMAIN_VDEC, 0},
> > > +       {MT8183_POWER_DOMAIN_VENC, 0},
> > > +};
> > > +
> > > +static const struct dvfsrc_soc_data mt8183_data = {
> > > +       .opps = dvfsrc_opp_mt8183,
> > > +       .num_opp = ARRAY_SIZE(dvfsrc_opp_mt8183_lp4),
> > > +       .regs = mt8183_regs,
> > > +       .domains = dvfsrc_domains_mt8183,
> > > +       .num_domains = ARRAY_SIZE(dvfsrc_domains_mt8183),
> > > +       .init_soc = mtk_dvfsrc_mt8183_init,
> > > +       .get_target_level = mt8183_get_target_level,
> > > +       .get_current_level = mt8183_get_current_level,
> > > +       .dram_sft = 0,
> > > +       .vcore_sft = 2,
> > > +};
> > > +
> > > +static int mtk_dvfsrc_remove(struct platform_device *pdev)
> > > +{
> > > +       return 0;
> >
> > Should you at least disable the clock? (since you do it in the error
> > path in _probe...)
> >
> > clk_disable_unprepare(dvfsrc->clk_dvfsrc);
> Yes, you're right. I will add this.
> >
> > > +}
> > > +
> > > +static const struct of_device_id mtk_dvfsrc_of_match[] = {
> > > +       {
> > > +               .compatible = "mediatek,mt8183-dvfsrc",
> > > +               .data = &mt8183_data,
> > > +       }, {
> > > +               /* sentinel */
> > > +       },
> > > +};
> > > +
> > > +static struct platform_driver mtk_dvfsrc_driver = {
> > > +       .probe  = mtk_dvfsrc_probe,
> > > +       .remove = mtk_dvfsrc_remove,
> > > +       .driver = {
> > > +               .name = "mtk-dvfsrc",
> > > +               .of_match_table = of_match_ptr(mtk_dvfsrc_of_match),
> > > +       },
> > > +};
> > > +
> > > +builtin_platform_driver(mtk_dvfsrc_driver);
> > > +
> > > +MODULE_LICENSE("GPL v2");
> > > +MODULE_DESCRIPTION("MTK DVFSRC driver");
> > > --
> > > 1.9.1
> > >
>
>
