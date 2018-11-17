Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496B5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BF82080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 20:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bPl/vtlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BF82080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeKRG7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:59:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33780 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeKRG7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 01:59:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so18009853otl.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 12:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2+mAg6blJw4ppf1aH729y3tyL0zaMquo01YHHvvCXk=;
        b=bPl/vtlqDZ25w3r43MPbOXNHWahhJroje5ZF8Cwt914MhaDs7j3dTkwOkGDkpJhFQJ
         gZbviVErkrcnKwMOOS5JKmqxv0VFZ0IoXknG9kJWzdi7blTt4IIkmGz+pj9f7ZL03Q/n
         Tf492KOMmULd8eomc3Vcz4/GmaT02/iTNX8wnKZz0yd+tUEcCa0ID1p2Ij6Res2Yo++A
         S+DrjUa9L+enLbfr/sBHfG7qGmcrbQWUwKbz+OfnEC8XXy0svIM362Dzd+Hry4oOdJOf
         EgARDAyGB8yaVv/4pbKJlsOR4T56MGyPKJ5UfB0sZKnGucIhnK1zeVpd8PGJMNIBEjrh
         oyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2+mAg6blJw4ppf1aH729y3tyL0zaMquo01YHHvvCXk=;
        b=FJhh22B0wIKOuRpEx3ZZxWxk7n6C2D4VQGHexGGc2A3yvRiF43mccUXTURSd5Mo9Q6
         m9J603U5L06aV1IUYVo4YgqtJeQMO6UwogVhPgTWII/9DNh0ypB12T1kOtc6PmZRinVP
         C9CFKV+q/aWm/vs8xaafj9Dx4M3O/aVsNCoD6DqgBZFqybogxroVFvvrU/qUFcfMpZOj
         lGulV8Zg7DaLRBapxKs8yNqhUurbuhWRuZ/N1EEcaUUMhhFJVL1MyoaxsMNahefDMQFz
         xnLc4mXlffMmVLRPwdEyELQwsag/3vJ1biw5IEPwckaqm5kOOL5aM0QqlflbkNEd2oF5
         oRHA==
X-Gm-Message-State: AGRZ1gJvULugpVJ750Q1ApFSrhgAX1Y86c8SO0V4Go2vbGdNJAhhtJIK
        440VE95Jr2uIFenvG32RJDL4NQOSQi677DGqwB8=
X-Google-Smtp-Source: AJdET5cNHdFEwoIAfZnT0wPMe1jgyGTIqIb+5GOYQmc53/h7C3lf4baa/xqcg/ePrQBtKHWy9WtvURl9HPAbABXpj14=
X-Received: by 2002:a05:6830:2010:: with SMTP id e16mr9094666otp.86.1542487275504;
 Sat, 17 Nov 2018 12:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20181114131627.17766-1-narmstrong@baylibre.com> <20181114131627.17766-3-narmstrong@baylibre.com>
In-Reply-To: <20181114131627.17766-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 17 Nov 2018 21:41:04 +0100
Message-ID: <CAFBinCCQA=k9c5W4OML1X0CfxAkmyJwtj6Wry9R563HScZUDEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] soc: amlogic: Add Meson GX Clock Measure driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="00000000000020b390057ae24eee"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000020b390057ae24eee
Content-Type: text/plain; charset="UTF-8"

Hi Neil,

On Wed, Nov 14, 2018 at 2:18 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
I would remove "GX" from that sentence

> The precision is determined by stepping into the divider until the counter
> overflows.
> The debugfs slows a pretty summary and each clock can be measured
> individually aswell.
>
> The clock table covers all GX SoCs (GXBB, GXL & GXM) even if some clocks
> are only present on GXBB or GXM (i.e. wave420l) but the counter returns
> 0 when the clocks are invalid.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
looks good apart from a small comments (and a 32-bit SoC fix) below as
this driver is not GX specific

> ---
>  drivers/soc/amlogic/Kconfig                |   8 +
>  drivers/soc/amlogic/Makefile               |   1 +
>  drivers/soc/amlogic/meson-gx-clk-measure.c | 293 +++++++++++++++++++++
>  3 files changed, 302 insertions(+)
>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
>
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index 2f282b472912..155868830773 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -7,6 +7,14 @@ config MESON_CANVAS
>         help
>           Say yes to support the canvas IP for Amlogic SoCs.
>
> +config MESON_GX_CLK_MEASURE
> +       bool "Amlogic Meson GX SoC Clock Measure driver"
please drop the GX from the name, I verified that it also works on
Meson8 and Meson8b with very little changes

