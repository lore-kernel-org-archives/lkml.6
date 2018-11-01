Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530A4ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A95205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QpaBo1Gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A95205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeKBDU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:20:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36688 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeKBDUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:20:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id x4so18611031otg.3;
        Thu, 01 Nov 2018 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EydD6ZCHKajdpkQybByKZ1/BOMTTKtQ+leA7s6M3/4c=;
        b=QpaBo1Gp0gAWqhWKqWWOwJc1Wrtj7CnLp/QZTDxc4GDHxTe6DhZeuQZVezkaw6BJL7
         XHQr/H49TdkQb6OR2ZBD+4vspITDmFNfueJ9CLk8KhB6F01m1ViZauf52QsqoG01ewWd
         vUdxz8oJ0Um5WF/eQxJXFmUACbWvhhJx1PGfRQ3OUqb/ADGIf04LYfNaBmFkJ8jmD8Ov
         MAk5FC37m8EWo1BoNIzQ9F3lV67pfDg7isNSgqRAFPnoqCuOBHvay9vdiZ0ZV+Garmxk
         j9rBfivXmPjh0OHptTpl6VGnmFElu/ZPfPJcb0m+6hHOfPpTaVGSbEN3wDAqu3qxzH10
         Py4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EydD6ZCHKajdpkQybByKZ1/BOMTTKtQ+leA7s6M3/4c=;
        b=fCOM4VigKUMC3UFvDYkWiJwLjTGUuE5RI6QdnDLreG1e7qgmzk68UEqBGEe2qX3jhj
         LR4gvul1jLqLEOdnj9fb1WvYfl47Otm/WqYQm4W/RcaoXtW16cKsCAOmjTKgicQSPRlC
         caOBN1K0z/9D76pB0oLaM03ImdBl22GfRSESoI18hJE9lNRlU2846LdwnczCBZy9y/Ww
         MVgXWnRrdwI3BFMfl967i9JK565zEBbPvBmMxiuFJp0Len3sK68ZFePdwyuM2giBMgBN
         sY3+zEOodhoOhpmphB8c55ZNS9WQzl7a5zT64/KeUGFnrMCjT7eTpQaRx6CDm/KifK3L
         K5rw==
X-Gm-Message-State: AGRZ1gK8OHCs4ZxpPVH2SrrIM4szeL7h8iH11jdlqn1r5PoUokdtXRzf
        342mZRqf93TSBRzCJlbPlwCiXg+SGEw4Us2ybbr5LBviKE0=
X-Google-Smtp-Source: AJdET5fao3FoeAd02StuNbNfh1W2BKBkPhQO5gngymd0AcZp+LFvrM6Tkysi2eiADJAEuip1sBzw8C1WV0JKaictgFc=
X-Received: by 2002:a9d:3db6:: with SMTP id l51mr4997448otc.348.1541096210079;
 Thu, 01 Nov 2018 11:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com> <1541089855-19356-4-git-send-email-jianxin.pan@amlogic.com>
In-Reply-To: <1541089855-19356-4-git-send-email-jianxin.pan@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 1 Nov 2018 19:16:38 +0100
Message-ID: <CAFBinCBbWCoA-f8-dPkT1KFrFAtwZcRZo-N6mj4YockTuNeDhQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] clk: meson: add sub MMC clock controller driver
To:     jianxin.pan@amlogic.com
Cc:     jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        yixun.lan@amlogic.com, khilman@baylibre.com, carlo@caione.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        liang.yang@amlogic.com, jian.hu@amlogic.com,
        qiufang.dai@amlogic.com, hanjie.lin@amlogic.com,
        victor.wan@amlogic.com, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

On Thu, Nov 1, 2018 at 5:31 PM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>
> From: Yixun Lan <yixun.lan@amlogic.com>
>
> The patch will add a MMC clock controller driver which used by MMC or NAND,
> It provide a mux and divider clock, and three phase clocks - core, tx, tx.
>
> Two clocks are provided as the parent of MMC clock controller from
> upper layer clock controller - eg "amlogic,axg-clkc" in AXG platform.
>
> To specify which clock the MMC or NAND driver may consume,
> the preprocessor macros in the dt-bindings/clock/amlogic,mmc-clkc.h header
> can be used in the device tree sources.
>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
this looks good to me in general, some comments below

