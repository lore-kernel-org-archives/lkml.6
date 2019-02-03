Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D411BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD2B2080A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJCbjQ32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfBCMXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:23:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44731 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfBCMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:23:52 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so12668787qte.11;
        Sun, 03 Feb 2019 04:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZJdi4g3lJscdUF0FyhUYaYgFQE4iqo8d5OSbWWAYuC0=;
        b=fJCbjQ32LSpUGpouc8MaI2bQUURvW2JLFxvl5/zDfRj7ZoYusB3qSs4VhWeWjwraRv
         noFrWrhhPUZinO4X+OduLRAoRAaHI0bjAiZeUD9umOYYMQZYkDNnAWHjb5AeVm6yOQxW
         miJF+MtuE+FSuACbPpCw1ElmZIjUn7c5Ap2nnjKtaZIFbd1VFKMVXIInGu1M5kxZn9TD
         cVzzjOM9gh3ytdsobQZec+T4wN0o/o06NVHfSYNOTNEFtPd4x8TzLkCwrktQIwgf6Zyx
         802J3FHiqjNfesLiKO9I09VJXT4rbgcPWwATMAhg8JtCGMRR+b03d2tgGJaTNQLnb/kF
         EeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZJdi4g3lJscdUF0FyhUYaYgFQE4iqo8d5OSbWWAYuC0=;
        b=oTIn/o6kgM63TZGTTPK3/SU0n1XoqUexMFKzVCaElXkHUEh6KoX99rmfxNuKUWtSde
         bUIwjNTJYIXs522bpDVpSjyRxfz4Xfyv2kr5kewMWa/3s3Lu5Pq6bEdOKb0Jft0wxswU
         1TV4Hxpn7gPACYFZ3TtdZdFbmOm3gFywMYlWLeyM6mVi1TVATWG70/jeUg1lIA3X677k
         AH3ggiHv48dAF2DeYjFl5d8w5RW7xUex9XfGNq401v6aRr9xAFj1vfvMJ4efY6h0rESP
         ULWCe83UqD5MVgCovQrMGUVtRGuV3CexeQi8OyGQ/3PfhcfPsXCWFBTQ8k1Jq++7d5jO
         G0yA==
X-Gm-Message-State: AJcUukeSDTmt3i/hi6rarLjp4lP7uO0w8W+aAqFMirDH4IATrA8LKt4Y
        i4GTcr9tyUmBpzwDyPVQgp9AcpWAK5UfDEVeoro=
X-Google-Smtp-Source: ALg8bN4sk29oH/AzOdtAsuPJYuO45fi4C306TbHecqw3lWHtNZOcHxbr7nPaTiR+2WJMolDR2QO30TYWdoxyWKZtHKs=
X-Received: by 2002:ad4:410c:: with SMTP id i12mr43926556qvp.219.1549196629936;
 Sun, 03 Feb 2019 04:23:49 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190201164720eucas1p13aac6550399d240b261a2cbe489d3dfc@eucas1p1.samsung.com>
 <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com> <1549039612-28905-5-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1549039612-28905-5-git-send-email-l.luba@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 3 Feb 2019 21:23:10 +0900
Message-ID: <CAGTfZH0o6dHQj00vHwZBn05AT-Z_oAWHfBX0eATQ12NPmfw4fg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] drivers: devfreq: add DMC driver for Exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

As I already commented on the other patch,
please don't send next version patchset until finishing the discussion.

2019=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 2:42, Lu=
kasz Luba <l.luba@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> This patch adds driver for Exynos5422 Dynamic Memory Controller.
> The driver provides support for dynamic frequency and voltage scaling for
> DMC and DRAM. It supports changing timings of DRAM running with different
> frequency.
> The patch also contains needed MAINTAINERS file update.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                      |    7 +
>  drivers/devfreq/Kconfig          |   13 +
>  drivers/devfreq/Makefile         |    1 +
>  drivers/devfreq/exynos5422-dmc.c | 1274 ++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 1295 insertions(+)
>  create mode 100644 drivers/devfreq/exynos5422-dmc.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9f64f8d..e81dfbf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3310,6 +3310,13 @@ S:       Maintained
>  F:     drivers/devfreq/exynos-bus.c
>  F:     Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>
> +DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5422
> +M:     Lukasz Luba <l.luba@partner.samsung.com>
> +L:     linux-pm@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org
> +S:     Maintained
> +F:     drivers/devfreq/exynos5422-dmc.c
> +
>  BUSLOGIC SCSI DRIVER
>  M:     Khalid Aziz <khalid@gonehiking.org>
>  L:     linux-scsi@vger.kernel.org
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 6a172d3..2a876ad 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -113,6 +113,19 @@ config ARM_RK3399_DMC_DEVFREQ
>            It sets the frequency for the memory controller and reads the =
usage counts
>            from hardware.
>
> +config ARM_EXYNOS5422_DMC_DEVFREQ

Move it under ARM_EXYNOS_BUS_DEVFREQ alphabetically.

> +       tristate "ARM EXYNOS5422 DMC DEVFREQ Driver"
> +       depends on ARCH_EXYNOS || COMPILE_TEST
> +       select DEVFREQ_GOV_SIMPLE_ONDEMAND

The exynos5422-dmc.c driver use the 'userspace' governor. Why do you
add the DEVFREQ_GOV_SIMPLE_ONDEMAND dependency instead of
GOV_USERSPACE?

Even if you use userspace governor with devfreq_add_device() you added
the 'struct devfreq_dev_profile' for simple_ondemand governor. Why
don't you use 'simple_ondemand' governor as the default governor?

This patch description doesn't contain the something of
simple_ondemand governor.

> +       select DEVFREQ_GOV_PASSIVE

The exynos5422-dmc.c doesn't use 'passive' governor. Maybe you just
copied from ARM_EXYNOS_BUS_DEVFREQ's config. Remove this dependency.

> +       select PM_DEVFREQ_EVENT
> +       select PM_OPP
> +       help
> +         This adds DEVFREQ driver for Exynos5422 DMC (Dynamic Memory Con=
troller).
> +         The driver provides support for Dynamic Voltage and Frequency S=
caling in
> +         DMC and DRAM. It also supports changing timings of DRAM running=
 with
> +         different frequency.
> +
>  source "drivers/devfreq/event/Kconfig"
>
>  endif # PM_DEVFREQ
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 32b8d4d..d011835 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)     +=3D governor_pas=
sive.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)   +=3D exynos-bus.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)   +=3D rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)                +=3D tegra-devfreq.o
> +obj-$(CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ)       +=3D exynos5422-dmc.o

Move it under CONFIG_ARM_EXYNOS_BUS_DEVFREQ alphabetically.

>
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)         +=3D event/
> diff --git a/drivers/devfreq/exynos5422-dmc.c b/drivers/devfreq/exynos542=
2-dmc.c
> new file mode 100644
> index 0000000..8a19281
> --- /dev/null
> +++ b/drivers/devfreq/exynos5422-dmc.c
> @@ -0,0 +1,1274 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/devfreq.h>
> +#include <linux/devfreq-event.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +#define DRIVER_DESC "Driver for Exynos5422 Dynamic Memory Controller dyn=
amic frequency and voltage change"

Don't need to define the separate constant because MODULE_DESCRIPTION
only use it. You can describe it with MODULE_DESCRIPTION. Remove the
separate definition.

> +
> +#define EXYNOS5422_REV_0 (0x1)
> +#define EXYNOS5422_PROD_REV_MAIN_MASK (0xf0)
> +#define EXYNOS5422_PROD_REV_SUB_MASK (0xf)

The above three definitions are never used on this driver.

