Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC8BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46B9223F8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CvU4WRMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46B9223F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbeGDNq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:46:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34303 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753662AbeGDNoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:44:21 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so10844762ois.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7Fg2hPH7d/oKPxiN0uashIXx8ZB7FlD4geXC4ZZDN8=;
        b=CvU4WRMDvPqGuCv50WxNPr31sqmIvfN5yRM7p6lCDVwEXzIHQqCHf+DAUN/bExeARq
         9kqj0vdz+/kytGH9pkhSl35jZ4gFvUQImrXoxV0lO6GrPOlBD4/4qGjSjaWB5Vvt2ODD
         6mUfthtk6eyBruIp3vGIsaMd0nmF/3moR4JCZgx7Rb1MC65N4F25LG4sqacHdNnSB7o7
         AstCOVM4wHROf63XR43N7LozonQfwwrIvKozK/Lucpp4T8nTHaZKpl7CDknzKVNT0kNI
         SDUBTILPRSDVxRfR7okpArbWndAardvtZPuKbUwsVehQ+FMexwN+QbxMlxoxiHuk/Qjx
         weOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7Fg2hPH7d/oKPxiN0uashIXx8ZB7FlD4geXC4ZZDN8=;
        b=A3b3hHa6fMbk2yEhXc5KDVqfCIEruqR9lwGI9yeKQcQKtjdbS+gFNSjUGqB0sUha2B
         ZT7hMEQsntB7Xa7X0ukcyLGV5sSvJ8ZZw+D0bTB3yp49UgwkmXBIUOGAvra9t9ttwB9r
         2Po0Cq3qH435Fkzl6HLNXKFw64ideF2xIweethmbMrZG0xg8aDV+UV0A/vJ8rZ+bF/l+
         2ronGbYPwOE+WOnvQV0SiUi3LdfLmJq2RktQcAK4yPRymv8IBp/WOWxQEZqTPZZzy42g
         07M26fT0qFrBCFU+pdbMpVt/nh6fiS2PdK7UX4O8ss6DBGhZhN84beEqzp3w2IO2WrCR
         BRWw==
X-Gm-Message-State: APt69E0jjA4vWdS10tjcJ4iWztprP0IoenN3017WaA/bUjXOK3wXtSFB
        qKm3L57NspvvWTKFXG+1tr79B367Ac2tvsnZj0v07UcP
X-Google-Smtp-Source: AAOMgpfBztJuQnAGhk6usMxCNFeQpDFeBZIyAngVoBC9kqr8aAh0P/6X1aJ5ShuijuNxT2AbEqe61r+g2NyLY1u6J0I=
X-Received: by 2002:aca:b60a:: with SMTP id g10-v6mr2389998oif.263.1530711860553;
 Wed, 04 Jul 2018 06:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
 <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
 <CAFBinCDBEbVSEzhM2WOhxNX1DZLiSrkeo7GWdxGzBpOUH3PKQw@mail.gmail.com> <7d83a0a4-5cde-7e4f-78a8-372ae8cb03d0@baylibre.com>