> ---
>  drivers/clk/meson/Kconfig      |  10 ++
>  drivers/clk/meson/Makefile     |   1 +
>  drivers/clk/meson/clk-regmap.c |   1 -
>  drivers/clk/meson/mmc-clkc.c   | 310 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 321 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/mmc-clkc.c
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index efaa70f..6bb0d44 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -15,6 +15,16 @@ config COMMON_CLK_MESON_AO
>         select COMMON_CLK_REGMAP_MESON
>         select RESET_CONTROLLER
>
> +config COMMON_CLK_MMC_MESON
> +       tristate "Meson MMC Sub Clock Controller Driver"
> +       select MFD_SYSCON
> +       select COMMON_CLK_AMLOGIC
> +       select COMMON_CLK_AMLOGIC_AUDIO
> +       help
> +         Support for the MMC sub clock controller on Amlogic Meson Platform,
> +         which include S905 (GXBB, GXL), A113D/X (AXG) devices.
can you confirm that (in the future) we will be able to use this with
G12A and G12B as well?

> +         Say Y if you want this clock enabled.
> +
>  config COMMON_CLK_REGMAP_MESON
>         bool
>         select REGMAP
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 39ce566..31c16d5 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -9,4 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>  obj-$(CONFIG_COMMON_CLK_GXBB)   += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>  obj-$(CONFIG_COMMON_CLK_AXG)    += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)     += axg-audio.o
> +obj-$(CONFIG_COMMON_CLK_MMC_MESON)     += mmc-clkc.o
>  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)  += clk-regmap.o
> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
> index 305ee30..89cee4a 100644
> --- a/drivers/clk/meson/clk-regmap.c
> +++ b/drivers/clk/meson/clk-regmap.c
> @@ -114,7 +114,6 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
>  };
>
>  /* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> -
unnecessary whitespace change, personally I would drop this file from the patch

>  const struct clk_ops clk_regmap_divider_ops = {
>         .recalc_rate = clk_regmap_div_recalc_rate,
>         .round_rate = clk_regmap_div_round_rate,
> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> new file mode 100644
> index 0000000..a3e4c91
> --- /dev/null
> +++ b/drivers/clk/meson/mmc-clkc.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2017 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + * Author: Jianxin Pan <jianxin.pan@amlogic.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/amlogic,mmc-clkc.h>
> +
> +#include "clkc.h"
> +#include "clkc-audio.h"
> +
> +/* clock ID used by internal driver */
> +#define CLKID_MMC_MUX                  0
> +
> +#define   SD_EMMC_CLOCK                0
> +#define   CLK_DELAY_STEP_PS            200
> +#define   CLK_PHASE_STEP               30
> +#define   CLK_PHASE_POINT_NUM          (360 / CLK_PHASE_STEP)
CLK_PHASE_STEP and CLK_PHASE_POINT_NUM are unused
> +
> +#define MUX_CLK_NUM_PARENTS            2
> +#define MMC_MAX_CLKS                   5
> +
> +struct mmc_clkc_data {
> +       struct meson_clk_phase_delay_data       tx;
> +       struct meson_clk_phase_delay_data       rx;
> +};
> +
> +static struct clk_regmap_mux_data mmc_clkc_mux_data = {
> +       .offset         = SD_EMMC_CLOCK,
> +       .mask           = 0x3,
> +       .shift          = 6,
> +};
> +
> +struct meson_sclk_div_data  mmc_clkc_div_data = {
can this be const?
also there are two whitespaces after meson_sclk_div_data

> +       .div = {
> +               .reg_off = SD_EMMC_CLOCK,
> +               .shift   = (0),
> +               .width   = (6),
> +       },
> +       .hi = {
> +               .reg_off = 0,
> +               .shift   = 0,
> +               .width   = 0,
> +       },
> +};
> +
> +static struct meson_clk_phase_data mmc_clkc_core_phase = {
> +       .ph = {
> +               .reg_off        = SD_EMMC_CLOCK,
> +               .shift  = 8,
> +               .width  = 2,
> +       }
> +};
> +
> +static const struct mmc_clkc_data mmc_clkc_gx_data = {
> +       .tx = {
> +               .phase = {
> +                       .reg_off        = SD_EMMC_CLOCK,
> +                       .shift  = 10,
> +                       .width  = 2,
> +               },
> +               .delay = {
> +                       .reg_off        = SD_EMMC_CLOCK,
> +                       .shift  = 16,
> +                       .width  = 4,
> +               },
> +               .delay_step_ps  = CLK_DELAY_STEP_PS,
> +       },
> +       .rx = {
> +               .phase = {
> +                       .reg_off        = SD_EMMC_CLOCK,
> +                       .shift  = 12,
> +                       .width  = 2,
> +               },
> +               .delay = {
> +                       .reg_off        = SD_EMMC_CLOCK,
> +                       .shift  = 20,
> +                       .width  = 4,
> +               },
> +               .delay_step_ps  = CLK_DELAY_STEP_PS,
> +       },
> +};
> +
> +static const struct mmc_clkc_data mmc_clkc_axg_data = {
> +       .tx = {
> +               .phase = {
> +                       .reg_off        = SD_EMMC_CLOCK,
> +                       .shift  = 10,
> +                       .width  = 2,
> +               },
> +               .delay = {
> +                       .reg_off        = SD_EMMC_CLOCK,
> +                       .shift  = 16,
> +                       .width  = 6,
> +               },
> +               .delay_step_ps  = CLK_DELAY_STEP_PS,
> +       },
> +       .rx = {
> +               .phase = {
> +                       .reg_off        = SD_EMMC_CLOCK,
> +                       .shift  = 12,
> +                       .width  = 2,
> +               },
> +               .delay = {
> +                       .reg_off        = SD_EMMC_CLOCK,
> +                       .shift  = 22,
> +                       .width  = 6,
> +               },
> +               .delay_step_ps  = CLK_DELAY_STEP_PS,
> +       },
> +};
> +
> +static const struct of_device_id mmc_clkc_match_table[] = {
> +       {
> +               .compatible     = "amlogic,gx-mmc-clkc",
> +               .data           = &mmc_clkc_gx_data
> +       },
> +       {
> +               .compatible     = "amlogic,axg-mmc-clkc",
> +               .data           = &mmc_clkc_axg_data
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, mmc_clkc_match_table);
> +
> +static struct clk_regmap *
> +mmc_clkc_register_clk(struct device *dev, struct regmap *map,
> +                     struct clk_init_data *init,
> +                     const char *suffix, void *data)
> +{
> +       struct clk_regmap *clk;
> +       char *name;
> +       int ret;
> +
> +       clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
> +       if (!clk)
> +               return ERR_PTR(-ENOMEM);
> +
> +       name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), suffix);
use devm_kasprintf here? this will allow you to get rid of the kfree below
> +       if (!name)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init->name = name;
> +
> +       clk->map = map;
> +       clk->data = data;
> +       clk->hw.init = init;
> +
> +       ret = devm_clk_hw_register(dev, &clk->hw);
> +       if (ret)
> +               clk = ERR_PTR(ret);
> +
> +       kfree(name);
> +       return clk;
> +}
> +
> +static struct clk_regmap *mmc_clkc_register_mux(struct device *dev,
> +                                               struct regmap *map)
> +{
> +       const char *parent_names[MUX_CLK_NUM_PARENTS];
> +       struct clk_init_data init;
> +       struct clk_regmap *mux;
> +       struct clk *clk;
> +       int i;
> +
> +       for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
> +               char name[8];
> +
> +               snprintf(name, sizeof(name), "clkin%d", i);
> +               clk = devm_clk_get(dev, name);
> +               if (IS_ERR(clk)) {
> +                       if (clk != ERR_PTR(-EPROBE_DEFER))
> +                               dev_err(dev, "Missing clock %s\n", name);
> +                       return ERR_PTR((long)clk);
> +               }
> +
> +               parent_names[i] = __clk_get_name(clk);
> +       }
> +
> +       init.ops = &clk_regmap_mux_ops;
> +       init.flags = CLK_SET_RATE_PARENT;
> +       init.parent_names = parent_names;
> +       init.num_parents = MUX_CLK_NUM_PARENTS;
> +
> +       mux = mmc_clkc_register_clk(dev, map, &init, "mux", &mmc_clkc_mux_data);
> +       if (IS_ERR(mux))
> +               dev_err(dev, "Mux clock registration failed\n");
> +
> +       return mux;
> +}
> +
> +static struct clk_regmap *
> +mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap *map,
> +                                 char *suffix, const struct clk_hw *hw,
> +                                 unsigned long flags,
> +                                 const struct clk_ops *ops, void *data)
> +{
> +       struct clk_init_data init;
> +       struct clk_regmap *clk;
> +       const char *parent_name = clk_hw_get_name(hw);
> +
> +       init.ops = ops;
> +       init.flags = flags;
> +       init.parent_names = &parent_name;
> +       init.num_parents = 1;
> +
> +       clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
> +       if (IS_ERR(clk))
> +               dev_err(dev, "Core %s clock registration failed\n", suffix);
> +
> +       return clk;
> +}
> +
> +static int mmc_clkc_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *onecell_data;
> +       struct device *dev = &pdev->dev;
> +       struct mmc_clkc_data *data;
> +       struct regmap *map;
> +       struct clk_regmap *clk, *core;
> +
> +       /*cast to drop the const in match->data*/
> +       data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
can you declare the data variable as "const struct mmc_clkc_data
*data;" instead?

