Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033494AbeCARaE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:30:04 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37547 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033466AbeCAR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:29:55 -0500
X-Google-Smtp-Source: AG47ELswjYKmPzm/O76Rmk9aGPHjlH8kSESy7TsIUZwPhnI2GgQvmsPxkcAXWNaHl/Z6V/pkpPsoAw==
Date: Thu, 1 Mar 2018 22:59:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        =?utf-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com
Subject: Re: [PATCH v3 04/10] pinctrl: actions: Add Actions S900 pinctrl
 driver
Message-ID: <20180301172943.cuypepvflte2cynr@linaro.org>
References: <20180228181432.26847-1-manivannan.sadhasivam@linaro.org>
 <20180228181432.26847-5-manivannan.sadhasivam@linaro.org>
 <CAHp75VchzV9SZb4g0fVP9aoKb7actsehXm8c4wsvVGASgkOc+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VchzV9SZb4g0fVP9aoKb7actsehXm8c4wsvVGASgkOc+w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Feb 28, 2018 at 08:36:53PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 28, 2018 at 8:14 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Add pinctrl driver for Actions Semi S900 SoC. The driver supports
> > pinctrl, pinmux and pinconf functionalities through a range of registers
> > common to both gpio driver and pinctrl driver.
> >
> > Pinmux functionality is available only for the pin groups while the
> > pinconf functionality is available for both pin groups and individual
> > pins.
> 
> > +static int owl_set_mux(struct pinctrl_dev *pctrldev,
> > +                               unsigned int function,
> > +                               unsigned int group)
> > +{
> 
> > +       mfpval = readl(pctrl->base + g->mfpctl_reg);
> > +       mfpval &= ~mask;
> > +       mfpval |= val;
> > +       writel(mfpval, pctrl->base + g->mfpctl_reg);
> 
> This is called owl_update_bits().
>

Okay. Will add a helper.
 
> > +static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
> > +                               unsigned int pin,
> > +                               unsigned long *configs,
> > +                               unsigned int num_configs)
> > +{
> 
> > +       int ret = 0;
> 
> Redundant assignment?
>

Ack.
 
> > +               mask = (1 << width) - 1;
> > +               mask = mask << bit;
> > +               tmp = readl(pctrl->base + reg);
> > +               tmp &= ~mask;
> > +               tmp |= arg << bit;
> > +               writel(tmp, pctrl->base + reg);
> 
> This is called owl_update_bits().
>

Ack.

> > +}
> 
> > +static int owl_group_pinconf_val2arg(const struct owl_pingroup *g,
> > +                               unsigned int param,
> > +                               u32 *arg)
> > +{
> 
> > +       case PIN_CONFIG_SLEW_RATE:
> > +               if (*arg)
> > +                       *arg = 1;
> > +               else
> > +                       *arg = 0;
> 
> Doesn't slew rate allow a non-binary value?
>

As stated in the binding doc, valid values for the slew rate parameter are:

0 - Slow
1 - Fast
 
> > +       return 0;
> > +}
> > +
> > +static int owl_group_config_get(struct pinctrl_dev *pctrldev,
> > +                               unsigned int group,
> > +                               unsigned long *config)
> > +{
> > +       int ret = 0;
> 
> Redundant assignment.
> 

Ack.

> > +}
> 
> > +static int owl_group_config_set(struct pinctrl_dev *pctrldev,
> > +                               unsigned int group,
> > +                               unsigned long *configs,
> > +                               unsigned int num_configs)
> > +{
> > +       int ret = 0;
> 
> Redundant assignment, see below.
>

Ack. Will return 0 directly.
 
> > +               mask = (1 << width) - 1;
> > +               mask = mask << bit;
> > +               tmp = readl(pctrl->base + reg);
> > +               tmp &= ~mask;
> > +               tmp |= arg << bit;
> > +               writel(tmp, pctrl->base + reg);
> 
> This is called owl_update_bits().
>

Ack.
 
> > +       return ret;
> 
> return 0; ?
> 

Okay.

> > +}
> 
> > +int owl_pinctrl_probe(struct platform_device *pdev,
> > +                               struct owl_pinctrl_soc_data *soc_data)
> > +{
> 
> > +       clk_prepare_enable(pctrl->clk);
> 
> This can fail.
>

Okay. Will add a check.
 
> > +}
> 
> > +static const struct of_device_id s900_pinctrl_of_match[] = {
> > +       { .compatible = "actions,s900-pinctrl", },
> 
> > +       { },
> 
> No comma needed.
>

Okay.

Thanks for the review.

Regards,
Mani
 
> > +};
> 
> -- 
> With Best Regards,
> Andy Shevchenko