In-Reply-To: <7d83a0a4-5cde-7e4f-78a8-372ae8cb03d0@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 4 Jul 2018 15:44:09 +0200
Message-ID: <CAFBinCA5B87TkfOtQd==PxDK74kJ+XWMgY-36QK2TT9p-vAEUA@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: amlogic: Add Meson GX Clock Measure driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Jul 4, 2018 at 10:41 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Martin,
>
> On 03/07/2018 21:18, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Tue, Jul 3, 2018 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> >> clock paths frequencies.
> >> The precision is in the order of the MHz.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  drivers/soc/amlogic/Kconfig                |   8 ++
> >>  drivers/soc/amlogic/Makefile               |   1 +
> >>  drivers/soc/amlogic/meson-gx-clk-measure.c | 224 +++++++++++++++++++++++++++++
> >>  3 files changed, 233 insertions(+)
> >>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
> >>
> >> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> >> index b04f6e4..4a3217d 100644
> >> --- a/drivers/soc/amlogic/Kconfig
> >> +++ b/drivers/soc/amlogic/Kconfig
> >> @@ -1,5 +1,13 @@
> >>  menu "Amlogic SoC drivers"
> >>
> >> +config MESON_GX_CLK_MEASURE
> >> +       bool "Amlogic Meson GX SoC Clock Measure driver"
> >> +       depends on ARCH_MESON || COMPILE_TEST
> >> +       default ARCH_MESON
> >> +       help
> >> +         Say yes to support of Measuring a set of internal SoC clocks
> >> +         from the debugfs interface.
> >> +
> >>  config MESON_GX_SOCINFO
> >>         bool "Amlogic Meson GX SoC Information driver"
> >>         depends on ARCH_MESON || COMPILE_TEST
> >> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> >> index 8fa3218..a0ad966 100644
> >> --- a/drivers/soc/amlogic/Makefile
> >> +++ b/drivers/soc/amlogic/Makefile
> >> @@ -1,3 +1,4 @@
> >> +obj-$(CONFIG_MESON_GX_CLK_MEASURE) += meson-gx-clk-measure.o
> >>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
> >>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
> >>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> >> diff --git a/drivers/soc/amlogic/meson-gx-clk-measure.c b/drivers/soc/amlogic/meson-gx-clk-measure.c
> >> new file mode 100644
> >> index 0000000..434d9f3
> >> --- /dev/null
> >> +++ b/drivers/soc/amlogic/meson-gx-clk-measure.c
>
> [...]
>
> >> +       CLK_MSR_ID(57, "wave420l_c"),
> >> +       CLK_MSR_ID(58, "wave420l_b"),
> > AFAIK the Chips&Media WAVE420L video codec is only available on GXM (S912)
> > I assume reading this on GXBB or GXL simply reads 0?
>
> Yes
>
> >
> >> +       CLK_MSR_ID(59, "hcodec"),
> >> +       CLK_MSR_ID(60, "alt_32k"),
> >> +       CLK_MSR_ID(61, "gpio_msr"),
> >> +       CLK_MSR_ID(62, "hevc"),
> >> +       CLK_MSR_ID(66, "vid_lock"),
> >> +       CLK_MSR_ID(70, "pwm_f"),
> >> +       CLK_MSR_ID(71, "pwm_e"),
> >> +       CLK_MSR_ID(72, "pwm_d"),
> >> +       CLK_MSR_ID(73, "pwm_C"),
> > should this be pwm_c (instead of pwm_C)?
> >
> >> +       CLK_MSR_ID(75, "aoclkx2_int"),
> >> +       CLK_MSR_ID(76, "aoclk_int"),
> >> +       CLK_MSR_ID(77, "rng_ring_osc_0"),
> >> +       CLK_MSR_ID(78, "rng_ring_osc_1"),
> >> +       CLK_MSR_ID(79, "rng_ring_osc_2"),
> >> +       CLK_MSR_ID(80, "rng_ring_osc_3"),
> >> +       CLK_MSR_ID(81, "vapb"),
> >> +       CLK_MSR_ID(82, "ge2d"),
> >> +};
> > I did a quick check whether the clock IDs are really the same for all GX SoCs:
> > apart from clocks missing on older SoCs (see for example the WAVE420L
> > clocks above) there were only minor renames but no conflicts!
>
> I did the same work ! I will add this detail to the commit log.
> Thanks for checking ;-)
:)