> +       depends on ARCH_MESON || COMPILE_TEST
> +       default ARCH_MESON
> +       help
> +         Say yes to support of Measuring a set of internal SoC clocks
> +         from the debugfs interface.
> +
>  config MESON_GX_SOCINFO
>         bool "Amlogic Meson GX SoC Information driver"
>         depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> index 0ab16d35ac36..2cc0f9c2f715 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
> +obj-$(CONFIG_MESON_GX_CLK_MEASURE) += meson-gx-clk-measure.o
>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> diff --git a/drivers/soc/amlogic/meson-gx-clk-measure.c b/drivers/soc/amlogic/meson-gx-clk-measure.c
> new file mode 100644
> index 000000000000..da1a0001cef9
> --- /dev/null
> +++ b/drivers/soc/amlogic/meson-gx-clk-measure.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2017 BayLibre, SAS
nitpick; 2017-2018

> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/bitfield.h>
> +#include <linux/seq_file.h>
> +#include <linux/debugfs.h>
> +#include <linux/regmap.h>
> +
> +#define MSR_CLK_DUTY           0x0
> +#define MSR_CLK_REG0           0x4
> +#define MSR_CLK_REG1           0x8
> +#define MSR_CLK_REG2           0xc
> +
> +#define MSR_CLK_DIV            GENMASK(15, 0)
I would call this MSR_DURATION (see my comment on the divider below)

> +#define MSR_ENABLE             BIT(16)
> +#define MSR_CONT               BIT(17) /* continuous measurement */
> +#define MSR_INTR               BIT(18) /* interrupts */
> +#define MSR_RUN                        BIT(19)
> +#define MSR_CLK_SRC            GENMASK(26, 20)
> +#define MSR_BUSY               BIT(31)
> +
> +#define MSR_VAL_MASK           GENMASK(15, 0)
> +
> +#define DIV_MIN                        32
> +#define DIV_STEP               32
> +#define DIV_MAX                        640
> +
> +#define CLK_MSR_MAX            128
> +
> +struct meson_gx_msr_id {
> +       struct meson_gx_msr *priv;
> +       unsigned int id;
> +       const char *name;
> +};
> +
> +struct meson_gx_msr {
> +       struct regmap *regmap;
> +       struct meson_gx_msr_id msr_table[CLK_MSR_MAX];
> +};
can you drop the "_gx" from these two structs and all functions below please?