> +
> +#define EXYNOS5_DREXI_TIMINGAREF       (0x0030)
> +#define EXYNOS5_DREXI_TIMINGROW0       (0x0034)
> +#define EXYNOS5_DREXI_TIMINGDATA0      (0x0038)
> +#define EXYNOS5_DREXI_TIMINGPOWER0     (0x003C)
> +#define EXYNOS5_DREXI_TIMINGROW1       (0x00E4)
> +#define EXYNOS5_DREXI_TIMINGDATA1      (0x00E8)
> +#define EXYNOS5_DREXI_TIMINGPOWER1     (0x00EC)
> +
> +#define EXYNOS5_DREXI_MEMCTRL          (0x0004)
> +#define EXYNOS5_DREXI_DIRECTCMD                (0x0010)
> +#define EXYNOS5_DREXI_TIMINGAREF       (0x0030)

It is redefined on this driver.

> +#define EXYNOS5_DREXI_TIMINGSETSW      (0x00E0)
> +#define EXYNOS5_DREXI_MRSTATUS         (0x0054)
> +#define EXYNOS5_DREXI_QOSCONTROL8      (0x00A0)
> +#define EXYNOS5_DREXI_BRBRSVCONTROL    (0x0100)
> +#define EXYNOS5_DREXI_BP_CONTROL0      (0x0210)
> +#define EXYNOS5_DREXI_BP_CONTROL1      (0x0220)
> +#define EXYNOS5_DREXI_BP_CONTROL2      (0x0230)
> +#define EXYNOS5_DREXI_BP_CONTROL3      (0x0240)
> +
> +#define EXYNOS5_LPDDR3PHY_CON3                  (0x0A20)
> +#define EXYNOS5_TIMING_SET_SWI                  (1UL << 28)

Dont' use the space for indentation.

> +
> +#define AREF_NORMAL                    (0x2e)

It doesn't contain the 'EXYNOS_' prefix. why?

> +
> +#define EXYNOS5_TIMING_USE_SET               (1UL << 4)
> +#define EXYNOS5_TIMING_SET_SW_CON               (1UL)

Dont' use the space for indentation.

hmm. The above two definitions are not used on this driver.
Do you just copy them from other file?

> +
> +#define EXYNOS5_CLK_MUX_STAT_CDREX             (0x400)
> +#define EXYNOS5_MCLK_CDREX_SEL_BPLL            (1UL)
> +#define EXYNOS5_MCLK_CDREX_SEL_MX_MSPLL                (2UL)
> +#define EXYNOS5_CLKSRC_CDREX_SEL_SHIFT         (4)
> +#define EXYNOS5_MCLK_CDREX_MASK                        (0x7)
> +
> +#define EXYNOS5_CLK_SRC_CDREX          (0x200)

> +#define DMC_PAUSE_CTRL                 (0x91C)
> +#define DMC_PAUSE_ENABLE                       (1UL)

> +#define SELF_REFRESH_MASK              (0x20UL)
> +#define SR_CMD_EXIT_CHIP0              (0x08000000)
> +#define SR_CMD_EXIT_CHIP1              (0x08100000)
> +#define CMD_SR_ENTER           (0x04000000)
> +#define CMD_SR_EXIT            (0x08000000)
> +#define CMD_CHIP0              (0x00000000)
> +#define CMD_CHIP1              (0x00100000)

The above seven definitions are not used.

> +#define USE_MX_MSPLL_TIMINGS   (1)
> +#define USE_BPLL_TIMINGS       (0)
> +
> +#define DMC_REG_VOLT_STEP      0

Why don't you add 'EXYNOS5_' prefix from 'DMC_PAUSE_CTRL' to 'USE_BPLL_TIMI=
NGS'?

> +
> +#define IS_MEM_2GB(val) \
> +       (                                               \
> +        (((val) & 0xf0) & 0x20) ? 1 :                  \
> +               (((val) & 0xf0) & 0x30) ? 1 : 0         \
> +       )
> +
> +#define EXYNOS5_POP_OPTIONS(val) \
> +               (((val >> 4) & 0x3UL) << 4)

Don't need to add on next line. It is possible to specify on per line.

> +#define EXYNOS5_DDR_TYPE(val) \
> +               (((val >> 14) & 0x1UL))

ditto.

> +
> +#define CHIP_PROD_ID   (0)
> +#define CHIP_PKG_ID    (4)
> +
> +#define PMCNT_CONST_RATIO_MUL 15
> +#define PMCNT_CONST_RATIO_DIV 10

It looks like the value for PPMU. You better to add 'PPMU_' prefix.

> +

The above definitions have the different indentation. Please keep the
same indentation for the readability.

> +/**
> + * enum dmc_slot_id - An enum with slots in DMC
> + */
> +enum dmc_slot_id {
> +       DMC0_0,
> +       DMC0_1,
> +       DMC1_0,
> +       DMC1_1,
> +       DMC_SLOTS_END
> +};
> +
> +/**
> + * struct dmc_slot_info - Describes DMC's slot
> + *
> + * The structure holds DMC's slot name which is part of the device name
> + * provided in DT. Each slot has particular share of the DMC bandwidth.
> + * To abstract the model performance and values in performance counters,
> + * fields 'ratio_mul' and 'ratio_div' are used in calculation algorithm
> + * for each slot. Please check the corresponding function with the algor=
ithm,
> + * to see how these variables are used.
> + */
> +struct dmc_slot_info {
> +       char *name;
> +       int id;
> +       int ratio_mul;
> +       int ratio_div;
> +};
> +
> +/**
> + * struct dmc_opp_table - Operating level desciption
> + *
> + * Covers frequency and voltage settings of the DMC operating mode.
> + */
> +struct dmc_opp_table {
> +       unsigned long freq_khz;
> +       unsigned long volt_uv;
> +};
> +
> +/**
> + * struct dram_param - Parameters for the external memory chip
> + *
> + * Covers timings settings for a particular memory chip's operating freq=
uency.
> + */
> +struct dram_param {
> +       unsigned int timing_row;
> +       unsigned int timing_data;
> +       unsigned int timing_power;
> +};
> +
> +/**
> + * struct exynos5_dmc - main structure describing DMC device
> + *
> + * The main structure for the Dynamic Memory Controller which covers clo=
cks,
> + * memory regions, HW information, parameters and current operating mode=
.
> + */
> +struct exynos5_dmc {
> +       struct device *dev;
> +       struct devfreq *df;
> +       struct devfreq_simple_ondemand_data gov_data;
> +       void __iomem *base_drexi0;
> +       void __iomem *base_drexi1;
> +       void __iomem *base_clk;
> +       void __iomem *chip_id;
> +       struct mutex lock;
> +       unsigned long curr_rate;
> +       unsigned long curr_volt;
> +       const struct dmc_opp_table *opp;
> +       const struct dmc_opp_table *opp_bypass;
> +       int opp_count;
> +       const struct dram_param *dram_param;
> +       const struct dram_param *dram_bypass_param;
> +       int dram_param_count;
> +       unsigned int prod_rev;
> +       unsigned int pkg_rev;
> +       unsigned int mem_info;
> +       struct regulator *vdd_mif;
> +       struct clk *fout_spll;
> +       struct clk *fout_bpll;
> +       struct clk *mout_spll;
> +       struct clk *mout_bpll;
> +       struct clk *mout_mclk_cdrex;
> +       struct clk *dout_clk2x_phy0;
> +       struct clk *mout_mx_mspll_ccore;
> +       struct clk *mx_mspll_ccore_phy;
> +       struct clk *mout_mx_mspll_ccore_phy;
> +       struct devfreq_event_dev **counter;
> +       int num_counters;
> +       bool counters_enabled;
> +};
> +
> +/**
> + * exynos5_counters_fname() - Macro generating function for event device=
s
> + * @f:         function name suffix
> + *
> + * Macro which generates needed function for manipulation of event devic=
es.
> + * It aims to avoid code duplication relaying on similar prefix and func=
tion
> + * parameters in the devfreq event device framework functions.
> + */
> +#define exynos5_counters_fname(f)                              \
> +static int exynos5_counters_##f(struct exynos5_dmc *dmc)       \
> +{                                                              \
> +       int i, ret;                                             \
> +                                                               \
> +       for (i =3D 0; i < dmc->num_counters; i++) {               \
> +               if (!dmc->counter[i])                           \
> +                       continue;                               \
> +               ret =3D devfreq_event_##f(dmc->counter[i]);       \
> +               if (ret < 0)                                    \
> +                       return ret;                             \
> +       }                                                       \
> +       return 0;                                               \
> +}
> +exynos5_counters_fname(set_event);
> +exynos5_counters_fname(enable_edev);
> +exynos5_counters_fname(disable_edev);
> +
> +/**
> + * dmc_opp_exynos5422 - Array with frequency and voltage values
> + *
> + * Operating points for  Exynos5422 SoC revisions.
> + * The order and sizeof the array has a meaning and is tightly connected=
 with
> + * DRAM parameters in arrays bellow.
> + */
> +static const struct dmc_opp_table dmc_opp_exynos5422[] =3D {
> +       {825000, 1050000},
> +       {728000, 1037500},
> +       {633000, 1012500},
> +       {543000, 937500},
> +       {413000, 887500},
> +       {275000, 875000},
> +       {206000, 875000},
> +       {165000, 875000},
> +};

