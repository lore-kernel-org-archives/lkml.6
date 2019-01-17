Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31A7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F5F2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfAQLcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:32:08 -0500
Received: from foss.arm.com ([217.140.101.70]:38318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfAQLcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:32:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2771B80D;
        Thu, 17 Jan 2019 03:32:07 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F3A13F557;
        Thu, 17 Jan 2019 03:32:02 -0800 (PST)
Subject: Re: [PATCH v5 07/14] qcom: spmi-gpio: add support for hierarchical
 IRQ chip
To:     Brian Masney <masneyb@onstation.org>, linus.walleij@linaro.org,
        sboyd@kernel.org, bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190117003234.22127-1-masneyb@onstation.org>
 <20190117003234.22127-8-masneyb@onstation.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <e9234c48-9fce-1ec4-48f1-dff134559eed@arm.com>
Date:   Thu, 17 Jan 2019 11:32:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117003234.22127-8-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2019 00:32, Brian Masney wrote:
> spmi-gpio did not have any irqchip support so consumers of this in
> device tree would need to call gpio[d]_to_irq() in order to get the
> proper IRQ on the underlying PMIC. IRQ chips in device tree should
> be usable from the start without the consumer having to make an
> additional call to get the proper IRQ on the parent. This patch adds
> hierarchical IRQ chip support to the spmi-gpio code to correct this
> issue.
> 
> Driver was tested using the volume buttons (via gpio-keys) on the LG
> Nexus 5 (hammerhead) phone with the following two configurations.
> 
> volume-up {
>         interrupts-extended = <&pm8941_gpios 2 IRQ_TYPE_EDGE_BOTH>;
>         ...
> };
> 
> volume-up {
>         gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
>         ...
> };
> 
> Both configurations now show that spmi-gpio is the IRQ domain and that
> the IRQ is setup in a hierarchy.
> 
> $ grep volume_up /proc/interrupts
>  72:          6          0  spmi-gpio   1 Edge      volume_up
> 
> $ cat /sys/kernel/debug/irq/irqs/72
> handler:  handle_edge_irq
> device:   (null)
> status:   0x00000403
>             _IRQ_NOPROBE
> istate:   0x00000000
> ddepth:   0
> wdepth:   0
> dstate:   0x02400203
>             IRQ_TYPE_EDGE_RISING
>             IRQ_TYPE_EDGE_FALLING
>             IRQD_ACTIVATED
>             IRQD_IRQ_STARTED
> node:     0
> affinity: 0-3
> effectiv:
> domain:  :soc:spmi@fc4cf000:pm8941@0:gpios@c000
>  hwirq:   0x1
>  chip:    spmi-gpio
>   flags:   0x4
>              IRQCHIP_MASK_ON_SUSPEND
>  parent:
>     domain:  :soc:spmi@fc4cf000
>      hwirq:   0xc100057
>      chip:    pmic_arb
>       flags:   0x4
>                  IRQCHIP_MASK_ON_SUSPEND
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
> Changes since v4:
> - None
> 
> Changes since v3:
> - None
> 
> Changes since v2:
> - Use PMIC_GPIO_PHYSICAL_OFFSET instead of the 1 constant
> - Use gpiochip_irq_domain_{activate,deactivate}
> - Changed 'fwspec->param[0] + 0xc0 - 1' to 'hwirq + c0' in call to
>   irq_domain_alloc_irqs_parent
> 
> Changes since v1:
> - Use two cells for interrupts instead of four.
> - Pin numbers in interrupts-extended are now one based instead of zero
>   based so that they match the GPIO pin number.
> - Drop unnecessary parenthesis in pmic_gpio_domain_translate
> - Add missing of_node_put()
> - Remove irq field from pmic_gpio_pad struct that is no longer
>   necessary.
> 
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 111 +++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index b6fa2c7dbb26..3604c3cdbbc0 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> @@ -136,7 +137,6 @@ enum pmic_gpio_func_index {
>  /**
>   * struct pmic_gpio_pad - keep current GPIO settings
>   * @base: Address base in SPMI device.
> - * @irq: IRQ number which this GPIO generate.
>   * @is_enabled: Set to false when GPIO should be put in high Z state.
>   * @out_value: Cached pin output value
>   * @have_buffer: Set to true if GPIO output could be configured in push-pull,
> @@ -156,7 +156,6 @@ enum pmic_gpio_func_index {
>   */
>  struct pmic_gpio_pad {
>  	u16		base;
> -	int		irq;
>  	bool		is_enabled;
>  	bool		out_value;
>  	bool		have_buffer;
> @@ -179,6 +178,8 @@ struct pmic_gpio_state {
>  	struct regmap	*map;
>  	struct pinctrl_dev *ctrl;
>  	struct gpio_chip chip;
> +	struct fwnode_handle *fwnode;
> +	struct irq_domain *domain;
>  };
>  
>  static const struct pinconf_generic_params pmic_gpio_bindings[] = {
> @@ -761,11 +762,14 @@ static int pmic_gpio_of_xlate(struct gpio_chip *chip,
>  static int pmic_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
>  {
>  	struct pmic_gpio_state *state = gpiochip_get_data(chip);
> -	struct pmic_gpio_pad *pad;
> +	struct irq_fwspec fwspec;
>  
> -	pad = state->ctrl->desc->pins[pin].drv_data;
> +	fwspec.fwnode = state->fwnode;
> +	fwspec.param_count = 2;
> +	fwspec.param[0] = pin + PMIC_GPIO_PHYSICAL_OFFSET;
> +	fwspec.param[1] = IRQ_TYPE_NONE;

In my experience, IRQ_TYPE_NONE is rarely a good thing, unless you
expect the trigger information to be found by some other mean. I guess
that's one of the reasons why everything falls back to level in the SPMI
driver...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