> +
> +#define CLK_MSR_ID(__id, __name) \
> +       [__id] = {.id = __id, .name = __name,}
> +
> +static struct meson_gx_msr_id clk_msr_gx[CLK_MSR_MAX] = {
> +       CLK_MSR_ID(0, "ring_osc_out_ee_0"),
> +       CLK_MSR_ID(1, "ring_osc_out_ee_1"),
> +       CLK_MSR_ID(2, "ring_osc_out_ee_2"),
> +       CLK_MSR_ID(3, "a53_ring_osc"),
> +       CLK_MSR_ID(4, "gp0_pll"),
> +       CLK_MSR_ID(6, "enci"),
> +       CLK_MSR_ID(7, "clk81"),
> +       CLK_MSR_ID(8, "encp"),
> +       CLK_MSR_ID(9, "encl"),
> +       CLK_MSR_ID(10, "vdac"),
> +       CLK_MSR_ID(11, "rgmii_tx"),
> +       CLK_MSR_ID(12, "pdm"),
> +       CLK_MSR_ID(13, "amclk"),
> +       CLK_MSR_ID(14, "fec_0"),
> +       CLK_MSR_ID(15, "fec_1"),
> +       CLK_MSR_ID(16, "fec_2"),
> +       CLK_MSR_ID(17, "sys_pll_div16"),
> +       CLK_MSR_ID(18, "sys_cpu_div16"),
> +       CLK_MSR_ID(19, "hdmitx_sys"),
> +       CLK_MSR_ID(20, "rtc_osc_out"),
> +       CLK_MSR_ID(21, "i2s_in_src0"),
> +       CLK_MSR_ID(22, "eth_phy_ref"),
> +       CLK_MSR_ID(23, "hdmi_todig"),
> +       CLK_MSR_ID(26, "sc_int"),
> +       CLK_MSR_ID(28, "sar_adc"),
> +       CLK_MSR_ID(31, "mpll_test_out"),
> +       CLK_MSR_ID(32, "vdec"),
> +       CLK_MSR_ID(35, "mali"),
> +       CLK_MSR_ID(36, "hdmi_tx_pixel"),
> +       CLK_MSR_ID(37, "i958"),
> +       CLK_MSR_ID(38, "vdin_meas"),
> +       CLK_MSR_ID(39, "pcm_sclk"),
> +       CLK_MSR_ID(40, "pcm_mclk"),
> +       CLK_MSR_ID(41, "eth_rx_or_rmii"),
> +       CLK_MSR_ID(42, "mp0_out"),
> +       CLK_MSR_ID(43, "fclk_div5"),
> +       CLK_MSR_ID(44, "pwm_b"),
> +       CLK_MSR_ID(45, "pwm_a"),
> +       CLK_MSR_ID(46, "vpu"),
> +       CLK_MSR_ID(47, "ddr_dpll_pt"),
> +       CLK_MSR_ID(48, "mp1_out"),
> +       CLK_MSR_ID(49, "mp2_out"),
> +       CLK_MSR_ID(50, "mp3_out"),
> +       CLK_MSR_ID(51, "nand_core"),
> +       CLK_MSR_ID(52, "sd_emmc_b"),
> +       CLK_MSR_ID(53, "sd_emmc_a"),
> +       CLK_MSR_ID(55, "vid_pll_div_out"),
> +       CLK_MSR_ID(56, "cci"),
> +       CLK_MSR_ID(57, "wave420l_c"),
> +       CLK_MSR_ID(58, "wave420l_b"),
> +       CLK_MSR_ID(59, "hcodec"),
> +       CLK_MSR_ID(60, "alt_32k"),
> +       CLK_MSR_ID(61, "gpio_msr"),
> +       CLK_MSR_ID(62, "hevc"),
> +       CLK_MSR_ID(66, "vid_lock"),
> +       CLK_MSR_ID(70, "pwm_f"),
> +       CLK_MSR_ID(71, "pwm_e"),
> +       CLK_MSR_ID(72, "pwm_d"),
> +       CLK_MSR_ID(73, "pwm_c"),
> +       CLK_MSR_ID(75, "aoclkx2_int"),
> +       CLK_MSR_ID(76, "aoclk_int"),
> +       CLK_MSR_ID(77, "rng_ring_osc_0"),
> +       CLK_MSR_ID(78, "rng_ring_osc_1"),
> +       CLK_MSR_ID(79, "rng_ring_osc_2"),
> +       CLK_MSR_ID(80, "rng_ring_osc_3"),
> +       CLK_MSR_ID(81, "vapb"),
> +       CLK_MSR_ID(82, "ge2d"),
> +};
> +
> +static int meson_gx_measure_id(struct meson_gx_msr_id *clk_msr_id,
> +                              unsigned int divider)
I would replace "divider" with duration. Amlogic's kernel code
mentions that this is value is in microseconds.
during my tests I could confirm that bigger "divider" value means
better precision - if this was a divider then lower values should
probably give higher precision

> +{
> +       struct meson_gx_msr *priv = clk_msr_id->priv;
> +       unsigned int val;
> +       int ret;
> +
> +       regmap_write(priv->regmap, MSR_CLK_REG0, 0);
> +
> +       /* Set measurement divider */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_DIV,
> +                          FIELD_PREP(MSR_CLK_DIV, divider - 1));
> +
> +       /* Set ID */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
> +                          FIELD_PREP(MSR_CLK_SRC, clk_msr_id->id));
> +
> +       /* Enable & Start */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0,
> +                          MSR_RUN | MSR_ENABLE,
> +                          MSR_RUN | MSR_ENABLE);
> +
> +       ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
> +                                      val, !(val & MSR_BUSY), 10, 10000);
> +       if (ret)
> +               return ret;
> +
> +       /* Disable */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
> +
> +       /* Get the value in multiple of gate time counts */
> +       regmap_read(priv->regmap, MSR_CLK_REG2, &val);
> +
> +       if (val >= MSR_VAL_MASK)
> +               return -EINVAL;
> +
> +       return DIV_ROUND_CLOSEST((val & MSR_VAL_MASK) * 1000000,
> +                                divider);
the 32-bit SoCs want a bit of love here:
please use DIV_ROUND_CLOSEST_ULL and  cast 1MHz to u64

