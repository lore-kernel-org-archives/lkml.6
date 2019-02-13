Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C34C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7865A222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfBMFCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 00:02:13 -0500
Received: from mx.socionext.com ([202.248.49.38]:17425 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfBMFCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 00:02:12 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 13 Feb 2019 14:02:09 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B79486117D;
        Wed, 13 Feb 2019 14:02:09 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 13 Feb 2019 14:02:09 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 2D85640389;
        Wed, 13 Feb 2019 14:02:09 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 1776A120459;
        Wed, 13 Feb 2019 14:02:09 +0900 (JST)
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v2 12/15] pinctrl: milbeaut: Add Milbeaut M10V pinctrl
To:     Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Brian Masney <masneyb@onstation.org>
References: <1549628897-32345-1-git-send-email-sugaya.taichi@socionext.com>
 <CACRpkdZCpyJDL+zy-NftXJNah2u6t75cVCDmh_L0+ZyXv7J2LA@mail.gmail.com>
Message-ID: <de0177d8-65a4-0111-9060-606f25868bd1@socionext.com>
Date:   Wed, 13 Feb 2019 14:02:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZCpyJDL+zy-NftXJNah2u6t75cVCDmh_L0+ZyXv7J2LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your comments.

On 2019/02/08 22:26, Linus Walleij wrote:
> Hi Sugaya,
> 
> thank you for the patch!
> 
> Since Masahiro has previously added the Uniphier pin control driver
> I would like him to provide a review of this patch, if possible. I also
> want to make sure that the hardware is different enough from the
> existing Uniphier pin control so that it really needs a new
> driver, else I suppose it should be refactored to be part of
> the pinctrl/uniphier drivers (we can of course rename it
> pinctrl/socionext if only naming is an issue).

As Masahiro mentioned Millbeaut is totally different from UniPhier. So I 
would like to put files individually.

> 
> On Fri, Feb 8, 2019 at 1:27 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
> 
>> Add Milbeaut M10V pinctrl.
>> The M10V has the pins that can be used GPIOs or take multiple other
>> functions.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> 
> This file seems to be mostly authored by Jassi Brar 
That's right.
as he is
> listed as author in the top of the source code.
> 
> Please at least add Signed-off-by: Jassi Brar <jassi.brar@linaro.org>
> above your signed-off-by to reflect the delivery path.
> 
> Also usually author is set to indicate the person who wrote
> the majority of the code so consider:
> git commit --amend --author="Jassi Brar <jassi.brar@linaro.org>"
> if Jassi wrote the majority of the code.
> Since I will ask you to change a bunch of stuff in the driver
> I don't know who the majority author will be in the end.
> 
> When you send out the patches this will reflect in a
> From: ... line at the top of the patch.
> 
> I'm not overly sensitive about credits but this seems like
> a simple thing to fix.
> 
I will decide the author in discussion with him. If Jassi will be,
I remember to add a "From:..." line.

>> +config PINCTRL_MILBEAUT
>> +       bool
>> +       select PINMUX
>> +       select PINCONF
>> +       select GENERIC_PINCONF
>> +       select OF_GPIO
>> +       select REGMAP_MMIO
>> +       select GPIOLIB_IRQCHIP
> 
> Nice reuse of the frameworks! But this driver doesn't
> really use GPIOLIB_IRQCHIP, at least not as it looks now.
> 

I got it, drop this line.

>> +#include <linux/gpio.h>
> 
> Please use only <linux/gpio/driver.h> on new code.
> It should be just as fine.
> 
OK, use it instead.


>> +#include <linux/pinctrl/machine.h>
> 
> This include should not be needed.
> 

I got it, drop this line.

>> +struct pin_irq_map {
>> +       int pin; /* offset of pin in the managed range */
>> +       int irq; /* virq of the pin as fpint */
>> +       int type;
>> +       char irqname[8];
>> +};
> 
> If pins are mapped 1-to-1 to IRQs from another irqchip,
> we are dealing with a hierarchical interrupt controller.
> But I guess I learn more as I read the code.
>
Yes, some pins of GPIO are available to be used as external interrupt.


>> +static void _set_mux(struct m10v_pinctrl *pctl, unsigned int pin, bool gpio)
> 
> I don't like __underscore_prefix on functions since they
> are semantically ambiguous. Try to find the perfect name that
> reflects what the function is really doing. m10v_pmx_commit_mux_setting()
> if nothing else.
> 

OK, consider perfect name.