> +       if (!data)
> +               return -ENODEV;
> +
> +       map = syscon_node_to_regmap(dev->of_node);
> +       if (IS_ERR(map)) {
> +               dev_err(dev, "could not find mmc clock controller\n");
> +               return PTR_ERR(map);
> +       }
> +
> +       onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
> +                                   sizeof(*onecell_data->hws) * MMC_MAX_CLKS,
> +                                   GFP_KERNEL);
> +       if (!onecell_data)
> +               return -ENOMEM;
> +
> +       clk = mmc_clkc_register_mux(dev, map);
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +       onecell_data->hws[CLKID_MMC_MUX]                = &clk->hw,
> +
> +       clk = mmc_clkc_register_clk_with_parent(dev, map, "div",
> +                                               &clk->hw,
> +                                               CLK_SET_RATE_PARENT,
> +                                               &meson_sclk_div_ops,
> +                                               &mmc_clkc_div_data);
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +       onecell_data->hws[CLKID_MMC_DIV]                = &clk->hw,
> +
> +       core = mmc_clkc_register_clk_with_parent(dev, map, "core",
> +                                                &clk->hw,
> +                                                CLK_SET_RATE_PARENT,
> +                                                &meson_clk_phase_ops,
> +                                                &mmc_clkc_core_phase);
> +       if (IS_ERR(core))
> +               return PTR_ERR(core);
> +       onecell_data->hws[CLKID_MMC_PHASE_CORE]         = &core->hw,
> +
> +       clk = mmc_clkc_register_clk_with_parent(dev, map, "rx",
> +                                               &core->hw,  0,
> +                                               &meson_clk_phase_delay_ops,
> +                                               &data->rx);
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +       onecell_data->hws[CLKID_MMC_PHASE_RX]           = &clk->hw,
> +
> +       clk = mmc_clkc_register_clk_with_parent(dev, map, "tx",
> +                                               &core->hw,  0,
> +                                               &meson_clk_phase_delay_ops,
> +                                               &data->tx);
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +       onecell_data->hws[CLKID_MMC_PHASE_TX]           = &clk->hw,
> +
> +       onecell_data->num                               = MMC_MAX_CLKS;
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                          onecell_data);
> +}
> +
> +static struct platform_driver mmc_clkc_driver = {
> +       .probe          = mmc_clkc_probe,
> +       .driver         = {
> +               .name   = "meson-mmc-clkc",
> +               .of_match_table = of_match_ptr(mmc_clkc_match_table),
> +       },
> +};
> +
> +module_platform_driver(mmc_clkc_driver);
> +
> +MODULE_DESCRIPTION("Amlogic AXG MMC clock driver");
> +MODULE_AUTHOR("Jianxin Pan <jianxin.pan@amlogic.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>

Regards
Martin