> +}
> +
> +static int meson_gx_measure_best_id(struct meson_gx_msr_id *clk_msr_id,
> +                                   unsigned int *precision)
> +{
> +       unsigned int divider = DIV_MAX;
> +       int ret;
> +
> +       /* Start from max divider and down to min divider */
> +       do {
> +               ret = meson_gx_measure_id(clk_msr_id, divider);
> +               if (ret >= 0)
> +                       *precision = (2 * 1000000) / divider;
> +               else
> +                       divider -= DIV_STEP;
> +       } while (divider >= DIV_MIN && ret == -EINVAL);
> +
> +       return ret;
> +}
> +
> +static int clk_msr_show(struct seq_file *s, void *data)
> +{
> +       struct meson_gx_msr_id *clk_msr_id = s->private;
> +       unsigned int precision = 0;
> +       int val;
> +
> +       val = meson_gx_measure_best_id(clk_msr_id, &precision);
> +       if (val < 0)
> +               return val;
> +
> +       seq_printf(s, "%d\t+/-%dHz\n", val, precision);
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(clk_msr);
> +
> +static int clk_msr_summary_show(struct seq_file *s, void *data)
> +{
> +       struct meson_gx_msr_id *msr_table = s->private;
> +       unsigned int precision = 0;
> +       int val, i;
> +
> +       seq_puts(s, "  clock                     rate    precision\n");
> +       seq_puts(s, "---------------------------------------------\n");
> +
> +       for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
> +               if (!msr_table[i].name)
> +                       continue;
> +
> +               val = meson_gx_measure_best_id(&msr_table[i], &precision);
> +               if (val < 0)
> +                       return val;
> +
> +               seq_printf(s, " %-20s %10d    +/-%dHz\n",
> +                          msr_table[i].name, val, precision);
> +       }
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(clk_msr_summary);
> +
> +static const struct regmap_config clk_msr_regmap_config = {
nitpick: meson_clk_msr_regmap_config (for consistency)

> +       .reg_bits = 32,
> +       .val_bits = 32,
> +       .reg_stride = 4,
> +       .max_register = MSR_CLK_REG2,
> +};
> +
> +static int meson_gx_msr_probe(struct platform_device *pdev)
> +{
> +       const struct meson_gx_msr_id *match_data;
> +       struct meson_gx_msr *priv;
> +       struct resource *res;
> +       struct dentry *root, *clks;
> +       void __iomem *base;
> +       int i;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(struct meson_gx_msr),
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       match_data = device_get_match_data(&pdev->dev);
> +       if (!match_data) {
> +               dev_err(&pdev->dev, "failed to get match data\n");
> +               return -ENODEV;
> +       }
> +
> +       memcpy(priv->msr_table, match_data, sizeof(priv->msr_table));
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base)) {
> +               dev_err(&pdev->dev, "io resource mapping failed\n");
> +               return PTR_ERR(base);
> +       }
> +
> +       priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> +                                             &clk_msr_regmap_config);
> +       if (IS_ERR(priv->regmap))
> +               return PTR_ERR(priv->regmap);
> +
> +       root = debugfs_create_dir("meson-clk-msr", NULL);
> +       clks = debugfs_create_dir("clks", root);
> +
> +       debugfs_create_file("measure_summary", 0444, root,
> +                           priv->msr_table, &clk_msr_summary_fops);
> +
> +       for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
> +               if (!priv->msr_table[i].name)
> +                       continue;
> +
> +               priv->msr_table[i].priv = priv;
> +
> +               debugfs_create_file(priv->msr_table[i].name, 0444, clks,
> +                                   &priv->msr_table[i], &clk_msr_fops);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id meson_gx_msr_match_table[] = {
> +       {
> +               .compatible = "amlogic,meson-gx-clk-measure",
> +               .data = (void *)clk_msr_gx,
> +       },
if you want you can fold this with the patch that I've attached, then
we have Meson8 and Meson8b support as well :)

> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver meson_gx_msr_driver = {
> +       .probe  = meson_gx_msr_probe,
> +       .driver = {
> +               .name           = "meson_gx_msr",
> +               .of_match_table = meson_gx_msr_match_table,
> +       },
> +};
> +builtin_platform_driver(meson_gx_msr_driver);
> --
> 2.19.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

