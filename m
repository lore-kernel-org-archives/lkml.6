Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A87EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7CB21A59
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cAmVIyZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7CB21A59
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753603AbeGCTS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:18:28 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37147 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeGCTS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:18:27 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so6042376oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpOpn68BlUnKc3QMHrZ0tmx8VkNXx9m9qQfm+0uURP4=;
        b=cAmVIyZAg2Vl8jDtyXBQQxLp/R8GuYcHnlOOxaNeAnyPPxprAGOd3NMbqaglfX0vBM
         VUN5pqDO0PRQfcfy7zxmsICZLERUd2gykp7KXDpm6X4TFh6xUf8zuiTpN/bMH8LwVdfC
         9nO2WcSAgtDfU0Cg7QC3+1k2g1G5PECAQgGVdW9NyOsUGzRGLiTgNPgtr4AvldK6abTO
         YIkTyI8j+Y9Ry7/pWfjWzHglHupCf7lDcmsxDkwKWueAPciTRNkxQvT7PC1NhZsWSKtx
         w/mpwmVFlLo+KA69ODBx1z6Uc1tw7iX+TWrwKqyiCmvT6YVlD0QiQb9136IXY/cMulLj
         or/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpOpn68BlUnKc3QMHrZ0tmx8VkNXx9m9qQfm+0uURP4=;
        b=C3WG5NlamxRb/ldD5+bqteBrTpLLzp64tN+wCSAFpGSEskFHhwtMOA5tPrlQd2OZmJ
         2cRVciOPsDVBsp1eZNEsNyzSgPTA1tozkPTGY4ycC39I1G9rADZzEslgbvQ4RrveykxP
         qfcB76/EMEhQun6rNNwYcXHzTAvd3Y931KWH2P2dEtISd/GDdASAlCKkG6dwsivo617X
         O2YSckY+esWMOcXJPHCz+SJaZtP+cAicazi0SXoX372Pgi7Aknq5xt03JbEVfb3QKAc/
         pNVvgtswqcWVQ5ZbeVTY4S+EfY2cHfxa8qQ1I4Pf2X9rmp/d1VtOOvx0eg5EYrTS+Bwy
         Cwtw==
X-Gm-Message-State: APt69E0ZsMdkIGDJUBfbf0CcZIkf8cg7p9ukcR6syarbBHVzdIXuRgel
        LLwYLcYK7CmEfRDciQqgfWCopxV8f0y3yjgSjh4=
X-Google-Smtp-Source: AAOMgpfcwntARpzw8eBUZZrJVKGFMqIMYrI4CuwND6avniUQGAJ8lJSixZhAx88q17EWr4Xx8nZV/UY0Eax7klJVMwU=
X-Received: by 2002:aca:68a2:: with SMTP id o34-v6mr21707392oik.267.1530645506201;
 Tue, 03 Jul 2018 12:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com> <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 3 Jul 2018 21:18:14 +0200
Message-ID: <CAFBinCDBEbVSEzhM2WOhxNX1DZLiSrkeo7GWdxGzBpOUH3PKQw@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: amlogic: Add Meson GX Clock Measure driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="000000000000ace8a005701d2dca"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ace8a005701d2dca
Content-Type: text/plain; charset="UTF-8"

Hi Neil,

On Tue, Jul 3, 2018 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
> The precision is in the order of the MHz.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/soc/amlogic/Kconfig                |   8 ++
>  drivers/soc/amlogic/Makefile               |   1 +
>  drivers/soc/amlogic/meson-gx-clk-measure.c | 224 +++++++++++++++++++++++++++++
>  3 files changed, 233 insertions(+)
>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
>
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index b04f6e4..4a3217d 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -1,5 +1,13 @@
>  menu "Amlogic SoC drivers"
>
> +config MESON_GX_CLK_MEASURE
> +       bool "Amlogic Meson GX SoC Clock Measure driver"
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
> index 8fa3218..a0ad966 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MESON_GX_CLK_MEASURE) += meson-gx-clk-measure.o
>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> diff --git a/drivers/soc/amlogic/meson-gx-clk-measure.c b/drivers/soc/amlogic/meson-gx-clk-measure.c
> new file mode 100644
> index 0000000..434d9f3
> --- /dev/null
> +++ b/drivers/soc/amlogic/meson-gx-clk-measure.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2017 BayLibre, SAS
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
> +#define MSR_ENABLE             BIT(16)
> +#define MSR_CONT               BIT(17) /* continuous measurement */
> +#define MSR_INTR               BIT(18) /* interrupts */
> +#define MSR_RUN                        BIT(19)
> +#define MSR_CLK_SRC            GENMASK(26, 20)
> +#define MSR_BUSY               BIT(31)
> +
> +#define MSR_VAL_MASK           GENMASK(15, 0)
> +
> +#define DIV_50US               64
> +
> +#define CLK_MSR_MAX            128
> +
> +struct meson_gx_msr {
> +       struct regmap *regmap;
> +};
> +
> +struct meson_gx_msr_id {
> +       struct meson_gx_msr *priv;
> +       unsigned int id;
> +       const char *name;
> +};
> +
> +#define CLK_MSR_ID(__id, __name) \
> +       [__id] = {.id = __id, .name = __name,}
> +
> +static struct meson_gx_msr_id clk_msr[CLK_MSR_MAX] = {
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
AFAIK the Chips&Media WAVE420L video codec is only available on GXM (S912)
I assume reading this on GXBB or GXL simply reads 0?

> +       CLK_MSR_ID(59, "hcodec"),
> +       CLK_MSR_ID(60, "alt_32k"),
> +       CLK_MSR_ID(61, "gpio_msr"),
> +       CLK_MSR_ID(62, "hevc"),
> +       CLK_MSR_ID(66, "vid_lock"),
> +       CLK_MSR_ID(70, "pwm_f"),
> +       CLK_MSR_ID(71, "pwm_e"),
> +       CLK_MSR_ID(72, "pwm_d"),
> +       CLK_MSR_ID(73, "pwm_C"),
should this be pwm_c (instead of pwm_C)?

> +       CLK_MSR_ID(75, "aoclkx2_int"),
> +       CLK_MSR_ID(76, "aoclk_int"),
> +       CLK_MSR_ID(77, "rng_ring_osc_0"),
> +       CLK_MSR_ID(78, "rng_ring_osc_1"),
> +       CLK_MSR_ID(79, "rng_ring_osc_2"),
> +       CLK_MSR_ID(80, "rng_ring_osc_3"),
> +       CLK_MSR_ID(81, "vapb"),
> +       CLK_MSR_ID(82, "ge2d"),
> +};
I did a quick check whether the clock IDs are really the same for all GX SoCs:
apart from clocks missing on older SoCs (see for example the WAVE420L
clocks above) there were only minor renames but no conflicts!

