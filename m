Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96999C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552AA2145D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 19:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeL2TZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 14:25:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:50170 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728242AbeL2TZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 14:25:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEEECAC6E;
        Sat, 29 Dec 2018 19:25:40 +0000 (UTC)
Subject: Re: [PATCH v3 lora-next 5/5] net: lora: sx125x sx1301: allow radio to
 register as a clk provider
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     starnight@g.ncu.edu.tw, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <a89c7974-672f-e5d0-8022-d2c2f9ffeac0@suse.de>
Date:   Sat, 29 Dec 2018 20:25:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

+ linux-lpwan, linux-clk, devicetree

Am 12.10.18 um 18:26 schrieb Ben Whitten:
> From: Ben Whitten <ben.whitten@gmail.com>
> 
> The 32M is run from the radio, before we just enabled it based on
> the radio number but now we can use the clk framework to request the
> clk is started when we need it.
> 
> The 32M clock produced from the radio is really a gated version of
> tcxo which is a fixed clock provided by hardware, and isn't captured
> in this patch.
> 
> The sx1301 brings the clock up prior to calibration once the radios
> have probed themselves.
> 
> A sample dts showing the clk link:
> 	sx1301: sx1301@0 {

Nit: Node names should not duplicate model from compatible or label.
I've been using "lora" for both concentrator and radios.

> 		...
>                 clocks = <&radio1 0>;

Since you use #clock-cells of zero below, you are specifying two clocks
here, surely unintentional.

>                 clock-names = "clk32m";
> 
>                 radio-spi {
>                         radio0: radio-a@0 {

-a/-b in node names duplicates the unit address. I've been using "lora",
but we might also go for just "radio" or "transceiver"?

>                                 ...
>                         };
> 
>                         radio1: radio-b@1 {

Should add "..." here, too, for clarity.

>                                 #clock-cells = <0>;
>                                 clock-output-names = "clk32m";

Personally I'd reorder those two lines to have #foo-cells last.

But more importantly, in my testing this is lacking, e.g.,
clocks = <&clk32m>;
and an appropriate fixed-clock node in the root node. See inline.

>                         };
>                 };
> 	};

This issue is making me think we should start properly documenting our
dt-bindings in a preceding patch, even if just for my linux-lora staging
tree. Be it in the old .txt format or Rob's newly proposed YAML.

The more cooks are working on SX130x, the better we need to explain what
changes people need to make to their DT to keep things working - if I
stumble as original author, then new testers are even more likely to!

> 
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
>  drivers/net/lora/sx125x.c | 112 ++++++++++++++++++++++++++++++++++++++++++----
>  drivers/net/lora/sx1301.c |  13 ++++++
>  drivers/net/lora/sx1301.h |   2 +
>  3 files changed, 119 insertions(+), 8 deletions(-)

In general I'd appreciate if you would prepare, e.g., the clock output
in a preceding sx125x-only patch. Exposing (and consuming) clocks in the
radio driver should be independent of consuming them in the concentrator
driver. That'll make things easier to review for us and also helps avoid
the unusual "sx125x sx1301" in the subject, here and elsewhere.

> 
> diff --git a/drivers/net/lora/sx125x.c b/drivers/net/lora/sx125x.c
> index 36b61b1..b7ca782 100644
> --- a/drivers/net/lora/sx125x.c
> +++ b/drivers/net/lora/sx125x.c
> @@ -9,6 +9,8 @@
>   * Copyright (c) 2013 Semtech-Cycleo
>   */
>  
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -42,10 +44,16 @@ static const struct reg_field sx125x_regmap_fields[] = {
>  };
>  
>  struct sx125x_priv {
> +	struct clk		*clkout;
> +	struct clk_hw		clkout_hw;

The 0-day bots have reported this to break on sparc64, as you've seen.
We'll need to squash a Kconfig or .c based solution here.

> +
> +	struct device		*dev;
>  	struct regmap		*regmap;
>  	struct regmap_field     *regmap_fields[ARRAY_SIZE(sx125x_regmap_fields)];
>  };
>  
> +#define to_clkout(_hw) container_of(_hw, struct sx125x_priv, clkout_hw)
> +
>  static struct regmap_config __maybe_unused sx125x_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -64,6 +72,96 @@ static int sx125x_field_write(struct sx125x_priv *priv,
>  	return regmap_field_write(priv->regmap_fields[field_id], val);
>  }
>  
> +static int sx125x_field_read(struct sx125x_priv *priv,
> +		enum sx125x_fields field_id, unsigned int *val)
> +{
> +	return regmap_field_read(priv->regmap_fields[field_id], val);
> +}