--00000000000020b390057ae24eee
Content-Type: text/x-patch; charset="US-ASCII"; name="32bit-meson.patch"
Content-Disposition: attachment; filename="32bit-meson.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jolx1ika0>
X-Attachment-Id: f_jolx1ika0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2FtbG9naWMvbWVzb24tZ3gtY2xrLW1lYXN1cmUuYyBi
L2RyaXZlcnMvc29jL2FtbG9naWMvbWVzb24tZ3gtY2xrLW1lYXN1cmUuYw0KaW5kZXggZGExYTAw
MDFjZWY5Li4wYzlkOTQ4NmIyZjUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9hbWxvZ2ljL21l
c29uLWd4LWNsay1tZWFzdXJlLmMNCisrKyBiL2RyaXZlcnMvc29jL2FtbG9naWMvbWVzb24tZ3gt
Y2xrLW1lYXN1cmUuYw0KQEAgLTQ2LDYgKzQ2LDU1IEBAIHN0cnVjdCBtZXNvbl9neF9tc3Igew0K
ICNkZWZpbmUgQ0xLX01TUl9JRChfX2lkLCBfX25hbWUpIFwNCiAJW19faWRdID0gey5pZCA9IF9f
aWQsIC5uYW1lID0gX19uYW1lLH0NCiANCitzdGF0aWMgc3RydWN0IG1lc29uX2d4X21zcl9pZCBj
bGtfbXNyX204W0NMS19NU1JfTUFYXSA9IHsNCisJQ0xLX01TUl9JRCgwLCAicmluZ19vc2Nfb3V0
X2VlMCIpLA0KKwlDTEtfTVNSX0lEKDEsICJyaW5nX29zY19vdXRfZWUxIiksDQorCUNMS19NU1Jf
SUQoMiwgInJpbmdfb3NjX291dF9lZTIiKSwNCisJQ0xLX01TUl9JRCgzLCAiYTlfcmluZ19vc2Nr
IiksDQorCUNMS19NU1JfSUQoNiwgInZpZF9wbGwiKSwNCisJQ0xLX01TUl9JRCg3LCAiY2xrODEi
KSwNCisJQ0xLX01TUl9JRCg4LCAiZW5jcCIpLA0KKwlDTEtfTVNSX0lEKDksICJlbmNsIiksDQor
CUNMS19NU1JfSUQoMTEsICJldGhfcm1paSIpLA0KKwlDTEtfTVNSX0lEKDEzLCAiYW1jbGsiKSwN
CisJQ0xLX01TUl9JRCgxNCwgImZlY19jbGtfMCIpLA0KKwlDTEtfTVNSX0lEKDE1LCAiZmVjX2Ns
a18xIiksDQorCUNMS19NU1JfSUQoMTYsICJmZWNfY2xrXzIiKSwNCisJQ0xLX01TUl9JRCgxOCwg
ImE5X2Nsa19kaXYxNiIpLA0KKwlDTEtfTVNSX0lEKDE5LCAiaGRtaV9zeXMiKSwNCisJQ0xLX01T
Ul9JRCgyMCwgInJ0Y19vc2NfY2xrX291dCIpLA0KKwlDTEtfTVNSX0lEKDIxLCAiaTJzX2Nsa19p
bl9zcmMwIiksDQorCUNMS19NU1JfSUQoMjIsICJjbGtfcm1paV9mcm9tX3BhZCIpLA0KKwlDTEtf
TVNSX0lEKDIzLCAiaGRtaV9jaDBfdG1kcyIpLA0KKwlDTEtfTVNSX0lEKDI0LCAibHZkc19maWZv
IiksDQorCUNMS19NU1JfSUQoMjYsICJzY19jbGtfaW50IiksDQorCUNMS19NU1JfSUQoMjgsICJz
YXJfYWRjIiksDQorCUNMS19NU1JfSUQoMzAsICJtcGxsX2Nsa190ZXN0X291dCIpLA0KKwlDTEtf
TVNSX0lEKDMxLCAiYXVkYWNfY2xrcGkiKSwNCisJQ0xLX01TUl9JRCgzMiwgInZkYWMiKSwNCisJ
Q0xLX01TUl9JRCgzMywgInNkaGNfcngiKSwNCisJQ0xLX01TUl9JRCgzNCwgInNkaGNfc2QiKSwN
CisJQ0xLX01TUl9JRCgzNSwgIm1hbGkiKSwNCisJQ0xLX01TUl9JRCgzNiwgImhkbWlfdHhfcGl4
ZWwiKSwNCisJQ0xLX01TUl9JRCgzOCwgInZkaW5fbWVhcyIpLA0KKwlDTEtfTVNSX0lEKDM5LCAi
cGNtX3NjbGsiKSwNCisJQ0xLX01TUl9JRCg0MCwgInBjbV9tY2xrIiksDQorCUNMS19NU1JfSUQo
NDEsICJldGhfcnhfdHgiKSwNCisJQ0xLX01TUl9JRCg0MiwgInB3bV9kIiksDQorCUNMS19NU1Jf
SUQoNDMsICJwd21fYyIpLA0KKwlDTEtfTVNSX0lEKDQ0LCAicHdtX2IiKSwNCisJQ0xLX01TUl9J
RCg0NSwgInB3bV9hIiksDQorCUNMS19NU1JfSUQoNDYsICJwY20yX3NjbGsiKSwNCisJQ0xLX01T
Ul9JRCg0NywgImRkcl9kcGxsX3B0IiksDQorCUNMS19NU1JfSUQoNDgsICJwd21fZiIpLA0KKwlD
TEtfTVNSX0lEKDQ5LCAicHdtX2UiKSwNCisJQ0xLX01TUl9JRCg1OSwgImhjb2RlYyIpLA0KKwlD
TEtfTVNSX0lEKDYwLCAidXNiXzMya19hbHQiKSwNCisJQ0xLX01TUl9JRCg2MSwgImdwaW8iKSwN
CisJQ0xLX01TUl9JRCg2MiwgInZpZDJfcGxsIiksDQorCUNMS19NU1JfSUQoNjMsICJtaXBpX2Nz
aV9jZmciKSwNCit9Ow0KKw0KIHN0YXRpYyBzdHJ1Y3QgbWVzb25fZ3hfbXNyX2lkIGNsa19tc3Jf
Z3hbQ0xLX01TUl9NQVhdID0gew0KIAlDTEtfTVNSX0lEKDAsICJyaW5nX29zY19vdXRfZWVfMCIp
LA0KIAlDTEtfTVNSX0lEKDEsICJyaW5nX29zY19vdXRfZWVfMSIpLA0KQEAgLTE1Miw4ICsyMDEs
OCBAQCBzdGF0aWMgaW50IG1lc29uX2d4X21lYXN1cmVfaWQoc3RydWN0IG1lc29uX2d4X21zcl9p
ZCAqY2xrX21zcl9pZCwNCiAJaWYgKHZhbCA+PSBNU1JfVkFMX01BU0spDQogCQlyZXR1cm4gLUVJ
TlZBTDsNCiANCi0JcmV0dXJuIERJVl9ST1VORF9DTE9TRVNUKCh2YWwgJiBNU1JfVkFMX01BU0sp
ICogMTAwMDAwMCwNCi0JCQkJIGRpdmlkZXIpOw0KKwlyZXR1cm4gRElWX1JPVU5EX0NMT1NFU1Rf
VUxMKCh2YWwgJiBNU1JfVkFMX01BU0spICogKHU2NCkxMDAwMDAwLA0KKwkJCQkgICAgIGRpdmlk
ZXIpOw0KIH0NCiANCiBzdGF0aWMgaW50IG1lc29uX2d4X21lYXN1cmVfYmVzdF9pZChzdHJ1Y3Qg
bWVzb25fZ3hfbXNyX2lkICpjbGtfbXNyX2lkLA0KQEAgLTI4MCw2ICszMjksMTQgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbWVzb25fZ3hfbXNyX21hdGNoX3RhYmxlW10gPSB7
DQogCQkuY29tcGF0aWJsZSA9ICJhbWxvZ2ljLG1lc29uLWd4LWNsay1tZWFzdXJlIiwNCiAJCS5k
YXRhID0gKHZvaWQgKiljbGtfbXNyX2d4LA0KIAl9LA0KKwl7DQorCQkuY29tcGF0aWJsZSA9ICJh
bWxvZ2ljLG1lc29uOC1jbGstbWVhc3VyZSIsDQorCQkuZGF0YSA9ICh2b2lkICopY2xrX21zcl9t
OCwNCisJfSwNCisJew0KKwkJLmNvbXBhdGlibGUgPSAiYW1sb2dpYyxtZXNvbjhiLWNsay1tZWFz
dXJlIiwNCisJCS5kYXRhID0gKHZvaWQgKiljbGtfbXNyX204LA0KKwl9LA0KIAl7IC8qIHNlbnRp
bmVsICovIH0NCiB9Ow0KIA0KLS0gDQoyLjE5LjE=
--00000000000020b390057ae24eee--