> +
> +static int meson_gx_measure_id(struct meson_gx_msr *priv, unsigned int id)
> +{
> +       unsigned int val;
> +       int ret;
> +
> +       regmap_write(priv->regmap, MSR_CLK_REG0, 0);
> +
> +       /* Set measurement gate to 50uS */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_DIV,
> +                          FIELD_PREP(MSR_CLK_DIV, DIV_50US));
> +
> +       /* Set ID */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
> +                          FIELD_PREP(MSR_CLK_SRC, id));
> +
> +       /* Enable & Start */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0,
> +                          MSR_RUN | MSR_ENABLE,
> +                          MSR_RUN | MSR_ENABLE);
> +
> +       ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
> +                                      val, !(val & MSR_BUSY), 10, 1000);
> +       if (ret)
> +               return ret;
> +
> +       /* Disable */
> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
> +
> +       /* Get the value in MHz*64 */
> +       regmap_read(priv->regmap, MSR_CLK_REG2, &val);
> +
> +       return (((val + 31) & MSR_VAL_MASK) / 64) * 1000000;
> +}
> +
> +static int clk_msr_show(struct seq_file *s, void *data)
> +{
> +       struct meson_gx_msr_id *clk_msr_id = s->private;
> +       int val;
> +
> +       val = meson_gx_measure_id(clk_msr_id->priv, clk_msr_id->id);
> +       if (val < 0)
> +               return val;
> +
> +       seq_printf(s, "%d\n", val);
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(clk_msr);
have you considered modelling this as clock driver instead?

> +
> +static const struct regmap_config clk_msr_regmap_config = {
> +       .reg_bits = 32,
> +       .val_bits = 32,
> +       .reg_stride = 4,
> +       .max_register = MSR_CLK_REG2,
> +};
> +
> +static int meson_gx_msr_probe(struct platform_device *pdev)
> +{
> +       struct meson_gx_msr *priv;
> +       struct resource *res;
> +       struct dentry *root;
> +       void __iomem *base;
> +       int i;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(struct meson_gx_msr),
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
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
> +
> +       for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
> +               if (!clk_msr[i].name)
> +                       continue;
> +
> +               clk_msr[i].priv = priv;
> +
> +               debugfs_create_file(clk_msr[i].name, 0444, root,
> +                                   &clk_msr[i], &clk_msr_fops);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id meson_gx_msr_match_table[] = {
> +       { .compatible = "amlogic,meson-gx-clk-measure" },
maybe pass the meson_gx_msr_id table here because it seems easy to add
support for AXG and Meson8/Meson8b/Meson8m2 later on


Regards
Martin

--000000000000ace8a005701d2dca
Content-Type: text/plain; charset="US-ASCII"; name="gxl.txt"
Content-Disposition: attachment; filename="gxl.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_jj62ktqa3>
X-Attachment-Id: f_jj62ktqa3

CQlbODJdID0gIkN0c19nZTJkX2NsayAgICAgICAiLAoJCVs4MV0gPSAiQ3RzX3ZhcGJjbGsgICAg
ICAgICIsCgkJWzgwXSA9ICJSbmdfcmluZ19vc2NfY2xrWzNdIiwKCQlbNzldID0gIlJuZ19yaW5n
X29zY19jbGtbMl0iLAoJCVs3OF0gPSAiUm5nX3Jpbmdfb3NjX2Nsa1sxXSIsCgkJWzc3XSA9ICJS
bmdfcmluZ19vc2NfY2xrWzBdIiwKCQlbNzZdID0gImN0c19hb2Nsa19pbnQgICAgICAiLAoJCVs3
NV0gPSAiY3RzX2FvY2xreDJfaW50ICAgICIsCgkJWzc0XSA9ICIwICAgICAgICAgICAgICAgICAg
IiwKCQlbNzNdID0gImN0c19wd21fQ19jbGsgICAgICAiLAoJCVs3Ml0gPSAiY3RzX3B3bV9EX2Ns
ayAgICAgICIsCgkJWzcxXSA9ICJjdHNfcHdtX0VfY2xrICAgICAgIiwKCQlbNzBdID0gImN0c19w
d21fRl9jbGsgICAgICAiLAoJCVs2OV0gPSAiMCAgICAgICAgICAgICAgICAgICIsCgkJWzY4XSA9
ICIwICAgICAgICAgICAgICAgICAgIiwKCQlbNjddID0gIjAgICAgICAgICAgICAgICAgICAiLAoJ
CVs2Nl0gPSAiY3RzX3ZpZF9sb2NrX2NsayAgICIsCgkJWzY1XSA9ICIwICAgICAgICAgICAgICAg
ICAgIiwKCQlbNjRdID0gIjAgICAgICAgICAgICAgICAgICAiLAoJCVs2M10gPSAiMCAgICAgICAg
ICAgICAgICAgICIsCgkJWzYyXSA9ICJjdHNfaGV2Y19jbGsgICAgICAgIiwKCQlbNjFdID0gImdw
aW9fY2xrX21zciAgICAgICAiLAoJCVs2MF0gPSAiYWx0XzMya19jbGsgICAgICAgICIsCgkJWzU5
XSA9ICJjdHNfaGNvZGVjX2NsayAgICAgIiwKCQlbNThdID0gIjAgICAgICAgICAgICAgICAgICAi
LAoJCVs1N10gPSAiMAkJCQkJIiwKCQlbNTZdID0gIjAJCQkJCSIsCgkJWzU1XSA9ICJ2aWRfcGxs
X2Rpdl9jbGtfb3V0CSIsCgkJWzU0XSA9ICIwCQkJCQkiLAoJCVs1M10gPSAiU2RfZW1tY19jbGtf
QQkJIiwKCQlbNTJdID0gIlNkX2VtbWNfY2xrX0IJCSIsCgkJWzUxXSA9ICJDdHNfbmFuZF9jb3Jl
X2NsawkiLAoJCVs1MF0gPSAiTXAzX2Nsa19vdXQJCQkiLAoJCVs0OV0gPSAibXAyX2Nsa19vdXQJ
CQkiLAoJCVs0OF0gPSAibXAxX2Nsa19vdXQJCQkiLAoJCVs0N10gPSAiZGRyX2RwbGxfcHRfY2xr
CQkiLAoJCVs0Nl0gPSAiY3RzX3ZwdV9jbGsJCQkiLAoJCVs0NV0gPSAiY3RzX3B3bV9BX2NsawkJ
IiwKCQlbNDRdID0gImN0c19wd21fQl9jbGsJCSIsCgkJWzQzXSA9ICJmY2xrX2RpdjUJCQkiLAoJ
CVs0Ml0gPSAibXAwX2Nsa19vdXQJCQkiLAoJCVs0MV0gPSAiZXRoX3J4X2Nsa19vcl9jbGtfcm1p
aSIsCgkJWzQwXSA9ICJjdHNfcGNtX21jbGsJCQkiLAoJCVszOV0gPSAiY3RzX3BjbV9zY2xrCQkJ
IiwKCQlbMzhdID0gImN0c192ZGluX21lYXNfY2xrCQkJIiwKCQlbMzddID0gImN0c19jbGtfaTk1
OAkJCSIsCgkJWzM2XSA9ICJjdHNfaGRtaV90eF9waXhlbF9jbGsgIiwKCQlbMzVdID0gImN0c19t
YWxpX2NsawkJCSIsCgkJWzM0XSA9ICIwCQkJCQkiLAoJCVszM10gPSAiMAkJCQkJIiwKCQlbMzJd
ID0gImN0c192ZGVjX2NsawkJCSIsCgkJWzMxXSA9ICJNUExMX0NMS19URVNUX09VVAkiLAoJCVsz
MF0gPSAiMAkJCQkJIiwKCQlbMjldID0gIjAJCQkJCSIsCgkJWzI4XSA9ICJjdHNfc2FyX2FkY19j
bGsJCQkJCSAgICIsCgkJWzI3XSA9ICIwCQkJCQkgICAiLAoJCVsyNl0gPSAic2NfY2xrX2ludAkJ
CSAgICIsCgkJWzI1XSA9ICIwCQkJCQkgICAiLAoJCVsyNF0gPSAiMAkJCQkJICAgIiwKCQlbMjNd
ID0gIkhETUlfQ0xLX1RPRElHCQkgICAiLAoJCVsyMl0gPSAiZXRoX3BoeV9yZWZfY2xrCQkgICAi
LAoJCVsyMV0gPSAiaTJzX2Nsa19pbl9zcmMwCQkgICAiLAoJCVsyMF0gPSAicnRjX29zY19jbGtf
b3V0CQkgICAiLAoJCVsxOV0gPSAiY3RzX2hkbWl0eF9zeXNfY2xrCSAgICIsCgkJWzE4XSA9ICJz
eXNfY3B1X2Nsa19kaXYxNgkJICAgIiwKCQlbMTddID0gInN5c19wbGxfZGl2MTYJCQkJCSAgICIs
CgkJWzE2XSA9ICJjdHNfRkVDX0NMS18yCQkgICAiLAoJCVsxNV0gPSAiY3RzX0ZFQ19DTEtfMQkJ
ICAgIiwKCQlbMTRdID0gImN0c19GRUNfQ0xLXzAJCSAgICIsCgkJWzEzXSA9ICJjdHNfYW1jbGsJ
CQkgICAiLAoJCVsxMl0gPSAiQ3RzX3BkbV9jbGsJCQkgICAiLAoJCVsxMV0gPSAicmdtaWlfdHhf
Y2xrX3RvX3BoeQkgICAiLAoJCVsxMF0gPSAiY3RzX3ZkYWNfY2xrCQkJICAgIiwKCQlbOV0gPSAi
Y3RzX2VuY2xfY2xrCQkJICAiLAoJCVs4XSA9ICJjdHNfZW5jcF9jbGsJCQkgICIsCgkJWzddID0g
ImNsazgxCQkJCQkgICIsCgkJWzZdID0gImN0c19lbmNpX2NsawkJCSAgIiwKCQlbNV0gPSAiMAkJ
CQkJCSAgIiwKCQlbNF0gPSAiZ3AwX3BsbF9jbGsJCQkgICIsCgkJWzNdID0gIkE1M19yaW5nX29z
Y19jbGsJCSAgIiwKCQlbMl0gPSAiYW1fcmluZ19vc2NfY2xrX291dF9lZVsyXSIsCgkJWzFdID0g
ImFtX3Jpbmdfb3NjX2Nsa19vdXRfZWVbMV0iLAoJCVswXSA9ICJhbV9yaW5nX29zY19jbGtfb3V0
X2VlWzBdIiwK
--000000000000ace8a005701d2dca
Content-Type: text/x-patch; charset="US-ASCII"; name="gxbb-to-gxl.diff"
Content-Disposition: attachment; filename="gxbb-to-gxl.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jj62ktpu0>
X-Attachment-Id: f_jj62ktpu0

LS0tIC90bXAvZ3hiYi50eHQJMjAxOC0wNy0wMyAyMTowOToxNS43Nzk5NDQyOTggKzAyMDAKKysr
IC90bXAvZ3hsLnR4dAkyMDE4LTA3LTAzIDIxOjA5OjM1LjIyMzYwNjk4MCArMDIwMApAQCAtNDIs
NyArNDIsNyBAQAogCQlbNDFdID0gImV0aF9yeF9jbGtfb3JfY2xrX3JtaWkiLAogCQlbNDBdID0g
ImN0c19wY21fbWNsawkJCSIsCiAJCVszOV0gPSAiY3RzX3BjbV9zY2xrCQkJIiwKLQkJWzM4XSA9
ICIwCQkJCQkiLAorCQlbMzhdID0gImN0c192ZGluX21lYXNfY2xrCQkJIiwKIAkJWzM3XSA9ICJj
dHNfY2xrX2k5NTgJCQkiLAogCQlbMzZdID0gImN0c19oZG1pX3R4X3BpeGVsX2NsayAiLAogCQlb
MzVdID0gImN0c19tYWxpX2NsawkJCSIsCkBAIC01Miw3ICs1Miw3IEBACiAJCVszMV0gPSAiTVBM
TF9DTEtfVEVTVF9PVVQJIiwKIAkJWzMwXSA9ICIwCQkJCQkiLAogCQlbMjldID0gIjAJCQkJCSIs
Ci0JCVsyOF0gPSAiMAkJCQkJICAgIiwKKwkJWzI4XSA9ICJjdHNfc2FyX2FkY19jbGsJCQkJCSAg
ICIsCiAJCVsyN10gPSAiMAkJCQkJICAgIiwKIAkJWzI2XSA9ICJzY19jbGtfaW50CQkJICAgIiwK
IAkJWzI1XSA9ICIwCQkJCQkgICAiLApAQCAtNjIsOCArNjIsOCBAQAogCQlbMjFdID0gImkyc19j
bGtfaW5fc3JjMAkJICAgIiwKIAkJWzIwXSA9ICJydGNfb3NjX2Nsa19vdXQJCSAgICIsCiAJCVsx
OV0gPSAiY3RzX2hkbWl0eF9zeXNfY2xrCSAgICIsCi0JCVsxOF0gPSAiQTUzX2Nsa19kaXYxNgkJ
ICAgIiwKLQkJWzE3XSA9ICIwCQkJCQkgICAiLAorCQlbMThdID0gInN5c19jcHVfY2xrX2RpdjE2
CQkgICAiLAorCQlbMTddID0gInN5c19wbGxfZGl2MTYJCQkJCSAgICIsCiAJCVsxNl0gPSAiY3Rz
X0ZFQ19DTEtfMgkJICAgIiwKIAkJWzE1XSA9ICJjdHNfRkVDX0NMS18xCQkgICAiLAogCQlbMTRd
ID0gImN0c19GRUNfQ0xLXzAJCSAgICIsCg==
--000000000000ace8a005701d2dca
Content-Type: text/x-patch; charset="US-ASCII"; name="gxl-to-gxm.diff"
Content-Disposition: attachment; filename="gxl-to-gxm.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jj62ktq72>
X-Attachment-Id: f_jj62ktq72

LS0tIC90bXAvZ3hsLnR4dAkyMDE4LTA3LTAzIDIxOjA5OjM1LjIyMzYwNjk4MCArMDIwMAorKysg
L3RtcC9neG0udHh0CTIwMTgtMDctMDMgMjE6MDk6NDQuMjAzNzU5MDc0ICswMjAwCkBAIC0yMiw5
ICsyMiw5IEBACiAJCVs2MV0gPSAiZ3Bpb19jbGtfbXNyICAgICAgICIsCiAJCVs2MF0gPSAiYWx0
XzMya19jbGsgICAgICAgICIsCiAJCVs1OV0gPSAiY3RzX2hjb2RlY19jbGsgICAgICIsCi0JCVs1
OF0gPSAiMCAgICAgICAgICAgICAgICAgICIsCi0JCVs1N10gPSAiMAkJCQkJIiwKLQkJWzU2XSA9
ICIwCQkJCQkiLAorCQlbNThdID0gImN0c193YXZlNDIwbF9iY2xrICAgICAgICAgICAgICAgICAg
IiwKKwkJWzU3XSA9ICJjdHNfd2F2ZTQyMGxfY2NsawkiLAorCQlbNTZdID0gImN0c19jY2lfY2xr
CQkJIiwKIAkJWzU1XSA9ICJ2aWRfcGxsX2Rpdl9jbGtfb3V0CSIsCiAJCVs1NF0gPSAiMAkJCQkJ
IiwKIAkJWzUzXSA9ICJTZF9lbW1jX2Nsa19BCQkiLApAQCAtNTYsNyArNTYsNyBAQAogCQlbMjdd
ID0gIjAJCQkJCSAgICIsCiAJCVsyNl0gPSAic2NfY2xrX2ludAkJCSAgICIsCiAJCVsyNV0gPSAi
MAkJCQkJICAgIiwKLQkJWzI0XSA9ICIwCQkJCQkgICAiLAorCQlbMjRdID0gInN5c19jcHUxX2Ns
a19kaXYxNgkJCSIsCiAJCVsyM10gPSAiSERNSV9DTEtfVE9ESUcJCSAgICIsCiAJCVsyMl0gPSAi
ZXRoX3BoeV9yZWZfY2xrCQkgICAiLAogCQlbMjFdID0gImkyc19jbGtfaW5fc3JjMAkJICAgIiwK
QEAgLTY5LDcgKzY5LDcgQEAKIAkJWzE0XSA9ICJjdHNfRkVDX0NMS18wCQkgICAiLAogCQlbMTNd
ID0gImN0c19hbWNsawkJCSAgICIsCiAJCVsxMl0gPSAiQ3RzX3BkbV9jbGsJCQkgICAiLAotCQlb
MTFdID0gInJnbWlpX3R4X2Nsa190b19waHkJICAgIiwKKwkJWzExXSA9ICJtYWNfZXRoX3R4X2Ns
awkgICAiLAogCQlbMTBdID0gImN0c192ZGFjX2NsawkJCSAgICIsCiAJCVs5XSA9ICJjdHNfZW5j
bF9jbGsJCQkgICIsCiAJCVs4XSA9ICJjdHNfZW5jcF9jbGsJCQkgICIsCg==
--000000000000ace8a005701d2dca
Content-Type: text/plain; charset="US-ASCII"; name="gxm.txt"
Content-Disposition: attachment; filename="gxm.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_jj62ktqc4>
X-Attachment-Id: f_jj62ktqc4

CQlbODJdID0gIkN0c19nZTJkX2NsayAgICAgICAiLAoJCVs4MV0gPSAiQ3RzX3ZhcGJjbGsgICAg
ICAgICIsCgkJWzgwXSA9ICJSbmdfcmluZ19vc2NfY2xrWzNdIiwKCQlbNzldID0gIlJuZ19yaW5n
X29zY19jbGtbMl0iLAoJCVs3OF0gPSAiUm5nX3Jpbmdfb3NjX2Nsa1sxXSIsCgkJWzc3XSA9ICJS
bmdfcmluZ19vc2NfY2xrWzBdIiwKCQlbNzZdID0gImN0c19hb2Nsa19pbnQgICAgICAiLAoJCVs3
NV0gPSAiY3RzX2FvY2xreDJfaW50ICAgICIsCgkJWzc0XSA9ICIwICAgICAgICAgICAgICAgICAg
IiwKCQlbNzNdID0gImN0c19wd21fQ19jbGsgICAgICAiLAoJCVs3Ml0gPSAiY3RzX3B3bV9EX2Ns
ayAgICAgICIsCgkJWzcxXSA9ICJjdHNfcHdtX0VfY2xrICAgICAgIiwKCQlbNzBdID0gImN0c19w
d21fRl9jbGsgICAgICAiLAoJCVs2OV0gPSAiMCAgICAgICAgICAgICAgICAgICIsCgkJWzY4XSA9
ICIwICAgICAgICAgICAgICAgICAgIiwKCQlbNjddID0gIjAgICAgICAgICAgICAgICAgICAiLAoJ
CVs2Nl0gPSAiY3RzX3ZpZF9sb2NrX2NsayAgICIsCgkJWzY1XSA9ICIwICAgICAgICAgICAgICAg
ICAgIiwKCQlbNjRdID0gIjAgICAgICAgICAgICAgICAgICAiLAoJCVs2M10gPSAiMCAgICAgICAg
ICAgICAgICAgICIsCgkJWzYyXSA9ICJjdHNfaGV2Y19jbGsgICAgICAgIiwKCQlbNjFdID0gImdw
aW9fY2xrX21zciAgICAgICAiLAoJCVs2MF0gPSAiYWx0XzMya19jbGsgICAgICAgICIsCgkJWzU5
XSA9ICJjdHNfaGNvZGVjX2NsayAgICAgIiwKCQlbNThdID0gImN0c193YXZlNDIwbF9iY2xrICAg
ICAgICAgICAgICAgICAgIiwKCQlbNTddID0gImN0c193YXZlNDIwbF9jY2xrCSIsCgkJWzU2XSA9
ICJjdHNfY2NpX2NsawkJCSIsCgkJWzU1XSA9ICJ2aWRfcGxsX2Rpdl9jbGtfb3V0CSIsCgkJWzU0
XSA9ICIwCQkJCQkiLAoJCVs1M10gPSAiU2RfZW1tY19jbGtfQQkJIiwKCQlbNTJdID0gIlNkX2Vt
bWNfY2xrX0IJCSIsCgkJWzUxXSA9ICJDdHNfbmFuZF9jb3JlX2NsawkiLAoJCVs1MF0gPSAiTXAz
X2Nsa19vdXQJCQkiLAoJCVs0OV0gPSAibXAyX2Nsa19vdXQJCQkiLAoJCVs0OF0gPSAibXAxX2Ns
a19vdXQJCQkiLAoJCVs0N10gPSAiZGRyX2RwbGxfcHRfY2xrCQkiLAoJCVs0Nl0gPSAiY3RzX3Zw
dV9jbGsJCQkiLAoJCVs0NV0gPSAiY3RzX3B3bV9BX2NsawkJIiwKCQlbNDRdID0gImN0c19wd21f
Ql9jbGsJCSIsCgkJWzQzXSA9ICJmY2xrX2RpdjUJCQkiLAoJCVs0Ml0gPSAibXAwX2Nsa19vdXQJ
CQkiLAoJCVs0MV0gPSAiZXRoX3J4X2Nsa19vcl9jbGtfcm1paSIsCgkJWzQwXSA9ICJjdHNfcGNt
X21jbGsJCQkiLAoJCVszOV0gPSAiY3RzX3BjbV9zY2xrCQkJIiwKCQlbMzhdID0gImN0c192ZGlu
X21lYXNfY2xrCQkJIiwKCQlbMzddID0gImN0c19jbGtfaTk1OAkJCSIsCgkJWzM2XSA9ICJjdHNf
aGRtaV90eF9waXhlbF9jbGsgIiwKCQlbMzVdID0gImN0c19tYWxpX2NsawkJCSIsCgkJWzM0XSA9
ICIwCQkJCQkiLAoJCVszM10gPSAiMAkJCQkJIiwKCQlbMzJdID0gImN0c192ZGVjX2NsawkJCSIs
CgkJWzMxXSA9ICJNUExMX0NMS19URVNUX09VVAkiLAoJCVszMF0gPSAiMAkJCQkJIiwKCQlbMjld
ID0gIjAJCQkJCSIsCgkJWzI4XSA9ICJjdHNfc2FyX2FkY19jbGsJCQkJCSAgICIsCgkJWzI3XSA9
ICIwCQkJCQkgICAiLAoJCVsyNl0gPSAic2NfY2xrX2ludAkJCSAgICIsCgkJWzI1XSA9ICIwCQkJ
CQkgICAiLAoJCVsyNF0gPSAic3lzX2NwdTFfY2xrX2RpdjE2CQkJIiwKCQlbMjNdID0gIkhETUlf
Q0xLX1RPRElHCQkgICAiLAoJCVsyMl0gPSAiZXRoX3BoeV9yZWZfY2xrCQkgICAiLAoJCVsyMV0g
PSAiaTJzX2Nsa19pbl9zcmMwCQkgICAiLAoJCVsyMF0gPSAicnRjX29zY19jbGtfb3V0CQkgICAi
LAoJCVsxOV0gPSAiY3RzX2hkbWl0eF9zeXNfY2xrCSAgICIsCgkJWzE4XSA9ICJzeXNfY3B1X2Ns
a19kaXYxNgkJICAgIiwKCQlbMTddID0gInN5c19wbGxfZGl2MTYJCQkJCSAgICIsCgkJWzE2XSA9
ICJjdHNfRkVDX0NMS18yCQkgICAiLAoJCVsxNV0gPSAiY3RzX0ZFQ19DTEtfMQkJICAgIiwKCQlb
MTRdID0gImN0c19GRUNfQ0xLXzAJCSAgICIsCgkJWzEzXSA9ICJjdHNfYW1jbGsJCQkgICAiLAoJ
CVsxMl0gPSAiQ3RzX3BkbV9jbGsJCQkgICAiLAoJCVsxMV0gPSAibWFjX2V0aF90eF9jbGsJICAg
IiwKCQlbMTBdID0gImN0c192ZGFjX2NsawkJCSAgICIsCgkJWzldID0gImN0c19lbmNsX2NsawkJ
CSAgIiwKCQlbOF0gPSAiY3RzX2VuY3BfY2xrCQkJICAiLAoJCVs3XSA9ICJjbGs4MQkJCQkJICAi
LAoJCVs2XSA9ICJjdHNfZW5jaV9jbGsJCQkgICIsCgkJWzVdID0gIjAJCQkJCQkgICIsCgkJWzRd
ID0gImdwMF9wbGxfY2xrCQkJICAiLAoJCVszXSA9ICJBNTNfcmluZ19vc2NfY2xrCQkgICIsCgkJ
WzJdID0gImFtX3Jpbmdfb3NjX2Nsa19vdXRfZWVbMl0iLAoJCVsxXSA9ICJhbV9yaW5nX29zY19j
bGtfb3V0X2VlWzFdIiwKCQlbMF0gPSAiYW1fcmluZ19vc2NfY2xrX291dF9lZVswXSIsCg==
--000000000000ace8a005701d2dca
Content-Type: text/plain; charset="US-ASCII"; name="gxbb.txt"
Content-Disposition: attachment; filename="gxbb.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_jj62ktq41>
X-Attachment-Id: f_jj62ktq41

CQlbODJdID0gIkN0c19nZTJkX2NsayAgICAgICAiLAoJCVs4MV0gPSAiQ3RzX3ZhcGJjbGsgICAg
ICAgICIsCgkJWzgwXSA9ICJSbmdfcmluZ19vc2NfY2xrWzNdIiwKCQlbNzldID0gIlJuZ19yaW5n
X29zY19jbGtbMl0iLAoJCVs3OF0gPSAiUm5nX3Jpbmdfb3NjX2Nsa1sxXSIsCgkJWzc3XSA9ICJS
bmdfcmluZ19vc2NfY2xrWzBdIiwKCQlbNzZdID0gImN0c19hb2Nsa19pbnQgICAgICAiLAoJCVs3
NV0gPSAiY3RzX2FvY2xreDJfaW50ICAgICIsCgkJWzc0XSA9ICIwICAgICAgICAgICAgICAgICAg
IiwKCQlbNzNdID0gImN0c19wd21fQ19jbGsgICAgICAiLAoJCVs3Ml0gPSAiY3RzX3B3bV9EX2Ns
ayAgICAgICIsCgkJWzcxXSA9ICJjdHNfcHdtX0VfY2xrICAgICAgIiwKCQlbNzBdID0gImN0c19w
d21fRl9jbGsgICAgICAiLAoJCVs2OV0gPSAiMCAgICAgICAgICAgICAgICAgICIsCgkJWzY4XSA9
ICIwICAgICAgICAgICAgICAgICAgIiwKCQlbNjddID0gIjAgICAgICAgICAgICAgICAgICAiLAoJ
CVs2Nl0gPSAiY3RzX3ZpZF9sb2NrX2NsayAgICIsCgkJWzY1XSA9ICIwICAgICAgICAgICAgICAg
ICAgIiwKCQlbNjRdID0gIjAgICAgICAgICAgICAgICAgICAiLAoJCVs2M10gPSAiMCAgICAgICAg
ICAgICAgICAgICIsCgkJWzYyXSA9ICJjdHNfaGV2Y19jbGsgICAgICAgIiwKCQlbNjFdID0gImdw
aW9fY2xrX21zciAgICAgICAiLAoJCVs2MF0gPSAiYWx0XzMya19jbGsgICAgICAgICIsCgkJWzU5
XSA9ICJjdHNfaGNvZGVjX2NsayAgICAgIiwKCQlbNThdID0gIjAgICAgICAgICAgICAgICAgICAi
LAoJCVs1N10gPSAiMAkJCQkJIiwKCQlbNTZdID0gIjAJCQkJCSIsCgkJWzU1XSA9ICJ2aWRfcGxs
X2Rpdl9jbGtfb3V0CSIsCgkJWzU0XSA9ICIwCQkJCQkiLAoJCVs1M10gPSAiU2RfZW1tY19jbGtf
QQkJIiwKCQlbNTJdID0gIlNkX2VtbWNfY2xrX0IJCSIsCgkJWzUxXSA9ICJDdHNfbmFuZF9jb3Jl
X2NsawkiLAoJCVs1MF0gPSAiTXAzX2Nsa19vdXQJCQkiLAoJCVs0OV0gPSAibXAyX2Nsa19vdXQJ
CQkiLAoJCVs0OF0gPSAibXAxX2Nsa19vdXQJCQkiLAoJCVs0N10gPSAiZGRyX2RwbGxfcHRfY2xr
CQkiLAoJCVs0Nl0gPSAiY3RzX3ZwdV9jbGsJCQkiLAoJCVs0NV0gPSAiY3RzX3B3bV9BX2NsawkJ
IiwKCQlbNDRdID0gImN0c19wd21fQl9jbGsJCSIsCgkJWzQzXSA9ICJmY2xrX2RpdjUJCQkiLAoJ
CVs0Ml0gPSAibXAwX2Nsa19vdXQJCQkiLAoJCVs0MV0gPSAiZXRoX3J4X2Nsa19vcl9jbGtfcm1p
aSIsCgkJWzQwXSA9ICJjdHNfcGNtX21jbGsJCQkiLAoJCVszOV0gPSAiY3RzX3BjbV9zY2xrCQkJ
IiwKCQlbMzhdID0gIjAJCQkJCSIsCgkJWzM3XSA9ICJjdHNfY2xrX2k5NTgJCQkiLAoJCVszNl0g
PSAiY3RzX2hkbWlfdHhfcGl4ZWxfY2xrICIsCgkJWzM1XSA9ICJjdHNfbWFsaV9jbGsJCQkiLAoJ
CVszNF0gPSAiMAkJCQkJIiwKCQlbMzNdID0gIjAJCQkJCSIsCgkJWzMyXSA9ICJjdHNfdmRlY19j
bGsJCQkiLAoJCVszMV0gPSAiTVBMTF9DTEtfVEVTVF9PVVQJIiwKCQlbMzBdID0gIjAJCQkJCSIs
CgkJWzI5XSA9ICIwCQkJCQkiLAoJCVsyOF0gPSAiMAkJCQkJICAgIiwKCQlbMjddID0gIjAJCQkJ
CSAgICIsCgkJWzI2XSA9ICJzY19jbGtfaW50CQkJICAgIiwKCQlbMjVdID0gIjAJCQkJCSAgICIs
CgkJWzI0XSA9ICIwCQkJCQkgICAiLAoJCVsyM10gPSAiSERNSV9DTEtfVE9ESUcJCSAgICIsCgkJ
WzIyXSA9ICJldGhfcGh5X3JlZl9jbGsJCSAgICIsCgkJWzIxXSA9ICJpMnNfY2xrX2luX3NyYzAJ
CSAgICIsCgkJWzIwXSA9ICJydGNfb3NjX2Nsa19vdXQJCSAgICIsCgkJWzE5XSA9ICJjdHNfaGRt
aXR4X3N5c19jbGsJICAgIiwKCQlbMThdID0gIkE1M19jbGtfZGl2MTYJCSAgICIsCgkJWzE3XSA9
ICIwCQkJCQkgICAiLAoJCVsxNl0gPSAiY3RzX0ZFQ19DTEtfMgkJICAgIiwKCQlbMTVdID0gImN0
c19GRUNfQ0xLXzEJCSAgICIsCgkJWzE0XSA9ICJjdHNfRkVDX0NMS18wCQkgICAiLAoJCVsxM10g
PSAiY3RzX2FtY2xrCQkJICAgIiwKCQlbMTJdID0gIkN0c19wZG1fY2xrCQkJICAgIiwKCQlbMTFd
ID0gInJnbWlpX3R4X2Nsa190b19waHkJICAgIiwKCQlbMTBdID0gImN0c192ZGFjX2NsawkJCSAg
ICIsCgkJWzldID0gImN0c19lbmNsX2NsawkJCSAgIiAsCgkJWzhdID0gImN0c19lbmNwX2NsawkJ
CSAgIiAsCgkJWzddID0gImNsazgxCQkJCQkgICIgLAoJCVs2XSA9ICJjdHNfZW5jaV9jbGsJCQkg
ICIgLAoJCVs1XSA9ICIwCQkJCQkJICAiICwKCQlbNF0gPSAiZ3AwX3BsbF9jbGsJCQkgICIgLAoJ
CVszXSA9ICJBNTNfcmluZ19vc2NfY2xrCQkgICIgLAoJCVsyXSA9ICJhbV9yaW5nX29zY19jbGtf
b3V0X2VlWzJdIiAsCgkJWzFdID0gImFtX3Jpbmdfb3NjX2Nsa19vdXRfZWVbMV0iICwKCQlbMF0g
PSAiYW1fcmluZ19vc2NfY2xrX291dF9lZVswXSIgLAo=
--000000000000ace8a005701d2dca--