> >
> >> +
> >> +static int meson_gx_measure_id(struct meson_gx_msr *priv, unsigned int id)
> >> +{
> >> +       unsigned int val;
> >> +       int ret;
> >> +
> >> +       regmap_write(priv->regmap, MSR_CLK_REG0, 0);
> >> +
> >> +       /* Set measurement gate to 50uS */
> >> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_DIV,
> >> +                          FIELD_PREP(MSR_CLK_DIV, DIV_50US));
> >> +
> >> +       /* Set ID */
> >> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
> >> +                          FIELD_PREP(MSR_CLK_SRC, id));
> >> +
> >> +       /* Enable & Start */
> >> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0,
> >> +                          MSR_RUN | MSR_ENABLE,
> >> +                          MSR_RUN | MSR_ENABLE);
> >> +
> >> +       ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
> >> +                                      val, !(val & MSR_BUSY), 10, 1000);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* Disable */
> >> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
> >> +
> >> +       /* Get the value in MHz*64 */
> >> +       regmap_read(priv->regmap, MSR_CLK_REG2, &val);
> >> +
> >> +       return (((val + 31) & MSR_VAL_MASK) / 64) * 1000000;
> >> +}
> >> +
> >> +static int clk_msr_show(struct seq_file *s, void *data)
> >> +{
> >> +       struct meson_gx_msr_id *clk_msr_id = s->private;
> >> +       int val;
> >> +
> >> +       val = meson_gx_measure_id(clk_msr_id->priv, clk_msr_id->id);
> >> +       if (val < 0)
> >> +               return val;
> >> +
> >> +       seq_printf(s, "%d\n", val);
>
> With jerome, we managed to have a much higher precision by cycling over the divider
> and checking when the counter overflows. And I will print the precision in the clock debugfs
> entry.
great that you could even improve the precision!

> >> +
> >> +       return 0;
> >> +}
> >> +DEFINE_SHOW_ATTRIBUTE(clk_msr);
> > have you considered modelling this as clock driver instead?
>
> Yes, but it can wait.
> Actually this clk-msr can be feed to GEN_CLK and be outputted to a pad,
> but all this is only for debug, so we can stick to debugfs for now.
>
> Question, should I separate the clocks in a subdirectory and add a summary file like
> for the clk debugfs ?
>
>
> /sys/kernel/debug/meson-clk-msr
> ------------------|--- summary
> ------------------|--- clks
> -----------------------|--- ring_osc_out_ee_0
> ...
> -----------------------|--- ge2d
>
> ?
this is exactly why I was curious if you considered implementing this
as clock driver instead
based on your description above each measured clock will have the
following properties:
- id (passed to the clkmsr IP block)
- name (human readable name)
- clock rate
- accuracy

doesn't CCF provide everything except "id"? you'll even get the summary

can you explain how you would use the clkmsr output?
here's how I would use it:
- assume I'm debugging something broken
- I suspect that it may be due to the clock setup
- grep "suspicious-clock" /sys/kernel/debug/clk/clk_summary
- compare the grep output with /sys/kernel/debug/meson-clk-msr/suspicious-clock

if it was a CCF driver I could simply do:
grep "suspicious-clock" /sys/kernel/debug/clk/clk_summary
-> this would return "suspicious-clock" (which is what the kernel can
configure) and "clkmsr_suspicious-clock" (which is what clkmsr reads)

> >
> >> +
> >> +static const struct regmap_config clk_msr_regmap_config = {
> >> +       .reg_bits = 32,
> >> +       .val_bits = 32,
> >> +       .reg_stride = 4,
> >> +       .max_register = MSR_CLK_REG2,
> >> +};
> >> +
> >> +static int meson_gx_msr_probe(struct platform_device *pdev)
> >> +{
> >> +       struct meson_gx_msr *priv;
> >> +       struct resource *res;
> >> +       struct dentry *root;
> >> +       void __iomem *base;
> >> +       int i;
> >> +
> >> +       priv = devm_kzalloc(&pdev->dev, sizeof(struct meson_gx_msr),
> >> +                           GFP_KERNEL);
> >> +       if (!priv)
> >> +               return -ENOMEM;
> >> +
> >> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +       base = devm_ioremap_resource(&pdev->dev, res);
> >> +       if (IS_ERR(base)) {
> >> +               dev_err(&pdev->dev, "io resource mapping failed\n");
> >> +               return PTR_ERR(base);
> >> +       }
> >> +
> >> +       priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> >> +                                             &clk_msr_regmap_config);
> >> +       if (IS_ERR(priv->regmap))
> >> +               return PTR_ERR(priv->regmap);
> >> +
> >> +       root = debugfs_create_dir("meson-clk-msr", NULL);
> >> +
> >> +       for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
> >> +               if (!clk_msr[i].name)
> >> +                       continue;
> >> +
> >> +               clk_msr[i].priv = priv;
> >> +
> >> +               debugfs_create_file(clk_msr[i].name, 0444, root,
> >> +                                   &clk_msr[i], &clk_msr_fops);
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static const struct of_device_id meson_gx_msr_match_table[] = {
> >> +       { .compatible = "amlogic,meson-gx-clk-measure" },
> > maybe pass the meson_gx_msr_id table here because it seems easy to add
> > support for AXG and Meson8/Meson8b/Meson8m2 later on
>
> Yes, I will rename the driver to be generic and pass the table as match data.
great, thank you!


Regards
Martin