> I do not understand the "gpio" argument for this function so please
> explain it:
> 
>> +       if (gpio)
>> +               val &= ~BIT(offset);
>> +       else
>> +               val |= BIT(offset);
> 
> So this bit is set if "gpio" is true, and that comes from here:
> 
>> +static int m10v_pmx_set_mux(struct pinctrl_dev *pctldev,
>> +                            unsigned int function,
>> +                            unsigned int group)
>> +{
>> +       struct m10v_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
>> +       u32 pin = pctl->gpins[group][0]; /* each group has exactly 1 pin */
>> +
>> +       _set_mux(pctl, pin, !function);
> 
> So if no special function is passed to the .set_mux() callback,
> we assume that the pin is used for GPIO. Write this in a comment
> if I understand it correctly, so it gets easy to read the code.

That's right!!
OK, add a comment about "gpio".

> 
>> +static int _set_direction(struct m10v_pinctrl *pctl,
>> +                       unsigned int pin, bool input)
> 
> Same issue with __underscore.
> m10v_set_direction_commit()?
> 
I got it too.
Try to consider nice name.

>> +static int
>> +m10v_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
>> +                       struct pinctrl_gpio_range *range,
>> +                       unsigned int pin, bool input)
>> +{
>> +       struct m10v_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
>> +
>> +       return _set_direction(pctl, pin, input);
>> +}
>> +
>> +static int
>> +m10v_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
>> +                           struct pinctrl_gpio_range *range,
>> +                           unsigned int pin)
>> +{
>> +       struct m10v_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
>> +
>> +       _set_mux(pctl, pin, true);
>> +       return 0;
>> +}
> 
> This is a good solution.
> 

Thank you.

>> +static const struct pinmux_ops m10v_pmx_ops = {
>> +       .get_functions_count    = m10v_pmx_get_funcs_cnt,
>> +       .get_function_name      = m10v_pmx_get_func_name,
>> +       .get_function_groups    = m10v_pmx_get_func_groups,
>> +       .set_mux                = m10v_pmx_set_mux,
>> +       .gpio_set_direction     = m10v_pmx_gpio_set_direction,
>> +       .gpio_request_enable    = m10v_pmx_gpio_request_enable,
>> +};
> 
> If GPIO and other functions cannot be used at the same time,
> then consider setting .strict = true, in struct pinmux_ops.
> (Else skip it, maybe add a comment that GPIO lines can be
> used orthogonal to functions.)
> 

They cannot be used the same time, so add a line ".strict = true,"