Nit: Given how trivial this is, we might make it static inline?

> +
> +static int sx125x_clkout_enable(struct clk_hw *hw)
> +{
> +	struct sx125x_priv *priv = to_clkout(hw);
> +
> +	dev_info(priv->dev, "enabling clkout\n");
> +	return sx125x_field_write(priv, F_CLK_OUT, 1);
> +}
> +
> +static void sx125x_clkout_disable(struct clk_hw *hw)
> +{
> +	struct sx125x_priv *priv = to_clkout(hw);
> +	int ret;
> +
> +	dev_info(priv->dev, "disabling clkout\n");
> +	ret = sx125x_field_write(priv, F_CLK_OUT, 0);
> +	if (ret)
> +		dev_err(priv->dev, "error disabling clkout\n");
> +}
> +
> +static int sx125x_clkout_is_enabled(struct clk_hw *hw)
> +{
> +	struct sx125x_priv *priv = to_clkout(hw);
> +	unsigned int enabled;
> +	int ret;
> +
> +	ret = sx125x_field_read(priv, F_CLK_OUT, &enabled);
> +	if (ret) {
> +		dev_err(priv->dev, "error reading clk enable\n");
> +		return 0;
> +	}
> +	return enabled;
> +}
> +
> +static const struct clk_ops sx125x_clkout_ops = {
> +	.enable = sx125x_clkout_enable,
> +	.disable = sx125x_clkout_disable,
> +	.is_enabled = sx125x_clkout_is_enabled,
> +};
> +
> +static int sx125x_register_clock_provider(struct sx125x_priv *priv)
> +{
> +	struct device *dev = priv->dev;
> +	struct clk_init_data init;
> +	const char *parent;
> +	int ret;
> +
> +	/* Disable CLKOUT */
> +	ret = sx125x_field_write(priv, F_CLK_OUT, 0);
> +	if (ret) {
> +		dev_err(dev, "unable to disable clkout\n");
> +		return ret;
> +	}
> +
> +	/* Register clock provider if expected in DTB */
> +	if (!of_find_property(dev->of_node, "#clock-cells", NULL))
> +		return 0;
> +
> +	dev_info(dev, "registering clkout\n");
> +
> +	parent = of_clk_get_parent_name(dev->of_node, 0);
> +	if (!parent) {
> +		dev_err(dev, "Unable to find parent clk\n");
> +		return -ENODEV;

I got stuck here testing:

[233875.731268] sx1301 spi0.0: SX1301 module probed
[233876.520801] sx1301 spi1.0: SX1301 module probed
[233876.543460] sx125x_con spi0.0-b: SX125x version: 21
[233876.550866] sx125x_con spi0.0-b: registering clkout
[233876.555852] sx125x_con spi0.0-b: Unable to find parent clk
[233876.561491] sx125x_con spi0.0-b: failed to register clkout provider: -19
[233876.569914] sx125x_con spi0.0-a: SX125x version: 21
[233876.582915] sx125x_con spi0.0-a: SX125x module probed
[233876.589100] sx125x_con spi1.0-b: SX125x version: 21
[233876.595981] sx125x_con spi1.0-b: registering clkout
[233876.600986] sx125x_con spi1.0-b: Unable to find parent clk
[233876.606557] sx125x_con spi1.0-b: failed to register clkout provider: -19
[233876.614559] sx125x_con spi1.0-a: SX125x version: 21
[233876.625047] sx125x_con spi1.0-a: SX125x module probed

Your DT example above does not use any parent clock for the radios. It
seems adding any clocks = <> reference helps resolve that error.

I don't spot any code dealing with enabling that parent either. With a
fixed-clock we appear to get around that, except for reference counting:

# cat /sys/kernel/debug/clk/clk_summary
[...]
 rak831-clk32m                        0        0        0    32000000
       0     0  50000
    rak831_clk32m                     0        0        0    32000000
       0     0  50000
 rg186-clk32m                         0        0        0    32000000
       0     0  50000
    rg186_clk32m                      0        0        0    32000000
       0     0  50000

But it might just as well be a gpio-gate-clock or some PMIC providing
it, needing prepare+enable ops.

> +	}
> +
> +	init.ops = &sx125x_clkout_ops;
> +	init.flags = CLK_IS_BASIC;

I don't think that's really true.

> +	init.parent_names = &parent;
> +	init.num_parents = 1;
> +	priv->clkout_hw.init = &init;
> +
> +	of_property_read_string_index(dev->of_node, "clock-output-names", 0,
> +			&init.name);

Error handling for this was in your style cleanup patch. I'd prefer to
squash that hunk here.

However, clock-output-names is documented as an optional property, so we
shouldn't rely on it here, please.

> +
> +	priv->clkout = devm_clk_register(dev, &priv->clkout_hw);
> +	if (IS_ERR(priv->clkout)) {
> +		dev_err(dev, "failed to register clkout\n");

Would be nice to output the error code, but then again the caller does.

> +		return PTR_ERR(priv->clkout);
> +	}
> +	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get,
> +			&priv->clkout_hw);