Usually, almost device drivers got the OPP table from devicetree by
using dev_pm_opp_of_add_table(). You can refer to other devfreq device
drivers like exynos-bus.c, rk3399_dmc.c. Please get the opp
information from devicetree.

If define the opp table in the device driver, the user cannot check
the opp information through devicetree.

> +
> +/**
> + * dmc_opp_bypass_exynos5422 - frequency and voltage level for temporary=
 mode
> + */
> +static const struct dmc_opp_table dmc_opp_bypass_exynos5422 =3D {400000,=
 887500};

ditto.

> +
> +/**
> + * dram_param_exynos5422 - DRAM timings for particular HW setup
> + *
> + * Operating parameters for DRAM memory running with different clock fre=
quency.
> + * The order is the same as in 'dmc_opp_table' above, the highest freque=
ncy
> + * is first.
> + * These settings are needed for proper operation of the DRAM memory wit=
h
> + * corresponding frequency. They are calculated for Exynos5422 revision =
0
> + * with 2GB LPDDR3 memory chip.
> + */
> +static const struct dram_param dram_param_exynos5422[] =3D {
> +       {0x365A9713, 0x4740085E, 0x543A0446},
> +       {0x30598651, 0x3730085E, 0x4C330336},
> +       {0x2A48758F, 0x3730085E, 0x402D0335},
> +       {0x244764CD, 0x3730085E, 0x38270335},
> +       {0x1B35538A, 0x2720085E, 0x2C1D0225},
> +       {0x12244287, 0x2720085E, 0x1C140225},
> +       {0x112331C6, 0x2720085E, 0x180F0225},
> +       {0x11223185, 0x2720085E, 0x140C0225},
> +};

If device driver need  data depends on h/w device like opp table, you
shoud get them from devicetree which specify the h/w information. You
can refer to  'drivers/devfreq/rk3399_dmc.c' in order to get timing
information.

> +
> +
> +/**
> + * Operating parameters for DRAM memory running on temporary clock 400MH=
z during
> + * switching frequency on the main clock. This variable provides timings=
 for
> + * Exynos5422 SoC revision 0 and DRAM 2GB chip.
> + */
> +static const struct dram_param dram_bypass_param_exynos5422 =3D {
> +       0x365a9713, 0x4740085e, 0x543a0446
> +};

ditto.

> +
> +/**
> + * dmc_slot - An array which holds DMC's slots information
> + *
> + * The array is used in algorithm calculating slots performance and usag=
e
> + * based on performance counters' values. The values i.e. 15/10=3D1.5 co=
rrespond
> + * to slot share in the DMC channel, which has 2.0 abstract width.
> + */
> +static const struct dmc_slot_info dmc_slot[] =3D {
> +       {"dmc0_0", DMC0_0, 15, 10},
> +       {"dmc0_1", DMC0_1, 5, 10},
> +       {"dmc1_0", DMC1_0, 10, 10},
> +       {"dmc1_1", DMC1_0, 10, 10},
> +};
> +
> +/**
> + * find_target_freq_id() - Finds requested frequency in local DMC config=
uration
> + * @dmc:       device for which the information is checked
> + * @target_rate:       requested frequency in KHz
> + *
> + * Seeks in the local DMC driver structure for the requested frequency v=
alue
> + * and returns index or error value.
> + */
> +static int find_target_freq_idx(struct exynos5_dmc *dmc,
> +                               unsigned long target_rate)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < dmc->opp_count; i++)
> +               if (dmc->opp[i].freq_khz <=3D target_rate)
> +                       return i;
> +
> +       return -EINVAL;
> +}
> +
> +/**
> + * exynos5_get_chip_info() - Gets chip ID information
> + * @dmc:       device for which the information is checked
> + *
> + * Function wrapper for getting the chip ID information.
> + */
> +static void exynos5_get_chip_info(struct exynos5_dmc *dmc)
> +{
> +       unsigned int val;
> +
> +       val =3D readl(dmc->chip_id + CHIP_PROD_ID);
> +       dmc->prod_rev =3D val;
> +
> +       val =3D readl(dmc->chip_id + CHIP_PKG_ID);
> +       dmc->pkg_rev =3D val;
 > +
> +       dmc->mem_info =3D EXYNOS5_POP_OPTIONS(val);
> +       dmc->mem_info |=3D EXYNOS5_DDR_TYPE(val);
> +}

Don't need to make it as the separate function. Just add this code in
the exynos5_dmc_chip_revision_settings.

> +
> +/**
> + * exynos5_dmc_pause_on_switching() - Controls a pause feature in DMC
> + * @dmc:       device which is used for changing this feature
> + * @set:       a boolean state passing enable/disable request
> + *
> + * There is a need of pausing DREX DMC when divider or MUX in clock tree
> + * changes its configuration. In such situation access to the memory is =
blocked
> + * in DMC automatically. This feature is used when clock frequency chang=
e
> + * request appears and touches clock tree.
> + */
> +static int exynos5_dmc_pause_on_switching(struct exynos5_dmc *dmc, bool =
set)

Don't need to make it as the separate function. It is only used on
probe() function.

> +{
> +       unsigned int val;
> +
> +       val =3D readl(dmc->base_clk + DMC_PAUSE_CTRL);
> +       if (set)
> +               val |=3D DMC_PAUSE_ENABLE;
> +       else
> +               val &=3D ~DMC_PAUSE_ENABLE;
> +       writel(val, dmc->base_clk + DMC_PAUSE_CTRL);

The dt-binding file doesn't explain the 'reg' property for 'base_clk'.
You are missing.
When I tried to find what are the base address, it is the register map
of clock-controller.
This driver accesed the register of clock controller without any
functions of CCF
(common clock framework). It is wrong.

If you need to get the some information of clock, must have to use the CCF.

> +
> +       return 0;
> +}