>> +static int m10v_gpio_get(struct gpio_chip *gc, unsigned int group)
>> +{
>> +       struct m10v_pinctrl *pctl =
>> +               container_of(gc, struct m10v_pinctrl, gc);
> 
> Please set the gpio chip data to struct m10v_pinctrl * and use:
> 
> struct m10v_pinctrl *pctl = gpiochip_get_data(gc);
> 
> in all these functions.
>

I got it.

>> +static void (*gpio_set)(struct gpio_chip *, unsigned int, int);
> 
> Why is this forward-declaration here in the middle of the code?
> It seems unnecessary, at least it warrants a comment.
> 

This is a remnant of code refining and no longer needed.
I will drop this line and use m10v_gpio_set() directly.

>> +static int m10v_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
>> +{
>> +       struct m10v_pinctrl *pctl =
>> +               container_of(gc, struct m10v_pinctrl, gc);
>> +
>> +       return irq_linear_revmap(pctl->irqdom, offset);
>> +}
> 
> Something is fishy here because when you use GPIOLIB_IRQCHIP
> .to_irq() should be handled by the gpiolib core.
> 
> However if you rewrite this driver to use hierarchical irqdomain,
> you still have to provide a .to_irq() function.
> 

I see. Try to use hierarchical irqdomain.

>> +static struct lock_class_key gpio_lock_class;
>> +static struct lock_class_key gpio_request_class;
> 
> These forward declarations should not be here, they should
> be coming from <linux/gpio/driver.h>
> 

OK.
Therefore I think GPIOLIB_IRQCHIP is needed.

>> +static int pin_to_extint(struct m10v_pinctrl *pctl, int pin)
>> +{
>> +       int extint;
>> +
>> +       for (extint = 0; extint < pctl->extints; extint++)
>> +               if (pctl->fpint[extint].pin == pin)
>> +                       break;
>> +
>> +       if (extint == pctl->extints)
>> +               return -1;
>> +
>> +       return extint;
>> +}
> 
> This looks like it should be a hierarchical irqchip.
> 
> I am working on generic mappings of parent<->child IRQ
> offsets for gpiolib but don't know when it will be there.
> 

OK, study and try to use irqchip.

>> +static void update_trigger(struct m10v_pinctrl *pctl, int extint)
> 
> Normally this is .set_type() on the irqchip.
> 

OK.

>> +{
>> +       int type = pctl->fpint[extint].type;
> 
> But since you are not using hierarchical irqchip, this stuff
> appears here instead, which becomes a kind of workaround.
> So use hierarchical irqchip instead.
> 

I see.
I try to drop this line.

>> +static irqreturn_t m10v_gpio_irq_handler(int irq, void *data)
>> +{
>> +       struct m10v_pinctrl *pctl = data;
>> +       int i, pin;
>> +       u32 val;
>> +
>> +       for (i = 0; i < pctl->extints; i++)
>> +               if (pctl->fpint[i].irq == irq)
>> +                       break;
>> +       if (i == pctl->extints) {
>> +               pr_err("%s:%d IRQ(%d)!\n", __func__, __LINE__, irq);
>> +               return IRQ_NONE;
>> +       }
>> +
>> +       if (!pctl->exiu)
>> +               return IRQ_NONE;
>> +
>> +       val = readl_relaxed(pctl->exiu + EIREQSTA);
>> +       if (!(val & BIT(i))) {
>> +               pr_err("%s:%d i=%d EIREQSTA=0x%x IRQ(%d)!\n",
>> +                               __func__, __LINE__, i, val, irq);
>> +               return IRQ_NONE;
>> +       }
>> +
>> +       pin = pctl->fpint[i].pin;
>> +       generic_handle_irq(irq_linear_revmap(pctl->irqdom, pin));
>> +
>> +       return IRQ_HANDLED;
>> +}
> 
> This becomes a complex workaround for not having hierarchical
> irqchip.
> 

OKay!

>> +static int m10v_pinctrl_probe(struct platform_device *pdev)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct pinctrl_dev *pctl_dev;
>> +       struct pin_irq_map fpint[32];
>> +       struct m10v_pinctrl *pctl;
>> +       struct pinctrl_desc *pd;
>> +       struct gpio_chip *gc;
>> +       struct resource *res;
>> +       int idx, i, ret, extints, tpins;
>> +
>> +       extints = of_irq_count(np);
> 
> So this means that you have all the IRQs from the parent interrupt
> controller defined in the device tree.
> 

Yes.

> This has been done in some drivers but they are bad example.
> 
> Instead use hierarchical irqchip, and do the mappings from parent
> to child offset directly in the driver.
> 
> Hierarchial irqdomains are not very old, so I am sorry if the kernel
> contains a number of bad examples.
> 
> Examples:
> drivers/irqchip/irq-meson-gpio.c
> drivers/pinctrl/stm32/pinctrl-stm32.c
> https://marc.info/?l=linux-arm-kernel&m=154923023907623&w=2
> https://marc.info/?l=linux-arm-kernel&m=154923038707686&w=2
> 
> You can also look at Brian Masney's series where he's converting
> some of Qualcomms drivers to use hierarchical interrupts.
> 

Thank you for suggestion.
I will refer to it and try to converting.

>> +       pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl) +
>> +                               sizeof(struct pin_irq_map) * extints,
>> +                               GFP_KERNEL);
> 
> This should use struct_size() these days, but this will not be needed
> when you switch to hierarchical irqdomain.
> 

I got it.

>> +       for (idx = 0, i = 0; i < pctl->extints; i++) {
>> +               int j = 0, irq = platform_get_irq(pdev, i);
> 
> And this code goes away as well. Instead the mapping from
> child to parent irq offset happens in statically assigned data.
> If that varies between implementations of this pin controller,
> you should use unique compatible strings to discern them.
> 

I see.

>> +       gc->base = -1;
>> +       gc->ngpio = tpins;
>> +       gc->label = dev_name(&pdev->dev);
>> +       gc->owner = THIS_MODULE;
>> +       gc->of_node = np;
>> +       gc->direction_input = m10v_gpio_direction_input;
>> +       gc->direction_output = m10v_gpio_direction_output;
>> +       gc->get = m10v_gpio_get;
>> +       gc->set = gpio_set;
>> +       gc->to_irq = m10v_gpio_to_irq;
>> +       gc->request = gpiochip_generic_request;
>> +       gc->free = gpiochip_generic_free;
>> +       ret = gpiochip_add(gc);
> 
> Please use devm_gpiochip_add_data() and pass the pin controller struct
> as data.
>

OK.

Thanks.
Sugaya Taichi

> Yours,
> Linus Walleij
> 