Don't we need to unregister the provider on remove? Using the devm_
variant would seem to handle that for us.

> +	return ret;
> +}

I wonder whether we may want to split (some of) this off into a _clk.c
for Makefile-based optional compilation? We could then provide a static
inline version of sx125x_register_clock_provider() as alternative and
have this file not care.

> +
>  static int __maybe_unused sx125x_regmap_probe(struct device *dev, struct regmap *regmap, unsigned int radio)
>  {
>  	struct sx125x_priv *priv;
> @@ -76,6 +174,7 @@ static int __maybe_unused sx125x_regmap_probe(struct device *dev, struct regmap
>  		return -ENOMEM;
>  
>  	dev_set_drvdata(dev, priv);
> +	priv->dev = dev;
>  	priv->regmap = regmap;
>  	for (i = 0; i < ARRAY_SIZE(sx125x_regmap_fields); i++) {
>  		const struct reg_field *reg_fields = sx125x_regmap_fields;
> @@ -99,16 +198,13 @@ static int __maybe_unused sx125x_regmap_probe(struct device *dev, struct regmap
>  		dev_info(dev, "SX125x version: %02x\n", val);
>  	}
>  
> -	if (radio == 1) { /* HACK */
> -		ret = sx125x_field_write(priv, F_CLK_OUT, 1);
> -		if (ret) {
> -			dev_err(dev, "enabling clock output failed\n");
> -			return ret;
> -		}
> -
> -		dev_info(dev, "enabling clock output\n");
> +	ret = sx125x_register_clock_provider(priv);
> +	if (ret) {
> +		dev_err(dev, "failed to register clkout provider: %d\n", ret);
> +		return ret;
>  	}
>  
> +	/* TODO Only needs setting on radio on the TX path */

Slightly unrelated, but thanks for documenting. :)

>  	ret = sx125x_field_write(priv, F_TX_DAC_CLK_SEL, 1);
>  	if (ret) {
>  		dev_err(dev, "clock select failed\n");
> diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
> index 339f8d9..23cbddc3 100644
> --- a/drivers/net/lora/sx1301.c
> +++ b/drivers/net/lora/sx1301.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/firmware.h>
>  #include <linux/lora.h>
> @@ -378,6 +379,18 @@ static int sx130x_loradev_open(struct net_device *netdev)
>  		return -ENXIO;
>  	}
>  
> +	priv->clk32m = devm_clk_get(priv->dev, "clk32m");
> +	if (IS_ERR(priv->clk32m)) {
> +		dev_err(priv->dev, "failed to get clk32m\n");
> +		return PTR_ERR(priv->clk32m);
> +	}
> +
> +	ret = clk_prepare_enable(priv->clk32m);

Does this cope with an absent/NULL clock?

> +	if (ret) {
> +		dev_err(priv->dev, "failed to enable clk32m: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = sx1301_field_write(priv, F_GLOBAL_EN, 1);
>  	if (ret) {
>  		dev_err(priv->dev, "enable global clocks failed\n");
> diff --git a/drivers/net/lora/sx1301.h b/drivers/net/lora/sx1301.h
> index 0bbd948..a1a2e38 100644
> --- a/drivers/net/lora/sx1301.h
> +++ b/drivers/net/lora/sx1301.h
> @@ -9,6 +9,7 @@
>  #ifndef _SX1301_
>  #define _SX1301_
>  
> +#include <linux/clk.h>
>  #include <linux/regmap.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/lora/dev.h>
> @@ -108,6 +109,7 @@ static const struct reg_field sx1301_regmap_fields[] = {
>  struct sx1301_priv {
>  	struct lora_dev_priv lora;
>  	struct device		*dev;
> +	struct clk		*clk32m;
>  	struct gpio_desc *rst_gpio;
>  	struct regmap		*regmap;
>  	struct regmap_field     *regmap_fields[ARRAY_SIZE(sx1301_regmap_fields)];

Thanks again for contributing this cleanup series!
(already staged in linux-lora.git)

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