> +
> +/**
> + * exynos5_dmc_chip_revision_settings() - Chooses proper DMC's configura=
tion
> + * @dmc:       device for which is going to be checked and configured
> + *
> + * Function checks the HW product information in order to choose proper
> + * configuration for DMC frequency, voltage and DRAM timings.
> + */
> +static int exynos5_dmc_chip_revision_settings(struct exynos5_dmc *dmc)
> +{
> +       exynos5_get_chip_info(dmc);
> +
> +       if (!IS_MEM_2GB(dmc->mem_info)) {
> +               dev_warn(dmc->dev, "DRAM memory type not supported\n");
> +               return -EINVAL;
> +       }
> +
> +       dmc->dram_param =3D dram_param_exynos5422;
> +
> +       dmc->dram_param_count =3D ARRAY_SIZE(dram_param_exynos5422);
> +
> +       dmc->dram_bypass_param =3D &dram_bypass_param_exynos5422;
> +
> +       dmc->opp =3D dmc_opp_exynos5422;
> +       dmc->opp_count =3D ARRAY_SIZE(dmc_opp_exynos5422);
> +
> +       dmc->opp_bypass =3D &dmc_opp_bypass_exynos5422;

As I already commented, you have to get the data depends on h/w device
from devicetree like opp information.

> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_init_freq_table() - Initialized PM OPP framework
> + * @dev:       devfreq device for which the OPP table is going to be
> + *             initialized
> + * @dmc:       DMC device for which the frequencies are used for OPP ini=
t
> + * @profile:   devfreq device's profile
> + *
> + * Populate the devfreq device's OPP table based on current frequency, v=
oltage.
> + */
> +static int exynos5_init_freq_table(struct device *dev, struct exynos5_dm=
c *dmc,
> +                                  struct devfreq_dev_profile *profile)
> +{
> +       int i, ret;
> +
> +       for (i =3D 0; i < dmc->opp_count; i++) {
> +               ret =3D dev_pm_opp_add(dev, dmc->opp[i].freq_khz,
> +                                    dmc->opp[i].volt_uv);
> +               if (ret) {
> +                       dev_warn(dev, "failed to add opp %uHz %umV\n", 1,=
 1);
> +                       while (i-- > 0)
> +                               dev_pm_opp_remove(dev, dmc->opp[i].freq_k=
hz);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}

If you get the OPP information from devicetree through OPP framework,
you don't need to add them by yourself.

> +
> +/**
> + * exynos5_set_bypass_dram_timings() - Low-level changes of the DRAM tim=
ings
> + * @dmc:       device for which the new settings is going to be applied
> + * @param:     DRAM parameters which passes timing data
> + *
> + * Low-level function for changing timings for DRAM memory clocking from
> + * 'bypass' clock source (fixed frequency @400MHz).
> + * It uses timing bank registers set 1.
> + */
> +static void exynos5_set_bypass_dram_timings(struct exynos5_dmc *dmc,
> +                                           const struct dram_param *para=
m)
> +{
> +

Remove unneeded blank line.

> +       writel(AREF_NORMAL, dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGAREF);
> +
> +       writel(param->timing_row,
> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGROW1);
> +       writel(param->timing_row,
> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGROW1);
> +       writel(param->timing_data,
> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGDATA1);
> +       writel(param->timing_data,
> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGDATA1);
> +       writel(param->timing_power,
> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGPOWER1);
> +       writel(param->timing_power,
> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGPOWER1);
> +}
> +

Remove unneeded blank line.

> +
> +/**
> + * exynos5_dram_change_timings() - Low-level changes of the DRAM final t=
imings
> + * @dmc:       device for which the new settings is going to be applied
> + * @target_rate:       target frequency of the DMC
> + *
> + * Low-level function for changing timings for DRAM memory operating fro=
m main
> + * clock source (BPLL), which can have different frequencies. Thus, each
> + * frequency must have corresponding timings register values in order to=
 keep
> + * the needed delays.
> + * It uses timing bank registers set 0.
> + */
> +static int exynos5_dram_change_timings(struct exynos5_dmc *dmc,
> +                                      unsigned long target_rate)
> +{
> +       int idx;
> +
> +

Remove unneeded blank line.

> +       for (idx =3D 0; idx < dmc->dram_param_count; idx++)
> +               if (dmc->opp[idx].freq_khz <=3D target_rate)
> +                       break;
> +
> +       if (idx >=3D dmc->dram_param_count)
> +               return -EINVAL;
> +
> +       writel(AREF_NORMAL, dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGAREF);
> +
> +       writel(dmc->dram_param[idx].timing_row,
> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGROW0);
> +       writel(dmc->dram_param[idx].timing_row,
> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGROW0);
> +       writel(dmc->dram_param[idx].timing_data,
> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGDATA0);
> +       writel(dmc->dram_param[idx].timing_data,
> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGDATA0);
> +       writel(dmc->dram_param[idx].timing_power,
> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGPOWER0);
> +       writel(dmc->dram_param[idx].timing_power,
> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGPOWER0);
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_switch_timing_regs() - Changes bank register set for DRAM tim=
ings
> + * @dmc:       device for which the new settings is going to be applied
> + * @set:       boolean variable passing set value
> + *
> + * Changes the register set, which holds timing parameters.
> + * There is two register sets: 0 and 1. The register set 0
> + * is used in normal operation when the clock is provided from main PLL.
> + * The bank register set 1 is used when the main PLL frequency is going =
to be
> + * changed and the clock is taken from alternative, stable source.
> + * This function switches between these banks according to the
> + * currently used clock source.
> + */
> +static void exynos5_switch_timing_regs(struct exynos5_dmc *dmc, bool set=
)
> +{
> +       unsigned int reg;
> +
> +       reg =3D readl(dmc->base_clk + EXYNOS5_LPDDR3PHY_CON3);
> +
> +       if (set)
> +               reg |=3D EXYNOS5_TIMING_SET_SWI;
> +       else
> +               reg &=3D ~EXYNOS5_TIMING_SET_SWI;
> +
> +       writel(reg, dmc->base_clk + EXYNOS5_LPDDR3PHY_CON3);
> +}
> +
> +/*
> + * Change clock parent for MUX_CORE_SEL and the main clock for DMC.
> + * The mux takes two clock sources: main BPLL and mx_mspll ('bypass').
> + */
> +static int exynos5_dmc_change_clock_parent(struct exynos5_dmc *dmc,
> +                                          struct clk *parent,
> +                                          unsigned int parent_selection_=
id)
> +{
> +       unsigned int reg =3D 0;
> +
> +       reg =3D readl(dmc->base_clk + EXYNOS5_CLK_SRC_CDREX);
> +       if (clk_set_parent(dmc->mout_mclk_cdrex, parent)) {
> +               dev_err(dmc->dev, "Couldn't change parent of mclk_cdrex\n=
");
> +               return -EINVAL;
> +       }
> +
> +       for ( ; reg !=3D parent_selection_id; ) {
> +               cpu_relax();
> +               reg =3D readl(dmc->base_clk + EXYNOS5_CLK_MUX_STAT_CDREX)=
;
> +               reg >>=3D EXYNOS5_CLKSRC_CDREX_SEL_SHIFT;
> +               reg &=3D EXYNOS5_MCLK_CDREX_MASK;
> +       }
> +
> +       return 0;

When handling the clock controller, like changing the parent clock,
you have to use the clock framework. If changing the issue of parent clock,
you should fix the issue on clock driver and then just use the clock api
provided by clock framework(CCF). I can't agree to access the clock registe=
r map
directly without the clock framework.

> +}
> +
> +
> +/**
> + * exynos5_dmc_change_voltage() - Changes the voltage regulator value
> + * @dmc:       device for which it is going to be set
> + * @target_volt:       new voltage which is chosen to be final
> + *
> + * Main function for changing voltage on the VDD_MIF regulator.
> + */
> +static int exynos5_dmc_change_voltage(struct exynos5_dmc *dmc,
> +                                     unsigned long target_volt)

Don't  to make it as separate function. Just call the
'regulator_set_voltage' on proper position.

> +{
> +       int ret;
> +
> +       ret =3D regulator_set_voltage(dmc->vdd_mif, target_volt,
> +                                   target_volt + DMC_REG_VOLT_STEP);
> +
> +       if (ret)
> +               return ret;
> +
> +       dmc->curr_volt =3D target_volt;
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_dmc_align_target_voltage() - Sets the final voltage for the D=
MC
> + * @dmc:       device for which it is going to be set
> + * @target_volt:       new voltage which is chosen to be final
> + *
> + * Function tries to align voltage to the safe level for 'normal' mode.
> + * It checks the need of higher voltage and changes the value. The targe=
t
> + * voltage might be lower that currently set and still the system will b=
e
> + * stable.
> + */
> +static int exynos5_dmc_align_target_voltage(struct exynos5_dmc *dmc,
> +                                           unsigned long target_volt)
> +{


Don't  need to make it as separate function. Just call the
'regulator_set_voltage'
after comparing the current voltage. Please remove the separate function.

> +       int ret =3D 0;
> +
> +       if (dmc->curr_volt > target_volt)
> +               ret =3D exynos5_dmc_change_voltage(dmc, target_volt);
> +
> +       return ret;
> +}
> +
> +/**
> + * exynos5_dmc_align_bypass_voltage() - Sets the voltage for the DMC
> + * @dmc:       device for which it is going to be set
> + * @target_volt:       new voltage which is chosen to be final
> + *
> + * Function tries to align voltage to the safe level for the 'bypass' mo=
de.
> + * It checks the need of higher voltage and changes the value.
> + * The target voltage must not be less than currently needed, because
> + * for current frequency the device might become unstable.
> + */
> +static int exynos5_dmc_align_bypass_voltage(struct exynos5_dmc *dmc,
> +                                           unsigned long target_volt)
> +{

This function is called only one time. Don't  need to make it as
separate function.

> +       int ret =3D 0;
> +       unsigned long bypass_volt =3D dmc->opp_bypass->volt_uv;
> +
> +       target_volt =3D max(bypass_volt, target_volt);
> +
> +       if (dmc->curr_volt >=3D target_volt)
> +               return 0;
> +
> +       ret =3D exynos5_dmc_change_voltage(dmc, target_volt);
> +
> +       return ret;
> +}
> +
> +/**
> + * exynos5_dmc_align_bypass_dram_timings() - Chooses and sets DRAM timin=
gs
> + * @dmc:       device for which it is going to be set
> + * @target_rate:       new frequency which is chosen to be final
> + *
> + * Function changes the DRAM timings for the temporary 'bypass' mode.
> + */
> +static int exynos5_dmc_align_bypass_dram_timings(struct exynos5_dmc *dmc=
,
> +                                                unsigned long target_rat=
e)

This function is called only one time. Don't  need to make it as
separate function.
If you add the detailed comment about code, it is enought. Please
remove the separate function.

> +{
> +       int idx =3D find_target_freq_idx(dmc, target_rate);
> +
> +       if (idx < 0)
> +               return -EINVAL;
> +
> +       exynos5_set_bypass_dram_timings(dmc, dmc->dram_bypass_param);
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_dmc_switch_to_bypass_configuration() - Switching to temporary=
 clock
> + * @dmc:       DMC device for which the switching is going to happen
> + * @target_rate:       new frequency which is going to be set as a final
> + * @target_volt:       new voltage which is going to be set as a final
> + *
> + * Function configures DMC and clocks for operating in temporary 'bypass=
' mode.
> + * This mode is used only temporary but if required, changes voltage and=
 timings
> + * for DRAM chips. It switches the main clock to stable clock source for=
 the
> + * period of the main PLL reconfiguration.
> + */
> +static int exynos5_dmc_switch_to_bypass_configuration(struct exynos5_dmc=
 *dmc,
> +                                  unsigned long target_rate,
> +                                  unsigned long target_volt)
> +{
> +       int ret;
> +
> +       /*
> +        * Having higher voltage for a particular frequency does not harm
> +        * the chip. Use it for the temporary frequency change when one
> +        * voltage manipulation might be avoided.
> +        */
> +       ret =3D exynos5_dmc_align_bypass_voltage(dmc, target_volt);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Longer delays for DRAM does not cause crash, the opposite does=
.
> +        */
> +       ret =3D exynos5_dmc_align_bypass_dram_timings(dmc, target_rate);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Delays are long enough, so use them for the new coming clock.
> +        */
> +       exynos5_switch_timing_regs(dmc, USE_MX_MSPLL_TIMINGS);
> +
> +       /*
> +        * Voltage is set at least to a level needed for this frequency,
> +        * so switching clock source is safe now.
> +        */
> +       clk_prepare_enable(dmc->fout_spll);
> +       clk_prepare_enable(dmc->mout_spll);
> +       clk_prepare_enable(dmc->mout_mx_mspll_ccore);
> +       ret =3D exynos5_dmc_change_clock_parent(dmc, dmc->mout_mx_mspll_c=
core,
> +                                             EXYNOS5_MCLK_CDREX_SEL_MX_M=
SPLL);
> +       return ret;
> +}
> +
> +/**
> + * exynos5_dmc_change_freq_and_volt() - Changes voltage and frequency of=
 the DMC
> + * using safe procedure
> + * @dmc:       device for which the frequency is going to be changed
> + * @target_rate:       requested new frequency
> + * @target_volt:       requested voltage which corresponds to the new fr=
equency
> + *
> + * The DMC frequency change procedure requires a few steps.
> + * The main requirement is to change the clock source in the clk mux
> + * for the time of main clock PLL locking. The assumption is that the
> + * alternative clock source set as parent is stable.
> + * The second parent's clock frequency is fixed to 400MHz, it is named '=
bypass'
> + * clock. This requires alignment in DRAM timing parameters for the new
> + * T-period. There is two bank sets for keeping DRAM
> + * timings: set 0 and set 1. The set 0 is used when main clock source is
> + * chosen. The 2nd set of regs is used for 'bypass' clock. Switching bet=
ween
> + * the two bank sets is part of the process.
> + * The voltage must also be aligned to the minimum required level. There=
 is
> + * this intermediate step with switching to 'bypass' parent clock source=
.
> + * if the old voltage is lower, it requires an increase of the voltage l=
evel.
> + * The complexity of the voltage manipulation is hidden in low level fun=
ction.
> + * In this function there is last alignment of the voltage level at the =
end.
> + */
> +static int
> +exynos5_dmc_change_freq_and_volt(struct exynos5_dmc *dmc,
> +                                unsigned long target_rate,
> +                                unsigned long target_volt)
> +{
> +       int ret;
> +
> +       ret =3D exynos5_dmc_switch_to_bypass_configuration(dmc, target_ra=
te,
> +                                                        target_volt);
> +       if (ret)
> +               return ret;
> +
> +       /* We are safe to increase the timings for current bypass frequen=
cy.
> +        * Thanks to this the settings we be ready for the upcoming clock=
 source
> +        * change.
> +        */
> +       exynos5_dram_change_timings(dmc, target_rate);
> +
> +       clk_set_rate(dmc->fout_bpll, target_rate * 1000);
> +
> +       exynos5_switch_timing_regs(dmc, USE_BPLL_TIMINGS);
> +
> +       ret =3D exynos5_dmc_change_clock_parent(dmc, dmc->mout_bpll,
> +                                             EXYNOS5_MCLK_CDREX_SEL_BPLL=
);

As I commented already, it is wrong to access the register of clock
controller directly by this driver without clcok framework.

> +       if (ret)
> +               return ret;
> +
> +       clk_disable_unprepare(dmc->mout_mx_mspll_ccore);
> +       clk_disable_unprepare(dmc->mout_spll);
> +       clk_disable_unprepare(dmc->fout_spll);
> +       /* Make sure if the voltage is not from 'bypass' settings and ali=
gn to
> +        * the right level for power efficiency.
> +        */
> +       ret =3D exynos5_dmc_align_target_voltage(dmc, target_volt);
> +
> +       return ret;
> +}
> +
> +/**
> + * exynos5_dmc_get_volt_freq() - Gets the frequency and voltage from the=
 OPP
> + * table.
> + * @dev:       device for which the frequency is going to be changed
> + * @freq:       requested frequency in KHz
> + * @target_rate:       returned frequency which is the same or lower tha=
n
> + *                     requested
> + * @target_volt:       returned voltage which corresponds to the returne=
d
> + *                     frequency
> + *
> + * Function gets requested frequency and checks OPP framework for needed
> + * frequency and voltage. It populates the values 'target_rate' and
> + * 'target_volt' or returns error value when OPP framework fails.
> + */
> +static int exynos5_dmc_get_volt_freq(struct device *dev, unsigned long *=
freq,
> +                                    unsigned long *target_rate,
> +                                    unsigned long *target_volt, u32 flag=
s)
> +{
> +       struct dev_pm_opp *opp;
> +
> +       opp =3D devfreq_recommended_opp(dev, freq, flags);
> +       if (IS_ERR(opp))
> +               return PTR_ERR(opp);
> +
> +       *target_rate =3D dev_pm_opp_get_freq(opp);
> +       *target_volt =3D dev_pm_opp_get_voltage(opp);
> +       dev_pm_opp_put(opp);
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_dmc_target() - Function responsible for changing frequency of=
 DMC
> + * @dev:       device for which the frequency is going to be changed
> + * @freq:      requested frequency in KHz
> + * @flags:     flags provided for this frequency change request
> + *
> + * An entry function provided to the devfreq framework which provides fr=
equency
> + * change of the DMC. The function gets the possible rate from OPP table=
 based
> + * on requested frequency. It calls the next function responsible for th=
e
> + * frequency and voltage change. In case of failure, does not set 'curr_=
rate'
> + * and returns error value to the framework.
> + */
> +static int exynos5_dmc_target(struct device *dev, unsigned long *freq,
> +                             u32 flags)
> +{
> +       struct exynos5_dmc *dmc =3D dev_get_drvdata(dev);
> +       unsigned long target_rate =3D 0;
> +       unsigned long target_volt =3D 0;
> +       int ret;
> +
> +       ret =3D exynos5_dmc_get_volt_freq(dev, freq, &target_rate, &targe=
t_volt,
> +                                       flags);
> +       if (ret)
> +               return ret;
> +
> +       if (target_rate =3D=3D dmc->curr_rate)
> +               return 0;
> +
> +       mutex_lock(&dmc->lock);
> +
> +       ret =3D exynos5_dmc_change_freq_and_volt(dmc, target_rate, target=
_volt);
> +
> +       if (ret) {
> +               mutex_unlock(&dmc->lock);
> +               return ret;
> +       }
> +
> +       dmc->curr_rate =3D target_rate;
> +
> +       mutex_unlock(&dmc->lock);
> +       return 0;
> +}
> +
> +/**
> + * exynos5_cnt_name_match() - Tries to match 'edev' with the right devic=
e index
> + * @edev:       event device for which the name is going to be matched
> + *
> + * Function matches the name of the 'edev' counter device with known dev=
ices
> + * with configured ratios and shares of the DMC channels.
> + * When the name is matched, it returns the index for the proper device.
> + */
> +static int exynos5_cnt_name_match(struct devfreq_event_dev *edev)

Dont' need to make it as separate function. Just add it to
exynos5_cnt_calculate.

> +{
> +       int i;
> +       int id =3D -ENODEV;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(dmc_slot); i++) {
> +               if (strstr(edev->desc->name, dmc_slot[i].name))
> +                       return i;
> +       }
> +
> +       return id;
> +}
> +
> +/**
> + * exynos5_cnt_calculate() - Calculates the values of performance counte=
rs.
> + * @edev:      event device for which the counter is used for calculatio=
n
> + * @cnt:       raw counter value
> + * @cnt_norm:  counter value normalized to DMC performance ratio for a p=
roper
> + *             channel or virtual channel
> + *
> + * Function calculates normalized value for the raw counter. The raw cou=
nter
> + * value does not show real channel usage. The DMC splits not equally th=
e
> + * bandwidth for the channels. The function checks the type of the 'edev=
'
> + * counter and calculates the normalized value based on the 'shares' of =
the
> + * bandwidth set in the controller.
> + */
> +static int exynos5_cnt_calculate(struct devfreq_event_dev *edev,
> +                                unsigned long cnt, u64 *cnt_norm)
> +{
> +       int idx;
> +
> +       idx =3D exynos5_cnt_name_match(edev);
> +       if (idx < 0)
> +               return idx;
> +
> +       *cnt_norm =3D cnt;
> +
> +       if (!(dmc_slot[idx].ratio_mul =3D=3D dmc_slot[idx].ratio_div)) {
> +               *cnt_norm =3D *cnt_norm * dmc_slot[idx].ratio_mul;
> +               *cnt_norm =3D div_u64(*cnt_norm, dmc_slot[idx].ratio_div)=
;
> +       }
> +
> +       *cnt_norm =3D *cnt_norm * PMCNT_CONST_RATIO_MUL;
> +       *cnt_norm =3D div_u64(*cnt_norm, PMCNT_CONST_RATIO_DIV);
> +
> +       return idx;
> +}
> +
> +/**
> + * exynos5_counters_get() - Gets the performance counters values.
> + * @dmc:       device for which the counters are going to be checked
> + * @load_count:        variable which is populated with counter value
> + * @total_count:       variable which is used as 'wall clock' reference
> + *
> + * Function which provides performance counters values. It sums up count=
ers for
> + * two DMC channels. The 'total_count' is used as a reference and max va=
lue.
> + * The ratio 'load_count/total_count' shows the busy percentage [0%, 100=
%].
> + */
> +static int exynos5_counters_get(struct exynos5_dmc *dmc,
> +                               unsigned long *load_count,
> +                               unsigned long *total_count)
> +{
> +       unsigned long load_dmc[2] =3D {0, 0};
> +       unsigned long total =3D 0;
> +       u64 load =3D 0;
> +       struct devfreq_event_data event;
> +       int ret, i, idx;
> +
> +       for (i =3D 0; i < dmc->num_counters; i++) {
> +               if (!dmc->counter[i])
> +                       continue;
> +
> +               ret =3D devfreq_event_get_event(dmc->counter[i], &event);
> +               if (ret < 0)
> +                       return ret;
> +
> +               idx =3D exynos5_cnt_calculate(dmc->counter[i], event.load=
_count,
> +                                           &load);
> +               if (idx < 0)
> +                       continue;
> +
> +               if (idx =3D=3D DMC0_0 || idx =3D=3D DMC0_1)
> +                       load_dmc[0] +=3D load;
> +               else
> +                       load_dmc[1] +=3D load;
> +
> +               if (total < event.total_count)
> +                       total =3D event.total_count;
> +       }
> +
> +       *load_count =3D load_dmc[0] + load_dmc[1];
> +       *total_count =3D total;
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_dmc_get_status() - Read current DMC performance statistics.
> + * @dev:       device for which the statistics are requested
> + * @stat:      structure which has statistic fields
> + *
> + * Function reads the DMC performance counters and calculates 'busy_time=
'
> + * and 'total_time'. To protect from overflow, the values are shifted ri=
ght
> + * by 10. After read out the counters are setup to count again.
> + */
> +static int exynos5_dmc_get_status(struct device *dev,
> +                                 struct devfreq_dev_status *stat)
> +{
> +       struct exynos5_dmc *dmc =3D dev_get_drvdata(dev);
> +       unsigned long load, total;
> +       int ret;
> +       bool cnt_en;
> +
> +       mutex_lock(&dmc->lock);
> +       cnt_en =3D dmc->counters_enabled;
> +       mutex_unlock(&dmc->lock);
> +       if (!cnt_en) {
> +               dev_warn(dev, "performance counters needed, but not prese=
nt\n");
> +               return -EAGAIN;
> +       }
> +
> +       ret =3D exynos5_counters_get(dmc, &load, &total);
> +       if (ret < 0)
> +               return -EINVAL;
> +
> +       /* To protect from overflow in calculation ratios, divide by 1024=
 */
> +       stat->busy_time =3D load >> 10;
> +       stat->total_time =3D total >> 10;
> +
> +       ret =3D exynos5_counters_set_event(dmc);
> +       if (ret < 0) {
> +               dev_err(dmc->dev, "could not set event counter\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_dmc_get_cur_freq() - Function returns current DMC frequency
> + * @dev:       device for which the framework checks operating frequency
> + * @freq:      returned frequency value
> + *
> + * It returns the currently used frequency of the DMC. The real operatin=
g
> + * frequency might be lower when the clock source value could not be div=
ided
> + * to the requested value.
> + */
> +static int exynos5_dmc_get_cur_freq(struct device *dev, unsigned long *f=
req)
> +{
> +       struct exynos5_dmc *dmc =3D dev_get_drvdata(dev);
> +
> +       mutex_lock(&dmc->lock);
> +       *freq =3D dmc->curr_rate;
> +       mutex_unlock(&dmc->lock);
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_dmc_df_profile - Devfreq governor's profile structure
> + *
> + * It provides to the devfreq framework needed functions and polling per=
iod.
> + */
> +static struct devfreq_dev_profile exynos5_dmc_df_profile =3D {
> +       .polling_ms =3D 500,

Is it right? IMO, 500 ms is too late for ondemand governor.

> +       .target =3D exynos5_dmc_target,
> +       .get_dev_status =3D exynos5_dmc_get_status,
> +       .get_cur_freq =3D exynos5_dmc_get_cur_freq,
> +};
> +
> +/**
> + * exynos5_dmc_align_initial_frequency() - Align initial frequency value
> + * @dmc:       device for which the frequency is going to be set
> + * @bootloader_init_freq:      initial frequency set by the bootloader i=
n KHz
> + *
> + * The initial bootloader frequency, which is present during boot, might=
 be
> + * different that supported frequency values in the driver. It is possib=
le
> + * due to different PLL settings or used PLL as a source.
> + * This function provides the 'initial_freq' for the devfreq framework
> + * statistics engine which supports only registered values. Thus, some a=
lignment
> + * must be made.
> + */
> +unsigned long
> +exynos5_dmc_align_init_freq(struct exynos5_dmc *dmc,
> +                           unsigned long bootloader_init_freq)
> +{
> +       unsigned long aligned_freq;
> +       int idx;
> +
> +       idx =3D find_target_freq_idx(dmc, bootloader_init_freq);
> +       if (idx >=3D 0)
> +               aligned_freq =3D dmc->opp[idx].freq_khz;
> +       else
> +               aligned_freq =3D dmc->opp[dmc->opp_count - 1].freq_khz;
> +
> +       return aligned_freq;
> +}
> +
> +/**
> + * exynos5_dmc_init_clks() - Initialize clocks needed for DMC operation.
> + * @dev:       device for which the clocks are setup
> + * @dmc:       DMC structure containing needed fields
> + *
> + * Get the needed clocks defined in DT device, enable and set the right =
parents.
> + * Read current frequency and initialize the initial rate for governor.
> + */
> +static int exynos5_dmc_init_clks(struct device *dev, struct exynos5_dmc =
*dmc)
> +{
> +       int ret;
> +       unsigned long target_volt =3D 0;
> +       unsigned long target_rate =3D 0;
> +
> +       dmc->fout_spll =3D devm_clk_get(dev, "fout_spll");
> +       if (IS_ERR(dmc->fout_spll))
> +               return PTR_ERR(dmc->fout_spll);
> +
> +       dmc->fout_bpll =3D devm_clk_get(dev, "fout_bpll");
> +       if (IS_ERR(dmc->fout_bpll))
> +               return PTR_ERR(dmc->fout_bpll);
> +
> +       dmc->mout_mclk_cdrex =3D devm_clk_get(dev, "mout_mclk_cdrex");
> +       if (IS_ERR(dmc->mout_mclk_cdrex))
> +               return PTR_ERR(dmc->mout_mclk_cdrex);
> +
> +       dmc->mout_bpll =3D devm_clk_get(dev, "mout_bpll");
> +       if (IS_ERR(dmc->mout_bpll))
> +               return PTR_ERR(dmc->mout_bpll);
> +
> +       dmc->mout_mx_mspll_ccore =3D devm_clk_get(dev, "mout_mx_mspll_cco=
re");
> +       if (IS_ERR(dmc->mout_mx_mspll_ccore))
> +               return PTR_ERR(dmc->mout_mx_mspll_ccore);
> +
> +       dmc->dout_clk2x_phy0 =3D devm_clk_get(dev, "dout_clk2x_phy0");
> +       if (IS_ERR(dmc->dout_clk2x_phy0))
> +               return PTR_ERR(dmc->dout_clk2x_phy0);
> +
> +       dmc->mout_spll =3D devm_clk_get(dev, "ff_dout_spll2");
> +       if (IS_ERR(dmc->mout_spll))
> +               return PTR_ERR(dmc->mout_spll);
> +

I don't understand why do you get the parent clocks and hanel them directly=
?
You make the hierarchy between clocks by using 'assigned-clocks,
assigned-clock-parents' property on devicetree. It was too legacy
style to make the hierarchy directly on device driver. You can easily
refer to 'assigned-clocks, assigned-clock-parents' examples on exynos
dts files.

> +       /*
> +        * Convert frequency to KHz values and set it for the governor.
> +        */
> +       dmc->curr_rate =3D clk_get_rate(dmc->mout_mclk_cdrex) / 1000;
> +       dmc->curr_rate =3D exynos5_dmc_align_init_freq(dmc, dmc->curr_rat=
e);
> +       exynos5_dmc_df_profile.initial_freq =3D dmc->curr_rate;
> +
> +       ret =3D exynos5_dmc_get_volt_freq(dev, &dmc->curr_rate, &target_r=
ate,
> +                                       &target_volt, 0);
> +       if (ret)
> +               return ret;
> +
> +       dmc->curr_volt =3D target_volt;
> +
> +       clk_prepare_enable(dmc->mout_spll);
> +       clk_set_parent(dmc->mout_mx_mspll_ccore, dmc->mout_spll);
> +       clk_prepare_enable(dmc->mout_mx_mspll_ccore);
> +
> +       clk_prepare_enable(dmc->fout_bpll);
> +       clk_prepare_enable(dmc->mout_bpll);
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_performance_counters_init() - Initializes performance DMC's c=
ounters
> + * @dmc:       DMC for which it does the setup
> + *
> + * Initialization of performance counters in DMC for estimating usage.
> + * The counter's values are used for calculation of a memory bandwidth a=
nd based
> + * on that the governor changes the frequency.
> + * The counters are not used when the governor is GOVERNOR_USERSPACE.
> + */
> +static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
> +{
> +       int counters_size;
> +       int ret, i;
> +
> +       dmc->num_counters =3D devfreq_event_get_edev_count(dmc->dev);
> +       if (dmc->num_counters < 0) {
> +               dev_err(dmc->dev, "could not get devfreq-event counters\n=
");
> +               return dmc->num_counters;
> +       }
> +
> +       counters_size =3D sizeof(struct devfreq_event_dev) * dmc->num_cou=
nters;
> +       dmc->counter =3D devm_kzalloc(dmc->dev, counters_size, GFP_KERNEL=
);
> +       if (!dmc->counter)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < dmc->num_counters; i++) {
> +               dmc->counter[i] =3D
> +                       devfreq_event_get_edev_by_phandle(dmc->dev, i);
> +               if (IS_ERR_OR_NULL(dmc->counter[i]))
> +                       return -EPROBE_DEFER;
> +       }
> +
> +       ret =3D exynos5_counters_enable_edev(dmc);
> +       if (ret < 0) {
> +               dev_err(dmc->dev, "could not enable event counter\n");
> +               return ret;
> +       }
> +
> +       ret =3D exynos5_counters_set_event(dmc);
> +       if (ret < 0) {
> +               dev_err(dmc->dev, "counld not set event counter\n");
> +               return ret;
> +       }
> +
> +       mutex_lock(&dmc->lock);
> +       dmc->counters_enabled =3D true;
> +       mutex_unlock(&dmc->lock);
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos5_dmc_probe() - Probe function for the DMC driver
> + * @pdev:      platform device for which the driver is going to be initi=
alized
> + *
> + * Initialize basic components: clocks, regulators, performance counters=
, etc.
> + * Read out product version and based on the information setup
> + * internal structures for the controller (frequency and voltage) and fo=
r DRAM
> + * memory parameters: timings for each operating frequency.
> + * Register new devfreq device for controlling DVFS of the DMC.
> + */
> +static int exynos5_dmc_probe(struct platform_device *pdev)
> +{
> +       int ret =3D 0;
> +       struct exynos5_dmc *dmc;
> +       struct device *dev =3D &pdev->dev;
> +       struct resource *res;
> +
> +       dmc =3D devm_kzalloc(dev, sizeof(*dmc), GFP_KERNEL);
> +       if (!dmc)
> +               return -ENOMEM;
> +
> +       mutex_init(&dmc->lock);
> +
> +       dmc->dev =3D dev;
> +       platform_set_drvdata(pdev, dmc);
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       dmc->base_drexi0 =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(dmc->base_drexi0))
> +               return PTR_ERR(dmc->base_drexi0);
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       dmc->base_drexi1 =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(dmc->base_drexi1))
> +               return PTR_ERR(dmc->base_drexi1);
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +       dmc->base_clk =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(dmc->base_clk))
> +               return PTR_ERR(dmc->base_clk);
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 3);
> +       dmc->chip_id =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(dmc->chip_id))
> +               return PTR_ERR(dmc->chip_id);
> +
> +       ret =3D exynos5_dmc_chip_revision_settings(dmc);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D exynos5_init_freq_table(dev, dmc, &exynos5_dmc_df_profile=
);
> +       if (ret)
> +               return ret;
> +
> +       dmc->vdd_mif =3D devm_regulator_get(dev, "vdd_mif");
> +       if (IS_ERR(dmc->vdd_mif)) {
> +               ret =3D PTR_ERR(dmc->vdd_mif);
> +               dev_warn(dev, "couldn't get regulator\n");
> +               goto remove_opp_table;
> +       }
> +
> +       ret =3D exynos5_dmc_init_clks(dev, dmc);
> +       if (ret) {
> +               dev_warn(dev, "couldn't initialize clocks\n");
> +               goto remove_opp_table;
> +       }
> +
> +       ret =3D exynos5_dmc_pause_on_switching(dmc, 1);
> +       if (ret) {
> +               dev_warn(dev, "couldn't setup pause on switching\n");
> +               goto remove_clocks;
> +       }
> +
> +       ret =3D exynos5_performance_counters_init(dmc);
> +       if (ret) {
> +               dev_warn(dev, "couldn't probe performance counters\n");
> +               goto remove_clocks;
> +       }
> +       /*
> +        * Setup default thresholds for the devfreq governor.
> +        * The values are chosen based on experiments.
> +        */
> +       dmc->gov_data.upthreshold =3D 30;
> +       dmc->gov_data.downdifferential =3D 5;
> +
> +       dmc->df =3D devm_devfreq_add_device(dev, &exynos5_dmc_df_profile,
> +                                         DEVFREQ_GOV_USERSPACE,
> +                                         &dmc->gov_data);
> +
> +       if (IS_ERR(dmc->df)) {
> +               ret =3D PTR_ERR(dmc->df);
> +               goto err_devfreq_add;
> +       }
> +
> +       dev_info(&pdev->dev, "DMC init for prod_id=3D0x%08x pkg_id=3D0x%0=
8x\n",
> +                dmc->prod_rev, dmc->pkg_rev);
> +
> +       return 0;
> +
> +err_devfreq_add:
> +       exynos5_counters_disable_edev(dmc);
> +remove_clocks:
> +       clk_disable_unprepare(dmc->mout_mx_mspll_ccore);
> +       clk_disable_unprepare(dmc->mout_spll);
> +remove_opp_table:
> +       while (dmc->opp_count-- > 0)
> +               dev_pm_opp_remove(dev, dmc->opp[dmc->opp_count].freq_khz)=
;
> +
> +       return ret;
> +}
> +
> +/**
> + * exynos5_dmc_remove() - Remove function for the platform device
> + * @pdev:      platform device which is going to be removed
> + *
> + * The function relies on 'devm' framework function which automatically
> + * clean the device's resources. It just calls explicitly disable functi=
on for
> + * the performance counters.
> + */
> +static int exynos5_dmc_remove(struct platform_device *pdev)
> +{
> +       struct exynos5_dmc *dmc =3D dev_get_drvdata(&pdev->dev);
> +
> +       exynos5_counters_disable_edev(dmc);
> +
> +       clk_disable_unprepare(dmc->mout_mx_mspll_ccore);
> +       clk_disable_unprepare(dmc->mout_spll);
> +
> +       dev_pm_opp_remove_table(&pdev->dev);
> +
> +       dev_info(&pdev->dev, "DMC removed\n");
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id exynos5_dmc_of_match[] =3D {
> +       { .compatible =3D "samsung,exynos5422-dmc", },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, exynos5_dmc_of_match);
> +
> +static struct platform_driver exynos5_dmc_platdrv =3D {
> +       .probe  =3D exynos5_dmc_probe,
> +       .remove =3D exynos5_dmc_remove,
> +       .driver =3D {
> +               .name   =3D "exynos5-dmc",
> +               .of_match_table =3D exynos5_dmc_of_match,
> +       },
> +};
> +module_platform_driver(exynos5_dmc_platdrv);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Samsung");
> --
> 2.7.4
>


--=20
Best Regards,
Chanwoo Choi
